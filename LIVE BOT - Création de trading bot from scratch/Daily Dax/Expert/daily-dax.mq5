//+----------------------------------------------------------------------------------+
//|                                                                     daily-dax.mq5|
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <Trade\Trade.mqh>;

void OnTick(){

   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);
   
   if(now.hour == 13 && now.min == 30){
      
      if(PositionsTotal() < 1 && getAdx() > 25){
         
         CTrade trade;
         double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
         double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
         double movingAverage = getMovingAverage();
         
         if(movingAverage > 0.0 && ask > movingAverage){
         
            if(trade.Buy(0.1, _Symbol, ask, 0.0, 0.0)){
            
               ulong resultTicket = trade.ResultOrder();
               
               if(resultTicket > 0){
                  
                  Print("Buy completed: " + (string)resultTicket);
                  
               }  
            }
         }
         else if(movingAverage > 0.0 && bid < movingAverage){
            
            if(trade.Sell(0.1, _Symbol, bid, 0.0, 0.0)){
               
               ulong resultTicket = trade.ResultOrder();
               
               if(resultTicket > 0){
               
                  Print("Sell completed: " + (string)resultTicket);      
                              
               }  
            }
         }
      }
   }
   else if(now.hour == 21 && now.min == 30){
      
      if(PositionsTotal() > 0){
         
         CTrade trade;
         
         if(trade.PositionClose(PositionGetTicket(0))){
         
            if(trade.ResultOrder() > 0){
            
               Print("Position close.");
               
            }
         }
      }
   }
}

double getAdx(){

   double adxBuffer[];
   ArraySetAsSeries(adxBuffer, true);
   int iadx = iADX(_Symbol, PERIOD_D1, 14);
   
   if(CopyBuffer(iadx, 0, 0, 1, adxBuffer)){
      
      if(ArraySize(adxBuffer) > 0){
         
         return adxBuffer[0];
         
      }
   }
   
   return -1.0;

}

double getMovingAverage(){

   double maBuffer[];
   ArraySetAsSeries(maBuffer, true);
   int ima = iMA(_Symbol, PERIOD_D1, 10, 0, MODE_SMA, PRICE_CLOSE);
   
   if(CopyBuffer(ima, 0, 0, 1, maBuffer)){
      
      if(ArraySize(maBuffer) > 0){
      
         return maBuffer[0];
         
      }
   }
   
   return -1.0;
}