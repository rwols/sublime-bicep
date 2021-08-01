// SYNTAX TEST "Packages/Bicep/Bicep.sublime-syntax"

// COMMENTS

var myVar = 'hi!' // this is a comment
//                ^^^^^^^^^^^^^^^^^^^^ comment.line

/* this 
is a 
multi line comment */
// <- comment.block

// evaluates to "hello!"
var myVar = '''hello!'''

// also evaluates to "hello!" as the first newline is skipped
var myVar2 = '''
hello!'''

// evaluates to "hello!\n" as the final newline is included
var myVar3 = '''
hello!
'''

// evaluates to "  this\n    is\n      indented\n"
var myVar4 = '''
  this
    is
      indented
'''

// evaluates to "comments // are included\n/* because everything is read as-is */\n"
var myVar5 = '''
comments // are included
/* because everything is read as-is */
'''

// evaluates to "interpolation\nis ${blocked}"
// note ${blocked} is part of the string, and is not evaluated as an expression
var myVar6 = '''interpolation
is ${blocked}'''
//^^^^^^^^^^^ - meta.interpolation

// STRINGS

var myVar = 'hi!' /* so is
this */
// <- comment.block
//^^^^^ comment.block

// myVar evaluates to "hello!"
var myVar = 'hello!'
//          ^^^^^^^^ string

// myVar evaluates to "what's up?"
var myVar2 = 'what\'s up?'
//           ^^^^^^^^^^^^^ string
//                ^^ constant.character.escape

// myVar evaluates to "hello steve!"
var name = 'steve'
var myVar3 = 'hello ${name}!'
//                  ^^^^^^^ meta.interpolation

// smiley evaluates to "😁🙂"
var smiley = '😁\u{1F642}'
//             ^^ constant.character.escape

// MULTI-LINE STRINGS

// evaluates to "hello!"
var myVar = '''hello!'''
//          ^^^^^^^^^^^^ string

// also evaluates to "hello!" as the first newline is skipped
var myVar2 = '''
//           ^^^ string
hello!'''
// <- string
//^^^^^^^ string

// evaluates to "hello!\n" as the final newline is included
var myVar3 = '''
//           ^^^ string
hello!
// <- string
'''
// <- string
 // <- string
//^ string

// evaluates to "  this\n    is\n      indented\n"
var myVar4 = '''
//           ^^^ string
  this
    is
      indented
'''
//^ string

// evaluates to "comments // are included\n/* because everything is read as-is */\n"
var myVar5 = '''
comments // are included
//       ^^^^^^^^^^^^^^^ string
/* because everything is read as-is */
// <- string
 // <- string
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ string
'''

// evaluates to "interpolation\nis ${blocked}"
// note ${blocked} is part of the string, and is not evaluated as an expression
myVar6 = '''interpolation
is ${blocked}'''
// ^^^^^^^^^^ - meta.interpolation

// NUMBERS

var myVar = 123
// <- keyword.declaration
//        ^ keyword.operator.assignment
//          ^^^ constant.numeric
var myVar2 = -454
//           ^ keyword.operator.arithmetic
//            ^^^ constant.numeric
var mvVar3 = 0
//           ^ constant.numeric

// BOOLEANS

var myVar = false
//          ^^^^^ constant.language
var myVar2 = true
//           ^^^^ constant.language

// ARRAYS
//
// Note that commas are not required or permitted between array values.

var myArray = [
  //          ^ punctuation.section
  5983
  3923
  -241
]
// <- punctuation.section

var myEmptyArray = [
  //               ^ punctuation.section
]
// <- punctuation.section

var myMixedArray = [
  myVariable
  // <- variable.other
  'hello!'
  // ^^^^^ string
  true
  // <- constant.language
  1255
  // <- constant.numeric
]

// OBJECTS

var myObj = {
  //        ^ punctuation.section
  stringProp: 'hello!'
  //        ^ punctuation.separator
  //          ^^^^^^^^ string
  boolProp: false
  //      ^ punctuation.separator
  numberProp: -464
  //        ^ punctuation.separator
  //          ^ keyword.operator.arithmetic
  //           ^^^ constant.numeric
  objProp: {
  //     ^ punctuation.separator
    nestedString: 'hello nested!'
    // <- meta.mapping meta.mapping meta.mapping.key
    //          ^ punctuation.separator
    //            ^^^^^^^^^^^^^^^ string
  }
  arrayProp: [
  // <- meta.mapping meta.mapping.key
  //         ^ punctuation.section
    1234
    // <- constant.numeric
    3435
    // <- constant.numeric
  ]
  variableProp: myVariable
  //            ^^^^^^^^^^ variable.other
}

var myObjWithSpecialChars = {
  '$special\tchars!': true
  //       ^^ string constant.character.escape
  normalKey: 'val'
}

var name = 'Steve'
var objWithInterpolatedKeys = {
  'Hello ${name}!': 'val'
  //     ^^^^^^^ meta.interpolation
  '${name}': 'val'
  // ^^^^^ meta.interpolation
  '${name == 'Steve' ? 'wibble' : 'wobble'}': 'val'
  // ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ meta.interpolation
  '${guid(name)}': 'val'
  // ^^^^^^^^^^^ meta.interpolation
  // <- punctuation.definition.string.begin
    // <- punctuation.section.interpolation.begin
  //^ punctuation.section.interpolation.begin
  // ^^^^ variable.function
}

var myEmptyObj = {}
//               ^^ meta.mapping

// NULL

var myVar = null
//          ^^^^ constant.language

param replicateGlobally bool

resource myStorageAccount 'Microsoft.Storage/storageAccounts@2017-10-01' = {
// ^^^^^ keyword.declaration
  name: storageAccountName
  location: resourceGroup().location
  properties: {
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        blob: {
          enabled: true
        }
        file: {
          enabled: true
        }
      }
    }
  }
  kind: StorageV2
  sku: {
    name: replicateGlobally ? 'Standard_GRS' : 'Standard_LRS'
  }
}

resource myParent 'My.Rp/parentType@2020-01-01' = {
  name: 'myParent'
  location: 'West US'

  // declares a nested resource inside 'myParent'
  resource myChild 'childType' = {
    //^^^^ meta.mapping.js keyword.declaration.bicep
    name: 'myChild'
    properties: {
      displayName: 'Child Resource'
    }
  }

  // 'myChild' can be referenced inside the body of 'myParent'
  resource mySibling 'childType' = {
    //^^^^ meta.mapping.js keyword.declaration.bicep
    name: 'mySibling'
    properties: {
      displayName: 'Sibling of ${mychild.properties.displayName}'
    }
  }
}

// accessing 'myChild' here requires the resource access operator
output displayName string = myParent::myChild.properties.displayName
//^^^^ keyword.declaration

// array of storage account names
param storageAccounts array
//^^^ keyword.declaration

resource storageAccountResources 'Microsoft.Storage/storageAccounts@2019-06-01' = [for storageName in storageAccounts: {
  //^^^^ keyword.declaration
  //                                                                              ^ punctuation.section
  //                                                                               ^^^ keyword
  name: storageName
  location: resourceGroup().location
  properties: {
    supportsHttpsTrafficOnly: true
    accessTier: 'Hot'
    encryption: {
      keySource: 'Microsoft.Storage'
      services: {
        blob: {
          enabled: true
        }
        file: {
          enabled: true
        }
      }
    }
  }
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
}]

resource parentResources 'Microsoft.Example/examples@2020-06-06' = [for parent in parents: if(parent.enabled) {
  name: parent.name
  properties: {
    children: [for child in parent.children: {
      name: child.name
      setting: child.settingValue
    }]
  }
}]

targetScope = 'subscription'

@batchSize(2)
resource resourceGroups 'Microsoft.Resources/resourceGroups@2020-06-01' = [for i in range(0,10): {
  name: 'my-rg-{i}'
  location: 'eastus'
}]

var nsgNames = [
  'nsg1'
  'nsg2'
  'nsg3'
]

resource nsg 'Microsoft.Network/networkSecurityGroups@2020-06-01' = [for name in nsgNames: {
  name: name
  location: resourceGroup().location
}]

output nsgs array = [for (name, i) in nsgNames: {
  name: nsg[i].name
  resourceId: nsg[i].id
}]

// Input parameters must be specified by the module consumer
param publicIpResourceName string
param publicIpDnsLabel string = '${publicIpResourceName}-${newGuid()}'
param location string = resourceGroup().location
param dynamicAllocation bool

resource publicIp 'Microsoft.Network/publicIPAddresses@2020-06-01' = {
  name: publicIpResourceName
  location: location
  properties: {
    publicIPAllocationMethod: dynamicAllocation ? 'Dynamic' : 'Static'
    dnsSettings: {
      domainNameLabel: publicIpDnsLabel
    }
  }
}

// Set an output which can be accessed by the module consumer
output ipFqdn string = publicIp.properties.dnsSettings.fqdn

param publicIpName string = 'mypublicip'

module publicIp './publicIpAddress.bicep' = {
  name: 'publicIp'
  params: {
    publicIpResourceName: publicIpName
    dynamicAllocation: true
    // Parameters with default values may be omitted.
  }
}

// To reference module outputs
output ipFqdn string = publicIp.outputs.ipFqdn

module publicIp './publicIpAddress.bicep' = {
  name: 'publicIp'
  scope: resourceGroup('someOtherRg') // pass in a scope to a different resourceGroup
  params: {
    publicIpResourceName: publicIpName
    dynamicAllocation: true
  }
}
// Module accepting secure string
@secure()
param myPassword string
@secure()
param mySecondPassword string

param keyVaultName string
param keyVaultSubscription string
param keyVaultResourceGroup string
param secret1Name string
param secret1Version  string
param secret2Name string

resource kv 'Microsoft.KeyVault/vaults@2019-09-01' existing = {
  name: keyVaultName
  scope: resourceGroup(keyVaultSubscription, keyVaultResourceGroup)
}

module secretModule './secretModule.bicep' = {
  name: 'secretModule'  
  params: {
    myPassword: kv.getSecret(secret1Name, secret1Version)
    mySecondPassword: kv.getSecret(secret2Name)
  }
}

@allowed([
  'one'
  'two'
])
param myEnum string

@minLength(3)
@maxLength(24)
param storageAccountName string

@minValue(1)
@maxValue(12)
param month int

@description('There are many like this, but this object is mine.')
param myObject object

@metadata({
  description: 'There are many like this, but this object is mine.'
})
param myObject object

@minLength(3)
// <- meta.annotation.js punctuation.definition.annotation.js
//^^^^^^^^ meta.annotation.js meta.function-call.js variable.function.js
@maxLength(24)
@description('Name of the storage account')
// <- meta.annotation.js punctuation.definition.annotation.js
//^^^^^^^^^^ meta.annotation.js meta.function-call.js variable.function.js
param storageAccountName string = concat(uniqueString(resourceGroup().id), 'sa')

tenant() // returns the tenant scope

managementGroup() // returns the current management group scope (only from managementGroup deployments)
managementGroup(name: string) // returns the scope for a named management group

subscription() // returns the subscription scope for the current deployment (only from subscription & resourceGroup deployments)
subscription(subscriptionId: string) // returns a named subscription scope (only from subscription & resourceGroup deployments)

resourceGroup() // returns the current resource group scope (only from resourceGroup deployments)
resourceGroup(resourceGroupName: string) // returns a named resource group scope (only from subscription & resourceGroup deployments)
resourceGroup(subscriptionId: string, resourceGroupName: string) // returns a named resource group scope (only from subscription & resourceGroup deployments)

// deploy a parent storage account resource
resource storageAcc 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: accountName
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  location: resourceGroup().location
}

// declare a lock resource extending the storage account by supplying the 'scope' property
resource lockResource 'Microsoft.Authorization/locks@2016-09-01' = {
  name: 'DontDelete'
  scope: storageAcc
  properties: {
    level: 'CanNotDelete'
  }
}

// set the target scope for this file
targetScope = 'subscription'

// deploy a resource group to the subscription scope
resource myRg 'Microsoft.Resources/resourceGroups@2020-10-01' = {
  name: 'myRg'
  location: 'West US'
}

// deploy a module to that newly-created resource group
module myMod './path/to/module.bicep' = {
  name: 'myMod'
  scope: myRg
}

param deployZone bool

resource dnsZone 'Microsoft.Network/dnszones@2018-05-01' = if (deployZone) {
  name: 'myZone'
  location: 'global'
}

// this resource will not be deployed by this file, but the declaration provides access to properties on the existing resource.
resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: 'myacc'
}

// the 'stg' symbolic name may now be used to access properties on the storage account.
output blobEndpoint string = stg.properties.primaryEndpoints.blob

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
  name: 'myacc'
  scope: resourceGroup('otherRg')
}

// defaults the API version for listKeys to that of the resource ('2019-06-01')
var primaryKey = stg.listKeys().keys[0].value

// use a custom API version for listKeys
var primaryKey = stg.listKeys('2020-01-01').keys[0].value

// Supply data to the list* function
var someData = {
  foo: 'bar'
}
var primaryKey = stg.listKeys('2020-01-01', someData).keys[0].value
