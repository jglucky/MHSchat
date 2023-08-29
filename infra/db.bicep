param accountName string
param location string = resourceGroup().location
param tags object = {}

param databaseName string = 'db_conversation_history'
param collectionName string = 'conversations'
param principalId string = ''

param containers array = [
  {
    name: collectionName
    id: collectionName
    partitionKey: '/id'
  }
]

module cosmos 'core/database/cosmos/sql/cosmos-sql-db.bicep' = {
  name: 'cosmos-sql'
  params: {
    accountName: accountName
    databaseName: databaseName
    location: location
    containers: containers
    tags: tags
    principalIds: [principalId]
  }
}


output databaseName string = cosmos.outputs.databaseName
output containerName string = containers[0].name
output accountName string = cosmos.outputs.accountName
output endpoint string = cosmos.outputs.endpoint