//+----------------------------------------------------------------------------------+
//|                                                                        email.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+


void OnInit(){
   
   string subject = "MT5 email";
   string content = "Message envoyé depuis MetaTrader5.";
   
   if(!SendMail(subject, content)){
      
      Print(subject);
      Print(content);
      
   }

}