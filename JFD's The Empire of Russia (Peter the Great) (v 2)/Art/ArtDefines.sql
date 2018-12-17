--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 				TileType,	Asset)
VALUES		('ART_DEF_UNIT_JFD_TWO_DECKER', 	'Unit', 	'sv_Twodecker.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------	
INSERT INTO ArtDefine_UnitInfos 
			(Type, 								DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_JFD_TWO_DECKER'),	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_FRIGATE');
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_JFD_TWO_DECKER'),	('ART_DEF_UNIT_MEMBER_JFD_TWO_DECKER'),		NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_FRIGATE');
------------------------------
-- ArtDefine_UnitMemberCombats
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_TWO_DECKER'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_FRIGATE');
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_TWO_DECKER'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_FRIGATE');
------------------------------
-- ArtDefine_UnitMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 									Scale,  ZOffset, Domain, Model, 						MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_TWO_DECKER'),	Scale,	ZOffset, Domain, ('russian_galleon.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_FRIGATE');
------------------------------
-- IconTextureAtlasesa
------------------------------
INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES		('JFD_RUSSIA_PETER_ATLAS', 				256, 		'JFD_RussiaPeterAtlas_256.dds',			2, 				2),
			('JFD_RUSSIA_PETER_ATLAS', 				128, 		'JFD_RussiaPeterAtlas_128.dds',			2, 				2),
			('JFD_RUSSIA_PETER_ATLAS', 				80, 		'JFD_RussiaPeterAtlas_80.dds',			2, 				2),
			('JFD_RUSSIA_PETER_ATLAS', 				64, 		'JFD_RussiaPeterAtlas_64.dds',			2, 				2),
			('JFD_RUSSIA_PETER_ATLAS', 				45, 		'JFD_RussiaPeterAtlas_45.dds',			2, 				2),
			('JFD_RUSSIA_PETER_ATLAS', 				32, 		'JFD_RussiaPeterAtlas_32.dds',			2, 				2),
			('JFD_RUSSIA_ALPHA_ATLAS', 				128, 		'JFD_RussiaPeterAlphaAtlas_128.dds',	1, 				1),
			('JFD_RUSSIA_ALPHA_ATLAS', 				80, 		'JFD_RussiaPeterAlphaAtlas_80.dds',		1, 				1),
			('JFD_RUSSIA_ALPHA_ATLAS', 				64, 		'JFD_RussiaPeterAlphaAtlas_64.dds',		1, 				1),
			('JFD_RUSSIA_ALPHA_ATLAS', 				48, 		'JFD_RussiaPeterAlphaAtlas_48.dds',		1, 				1),
			('JFD_RUSSIA_ALPHA_ATLAS', 				45, 		'JFD_RussiaPeterAlphaAtlas_45.dds',		1, 				1),
			('JFD_RUSSIA_ALPHA_ATLAS', 				32, 		'JFD_RussiaPeterAlphaAtlas_32.dds',		1, 				1),
			('JFD_RUSSIA_ALPHA_ATLAS', 				24, 		'JFD_RussiaPeterAlphaAtlas_24.dds',		1, 				1),
			('JFD_RUSSIA_ALPHA_ATLAS', 				16, 		'JFD_RussiaPeterAlphaAtlas_16.dds',		1, 				1),
			('JFD_UNIT_FLAG_TWO_DECKER_ATLAS', 		32, 		'JFD_TwodeckerUnitFlag_32.dds',			1, 				1);
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
			(SoundID, 									Filename, 			LoadType)
VALUES		('SND_LEADER_MUSIC_JFD_PETER_PEACE', 		'Peter_Peace',		'DynamicResident'),
			('SND_LEADER_MUSIC_JFD_PETER_WAR', 			'Peter_War', 		'DynamicResident');			
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
			(ScriptID, 										SoundID, 								SoundType, 		MinVolume, 	MaxVolume,  IsMusic,	Looping)
VALUES		('AS2D_AMBIENCE_LEADER_JFD_PETER_AMBIENCE', 	'SND_AMBIENCE_FOREST_BED', 				'GAME_SFX', 	50, 		50, 		0, 			1),
			('AS2D_LEADER_MUSIC_JFD_PETER_PEACE', 			'SND_LEADER_MUSIC_JFD_PETER_PEACE', 	'GAME_MUSIC', 	50, 		50, 		1, 			0),
			('AS2D_LEADER_MUSIC_JFD_PETER_WAR', 			'SND_LEADER_MUSIC_JFD_PETER_WAR', 		'GAME_MUSIC', 	50, 		50, 		1,			0);
--==========================================================================================================================	
--==========================================================================================================================