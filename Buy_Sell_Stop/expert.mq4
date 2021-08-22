//+------------------------------------------------------------------+
//|                                                         hilo.mq4 |
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

extern double LotSize = 0.1;
extern int TakeProfit = 80;
extern int StopLoss = 40;
extern int Distance_pip = 10;

double hi,lo,hi_for_order, lo_for_order;
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
   hi=iHigh(NULL,1440,1);
   lo=iLow(NULL,1440,1);
   hi_for_order = hi+Distance_pip*Point;
   lo_for_order = lo - Distance_pip*Point;
   
   if(Hour()==0 && Minute()==0 && (Seconds()>=0 && Seconds()<60))
   SellStopPosition();
   BuyStopPosition();
   
   if(Hour()==23 &&(Minute()>=0 && Minute()<60))
   Delete_Order();
  }
//+------------------------------------------------------------------+

void SellStopPosition(){

if(OrdersTotal()>1)
return;

OrderSend(Symbol(),OP_SELLSTOP,LotSize,lo_for_order,3,lo_for_order+StopLoss*Point,lo_for_order-TakeProfit*Point,"Sell Pos",16384,0,Red);


}

void BuyStopPosition(){

if(OrdersTotal()>1)
return;

OrderSend(Symbol(),OP_BUYSTOP,LotSize,hi_for_order,3,hi_for_order-StopLoss*Point,hi_for_order+TakeProfit*Point,"Buy Pos",16384,0,Green);


}
void Delete_Order(){
for(int i = 0; i<OrdersTotal();i++){
 
 OrderSelect(i , SELECT_BY_POS,MODE_TRADES );
 if((OrderType()==OP_BUYSTOP) || (OrderType()==OP_SELLSTOP))
 OrderDelete(OrderTicket());

}


}