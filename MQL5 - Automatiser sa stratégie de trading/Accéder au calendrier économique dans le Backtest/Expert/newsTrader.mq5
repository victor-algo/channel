//+----------------------------------------------------------------------------------+
//|                                                                   newsTrader.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#include <Self\newsBacktest.mqh>;

void OnInit(){
   
   // -- à décommenter et lancer sur graphique pour télécharger les news
   
   // -- downloadCountryNews("US");

}

void OnTick(){
   
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);
   
   if(now.hour == 6 && now.min == 0 && now.sec == 0){
   
      economicNews news[];
      
      if(getBTnews(24 * 60 * 60, "US", news)){
      
         for(int i = 0; i < ArraySize(news); i += 1){
               
            Print(news[i].value.time);
            Print(news[i].event.name);
            Print(news[i].value.forecast_value);
         
         }
      }
      
      Sleep(1000);
      
   }
}