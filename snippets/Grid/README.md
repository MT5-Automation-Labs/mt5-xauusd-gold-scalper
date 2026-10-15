# Grid

On-chart table used by `templates/indicators/Dashboard.mq5`. A grid is a set of rows; each row is a set of cells. `GridBuilder` assembles them. `TrendValueCellFactory` and `TextValueCell` cover the usual scanner cells.

| File | Role |
| --- | --- |
| `ICell.mqh`, `ACell.mqh` | Cell interface and base |
| `ICellFactory.mqh` | Builds a cell for one symbol and timeframe |
| `EmptyCell.mqh`, `LabelCell.mqh` | Blank cell and text label |
| `TrendValueCell.mqh`, `TrendValueCellFactory.mqh` | Colored trend cell driven by an `ICondition` |
| `GridTextCell.mqh` | Text value inside the grid |
| `IValueFormatter.mqh`, `AValueFormatter.mqh`, `FixedTextFormatter.mqh` | Turn a value into the string drawn in a cell |
| `Row.mqh`, `RowSize.mqh` | One row and its measured size |
| `Grid.mqh`, `GridRow.mqh`, `GridCells.mqh`, `GridBuilder.mqh` | Layout and construction |
| `CellUtils.mqh` | Shared cell helpers |
