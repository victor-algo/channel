//+-----------------------------------------------------------------------+
//|                                                           Pattern.mq5 |
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

#include <VictorAlgo\Pattern\Pattern.mqh>

input int SCAN_PERIOD_SIZE = 20;
input int NB_SCAN_PERIOD = 4;
input double EPSILON = 0.1;

void OnTick(){

   ENUM_PATTERN pattern = getCurrentPattern(_Symbol, _Period, NB_SCAN_PERIOD, SCAN_PERIOD_SIZE, EPSILON);

   if(pattern == ASCENDING_TRIANGLE) Comment("ASCENDING TRIANGLE");
   else if(pattern == DESCENDING_TRIANGLE) Comment("DESCENDING TRIANGLE");
   else if(pattern == RECTANGLE) Comment("RECTANGLE");
   else if(pattern == FALLING_WEDGE) Comment("FALLING WEDGE");
   else if(pattern == RISING_WEDGE) Comment("RISING WEDGE");
   else Comment("UNKNOWN");
   
}