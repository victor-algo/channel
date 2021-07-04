//+----------------------------------------------------------------------------------+
//|                                                             ProfitCalculator.mqh |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


bool setPositionProfit(string symbolName, ENUM_POSITION_TYPE type, double volume, double priceOpen, double priceClose, double &result){
  
   double pointPrice;

   if((type == POSITION_TYPE_BUY && priceOpen < priceClose) || (type == POSITION_TYPE_SELL && priceOpen > priceClose)){
      
      if(!setPointPrice(symbolName, volume, true, pointPrice)) return false;
      
   }
   else{
   
      if(!setPointPrice(symbolName, volume, false, pointPrice)) return false;
      
   }  

   result = NormalizeDouble(MathAbs(priceOpen - priceClose) * pointPrice, 2);
   return true;

}




bool setPointPrice(string symbolName, double volume, bool profitable, double &result){
   
   double point;
   if(!SymbolInfoDouble(symbolName, SYMBOL_POINT, point)) return false;

   double tickProfitValue;
   if(!SymbolInfoDouble(symbolName, SYMBOL_TRADE_TICK_VALUE_PROFIT, tickProfitValue)) return false;
   
   double tickLossValue;
   if(!SymbolInfoDouble(symbolName, SYMBOL_TRADE_TICK_VALUE_LOSS, tickLossValue)) return false;
   
   if(profitable){
   
      result = tickProfitValue / point * volume;
      
   }
   else{
      
      result = tickLossValue / point * volume * -1.0;      
   
   }
   return true;
    
}