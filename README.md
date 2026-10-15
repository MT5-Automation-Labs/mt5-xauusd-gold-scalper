# mt5-XAUUSD Gold Scalper

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Platform](https://img.shields.io/badge/Platform-MetaTrader%205-blue.svg)](https://www.metatrader5.com/)
[![Language](https://img.shields.io/badge/Language-MQL5-orange.svg)](https://www.mql5.com/)

Starter Expert Advisors, indicator skeletons, and a reusable include library for MetaTrader 5.

The snippets cover the pieces that show up in almost every strategy: conditions, order construction, position sizing, trailing, and time-series access. A large part of the stream and Pine Script layers mirrors TradingView function names, so a Pine script can be ported onto MT5 without rebuilding that machinery. The library is maintained for the [Trade Script Converter](https://convertor.profitrobots.com).

Templates are starting points. They are not meant to be compiled and attached as shipped.

## Requirements

- MetaTrader 5 with MetaEditor
- The `snippets/` tree on the compiler include path (see below)


## Install the library

MetaEditor resolves `#include <Module/File.mqh>` from `MQL5/Include` in the terminal data folder.

Copy the **contents** of `snippets/` into that `Include` folder, so `Include/Trading/TradingController.mqh` exists. Do not wrap the copy in an extra directory, or every include path will be one level off.

Two ways to compile a template:

1. Copy `snippets/` into `MQL5/Include`, copy one template into `MQL5/Experts` or `MQL5/Indicators`, then compile in MetaEditor.
2. Inject the snippet sources into the template with 
 Lines marked `#include /**/` are the MetaTrader standard library (`Trade\Trade.mqh` and similar). Leave those for the terminal; do not inject them.

The standard library folders (`Trade`, `Expert`, `Math`, `Generic`, and the rest) are not stored in this repository. MetaTrader already ships them.

## Use a template

1. Pick a file from [templates/](templates/README.md).
2. Copy it into `MQL5/Experts` or `MQL5/Indicators`.
3. Turn features on or off with the `#define` block at the top of the Expert Advisor. Each feature wraps its `input` parameters in `#ifdef`. A disabled feature falls back to plain variables with fixed defaults, so the file still compiles.
4. Put the strategy in the `// TODO: implement` markers. Expert Advisors implement `IsPass` on the entry condition classes, or assemble `ICondition` blocks inside the `Create*Condition` factories. Indicators do the same inside `OnCalculate` or the alert condition classes.
5. Compile in MetaEditor and test on a demo account.

Expert Advisor switches in `templates/experts/EA_Base.mq5`:

| Define | What it adds |
| --- | --- |
| `STOP_LOSS_FEATURE` | Per-trade stop loss |
| `TAKE_PROFIT_FEATURE` | Per-trade take profit |
| `NET_STOP_LOSS_FEATURE` | Account-level net stop |
| `NET_TAKE_PROFIT_FEATURE` | Account-level net target |
| `MARTINGALE_FEATURE` | Martingale lot sizing |
| `TRADING_TIME_FEATURE` | Intraday session filter |
| `WEEKLY_TRADING_TIME_FEATURE` | Day-of-week filter |
| `ACT_ON_SWITCH_CONDITION` | Fire on the rising edge of a condition |
| `WITH_EXIT_LOGIC` | Exit condition factories |
| `USE_MARKET_ORDERS` | Market orders through `MarketOrderBuilder` |
| `ADVANCED_ALERTS` | External alerts through the notifications DLL |

## Repository layout

```text
templates/
  experts/                 Expert Advisor skeletons
  indicators/              Indicator, arrow, dashboard, and heatmap skeletons
snippets/                  Include library. This folder is the include root.
  Actions/                 Work to do when a condition passes
  Alerts/                  Popup, push, email, sound, and external alerts
  Chart/                   Heatmap values and plotchar-style chart text
  Conditions/              Entry, exit, and filter rules
  Enums/                   Shared enumerations
  Grid/                    Dashboard cell grid
  Legacy/                  Previous condition API, kept for old sources
  Logic/                   Binds an action to a condition
  MoneyManagement/         Stops, targets, and lot size
  PineScript/              Pine Script objects, arrays, and helpers
  Streams/                 Bar-indexed series (price, averages, oscillators)
  Trading/                 Orders, positions, trailing, and the trade controller
  TradingMonitor/          Watches tickets as they open, change, and close
  Utils/                   Symbol info, safe math, color helpers, time routines
```

Module notes live in `snippets/README.md` and in each folder's `README.md`.

## Include convention

Includes are absolute from the `snippets/` root:

```mql5
#include <Conditions/ACondition.mqh>
#include <Trading/TradingController.mqh>
#include <Enums/OrderSide.mqh>
```

`Conditions`, `Actions`, `Streams`, and `Trading` are the names to use in new code. Reference-counted objects (`ICondition`, `IAction`, stream interfaces) use `AddRef()` and `Release()` rather than a bare `delete` once another object owns them.

## Path changes

Headers that used to sit loose in `snippets/` now live in a module folder. If you already have a copy of this library under `MQL5/Include`, update those includes and remove the old root files so MetaEditor does not compile a stale copy.

| Previous path | Current path |
| --- | --- |
| `Signaler.mqh`, `AlertSignal.mqh` | `Alerts/` |
| `TradingController.mqh`, `OrderBuilder.mqh`, `MarketOrderBuilder.mqh`, iterators, entry strategies, trailing and breakeven controllers | `Trading/` |
| `InstrumentInfo.mqh`, `PineScriptUtils.mqh`, `SafeMath.mqh`, `Syminfo.mqh` | `Utils/` |
| `routines.mqh` | `Utils/Routines.mqh` |
| `HeatMapValueCalculator.mqh`, `PlotChar.mqh` | `Chart/` |
| `Condition.mqh` | `Legacy/Condition.mqh` |
| `enums/` | `Enums/` |
| `Streams/indicators/` | `Streams/Indicators/` |
| `Conditions/patterns/` | `Conditions/Patterns/` |
| `Conditions/bar_conditions.mqh` | `Conditions/BarConditions.mqh` |
| `Conditions/bb_conditions.mqh` | `Conditions/BbConditions.mqh` |
| `Conditions/ma_conditions.mqh` | `Conditions/MaConditions.mqh` |
| `Conditions/ich_conditions.mqh` | `Conditions/IchimokuConditions.mqh` |
| `Conditions/divergence_conditions.mqh` | `Conditions/DivergenceConditions.mqh` |
| `MoneyManagement/functions.mqh` | `MoneyManagement/Functions.mqh` |
| `templates/EA_Base.mq5` | `templates/experts/EA_Base.mq5` |
| `templates/indicator.mq5` | `templates/indicators/Indicator.mq5` |
| `templates/arrows_indicator.mq5` | `templates/indicators/ArrowsIndicator.mq5` |
| `templates/dashboard.mq5` | `templates/indicators/Dashboard.mq5` |
| `templates/heatmap.mq5` | `templates/indicators/Heatmap.mq5` |

`MartingaleLotSizingType.mqh` existed twice. The root copy was removed. Include `Enums/MartingaleLotSizingType.mqh`.

`Trading/Trade.mqh` is this project's order model. `#include /**/ <Trade\Trade.mqh>` is still the terminal `CTrade` class. The two paths no longer share a filename at the include root.


## License

MIT. Copyright (c) 2019 Victor Tereschenko. See [LICENSE](LICENSE).
