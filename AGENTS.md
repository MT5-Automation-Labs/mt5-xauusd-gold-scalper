# AGENTS.md

## Project overview

MQL5/MetaTrader 5 template library for indicators and expert advisors.
Maintained by Victor Tereschenko (ProfitRobots), primarily to support the
[Trade Script Converter](https://convertor.profitrobots.com) and Pine Script
to MQL5 conversions (`snippets/PineScript` mirrors Pine Script APIs).

Repository: https://github.com/MT5-Automation-Labs/mt5-xauusd-gold-scalper

## Repository layout

- `templates/experts/` — expert advisor skeletons. See `templates/README.md`.
- `templates/indicators/` — indicator, arrow, dashboard, and heatmap skeletons.
- `snippets/` — reusable `.mqh` library. This directory is the include root
  once copied into `MQL5/Include`.
  - `Actions/` — `IAction` building blocks.
  - `Alerts/` — `Signaler`, `AlertSignal`.
  - `Chart/` — heatmap values and `plotchar`.
  - `Conditions/` — `ICondition` building blocks. `Patterns/` holds candle
    patterns. Most trading logic is expressed as conditions.
  - `Enums/` — shared enumerations (`OrderSide`, `StopLossType`, ...).
  - `Grid/` — dashboard cells.
  - `Legacy/Condition.mqh` — older `IsPass(period)` API. Do not mix it with
    `Conditions/OrCondition.mqh`.
  - `Logic/` — `ActionOnConditionLogic`.
  - `MoneyManagement/` — stops, targets, lots. Factory is `Functions.mqh`.
  - `PineScript/` — Pine Script arrays, matrices, objects, variables.
  - `Streams/` — bar-indexed series. Subfolders: `Interfaces`, `Abstract`,
    `Averages`, `Oscillators`, `Indicators`, `Condition`, `Custom`, `Object`,
    `Plots`.
  - `Trading/` — orders, iterators, builders, trailing, `TradingController`.
    This is not the standard-library `Trade/Trade.mqh`.
  - `TradingMonitor/` — ticket create/update/delete callbacks.
  - `Utils/` — `InstrumentInfo`, `Routines`, `SafeMath`, `PineScriptUtils`,
    `Syminfo`, `ToString`.
  - `Expert/`, `Trade/`, `Math/`, `Generic/`, `OpenCL/`, `Controls/`,
    `Graphics/`, `WinAPI/`, `Files/`, `Indicators/`, `Objects/`, `Charts/`,
    `ChartObjects/`, `Canvas/`, `Strings/`, `Tools/`, `Arrays/` — not in git.
    They are the MetaTrader 5 standard library under `MQL5/Include`.

## How the templates work

Templates are not compiled as-is.

1. Copy a template from `templates/experts/` or `templates/indicators/` into
   `MQL5/Experts` or `MQL5/Indicators`.
2. Enable or disable features via the `#define` / `#ifdef` block at the top
   of `EA_Base.mq5` (`STOP_LOSS_FEATURE`, `TAKE_PROFIT_FEATURE`,
   `NET_STOP_LOSS_FEATURE`, `NET_TAKE_PROFIT_FEATURE`, `MARTINGALE_FEATURE`,
   `TRADING_TIME_FEATURE`, `WEEKLY_TRADING_TIME_FEATURE`,
   `ACT_ON_SWITCH_CONDITION`, `WITH_EXIT_LOGIC`, `USE_MARKET_ORDERS`,
   `ADVANCED_ALERTS`). A commented-out define produces a plain variable with
   a fixed default instead of an `input`.
3. Fill trading logic at the `// TODO: implement` markers — usually
   `IsPass(const int period, const datetime date)` on condition classes
   (`EntryLongCondition`, `EntryShortCondition`, `LongCondition`,
   `ShortCondition`, `UpCondition`, `DownCondition`, ...) or by composing
   existing `ICondition` snippets inside the `Create*Condition` factories.
4. Resolve `#include <...>` before compiling, either by copying `snippets/`
   into `MQL5/Include`, or by injecting sources with
   [MQ4Inject](https://github.com/sibvic/MQ4Inject). Lines written as
   `#include /**/ <Trade\Trade.mqh>` must stay pointed at the standard library.

Advanced alerts need the
[mt-notifications-lib](https://github.com/sibvic/mt-notifications-lib) DLL
(`AdvancedNotificationsLib`).

## Key abstractions

### ICondition

`snippets/Conditions/ICondition.mqh`:

```mql5
interface ICondition
{
   virtual void AddRef() = 0;
   virtual void Release() = 0;
   virtual bool IsPass(const int period, const datetime date) = 0;
   virtual string GetLogMessage(const int period, const datetime date) = 0;
};
```

- Entry and exit logic in `templates/experts/EA_Base.mq5` is a set of
  condition classes derived from `ACondition`.
- Compose with `AndCondition`, `OrCondition`, `NotCondition` inside
  `CreateLongCondition`, `CreateShortCondition`,
  `CreateLongFilterCondition`, `CreateShortFilterCondition`, and
  `CreateExit*Condition`.
- `ActOnSwitchCondition` fires once on the rising edge
  (`ACT_ON_SWITCH_CONDITION`). `DisabledCondition` and `NoCondition` are
  neutral.
- `condition.Add(child, false)` — the second argument controls ownership.
- Prefer the conditions already in `snippets/Conditions/` (bar, bands,
  Ichimoku, MA, divergence, `Patterns/`, sessions, position limits, profit
  ranges, `StreamLevelCondition`, `StreamStreamCondition`).
- `IConditionFactory` builds per-symbol conditions for the dashboard.
- `snippets/Legacy/Condition.mqh` is the old `IsPass(period)` variant.

### IAction

`snippets/Actions/` plus `Logic/ActionOnConditionLogic`. Register with
`actions.AddActionOnCondition(action, condition)`. `AOrderAction` and
`Trading/OrderHandlers.mqh` run once per new position (`_currentTicket`).

### Streams

`TIStream` and the classes under `snippets/Streams/` are timeseries addressed
by bar index. `EntryStreamData` is passed into entry conditions.

### Trading

`CTrade tradeManager` comes from the standard library `Trade\Trade.mqh`.
`Trading/OrderBuilder.mqh` and `Trading/MarketOrderBuilder.mqh` build orders.
Account hedging versus netting matters; `NET_*_FEATURE` is the basket stop
and target, not the per-position one.

## Coding conventions

- MQL5 with `#property strict`. Includes use `#ifndef X_IMP` / `#define X_IMP`
  guards. `Alerts/Signaler.mqh` is an exception and must be included once.
- Interfaces use the `I` prefix (`ICondition`, `IAction`, `TIStream`,
  `IConditionFactory`). Abstract bases use `A` (`ACondition`,
  `AConditionBase`, `AOrderAction`, `AAction`).
- Reference counting: callers pass `I*` and call `Release()` after handing
  ownership to a container.
- Feature toggles: `#ifdef FEATURE` wraps `input` declarations, and the
  `#else` branch declares plain variables with the same names. Keep both
  branches in sync.
- Templates and snippets carry a version comment (`// Name vX.Y`). Bump it
  when editing that file.
- `input` parameters use `snake_case`. The comment after `//` is the input
  label shown in the terminal.
- Snippets include each other from the snippets root
  (`#include <Conditions/ACondition.mqh>`,
  `#include <Trading/TradingController.mqh>`).
- Folder names are PascalCase (`Enums`, `Streams/Indicators`,
  `Conditions/Patterns`).
- No build system, tests, or CI. Verification is compiling in MetaEditor 5.

## Related repositories

- MQ4Inject: https://github.com/sibvic/MQ4Inject
- fxlint: https://github.com/sibvic/fxlint
- Sibling template packs: mq4, fxts2, pinescript, nt8.
