//+----------------------------------------------------------------------------------+
//|                                                                        dates.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


void OnInit(){
   
   datetime dayOne = D'2020.04.12 11:34:00';
   datetime dayTwo = TimeCurrent();
   datetime dayThree = (datetime)1564187265;

   Print(dayOne);
   Print(dayTwo);
   Print(dayThree);
   
   Print(dayOne < dayThree);  
   
   Print(getTomorrow(dayTwo));
   
   Print(getRoundDay(dayOne));
}

datetime getTomorrow(datetime day){
   
   long tomorrow = (long)day + 24 * 60 * 60;
   return (datetime)tomorrow;

}

datetime getRoundDay(datetime day){

   long roundDay = (long)day - ((long)day % (24 * 60 * 60));
   return (datetime)roundDay;

}