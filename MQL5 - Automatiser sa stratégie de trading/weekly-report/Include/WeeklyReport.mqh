//+----------------------------------------------------------------------------------+
//|                                                                 WeeklyReport.mqh |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


double getWeeklyProfit(string symbolName){
   
   double profit = 0.0;
   
   if(HistorySelect(TimeCurrent() - (7 * 24 * 60 * 60), TimeCurrent())){
   
      for(int i = 0; i < HistoryDealsTotal(); i += 1){
      
         ulong ticket = HistoryDealGetTicket(i);
         
         if(HistoryDealGetString(ticket, DEAL_SYMBOL) == symbolName) 
            profit += (HistoryDealGetDouble(ticket, DEAL_COMMISSION) + HistoryDealGetDouble(ticket, DEAL_SWAP) + HistoryDealGetDouble(ticket, DEAL_PROFIT));
      
      }
   }
   
   return profit;
   
}


double getCurrentProfit(string symbolName){

   double profit = 0.0;
   
   for(int i = 0; i < PositionsTotal(); i += 1){
      
      if(PositionGetSymbol(i) == symbolName){
         
         if(PositionSelectByTicket(PositionGetTicket(i))){
            
            profit += (PositionGetDouble(POSITION_SWAP) + PositionGetDouble(POSITION_PROFIT));
         
         }
      }
   }
   
   return profit;

}


int getWeeklyPositionTotal(string symbolName){

   int total = 0;
   
   if(HistorySelect(TimeCurrent() - (7 * 24 * 60 * 60), TimeCurrent())){
   
      for(int i = 0; i < HistoryDealsTotal(); i += 1){
      
         ulong ticket = HistoryDealGetTicket(i);
         
         if(HistoryDealGetString(ticket, DEAL_SYMBOL)  == symbolName && HistoryDealGetInteger(ticket, DEAL_ENTRY) == 0) total += 1;
      
      }
   }
   
   return total;

}


void sendReport(string &symboles[]){

   double weeklyProfitTotal = 0.0;
   double currentProfitTotal = 0.0;
   int positionTotal = 0;
   
   string report =  "+--------------------------------------------------------------------------------------+\n";
   report += "+---  symbol   ---  weekly profit  ---  current profit  ---  position total  ---+\n";
   
   for(int i = 0; i < ArraySize(symboles); i += 1){
      
      double weeklyProfit = getWeeklyProfit(symboles[i]);
      double currentProfit = getCurrentProfit(symboles[i]);
      int nbPos = getWeeklyPositionTotal(symboles[i]);

      report +=    "+--------------------------------------------------------------------------------------+\n";
      report +=  StringFormat("+---    %s       ---        %s         ---          %s           ---        %s        ---+\n", 
                        symboles[i],
                         (string)NormalizeDouble(weeklyProfit, 2),
                          (string)NormalizeDouble(currentProfit, 2),
                           (string)nbPos);
      
      weeklyProfitTotal += weeklyProfit;
      currentProfitTotal += currentProfit;
      positionTotal += nbPos;
   
   }
   
   report += "+--------------------------------------------------------------------------------------+\n";
   report += StringFormat("+---    TOTAL      ---        %s          ---          %s           ---        %s        ---+\n", (string)NormalizeDouble(weeklyProfitTotal, 2), (string)NormalizeDouble(currentProfitTotal, 2), (string)positionTotal);

   double balance = AccountInfoDouble(ACCOUNT_BALANCE);
   double performance = (balance - (balance - weeklyProfitTotal)) / (balance - weeklyProfitTotal) * 100;
   report += "+--------------------------------------------------------------------------------------+\n";
   report += (StringFormat("+ ---------------------------   Performance: %s ", (string)NormalizeDouble(performance, 2))) + "%    ---------------------------+\n";
   
   if(!SendMail("Morning Buy US REPORT", report) || MQLInfoInteger(MQL_TESTER)) Print(report);

}