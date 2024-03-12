<#assign buildPlan = features["quarkus"].buildPlan>
<#assign repository = features["quarkus"].repository>

bambooServer: [=buildPlan.project.url?keep_before_last("/browse")]
specType: deployment

name: [=buildPlan.name] Deployment
buildProject: [=buildPlan.project.key]
buildPlan: [=buildPlan.key]
description: [=buildPlan.description]

releaseNaming:
  pattern: release-${bamboo.buildNumber}
  
environments:
- environment: DEV
  description: Quarkus DEV Deployment

  triggers:
  - type: AFTER_SUCCESSFUL_BUILD_PLAN
    branch: develop
    description: Deploy main plan branch after successful build

  tasks:
   - type: CLEAN
     description: Clean working dir
     
   - type: ARTEFACT
     description: Download Artefacts

   - type: INJECT
     description: Store vars for use in other tasks
     namespace: inject
     propertiesFile: buildvariables.txt
     scope: LOCAL
     
   - type: INJECT
     description: Inject Quarkus Application Properties
     namespace: quarkus
     propertiesFile: application.properties
     scope: LOCAL
     
   - type: COMMAND
     description: Tag image
     executable: Openshift Project Command 2
     argument: [=application.appId]-dev tag ${bamboo.docker.host}/[=application.appId]:${bamboo.inject.image_tag} [=application.appId]:latest --scheduled=true

   - type: COMMAND
     description: Import Image
     executable: Openshift Project Command 2
     argument: [=application.appId]-dev import-image [=application.appId]:latest

   - type: COMMAND
     description: helm repo update
     executable: Helm 3.6
     argument: repo update

   - type: COMMAND
     description: helm install
     executable: Helm 3.6
     argument: upgrade -i -n [=application.appId]-dev [=application.appId] --set quarkusProfile=dev -f values.yaml --burst-limit 255 helm-mclane/Quarkus 

- environment: UAT
  description: Quarkus UAT Deployment

  tasks:
   - type: CLEAN
     description: Clean working dir
     
   - type: ARTEFACT
     description: Download Artefacts

   - type: INJECT
     description: Store vars for use in other tasks
     namespace: inject
     propertiesFile: buildvariables.txt
     scope: LOCAL
     
   - type: INJECT
     description: Inject Quarkus Application Properties
     namespace: quarkus
     propertiesFile: application.properties
     scope: LOCAL
     
   - type: COMMAND
     description: Tag image
     executable: Openshift Project Command 2
     argument: [=application.appId]-test tag ${bamboo.docker.host}/[=application.appId]:${bamboo.inject.image_tag} [=application.appId]:latest --scheduled=true

   - type: COMMAND
     description: Import Image
     executable: Openshift Project Command 2
     argument: [=application.appId]-test import-image [=application.appId]:latest

   - type: COMMAND
     description: helm repo update
     executable: Helm 3.6
     argument: repo update

   - type: COMMAND
     description: helm install
     executable: Helm 3.6
     argument: upgrade -i -n [=application.appId]-test [=application.appId] --set quarkusProfile=test -f values.yaml --burst-limit 255 helm-mclane/Quarkus

- environment: PROD
  description: Quarkus PROD Deployment

  tasks:
   - type: CLEAN
     description: Clean working dir
     
   - type: ARTEFACT
     description: Download Artefacts

   - type: INJECT
     description: Store vars for use in other tasks
     namespace: inject
     propertiesFile: buildvariables.txt
     scope: LOCAL
     
   - type: INJECT
     description: Inject Quarkus Application Properties
     namespace: quarkus
     propertiesFile: application.properties
     scope: LOCAL
     
   - type: COMMAND
     description: Tag image
     executable: Openshift Project Command 2
     argument: [=application.appId] tag ${bamboo.docker.host}/[=application.appId]:${bamboo.inject.image_tag} [=application.appId]:latest --scheduled=true

   - type: COMMAND
     description: Import Image
     executable: Openshift Project Command 2
     argument: [=application.appId] import-image [=application.appId]:latest

   - type: COMMAND
     description: helm repo update
     executable: Helm 3.6
     argument: repo update

   - type: COMMAND
     description: helm install
     executable: Helm 3.6
     argument: upgrade -i -n [=application.appId] [=application.appId] -f values.yaml --burst-limit 255 helm-mclane/Quarkus
 
