//+-----------------------------------------------------------------------+
//|                                                             Signal.mqh|
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

int getOpenSignal(string symbolName, ENUM_TIMEFRAMES timeframe, double minGapSize, int maPeriod){

   double ma[];
   MqlRates rates[];
   double gap = 0.0;
   
   ArraySetAsSeries(ma, true);
   ArraySetAsSeries(rates, true);
   
   int ima = iMA(symbolName, timeframe, maPeriod, 0, MODE_SMA, PRICE_CLOSE);
   
   if(CopyBuffer(ima, 0, 1, 1, ma) == 1 && CopyRates(symbolName, timeframe, 1, 2, rates) == 2){
   
      gap = (rates[0].open - rates[1].close) / rates[1].close * 100.0;
      
      if(gap < minGapSize * -1.0 && rates[0].close > rates[0].open && rates[0].close > ma[0]) return 1;
      if(gap > minGapSize && rates[0].close < rates[0].open && rates[0].close < ma[0]) return 2;
      
   }

   return 0;

}

double getAtr(string symbolName, ENUM_TIMEFRAMES timeframe, int maPeriod){

   double atr[];
   
   ArraySetAsSeries(atr, true);
   
   int iatr = iATR(symbolName, timeframe, maPeriod);
   
   if(CopyBuffer(iatr, 0, 1, 1, atr) == 1){
   
      return atr[0];
   
   } 

   return 0.0;

}