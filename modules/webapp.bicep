// Arquivo padrão para criação de Web App
@description('Nome que será usado na construção do Web App')
param nomeWebApp string

@description('Localização padrão para criação')
param localizacao string

@description('ID do App Service Plan onde esse Web APP irá rodar')
param idAppServicePlan string

@description('Objeto contendo os endpoints e conexões da infraestrutura para a API')
param appConfiguracao object = {
  appInsightsConnectionString: ''
  keyVaultUri: ''
  storageBlobEndpoint: ''
}

resource meuWebApp 'Microsoft.Web/sites@2025-03-01' = {
  name: nomeWebApp
  location: localizacao
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    serverFarmId: idAppServicePlan
    siteConfig: {
      netFrameworkVersion: 'v8.0'
      appSettings: [
        {
          name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
          value: appConfiguracao.appInsightsConnectionString
        }
        {
          name: 'KeyVault__Uri'
          value: appConfiguracao.keyVaultUri
        }
        {
          name: 'Storage__BlobEndpoint'
          value: appConfiguracao.storageBlobEndpoint
        }
      ]
    }
  }
}

output id string = meuWebApp.id

// Usado pela role pra saber exatmente a Managed Identity desse Web App
output principalId string = meuWebApp.identity.principalId

// URL desse web app após implementação
output urlPublica string = meuWebApp.properties.defaultHostName
