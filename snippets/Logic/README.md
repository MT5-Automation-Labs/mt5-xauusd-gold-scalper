# Logic

Connects an `IAction` to an `ICondition`.

| File | Role |
| --- | --- |
| `ActionOnConditionController.mqh` | One action and one condition |
| `ActionOnConditionLogic.mqh` | The list of those pairs. `AddActionOnCondition` registers a pair. `DoLogic(period, date)` runs every pair whose condition passes |

`Trading/TradingController` owns an `ActionOnConditionLogic` and calls `DoLogic` from the expert advisor loop.
