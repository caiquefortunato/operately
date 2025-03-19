export function getReadonlyFlags(attrs: { readonly?: boolean; editValue?: boolean; editDefinition?: boolean }) {
  return {
    readonlyValue: Boolean(attrs.readonly || !attrs.editValue),
    readonlyDefinition: Boolean(attrs.readonly || !attrs.editDefinition),
  };
}
