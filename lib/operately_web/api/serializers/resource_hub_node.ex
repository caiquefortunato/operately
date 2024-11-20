defimpl OperatelyWeb.Api.Serializable, for: Operately.ResourceHubs.Node do
  def serialize(node, level: :essential) do
    %{
      id: OperatelyWeb.Paths.node_id(node),
      name: node.name,
      type: node.type,
      folder: OperatelyWeb.Api.Serializer.serialize(node.folder),
      document: OperatelyWeb.Api.Serializer.serialize(node.document),
    }
  end
end
