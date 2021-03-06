//+----------------------------------------------------------------------------------+
//|                                                                       rwr-1.0.mq5|
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <Trade\Trade.mqh>

void OnTick(){
   
   if(PositionsTotal() < 1){
        
         start();
      
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

                    Print("Posistion ouverte à: " + (string)ask + ". Ticket: " + (string)ticket);

                 }

              }
                 
            }
            
         }
         
      }
      
   }

}

