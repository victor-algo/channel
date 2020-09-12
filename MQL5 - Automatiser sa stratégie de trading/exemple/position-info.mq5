//+----------------------------------------------------------------------------------+
//|                                                                position-info.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <Trade\Trade.mqh>

CTrade trade;

void OnTick(){
   
   if(PositionsTotal() < 1){
   
      trade.Buy(0.01, _Symbol, SymbolInfoDouble(_Symbol, SYMBOL_ASK), 0.0, 0.0);
      trade.Sell(0.01, _Symbol, SymbolInfoDouble(_Symbol, SYMBOL_BID), 0.0, 0.0);
       
   }
   else{
     
     for(int i = 0; i < PositionsTotal(); i += 1){
     
        ulong ticket = PositionGetTicket(i);
        
        Print("Ticket: " + (string)ticket);
        
        if(PositionSelectByTicket(ticket)){
        
              double stoploss = PositionGetDouble(POSITION_SL);
              double takeprofit = PositionGetDouble(POSITION_TP);
              double priceOpen = PositionGetDouble(POSITION_PRICE_OPEN);
              
              
              datetime timeOpen = (datetime)PositionGetInteger(POSITION_TIME);
              int type = (int)PositionGetInteger(POSITION_TYPE);
              
              Print("Stoploss: " + (string)stoploss);
              Print("Takeprofit: " + (string)takeprofit);
              Print("Prix ouverture: " + (string)priceOpen);
              Print("Date ouverture: " + (string)timeOpen);
              Print("Type position: " + (string)type);             
           
        }
        
      }
   
   }
   
}