import React from "react";

import { ProjectCheckIn } from "@/models/projectCheckIns";
import { Status } from "./Status";
import { Person } from "@/models/people";

interface StatusSectionProps {
  checkIn: ProjectCheckIn;
  reviewer?: Person | null;
}

export function StatusSection({ checkIn, reviewer }: StatusSectionProps) {
  return (
    <div className="my-8">
      <div className="text-lg font-bold mx-auto">1. How's the project going?</div>

      <div className="flex flex-col gap-2 mt-2 border border-stroke-base rounded-lg p-2">
        <Status status={checkIn.status!} reviewer={reviewer} />
      </div>
    </div>
  );
}
