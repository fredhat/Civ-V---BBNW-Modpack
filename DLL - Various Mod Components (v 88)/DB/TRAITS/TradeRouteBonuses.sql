ALTER TABLE Traits
  ADD SeaTradeRouteRangeBonus INTEGER DEFAULT 0;

INSERT INTO CustomModDbUpdates(Name, Value) VALUES('TRAITS_TRADE_ROUTE_BONUSES', 1);