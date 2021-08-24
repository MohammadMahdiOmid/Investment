//+------------------------------------------------------------------+
//|                                                     Project6.mq4 |
//|                                      Seyed Amir Babak Teymourian |
//|                                         http://www.amirbabak.com |
//+------------------------------------------------------------------+
#property copyright "Seyed Amir Babak Teymourian"
#property link      "http://www.amirbabak.com"

extern double LOTSIZE=0.1;
extern int TakeProfit=80;
extern int StopLoss=40;
extern int Distance_Pip=20;
extern int TrailingStop=15;

double hi,lo,hi_for_order,lo_for_order;
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
 trail(); 
 
if(Volume[0]>1)
   return;
   
hi=iHigh(NULL,1440,1);
lo=iLow(NULL,1440,1);
hi_for_order=hi+Distance_Pip*Point;
lo_for_order=lo-Distance_Pip*Point;
Comment("high=",hi,
        "\nlow=",lo,
        "\nhi order=",hi_for_order,
        "\nlo order=",lo_for_order);
       
if(Hour()==0 && Minute()==0 && (Seconds()>=0 && Seconds()<60)) 
{
SellStopPosition();
BuyStopPosition();
}
if(Hour()==23 && (Minute()>=0 && Minute()<60))
        Delete_BS_And_SS_Orders();

   return(0);
  }
//+------------------------------------------------------------------+

void SellStopPosition()
{
if(OrdersTotal()>1)
      return;

OrderSend(Symbol(),OP_SELLSTOP,LOTSIZE,lo_for_order,3,lo_for_order+StopLoss*Point,lo_for_order-TakeProfit*Point,"My SellStop Position",16384,0,Red);

}
//-----------------------------------------------------------------
void BuyStopPosition()
{
if(OrdersTotal()>1)
      return;

OrderSend(Symbol(),OP_BUYSTOP,LOTSIZE,hi_for_order,3,hi_for_order-StopLoss*Point,hi_for_order+TakeProfit*Point,"My BuyStop Position",16384,0,Green);

}

void Delete_BS_And_SS_Orders()
{
   for (int i = 0; i < OrdersTotal(); i++)
     {
     OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
     if ((OrderType()==OP_BUYSTOP)  ||  (OrderType()==OP_SELLSTOP)) 
       OrderDelete(OrderTicket());
      }
       
}

void trail()
{
 for(int cnt=0;cnt<OrdersTotal();cnt++)
     {
      OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
        {
         if(OrderType()==OP_BUY)   // long position is opened
           {
            // check for trailing stop
            if(TrailingStop>0)  
              {                 
               if(Bid-OrderOpenPrice()>Point*TrailingStop)
                 {
                  if(OrderStopLoss()<Bid-Point*TrailingStop)
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Bid-Point*TrailingStop,OrderTakeProfit(),0,Green);
                     return(0);
                    }
                 }
              }
           }
           
         else if(OrderType()==OP_SELL) // go to short position
           {

            // check for trailing stop
            if(TrailingStop>0)  
              {                 
               if((OrderOpenPrice()-Ask)>(Point*TrailingStop))
                 {
                  if((OrderStopLoss()>(Ask+Point*TrailingStop)) || (OrderStopLoss()==0))
                    {
                     OrderModify(OrderTicket(),OrderOpenPrice(),Ask+Point*TrailingStop,OrderTakeProfit(),0,Red);
                     return(0);
                     }
                 }
              }
           }
        }
     }
 }
 