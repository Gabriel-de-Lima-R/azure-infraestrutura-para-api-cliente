// Arquivo padrão para construção do Log Analytics Workspace
@description('Nome que será usado na construção do Log Analytics Workspace')
param nomeWorkspace string

@description('Localização padrão para criação')
param localizacao string

@description('Tempo de retenção dos logs em dias')
@minValue(30)
@maxValue(730)
param retencaoEmDias int = 30

resource meuLogAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2025-02-01' = {
  name: nomeWorkspace
  location: localizacao
  properties: {
    sku: {
      name: 'PerGB2018' // Modelo Pay As You Go
    }
    retentionInDays: retencaoEmDias
  }
}

@description('ID do Log Analytics Workspace')
output id string = meuLogAnalyticsWorkspace.id

@description('Nome do workspace criado')
output name string = meuLogAnalyticsWorkspace.name
