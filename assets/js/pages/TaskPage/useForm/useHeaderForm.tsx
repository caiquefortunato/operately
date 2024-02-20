import * as React from "react";
import * as Tasks from "@/models/tasks";
import * as People from "@/models/people";

import { Fields } from "./fields";

export interface HeaderFormState {
  editing: boolean;
  startEditing: () => void;

  name: string;
  setName: (name: string) => void;

  assignedPeople: People.Person[];
  setAssignedPeople: React.Dispatch<React.SetStateAction<People.Person[]>>;

  submit: () => Promise<boolean>;
  cancel: () => void;
  errors: string[];
}

export function useHeaderForm(fields: Fields): HeaderFormState {
  const [editing, setEditing] = React.useState(false);

  const [name, setName] = React.useState(fields.name);
  const [assignedPeople, setAssignedPeople] = React.useState(fields.assignedPeople! || []);

  const [error, setError] = React.useState<string[]>([]);

  const [update] = Tasks.useUpdateTaskMutation({
    onCompleted: () => setEditing(false),
  });

  const submit = React.useCallback(async (): Promise<boolean> => {
    if (name.trim() === "") {
      setError(["name"]);
      return false;
    }

    const idList = assignedPeople!.map((person) => person.id);

    console.log("idList", idList);
    console.log("name", name);

    await update({
      variables: {
        input: {
          taskId: fields.taskID,
          name,
          assignedIds: idList,
        },
      },
    });

    fields.setName(name);
    fields.setAssignedPeople(assignedPeople);

    return true;
  }, [name, assignedPeople]);

  return {
    name,
    assignedPeople,

    setName,
    setAssignedPeople,

    editing,
    startEditing: () => setEditing(true),

    submit,
    cancel: () => setEditing(false),
    errors: error,
  };
}
