# Streams

A stream is a series addressed by bar index. Conditions and plots read streams instead of calling `iClose` or `iMA` directly. `TIStream<T>` is the typed interface (`GetValues`, `GetSeriesValues`, reference counting). `IBarStream` is the OHLC view.

Most files in this folder are one series: price (`PriceStream`, `SimplePriceStream`, `BarStream`, `HABarStream`, `RenkoStream`), moving statistics (`StDevStream`, `VarianceOnStream`, `SumOnStream`), pivots, crosses, and built-in indicators (`MACDStream`, `RSIStream`, `StochStream`, `CCIStream`, `OBVStream`, `MAStream`).

## Subfolders

| Folder | Contents |
| --- | --- |
| `Interfaces/` | `TIStream`, plus datetime, color, and string stream interfaces |
| `Abstract/` | `TAStream`, `AFloatStream`, `AStringStream`, `AColorStream`, `ADateTimeStream` |
| `Averages/` | Moving averages on another stream: SMA, EMA, RMA, WMA, VWMA, VWAP, ALMA, DEMA, TEMA, Hull, SWMA, plus true range, MFI, TSI, RSI, and linear regression. `AveragesStreamFactory` picks one from `Enums/MATypes.mqh` |
| `Oscillators/` | RSI, Williams %R, ROC, DMI/ADX, Supertrend, Bollinger bandwidth, deviation, correlation, percent rank |
| `Indicators/` | Parabolic SAR (`SARStream`) |
| `Condition/` | `ConditionStreamV2` and `CrossStreamV2`, which expose a condition as an integer stream |
| `Custom/` | Hand-filled buffers: `FloatStream`, `IntStream`, `BoolStream`, `ColorStream`, `TStream`, and wrappers between those types |
| `Object/` | Streams of strings, labels, lines, and label arrays for Pine drawing objects |
| `Plots/` | `ColoredPlot`, a sectioned plot used where a single MetaTrader plot color is too coarse |

`AOnStream` is the base for a stream computed from another stream. `StreamBuffer` is the internal storage those classes write into. `PriceStreamFactory` builds a price stream for a symbol and timeframe.

Include the full path, for example `Streams/Averages/SMAOnStream.mqh` or `Streams/Oscillators/DMIOnStream.mqh`.
