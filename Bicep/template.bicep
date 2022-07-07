param location string = resourceGroup().location

@minLength(3)
@maxLength(11)
param storageNamePrefix string

@allowed([
    'Standard_LRS'
    'Standard_ZRS'
  ])
param storageSKU string

var storageName = '${toLower(storageNamePrefix)}${uniqueString(resourceGroup().id)}'

resource storageaccount_res 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  properties:{
    allowBlobPublicAccess:false
    accessTier: 'Hot'
    allowSharedKeyAccess: false
    networkAcls: {
      defaultAction: 'Deny'
      bypass:'AzureServices'
    } 
  }
  sku: {
    name: storageSKU
  }
}
output bloburl string=storageaccount_res.properties.primaryEndpoints.blob
