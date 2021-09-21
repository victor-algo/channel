//+-----------------------------------------------------------------------+
//|                                                           Pattern.mq5 |
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

#include <Trade\Trade.mqh>
#include <VictorAlgo\Pattern\Pattern.mqh>
#include <VictorAlgo\Pattern\Utils.mqh>

input group "PATTERN";

input int SCAN_PERIOD_SIZE = 20;
input int NB_SCAN_PERIOD = 4;
input double EPSILON = 0.1;

input group "STRATEGY";

input group "ASCENDING TRIANGLE";
input bool AT_BUY = true;
input bool AT_SELL = true;

input group "DESCENDING TRIANGLE";
input bool DT_BUY = true;
input bool DT_SELL = true;

input group "RECTANGLE";
input bool RE_BUY = true;
input bool RE_SELL = true;

input group "FALLING WEDGE";
input bool FW_BUY = true;
input bool FW_SELL = true;

input group "RISING WEDGE";
input bool RW_BUY = true;
input bool RW_SELL = true;

input group "TRADE";
input double TRAILING_STOP = 1.0;
input double VOLUME = 0.1;


void OnTick(){

   int posTotal = getSymbolPositionTotal(_Symbol);
   
   if(posTotal < 1 && !symbolIsAlreadyTrade(_Symbol, _Period, 1)) open(_Symbol, _Period);
   if(posTotal > 0) updateStoploss(_Symbol, _Period);
   
}


void open(string symbolName, ENUM_TIMEFRAMES timeframe){

   int signal = getPatternSignal(symbolName, timeframe);
   double ask = SymbolInfoDouble(symbolName, SYMBOL_ASK);
   double bid = SymbolInfoDouble(symbolName, SYMBOL_BID);
   CTrade trade;
   
   if(signal == 1) trade.Buy(VOLUME, symbolName, ask, ask * (1.0 - TRAILING_STOP / 100.0));
   if(signal == 2) trade.Sell(VOLUME, symbolName, bid, bid * (1.0 + TRAILING_STOP / 100.0));

}


void updateStoploss(string symbolName, ENUM_TIMEFRAMES timeframe){

   ulong ticket = getLastTicket(symbolName);
   double point = SymbolInfoDouble(symbolName, SYMBOL_POINT);
   double ask = SymbolInfoDouble(symbolName, SYMBOL_ASK);
   double bid = SymbolInfoDouble(symbolName, SYMBOL_BID);
   CTrade trade;
   
   if(PositionSelectByTicket(ticket)){
   
      if(PositionGetInteger(POSITION_TYPE) == 0){
         
         if(PositionGetDouble(POSITION_SL) + point < ask * (1.0 - TRAILING_STOP / 100.0))
            trade.PositionModify(ticket, ask * (1.0 - TRAILING_STOP / 100.0), PositionGetDouble(POSITION_TP));
      
      }
      else{
  
         if(PositionGetDouble(POSITION_SL) - point > bid * (1.0 + TRAILING_STOP / 100.0))
            trade.PositionModify(ticket, bid * (1.0 + TRAILING_STOP / 100.0), PositionGetDouble(POSITION_TP));

      }
   }
}


int getPatternSignal(string symbolName, ENUM_TIMEFRAMES timeframe){

   ENUM_PATTERN pattern = getCurrentPattern(symbolName, timeframe, NB_SCAN_PERIOD, SCAN_PERIOD_SIZE, EPSILON);
   int breakSignal = getPatternBreak(symbolName, timeframe);
   
   if(pattern == ASCENDING_TRIANGLE){
      
      Comment("ASCENDING TRIANGLE");
      if(breakSignal == 1 && AT_BUY) return 1;
      if(breakSignal == 2 && AT_SELL) return 2;
      
   }
   else if(pattern == DESCENDING_TRIANGLE){
      
      Comment("DESCENDING TRIANGLE");
      if(breakSignal == 1 && DT_BUY) return 1;
      if(breakSignal == 2 && DT_SELL) return 2;
      
   }
   else if(pattern == RECTANGLE){
      
      Comment("RECTANGLE");
      if(breakSignal == 1 && RE_BUY) return 1;
      if(breakSignal == 2 && RE_SELL) return 2;
      
   }
   else if(pattern == FALLING_WEDGE){
   
      Comment("FALLING WEDGE");
      if(breakSignal == 1 && FW_BUY) return 1;
      if(breakSignal == 2 && FW_SELL) return 2;
      
   }
   else if(pattern == RISING_WEDGE){
      
      Comment("RISING WEDGE");
      if(breakSignal == 1 && RW_BUY) return 1;
      if(breakSignal == 2 && RW_SELL) return 2;
      
   }
   else if(pattern == UNKNOWN){
      
      Comment("UNKNOWN");
      
   }
   
   return 0;

}


int getPatternBreak(string symbolName, ENUM_TIMEFRAMES timeframe){

   double highPoint = 0.0;
   double lowPoint = 0.0;
   MqlRates rates[];
   
   ArraySetAsSeries(rates, true);
   
   if(getHighLinePoint(symbolName, timeframe, NB_SCAN_PERIOD, SCAN_PERIOD_SIZE, (double)TimeCurrent(), highPoint) &&
      getLowLinePoint(symbolName, timeframe, NB_SCAN_PERIOD, SCAN_PERIOD_SIZE, (double)TimeCurrent(), lowPoint) &&
      CopyRates(symbolName, timeframe, 0, 1, rates) == 1){

        if(rates[0].open < highPoint && highPoint < rates[0].close) return 1;
        else if(rates[0].open > lowPoint && lowPoint > rates[0].close) return 2;   

   }
   
   return 0;
   
}