//+----------------------------------------------------------------------------------+
//|                                                            calculProfitTools.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <VictorAlgo\ProfitCalculator.mqh>

enum STOP_CALC_MODE{

   PERCENT,
   POINT

};

input int TYPE_POSITION = 0;
input double VOL = 0.1;
input STOP_CALC_MODE STOP_MODE = PERCENT;
input double STOPLOSS = 0.05;
input double TAKEPROFIT = 0.05; 

void OnTick(){

   double takeprofit = 0.0;
   double stoploss = 0.0;
   double potentialProfit = 0.0;
   double potentialLoss =  0.0;
   double volMin = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
   double volMax = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MAX);
   
   if(VOL < volMin){
      
      Alert("ERROR: Minimum volume: " + (string)volMin);
      ExpertRemove();
   
   }
   else if(VOL > volMax){
   
      Alert("ERROR: Maximum volume: " + (string)volMax);
      ExpertRemove();
      
   }
   
   if(TYPE_POSITION == 0){
   
      double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
      
      if(STOP_MODE == PERCENT){
      
         takeprofit = ask * (1.0 + TAKEPROFIT / 100.0);
         stoploss = ask * (1.0 - STOPLOSS / 100.0);
      
      }
      else{
      
         takeprofit = ask + TAKEPROFIT * _Point;
         stoploss = ask - STOPLOSS * _Point;     
      
      }

      if(!setPositionProfit(_Symbol, POSITION_TYPE_BUY, VOL, ask, takeprofit, potentialProfit)) ExpertRemove();
      if(!setPositionProfit(_Symbol, POSITION_TYPE_BUY, VOL, ask, stoploss, potentialLoss)) ExpertRemove();

   }
   else{
   
      double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      
      if(STOP_MODE == PERCENT){
      
         takeprofit = bid * (1.0 - TAKEPROFIT / 100.0);
         stoploss = bid * (1.0 + STOPLOSS / 100.0);
      
      }
      else{
      
         takeprofit = bid - TAKEPROFIT * _Point;
         stoploss = bid + STOPLOSS * _Point;     
      
      }

      if(!setPositionProfit(_Symbol, POSITION_TYPE_SELL, VOL, bid, takeprofit, potentialProfit)) ExpertRemove();
      if(!setPositionProfit(_Symbol, POSITION_TYPE_SELL, VOL, bid, stoploss, potentialLoss)) ExpertRemove();   
      
   }
   
   Comment(StringFormat("Potential profit: %s, Potential loss: %s", (string)potentialProfit, (string)potentialLoss));
}
