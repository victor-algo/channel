//+----------------------------------------------------------------------------------+
//|                                                                     indicator.mq5|
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

void OnTick(){

   Print("RSI: " + (string)getRsi());
   
   double bollingerBands[];
   setBollingerBands(bollingerBands);
   
   Print("Middle Bollinger Bands: " + (string)bollingerBands[0]);
   Print("Upper Bollinger Bands: " + (string)bollingerBands[1]); 
   Print("Lower Bollinger Bands: " + (string)bollingerBands[2]);
   
}

double getRsi(){

   double rsiBuffer[];
   
   ArraySetAsSeries(rsiBuffer, true);
   
   int rsi = iRSI(_Symbol, _Period, 20, PRICE_CLOSE);
   
   if(CopyBuffer(rsi, 0, 0, 1, rsiBuffer) > 0) { return rsiBuffer[0]; }
   
   return -1.0;

}

void setBollingerBands(double& array[]){
   
   ArrayResize(array, 3);
   
   double middleBuffer[];
   double upperBuffer[];
   double lowerBuffer[];
   
   ArraySetAsSeries(middleBuffer, true);
   ArraySetAsSeries(upperBuffer, true);
   ArraySetAsSeries(lowerBuffer, true);
   
   int iBolBands = iBands(_Symbol, _Period, 20, 0, 2, PRICE_CLOSE);
   
   if(CopyBuffer(iBolBands, 0, 0, 1, middleBuffer) > 0 &&
      CopyBuffer(iBolBands, 1, 0, 1, upperBuffer) > 0 && 
      CopyBuffer(iBolBands, 2, 0, 1, lowerBuffer) > 0){

         array[0] = middleBuffer[0];
         array[1] = upperBuffer[0];
         array[2] = lowerBuffer[0];      
      
   }
   else{
         array[0] = -1.0;
         array[1] = -1.0;
         array[2] = -1.0; 
   }
}