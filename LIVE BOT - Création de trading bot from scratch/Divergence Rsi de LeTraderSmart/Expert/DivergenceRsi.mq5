//+-----------------------------------------------------------------------+
//|                                                     DivergenceRsi.mq5 |
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

#include <VictorAlgo\DivergenceRsi\Signal.mqh>
#include <VictorAlgo\DivergenceRsi\Utils.mqh>
#include <Trade\Trade.mqh>

input group "DIVERGENCE RSI";
input int RSI_MA_PERIOD = 14;
input int MIN_CANDLE_SIZE = 20;
input int MAX_CANDLE_SIZE = 100;
input bool DRAW = true;

input group "SIGNAL";
input double BUY_RSI = 30.0;
input double SELL_RSI = 70.0;

input group "TRADE";
input double VOLUME = 0.1;
input double TRAILING_STOP = 1.0;

void OnTick(){

   int posTotal = getSymbolPositionTotal(_Symbol);
   
   if(posTotal < 1 && !symbolIsAlreadyTrade(_Symbol, _Period, 1)) open(_Symbol, _Period);
   if(posTotal > 0) updateStoploss(_Symbol);
   
}

void open(string symbolName, ENUM_TIMEFRAMES timeframe){

   int signal = getSignal(symbolName, timeframe, RSI_MA_PERIOD, MIN_CANDLE_SIZE, MAX_CANDLE_SIZE, BUY_RSI, SELL_RSI, DRAW);
   double ask = SymbolInfoDouble(symbolName, SYMBOL_ASK);
   double bid = SymbolInfoDouble(symbolName, SYMBOL_BID);
   CTrade trade;

   if(signal == 1)
         trade.Buy(VOLUME, symbolName, ask, ask * (1.0 - TRAILING_STOP / 100.0));
         
   if(signal == 2)
         trade.Sell(VOLUME, symbolName, bid, bid * (1.0 + TRAILING_STOP / 100.0));
}

void updateStoploss(string symbolName){

   double point = SymbolInfoDouble(symbolName, SYMBOL_POINT);
   ulong tickets[];
   CTrade trade;
   
   getSymbolTickets(symbolName, tickets);
   
   for(int i = 0; i < ArraySize(tickets); i += 1){
   
      if(PositionSelectByTicket(tickets[i])){
      
         if(PositionGetInteger(POSITION_TYPE) == 0){
            
            if(PositionGetDouble(POSITION_SL) + point < PositionGetDouble(POSITION_PRICE_CURRENT) * (1.0 - TRAILING_STOP / 100.0))
               trade.PositionModify(tickets[i], PositionGetDouble(POSITION_PRICE_CURRENT) * (1.0 - TRAILING_STOP / 100.0), PositionGetDouble(POSITION_TP));
         
         }
         else{
     
            if(PositionGetDouble(POSITION_SL) - point > PositionGetDouble(POSITION_PRICE_CURRENT) * (1.0 + TRAILING_STOP / 100.0))
               trade.PositionModify(tickets[i], PositionGetDouble(POSITION_PRICE_CURRENT) * (1.0 + TRAILING_STOP / 100.0), PositionGetDouble(POSITION_TP));
   
         }
      }
   }
}