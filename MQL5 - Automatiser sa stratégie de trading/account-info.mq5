//+----------------------------------------------------------------------------------+
//|                                                                 account-info.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


void OnInit(){

   double balance = AccountInfoDouble(ACCOUNT_BALANCE);
   double equity = AccountInfoDouble(ACCOUNT_EQUITY);
   double profit = AccountInfoDouble(ACCOUNT_PROFIT);
   double freeMargin = AccountInfoDouble(ACCOUNT_MARGIN_FREE);
   
   int leverage = (int)AccountInfoInteger(ACCOUNT_LEVERAGE);
   int tradeMode = (int)AccountInfoInteger(ACCOUNT_TRADE_MODE);
   
   string company = AccountInfoString(ACCOUNT_COMPANY);
   string currency = AccountInfoString(ACCOUNT_CURRENCY);
   
   Print("Balance: " + (string)balance);
   Print("Equity: " + (string)equity);
   Print("Profit: " + (string)profit);
   Print("Free Margin :" + (string)freeMargin);
   Print("Trade Mode: " + (string)tradeMode);
   Print("Leverage: " + (string)leverage);
   Print("Currency: " + currency);
   Print("Company: " + company);
   
}