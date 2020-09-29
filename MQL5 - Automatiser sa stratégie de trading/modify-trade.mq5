//+----------------------------------------------------------------------------------+
//|                                                                 modify-trade.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <Trade\Trade.mqh>

CTrade trade;

void OnTick(){
   
   if(PositionsTotal() < 1){
      
      trade.Buy(0.01, _Symbol, SymbolInfoDouble(_Symbol, SYMBOL_ASK), 0.0, 0.0);
      
   }
   else{
      
      ulong ticket = PositionGetTicket(0);
      
      if(PositionSelectByTicket(ticket)){
      
         if(PositionGetDouble(POSITION_SL) < 0.0001 && PositionGetDouble(POSITION_TP) < 0.0001){
            
            if(trade.PositionModify(ticket,  PositionGetDouble(POSITION_PRICE_OPEN) * 0.99, PositionGetDouble(POSITION_PRICE_OPEN) * 1.01)){
               
               int code = (int)trade.ResultRetcode();
               
               if(code == 10009){
                  
                  Print("Position modified");
                  
               }
            }
         }
         else if(PositionGetInteger(POSITION_TIME) + (24 * 60 * 60) < TimeCurrent()){
            
            if(trade.PositionClose(ticket)){
            
               int code = (int)trade.ResultRetcode();
               
               if(code == 10009) {
               
                  Print("Position closed");
                  
               }
            }
         }
      }
   }
}