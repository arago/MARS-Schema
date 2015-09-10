<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns="https://graphit.co/schemas/v2/MARSSchema" xmlns:mars="http://mars-o-matic.com" xmlns:marsnew="https://graphit.co/schemas/v2/MARSSchema">
    <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>

    <xsl:namespace-alias stylesheet-prefix="mars" result-prefix="marsnew"/>
    
    <xsl:template match="/*" >
        <xsl:element name="{name()}" namespace="https://graphit.co/schemas/v2/MARSSchema">
            <xsl:for-each select="mars:CustomerInformation/@*">
                <xsl:attribute name="Customer{name()}">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </xsl:for-each>
            <xsl:for-each select="mars:OSInformation/@*">
                <xsl:attribute name="OS{name()}">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </xsl:for-each>
            <xsl:for-each select="mars:HardwareInformation/@*">
                <xsl:attribute name="HW{name()}">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </xsl:for-each>
            <xsl:for-each select="mars:SoftwareInformation/@*">
                <xsl:attribute name="SW{name()}">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </xsl:for-each>
            <xsl:for-each select="mars:SoftwareConfiguration/@*">
                <xsl:attribute name="{name()}">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </xsl:for-each>
            <xsl:for-each select="mars:HardwareInformation/mars:CPUInformation/@*">
                <xsl:attribute name="CPU{name()}">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </xsl:for-each>
            <xsl:for-each select="mars:HardwareInformation/mars:ServiceContractInformation/@*">
                <xsl:attribute name="HWServiceContractContract{name()}">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </xsl:for-each>
            <xsl:for-each select="mars:SoftwareInformation/mars:ServiceContractInformation/@*">
                <xsl:attribute name="SWServiceContractContract{name()}">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </xsl:for-each>
            <xsl:for-each select="mars:SoftwareInformation/mars:LogInformation/@*">
                <xsl:attribute name="Log{name()}">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </xsl:for-each>
            <xsl:for-each select="mars:LocationInformation/*/@*">
                <xsl:attribute name="DataCenter{name()}">
                    <xsl:value-of select="." />
                </xsl:attribute>
            </xsl:for-each>
            <xsl:if test="mars:NetworkInformation/mars:RoutingInformation/@Gateway">
                <xsl:attribute name="NetworkDefaultGW">
                    <xsl:value-of select="mars:NetworkInformation/mars:RoutingInformation/@Gateway" />
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="mars:ContactInformation/mars:AppC/@eMail">
                <xsl:attribute name="ApplicationContact">
                    <xsl:value-of select="mars:ContactInformation/mars:AppC/@eMail" />
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="mars:ContactInformation/mars:ResourceC/@eMail">
                <xsl:attribute name="ResourceContact">
                    <xsl:value-of select="mars:ContactInformation/mars:ResourceC/@eMail" />
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="mars:ContactInformation/mars:SoftwareC/@eMail">
                <xsl:attribute name="SoftwareContact">
                    <xsl:value-of select="mars:ContactInformation/mars:SoftwareC/@eMail" />
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="mars:ContactInformation/mars:HardwareC/@eMail">
                <xsl:attribute name="HardwareContact">
                    <xsl:value-of select="mars:ContactInformation/mars:HardwareC/@eMail" />
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="mars:ContactInformation/mars:TechC/@eMail">
                <xsl:attribute name="TechContact">
                    <xsl:value-of select="mars:ContactInformation/mars:TechC/@eMail" />
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="mars:ContactInformation/mars:ServiceC/@eMail">
                <xsl:attribute name="ServiceContact">
                    <xsl:value-of select="mars:ContactInformation/mars:ServiceC/@eMail" />
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="mars:CustomerInformation" />
    <xsl:template match="mars:OSInformation" />
    <xsl:template match="mars:HardwareInformation" />
    <xsl:template match="mars:SoftwareInformation" />
    <xsl:template match="mars:SoftwareConfiguration" />
    <xsl:template match="mars:LocationInformation" />

    <xsl:template match="mars:Dependencies">
        <xsl:element name="Dependencies" namespace="https://graphit.co/schemas/v2/MARSSchema">
            <xsl:for-each select="mars:Node">
                <xsl:element name="Node" namespace="https://graphit.co/schemas/v2/MARSSchema">
                    <xsl:attribute name="ID">
                        <xsl:value-of select="@ID"/>
                    </xsl:attribute>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>

    <xsl:template match="mars:Extensions">
        <xsl:element name="MAIDChecks" namespace="https://graphit.co/schemas/v2/MARSSchema">
            <xsl:for-each select="mars:WatchMeConfig/*">
                <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                    <xsl:attribute name="Key">
                        <xsl:value-of select="name(.)"/>
                    </xsl:attribute>
                    <xsl:attribute name="Content">{<xsl:for-each select="@*">"<xsl:value-of select="name()" />": "<xsl:value-of select="." />",</xsl:for-each>"ConversionDummy": "Dummy"}</xsl:attribute>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
    </xsl:template>
    
    <xsl:template match="mars:OSServiceInformation">
        <xsl:for-each select="mars:AvailableServices[@Service]">
            <xsl:element name="AvailableServices" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:call-template name="tokenizeString">
                    <xsl:with-param name="list" select="@Service" />
                    <xsl:with-param name="delimiter" select="':'" />
                </xsl:call-template>
            </xsl:element>
        </xsl:for-each>
        <xsl:for-each select="mars:RunningServices[@Service]">
            <xsl:element name="RunningServices" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:call-template name="tokenizeString">
                    <xsl:with-param name="list" select="@Service" />
                    <xsl:with-param name="delimiter" select="':'" />
                </xsl:call-template>
            </xsl:element>
        </xsl:for-each>
        <xsl:for-each select="mars:DisabledServices[@Service]">
            <xsl:element name="DisabledServices" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:call-template name="tokenizeString">
                    <xsl:with-param name="list" select="@Service" />
                    <xsl:with-param name="delimiter" select="':'" />
                </xsl:call-template>
            </xsl:element>
        </xsl:for-each>
        <xsl:for-each select="mars:ManualServices[@Service]">
            <xsl:element name="ManualServices" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:call-template name="tokenizeString">
                    <xsl:with-param name="list" select="@Service" />
                    <xsl:with-param name="delimiter" select="':'" />
                </xsl:call-template>
            </xsl:element>
        </xsl:for-each>
    </xsl:template>


    <xsl:template match="mars:ContactInformation">
        <!--
    ContactInformation/XX/$$ (XX=ApplicationC/ResourceC/TechC/ServiceC) ($$=Name, Function, Company, eMail, Phone, ADSUserName)
    -> ApplicationContact,ResourceContact, TechContact, ServiceContact = email
    => persons should be in graph, not in nodes(!) this is conceptually broken bs... not used by _any_ KI    
        -->

        <!--        <xsl:for-each select="ApplicationC">
            <xsl:element name="ApplicationContact" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:attribute name="
            </xsl:element>
        </xsl:for-each>-->
            
    </xsl:template>

    <xsl:template match="mars:StorageInformation">
        <xsl:element name="Filesystem" namespace="https://graphit.co/schemas/v2/MARSSchema">
            <xsl:for-each select="mars:FileSystemInformation/mars:FileSystem">
                <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                    <xsl:attribute name="Content">
                        <xsl:value-of select="@Device" />
                    </xsl:attribute>
                </xsl:element>
            </xsl:for-each>
        </xsl:element>
        <xsl:if test="mars:FileSystemInformation/*[@MountPoint]">
            <xsl:element name="FilesystemMountpoint" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:for-each select="mars:FileSystemInformation">
                    <xsl:for-each select="*">
                        <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                            <xsl:attribute name="Key">
                                <xsl:value-of select="@Device" />
                            </xsl:attribute>
                            <xsl:attribute name="Content">
                                <xsl:value-of select="@MountPoint" />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>
        <xsl:if test="mars:FileSystemInformation/*[@MountOptions]">
            <xsl:element name="FilesystemMountOptions" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:for-each select="mars:FileSystemInformation">
                    <xsl:for-each select="*">
                        <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                            <xsl:attribute name="Key">
                                <xsl:value-of select="@Device" />
                            </xsl:attribute>
                            <xsl:attribute name="Content">
                                <xsl:value-of select="@MountOptions" />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>
        <xsl:if test="mars:FileSystemInformation/*[@Type]">
            <xsl:element name="FilesystemType" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:for-each select="mars:FileSystemInformation">
                    <xsl:for-each select="*">
                        <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                            <xsl:attribute name="Key">
                                <xsl:value-of select="@Device" />
                            </xsl:attribute>
                            <xsl:attribute name="Content">
                                <xsl:value-of select="@Type" />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>
        <xsl:if test="mars:FileSystemInformation/*[@SpaceUnit]">
            <xsl:element name="FilesystemSpaceUnit" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:for-each select="mars:FileSystemInformation">
                    <xsl:for-each select="*">
                        <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                            <xsl:attribute name="Key">
                                <xsl:value-of select="@Device" />
                            </xsl:attribute>
                            <xsl:attribute name="Content">
                                <xsl:value-of select="@SpaceUnit" />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>
        <xsl:if test="mars:FileSystemInformation/*[@SpaceTotal]">
            <xsl:element name="FilesystemSpaceTotal" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:for-each select="mars:FileSystemInformation">
                    <xsl:for-each select="*">
                        <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                            <xsl:attribute name="Key">
                                <xsl:value-of select="@Device" />
                            </xsl:attribute>
                            <xsl:attribute name="Content">
                                <xsl:value-of select="@SpaceTotal" />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>
    </xsl:template>

    <xsl:template match="mars:NetworkInformation">
        <xsl:element name="NetworkInterface" namespace="https://graphit.co/schemas/v2/MARSSchema">
            <xsl:for-each select="mars:InterfaceInformation">
                <xsl:for-each select="*">
                    <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                        <xsl:attribute name="Content">
                            <xsl:value-of select="@Name" />
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
            </xsl:for-each>
        </xsl:element>
        
        <xsl:if test="mars:InterfaceInformation/*[@MAC]">
            <xsl:element name="NetworkInterfaceMAC" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:for-each select="mars:InterfaceInformation/*[@MAC]">
                    <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                        <xsl:attribute name="Key">
                            <xsl:value-of select="@Name" />
                        </xsl:attribute>
                        <xsl:attribute name="Content">
                            <xsl:value-of select="@MAC" />
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>
        
        <xsl:if test="mars:InterfaceInformation/*[@IP|@IPv6]">
            <xsl:element name="NetworkInterfaceIP" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:for-each select="mars:InterfaceInformation">
                    <xsl:for-each select="*">
                        <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                            <xsl:attribute name="Key">
                                <xsl:value-of select="@Name" />
                            </xsl:attribute>
                            <xsl:if test="@IP">
                                <xsl:attribute name="Content">
                                    <xsl:value-of select="@IP" />
                                </xsl:attribute>
                            </xsl:if>
                            <xsl:if test="@IPv6">
                                <xsl:attribute name="Content">
                                    <xsl:value-of select="@IPv6" />
                                </xsl:attribute>
                            </xsl:if>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>
        
        <xsl:if test="mars:InterfaceInformation/*[@Netmask]">
            <xsl:element name="NetworkInterfaceNetmask" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:for-each select="mars:InterfaceInformation/*[@Netmask]">
                    <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                        <xsl:attribute name="Key">
                            <xsl:value-of select="@Name" />
                        </xsl:attribute>
                        <xsl:attribute name="Content">
                            <xsl:value-of select="@Netmask" />
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>
        
        <xsl:if test="mars:InterfaceInformation/*">
            <xsl:element name="NetworkInterfaceType" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:for-each select="mars:InterfaceInformation/*">
                    <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                        <xsl:attribute name="Key">
                            <xsl:value-of select="@Name" />
                        </xsl:attribute>
                        <xsl:attribute name="Content">
                            <xsl:value-of select="name(.)" />
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>

        <xsl:if test="mars:InterfaceInformation/*[@PrefixLength]">
            <xsl:element name="NetworkInterfacePrefixLength" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:for-each select="mars:InterfaceInformation/*[@PrefixLength]">
                    <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                        <xsl:attribute name="Key">
                            <xsl:value-of select="@Name" />
                        </xsl:attribute>
                        <xsl:attribute name="Content">
                            <xsl:value-of select="@PrefixLength" />
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        </xsl:if>
        
        <xsl:if test="mars:RoutingInformation/mars:Routes">
            <xsl:element name="Route" namespace="https://graphit.co/schemas/v2/MARSSchema">
                <xsl:for-each select="mars:RoutingInformation/mars:Routes">
                    <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                        <xsl:attribute name="Content">
                            <xsl:value-of select="concat(@Destination,':',@Gateway)" />
                        </xsl:attribute>
                    </xsl:element>
                </xsl:for-each>
            </xsl:element>
        
            <xsl:if test="mars:RoutingInformation/mars:Routes[@Netmask]">
                <xsl:element name="RouteNetmask" namespace="https://graphit.co/schemas/v2/MARSSchema">
                    <xsl:for-each select="mars:RoutingInformation/mars:Routes[@Netmask]">
                        <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                            <xsl:attribute name="Key">
                                <xsl:value-of select="concat(@Destination,':',@Gateway)" />
                            </xsl:attribute>
                            <xsl:attribute name="Content">
                                <xsl:value-of select="@Netmask" />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:if>
            <xsl:if test="mars:RoutingInformation/mars:Routes[@Interface]">
                <xsl:element name="RouteInterface" namespace="https://graphit.co/schemas/v2/MARSSchema">
                    <xsl:for-each select="mars:RoutingInformation/mars:Routes[@Interface]">
                        <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                            <xsl:attribute name="Key">
                                <xsl:value-of select="concat(@Destination,':',@Gateway)" />
                            </xsl:attribute>
                            <xsl:attribute name="Content">
                                <xsl:value-of select="@Interface" />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:if>
            <xsl:if test="mars:RoutingInformation/mars:Routes[@Destination]">
                <xsl:element name="RouteDestination" namespace="https://graphit.co/schemas/v2/MARSSchema">
                    <xsl:for-each select="mars:RoutingInformation/mars:Routes[@Gateway]">
                        <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                            <xsl:attribute name="Key">
                                <xsl:value-of select="concat(@Destination,':',@Gateway)" />
                            </xsl:attribute>
                            <xsl:attribute name="Content">
                                <xsl:value-of select="@Destination" />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:if>
            <xsl:if test="mars:RoutingInformation/mars:Routes[@Gateway]">
                <xsl:element name="RouteGateway" namespace="https://graphit.co/schemas/v2/MARSSchema">
                    <xsl:for-each select="mars:RoutingInformation/mars:Routes[@Gateway]">
                        <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                            <xsl:attribute name="Key">
                                <xsl:value-of select="concat(@Destination,':',@Gateway)" />
                            </xsl:attribute>
                            <xsl:attribute name="Content">
                                <xsl:value-of select="@Gateway" />
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:for-each>
                </xsl:element>
            </xsl:if>
        </xsl:if>
        
    </xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>

    <!--############################################################-->
    <!--## Template to tokenize strings                           ##-->
    <!--############################################################-->

    <xsl:template name="tokenizeString">
        <!--passed template parameter -->
        <xsl:param name="list"/>
        <xsl:param name="delimiter"/>
        <xsl:choose>
            <xsl:when test="contains($list, $delimiter)">               
                <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                    <xsl:attribute name="Content">
                        <xsl:value-of select="substring-before($list,$delimiter)"/>
                    </xsl:attribute>
                </xsl:element>
                <xsl:call-template name="tokenizeString">
                    <!-- store anything left in another variable -->
                    <xsl:with-param name="list" select="substring-after($list,$delimiter)"/>
                    <xsl:with-param name="delimiter" select="$delimiter"/>
                </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
                <xsl:choose>
                    <xsl:when test="$list = ''">
                        <xsl:text/>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:element name="Value" namespace="https://graphit.co/schemas/v2/MARSSchema">
                            <xsl:attribute name="Content">
                                <xsl:value-of select="$list"/>
                            </xsl:attribute>
                        </xsl:element>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>  

</xsl:stylesheet>

