# Trading

Order and position runtime used by the expert advisor template. MetaTrader's `CTrade` stays at `Trade\Trade.mqh` (standard library). This folder is the project's own order model and controllers.

| File | Role |
| --- | --- |
| `TradingController.mqh` | Drives entries, exits, trailing, breakeven, and condition actions for one symbol |
| `TradingCalculator.mqh` | Price, pip, stop, target, and lot calculations |
| `TradingCommands.mqh` | Close, modify, and related trade commands |
| `Trade.mqh` | Open-position record |
| `Order.mqh` | Order record |
| `OrderBuilder.mqh` | Builds a pending-order request |
| `MarketOrderBuilder.mqh` | Builds a market-order request |
| `OrderHandlers.mqh` | Actions invoked for each newly opened position |
| `IEntryStrategy.mqh` | Entry strategy interface |
| `MarketEntryStrategy.mqh` | Enters at market through `MarketOrderBuilder` |
| `PendingEntryStrategy.mqh` | Enters with a pending order through `OrderBuilder` |
| `EntryPositionController.mqh` | Applies entry conditions and the entry strategy |
| `ICloseOnOppositeStrategy.mqh` | What to do when the opposite signal appears |
| `DoCloseOnOppositeStrategy.mqh` | Closes the open side |
| `DontCloseOnOppositeStrategy.mqh` | Leaves the open side alone |
| `TradesIterator.mqh` | Walks open positions |
| `OrdersIterator.mqh` | Walks pending orders |
| `ClosedTradesIterator.mqh` | Walks history |
| `TrailingController.mqh` | Moves stops as price advances |
| `BreakevenController.mqh` | Moves stops to breakeven |

Hedging and netting accounts behave differently. The `NET_STOP_LOSS_FEATURE` and `NET_TAKE_PROFIT_FEATURE` switches in the expert advisor template are the basket-level stops, and they are separate from the per-position stop and target.
