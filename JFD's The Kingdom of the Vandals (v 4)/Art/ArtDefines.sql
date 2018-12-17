--==========================================================================================================================
-- ArtDefine_StrategicView
--==========================================================================================================================
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 			TileType,	Asset)
VALUES		('ART_DEF_UNIT_JFD_AXEMAN', 	'Unit', 	'sv_Axeman.dds');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================			
INSERT INTO ArtDefine_UnitInfos 
			(Type, 								DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_JFD_AXEMAN'), 		DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE	(Type = 'ART_DEF_UNIT_SWORDSMAN');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,						NumMembers)
SELECT		('ART_DEF_UNIT_JFD_AXEMAN'), 		('ART_DEF_UNIT_MEMBER_JFD_AXEMAN'), 	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_SWORDSMAN');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,					EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_AXEMAN'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SWORDSMAN');
--==========================================================================================================================
-- ArtDefine_UnitMemberCombatWeapons
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,					"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_AXEMAN'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_SWORDSMAN');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 								Scale, ZOffset, Domain, Model, 					 MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_AXEMAN'),	Scale, ZOffset, Domain, ('GermanHvyAxe.fxsxml'), MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_SWORDSMAN');
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES		('JFD_THE_VANDALS_ATLAS', 				256, 		'JFD_VandalsAtlas_256.dds',				2, 				2),
			('JFD_THE_VANDALS_ATLAS', 				128, 		'JFD_VandalsAtlas_128.dds',				2, 				2),
			('JFD_THE_VANDALS_ATLAS', 				80, 		'JFD_VandalsAtlas_80.dds',				2, 				2),
			('JFD_THE_VANDALS_ATLAS', 				64, 		'JFD_VandalsAtlas_64.dds',				2, 				2),
			('JFD_THE_VANDALS_ATLAS', 				45, 		'JFD_VandalsAtlas_45.dds',				2, 				2),
			('JFD_THE_VANDALS_ATLAS', 				32, 		'JFD_VandalsAtlas_32.dds',				2, 				2),
			('JFD_THE_VANDALS_ALPHA_ATLAS', 		128, 		'JFD_VandalsAlphaAtlas_128.dds',		2, 				2),
			('JFD_THE_VANDALS_ALPHA_ATLAS', 		80, 		'JFD_VandalsAlphaAtlas_80.dds',			1, 				1),
			('JFD_THE_VANDALS_ALPHA_ATLAS', 		64, 		'JFD_VandalsAlphaAtlas_64.dds',			1, 				1),
			('JFD_THE_VANDALS_ALPHA_ATLAS', 		48, 		'JFD_VandalsAlphaAtlas_48.dds',			1, 				1),
			('JFD_THE_VANDALS_ALPHA_ATLAS', 		45, 		'JFD_VandalsAlphaAtlas_45.dds',			1, 				1),
			('JFD_THE_VANDALS_ALPHA_ATLAS', 		32, 		'JFD_VandalsAlphaAtlas_32.dds',			1, 				1),
			('JFD_THE_VANDALS_ALPHA_ATLAS', 		24, 		'JFD_VandalsAlphaAtlas_24.dds',			1, 				1),
			('JFD_THE_VANDALS_ALPHA_ATLAS', 		16, 		'JFD_VandalsAlphaAtlas_16.dds',			1, 				1),
			('JFD_UNIT_FLAG_AXEMAN_ATLAS', 			32, 		'Unit_Axeman_Flag_32.dds',				1, 				1);
--==========================================================================================================================
--==========================================================================================================================
