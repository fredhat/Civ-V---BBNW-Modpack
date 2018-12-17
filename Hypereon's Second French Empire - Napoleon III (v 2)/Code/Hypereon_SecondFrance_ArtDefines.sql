--==========================================================================================================================
-- ARTDEFINES
--==========================================================================================================================	
-- ArtDefine_StrategicView
------------------------------
INSERT OR REPLACE INTO ArtDefine_StrategicView 
			(StrategicViewType, 				TileType,	Asset)
VALUES		('ART_DEF_UNIT_HYPEREON_ZOUAVE',	'Unit',		'sv_Zouave_256.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------			
INSERT OR REPLACE INTO ArtDefine_UnitInfos 
			(Type, 								DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_HYPEREON_ZOUAVE'),	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_RIFLEMAN');
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT OR REPLACE INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_HYPEREON_ZOUAVE'),	('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_1'), 	NumMembers/2
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_RIFLEMAN');

INSERT OR REPLACE INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_HYPEREON_ZOUAVE'),	('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_3'), 	NumMembers/2-1
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_RIFLEMAN');

INSERT OR REPLACE INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_HYPEREON_ZOUAVE'),	('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_2'), 	1
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_RIFLEMAN');
------------------------------	
-- ArtDefine_UnitMemberCombats
------------------------------	
INSERT OR REPLACE INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_1'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT OR REPLACE INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_2'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT OR REPLACE INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_3'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');
------------------------------	
-- ArtDefine_UnitMemberCombatWeapons
------------------------------	
INSERT OR REPLACE INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_1'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT OR REPLACE INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_2'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT OR REPLACE INTO ArtDefine_UnitMemberCombatWeapons	
			(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_3'),	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');
------------------------------	
-- ArtDefine_UnitMemberInfos
------------------------------		
INSERT OR REPLACE INTO ArtDefine_UnitMemberInfos 	
		(Type, 										Scale,	ZOffset, Domain, Model, 				MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_1'),	Scale,	ZOffset, Domain, ('zouave.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT OR REPLACE INTO ArtDefine_UnitMemberInfos 	
		(Type, 										Scale,	ZOffset, Domain, Model, 				MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_2'),	Scale,	ZOffset, Domain, ('zouave2.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');

INSERT OR REPLACE INTO ArtDefine_UnitMemberInfos 	
		(Type, 										Scale,	ZOffset, Domain, Model, 				MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_HYPEREON_ZOUAVE_3'),	Scale,	ZOffset, Domain, ('zouave3.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_RIFLEMAN');
------------------------------
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 										IconsPerRow, 	IconsPerColumn)
VALUES		('HYPEREON_SECONDFRANCE_ATLAS', 		256, 		'Hypereon_SecondFranceAtlas_256.dds',			4, 				4),
			('HYPEREON_SECONDFRANCE_ATLAS', 		128, 		'Hypereon_SecondFranceAtlas_128.dds',			4, 				4),
			('HYPEREON_SECONDFRANCE_ATLAS', 		80, 		'Hypereon_SecondFranceAtlas_80.dds',			4, 				4),
			('HYPEREON_SECONDFRANCE_ATLAS', 		64, 		'Hypereon_SecondFranceAtlas_64.dds',			4, 				4),
			('HYPEREON_SECONDFRANCE_ATLAS', 		45, 		'Hypereon_SecondFranceAtlas_45.dds',			4, 				4),
			('HYPEREON_SECONDFRANCE_ATLAS', 		32, 		'Hypereon_SecondFranceAtlas_32.dds',			4, 				4),
			('HYPEREON_SECONDFRANCE_ALPHA_ATLAS', 	128, 		'Hypereon_SecondFranceAlphaAtlas_128.dds',		1,				1),
			('HYPEREON_SECONDFRANCE_ALPHA_ATLAS', 	80, 		'Hypereon_SecondFranceAlphaAtlas_80.dds',		1, 				1),
			('HYPEREON_SECONDFRANCE_ALPHA_ATLAS', 	64, 		'Hypereon_SecondFranceAlphaAtlas_64.dds',		1, 				1),
			('HYPEREON_SECONDFRANCE_ALPHA_ATLAS', 	48, 		'Hypereon_SecondFranceAlphaAtlas_48.dds',		1, 				1),
			('HYPEREON_SECONDFRANCE_ALPHA_ATLAS', 	45, 		'Hypereon_SecondFranceAlphaAtlas_45.dds',		1, 				1),
			('HYPEREON_SECONDFRANCE_ALPHA_ATLAS', 	32, 		'Hypereon_SecondFranceAlphaAtlas_32.dds',		1, 				1),
			('HYPEREON_SECONDFRANCE_ALPHA_ATLAS', 	24, 		'Hypereon_SecondFranceAlphaAtlas_24.dds',		1, 				1),
			('HYPEREON_SECONDFRANCE_ALPHA_ATLAS', 	16, 		'Hypereon_SecondFranceAlphaAtlas_16.dds',		1, 				1),
			('HYPEREON_UNIT_FLAG_ZOUAVE_ATLAS', 	32, 		'NapoleonIII_ZouaveUnitFlag_32.dds',			1, 				1);
------------------------------	
-- Colors
------------------------------		
INSERT INTO Colors 
			(Type, 												Red, 	Green, 	Blue, 	Alpha)
VALUES		('COLOR_PLAYER_HYPEREON_SECONDFRANCE_ICON', 		1.000,	0.847,	0.847,	1),
			('COLOR_PLAYER_HYPEREON_SECONDFRANCE_BACKGROUND',	0.341,	0.322,	0.569,	1);
------------------------------	
-- PlayerColors
------------------------------				
INSERT INTO PlayerColors 
			(Type, 									PrimaryColor, 								SecondaryColor, 									TextColor)
VALUES		('PLAYERCOLOR_HYPEREON_SECONDFRANCE',	'COLOR_PLAYER_HYPEREON_SECONDFRANCE_ICON', 	'COLOR_PLAYER_HYPEREON_SECONDFRANCE_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
			(SoundID, 												Filename, 					LoadType)
VALUES		('SND_LEADER_MUSIC_HYPEREON_NAPOLEONIII_PEACE', 		'LouisNapoleon_Peace',		'DynamicResident'),
			('SND_LEADER_MUSIC_HYPEREON_NAPOLEONIII_WAR', 			'LouisNapoleon_War', 		'DynamicResident'),
			('SND_AMBIENCE_LEADER_HYPEREON_NAPOLEONIII_AMBIENCE', 	'LouisNapoleon_Ambience', 	'DynamicResident');		
------------------------------	
-- Audio_2DSounds
------------------------------		
INSERT INTO Audio_2DSounds 
			(ScriptID, 												SoundID, 												SoundType, 		MinVolume, 	MaxVolume,  IsMusic, 	Looping)
VALUES		('AS2D_LEADER_MUSIC_HYPEREON_NAPOLEONIII_PEACE', 		'SND_LEADER_MUSIC_HYPEREON_NAPOLEONIII_PEACE', 			'GAME_MUSIC', 	100, 		100, 		1, 		 	0),
			('AS2D_LEADER_MUSIC_HYPEREON_NAPOLEONIII_WAR', 			'SND_LEADER_MUSIC_HYPEREON_NAPOLEONIII_WAR', 			'GAME_MUSIC', 	90, 		90, 		1,		 	0),
			('AS2D_AMBIENCE_LEADER_HYPEREON_NAPOLEONIII_AMBIENCE', 	'SND_AMBIENCE_LEADER_HYPEREON_NAPOLEONIII_AMBIENCE', 	'GAME_SFX', 	40, 		40, 		1,			0);
--==========================================================================================================================	
--==========================================================================================================================