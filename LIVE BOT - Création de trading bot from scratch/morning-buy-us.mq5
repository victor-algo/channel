//+----------------------------------------------------------------------------------+
//|                                                               morning-buy-us.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <Trade\Trade.mqh>

input double VOLUME = 0.1;

string symbolNames[] = {"[DJI30]", "[SP500]", "[NQ100]"};

void OnTick(){

   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);
   
   if(now.hour == 15 && now.min == 0){
      
      for(int i = 0; i < ArraySize(symbolNames); i += 1){
      
        if(symbolGetPositionTotal(symbolNames[i]) < 1 && getMacdSignal(symbolNames[i])){
        
            double ask = SymbolInfoDouble(symbolNames[i], SYMBOL_ASK);
            double takeprofit = ask * 1.03;
            double stoploss = ask * 0.99;
            CTrade trade;

            if(trade.Buy(VOLUME, symbolNames[i], ask, stoploss, takeprofit)){
            
               if(trade.ResultOrder() < 1){
                  
                  Alert(StringFormat("%: Impossible d'ouvrir une position: %", symbolNames[i], trade.ResultComment()));
               
               }        
            }      
         }
      }
   }
   else if(now.hour == 21 && now.min == 59){
   
       closeAllPosition();
      
   }
}


int symbolGetPositionTotal(string symbolName){
   
   int total = 0;
   
   for(int i = 0; i < PositionsTotal(); i += 1){
   
      if(PositionGetSymbol(i) == symbolName){
         total += 1;
      }
   }
   
   return total;

}


bool getMacdSignal(string symbolName){

    double mainLine[];
    ArraySetAsSeries(mainLine, true);
    int macd = iMACD(symbolName, PERIOD_H4, 12, 26, 9, PRICE_CLOSE);
    
    if(CopyBuffer(macd, 0, 0, 1, mainLine) > 0){
         
        return mainLine[0] > 0.0;
      
    }
   
   return false;
   
}


void closeAllPosition(){

   CTrade trade;

   for(int i = 0; i < PositionsTotal(); i += 1){
   
      ulong ticket = PositionGetTicket(i);
         
         if(trade.PositionClose(ticket)){
            
            if(trade.ResultOrder() < 1){
               
               Alert(StringFormat(" Impossible de fermer la position %", ticket));
            
            }
        }
   }
}