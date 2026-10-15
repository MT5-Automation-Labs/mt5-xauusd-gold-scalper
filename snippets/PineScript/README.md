# Pine Script

MQL5 counterparts of Pine Script built-ins, used when a TradingView script is ported onto MetaTrader 5.

| File | Pine equivalent |
| --- | --- |
| `Str.mqh` | `str.*` |
| `SymInfo.mqh` | `syminfo.*` |
| `Time.mqh` | time helpers |
| `Timeframe.mqh` | `timeframe.*` |
| `Session.mqh` | session strings |
| `MathEx.mqh` | extra math helpers |
| `PlotShape.mqh` | `plotshape` |
| `StrategyAsIndicator.mqh` | `strategy.*` events expressed as indicator signals |

Color packing, transparency, and `na`-style checks used by these objects live in `Utils/PineScriptUtils.mqh`. The small `syminfo.mintick` helper is `Utils/Syminfo.mqh`.

## Array

Pine-style arrays in `Array/`: `Array`, `FloatArray`, `IntArray`, `StringArray`, `ColorArray`, `BoxArray`, `LineArray`, `LabelArray`, `ChartPointArray`, `PolylineArray`, and `CustomTypeArray`. Each has a matching `I*` interface. `ILineArray.mqh` includes `PineScript/Objects/Line.mqh`.

## Matrix

`Matrix/Matrix.mqh`, `SimpleTypeMatrix.mqh`, and `TableMatrix.mqh`, plus their interfaces.

## Objects

Chart drawings in `Objects/`: `Line`, `LineFill`, `Label`, `Box`, `Table`, `Polyline`, `ChartPoint`, and the collections that own them (`LinesCollection`, `LabelsCollection`, `BoxesCollection`, `LinefillsCollection`, `PolyLinesCollection`). `IObjectDestructor.mqh` is how `Variables/` releases those objects.

## Variables

`Variables/SimpleTypeVariable.mqh` holds a value type and remembers whether it was set. `Variables/CustomTypeVariable.mqh` holds a drawing object and destroys it through `IObjectDestructor`.

```mql5
#include <PineScript/Variables/SimpleTypeVariable.mqh>

SimpleTypeVariable<double>* priceVar = new SimpleTypeVariable<double>(0.0, NULL);
priceVar.Set(1.2345);
if (priceVar.IsInitialized())
{
   double currentPrice = priceVar.Get();
}
priceVar.Clear();
```
