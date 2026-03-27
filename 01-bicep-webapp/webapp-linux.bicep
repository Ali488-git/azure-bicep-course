param webAppName string
param sku string = 'B1'
param linuxFxVersion string = 'PHP|8.1'
param location string = resourceGroup().location

var appServicePlanName = toLower('asp-${webAppName}')
var webSiteName = toLower(webAppName)

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    name: sku
    tier: 'Basic'
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  kind: 'app,linux'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
    httpsOnly: true
  }
}
