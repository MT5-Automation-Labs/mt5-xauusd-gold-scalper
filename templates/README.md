# Templates

Skeletons for MetaTrader 5 expert advisors and indicators. Copy one file into the terminal, then fill in the strategy. The files are not meant to be compiled unchanged.

Install `snippets/` first. The steps are in the [repository README](../README.md).

## Experts

| File | Role |
| --- | --- |
| [experts/EA_Base.mq5](experts/EA_Base.mq5) | Multi-symbol expert advisor. Stops, targets, net stops, trailing, martingale, session filters, exit logic, close-on-opposite, and alerts are each gated by a `#define` at the top of the file. |

Entry logic goes in `EntryLongCondition` and `EntryShortCondition`, or in the `CreateLongCondition` / `CreateShortCondition` factories. Exit logic goes in the `CreateExit*Condition` factories. Compose rules from `snippets/Conditions/` with `AndCondition`, `OrCondition`, and `NotCondition`, and register side effects with `actions.AddActionOnCondition`.

## Indicators

| File | Role |
| --- | --- |
| [indicators/Indicator.mq5](indicators/Indicator.mq5) | Separate-window indicator with one buffer, a bar limit, and a unique object-name prefix. |
| [indicators/ArrowsIndicator.mq5](indicators/ArrowsIndicator.mq5) | Signal arrows plus popup, push, email, sound, and optional external alerts. Implement `UpAlertCondition` and `DownAlertCondition`. |
| [indicators/Dashboard.mq5](indicators/Dashboard.mq5) | Symbol-by-timeframe scanner drawn as a colored grid. Implement `IsPass` on `UpCondition` and `DownCondition`, produced by `ConditionFactory`. |
| [indicators/Heatmap.mq5](indicators/Heatmap.mq5) | Heatmap plot. Implement `LongCondition` and `ShortCondition`. Values are mapped by `Chart/HeatMapValueCalculator.mqh`. |

## Where to write code

Search the template for `TODO`. Those markers are the only places a strategy should land. Feature inputs stay inside the matching `#ifdef` / `#else` pair so a disabled feature still declares the same variable names.

Compile with MetaEditor 5 and run the result on a demo account before using it on a live one.
