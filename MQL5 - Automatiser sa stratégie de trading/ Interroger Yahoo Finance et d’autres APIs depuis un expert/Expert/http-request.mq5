//+----------------------------------------------------------------------------------+
//|                                                                  http-request.mq5|
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

input string API_KEY = "";
input string API_URL = "apidojo-yahoo-finance-v1.p.rapidapi.com";
input string SYMBOL = "TSLA";
input string REGION = "US";

string BASE_URL = "https://apidojo-yahoo-finance-v1.p.rapidapi.com/stock/v2/get-financials";
string PARAM_PATTERN = "?symbol=%s&region=%s";
string HEADER_PATTERN = "x-rapidapi-key:%s\r\nx-rapidapi-host:%s\r\n";

void OnInit(){

   string url = BASE_URL + StringFormat(PARAM_PATTERN, SYMBOL, REGION);
   string header = StringFormat(HEADER_PATTERN, API_KEY, API_URL);

   int fileHandle = FileOpen(SYMBOL + "_" + REGION + ".json", FILE_WRITE|FILE_BIN|FILE_COMMON);

   char data[];
   char result[];
   string resultHeader;
   
   int res = WebRequest("GET", url, header, 0, data, result, resultHeader);
   
   if(res != -1){
     
      if(fileHandle != INVALID_HANDLE){
     
         FileWriteArray(fileHandle, result, 0, ArraySize(result));
         FileClose(fileHandle);
     
      }
     
      Print("Requête terminée.");
     
   }
   else{
     
      Print("Requête érronée.");
   
   }
}