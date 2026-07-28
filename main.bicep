// Arquivo principal onde se orquestrará tudo

// Parametros Gerais
@allowed([
  'dev'
  'prod'
])
param ambiente string
param localizacaoGeral string
param rgId string = resourceGroup().id

// Parâmetros de Observabilidade (Log Analytics / App Insights)
param nomeWorkspaceFinal string = 'gab-workspace-${ambiente}'
param nomeInsightFinal string = 'gab-appinsight-${ambiente}'
param retencaoEmDiasFinal int = ambiente == 'dev' ? 30 : 120

// Parâmetros de Segredos e Segurança (Key Vault)
param nomeKeyVaultFinal string = 'gab-kv-${uniqueString(rgId)}${ambiente}'
param skuKeyVault string

// Parâmetros de Armazenamento (Storage Account)
param nomeStorageAccountFinal string = 'gabsa${uniqueString(rgId)}${ambiente}'
param skuStorageAccount string

// Parâmetros do Plano de Serviço (App Service Plan)
param nomeAppServicePlanFinal string = 'gab-plan-${ambiente}'
param skuAppService object

// Parâmetros da Aplicação (Web App)
param nomeWebAppFinal string = 'gab-webapp-${ambiente}'

// Chamadas dos Módulos (Infraestrutura)
module gabLogAnalyticsWorkspace 'modules/loganalytics.bicep' = {
  name: 'gab-log-analytics-workspace'
  params: {
    nomeWorkspace: nomeWorkspaceFinal
    localizacao: localizacaoGeral
    retencaoEmDias: retencaoEmDiasFinal
  }
}

module gabApplicationInsight 'modules/applicationinsights.bicep' = {
  name: 'gab-application-insight'
  params: {
    nomeInsight: nomeInsightFinal
    localizacao: localizacaoGeral
    IdWorkspace: gabLogAnalyticsWorkspace.outputs.id
  }
}

module gabKeyVault 'modules/keyvault.bicep' = {
  name: 'gab-key-vault'
  params: {
    nomeKeyVault: nomeKeyVaultFinal
    localizacao: localizacaoGeral
    nomeSKU: skuKeyVault
  }
}

module gabStorageAccount 'modules/storage.bicep' = {
  name: 'gab-storage-account'
  params: {
    nomeStorage: nomeStorageAccountFinal
    localizacao: localizacaoGeral
    nomeSKU: skuStorageAccount
  }
}

module gabAppServicePlan 'modules/appserviceplan.bicep' = {
  name: 'gab-app-service'
  params: {
    nomeAppServicePlan: nomeAppServicePlanFinal
    localizacao: localizacaoGeral
    nomeSKU: skuAppService.nome
    tierSKU: skuAppService.tier
    capacidadeSKU: ambiente == 'prod' ? 2 : 1
  }
}

module gabWebApp 'modules/webapp.bicep' = {
  name: 'gab-web-app'
  params: {
    nomeWebApp: nomeWebAppFinal
    localizacao: localizacaoGeral
    idAppServicePlan: gabAppServicePlan.outputs.id
    appConfiguracao: {
      appInsightsConnectionString: gabApplicationInsight.outputs.connectionString
      keyVaultUri: gabKeyVault.outputs.vaultUri
      storageBlobEndpoint: gabStorageAccount.outputs.blobEndpoint
    }
  }
}

module gabRoleKeyVault 'modules/roleassignment.bicep' = {
  name: 'gab-rbac-key-vault'
  params: {
    principalId: gabWebApp.outputs.principalId
    roleDefinitionId: '46330bef-0e9c-4113-b216-7924161d8615' // Permite ler os segredos do Key Vault, mas não permite alteração ou criação
  }
}

module gabRoleStorageAccount 'modules/roleassignment.bicep' = {
  name: 'gab-rbac-storage-account'
  params: {
    principalId: gabWebApp.outputs.principalId
    roleDefinitionId: 'ba92f5b4-2d11-453d-a403-e96b0029c9fe' // Permite ler, gravar e deletar Blobs no Storage Account.
  }
}
