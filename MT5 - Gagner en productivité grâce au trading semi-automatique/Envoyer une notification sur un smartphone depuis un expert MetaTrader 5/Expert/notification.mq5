//+--------------------------------------------------------------+
//|                                             notification.mq5 |
//|                   https://github.com/victor-algo/channel.git |
//|     https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+--------------------------------------------------------------+


void OnInit(){
   
   string content = "Message envoyé depuis MetaTrader5.";
   
   if(!SendNotification(content)){
      
      Print(content);
   
   }
}