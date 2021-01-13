//+----------------------------------------------------------------------------------+
//|                                                                   martingale.mqh |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

struct martingale{
   
   string symbolName;
   ulong lastTicket;

};

martingale createMartingale(string symbolName){

   martingale m;
   m.symbolName = symbolName;
   m.lastTicket = 0;
   return m;

}