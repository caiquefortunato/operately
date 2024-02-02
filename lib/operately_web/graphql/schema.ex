defmodule OperatelyWeb.Graphql.Schema do
  #
  # This file is generated by: mix operately.gen.elixir.graphql.schema
  # Do not edit this file directly.
  #

  use Absinthe.Schema

  import_types Absinthe.Type.Custom

  # Types
  import_types OperatelyWeb.Graphql.Types.Activities
  import_types OperatelyWeb.Graphql.Types.ActivityContent
  import_types OperatelyWeb.Graphql.Types.ActivityContentDiscussionCommentSubmitted
  import_types OperatelyWeb.Graphql.Types.ActivityContentDiscussionPosting
  import_types OperatelyWeb.Graphql.Types.ActivityContentGoalArchived
  import_types OperatelyWeb.Graphql.Types.ActivityContentGoalCheckIn
  import_types OperatelyWeb.Graphql.Types.ActivityContentGoalCheckInAcknowledgement
  import_types OperatelyWeb.Graphql.Types.ActivityContentGoalCheckInEdit
  import_types OperatelyWeb.Graphql.Types.ActivityContentGoalCreated
  import_types OperatelyWeb.Graphql.Types.ActivityContentGoalEditing
  import_types OperatelyWeb.Graphql.Types.ActivityContentGroupEdited
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectArchived
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectClosed
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectContributorAddition
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectCreated
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectDiscussionSubmitted
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectGoalConnection
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectGoalDisconnection
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectMilestoneCommented
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectMoved
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectRenamed
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectReviewAcknowledged
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectReviewCommented
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectReviewRequestSubmitted
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectReviewSubmitted
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectStatusUpdateAcknowledged
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectStatusUpdateCommented
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectStatusUpdateEdit
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectStatusUpdateSubmitted
  import_types OperatelyWeb.Graphql.Types.ActivityContentProjectTimelineEdited
  import_types OperatelyWeb.Graphql.Types.Assignments
  import_types OperatelyWeb.Graphql.Types.Blobs
  import_types OperatelyWeb.Graphql.Types.Comments
  import_types OperatelyWeb.Graphql.Types.Companies
  import_types OperatelyWeb.Graphql.Types.Dashboards
  import_types OperatelyWeb.Graphql.Types.Discussions
  import_types OperatelyWeb.Graphql.Types.GoalPermissions
  import_types OperatelyWeb.Graphql.Types.Goals
  import_types OperatelyWeb.Graphql.Types.Groups
  import_types OperatelyWeb.Graphql.Types.KeyResults
  import_types OperatelyWeb.Graphql.Types.Kpis
  import_types OperatelyWeb.Graphql.Types.Milestones
  import_types OperatelyWeb.Graphql.Types.Notifications
  import_types OperatelyWeb.Graphql.Types.Objectives
  import_types OperatelyWeb.Graphql.Types.Person
  import_types OperatelyWeb.Graphql.Types.ProjectHealths
  import_types OperatelyWeb.Graphql.Types.ProjectPermissions
  import_types OperatelyWeb.Graphql.Types.ProjectReviewRequests
  import_types OperatelyWeb.Graphql.Types.Projects
  import_types OperatelyWeb.Graphql.Types.Reactions
  import_types OperatelyWeb.Graphql.Types.Tenets
  import_types OperatelyWeb.Graphql.Types.UpdateContentGoalCheckIn
  import_types OperatelyWeb.Graphql.Types.UpdateContentMessage
  import_types OperatelyWeb.Graphql.Types.UpdateContentProjectContributorAdded
  import_types OperatelyWeb.Graphql.Types.UpdateContentProjectContributorRemoved
  import_types OperatelyWeb.Graphql.Types.UpdateContentProjectCreated
  import_types OperatelyWeb.Graphql.Types.UpdateContentProjectDiscussion
  import_types OperatelyWeb.Graphql.Types.UpdateContentProjectEndTimeChanged
  import_types OperatelyWeb.Graphql.Types.UpdateContentProjectMilestoneCompleted
  import_types OperatelyWeb.Graphql.Types.UpdateContentProjectMilestoneCreated
  import_types OperatelyWeb.Graphql.Types.UpdateContentProjectMilestoneDeadlineChanged
  import_types OperatelyWeb.Graphql.Types.UpdateContentProjectMilestoneDeleted
  import_types OperatelyWeb.Graphql.Types.UpdateContentProjectStartTimeChanged
  import_types OperatelyWeb.Graphql.Types.UpdateContentReview
  import_types OperatelyWeb.Graphql.Types.UpdateContentStatusUpdate
  import_types OperatelyWeb.Graphql.Types.Updates

  # Queries
  import_types OperatelyWeb.Graphql.Queries.Activities
  import_types OperatelyWeb.Graphql.Queries.Assignments
  import_types OperatelyWeb.Graphql.Queries.Companies
  import_types OperatelyWeb.Graphql.Queries.Discussions
  import_types OperatelyWeb.Graphql.Queries.Goals
  import_types OperatelyWeb.Graphql.Queries.Groups
  import_types OperatelyWeb.Graphql.Queries.KeyResources
  import_types OperatelyWeb.Graphql.Queries.KeyResults
  import_types OperatelyWeb.Graphql.Queries.Kpis
  import_types OperatelyWeb.Graphql.Queries.Milestones
  import_types OperatelyWeb.Graphql.Queries.Notifications
  import_types OperatelyWeb.Graphql.Queries.Objectives
  import_types OperatelyWeb.Graphql.Queries.People
  import_types OperatelyWeb.Graphql.Queries.ProjectReviewRequests
  import_types OperatelyWeb.Graphql.Queries.Projects
  import_types OperatelyWeb.Graphql.Queries.Tenets
  import_types OperatelyWeb.Graphql.Queries.Updates

  # Mutations
  import_types OperatelyWeb.Graphql.Mutations.Blobs
  import_types OperatelyWeb.Graphql.Mutations.Companies
  import_types OperatelyWeb.Graphql.Mutations.Dashboards
  import_types OperatelyWeb.Graphql.Mutations.Discussions
  import_types OperatelyWeb.Graphql.Mutations.Goals
  import_types OperatelyWeb.Graphql.Mutations.Groups
  import_types OperatelyWeb.Graphql.Mutations.KeyResults
  import_types OperatelyWeb.Graphql.Mutations.Kpis
  import_types OperatelyWeb.Graphql.Mutations.Milestones
  import_types OperatelyWeb.Graphql.Mutations.Notifications
  import_types OperatelyWeb.Graphql.Mutations.Objectives
  import_types OperatelyWeb.Graphql.Mutations.People
  import_types OperatelyWeb.Graphql.Mutations.ProjectReviewRequests
  import_types OperatelyWeb.Graphql.Mutations.Projects
  import_types OperatelyWeb.Graphql.Mutations.Tenets
  import_types OperatelyWeb.Graphql.Mutations.Updates

  # Subscriptions
  import_types OperatelyWeb.Graphql.Subscriptions.Notifications

  query do
    import_fields :activity_queries
    import_fields :assignment_queries
    import_fields :company_queries
    import_fields :discussion_queries
    import_fields :goal_queries
    import_fields :group_queries
    import_fields :key_resource_queries
    import_fields :key_result_queries
    import_fields :kpi_queries
    import_fields :milestone_queries
    import_fields :notification_queries
    import_fields :objective_queries
    import_fields :person_queries
    import_fields :project_review_request_queries
    import_fields :project_queries
    import_fields :tenet_queries
    import_fields :update_queries
  end

  mutation do
    import_fields :blob_mutations
    import_fields :company_mutations
    import_fields :dashboard_mutations
    import_fields :discussion_mutations
    import_fields :goal_mutations
    import_fields :group_mutations
    import_fields :key_result_mutations
    import_fields :kpi_mutations
    import_fields :milestone_mutations
    import_fields :notification_mutations
    import_fields :objective_mutations
    import_fields :person_mutations
    import_fields :project_review_request_mutations
    import_fields :project_mutations
    import_fields :tenet_mutations
    import_fields :update_mutations
  end

  subscription do
    import_fields :notification_subscriptions
  end
end
