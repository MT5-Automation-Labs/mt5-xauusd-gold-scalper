# Money management

Stop, target, and position-size strategies used by `templates/experts/EA_Base.mq5`. `Functions.mqh` is the factory: `CreateStopLossStrategy` and the matching take-profit and lot helpers.

| Area | Files |
| --- | --- |
| Stops | `IStopLossStrategy.mqh`, `DefaultStopLossStrategy.mqh` (off, percent, pips, absolute price), `DollarStopLossStrategy.mqh`, `RiskBalanceStopLossStrategy.mqh`, `IStopLossAndAmountStrategy.mqh`, `PositionSizeRiskStopLossAndAmountStrategy.mqh` |
| Targets | `ITakeProfitStrategy.mqh`, `DefaultTakeProfitStrategy.mqh`, `RiskToRewardTakeProfitStrategy.mqh`. `ATRTakeProfitStrategy.mqh` is in this folder; the `TPAtr` branch in `Functions.mqh` is commented out |
| Lots | `ILotsProvider.mqh`, `DefaultLotsProvider.mqh`, `RiskLotsProvider.mqh` |
| Bundle | `IMoneyManagementStrategy.mqh`, `MoneyManagementStrategy.mqh`, `Functions.mqh` |

`Functions.mqh` still has commented branches for a high-low stop and an ATR stop. Those classes are not in this tree, so the branches stay commented and the factory does not return them.
