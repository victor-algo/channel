//+-----------------------------------------------------------------------+
//|                                                            object.mq5 |
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

void OnTick(){
   
   double pivot = 0.0;
   double r1 = 0.0;
   double s1 = 0.0;
   double r2 = 0.0;
   double s2 = 0.0;
   
   MqlRates rates[];
   
   ArraySetAsSeries(rates, true);
   
   if(CopyRates(_Symbol, PERIOD_D1, 1, 1, rates) == 1){
     
      pivot = (rates[0].close + rates[0].high + rates[0].low) / 3.0;
      r1 = pivot * 2.0 - rates[0].low;
      s1 = pivot * 2.0 - rates[0].high;
      r2 = pivot + rates[0].high - rates[0].low;
      s2 = pivot - rates[0].high + rates[0].low;
      
      ObjectDelete(0, "pivot");
      ObjectDelete(0, "r1");
      ObjectDelete(0, "s1");
      ObjectDelete(0, "r2");
      ObjectDelete(0, "s2");
      
      ObjectCreate(0, "pivot", OBJ_HLINE, 0, 0, pivot);
      ObjectCreate(0, "r1", OBJ_HLINE, 0, 0, r1);
      ObjectCreate(0, "s1", OBJ_HLINE, 0, 0, s1);
      ObjectCreate(0, "r2", OBJ_HLINE, 0, 0, r2);
      ObjectCreate(0, "s2", OBJ_HLINE, 0, 0, s2);
      
      ObjectSetInteger(0, "pivot", OBJPROP_COLOR, clrBlue);
      ObjectSetInteger(0, "r1", OBJPROP_COLOR, clrGreenYellow);
      ObjectSetInteger(0, "r2", OBJPROP_COLOR, clrGreen);
      ObjectSetInteger(0, "s1", OBJPROP_COLOR, clrOrange);
      ObjectSetInteger(0, "s2", OBJPROP_COLOR, clrRed);
       
   }
}