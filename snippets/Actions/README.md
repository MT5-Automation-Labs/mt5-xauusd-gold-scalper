# Actions

`IAction` is the work that runs when a condition passes. `DoAction(period, date)` returns whether the action completed. `AAction` and `AOrderAction` supply the reference counting.

Register a pair from the expert advisor:

```mql5
actions.AddActionOnCondition(action, condition);
```

| File | Role |
| --- | --- |
| `IAction.mqh` | Interface |
| `AAction.mqh` | Reference-counted base |
| `AOrderAction.mqh` | Base for actions that see the new position ticket |
| `EntryAction.mqh` | Opens a position through an `IEntryStrategy` |
| `CloseTradeAction.mqh` | Closes one trade |
| `CloseAllAction.mqh` | Closes every matching trade |
| `CreateTrailingAction.mqh` | Attaches a trailing stop. The start can be pips or a percent of the stop |
| `TrailingPipsAction.mqh` | Holds the stop a fixed pip distance from price |
| `MoveStopLossAction.mqh` | Moves a stop loss |
| `MoveToBreakevenAction.mqh` | Moves the stop to breakeven |
| `MoveStopLossOnProfitOrderAction.mqh` | Moves the stop after the trade is in profit |
| `MoveNetStopLossAction.mqh` | Moves the net (basket) stop |
| `MoveNetTakeProfitAction.mqh` | Moves the net (basket) target |
| `CreateMartingaleAction.mqh` | Adds a martingale position |
| `CreateHiddenTPSLControllerAction.mqh` | Starts a hidden stop and target controller |

Order actions read the current ticket from the handlers in `Trading/OrderHandlers.mqh`.
