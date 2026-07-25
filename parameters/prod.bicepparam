// Arquivo usado para definir os parametros da main no ambiente de produção
using '../main.bicep'

param ambiente = 'prod'
param localizacao = 'brazilsouth'

param skuKeyVault = 'premium'
param skuStorageAccount = 'Standard_GRS'
param skuAppServiceNome = 'P1v3'
param skuAppServiceTier = 'PremiumV3'
