--==========================================================================================================================	
-- ArtDefine_StrategicView
--==========================================================================================================================	
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 			TileType,	Asset)
VALUES		('ART_DEF_UNIT_JFD_YAMATO', 	'Unit', 	'sv_Yamato.dds');
--==========================================================================================================================	
-- ArtDefine_UnitInfos
--==========================================================================================================================		
INSERT INTO ArtDefine_UnitInfos 
			(Type, 							DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_JFD_YAMATO'), 	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_BATTLESHIP');
--==========================================================================================================================	
-- ArtDefine_UnitInfoMemberInfos
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,					UnitMemberInfoType,						NumMembers)
SELECT		('ART_DEF_UNIT_JFD_YAMATO'), 	('ART_DEF_UNIT_MEMBER_JFD_YAMATO'), 	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_BATTLESHIP');
--==========================================================================================================================	
-- ArtDefine_UnitMemberCombats
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,					EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_YAMATO'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_BATTLESHIP');
--==========================================================================================================================	
-- ArtDefine_UnitMemberCombatWeapons
--==========================================================================================================================		
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,					"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_YAMATO'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_BATTLESHIP');
--==========================================================================================================================	
-- ArtDefine_UnitMemberInfos
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 								Scale, ZOffset, Domain, Model, 						MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_JFD_YAMATO'),	Scale, ZOffset, Domain, ('Yamato_Class.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_BATTLESHIP');
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 							IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES		('WAY_WARRIOR_ATLAS', 				256, 		'way_warrior_promo_256.dds',			1, 				1),
			('WAY_WARRIOR_ATLAS', 				64, 		'way_warrior_promo_64.dds',				1, 				1),
			('WAY_WARRIOR_ATLAS', 				45, 		'way_warrior_promo_45.dds',				1, 				1),
			('WAY_WARRIOR_ATLAS', 				32, 		'way_warrior_promo_32.dds',				1, 				1),
			('JFD_JAPAN_TOJO_ATLAS', 			256, 		'JFD_JapanTojoAtlas_256.dds',			2, 				2),
			('JFD_JAPAN_TOJO_ATLAS', 			128, 		'JFD_JapanTojoAtlas_128.dds',			2, 				2),
			('JFD_JAPAN_TOJO_ATLAS', 			80, 		'JFD_JapanTojoAtlas_80.dds',			2, 				2),
			('JFD_JAPAN_TOJO_ATLAS', 			64, 		'JFD_JapanTojoAtlas_64.dds',			2, 				2),
			('JFD_JAPAN_TOJO_ATLAS', 			45, 		'JFD_JapanTojoAtlas_45.dds',			2, 				2),
			('JFD_JAPAN_TOJO_ATLAS', 			32, 		'JFD_JapanTojoAtlas_32.dds',			2, 				2),
			('JFD_JAPAN_TOJO_ALPHA_ATLAS', 		128, 		'JFD_JapanTojoAlphaAtlas_128.dds',		1, 				1),
			('JFD_JAPAN_TOJO_ALPHA_ATLAS', 		80, 		'JFD_JapanTojoAlphaAtlas_80.dds',		1, 				1),
			('JFD_JAPAN_TOJO_ALPHA_ATLAS', 		64, 		'JFD_JapanTojoAlphaAtlas_64.dds',		1, 				1),
			('JFD_JAPAN_TOJO_ALPHA_ATLAS', 		48, 		'JFD_JapanTojoAlphaAtlas_48.dds',		1, 				1),
			('JFD_JAPAN_TOJO_ALPHA_ATLAS', 		45, 		'JFD_JapanTojoAlphaAtlas_45.dds',		1, 				1),
			('JFD_JAPAN_TOJO_ALPHA_ATLAS', 		32, 		'JFD_JapanTojoAlphaAtlas_32.dds',		1, 				1),
			('JFD_JAPAN_TOJO_ALPHA_ATLAS', 		24, 		'JFD_JapanTojoAlphaAtlas_24.dds',		1, 				1),
			('JFD_JAPAN_TOJO_ALPHA_ATLAS', 		16, 		'JFD_JapanTojoAlphaAtlas_16.dds',		1, 				1),
			('JFD_YAMATO_FLAG_ART_ATLAS', 		32, 		'UnitFlagYamatoAtlas_32.dds',			1, 				1);
--==========================================================================================================================
--==========================================================================================================================