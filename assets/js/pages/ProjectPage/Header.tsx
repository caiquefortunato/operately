import * as React from "react";
import * as Icons from "@tabler/icons-react";
import * as Projects from "@/models/projects";
import * as Goals from "@/models/goals";

import { DimmedLink, DivLink } from "@/components/Link";
import { Paths } from "@/routes/paths";
import { PrivacyIndicator } from "@/features/Permissions";

export function Header({ project }: { project: Projects.Project }) {
  return (
    <div className="flex-1 mb-2">
      <ParentGoal project={project} />

      <div className="flex items-center text-content-accent truncate mr-12">
        <ProjectIcon />
        <ProjectName project={project} />
        <PrivacyIndicator project={project} />
      </div>
    </div>
  );
}

function ProjectName({ project }) {
  return <div className="font-bold text-2xl text-content-accent truncate ml-3 mr-2">{project.name}</div>;
}

function ProjectIcon() {
  return (
    <div className="bg-indigo-500/10 p-1.5 rounded-lg">
      <Icons.IconHexagons size={24} className="text-indigo-500" />
    </div>
  );
}

function ParentGoal({ project }: { project: Projects.Project }) {
  return (
    <div className="flex items-center">
      <div className="border-t-2 border-l-2 border-stroke-base rounded-tl w-7 h-2.5 ml-4 mb-1 mt-2.5 mr-1" />

      {project.goal ? <ParentGoalLinked goal={project.goal} /> : <ParentGoalNotLinked project={project} />}
    </div>
  );
}

function ParentGoalNotLinked({ project }: { project: Projects.Project }) {
  const path = Paths.editProjectGoalPath(project.id!);

  return (
    <div className="text-sm text-content-dimmed mx-1 font-medium">
      <DimmedLink to={path}>Link this project to a goal</DimmedLink> for context and purpose
    </div>
  );
}

function ParentGoalLinked({ goal }: { goal: Goals.Goal }) {
  return (
    <>
      <Icons.IconTarget size={14} className="text-red-500" />
      <DivLink
        to={Paths.goalPath(goal.id!)}
        className="text-sm text-content-dimmed mx-1 hover:underline font-medium"
        testId="project-goal-link"
      >
        {goal.name}
      </DivLink>
    </>
  );
}
