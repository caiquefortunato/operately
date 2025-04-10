import * as React from "react";

import * as Pages from "@/components/Pages";
import * as Icons from "@tabler/icons-react";
import * as PageOptions from "@/components/PaperContainer/PageOptions";
import { assertPresent } from "@/utils/assertions";
import { Paths } from "@/routes/paths";

import { useLoadedData } from "./loader";

interface Props {
  toggleShowDeleteGoal: () => void;
}
export function Options({ toggleShowDeleteGoal }: Props) {
  const { goal } = useLoadedData();

  assertPresent(goal.permissions, "permissions must be present in goal");

  const viewMode = Pages.useIsViewMode();
  const setPageMode = Pages.useSetPageMode();
  const isEditVisible = goal.permissions.canEdit && viewMode;

  return (
    <PageOptions.Root testId="goal-options">
      {isEditVisible && (
        <PageOptions.Action
          icon={Icons.IconEdit}
          title="Edit"
          onClick={() => setPageMode("edit")}
          testId="edit-goal-definition"
          keepOutsideOnBigScreen
        />
      )}

      {goal.permissions.canClose && !goal.isClosed && (
        <PageOptions.Link
          icon={Icons.IconCircleCheck}
          title="Close Goal"
          to={Paths.goalClosePath(goal.id!)}
          testId="close-goal"
        />
      )}

      {goal.permissions.canClose && goal.isClosed && (
        <PageOptions.Link
          icon={Icons.IconRotateDot}
          title="Reopen Goal"
          to={Paths.goalReopenPath(goal.id!)}
          testId="reopen-goal"
        />
      )}

      {goal.permissions.canDelete && (
        <PageOptions.Action
          icon={Icons.IconTrash}
          title="Delete Goal"
          onClick={toggleShowDeleteGoal}
          testId="delete-goal"
        />
      )}
    </PageOptions.Root>
  );
}
