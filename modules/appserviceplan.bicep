// Arquivo padrão para criação de App Service Plan
@description('Nome que será usado na construção do App Service Plan')
@minLength(3)
@maxLength(24)
param nomeAppServicePlan string

@description('Localização padrão para criação')
param localizacao string

@description('O tamanho/código da máquina')
param nomeSKU string

@description('A categoria do plano')
param tierSKU string

@description('A quantidade de instâncias do servidor')
param capacidadeSKU int = 1

resource meuAppServicePlan 'Microsoft.Web/serverfarms@2025-03-01' = {
  name: nomeAppServicePlan
  location: localizacao
  sku: {
    name: nomeSKU
    tier: tierSKU
    capacity: capacidadeSKU
  }
  kind: 'app'
}

output id string = meuAppServicePlan.id

output nome string = meuAppServicePlan.name
