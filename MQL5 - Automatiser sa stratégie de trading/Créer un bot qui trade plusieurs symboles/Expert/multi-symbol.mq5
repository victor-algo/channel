//+----------------------------------------------------------------------------------+
//|                                                                 multi-symbol.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <Trade\Trade.mqh>

CTrade trade;
string symboles[] = {"[CAC40]", "[DAX30]", "[SP500]", "[JP225]"};


void OnTick(){
  
   for(int i = 0; i < ArraySize(symboles); i += 1){
   
     if(symbolGetPositionTotal(symboles[i]) < 1){
         
       double rsi = getRsi(symboles[i]);
       
       if(rsi > 0.0 && rsi < 50){
       
          trade.Buy(SymbolInfoDouble(symboles[i], SYMBOL_VOLUME_MIN), symboles[i], SymbolInfoDouble(symboles[i], SYMBOL_ASK));
       
       }
       else if(rsi > 0.0 && rsi > 49.999999){
          
          trade.Sell(SymbolInfoDouble(symboles[i], SYMBOL_VOLUME_MIN), symboles[i], SymbolInfoDouble(symboles[i], SYMBOL_BID));        
       
       }
     }
   }
}


double getRsi(string symbolName){

   double rsiBuffer[];
   
   ArraySetAsSeries(rsiBuffer, true);
   
   int rsi = iRSI(symbolName, PERIOD_D1, 20, PRICE_CLOSE);
   
   if(CopyBuffer(rsi, 0, 0, 1, rsiBuffer) > 0) return rsiBuffer[0];
   
   return -1.0;

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