//+-----------------------------------------------------------------------+
//|                                                  LinearRegression.mqh |
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

bool linearRegression(double& x[], double& y[], double& a, double& b){

   double cov;
   double xvar;
   double xmean;
   double ymean;
   
   if(covariance(x, y, cov) &&
      covariance(x, x, xvar) &&
      mean(x, xmean) &&
      mean(y, ymean)){
      
      if(xvar > 0.0){

         a = cov / xvar;
         b = ymean - a * xmean;
         return true;
      
      }
   }
   
   return false;

}


bool covariance(double& x[], double& y[], double& result){

   double xmean = 0.0;
   double ymean = 0.0;
   double sum = 0.0;
   int xsize = ArraySize(x);
   int ysize = ArraySize(y);
   
   if(mean(x, xmean) &&
      mean(y, ymean) &&
      xsize == ysize){
   
      for(int i = 0; i <  xsize; i += 1){
      
         sum += ((x[i] - xmean) * (y[i] - ymean));
      
      }
      
      result = sum / xsize;
      return true;
      
   }
   
   return false;
   
}

bool mean(double& x[], double& result){

   double sum = 0.0;
   int xsize = ArraySize(x);
    
   if(xsize > 0){
   
      for(int i = 0; i < xsize; i += 1){
         
         sum += x[i];
      
      }
      
      result = sum / xsize;
      return true;
      
   }

   return false;

}