// Arquivo usado para definir os parametros da main no ambiente de produção
using '../main.bicep'

param ambiente = 'prod'
param localizacaoGeral = 'brazilsouth'

param skuKeyVault = 'premium'
param skuStorageAccount = 'Standard_GRS'
param skuAppService = {
  nome: 'P1v3'
  tier: 'PremiumV3'
}

