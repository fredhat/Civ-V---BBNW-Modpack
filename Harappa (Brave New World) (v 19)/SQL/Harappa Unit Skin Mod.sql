INSERT INTO ArtDefine_UnitInfos(Type, DamageStates, Formation)
  VALUES ('ART_DEF_UNIT_HARAPPA_BULLOCK_CART', 1, 'ChariotElephant');
INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_HARAPPA_BULLOCK_CART', 'ART_DEF_UNIT_MEMBER_HARAPPA_BULLOCK_CART', 1);
INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_HARAPPA_BULLOCK_CART', 0.129999995231628, 'SupplyTrain.fxsxml', 'CLOTH', 'WOODSM');
INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, ShortMoveRadius, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasStationaryMelee, HasRefaceAfterCombat, ReformBeforeCombat, OnlyTurnInMovementActions)
  VALUES ('ART_DEF_UNIT_MEMBER_HARAPPA_BULLOCK_CART', 'Idle Attack RunCharge AttackCity Bombard Death BombardDefend Run Fortify CombatReady Walk', 24.0, 0.349999994039536, 0.5, 0.75, 15.0, 20.0, 12.0, 1, 1, 1, 1, 1, 1);
INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, WeaponTypeTag, WeaponTypeSoundOverrideTag, MissTargetSlopRadius)
  VALUES ('ART_DEF_UNIT_MEMBER_HARAPPA_BULLOCK_CART', 0, 0, 'ARROW', 'ARROW', 10.0);
INSERT INTO ArtDefine_UnitMemberCombatWeapons(UnitMemberType, "Index", SubIndex, VisKillStrengthMin, VisKillStrengthMax, WeaponTypeTag, MissTargetSlopRadius)
  VALUES ('ART_DEF_UNIT_MEMBER_HARAPPA_BULLOCK_CART', 1, 0, 10.0, 20.0, 'FLAMING_ARROW', 10.0);

INSERT INTO ArtDefine_UnitInfos(Type, DamageStates)
  VALUES ('ART_DEF_UNIT_HARAPPA_BULLOCK_CART_ALT', 1);
INSERT INTO ArtDefine_UnitInfoMemberInfos(UnitInfoType, UnitMemberInfoType, NumMembers)
  VALUES ('ART_DEF_UNIT_HARAPPA_BULLOCK_CART_ALT', 'ART_DEF_UNIT_MEMBER_HARAPPA_BULLOCK_CART_ALT', 1);
INSERT INTO ArtDefine_UnitMemberInfos(Type, Scale, Model, MaterialTypeTag, MaterialTypeSoundOverrideTag)
  VALUES ('ART_DEF_UNIT_MEMBER_HARAPPA_BULLOCK_CART_ALT', 0.119999997317791, 'SupplyTrainV2.fxsxml', 'CLOTH', 'FLESH');
INSERT INTO ArtDefine_UnitMemberCombats(UnitMemberType, EnableActions, HasRefaceAfterCombat)
  VALUES ('ART_DEF_UNIT_MEMBER_HARAPPA_BULLOCK_CART_ALT', 'Idle Death BombardDefend Run', 1);