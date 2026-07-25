// Arquivo modelo para criação de Storage Account
@description('Nome que será usado na construção do Storage Account')
@minLength(3)
@maxLength(24)
param nomeStorage string

@description('Localização padrão para criação')
param localizacao string

@description('Tipo de Redundância')
param nomeSKU string

resource meuStorageAccount 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: nomeStorage
  location: localizacao
  kind: 'StorageV2'
  sku: {
    name: nomeSKU
  }
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
    minimumTlsVersion: 'TLS1_2'
  }
}

output id string = meuStorageAccount.id

output name string = meuStorageAccount.name

// Usado pela API para acessar endpoint base do serviço. Valor = https://<nome-storage>.blob.core.windows.net/
output blobEndpoint string = meuStorageAccount.properties.primaryEndpoints.blob
