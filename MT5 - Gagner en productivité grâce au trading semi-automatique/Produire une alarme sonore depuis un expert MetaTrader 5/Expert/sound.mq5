//+---------------------------------------------------------------+
//|                                                     sound.mq5 |
//|                    https://github.com/victor-algo/channel.git |
//|      https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+---------------------------------------------------------------+


void OnInit(){
  
  string fileName = "alert.wav";
  
  if(!PlaySound(fileName)){
   
   Print(fileName + " n'existe pas.");
  
  }
}