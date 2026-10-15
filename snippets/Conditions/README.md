# Conditions

Rules that answer `IsPass(period, date)`. Expert advisors, arrow indicators, the dashboard, and the heatmap all express strategy logic as conditions.

```mql5
interface ICondition
{
   virtual void AddRef() = 0;
   virtual void Release() = 0;
   virtual bool IsPass(const int period, const datetime date) = 0;
   virtual string GetLogMessage(const int period, const datetime date) = 0;
};
```

`ACondition` and `AConditionBase` are the bases. Combine conditions with `AndCondition`, `OrCondition`, and `NotCondition`. `NoCondition` and `DisabledCondition` are neutral placeholders. `ActOnSwitchCondition` passes once, on the rising edge. `ConditionBuilder` parses a string such as `1 and 2 or 3`.

`IConditionFactory` builds a condition for one symbol and timeframe. The dashboard template uses it.

## Ready-made rules

| File | Role |
| --- | --- |
| `TradingTimeCondition.mqh` | Session filter. Build it with `TradingTimeFactory::Create`. Times are `HHMM`, ranges use `-`, and several ranges are separated by `,` |
| `TimeSessionCondition.mqh` | Session window on a stream of bar times |
| `StreamLevelCondition.mqh` | Compares a stream with a level |
| `StreamStreamCondition.mqh` | Compares two streams |
| `ProfitInRangeCondition.mqh` | True when a position's profit sits inside a range |
| `PositionLimitHitCondition.mqh` | True when the open-position cap is reached |
| `MinDistanceSinceLastTradeCondition.mqh` | Requires a minimum gap since the last trade |
| `MaxDistanceBetweenConditionsCondition.mqh` | Passes only when two conditions are at most N bars apart |
| `BarConditions.mqh` | Candle body checks, including a minimum body size |
| `BbConditions.mqh` | Bollinger Band comparisons |
| `MaConditions.mqh` | Moving-average comparisons |
| `IchimokuConditions.mqh` | Ichimoku line comparisons |
| `DivergenceConditions.mqh` | Regular and hidden divergence |
| `Patterns/AscendingBarCondition.mqh` | Bullish candle (`close > open`) |
| `Patterns/DescendingBarCondition.mqh` | Bearish candle (`close < open`) |

The previous `IsPass(period)` types live in [Legacy](../Legacy/README.md). New strategies should use this folder.
