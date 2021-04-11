//+-----------------------------------------------------------------------+
//|                                           Ichimoku Kumo Break Out.mq5 |
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

#include <Trade\Trade.mqh>
#include <VictorAlgo\IchimokuKumoBO\Utils.mqh>
#include <VictorAlgo\IchimokuKumoBO\Signal.mqh>

input ENUM_TIMEFRAMES TIMEFRAME = PERIOD_D1;
input double LOT = 0.1;
input double STOPLOSS = 3.0;

void OnTick(){
   
   int posTotal = getSymbolPositionTotal(_Symbol);

   if(posTotal < 1 && !symbolIsAlreadyTrade(_Symbol, TIMEFRAME, 1)){
      
      open(_Symbol);

   }
   else if(posTotal > 0){
       
      close(_Symbol);
      
   }
}

void open(string symbolName){

   CTrade trade;
   int signal = getKumoOpenSignal(symbolName, TIMEFRAME);
   double ask =  SymbolInfoDouble(symbolName, SYMBOL_ASK);
   double bid = SymbolInfoDouble(symbolName, SYMBOL_BID);
   
   if(signal == 1){
      
      trade.Buy(LOT, symbolName, ask, ask * (1.0 - STOPLOSS / 100.0));
      
   }
   else if(signal == 2){
   
      trade.Sell(LOT, symbolName, bid, bid * (1.0 + STOPLOSS / 100.0));
      
   }
}


void close(string symbolName){

   CTrade trade;
   
   if(PositionSelectByTicket(getLastTicket(symbolName))){
   
      if(getKumoCloseSignal(symbolName, TIMEFRAME, (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE)) == 1) trade.PositionClose(PositionGetInteger(POSITION_TICKET));
   
   }
}