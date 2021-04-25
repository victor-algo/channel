//+-----------------------------------------------------------------------+
//|                                                             Utils.mqh |
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
   
   datetime maxTimeOpen = 0;
   ulong ticket = 0;
   
   for(int i = 0; i < PositionsTotal(); i += 1){
      
      if(PositionGetSymbol(i) == symbolName){
          
          if(PositionSelectByTicket(PositionGetTicket(i))){
               
            datetime posTimeOpen = (datetime)PositionGetInteger(POSITION_TIME);
            
            if(maxTimeOpen < posTimeOpen){
            
               maxTimeOpen = posTimeOpen;
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


bool getHighLow(string symbolName, ENUM_TIMEFRAMES timeframe, int nbPeriod, double& result[]){

   double min = 0.0;
   double max = 0.0;
   MqlRates rates[];

   ArrayResize(result, 2);
   ArraySetAsSeries(rates, true);

   if(CopyRates(symbolName, timeframe, 1, nbPeriod, rates) == nbPeriod){

      min = rates[0].low;
      max = rates[0].high;

      for(int i = 1; i < nbPeriod; i += 1){

         if(rates[i].low < min) min = rates[i].low;
         if(rates[i].high > max) max = rates[i].high;

      }

      result[0] = min;
      result[1] = max;

      return true;

   }

   return false;

}