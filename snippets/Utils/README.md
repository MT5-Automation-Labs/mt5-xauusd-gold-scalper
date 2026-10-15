# Utils

Small helpers shared by conditions, trading, streams, and the Pine Script layer.

| File | Role |
| --- | --- |
| `InstrumentInfo.mqh` | Point size, pip size, digits, tick size, and lot comparison for one symbol |
| `Routines.mqh` | `AddPeriods`, which shifts a `datetime` by a number of bars of a given timeframe |
| `SafeMath.mqh` | Pine-style `Nz` and arithmetic (`SafePlus`, `SafeMinus`, `SafeMathMin`, `SafeMathMax`, `SafeMathPow`, `SafeMathSqrt`, `SafeMathRound`, `SafeMathFloor`, `SafeMathCeil`). Undefined inputs return `EMPTY_VALUE` or `INT_MIN` |
| `PineScriptUtils.mqh` | `ColorRGB`, channel extractors, transparency, `NumberToBool`, and `FirstBarState` |
| `Syminfo.mqh` | `SyminfoMintick`, the Pine `syminfo.mintick` value (point, times 10 on 3- and 5-digit quotes) |
| `ToString.mqh` | `ToString` overloads, including a `"percent"` format |

The fuller Pine `syminfo.*` object is `PineScript/SymInfo.mqh`. This folder only has the mintick function.
