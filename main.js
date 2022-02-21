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
