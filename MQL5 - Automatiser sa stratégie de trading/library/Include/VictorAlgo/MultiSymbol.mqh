//+----------------------------------------------------------------------------------+
//|                                                                  MultiSymbol.mqh |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <Trade\Trade.mqh>

int symbolGetPositionTotal(string symbolName){
   
   int total = 0;
   
   for(int i = 0; i < PositionsTotal(); i += 1){
   
      if(PositionGetSymbol(i) == symbolName){
         total += 1;
      }
   }
   
   return total;

}

void symbolCloseAllPosition(string symbolName){

   CTrade trade;
   
   for(int i = 0; i < PositionsTotal(); i += 1){
      
      if(PositionGetSymbol(i) == symbolName){
          
          ulong ticket = PositionGetTicket(i);
          
          if(trade.PositionClose(ticket)){
               
             if(trade.ResultOrder() < 1){
                
                Print("Erreur lors de la fermeture de " + (string)ticket);
                
             }
          }
      }
   }
   
   if(symbolGetPositionTotal(symbolName) > 0) symbolCloseAllPosition(symbolName);
   
}


