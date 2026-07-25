// Arquivo principal onde se orquestrará tudo

// Parametros Gerais
@allowed([
  'dev'
  'prod'
])
param ambiente string
param localizacao string
param rgId string = resourceGroup().id

// Parâmetros de Observabilidade (Log Analytics / App Insights)
param nomeWorkspace string = 'gab-workspace-${ambiente}'
param nomeInsight string = 'gab-appinsight-${ambiente}'
param retencaoEmDias int = ambiente == 'dev' ? 30 : 120

// Parâmetros de Segredos e Segurança (Key Vault)
param nomeKeyVault string = 'gab-kv-${uniqueString(rgId)}${ambiente}'
param skuKeyVault string

// Parâmetros de Armazenamento (Storage Account)
param nomeStorageAccount string = 'gabsa${uniqueString(rgId)}${ambiente}'
param skuStorageAccount string

// Parâmetros do Plano de Serviço (App Service Plan)
param nomeAppServicePlan string = 'gab-plan-${ambiente}'
param skuAppServiceNome string
param skuAppServiceTier string

// Parâmetros da Aplicação (Web App)
param nomeWebApp string = 'gab-webapp-${ambiente}'

// Chamadas dos Módulos (Infraestrutura)
