// Arquivo usado para definir os parametros da main no ambiente de desenvolvimento
using '../main.bicep'

param ambiente = 'dev'
param localizacaoGeral = 'eastusa'

param skuKeyVault = 'standard'
param skuStorageAccount = 'Standard_LRS'
param skuAppService = {
  nome: 'F1'
  tier: 'Free'
}
