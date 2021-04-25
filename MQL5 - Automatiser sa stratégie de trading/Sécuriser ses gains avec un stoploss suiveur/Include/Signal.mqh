//+-----------------------------------------------------------------------+
//|                                                            Signal.mqh |
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+


int getKumoOpenSignal(string symbolName, ENUM_TIMEFRAMES timeframe){

   double senkouSpanA[];
   double senkouSpanB[];
   MqlRates rates[];
   
   ArraySetAsSeries(senkouSpanA, true);
   ArraySetAsSeries(senkouSpanB, true);
   ArraySetAsSeries(rates, true);
      
   int iichimoku = iIchimoku(symbolName, timeframe, 9, 26, 52);
   
   if(CopyBuffer(iichimoku, 2, 0, 3, senkouSpanA) == 3 &&
      CopyBuffer(iichimoku, 3, 0, 3, senkouSpanB) == 3 &&
      CopyRates(symbolName, timeframe, 0, 3, rates) == 3){
      
      if(senkouSpanA[1] > senkouSpanB[1] && senkouSpanA[2] > senkouSpanB[2]){
         
         if(rates[2].low < senkouSpanA[2] && rates[1].low > senkouSpanA[1]) return 1;
         if(rates[2].high > senkouSpanB[2] && rates[1].high < senkouSpanB[1]) return 2;
         
      }
      else if(senkouSpanB[1] > senkouSpanA[1] && senkouSpanB[2] > senkouSpanA[2]){
      
         if(rates[2].low < senkouSpanB[2] && rates[1].low > senkouSpanB[1]) return 1;
         if(rates[2].high > senkouSpanA[2] && rates[1].high < senkouSpanA[1]) return 2;
      
      }
   }
   
   return 0;

}


int getKumoCloseSignal(string symbolName, ENUM_TIMEFRAMES timeframe, ENUM_POSITION_TYPE type){

   double senkouSpanA[];
   double senkouSpanB[];
   MqlRates rates[];
   
   ArraySetAsSeries(senkouSpanA, true);
   ArraySetAsSeries(senkouSpanB, true);
   ArraySetAsSeries(rates, true);
      
   int iichimoku = iIchimoku(symbolName, timeframe, 9, 26, 52);
   
   if(CopyBuffer(iichimoku, 2, 0, 1, senkouSpanA) == 1 &&
      CopyBuffer(iichimoku, 3, 0, 1, senkouSpanB) == 1 &&
      CopyRates(symbolName, timeframe, 0, 1, rates) == 1){
      
         if(senkouSpanA[0] > senkouSpanB[0]){
            
            if(type == POSITION_TYPE_BUY && rates[0].low < senkouSpanB[0]) return 1;
            if(type == POSITION_TYPE_SELL && rates[0].high > senkouSpanA[0]) return 1;
            
         }
         else if(senkouSpanB[0] > senkouSpanA[0]){
         
            if(type == POSITION_TYPE_BUY && rates[0].low < senkouSpanA[0]) return 1;
            if(type == POSITION_TYPE_SELL && rates[0].high > senkouSpanB[0]) return 1;
         
         }
      }

   return 0;

}