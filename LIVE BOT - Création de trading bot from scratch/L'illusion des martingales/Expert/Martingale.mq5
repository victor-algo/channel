//+----------------------------------------------------------------------------------+
//|                                                                   martingale.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <Trade\Trade.mqh>;
#include <VictorAlgo\MultiSymbol.mqh>;
#include <VictorAlgo\Martingale.mqh>;

input double STEP = 0.01;
input double TARGET_PROFIT = 3.0;
input double LATENCY = 250.0;

martingale martingales[2];

void OnInit(){

   martingales[0] = createMartingale("EURUSD");
   martingales[1] = createMartingale("USDJPY");   

}


void OnTick(){

   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);
   
   if(now.day_of_week == 5 && now.hour > 21 && now.min > 0){
      
      for(int i = 0; i < ArraySize(martingales); i += 1){
      
         symbolCloseAllPosition(martingales[i].symbolName);
         
      }
   }
   else{
   
      for(int i = 0; i < ArraySize(martingales); i += 1){
   
         int positionTotal = symbolGetPositionTotal(martingales[i].symbolName);
         
         if(positionTotal < 1){
   
            openPosition(martingales[i], STEP);
   
         }
         else if(getSymbolProfit(martingales[i].symbolName) > TARGET_PROFIT){
   
            symbolCloseAllPosition(martingales[i].symbolName);
         
         }
         else{
            
            manageMartingale(martingales[i], positionTotal);
         
         }
      }
   }
}


void openPosition(martingale &m, double volume){

   CTrade trade;

   if(trade.Buy(volume, m.symbolName, SymbolInfoDouble(m.symbolName, SYMBOL_ASK))){
   
      ulong newTicket = trade.ResultOrder();
      
      if(newTicket > 0){
         
         m.lastTicket = newTicket;
      
      }
   } 
}


void manageMartingale(martingale &m, int positionTotal){

   double ask = SymbolInfoDouble(m.symbolName, SYMBOL_ASK);
   double point = SymbolInfoDouble(m.symbolName, SYMBOL_POINT);
   
   if(PositionSelectByTicket(m.lastTicket)){
   
      double openPrice = PositionGetDouble(POSITION_PRICE_OPEN);

      if(openPrice - LATENCY * point > ask){
         
         openPosition(m, STEP * (positionTotal + 1));
      
      }
   } 
}