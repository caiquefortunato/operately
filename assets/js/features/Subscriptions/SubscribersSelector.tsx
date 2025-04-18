import React, { useState, useMemo } from "react";

import { Subscriber } from "@/models/notifications";
import { RadioGroup } from "@/components/Form";
import { SubscriptionsState, Options } from "@/features/Subscriptions";
import { SubscriptionOption } from "./selector/SubscriptionOption";
import { SubscribersSelectorModal } from "./selector/SubscribersSelectorModal";
import { SubscribersSelectorProvider } from "./SubscribersSelectorContext";

interface Props {
  state: SubscriptionsState;
  projectName?: string;
  spaceName?: string;
  resourceHubName?: string;
}

export function SubscribersSelector({ state, projectName, spaceName, resourceHubName }: Props) {
  const [showSelector, setShowSelector] = useState(false);
  const { subscribers, selectedSubscribers, subscriptionType, setSubscriptionType, alwaysNotify } = state;

  const allSubscribersLabel = useMemo(
    () => buildAllSubscribersLabel(subscribers, { projectName, spaceName, resourceHubName }),
    [],
  );

  // If all notifiable people must be notified,
  // the widget is not displayed.
  if (alwaysNotify.length >= subscribers.length) return <></>;

  return (
    <SubscribersSelectorProvider state={state}>
      <div>
        <p className="font-bold mb-1.5">When I post this, notify:</p>

        <RadioGroup name="subscriptions-options" onChange={setSubscriptionType} defaultValue={subscriptionType}>
          <SubscriptionOption
            label={allSubscribersLabel}
            value={Options.ALL}
            subscribers={subscribers}
            testId="subscribe-all"
          />

          <SubscriptionOption
            label="Only the people I select"
            value={Options.SELECTED}
            subscribers={selectedSubscribers}
            onClick={() => setShowSelector(true)}
            testId="subscribe-specific-people"
          />

          <SubscriptionOption label="No one" value={Options.NONE} subscribers={[]} testId="subscribe-no-one" />
        </RadioGroup>

        <SubscribersSelectorModal showSelector={showSelector} setShowSelector={setShowSelector} />
      </div>
    </SubscribersSelectorProvider>
  );
}

interface BuildAllPeopleLabelOpts {
  projectName?: string;
  spaceName?: string;
  resourceHubName?: string;
}

function buildAllSubscribersLabel(subscribers: Subscriber[], opts: BuildAllPeopleLabelOpts) {
  const part1 = subscribers.length > 1 ? `All ${subscribers.length} people` : "The 1 person";
  let part2 = "";

  if (opts.projectName) {
    part2 = ` contributing to ${opts.projectName}`;
  } else if (opts.spaceName) {
    part2 = ` who are members of the ${opts.spaceName} space`;
  } else if (opts.resourceHubName) {
    part2 = ` who have access to ${opts.resourceHubName}`;
  }

  return part1 + part2;
}
