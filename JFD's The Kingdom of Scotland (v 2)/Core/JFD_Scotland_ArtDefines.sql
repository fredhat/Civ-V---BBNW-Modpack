--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 				TileType,	Asset)
VALUES		('ART_DEF_UNIT_JFD_HIGHLANDER', 	'Unit', 	'sv_Highlander.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------			
INSERT INTO ArtDefine_UnitInfos 
			(Type, 								DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_JFD_HIGHLANDER'), 	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE	(Type = 'ART_DEF_UNIT_RIFLEMAN');
------------------------------
-- ArtDefine_UnitInfos
------------------------------	
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_JFD_HIGHLANDER'), 	('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_1'),	3
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_RIFLEMAN');

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_JFD_HIGHLANDER'), 	('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_2'),	3
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_RIFLEMAN');

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_JFD_HIGHLANDER'), 	('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_3'),	3
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_RIFLEMAN');
------------------------------
-- ArtDefine_UnitInfos
------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_1'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_2'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_3'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');
------------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_1'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_2'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_3'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');
------------------------------
-- ArtDefine_UnitInfos
------------------------------	
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 										Scale, ZOffset, Domain, Model, 				MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_1'),	Scale, ZOffset, Domain, ('celrm1.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 										Scale, ZOffset, Domain, Model, 				MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_2'),	Scale, ZOffset, Domain, ('celrm2.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 										Scale, ZOffset, Domain, Model, 				MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_HIGHLANDER_3'),	Scale, ZOffset, Domain, ('celrm3.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');
------------------------------
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES		('JFD_SCOTLAND_ATLAS', 					256, 		'JFD_ScotlandAtlas_256.dds',			2, 				2),
			('JFD_SCOTLAND_ATLAS', 					128, 		'JFD_ScotlandAtlas_128.dds',			2, 				2),
			('JFD_SCOTLAND_ATLAS', 					80, 		'JFD_ScotlandAtlas_80.dds',				2, 				2),
			('JFD_SCOTLAND_ATLAS', 					64, 		'JFD_ScotlandAtlas_64.dds',				2, 				2),
			('JFD_SCOTLAND_ATLAS', 					45, 		'JFD_ScotlandAtlas_45.dds',				2, 				2),
			('JFD_SCOTLAND_ATLAS', 					32, 		'JFD_ScotlandAtlas_32.dds',				2, 				2),
			('JFD_SCOTLAND_ALPHA_ATLAS', 			128, 		'JFD_ScotlandAlphaAtlas_128.dds',		2, 				2),
			('JFD_SCOTLAND_ALPHA_ATLAS', 			80, 		'JFD_ScotlandAlphaAtlas_80.dds',		1, 				1),
			('JFD_SCOTLAND_ALPHA_ATLAS', 			64, 		'JFD_ScotlandAlphaAtlas_64.dds',		1, 				1),
			('JFD_SCOTLAND_ALPHA_ATLAS', 			48, 		'JFD_ScotlandAlphaAtlas_48.dds',		1, 				1),
			('JFD_SCOTLAND_ALPHA_ATLAS', 			45, 		'JFD_ScotlandAlphaAtlas_45.dds',		1, 				1),
			('JFD_SCOTLAND_ALPHA_ATLAS', 			32, 		'JFD_ScotlandAlphaAtlas_32.dds',		1, 				1),
			('JFD_SCOTLAND_ALPHA_ATLAS', 			24, 		'JFD_ScotlandAlphaAtlas_24.dds',		1, 				1),
			('JFD_SCOTLAND_ALPHA_ATLAS', 			16, 		'JFD_ScotlandAlphaAtlas_16.dds',		1, 				1),
			('JFD_UNIT_FLAG_HIGHLANDER_ATLAS', 		32, 		'Unit_Highlander_Flag_32.dds',			1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
			(Type, 										Red, 	Green, 	Blue, 	Alpha)
VALUES		('COLOR_PLAYER_JFD_SCOTLAND_ICON', 			0.619, 	0.050, 	0.058, 	1),
			('COLOR_PLAYER_JFD_SCOTLAND_BACKGROUND', 	0.948,	0.772,	0.341, 	1);
------------------------------
-- PlayerColors
------------------------------				
INSERT INTO PlayerColors 
			(Type, 							PrimaryColor, 						SecondaryColor, 						TextColor)
VALUES		('PLAYERCOLOR_JFD_SCOTLAND', 	'COLOR_PLAYER_JFD_SCOTLAND_ICON',	'COLOR_PLAYER_JFD_SCOTLAND_BACKGROUND', 'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
			(SoundID, 								Filename, 		LoadType)
VALUES		('SND_LEADER_MUSIC_JFD_JAMES_PEACE',	'James_Peace', 	'DynamicResident'),
			('SND_LEADER_MUSIC_JFD_JAMES_WAR', 		'James_War', 	'DynamicResident');			
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
			(ScriptID, 										SoundID, 							SoundType, 		MinVolume, 	MaxVolume,	IsMusic,	Looping)
VALUES		('AS2D_AMBIENCE_LEADER_JFD_JAMES_AMBIENCE', 	'SND_AMBIENCE_CEASAR_AMBIENCE', 	'GAME_SFX', 	40, 		40, 		0, 			1),
			('AS2D_LEADER_MUSIC_JFD_JAMES_PEACE', 			'SND_LEADER_MUSIC_JFD_JAMES_PEACE', 'GAME_MUSIC', 	60, 		60, 		1, 			0),
			('AS2D_LEADER_MUSIC_JFD_JAMES_WAR', 			'SND_LEADER_MUSIC_JFD_JAMES_WAR', 	'GAME_MUSIC', 	60, 		60, 		1,			0);
--==========================================================================================================================	
--==========================================================================================================================