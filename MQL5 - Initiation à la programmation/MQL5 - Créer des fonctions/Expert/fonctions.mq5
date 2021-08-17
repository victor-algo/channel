//+----------------------------------------------------------------------------------+
//|                                                                    fonctions.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


void OnInit(){
   
   int nb = getNumber();
   Print(nb);
   
   Print(isEven(54));
   
   printAllEvenNumber(20);

}

int getNumber(){
   
   int nb = 20;
   return nb;
   
}

bool isEven(int x){
   
   if(x % 2 == 0){
      return true;
   }
   
   return false;

}

void printAllEvenNumber(int max, int start=0){
   
   if(isEven(start)){
      Print(start);
   }
   
   if(start < max){
      printAllEvenNumber(max, start + 1);
   }

}