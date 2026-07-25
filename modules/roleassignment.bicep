// Arquivo padrão para construção de um Role Assignnment para dar poder de ler o Key Vault e o Storage Account

@description('ID do Web App (PrincipalId)')
param principalId string

@description('GUID do papel do Azure (que pode ser Secrets User ou Blob Data Contributor)')
param roleDefinitionId string

@description('Tipo do Principal (padrão ServicePrincipal para Managed Identity)')
param principalTipo string = 'ServicePrincipal'

// Criamos o ID completo do recurso de Role Definition
var roleDefinitionIdCompleta = subscriptionResourceId('Microsoft.Authorization/roleDefinitions', roleDefinitionId)

// Geramos um GUID único e determinístico para a atribuição
var nomeRole = guid(resourceGroup().id, principalId, roleDefinitionId)

resource meuRoleAssignnment 'Microsoft.Authorization/roleAssignments@2022-04-01' = {
  name: nomeRole
  properties: {
    principalId: principalId
    roleDefinitionId: roleDefinitionIdCompleta
    principalType: principalTipo
  }
}

output id string = meuRoleAssignnment.id
output name string = meuRoleAssignnment.name
