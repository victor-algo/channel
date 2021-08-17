//+----------------------------------------------------------------------------------+
//|                                                                      boucles.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


void OnInit(){
   
   int count = 0;
   while(count < 10){
      
      Print(count);
      count ++;
   
   }
   
   string word = "a";
   do{
      
      Print(word);
      word += "a";
   
   } while(word != "aaaa");
   
   
   for(int i = 10; i >= 0; i -= 2){
      Print(i);
   }
   
}