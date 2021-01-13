//+----------------------------------------------------------------------------------+
//|                                                                       events.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

void OnInit(){
   
   Print("Start");
   
}

void OnTick(){

   Comment("Running");
   
}

void OnDeinit(const int reason){
   
   Print((string)reason);
   
}