//+-----------------------------------------------------------------------+
//|                                                           Pattern.mqh |
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

#include <VictorAlgo\Pattern\LinearRegression.mqh>

enum ENUM_PATTERN{

   ASCENDING_TRIANGLE,
   DESCENDING_TRIANGLE,
   RECTANGLE,
   FALLING_WEDGE,
   RISING_WEDGE,
   UNKNOWN

};


ENUM_PATTERN getCurrentPattern(string symbolName, ENUM_TIMEFRAMES timeframe, int nbScanPeriod, int scanPeriodSize, double epsilon){

   ENUM_PATTERN pattern = UNKNOWN;
   double highRecentPoint = 0.0;
   double highOldestPoint = 0.0;
   double lowRecentPoint = 0.0;
   double lowOldestPoint = 0.0;
   double highEvol = 0.0;
   double lowEvol = 0.0;
   MqlRates rates[];
   
   ArraySetAsSeries(rates, true);

   if(CopyRates(symbolName, timeframe, 0, nbScanPeriod * scanPeriodSize, rates) == nbScanPeriod * scanPeriodSize){
   
      if(getHighLinePoint(symbolName, timeframe, nbScanPeriod, scanPeriodSize, rates[0].time, highRecentPoint) &&
         getHighLinePoint(symbolName, timeframe, nbScanPeriod, scanPeriodSize, rates[nbScanPeriod * scanPeriodSize - 1].time, highOldestPoint) &&
         getLowLinePoint(symbolName, timeframe, nbScanPeriod, scanPeriodSize, rates[0].time, lowRecentPoint) &&
         getLowLinePoint(symbolName, timeframe, nbScanPeriod, scanPeriodSize, rates[nbScanPeriod * scanPeriodSize - 1].time, lowOldestPoint)){
         
         drawTrend("high", clrTurquoise, rates[0].time, rates[nbScanPeriod * scanPeriodSize - 1].time, highRecentPoint, highOldestPoint);
         drawTrend("low", clrOrange, rates[0].time, rates[nbScanPeriod * scanPeriodSize - 1].time, lowRecentPoint, lowOldestPoint);
         
         highEvol = (highRecentPoint - highOldestPoint) / highOldestPoint * 100.0;
         lowEvol = (lowRecentPoint - lowOldestPoint) / lowOldestPoint * 100.0;

         if(highRecentPoint > lowRecentPoint && highOldestPoint > lowOldestPoint){
         
            if(MathAbs(highEvol) < epsilon && lowEvol > epsilon) pattern = ASCENDING_TRIANGLE;
            else if(MathAbs(lowEvol) < epsilon && highEvol < -epsilon) pattern = DESCENDING_TRIANGLE;
            else if(MathAbs(lowEvol) < epsilon && MathAbs(highEvol) < epsilon) pattern = RECTANGLE;
            else if(lowEvol < -epsilon && highEvol < -epsilon) pattern = FALLING_WEDGE;
            else if(lowEvol > epsilon && highEvol > epsilon) pattern = RISING_WEDGE;
            
         }
      }
   }
   
   return pattern;
   
}


void drawTrend(string name, int lineColor, datetime x0, datetime x1, double y0, double y1){
   
   ObjectDelete(0, name);
   ObjectCreate(0, name, OBJ_TREND, 0, x0, y0, x1, y1);
   ObjectSetInteger(0, name, OBJPROP_COLOR, lineColor);

}

// --- Fonctions permettant de récupérer l'ordonnée (le prix) d'un point des droites haut/bas à partir d'un abscisse (la date) donné

bool getHighLinePoint(string symbolName, ENUM_TIMEFRAMES timeframe, int nbScanPeriod, int scanPeriodSize, double x, double& y){
   
   double a;
   double b;

   if(getHighLine(symbolName, timeframe, nbScanPeriod, scanPeriodSize, a, b)){

      y = a * x + b;
      return true;
      
   }
   
   return false;

}


bool getLowLinePoint(string symbolName, ENUM_TIMEFRAMES timeframe, int nbScanPeriod, int scanPeriodSize, double x, double& y){
   
   double a;
   double b;

   if(getLowLine(symbolName, timeframe, nbScanPeriod, scanPeriodSize, a, b)){

      y = a * x + b;
      return true;
      
   }
   
   return false;

}

// --- Fonctions chargées de retourner l'équation des droites (a, b) des plus haut/bas

bool getHighLine(string symbolName, ENUM_TIMEFRAMES timeframe, int nbScanPeriod, int scanPeriodSize, double& a, double& b){

   double highs[];
   double highTimes[];
   MqlRates highBuffer;
   
   ArrayResize(highs, nbScanPeriod);
   ArrayResize(highTimes, nbScanPeriod);
      
   for(int i = 0; i < nbScanPeriod; i += 1){
   
      if(getHigherCandle(symbolName, timeframe, i * scanPeriodSize, scanPeriodSize, highBuffer)){
         
         highs[i] = highBuffer.high;
         highTimes[i] = (double)highBuffer.time;
               
      }
   }
   
   if(linearRegression(highTimes, highs, a, b)) return true;
   
   return false;

}


bool getLowLine(string symbolName, ENUM_TIMEFRAMES timeframe, int nbScanPeriod, int scanPeriodSize, double& a, double& b){
   
   double lows[];
   double lowTimes[];
   MqlRates lowBuffer;
   
   ArrayResize(lows, nbScanPeriod);
   ArrayResize(lowTimes, nbScanPeriod);

   for(int i = 0; i < nbScanPeriod; i += 1){
   
      if(getlowerCandle(symbolName, timeframe, i * scanPeriodSize, scanPeriodSize, lowBuffer)){
         
         lows[i] = lowBuffer.low;
         lowTimes[i] = (double)lowBuffer.time;
      
      }
   }
   
   if(linearRegression(lowTimes, lows, a, b)) return true;
   
   return false;
   
}

// -- Fonctions chargées de retourner la bougie la plus haute/basse sur une période donnée

bool getHigherCandle(string symbolName, ENUM_TIMEFRAMES timeframe, int start, int nbCandle, MqlRates& higher){

   MqlRates higherBuffer;
   MqlRates rates[];
   
   ArraySetAsSeries(rates, true);

   if(CopyRates(symbolName, timeframe, start, nbCandle, rates) == nbCandle){

      higherBuffer = rates[0];

      for(int i = 1; i < nbCandle; i += 1){

         if(rates[i].high > higherBuffer.high) higherBuffer = rates[i];

      }

      higher = higherBuffer;

      return true;

   }

   return false;

}


bool getlowerCandle(string symbolName, ENUM_TIMEFRAMES timeframe, int start, int nbCandle, MqlRates& lower){

   MqlRates lowerBuffer;
   MqlRates rates[];
   
   ArraySetAsSeries(rates, true);

   if(CopyRates(symbolName, timeframe, start, nbCandle, rates) == nbCandle){

      lowerBuffer = rates[0];

      for(int i = 1; i < nbCandle; i += 1){

         if(rates[i].low < lowerBuffer.low) lowerBuffer = rates[i];

      }

      lower = lowerBuffer;

      return true;

   }

   return false;

}