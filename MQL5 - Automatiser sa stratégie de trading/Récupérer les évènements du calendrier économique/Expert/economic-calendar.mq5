//+----------------------------------------------------------------------------------+
//|                                                            economic-calendar.mqh |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


void OnInit(){

   MqlCalendarValue values[];
   
   if(CalendarValueHistory(values, D'01.01.2009', TimeCurrent(), "US")){
   
      for(int i = 0; i < ArraySize(values); i += 1){
      
         MqlCalendarEvent event;
         
         if(CalendarEventById(values[i].event_id, event)){
         
               Print("Date: ", values[i].time,
                         " Evènement: ", event.name,
                          " Importance: ", event.importance,
                           " Dernière: ", values[i].prev_value,
                            " Esperée: ", values[i].forecast_value);
        
         }
      }
   }
}