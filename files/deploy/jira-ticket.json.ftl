<#assign buildPlan = features["quarkus"].buildPlan>
<#assign repository = features["quarkus"].repository>
{
        "fields": {
                "project": {
                        "key": "SDHD"
                },
                "summary": "[=application.name]",
                "description": "[=buildPlan.description]",
                "reporter": {
                        "key": "[=application.requestedBy.userId]",
                        "name": "[=application.requestedBy.userId]",
                        "emailAddress": "[=application.requestedBy.email]"
                },
                "issuetype": {
                        "name": "Request"
                },
                "customfield_28102": {
                        "name": "Enterprise Architecture",
                        "emailAddress": "JIRAEnterpriseArchitecture@mclane.mclaneco.com"
                },
                "components": [
                        {
                                "name": "CICD"
                        }
                ],
                "customfield_21001": "Completed by the CICD Pipeline."
        }
}
