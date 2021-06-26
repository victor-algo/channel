//+-----------------------------------------------------------------------+
//|                                                        GapReversal.mq5|
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

#include <Trade\Trade.mqh>
#include <VictorAlgo\GapReversal\Signal.mqh>
#include <VictorAlgo\GapReversal\Utils.mqh>

input group "STRATEGY"
input double MIN_GAP_SIZE = 1.0;
input int MA_PERIOD = 250;

input group "TRADE"
input bool BUY = true;
input bool SELL = true;

input group "STOP"
input double SL_ATR_MULTIPLIER = 1.0;
input double TP_ATR_MULTIPLIER = 1.0;

input group "VOLUME"
input double LOT = 0.1;

void OnTick(){

   int posTotal = getSymbolPositionTotal(_Symbol);
   
   if(!symbolIsAlreadyTrade(_Symbol, _Period, 1) && posTotal < 1){
      
      open(_Symbol, _Period);
   
   }
   else if(posTotal > 0){
      
      updateStoploss(_Symbol, _Period);
   
   }
}

void open(string symbolName, ENUM_TIMEFRAMES timeframe){
   
   CTrade trade;
   int signal = getOpenSignal(symbolName, timeframe, MIN_GAP_SIZE, MA_PERIOD);
   double ask = SymbolInfoDouble(symbolName, SYMBOL_ASK);
   double bid = SymbolInfoDouble(symbolName, SYMBOL_BID);
   double atr = getAtr(symbolName, timeframe, MA_PERIOD);
   
   if(signal == 1 && BUY){
      
      trade.Buy(LOT, symbolName, ask, ask - SL_ATR_MULTIPLIER * atr, ask + TP_ATR_MULTIPLIER * atr);
   
   }
   else if(signal == 2 && SELL){
      
      trade.Sell(LOT, symbolName, bid, bid + SL_ATR_MULTIPLIER * atr, bid - TP_ATR_MULTIPLIER * atr);
      
   }
}

void updateStoploss(string symbolName, ENUM_TIMEFRAMES timeframe){

   ulong ticket = getLastTicket(symbolName);
   double point = SymbolInfoDouble(symbolName, SYMBOL_POINT);
   double atr = getAtr(symbolName, timeframe, MA_PERIOD);
   CTrade trade;
   MqlRates rates[];
   
   ArraySetAsSeries(rates, true);
   
   if(CopyRates(symbolName, timeframe, 1, 1, rates) == 1){
   
      if(PositionSelectByTicket(ticket)){
      
         if(PositionGetInteger(POSITION_TYPE) == 0){
            
            if(PositionGetDouble(POSITION_SL) + point < rates[0].close - SL_ATR_MULTIPLIER * atr) 
               trade.PositionModify(ticket, rates[0].close - SL_ATR_MULTIPLIER * atr, PositionGetDouble(POSITION_TP));
         
         }
         else{
     
            if(PositionGetDouble(POSITION_SL) - point > rates[0].close + SL_ATR_MULTIPLIER * atr)
               trade.PositionModify(ticket, rates[0].close + SL_ATR_MULTIPLIER * atr, PositionGetDouble(POSITION_TP));
   
         }
      }
   }
}