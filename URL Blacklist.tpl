___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "URL Blacklist",
  "description": "To exclude specified URL-Parameters from URL",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "URL",
    "displayName": "Input URL",
    "simpleValueType": true
  },
  {
    "type": "TEXT",
    "name": "urlBlacklist",
    "displayName": "Terms to exclude",
    "simpleValueType": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

// written by Moritz Bauer
// Enter your template code here.
const log = require('logToConsole');
const getUrl = require("getUrl");




const checkBlacklist = data.urlBlacklist;
var paramBlacklist =[];

paramBlacklist = data.urlBlacklist.split(",");

var customUrl = data.URL;
var page;
var character = "a";
var index = 0;

//Uses Custom URL Variable if Checkbox = true, else getUrl method is used.
if(data.cbUrl!=false){
  page = customUrl;
}
else{
  page = getUrl();
}


var regEx = "=[^&]+"; //name=[^&]+
var regExCH ="[\\?|\\&]$";
var paramList=[];
var matchedQuery;
var matchedChar;

//Construct RegEx for each Blacklist Term and check Page URL for occurences. 
paramBlacklist.forEach(function(entry, index) {
    
    entry = entry.trim();
  
    //Step 1
    paramList[index] = entry+regEx;
    matchedQuery = page.match(paramList[index]);
    page = page.replace(matchedQuery,"");
   
    //Step 2
    page = page.replace("&&","&");
    
    //Step 3
    page = page.replace("?&","?");
   
  
});

//Erase the last Character of the Page if it's ? or &
while(page[index]!==undefined){

  var current = page.charAt(index);
  var next = page.charAt(index+1);
  
  if(next==undefined||next==""){
    if(current == "?"|| current== "&"){
      
      page = page.substring(0,index);
    }
  }
  index++;
}



return page;


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "logging",
        "versionId": "1"
      },
      "param": [
        {
          "key": "environments",
          "value": {
            "type": 1,
            "string": "debug"
          }
        }
      ]
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_url",
        "versionId": "1"
      },
      "param": [
        {
          "key": "urlParts",
          "value": {
            "type": 1,
            "string": "any"
          }
        },
        {
          "key": "queriesAllowed",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 20.10.2022, 20:45:04


