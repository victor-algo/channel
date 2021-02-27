//+----------------------------------------------------------------------------------+
//|                                                                       HighLow.mq5|
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


void OnTick(){

   double high[];
   double low[];
   
   ArraySetAsSeries(high, true);
   ArraySetAsSeries(low, true);
   
   int ihighlow = iCustom(_Symbol, _Period, "\\Indicators\\HighLow.ex5", 10);
   
   if(CopyBuffer(ihighlow, 0, 0, 1, high) > 0 && CopyBuffer(ihighlow, 1, 0, 1, low) > 0){
      
      Comment(StringFormat("Low: %s, High: %s", (string)low[0], (string)high[0]));
   
   }
}