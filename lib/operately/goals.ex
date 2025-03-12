defmodule Operately.Goals do
  import Ecto.Query, warn: false

  alias Operately.Repo
  alias Operately.Goals.{Goal, Target}
  alias Operately.People.Person
  alias Operately.Access.Fetch

  def list_goals do
    Repo.all(Goal)
  end

  def list_goals(filter) do
    from(goal in Goal)
    |> apply_if(filter.space_id, fn query ->
      from(goal in query, where: goal.group_id == ^filter.space_id)
    end)
    |> apply_if(filter.company_id, fn query ->
      from(goal in query, where: goal.company_id == ^filter.company_id)
    end)
    |> Repo.all()
  end

  defp apply_if(query, condition, fun) do
    if condition, do: fun.(query), else: query
  end

  def get_goal!(id), do: Repo.get_by_id(Goal, id, :with_deleted)

  def get_goal_with_access_level(goal_id, person_id) do
    from(g in Goal, as: :resource, where: g.id == ^goal_id)
    |> Fetch.get_resource_with_access_level(person_id)
  end

  defdelegate create_goal(creator, attrs), to: Operately.Operations.GoalCreation, as: :run
  defdelegate archive_goal(author, goal), to: Operately.Operations.GoalArchived, as: :run

  def update_goal(%Goal{} = goal, attrs) do
    goal
    |> Goal.changeset(attrs)
    |> Repo.update()
  end

  def delete_goal(%Goal{} = goal) do
    Repo.delete(goal)
  end

  def change_goal(%Goal{} = goal, attrs \\ %{}) do
    Goal.changeset(goal, attrs)
  end

  def get_role(%Goal{} = goal, person) do
    cond do
      goal.champion_id == person.id -> :champion
      goal.reviewer_id == person.id -> :reviewer
      true -> nil
    end
  end

  def list_targets(goal_id) do
    from(target in Target, where: target.goal_id == ^goal_id, order_by: target.index)
    |> Repo.all()
  end

  def progress_percentage(goal) do
    targets = Repo.preload(goal, :targets).targets
    target_progresses = Enum.map(targets, &target_progress_percentage/1)

    if Enum.empty?(target_progresses) do
      0
    else
      Enum.sum(target_progresses) / length(target_progresses)
    end
  end

  def target_progress_percentage(target) do
    from = target.from
    to = target.to
    current = target.value

    cond do
      from == to -> 100

      from < to ->
        cond do
          current > to -> 100
          current < from -> 0
          true -> (from - current) / (from - to) * 100
        end

      from > to ->
        cond do
          current < to -> 100
          current > from -> 0
          true -> (to - current) / (to - from) * 100
        end
    end
  end

  def outdated?(goal) do
    if goal.next_update_scheduled_at do
      today = Date.utc_today()
      update_day = DateTime.to_date(goal.next_update_scheduled_at)
      update_missed_by = Date.diff(today, update_day)

      cond do
        goal.closed_at != nil -> false
        goal.deleted_at != nil -> false
        update_missed_by > 3 -> true
        true -> false
      end
    else
      true
    end
  end

  def list_goal_contributors(goal_id, requester: requester) when is_binary(goal_id) do
    initial_query = goal_contribs_initial_query(goal_id, requester)
    recursive_query = from(g in Goal, join: parent in "goal_tree", on: g.parent_goal_id == parent.id)

    goal_tree_query = union_all(initial_query, ^recursive_query)

    {"goal_tree", Goal}
    |> recursive_ctes(true)
    |> with_cte("goal_tree", as: ^goal_tree_query)
    |> join(:inner, [g], assoc(g, :projects))
    |> join(:inner, [_, p], assoc(p, :contributors), as: :contrib)
    |> join(:inner, [contrib: c], assoc(c, :person), as: :person)
    |> select([person: p], p)
    |> distinct([person: p], p.id)
    |> Repo.all()
  end

  defp goal_contribs_initial_query(goal_id, nil) do
    from(g in Goal, where: g.id == ^goal_id)
  end

  defp goal_contribs_initial_query(goal_id, requester = %Person{}) do
    from(g in Goal, as: :resource, where: g.id == ^goal_id)
    |> Fetch.join_access_level(requester.id)
  end

  alias Operately.Goals.Update

  def list_updates(goal) do
    from(u in Update,
      where: u.goal_id == ^goal.id
    )
    |> Repo.all()
  end

  def create_update(attrs \\ %{}) do
    %Update{}
    |> Update.changeset(attrs)
    |> Repo.insert()
  end

  def update_update(%Update{} = update, attrs) do
    update
    |> Update.changeset(attrs)
    |> Repo.update()
  end
end
