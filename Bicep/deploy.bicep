@minLength(3)
@maxLength(24)

param storageName string = 'webstg1${uniqueString(resourceGroup().id)}'

param location string = resourceGroup().location

module storage './storage.Bicep' = {
  name: 'deploy_&{storageName}'
  params: {
      StorageName: storageName
      location: location
  }
}

module kv './keyvault.bicep' = {
  name:'kv'
  dependsOn: [
    storage
  ]
  params: {
    keyVaultName: 'kv-${uniqueString(substring(uniqueString(subscription().subscriptionId), 0, 6)}-${uniqueString(resourceGroup().id)}'
    storageName: storage.outputs.storageNameOT
    location: location
  }
}
