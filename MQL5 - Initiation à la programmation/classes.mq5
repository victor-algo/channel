//+----------------------------------------------------------------------------------+
//|                                                                      classes.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


class SymbolTrader{
   
   private:
   
      string m_label;
      double m_volume;
      bool m_activ;
      
   
   public:
   
       SymbolTrader(string label, double volume){
         
         m_label = label;
         m_volume = volume;
         m_activ = true;
      
      }
   
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
   
   SymbolTrader eurusdTrader("EURUSD", 0.1, false);
   eurusdTrader.describe();
   
   SymbolTrader usdjpyTrader("USDJPY", 0.1);
   usdjpyTrader.describe();

}