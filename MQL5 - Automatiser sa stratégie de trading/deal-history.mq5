//+----------------------------------------------------------------------------------+
//|                                                                 deal-history.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

void OnInit(){

   if(HistorySelect(TimeCurrent() - (30 * 24 * 60 * 60), TimeCurrent())){
      
      for(int i = 0; i < HistoryDealsTotal(); i += 1){
         
         ulong ticket = HistoryDealGetTicket(i);
         
         double price = HistoryDealGetDouble(ticket, DEAL_PRICE);
         double profit = HistoryDealGetDouble(ticket, DEAL_PROFIT);
         double swap = HistoryDealGetDouble(ticket, DEAL_SWAP);
         double commission = HistoryDealGetDouble(ticket, DEAL_COMMISSION);
         double volume = HistoryDealGetDouble(ticket, DEAL_VOLUME);
         
         int type = (int)HistoryDealGetInteger(ticket, DEAL_TYPE);
         datetime time = (datetime)HistoryDealGetInteger(ticket, DEAL_TIME);
         int order = (int)HistoryDealGetInteger(ticket, DEAL_ORDER);
         
         string symbole = HistoryDealGetString(ticket, DEAL_SYMBOL);
         
         string rapport = StringFormat("Ticket %s - Symbole %s - Time %s - Price %s - Volume %s \nProfit %s - Swap %s - Commision %s \nType %s -  Order %s",
                                  (string)ticket, symbole, (string)time, (string)price, (string)volume, (string)profit, (string)swap, (string)commission, (string)type, (string)order);
         rapport += "\n----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------";
         
         Print(rapport);
      
      }
   }
}