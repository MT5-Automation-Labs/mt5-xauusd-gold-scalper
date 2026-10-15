#include <Streams/Averages/SMAOnStream.mqh>
#include <Streams/Averages/TemaOnStream.mqh>
#include <Streams/Averages/VwmaOnStream.mqh>
#include <Streams/Averages/HullOnStream.mqh>
#include <Streams/Averages/RmaOnStream.mqh>
#include <Streams/Averages/DEMAOnStream.mqh>
#include <Streams/Averages/LinearRegressionOnStream.mqh>
#include <Streams/Averages/EMAOnStream.mqh>
#include <Enums/MATypes.mqh>

// AveragesStreamFactory v2.0

class AveragesStreamFactory
{
public:
   static TIStream<double>* Create(MATypes method, TIStream<double>* source, TIStream<double>* volumeSource, int period)
   {
      switch (method)
      {
         case ma_sma:
            return new SmaOnStream(source, period);
         case ma_ema:
            return new EMAOnStream(source, period);
         case ma_tema:
            return new TemaOnStream(source, period);
         case ma_vwma:
            return new VwmaOnStream(source, volumeSource, period);
         case ma_hull:
            return new HullOnStream(source, period);
         case ma_rma:
            return new RmaOnStream(source, period);
         case ma_dema:
            return new DEMAOnStream(source, period);
         case ma_linr:
            return new LinearRegressionOnStream(source, period);
      }
      return NULL;
   }
};