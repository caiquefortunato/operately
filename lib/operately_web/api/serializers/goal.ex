defimpl OperatelyWeb.Api.Serializable, for: Operately.Goals.Goal do
  def serialize(goal, level: :essential) do
    %{
      id: OperatelyWeb.Paths.goal_id(goal),
      name: goal.name,
      permissions: OperatelyWeb.Api.Serializer.serialize(goal.permissions, level: :full),
      targets: OperatelyWeb.Api.Serializer.serialize(goal.targets),
      space: serialize_space(goal.group),
      champion: OperatelyWeb.Api.Serializer.serialize(goal.champion),
      reviewer: OperatelyWeb.Api.Serializer.serialize(goal.reviewer),
      success: goal.success == "yes"
    }
  end

  def serialize(goal, level: :full) do
    serialize(goal, level: :essential) |> Map.merge(%{
      description: goal.description && Jason.encode!(goal.description),
      inserted_at: OperatelyWeb.Api.Serializer.serialize(goal.inserted_at),
      updated_at: OperatelyWeb.Api.Serializer.serialize(goal.updated_at),
      archived_at: OperatelyWeb.Api.Serializer.serialize(goal.deleted_at),
      closed_by: OperatelyWeb.Api.Serializer.serialize(goal.closed_by),
      closed_at: OperatelyWeb.Api.Serializer.serialize(goal.closed_at),

      is_archived: goal.deleted_at != nil,
      is_closed: goal.closed_at != nil,
      is_outdated: Operately.Goals.outdated?(goal),

      parent_goal_id: goal.parent_goal && OperatelyWeb.Paths.goal_id(goal.parent_goal),
      parent_goal: OperatelyWeb.Api.Serializer.serialize(goal.parent_goal),
      progress_percentage: Operately.Goals.progress_percentage(goal),

      timeframe: OperatelyWeb.Api.Serializer.serialize(goal.timeframe),
      projects: OperatelyWeb.Api.Serializer.serialize(goal.projects, level: :full),
      last_check_in: OperatelyWeb.Api.Serializer.serialize(goal.last_check_in, level: :full),
      access_levels: OperatelyWeb.Api.Serializer.serialize(goal.access_levels, level: :full),
      potential_subscribers: OperatelyWeb.Api.Serializer.serialize(goal.potential_subscribers),
      notifications: OperatelyWeb.Api.Serializer.serialize(goal.notifications),
    })
  end

  defp serialize_space(space) do
    if Ecto.assoc_loaded?(space) and Ecto.assoc_loaded?(space.members) and Ecto.assoc_loaded?(space.company) do
      OperatelyWeb.Api.Serializer.serialize(space, level: :full)
    else
      OperatelyWeb.Api.Serializer.serialize(space)
    end
  end
end
