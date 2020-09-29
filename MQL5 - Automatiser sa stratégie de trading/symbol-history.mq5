//+----------------------------------------------------------------------------------+
//|                                                               symbol-history.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


void OnTick(){

   MqlRates historyBuffer[];
   
   ArraySetAsSeries(historyBuffer, true);
   
   if(CopyRates(_Symbol, _Period, 0, 5, historyBuffer)){
   
      Print("Time: " + (string)historyBuffer[2].time);
      Print("Open: " + (string)historyBuffer[2].open);
      Print("Close: " + (string)historyBuffer[2].close);
      Print("High: " + (string)historyBuffer[2].high);
      Print("Low: " + (string)historyBuffer[2].low);
      Print("Spread: " + (string)historyBuffer[2].spread);
      Print("Tick volume: " + (string)historyBuffer[2].tick_volume);
   
   }

}