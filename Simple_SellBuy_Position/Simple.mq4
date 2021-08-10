//+------------------------------------------------------------------+
//|                                                 first_expert.mq4 |
//|                        Copyright 2021, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2021, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

extern double LOTSIZE = 0.1;
extern int TakeProfit = 90;
extern int StopLoss = 45;
int OnInit()
  {
//---
   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
//---
   if(Volume[0]>1)
   return;
   
   if((Close[1]>Open[1]) && (Close[2]>Open[2]) && (Close[1]>Close[2]))
   BuyPosition();
   
   if((Close[1]<Open[1])&&(Close[2]<Open[2])&&(Close[1]<Close[2]))
   SellPosition();
   
   
   //return 0;
  }
  
//+------------------------------------------------------------------+

void BuyPosition(){


   if(OrdersTotal()>0)
   return;
   
   OrderSend(Symbol(),OP_BUY,LOTSIZE,Ask,3,Ask-StopLoss*Point ,Ask+TakeProfit*Point,"My_Buy_Position" , 16384 , 0 , Green );

}

void SellPosition(){

   if(OrdersTotal()>0)
   return;
   
   OrderSend(Symbol(),OP_SELL,LOTSIZE,Bid,3,Bid+StopLoss*Point,Bid-TakeProfit*Point,"MY_SELL_POSITION",16384,0,Red);
   

}

}