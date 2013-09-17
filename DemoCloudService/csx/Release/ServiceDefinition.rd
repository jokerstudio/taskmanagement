<?xml version="1.0" encoding="utf-8"?>
<serviceModel xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" name="DemoCloudService" generation="1" functional="0" release="0" Id="7197cf9b-eeea-425f-89b4-906bc6cd6476" dslVersion="1.2.0.0" xmlns="http://schemas.microsoft.com/dsltools/RDSM">
  <groups>
    <group name="DemoCloudServiceGroup" generation="1" functional="0" release="0">
      <componentports>
        <inPort name="MyWebrole:Endpoint1" protocol="http">
          <inToChannel>
            <lBChannelMoniker name="/DemoCloudService/DemoCloudServiceGroup/LB:MyWebrole:Endpoint1" />
          </inToChannel>
        </inPort>
      </componentports>
      <settings>
        <aCS name="MyWebrole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="">
          <maps>
            <mapMoniker name="/DemoCloudService/DemoCloudServiceGroup/MapMyWebrole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </maps>
        </aCS>
        <aCS name="MyWebroleInstances" defaultValue="[1,1,1]">
          <maps>
            <mapMoniker name="/DemoCloudService/DemoCloudServiceGroup/MapMyWebroleInstances" />
          </maps>
        </aCS>
      </settings>
      <channels>
        <lBChannel name="LB:MyWebrole:Endpoint1">
          <toPorts>
            <inPortMoniker name="/DemoCloudService/DemoCloudServiceGroup/MyWebrole/Endpoint1" />
          </toPorts>
        </lBChannel>
      </channels>
      <maps>
        <map name="MapMyWebrole:Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" kind="Identity">
          <setting>
            <aCSMoniker name="/DemoCloudService/DemoCloudServiceGroup/MyWebrole/Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" />
          </setting>
        </map>
        <map name="MapMyWebroleInstances" kind="Identity">
          <setting>
            <sCSPolicyIDMoniker name="/DemoCloudService/DemoCloudServiceGroup/MyWebroleInstances" />
          </setting>
        </map>
      </maps>
      <components>
        <groupHascomponents>
          <role name="MyWebrole" generation="1" functional="0" release="0" software="C:\taskmanagement\DemoCloudService\csx\Release\roles\MyWebrole" entryPoint="base\x64\WaHostBootstrapper.exe" parameters="base\x64\WaIISHost.exe " memIndex="1792" hostingEnvironment="frontendadmin" hostingEnvironmentVersion="2">
            <componentports>
              <inPort name="Endpoint1" protocol="http" portRanges="80" />
            </componentports>
            <settings>
              <aCS name="Microsoft.WindowsAzure.Plugins.Diagnostics.ConnectionString" defaultValue="" />
              <aCS name="__ModelData" defaultValue="&lt;m role=&quot;MyWebrole&quot; xmlns=&quot;urn:azure:m:v1&quot;&gt;&lt;r name=&quot;MyWebrole&quot;&gt;&lt;e name=&quot;Endpoint1&quot; /&gt;&lt;/r&gt;&lt;/m&gt;" />
            </settings>
            <resourcereferences>
              <resourceReference name="DiagnosticStore" defaultAmount="[4096,4096,4096]" defaultSticky="true" kind="Directory" />
              <resourceReference name="EventStore" defaultAmount="[1000,1000,1000]" defaultSticky="false" kind="LogStore" />
            </resourcereferences>
          </role>
          <sCSPolicy>
            <sCSPolicyIDMoniker name="/DemoCloudService/DemoCloudServiceGroup/MyWebroleInstances" />
            <sCSPolicyUpdateDomainMoniker name="/DemoCloudService/DemoCloudServiceGroup/MyWebroleUpgradeDomains" />
            <sCSPolicyFaultDomainMoniker name="/DemoCloudService/DemoCloudServiceGroup/MyWebroleFaultDomains" />
          </sCSPolicy>
        </groupHascomponents>
      </components>
      <sCSPolicy>
        <sCSPolicyUpdateDomain name="MyWebroleUpgradeDomains" defaultPolicy="[5,5,5]" />
        <sCSPolicyFaultDomain name="MyWebroleFaultDomains" defaultPolicy="[2,2,2]" />
        <sCSPolicyID name="MyWebroleInstances" defaultPolicy="[1,1,1]" />
      </sCSPolicy>
    </group>
  </groups>
  <implements>
    <implementation Id="6da1ad50-7c44-43d7-af07-bc6ac9995af9" ref="Microsoft.RedDog.Contract\ServiceContract\DemoCloudServiceContract@ServiceDefinition">
      <interfacereferences>
        <interfaceReference Id="9415bd8f-be4b-4e04-a663-a0e433fe7a74" ref="Microsoft.RedDog.Contract\Interface\MyWebrole:Endpoint1@ServiceDefinition">
          <inPort>
            <inPortMoniker name="/DemoCloudService/DemoCloudServiceGroup/MyWebrole:Endpoint1" />
          </inPort>
        </interfaceReference>
      </interfacereferences>
    </implementation>
  </implements>
</serviceModel>