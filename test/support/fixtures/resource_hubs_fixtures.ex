defmodule Operately.ResourceHubsFixtures do
  alias Operately.Support.RichText
  alias Operately.Access.Binding

  def resource_hub_fixture(creator, space, attrs \\ %{}) do
    attrs = Enum.into(attrs, %{
      name: "Resource hub",
      description: RichText.rich_text("This is a rosource hub"),
      anonymous_access_level: Binding.view_access(),
      company_access_level: Binding.comment_access(),
      space_access_level: Binding.edit_access(),
    })

    {:ok, hub} = Operately.ResourceHubs.create_resource_hub(creator, space, attrs)
    hub
  end

  def folder_fixture(hub_id, attrs \\ %{}) do
    {:ok, node} = Operately.ResourceHubs.create_node(%{
      resource_hub_id: hub_id,
      parent_folder_id: attrs[:parent_folder_id] && attrs.parent_folder_id,
      name: attrs[:name] || "some name",
      type: :folder,
    })

    {:ok, folder} = Operately.ResourceHubs.create_folder(%{
      node_id: node.id,
      description: attrs[:description] || RichText.rich_text("This is a rosource hub"),
    })

    folder
  end

  def document_fixture(hub_id, attrs \\ []) do
    {:ok, node} = Operately.ResourceHubs.create_node(%{
      resource_hub_id: hub_id,
      parent_folder_id: attrs[:parent_folder_id] && attrs.parent_folder_id,
      name: attrs[:name] || "some name",
      type: :document,
    })

    {:ok, document} = Operately.ResourceHubs.create_document(%{
      node_id: node.id,
      content: attrs[:content] || RichText.rich_text("Content"),
    })

    document
  end
end
