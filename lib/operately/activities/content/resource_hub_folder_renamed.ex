defmodule Operately.Activities.Content.ResourceHubFolderRenamed do
  use Operately.Activities.Content

  embedded_schema do
    belongs_to :company, Operately.Companies.Company
    belongs_to :space, Operately.Groups.Group
    belongs_to :resource_hub, Operately.ResourceHubs.ResourceHub
    belongs_to :node, Operately.ResourceHubs.Node
    belongs_to :folder, Operately.ResourceHubs.Folder

    field :old_name, :string
    field :new_name, :string
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> cast(attrs, __schema__(:fields))
    |> validate_required(__schema__(:fields))
  end

  def build(params) do
    changeset(params)
  end
end
