# Get token
$context = Get-AzContext
$userProfile = [Microsoft.Azure.Commands.Common.Authentication.Abstractions.AzureRmProfileProvider]::Instance.Profile
$profileClient = New-Object -TypeName Microsoft.Azure.Commands.ResourceManager.Common.RMProfileClient -ArgumentList ($userProfile)
$token = $profileClient.AcquireAccessToken($context.Subscription.TenantId)

# Set Mandatory parameter
$subscriptionId="12e6b5b1-87o4-4f4e-ac46-d12f87a32099"
$resourcegroupname="Honeypot_ICS"
$NSG_name="HoneyAgent1-nsg"
$NGS_SecurityRuleName="AllowConpot_8800_Inbound"
$baseUrl = "https://management.azure.com/subscriptions/$SubscriptionId" + "/resourceGroups/$resourceGroupName"
$apiVersion = "?api-version=2024-05-01"
$url = $baseUrl + "/providers/Microsoft.Network/networkSecurityGroups/" + $NSG_name + "/securityRules/" + $NGS_SecurityRuleName + $apiVersion

$authHeader = @{
    'Content-Type' = 'application/json' 
    'Authorization' = 'Bearer ' + $token.AccessToken 
    'host'="management.azure.com"
  }
   
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

Invoke-RestMethod -Uri $url -Headers $authHeader -Method PUT -Body $body
