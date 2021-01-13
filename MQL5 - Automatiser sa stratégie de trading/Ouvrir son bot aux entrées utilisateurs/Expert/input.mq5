//+----------------------------------------------------------------------------------+
//|                                                                        input.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

enum DAY_OF_WEEK{

   LUNDI,
   MARDI,
   MERCREDI,
   JEUDI,
   VENDREDI,
   SAMEDI,
   DIMANCHE,

};

input group "TRADE";
input string SYMBOL = "EURUSD";
input double TAKEPROFIT = 3.0;
input bool FRIDAY_TRADE = true;

input group "CALCUL";
input ENUM_TIMEFRAMES PERIOD = PERIOD_D1;
input ENUM_MA_METHOD METHOD = MODE_SMA;

input group "LOG";
input DAY_OF_WEEK LOG_DAY = LUNDI;

void OnInit(){

   Print(SYMBOL);
   Print(TAKEPROFIT);
   Print(FRIDAY_TRADE);
   Print(PERIOD);
   Print(LOG_DAY);
   Print(METHOD);   
   
}