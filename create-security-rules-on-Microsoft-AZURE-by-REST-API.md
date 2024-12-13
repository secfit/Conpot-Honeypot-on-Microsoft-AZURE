# Create Security Rules and affecting to Network Security Group on AZURE using REST API   

## Steps:
  On this example, we are going to create new security rule `AllowConpot_8800_Inbound` on Network Security Group `HoneyAgent1-nsg` allowing incoming connection to port 8800 from any IP Address.<br>
###  1.  Create Authentication token :
Followed the [authentication creation from the repository](https://github.com/secfit/VM-on-Microsoft-AZURE-by-REST-API/blob/main/azure_account_auth_rest_api.md), keep the similar `token` and `authHeader` values.<br>

###  2.  Set Mandatory parameters : 

  ```powershell
    $baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
    $apiVersion = "?api-version=2024-05-01"
    $url = $baseUrl + "/providers/Microsoft.Network/networkSecurityGroups/" + $NSG_name + "/securityRules/" + $NGS_SecurityRuleName + $apiVersion
   ```
  You should replace the following values : <br>
  ```
    $NSG_name="HoneyAgent1-nsg"
    $subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
    $resourcegroupname="Honeypot_ICS"
    $NGS_SecurityRuleName="AllowConpot_8800_Inbound"
  ```

Destination URL should be  : <br>
`https://management.azure.com/subscriptions/12e6b5b1-87o4-4f4e-ac46-d12f87a32099/resourceGroups/Honeypot_ICS/providers/Microsoft.Network/networkSecurityGroups/HoneyAgent1-nsg/securityRules/AllowConpot_8800_Inbound?api-version=2024-05-01`<br>

###  3.  The body section will be as following :<br>
      For more information about AZURE API options for IP Address creation : [Azure Help](https://learn.microsoft.com/en-us/rest/api/virtualnetwork/inbound-security-rule/create-or-update?view=rest-virtualnetwork-2024-05-01&tabs=HTTP)
      ```powershell
          $body = '{
          	"location": "centralus",
          	"properties": {
          		"protocol": "*",
          		"sourcePortRange": "*",
          		"destinationPortRange": "8800",
          		"sourceAddressPrefix": "*",
          		"destinationAddressPrefix": "*",
          		"access": "Allow",
          		"priority": 310,
          		"direction": "Inbound",
          		"sourcePortRanges": [],
          		"destinationPortRanges": [],
          		"sourceAddressPrefixes": [],
          		"destinationAddressPrefixes": []
          	}
          }'
     ```

###  4.  Call Invoke-RestMethod using PUT request:
     ```powershell
      Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
     ```

#### You can download full Poweshell script [create_ip_address.ps1](create_ip_address.ps1) 
  You should replace the following values : <br>
  ```
  -    $NSG_name
  -    $subscriptionId
  -    $resourcegroupname
  -    $NGS_SecurityRuleName
  ```
