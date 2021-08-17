//+----------------------------------------------------------------------------------+
//|                                                                   operations.mq5 |
//|                                       https://github.com/victor-algo/channel.git |
//|                         https://www.youtube.com/channel/UCmpooeG7KV1pgHFIkG5mJfA |
//+----------------------------------------------------------------------------------+

void OnInit(){
   
   int a = 8;
   int b = 2;
   
   int somme = a + b;
   int difference = a - b;
   int multiple = a * b;
   int quotient = a / b;
   int modulo = a % b;
   
   a += 2;
   b --;
   
   string phrase = "Une" + " phrase" + ".";
   
   Print(somme);
   Print(difference);
   Print(multiple);
   Print(quotient);
   Print(modulo);
   Print(a);
   Print(b);
   Print(phrase);

   int c = 9;
   double d = (double)c;
   string e = (string)c;
   int f = (int)'R';
   datetime g = (datetime)0;
   
   Print(c);
   Print(d);
   Print(e);
   Print(f);
   Print(g);

   Print(a < b);
   Print(a >= b);
   Print(a == b);
   Print(a != b);

}