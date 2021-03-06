//+----------------------------------------------------------------------------------+
//|                                                                  symbol-info.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

void OnTick(){
   
   Print(_Symbol);
   
   double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
   double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
   double point = SymbolInfoDouble(_Symbol, SYMBOL_POINT);
   double minVolume = SymbolInfoDouble(_Symbol, SYMBOL_VOLUME_MIN); 
   
   Print("Prix achat: " + (string)ask);
   Print("Prix vente: " + (string)bid);
   Print("Point: " + (string)point);
   Print("Volume minimum: " + (string)minVolume);
   
   int spread = SymbolInfoInteger(_Symbol, SYMBOL_SPREAD);
   
   Print("Spread: " + (string)spread);
   
}