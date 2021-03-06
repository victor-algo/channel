//+----------------------------------------------------------------------------------+
//|                                                                       rwr-2.0.mq5|
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <Trade\Trade.mqh>

bool modifiedTp = false;
bool modifiedSl = false;

void OnTick(){
   
   if(PositionsTotal() < 1){
        
         start();

   }
   else{
      
      if(!modifiedSl) { updateStopLoss(); }
      if(!modifiedTp) { updateTakeProfit(); }
      
   }
}

void start(){

   CTrade trade;
   
   MqlRates historyBuffer[];
   ArraySetAsSeries(historyBuffer, true);
   
   if(CopyRates(_Symbol, _Period, 0, 5, historyBuffer)){
   
      if(historyBuffer[3].close < historyBuffer[3].open &&
         historyBuffer[2].close > historyBuffer[2].open &&
         historyBuffer[1].close < historyBuffer[1].open){
         
         if(historyBuffer[4].low > historyBuffer[3].low &&
            historyBuffer[3].low > historyBuffer[2].low &&
            historyBuffer[1].low > historyBuffer[2].low){
            
            double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
            
            if(ask >  historyBuffer[1].high){
                  
               double stoploss = historyBuffer[2].low;
               double takeprofit = ask + (ask - stoploss) * 2;
               
               if(trade.Buy(0.01, _Symbol, ask, stoploss, takeprofit)){
         
                  ulong ticket = trade.ResultOrder();
                  
                  if(ticket > 0){
                  
                     modifiedSl = false;
                     modifiedTp = false;
                     
                  }
               }
            }
         }
      }
   }
}

void updateTakeProfit(){

   CTrade trade;
   
   ulong ticket = PositionGetTicket(0);
   
   if(PositionSelectByTicket(ticket)){

      if(PositionGetInteger(POSITION_TIME) + (6 * 24 * 60 * 60) < TimeCurrent()){
 
         MqlRates historyBuffer[];
         ArraySetAsSeries(historyBuffer, true);
         
         if(CopyRates(_Symbol, _Period, 0, 2, historyBuffer)){

            if(trade.PositionModify(ticket, PositionGetDouble(POSITION_SL), historyBuffer[1].high)){

               if(trade.ResultRetcode() == 10009){
                  
                  modifiedTp = true;
                  
               }                 
            }
         }                  
      }           
   }
}

void updateStopLoss(){

   CTrade trade;
   
   ulong ticket = PositionGetTicket(0);
   
   if(PositionSelectByTicket(ticket)){
   
      int timeOpen = (int)PositionGetInteger(POSITION_TIME);

      if(timeOpen + (3 * 24 * 60 * 60) < TimeCurrent()){

         if(trade.PositionModify(ticket, PositionGetDouble(POSITION_PRICE_OPEN), PositionGetDouble(POSITION_TP))){
            
            if(trade.ResultRetcode() == 10009){
             
               modifiedSl = true;
               
            }
         }
      }
      else if(timeOpen + (2 * 24 * 60 * 60) < TimeCurrent()){
         
         if(PositionGetDouble(POSITION_PROFIT) + PositionGetDouble(POSITION_SWAP) < 0.0){
            
            trade.PositionClose(ticket);

         }
      }      
   }
}