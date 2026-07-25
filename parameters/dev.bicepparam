// Arquivo usado para definir os parametros da main no ambiente de desenvolvimento
using '../main.bicep'

param ambiente = 'dev'
param localizacao = 'eastusa'

param skuKeyVault = 'standard'
param skuStorageAccount = 'Standard_LRS'
param skuAppServiceNome = 'F1'
param skuAppServiceTier = 'Free'
