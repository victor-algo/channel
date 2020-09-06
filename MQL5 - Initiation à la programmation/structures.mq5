//+----------------------------------------------------------------------------------+
//|                                                                   structures.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


struct symbolParameters{
   
   string label;
   double vol;
   bool activ;

};

enum dayOfWeek{

   LUNDI=1,
   MARDI=2,
   MERCREDI=3,
   JEUDI=4,
   VENDREDI=5,
   SAMEDI=6,
   DIMANCHE=0

};


void OnInit(){
  
  symbolParameters symbols[5];
  symbols[0] = createSymbolParameters("EURUSD", 0.01, true);
  symbols[1] = createSymbolParameters("USDJPY", 0.01, true);
  symbols[2] = createSymbolParameters("GBPUSD", 0.01, true);
  symbols[3] = createSymbolParameters("USDCHF", 0.01, true);
  symbols[4] = createSymbolParameters("AUDUSD", 0.01, true);
  
  for(int i = 0; i < ArraySize(symbols); i += 1){
  
      Print(symbols[i].label);
      Print(symbols[i].vol);
      Print(symbols[i].activ);   
  
  }
  
  Print(LUNDI);


}

symbolParameters createSymbolParameters(string label, double vol, bool activ){

   symbolParameters param;
   param.label = label;
   param.vol = vol;
   param.activ = activ;
   return param;

}