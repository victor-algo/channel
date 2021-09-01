//+-----------------------------------------------------------------------+
//|                                                          ma-cross.mq5 |
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

#include <Trade\Trade.mqh>
#include <VictorAlgo\MaCross\Utils.mqh>

input group "SLOW MA";
input int SLOW_MA_PERIOD = 10;
input int SLOW_MA_SHIFT = 0;
input ENUM_MA_METHOD SLOW_MA_METHOD = MODE_SMA;
input ENUM_APPLIED_PRICE SLOW_MA_PRICE = PRICE_CLOSE;

input group "FAST MA";
input int FAST_MA_PERIOD = 20;
input int FAST_MA_SHIFT = 0;
input ENUM_MA_METHOD FAST_MA_METHOD = MODE_SMA;
input ENUM_APPLIED_PRICE FAST_MA_PRICE = PRICE_CLOSE;

input group "TRADE";
input double LOT = 0.1;
input bool CLOSE_CROSS = true;
input double TRAILING_STOP = 1.0;


void OnTick(){
   
   int posTotal = getSymbolPositionTotal(_Symbol);
   
   if(posTotal < 1 && !symbolIsAlreadyTrade(_Symbol, _Period, 1)){
      
      open(_Symbol, _Period);
   
   }
   else if(posTotal > 0){
      
      if(CLOSE_CROSS) crossClose(_Symbol, _Period);
      updateStoploss(_Symbol, _Period);
   
   }
}


void open(string symbolName, ENUM_TIMEFRAMES timeframe){

   CTrade trade;
   int signal = getCrossSignal(symbolName, timeframe);
   double ask = SymbolInfoDouble(symbolName, SYMBOL_ASK);
   double bid = SymbolInfoDouble(symbolName, SYMBOL_BID);
   
   if(signal == 1) trade.Buy(LOT, symbolName, ask, ask * (1.0 - TRAILING_STOP / 100.0));
   if(signal == 2) trade.Sell(LOT, symbolName, bid, bid * (1.0 + TRAILING_STOP / 100.0));
   
}


void crossClose(string symbolName, ENUM_TIMEFRAMES timeframe){

   CTrade trade;
   ulong ticket = getLastTicket(symbolName);
   int signal = getCrossSignal(symbolName, timeframe);
   
   if(PositionSelectByTicket(ticket)){
      
      if(signal == 2 && PositionGetInteger(POSITION_TYPE) == 0) trade.PositionClose(ticket); 
      if(signal == 1 && PositionGetInteger(POSITION_TYPE) == 1) trade.PositionClose(ticket);
   
   }
}


void updateStoploss(string symbolName, ENUM_TIMEFRAMES timeframe){

   CTrade trade;
   ulong ticket = getLastTicket(symbolName);
   double point = SymbolInfoDouble(symbolName, SYMBOL_POINT);
   
   if(PositionSelectByTicket(ticket)){
   
      if(PositionGetInteger(POSITION_TYPE) == 0){
         
         if(PositionGetDouble(POSITION_PRICE_CURRENT) * (1.0 - TRAILING_STOP / 100.0) > PositionGetDouble(POSITION_SL) + point)
            trade.PositionModify(ticket, PositionGetDouble(POSITION_PRICE_CURRENT) * (1.0 - TRAILING_STOP / 100.0), PositionGetDouble(POSITION_TP));
      
      }
      else{
  
         if(PositionGetDouble(POSITION_PRICE_CURRENT) * (1.0 + TRAILING_STOP / 100.0) < PositionGetDouble(POSITION_SL) - point)
            trade.PositionModify(ticket, PositionGetDouble(POSITION_PRICE_CURRENT) * (1.0 + TRAILING_STOP / 100.0), PositionGetDouble(POSITION_TP));

      }
   }
}


int getCrossSignal(string symbolName, ENUM_TIMEFRAMES timeframe){

   double slowMa[];
   double fastMa[];
   
   ArraySetAsSeries(slowMa, true);
   ArraySetAsSeries(fastMa, true);
   
   int iSlowMa = iMA(symbolName, timeframe, SLOW_MA_PERIOD, SLOW_MA_SHIFT, SLOW_MA_METHOD, SLOW_MA_PRICE);
   int iFastMa = iMA(symbolName, timeframe, FAST_MA_PERIOD, FAST_MA_SHIFT, FAST_MA_METHOD, FAST_MA_PRICE);
   
   if(CopyBuffer(iSlowMa, 0, 1, 2, slowMa) == 2 && CopyBuffer(iFastMa, 0, 1, 2, fastMa) == 2){
   
      if(slowMa[1] > fastMa[1] && slowMa[0] < fastMa[0]) return 1;
      if(slowMa[1] < fastMa[1] && slowMa[0] > fastMa[0]) return 2;
   
   }
   
   return 0;

}