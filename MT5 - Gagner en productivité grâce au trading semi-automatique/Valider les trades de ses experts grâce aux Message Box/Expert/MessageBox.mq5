//+-----------------------------------------------------------------------+
//|                                                         MessageBox.mq5|
//|                            https://github.com/victor-algo/channel.git |
//|              https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+-----------------------------------------------------------------------+

#include <Trade\Trade.mqh>
#include <VictorAlgo\ProfitCalculator.mqh>

void OnTick(){

  double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
  double stoploss = ask * 0.995;
  double takeprofit = ask * 1.01;
  double volume = 0.1;
  CTrade trade;
 
  if(PositionsTotal() < 1){
 
      if(tradeConfirmation(_Symbol, POSITION_TYPE_BUY, ask, volume, stoploss, takeprofit))
         trade.Buy(volume, _Symbol, ask, stoploss, takeprofit);
 
  }
}

bool tradeConfirmation(string symbolName, ENUM_POSITION_TYPE type, double price, double volume, double stoploss, double takeprofit){

   string header = "TRADE CONFIRMATION";
   string message = "";
   string posTypeStr = "";
   double possibleLoss = 0.0;
   double possibleProfit = 0.0;
   
   if(type == POSITION_TYPE_BUY) posTypeStr = "Buy";
   else posTypeStr = "Sell";
   
   if(setPositionProfit(symbolName, type, volume, price, stoploss, possibleLoss) &&
      setPositionProfit(symbolName, type, volume, price, takeprofit, possibleProfit)){
     
        message = StringFormat(" TYPE: %s\n VOLUME: %s\n PRIX: %s\n STOPLOSS: %s\n TAKEPROFIT: %s\n PERTE POTENTIELLE: %s\n GAIN POTENTIEL: %s\n\n CONFIRMER ?",
                               posTypeStr ,(string)volume, (string)price, (string)stoploss, (string)takeprofit, (string)possibleLoss, (string)possibleProfit);
                               
        int response = MessageBox(message, header, MB_YESNO | MB_ICONQUESTION | MB_DEFBUTTON2);

        if(response == 6) return true;

   }
   
   return false;
   
}