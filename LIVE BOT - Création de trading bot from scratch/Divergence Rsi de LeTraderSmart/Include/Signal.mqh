//+-----------------------------------------------------------------------+
//|                                                            Signal.mqh |
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

int getSignal(string symbolName, ENUM_TIMEFRAMES timeframe, int rsiPeriod, int minCandleSize, int maxCandleSize, double buyRsi, double sellRsi, bool draw){
   
   int signal = 0;
   int index = 0;
   MqlRates rates[];
   double rsis[];
   
   ArraySetAsSeries(rates, true);
   ArraySetAsSeries(rsis, true);
   
   int irsi = iRSI(symbolName, timeframe, rsiPeriod, PRICE_CLOSE);
   
   if(CopyRates(symbolName, timeframe, 1, minCandleSize + maxCandleSize, rates) == minCandleSize + maxCandleSize &&
      CopyBuffer(irsi, 0, 1, minCandleSize + maxCandleSize, rsis) ==  minCandleSize + maxCandleSize){
     
      divergenceRsi(rates, rsis, minCandleSize, buyRsi, sellRsi, signal, index);
      
      if(signal == 1 && draw) drawDivergence(symbolName, timeframe, signal, rates[1].time, rates[index].time, rates[1].low, rates[index].low, rsis[1], rsis[index]);
      if(signal == 2 && draw) drawDivergence(symbolName, timeframe, signal, rates[1].time, rates[index].time, rates[1].high, rates[index].high, rsis[1], rsis[index]);
      
      if(signal == 1 && rates[0].close < rates[0].open) signal = 0;
      if(signal == 2 && rates[0].close > rates[0].open) signal = 0;
      
   }
   
   return signal;
   
}

void divergenceRsi(MqlRates& rates[], double& rsis[], int minCandleSize, double buyRsi, double sellRsi, int& signal, int& index){
   
   signal = 0;
   index = 0;
   
   if(rates[1].low < rates[2].low && rates[1].low < rates[0].low)
      if(rsis[1] < rsis[2] && rsis[1] < rsis[0] && rsis[1] < buyRsi)
         for(int i = 4 + minCandleSize; i < ArraySize(rsis) - 1; i += 1)
             if(rates[i].low < rates[i + 1].low && rates[i].low < rates[i - 1].low)
                  if(rsis[i] < rsis[i + 1] && rsis[i] < rsis[i - 1] && rsis[i] < buyRsi)
                     if(rsis[i] < rsis[1] && rates[i].low > rates[1].low){
                  
                        signal = 1;
                        index = i;

                      }
                  
                  
   if(rates[1].high > rates[2].high && rates[1].high > rates[0].high)
      if(rsis[1] > rsis[2] && rsis[1] > rsis[0] && rsis[1] > sellRsi)
         for(int i = 4 + minCandleSize; i < ArraySize(rsis) - 1; i += 1)
             if(rates[i].high > rates[i + 1].high && rates[i].high > rates[i - 1].high)
                  if(rsis[i] > rsis[i + 1] && rsis[i] > rsis[i - 1] && rsis[i] > sellRsi)
                     if(rsis[i] > rsis[1] && rates[i].high < rates[1].high){
                  
                        signal = 2;
                        index = i;

                      }
                  
}

void drawDivergence(string symbolName, ENUM_TIMEFRAMES timeframe, int type, datetime time0, datetime time1, double price0, double price1, double rsi0, double rsi1){
   
   color divColor = clrTurquoise;
   if(type == 2) divColor = clrRed;
   
   ObjectCreate(0, "_price_" + (string)time0, OBJ_TREND, 0, time0, price0, time1, price1);
   ObjectCreate(0, "_rsi_" + (string)time0, OBJ_TREND, 1, time0, rsi0, time1, rsi1);
   ObjectCreate(0, "_right_price_" + (string)time0, OBJ_VLINE, 0, time0, 0);
   ObjectCreate(0, "_left_price_" + (string)time1, OBJ_VLINE, 0, time1, 0);

   ObjectSetInteger(0, "_price_" + (string)time0, OBJPROP_COLOR, divColor);
   ObjectSetInteger(0, "_rsi_" + (string)time0, OBJPROP_COLOR, divColor);
   ObjectSetInteger(0, "_right_price_" + (string)time0, OBJPROP_COLOR, divColor);
   ObjectSetInteger(0, "_left_price_" + (string)time1, OBJPROP_COLOR, divColor);
   
   ObjectSetInteger(0, "_right_price_" + (string)time0, OBJPROP_STYLE, STYLE_DOT);
   ObjectSetInteger(0, "_left_price_" + (string)time1, OBJPROP_STYLE, STYLE_DOT);
    
}