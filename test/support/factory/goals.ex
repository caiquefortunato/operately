defmodule Operately.Support.Factory.Goals do
  alias Operately.Access.Binding
  alias Operately.Goals.Timeframe
  alias Operately.Support.RichText

  def add_goal(ctx, testid, space_name, opts \\ []) do
    name = Keyword.get(opts, :name, "some name")
    company_access = Keyword.get(opts, :company_access, Binding.view_access())
    space_access = Keyword.get(opts, :space_access, Binding.comment_access())
    champion = Keyword.get(opts, :champion, :creator)
    reviewer = Keyword.get(opts, :reviewer, :creator)
    parent_goal = Keyword.get(opts, :parent_goal)

    goal = Operately.GoalsFixtures.goal_fixture(ctx.creator, %{
      name: name,
      parent_goal_id: parent_goal && ctx[parent_goal].id,
      space_id: ctx[space_name].id,
      champion_id: ctx[champion].id,
      reviewer_id: ctx[reviewer].id,
      company_access_level: company_access,
      space_access_level: space_access,
      timeframe: opts[:timeframe] || Timeframe.current_year(),
    })

    Map.put(ctx, testid, goal)
  end

  def add_goal_update(ctx, testid, goal_name, person_name) do
    goal = Map.fetch!(ctx, goal_name)
    person = Map.fetch!(ctx, person_name)

    update = Operately.GoalsFixtures.goal_update_fixture(person, goal)

    Map.put(ctx, testid, update)
  end

  def set_goal_next_update_date(ctx, goal_name, date) do
    goal = Map.fetch!(ctx, goal_name)

    goal
    |> Operately.Goals.Goal.changeset(%{next_update_scheduled_at: date})
    |> Operately.Repo.update()

    Map.put(ctx, goal_name, goal)
  end

  def add_goal_target(ctx, testid, goal_name, attrs \\ []) do
    goal = Map.fetch!(ctx, goal_name)
    target = Operately.GoalsFixtures.goal_target_fixture(goal, attrs)

    Map.put(ctx, testid, target)
  end

  def add_goal_discussion(ctx, testid, goal_name, opts \\ []) do
    goal = Map.fetch!(ctx, goal_name)
    title = Keyword.get(opts, :title, "some title")
    message = Keyword.get(opts, :message, RichText.rich_text("content", :as_string))

    {:ok, activity} = Operately.Operations.GoalDiscussionCreation.run(ctx.creator, goal, title, message)
    discussion = Operately.Repo.preload(activity, :comment_thread).comment_thread

    Map.put(ctx, testid, discussion)
  end

  def close_goal(ctx, testid, opts \\ []) do
    goal = Map.fetch!(ctx, testid)
    success = Keyword.get(opts, :success, "success")
    retrospective = Keyword.get(opts, :retrospective, RichText.rich_text("content", :as_string))

    {:ok, goal} = Operately.Operations.GoalClosing.run(ctx.creator, goal, success, retrospective)

    Map.put(ctx, testid, goal)
  end

  def reopen_goal(ctx, testid, opts \\ []) do
    goal = Map.fetch!(ctx, testid)
    message = Keyword.get(opts, :message, RichText.rich_text("content", :as_string))

    {:ok, goal} = Operately.Operations.GoalReopening.run(ctx.creator, goal, message)

    Map.put(ctx, testid, goal)
  end
end
