//+----------------------------------------------------------------------------------+
//|                                                           calculProfitExpert.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <VictorAlgo\ProfitCalculator.mqh>
#include <Trade\Trade.mqh>

CTrade trade;

void OnTick(){

   if(PositionsTotal() < 1){
   
      double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
      double minVol = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN);
      
      double takeprofit = bid * 0.995;
      double stoploss = bid * 1.005;
      
      double potentialProfit;
      if(!setPositionProfit(_Symbol, POSITION_TYPE_SELL, minVol, bid, takeprofit, potentialProfit)) return;
      
      double potentialLoss;
      if(!setPositionProfit(_Symbol, POSITION_TYPE_SELL, minVol, bid, stoploss, potentialLoss)) return;
      
      Comment(StringFormat("Potential profit: %s, Potential loss: %s", (string)potentialProfit, (string)potentialLoss));
      
      if(trade.Sell(minVol, _Symbol, bid, stoploss, takeprofit)){
            // ...
      } 
   }
}