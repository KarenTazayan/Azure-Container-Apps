param location string = resourceGroup().location

var tags = {
  Purpose: 'Azure Container Apps Sample'
}

resource sampleWebAppCae 'Microsoft.App/managedEnvironments@2022-03-01' = {
  name: 'cae-azure-container-apps-1'
  location: location
  tags: tags
  properties: {
    zoneRedundant: false
  }
}

resource sampleWebAppCa 'Microsoft.App/containerApps@2022-03-01' = {
  name: 'ca-sample-web-app-1'
  location: location
  properties: {
    managedEnvironmentId: sampleWebAppCae.id
    configuration: {
      activeRevisionsMode: 'multiple'
      ingress: {
        external: true
        targetPort: 80
      }
    }
    template: {
      revisionSuffix: 'v1-0-0'
      containers: [
        {
          image: 'docker.io/asynchub/azure-container-apps:latest'
          name: 'ca-sample-web-app'
        }
      ]
      scale: {
        minReplicas: 0
        maxReplicas: 10
      }
    }
  }
}
