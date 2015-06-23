Changelog of MARS Schema
====

# latest Version: 5.0.2

## next Version 5.0.3

## Version 5.0.2

- *Date:* Jun 23 2015

- *included fixes*
  + new SoftwareSubClass for SoftwareClass "DataProcessing": GraphIT

## Version 5.0.1

- *Date:* Feb 26 2015

- *included fixes*
  + [new SoftwareSubClass for SoftwareClass "IAM": WSO2IS](../../pull/39)
  + new SoftwareClass "LDAP" with SubClasses: "OpenLDAP", "DirectoryServer389"
  + [new Attribute "AutoRestart" for SoftwareConfiguration](../../pull/43)

## Version 5.0.0

- *Date:* Jul 11 2014

- *changes incompatible with version 4.1*
  + [SoftwareClass/SubClass "EAI"/"Sharepoint" removed. Use "Productivity"/"MSSharePointServer" instead](../../issues/34)

## Version 4.1.7

- *Date:* Jul 08 2014

- *included fixes*
  + [new SoftwareSubClass for SoftwareClass "IAM": JOSSO2](../../pull/37)
  + [new SoftwareSubClass for SoftwareClass "FileServices": OracleASM](../../issues/38)

## Version 4.1.6

- *Date:* May 12 2014

- *included fixes*
  + [additional attributes for SoftwareConfiguration](../../pull/35)
  + [new SoftwareSubClass for SoftwareClass "Proxy": Varnish](../../pull/36)

## Version 4.1.5

- *Date:* Mar 26 2014

- *included fixes*
  + [new SoftwareClass/SubClass pairs: Virtualization/VMWare, DBMS/HSQLDB](../../pull/27)
  + [new SoftwareSubClass for SoftwareClass "Administration": SophosAntiVirus, McAfeeCommonManagementAgent, McAfeeVirusScan](../../issues/28)
  + [new SoftwareSubClass for SoftwareClass "Administration": BMCPatrolAgent, BMCPerformanceManager](../../issues/29)
  + [attribute "StopScript" added to "SoftwareConfiguration"](../../pull/32)

## Version 4.1.4

- *Date:* Feb 14 2014

- *included fixes*
  + [general top level attribute "AutomationState" added](../../pull/25)
  + [value list for top level attribute "MonitoringStatus" corrected](../../pull/26)
  + [new SoftwareSubClass "MSSharePointServer" for SoftwareClass "Productivity"](../../issues/24)
  + [new SoftwareSubClass "MSProjectServer" for SoftwareClass "Productivity"](../../issues/22)
  + [allow longer strings for some fields](../../pull/21)
  + [changed MonitoringStatus to numeric status type](../../pull/26)

## Version 4.1.3

- *Date:* Jan 13 2014

- *included fixes*
  + [New sub-class 'OpenAM' for SW-Class 'IAM'](../../issues/5)
  + [some new values for MachineArchitecture](../../issues/8)
  + [allow _ in CustomerInformation/@ID](../../pull/10)
  + [DNS Software Knoten: only classes added. no configuration, yet](../../issues/3)
  + [New SoftwareClasses/SubClasses for Oracle Fusion](../../issues/11)
  + [New MachineClass BSD](../../issues/12)
  + [new SoftwareClass/SoftwareSubClass for AutoPilot CE](../../issues/13)
  + [new SoftwareSubClass PHP-FPM](../../pull/15)
  + [new SoftwareSubClass Crond](../../pull/18)
  + [new SoftwareSubClass Zookeeper](../../pull/19)


## Version 4.1.2

- *Date:* Nov 12 2013

- *included fixes*
  + [New SW-Class MailServer plus sub-classes](../../issues/2)

## Version 4.1.1

- *Date:* Mon Oct 28 16:07:10 2013 +0100

- *included fixes*

  + [Emtpy <Dependencies> tag can be omitted](../../pull/1)
  + [New software sub class "DB2" for software class "DBMS"](../../pull/1)


## Version 4.1.0

intial version


