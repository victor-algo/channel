//+----------------------------------------------------------------------------------+
//|                                                                     adresses.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

class SymbolTrader{
   
   private:
   
      string m_label;
      double m_volume;
      bool m_activ;
      
   
   public:
   
      SymbolTrader(string label, double volume, bool activ){
         
         m_label = label;
         m_volume = volume;
         m_activ = activ;
      
      }
      
      void describe(){
         
         Print(m_label);
         Print(m_volume);
         Print(m_activ);
      
      }
     

};

void OnInit(){

   int a = 10;
   addOne(a);
   Print(a);
   
   int tab[5];
   initialize(tab, 15);
   ArrayPrint(tab);
   
   SymbolTrader* trader = getSymbolTrader();
   trader.describe();
   delete trader;
   trader.describe();
   
}

void addOne(int& nombre){
   
   nombre += 1;

}

void initialize(int& nombres[], int nb){
   
   for(int i = 0; i < ArraySize(nombres); i += 1){
      nombres[i] = nb;
   }

}

SymbolTrader* getSymbolTrader(){
   
   SymbolTrader* trader = new SymbolTrader("EURUSD", 0.01, true);
   return trader;

}