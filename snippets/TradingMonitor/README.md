# Trading monitor

Watches the account and reports ticket changes to an `IAction`.

| File | Role |
| --- | --- |
| `ITicketTarget.mqh` | `SetTicket(ticket)` — the ticket the closed-trade action should use |
| `TicketTarget.mqh` | Default target |
| `TradingMonitor.mqh` | Compares open orders, open positions, and closed trades with the previous pass |

`SetOnNewTrade`, `SetOnTradeChanged`, and `SetOnClosedTrade` take an `IAction`. The closed-trade setter also takes an `ITicketTarget`. Call `DoWork()` on each tick. The destructor calls `Release()` on the actions it owns.
