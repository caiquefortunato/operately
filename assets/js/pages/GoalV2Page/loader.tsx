import * as Pages from "@/components/Pages";
import * as Goals from "@/models/goals";

interface LoaderResult {
  goal: Goals.Goal;
}

export async function loader({ params }): Promise<LoaderResult> {
  return {
    goal: await Goals.getGoal({
      id: params.id,
      includeTargets: true,
      includePermissions: true,
      includeUnreadNotifications: true,
    }).then((data) => data.goal!),
  };
}

export function useLoadedData(): LoaderResult {
  return Pages.useLoadedData() as LoaderResult;
}
