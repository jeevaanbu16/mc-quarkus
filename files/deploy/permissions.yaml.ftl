<#assign buildPlan = features["quarkus"].buildPlan>
<#assign repository = features["quarkus"].repository>

bambooServer: [=buildPlan.project.url?keep_before_last("/browse")]
specType: permissions

projects:
- plans: [[=buildPlan.project.key]-[=buildPlan.key]]
  permissions:
  - groups: [SEC_CI_JAG_DEV,GRP_QUALITYASSURANCE,SEC_CI_PROJMGR,SEC_CI_MODERNIZATION,SEC_NESS_JAVA_DEV]
    grant: [VIEW, BUILD]
    
deployments:
- name: [=buildPlan.name] Deployment
  permissions:
  - groups: [SEC_CI_JAG_DEV,GRP_QUALITYASSURANCE,SEC_CI_PROJMGR,SEC_CI_MODERNIZATION,SEC_NESS_JAVA_DEV]
    grant: [VIEW]
    
  environments:
  - names: [DEV]
    permissions:
    - groups: [SEC_CI_JAG_DEV,GRP_QUALITYASSURANCE,SEC_CI_PROJMGR,SEC_CI_MODERNIZATION,SEC_NESS_JAVA_DEV]
      grant: [VIEW]      
    - groups: [SEC_CI_JAG_DEV,GRP_QUALITYASSURANCE,SEC_CI_PROJMGR,SEC_CI_MODERNIZATION,SEC_NESS_JAVA_DEV]
      grant: [BUILD]     
      
  - names: [UAT]
    permissions:
    - groups: [SEC_CI_JAG_DEV,GRP_QUALITYASSURANCE,SEC_CI_PROJMGR,SEC_CI_MODERNIZATION,SEC_NESS_JAVA_DEV]
      grant: [VIEW]  
    - groups: [SEC_CI_JAG_DEV,GRP_QUALITYASSURANCE]
      grant: [BUILD]  
      
  - names: [PROD]
    permissions:
    - groups: [SEC_CI_JAG_DEV,GRP_QUALITYASSURANCE,SEC_CI_PROJMGR,SEC_CI_MODERNIZATION,SEC_NESS_JAVA_DEV]
      grant: [VIEW]    
    - groups: [GRP_QUALITYASSURANCE]
      grant: [BUILD]  
 