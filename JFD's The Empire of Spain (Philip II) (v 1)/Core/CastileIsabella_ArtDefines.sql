--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 									IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_SPAIN_PHILIP_II_ATLAS', 				256, 		'JFD_PhilipIISpainAtlas_256.dds',			2, 				2),
		('JFD_SPAIN_PHILIP_II_ATLAS', 				128, 		'JFD_PhilipIISpainAtlas_128.dds',			2, 				2),
		('JFD_SPAIN_PHILIP_II_ATLAS', 				80, 		'JFD_PhilipIISpainAtlas_80.dds',			2, 				2),
		('JFD_SPAIN_PHILIP_II_ATLAS', 				64, 		'JFD_PhilipIISpainAtlas_64.dds',			2, 				2),
		('JFD_SPAIN_PHILIP_II_ATLAS', 				45, 		'JFD_PhilipIISpainAtlas_45.dds',			2, 				2),
		('JFD_SPAIN_PHILIP_II_ATLAS', 				32, 		'JFD_PhilipIISpainAtlas_32.dds',			2, 				2),
		('JFD_CASTILE_ALPHA_ATLAS', 				128, 		'JFD_CastileAlphaAtlas_128.dds',			1,				1),
		('JFD_CASTILE_ALPHA_ATLAS', 				80, 		'JFD_CastileAlphaAtlas_80.dds',				1, 				1),
		('JFD_CASTILE_ALPHA_ATLAS', 				64, 		'JFD_CastileAlphaAtlas_64.dds',				1, 				1),
		('JFD_CASTILE_ALPHA_ATLAS', 				48, 		'JFD_CastileAlphaAtlas_48.dds',				1, 				1),
		('JFD_CASTILE_ALPHA_ATLAS', 				45, 		'JFD_CastileAlphaAtlas_45.dds',				1, 				1),
		('JFD_CASTILE_ALPHA_ATLAS', 				32, 		'JFD_CastileAlphaAtlas_32.dds',				1, 				1),
		('JFD_CASTILE_ALPHA_ATLAS', 				24, 		'JFD_CastileAlphaAtlas_24.dds',				1, 				1),
		('JFD_CASTILE_ALPHA_ATLAS', 				16, 		'JFD_CastileAlphaAtlas_16.dds',				1, 				1),
		('JFD_UNIT_FLAG_TREASURE_SHIP_ATLAS', 		32, 		'JFD_TreasureShipUnitFlag_32.dds',			1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 										Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_JFD_CASTILE_ICON', 			0.352,	0.019,	0.019,	1),
		('COLOR_PLAYER_JFD_CASTILE_BACKGROUND',		0.784,	0.427,	0.027,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 										PrimaryColor, 						SecondaryColor, 						TextColor)
VALUES	('PLAYERCOLOR_JFD_CASTILE',					'COLOR_PLAYER_JFD_CASTILE_ICON', 	'COLOR_PLAYER_JFD_CASTILE_BACKGROUND',	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- UNIT/RESOURCE GRAPHICS
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 					TileType,		Asset)
VALUES	('ART_DEF_UNIT_JFD_TREASURE_SHIP',		'Unit', 		'sv_TreasureShip.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------		
INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates,	Formation)
SELECT	'ART_DEF_UNIT_JFD_TREASURE_SHIP', 		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_FRIGATE';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,							NumMembers)
SELECT	'ART_DEF_UNIT_JFD_TREASURE_SHIP', 		'ART_DEF_UNIT_MEMBER_JFD_TREASURE_SHIP',	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_FRIGATE';
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_TREASURE_SHIP',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_FRIGATE';
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_TREASURE_SHIP',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_FRIGATE';
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 										Scale, ZOffset, Domain, Model, 								MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_TREASURE_SHIP',	Scale, ZOffset, Domain, 'spain_santisimatrinidad.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_FRIGATE';
--==========================================================================================================================	
--==========================================================================================================================