defmodule OperatelyWeb.Api.Mutations.PostGoalProgressUpdate do
  use TurboConnect.Mutation
  use OperatelyWeb.Api.Helpers

  alias Operately.Goals
  alias Operately.Goals.Permissions
  alias Operately.Operations.GoalCheckIn

  inputs do
    field :status, :string
    field :content, :string
    field :goal_id, :string
    field :timeframe, :timeframe
    field :new_target_values, :string
    field :send_notifications_to_everyone, :boolean
    field :subscriber_ids, list_of(:string)
  end

  outputs do
    field :update, :goal_progress_update
  end

  def call(conn, inputs) do
    Action.new()
    |> run(:me, fn -> find_me(conn) end)
    |> run(:goal_id, fn -> decode_id(inputs.goal_id) end)
    |> run(:goal, fn ctx -> Goals.get_goal_with_access_level(ctx.goal_id, ctx.me.id) end)
    |> run(:attrs, fn ctx -> parse_inputs(ctx, inputs) end)
    |> run(:check_permissions, fn ctx -> Permissions.check(ctx.goal.requester_access_level, :can_check_in) end)
    |> run(:operation, fn ctx -> GoalCheckIn.run(ctx.me, ctx.goal, ctx.attrs) end)
    |> run(:serialized, fn ctx -> {:ok, %{update: Serializer.serialize(ctx.operation, level: :full)}} end)
    |> respond()
  end

  defp respond(result) do
    case result do
      {:ok, ctx} -> {:ok, ctx.serialized}
      {:error, :attrs, _} -> {:error, :bad_request}
      {:error, :goal, _} -> {:error, :not_found}
      {:error, :check_permissions, _} -> {:error, :forbidden}
      {:error, :operation, _} -> {:error, :internal_server_error}
      _ -> {:error, :internal_server_error}
    end
  end

  defp parse_inputs(ctx, inputs) do
    {:ok, subscriber_ids} = decode_id(inputs[:subscriber_ids], :allow_nil)

    {:ok, %{
      target_values: Jason.decode!(inputs.new_target_values),
      content: Jason.decode!(inputs.content),
      status: inputs.status,
      timeframe: inputs[:timeframe] || ctx.goal.timeframe,
      send_to_everyone: inputs[:send_notifications_to_everyone] || false,
      subscription_parent_type: :goal_update,
      subscriber_ids: subscriber_ids || []
    }}
  end
end
