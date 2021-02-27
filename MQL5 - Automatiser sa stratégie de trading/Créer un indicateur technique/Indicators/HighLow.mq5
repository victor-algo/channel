//+----------------------------------------------------------------------------------+
//|                                                                       HighLow.mq5|
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

#property indicator_chart_window
#property indicator_buffers 2
#property indicator_plots   2

#property indicator_label1  "high"
#property indicator_type1   DRAW_LINE
#property indicator_color1  clrRed
#property indicator_style1  STYLE_SOLID
#property indicator_width1  1

#property indicator_label2  "low"
#property indicator_type2   DRAW_LINE
#property indicator_color2  clrRed
#property indicator_style2  STYLE_SOLID
#property indicator_width2  1

input int PERIOD = 8;

double highBuffer[];
double lowBuffer[];

int OnInit(){

   SetIndexBuffer(0,highBuffer,INDICATOR_DATA);
   SetIndexBuffer(1,lowBuffer,INDICATOR_DATA);
   
   return(INIT_SUCCEEDED);
}

int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[]){
                
   ArraySetAsSeries(highBuffer, true);
   ArraySetAsSeries(lowBuffer, true);
   ArraySetAsSeries(high, true);
   ArraySetAsSeries(low, true);
                
   int bars = 0;
   
   if(prev_calculated > 0){
      
      bars = rates_total - (prev_calculated - 1);
      
   }
   else{
      
      bars = rates_total - 1;
   
   }
   
   for(int i = bars; i >= 0; i -= 1){
      
      highBuffer[i] = high[ArrayMaximum(high, i, PERIOD)];
      lowBuffer[i] = low[ArrayMinimum(low, i, PERIOD)];
   
   }
   
   return(rates_total);
}

