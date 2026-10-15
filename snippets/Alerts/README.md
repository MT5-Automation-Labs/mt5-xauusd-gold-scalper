# Alerts

Notification delivery for indicators and expert advisors.

| File | Role |
| --- | --- |
| `Signaler.mqh` | Popup, push, email, sound, an external program, and optional advanced alerts |
| `AlertSignal.mqh` | Draws an arrow when a condition passes and sends the matching alert |

`Signaler` accepts a frequency of `"all"`, `"once_per_bar"`, or `"once_per_bar_close"`.

```mql5
#include <Alerts/Signaler.mqh>

Signaler* signaler;

int OnInit()
{
   signaler = new Signaler("once_per_bar");
   signaler.EnablePopupAlert(true);
   signaler.EnableNotificationAlert(true);
   return INIT_SUCCEEDED;
}

void OnDeinit(const int reason)
{
   delete signaler;
}

void OnTick()
{
   signaler.SendNotifications("Signal", "EURUSD buy");
}
```

External alerts (Telegram, Discord, and other endpoints) need `#define ADVANCED_ALERTS` and [mt-notifications-lib](https://github.com/sibvic/mt-notifications-lib). Enable them with `EnableAdvanced(true, key, server)`.

`Signaler.mqh` has no include guard. Include it once per compiled file.
