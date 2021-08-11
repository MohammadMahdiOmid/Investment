//+------------------------------------------------------------------+
//|                                                     Project2.mq4 |
//|                      Copyright © 2008, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2008, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"

extern double LOTSIZE=0.1;
extern int TakeProfit=90;
extern int StopLoss=60;
extern int MA_period=14;
extern int MA_shift=0;
extern int MA_method=0;
extern int MA_appliedprice=0;

//+------------------------------------------------------------------+
//| expert initialization function                                   |
//+------------------------------------------------------------------+
int init()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert deinitialization function                                 |
//+------------------------------------------------------------------+
int deinit()
  {
//----
   
//----
   return(0);
  }
//+------------------------------------------------------------------+
//| expert start function                                            |
//+------------------------------------------------------------------+
int start()
  {
if (Volume[0]>1) 
   return;
double myMA=iMA(Symbol(),0,MA_period,MA_shift,MA_method,MA_appliedprice,1);
if(Close[1]<myMA)
   SellPosition();
   
if(Close[1]>myMA)
   BuyPosition();  
//----
   return(0);
  }
//+------------------------------------------------------------------+

void BuyPosition()
{
if(OrdersTotal()>0)
      return;

OrderSend(Symbol(),OP_BUY,LOTSIZE,Ask,3,Ask-StopLoss*Point,Ask+TakeProfit*Point,"My Buy Position",16384,0,Green);
}
//-----------------------------------------------------------------
void SellPosition()
{
if(OrdersTotal()>0)
      return;

OrderSend(Symbol(),OP_SELL,LOTSIZE,Bid,3,Bid+StopLoss*Point,Bid-TakeProfit*Point,"My Sell Position",16384,0,Red);
} 

