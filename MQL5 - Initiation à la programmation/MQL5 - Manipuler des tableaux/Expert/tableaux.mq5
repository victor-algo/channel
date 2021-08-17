//+----------------------------------------------------------------------------------+
//|                                                                     tableaux.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

void OnInit(){
  
   string symboles[3];
   symboles[0] = "EURUSD";
   symboles[1] = "USDJPY";
   symboles[2] = "GBPUSD";
   
   for(int i = 0; i < ArraySize(symboles); i ++){
      Print(symboles[i]);
   }
   
   int chiffres[3] = {1, 2, 3};
   ArrayPrint(chiffres);
   
   int tableauDyn[];
   
   Print(ArraySize(tableauDyn));
   
   ArrayResize(tableauDyn, 2);
   ArrayInitialize(tableauDyn, 55);
   ArrayPrint(tableauDyn);
   
   ArrayResize(tableauDyn, 9);
   ArrayInitialize(tableauDyn, 32);
   ArrayPrint(tableauDyn);
   
   ArrayFree(tableauDyn);
   Print(ArraySize(tableauDyn));
   
   double matrice[2][2];
   matrice[0][0] = 1.0;
   matrice[0][1] = 2.0;
   matrice[1][0] = 3.0;
   matrice[1][1] = 4.0;
   
   ArrayPrint(matrice);
   
   
  
}