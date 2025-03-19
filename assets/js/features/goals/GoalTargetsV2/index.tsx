import React from "react";

import { IconChevronDown } from "@tabler/icons-react";
import classNames from "classnames";
import { useFieldValue } from "@/components/Forms/FormContext";
import { useValidation } from "@/components/Forms/validations/hook";
import { validatePresence } from "@/components/Forms/validations/presence";

import { getReadonlyFlags } from "./utils";
import { TargetNameSection } from "./TargetNameSection";
import { TargetDetails } from "./TargetDetails";
import { TargetValue } from "./TargetValue";
import { EditTargetCard } from "./EditTargetCard";
import { Target } from "./types";

export { Target };

interface StylesOptions {
  hideBorder?: boolean;
  dotsBetween?: boolean;
}

interface Props extends StylesOptions {
  field: string;
  label?: string;
  readonly?: boolean;
  editValue?: boolean;
  editDefinition?: boolean;
}

export function GoalTargetsField(props: Props) {
  const [targets] = useFieldValue<Target[]>(props.field);

  return (
    <div>
      {targets.map((target, index) => (
        <TargetCard
          key={target.id}
          index={index}
          target={target}
          readonly={props.readonly}
          hideBorder={props.hideBorder}
          dotsBetween={props.dotsBetween}
          editValue={props.editValue ?? true}
          editDefinition={props.editDefinition}
        />
      ))}
    </div>
  );
}

interface TargetCardProps extends StylesOptions {
  index: number;
  target: Target;
  readonly?: boolean;
  editValue?: boolean;
  editDefinition?: boolean;
}

function TargetCard(props: TargetCardProps) {
  const [open, setOpen] = React.useState(false);
  const { index, target, readonly, hideBorder, dotsBetween, editValue, editDefinition } = props;

  const { readonlyDefinition, readonlyValue } = getReadonlyFlags({ readonly, editDefinition, editValue });
  useValidation(`targets[${index}].name`, validatePresence(true));

  const containerClass = classNames("max-w-full py-2 px-px", {
    "border-t last:border-b border-stroke-base": !hideBorder,
  });

  const handleToggle = () => {
    if (!readonly) return;
    setOpen(!open);
  };

  const handleChevronToggle = () => {
    if (readonly) return;
    setOpen(!open);
  };

  if (!readonlyDefinition) return <EditTargetCard target={target} index={index} />;

  return (
    <div className={containerClass}>
      <div onClick={handleToggle} className="grid grid-cols-[1fr_auto_14px] gap-2 items-center cursor-pointer">
        <TargetNameSection target={target} dotsBetween={dotsBetween} />
        <TargetValue readonly={readonlyValue} index={index} target={target} />
        <IconChevronDown onClick={handleChevronToggle} size={14} />
      </div>
      {open && <TargetDetails target={target} />}
    </div>
  );
}
