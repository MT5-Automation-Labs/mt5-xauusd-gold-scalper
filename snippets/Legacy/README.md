# Legacy

`Condition.mqh` is the older condition API. Its `IsPass` takes only a bar index, and it defines its own `OrCondition`.

The templates and the rest of this library use [Conditions](../Conditions/README.md), where `IsPass(period, date)` is the current signature. Include `Legacy/Condition.mqh` only when compiling a source that was written against that older type. Do not include it in the same file as `Conditions/OrCondition.mqh`.
