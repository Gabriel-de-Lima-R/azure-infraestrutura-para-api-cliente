// Arquivo padrão para criação de um Key Vault
@description('Nome que será usado na construção do Key Vault')
@minLength(3)
@maxLength(24)
param nomeKeyVault string

@description('Localização padrão para criação')
param localizacao string

@description('SKU do Key Vault (que pode ser standard ou premium)')
param nomeSKU string = 'standard'

resource meuKeyVault 'Microsoft.KeyVault/vaults@2025-05-01' = {
  name: nomeKeyVault
  location: localizacao
  properties: {
    tenantId: subscription().id
    sku: {
      family: 'A'
      name: nomeSKU
    }
    enableRbacAuthorization: true
  }
}

output id string = meuKeyVault.id

output name string = meuKeyVault.name

output vaultUri string = meuKeyVault.properties.vaultUri
