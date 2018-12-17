--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 											IconSize, 	Filename, 										IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_EGYPT_HATSHEPSUT_ATLAS', 						256, 		'JFD_EgyptHatshepsutAtlas_256.dds',				2, 				2),
		('JFD_EGYPT_HATSHEPSUT_ATLAS', 						128, 		'JFD_EgyptHatshepsutAtlas_128.dds',				2, 				2),
		('JFD_EGYPT_HATSHEPSUT_ATLAS', 						80, 		'JFD_EgyptHatshepsutAtlas_80.dds',				2, 				2),
		('JFD_EGYPT_HATSHEPSUT_ATLAS', 						64, 		'JFD_EgyptHatshepsutAtlas_64.dds',				2, 				2),
		('JFD_EGYPT_HATSHEPSUT_ATLAS', 						45, 		'JFD_EgyptHatshepsutAtlas_45.dds',				2, 				2),
		('JFD_EGYPT_HATSHEPSUT_ATLAS', 						32, 		'JFD_EgyptHatshepsutAtlas_32.dds',				2, 				2),
		('JFD_EGYPT_HATSHEPSUT_ALPHA_ATLAS', 				128, 		'JFD_EgyptHatshepsutAlphaAtlas_128.dds',		1,				1),
		('JFD_EGYPT_HATSHEPSUT_ALPHA_ATLAS', 				80, 		'JFD_EgyptHatshepsutAlphaAtlas_80.dds',			1, 				1),
		('JFD_EGYPT_HATSHEPSUT_ALPHA_ATLAS', 				64, 		'JFD_EgyptHatshepsutAlphaAtlas_64.dds',			1, 				1),
		('JFD_EGYPT_HATSHEPSUT_ALPHA_ATLAS', 				48, 		'JFD_EgyptHatshepsutAlphaAtlas_48.dds',			1, 				1),
		('JFD_EGYPT_HATSHEPSUT_ALPHA_ATLAS', 				45, 		'JFD_EgyptHatshepsutAlphaAtlas_45.dds',			1, 				1),
		('JFD_EGYPT_HATSHEPSUT_ALPHA_ATLAS', 				32, 		'JFD_EgyptHatshepsutAlphaAtlas_32.dds',			1, 				1),
		('JFD_EGYPT_HATSHEPSUT_ALPHA_ATLAS', 				24, 		'JFD_EgyptHatshepsutAlphaAtlas_24.dds',			1, 				1),
		('JFD_EGYPT_HATSHEPSUT_ALPHA_ATLAS', 				16, 		'JFD_EgyptHatshepsutAlphaAtlas_16.dds',			1, 				1),
		('JFD_MERCHANT_BARGE_FLAG_ART_ATLAS', 				32, 		'JFD_MerchantBargeUnitFlag_32.dds',				1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 												Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_JFD_EGYPT_HATSHEPSUT_ICON', 			0.254,	0.027,	0.129,	1),
		('COLOR_PLAYER_JFD_EGYPT_HATSHEPSUT_BACKGROUND',	0.858,	0.725,	0.231,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 												PrimaryColor, 								SecondaryColor, 								TextColor)
VALUES	('PLAYERCOLOR_JFD_EGYPT_HATSHEPSUT',				'COLOR_PLAYER_JFD_EGYPT_HATSHEPSUT_ICON', 	'COLOR_PLAYER_JFD_EGYPT_HATSHEPSUT_BACKGROUND', 'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 									Filename, 				LoadType)
VALUES	('SND_LEADER_MUSIC_JFD_HATSHEPSUT_PEACE', 	'Hatshepsut_Peace',		'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_HATSHEPSUT_WAR', 	'Hatshepsut_War', 		'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 									SoundID, 									SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_JFD_HATSHEPSUT_PEACE', 	'SND_LEADER_MUSIC_JFD_HATSHEPSUT_PEACE', 	'GAME_MUSIC', 	-1.0,					45, 		45, 		1, 		 0),
		('AS2D_LEADER_MUSIC_JFD_HATSHEPSUT_WAR', 	'SND_LEADER_MUSIC_JFD_HATSHEPSUT_WAR', 		'GAME_MUSIC', 	-1.0,					45, 		45, 		1,		 0);
--==========================================================================================================================
-- UNIT/RESOURCE GRAPHICS
--==========================================================================================================================
-- ArtDefine_StrategicView
------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType, 					TileType,		Asset)
VALUES	('ART_DEF_UNIT_JFD_MERCHANT_BARGE',		'Unit', 		'sv_MerchantBarge.dds');
------------------------------
-- ArtDefine_UnitInfos
------------------------------			
INSERT INTO ArtDefine_UnitInfos 
		(Type, 										DamageStates,									Formation)
SELECT	'ART_DEF_UNIT_JFD_MERCHANT_BARGE',			DamageStates, 									Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_WORKBOAT';
------------------------------
-- ArtDefine_UnitInfoMemberInfos
------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,								UnitMemberInfoType,								NumMembers)
SELECT	'ART_DEF_UNIT_JFD_MERCHANT_BARGE', 			'ART_DEF_UNIT_MEMBER_JFD_MERCHANT_BARGE',		NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_WORKBOAT';
------------------------
-- ArtDefine_UnitMemberCombats
------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,							EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_MERCHANT_BARGE',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_WORKBOAT';
------------------------
-- ArtDefine_UnitMemberCombatWeapons
------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,							"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_MERCHANT_BARGE',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_WORKBOAT';
------------------------
-- ArtDefine_UnitMemberInfos
------------------------
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 										Scale,		ZOffset, Domain, Model, 						MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT	'ART_DEF_UNIT_MEMBER_JFD_MERCHANT_BARGE',	Scale+.03,	ZOffset, Domain, 'Mesopotamic_Embark.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_WORKBOAT';
--==========================================================================================================================	
--==========================================================================================================================