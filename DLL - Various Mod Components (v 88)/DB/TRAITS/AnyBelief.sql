ALTER TABLE Traits
  ADD AnyBelief INTEGER DEFAULT 0;

INSERT INTO CustomModDbUpdates(Name, Value) VALUES('TRAITS_ANY_BELIEF', 1);