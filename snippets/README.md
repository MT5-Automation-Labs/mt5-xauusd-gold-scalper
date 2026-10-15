# Snippets

Include library for the templates in this repository. Copy this folder's **contents** into `MQL5/Include`. Every `#include <...>` path below is relative to that root.

| Module | Responsibility |
| --- | --- |
| [Actions](Actions/README.md) | `IAction` implementations: entries, closes, trailing, martingale, net stops |
| [Alerts](Alerts/README.md) | Popup, push, email, sound, and external notifications |
| [Chart](Chart/README.md) | Heatmap buffer values and Pine-style `plotchar` text |
| [Conditions](Conditions/README.md) | `ICondition` rules used for entries, exits, and filters |
| [Enums](Enums/README.md) | Order side, price source, stops, targets, lot sizing |
| [Grid](Grid/README.md) | Cells and rows for the dashboard template |
| [Legacy](Legacy/README.md) | Older condition types. New code uses `Conditions/` |
| [Logic](Logic/README.md) | Runs an `IAction` when an `ICondition` passes |
| [MoneyManagement](MoneyManagement/README.md) | Stop, target, and lot-size strategies |
| [PineScript](PineScript/README.md) | Pine Script arrays, matrices, drawing objects, and `str` / `syminfo` helpers |
| [Streams](Streams/README.md) | Values addressed by bar index |
| [Trading](Trading/README.md) | Orders, iterators, trailing, breakeven, and `TradingController` |
| [TradingMonitor](TradingMonitor/README.md) | Callbacks when a ticket is created, changed, or removed |
| [Utils](Utils/README.md) | Symbol math, safe numeric helpers, colors, and time shifts |

## How a strategy is assembled

1. A stream (`Streams/`) exposes a value at a bar index.
2. A condition (`Conditions/`) reads streams, prices, or positions and returns `IsPass`.
3. An action (`Actions/`) places, modifies, or closes an order when that condition passes.
4. `Logic/ActionOnConditionLogic` holds the pairs. `Trading/TradingController` drives them from the expert advisor.

Objects that expose `AddRef()` and `Release()` are shared. Call `Release()` after handing ownership to a container. `condition.Add(child, false)` takes ownership of the child; follow the factories already in `templates/experts/EA_Base.mq5`.

## Standard library

`#include /**/ <Trade\Trade.mqh>` is MetaTrader's `CTrade`. The `/**/` marker tells [MQ4Inject](https://github.com/sibvic/MQ4Inject) to leave the line untouched. This repository's own order type is `Trading/Trade.mqh`.
