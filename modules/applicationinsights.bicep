// Arquivo padrão para construção do Application Insights
@description('Nome que será usado na construção do Application Insight')
param nomeInsight string

@description('Localização padrão para criação')
param localizacao string

@description('ID do Worspace correspondente')
param IdWorkspace string

resource meuApplicationInsight 'Microsoft.Insights/components@2020-02-02' = {
  name: nomeInsight
  location: localizacao
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId:IdWorkspace
  }
}

output id string = meuApplicationInsight.id

output nome string = meuApplicationInsight.name

// Vai ser usado para a API conseguir se conectar ao Application Insights e enviar as métricas e logs de execução.
output connectionString string = meuApplicationInsight.properties.ConnectionString
