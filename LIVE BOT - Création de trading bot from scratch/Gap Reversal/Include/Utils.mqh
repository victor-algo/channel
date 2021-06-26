//+-----------------------------------------------------------------------+
//|                                                              Utils.mqh|
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

int getSymbolPositionTotal(string symbolName){
   
   int total = 0;
   
   for(int i = 0; i < PositionsTotal(); i += 1){
   
      if(PositionGetSymbol(i) == symbolName){
         total += 1;
      }
   }
   
   return total;

}

ulong getLastTicket(string symbolName){
   
   datetime lastTimeOpen = 0;
   ulong ticket = 0;
   
   for(int i = 0; i < PositionsTotal(); i += 1){
      
      if(PositionGetSymbol(i) == symbolName){
          
          if(PositionSelectByTicket(PositionGetTicket(i))){
               
               datetime posTimeOpen = (datetime)PositionGetInteger(POSITION_TIME);
               
               if(lastTimeOpen < posTimeOpen){
               
                  lastTimeOpen = posTimeOpen;
                  ticket = PositionGetTicket(i);
                  
               }
          }
      }
   }

   return ticket;

}

bool symbolIsAlreadyTrade(string symbolName, ENUM_TIMEFRAMES timeframe, int nbCandle){

   MqlRates rates[];
   
   ArraySetAsSeries(rates, true);
   
   if(CopyRates(symbolName, timeframe, 0, nbCandle, rates) == nbCandle){
   
      if(HistorySelect(rates[nbCandle - 1].time, TimeCurrent())){
         
         for(int i = 0; i < HistoryDealsTotal(); i += 1){
         
            ulong ticket = HistoryDealGetTicket(i);

            if(HistoryDealGetString(ticket, DEAL_SYMBOL) == symbolName && HistoryDealGetInteger(ticket, DEAL_ENTRY) == (int)DEAL_ENTRY_IN) return true;

         }
      }
   }
   
   return false;
   
}