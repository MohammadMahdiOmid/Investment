//+------------------------------------------------------------------+
//|                                                     Project3.mq4 |
//|                      Copyright © 2008, MetaQuotes Software Corp. |
//|                                        http://www.metaquotes.net |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2008, MetaQuotes Software Corp."
#property link      "http://www.metaquotes.net"
extern double LOTSIZE=0.1;
extern int TakeProfit=90;
extern int StopLoss=45;

extern int MA_Period=21;

extern int RSI_Period=14;
extern double saghf=70;
extern double kaf=30;

extern int shift=1;

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
     
double myMA=iMA(Symbol(),0,MA_Period,10,2,1,shift);
double myRSI=iRSI(Symbol(),0,RSI_Period,0,shift);
Print("the MA value on ",shift," candle before,is ",myMA,"\nthe RSI value is ",myRSI);


if( (Close[shift]<myMA)  &&  (myRSI<kaf) )
        BuyPosition();

if( (Close[shift]>myMA)  &&  (myRSI>saghf) )
        SellPosition();        


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

