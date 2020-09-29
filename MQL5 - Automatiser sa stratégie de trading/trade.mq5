//+----------------------------------------------------------------------------------+
//|                                                                        trade.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <Trade\Trade.mqh>

CTrade trade;

void OnTick(){
   
   if(PositionsTotal() < 1){
   
      double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      double stoploss = ask - 100 * _Point;
      double takeprofit = ask + 100 * _Point;
      
      if(trade.Buy(0.01, _Symbol, ask, stoploss, takeprofit)){
      
         int code = (int)trade.ResultRetcode();
         ulong ticket = trade.ResultOrder();
         Print("Code: " + (string)code);
         Print("Ticket: " + (string)ticket);
           
      }
      
      double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      double sellStoploss = bid + 100 * _Point;
      double sellTakeprofit = bid - 100 * _Point;
      
      if(trade.Sell(0.01, _Symbol, bid, sellStoploss, sellTakeprofit)){
      
         int code = (int)trade.ResultRetcode();
         ulong ticket = trade.ResultOrder();
         Print("Code: " + (string)code);
         Print("Ticket: " + (string)ticket);
           
      }
    
   }
   
}