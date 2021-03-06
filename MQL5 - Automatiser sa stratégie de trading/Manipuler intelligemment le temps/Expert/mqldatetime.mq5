//+----------------------------------------------------------------------------------+
//|                                                                  mqldatetime.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

void OnInit(){
   
   Print("Datetime: " + (string)TimeCurrent());
   
   ulong nowTimestamp = (ulong)TimeCurrent();
   
   Print("Timestamp: " + (string)nowTimestamp);
   
   MqlDateTime now;
   TimeToStruct(TimeCurrent(), now);
   
   Print("Jour: " + (string)now.day);
   Print("Heure: " + (string)now.hour);
   Print("Jour de la semaine: " + (string)now.day_of_week);
   Print("Jour de l'année: " + (string)now.day_of_year);
   
}