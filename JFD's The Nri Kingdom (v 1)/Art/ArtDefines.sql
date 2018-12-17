--==========================================================================================================================
-- ArtDefine_StrategicView
--==========================================================================================================================
INSERT INTO ArtDefine_StrategicView 
			(StrategicViewType, 			TileType,	Asset)
VALUES		('ART_DEF_UNIT_JFD_MBURICHI', 	'Unit', 	'sv_Mburichi.dds');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================			
INSERT INTO ArtDefine_UnitInfos 
			(Type, 							DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_JFD_MBURICHI'), 	1, 				('UnFormed')
FROM ArtDefine_UnitInfos WHERE	(Type = 'ART_DEF_UNIT_MERCHANT');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================	
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,					UnitMemberInfoType,						NumMembers)
SELECT		('ART_DEF_UNIT_JFD_MBURICHI'), 	('ART_DEF_UNIT_MEMBER_JFD_MBURICHI'),	1
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_MERCHANT');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberCombats 
			(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_MBURICHI'),	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_GREATMERCHANT_EARLY_LEADER');
--==========================================================================================================================
-- ArtDefine_UnitInfos
--==========================================================================================================================
INSERT INTO ArtDefine_UnitMemberInfos 	
			(Type, 									Scale,	ZOffset, Domain, Model,					MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT		('ART_DEF_UNIT_MEMBER_JFD_MBURICHI'),	Scale,	ZOffset, Domain, ('Mburichi.fxsxml'),	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE (Type = 'ART_DEF_UNIT_MEMBER_GREATMERCHANT_EARLY_LEADER');
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES		('JFD_NRI_ATLAS', 						256, 		'JFD_NriAtlas_256.dds',					2, 				2),
			('JFD_NRI_ATLAS', 						128, 		'JFD_NriAtlas_128.dds',					2, 				2),
			('JFD_NRI_ATLAS', 						80, 		'JFD_NriAtlas_80.dds',					2, 				2),
			('JFD_NRI_ATLAS', 						64, 		'JFD_NriAtlas_64.dds',					2, 				2),
			('JFD_NRI_ATLAS', 						45, 		'JFD_NriAtlas_45.dds',					2, 				2),
			('JFD_NRI_ATLAS', 						32, 		'JFD_NriAtlas_32.dds',					2, 				2),
			('JFD_NRI_RELIGION_ATLAS', 				256, 		'JFD_NriReligionAtlas_256.dds',			1, 				1),
			('JFD_NRI_RELIGION_ATLAS', 				214, 		'JFD_NriReligionAtlas_214.dds',			1, 				1),
			('JFD_NRI_RELIGION_ATLAS', 				128, 		'JFD_NriReligionAtlas_128.dds',			1, 				1),
			('JFD_NRI_RELIGION_ATLAS', 				80, 		'JFD_NriReligionAtlas_80.dds',			1, 				1),
			('JFD_NRI_RELIGION_ATLAS', 				64, 		'JFD_NriReligionAtlas_64.dds',			1, 				1),
			('JFD_NRI_RELIGION_ATLAS', 				48, 		'JFD_NriReligionAtlas_48.dds',			1, 				1),
			('JFD_NRI_RELIGION_ATLAS', 				45, 		'JFD_NriReligionAtlas_45.dds',			1, 				1),
			('JFD_NRI_RELIGION_ATLAS', 				32, 		'JFD_NriReligionAtlas_32.dds',			1, 				1),
			('JFD_NRI_RELIGION_ATLAS', 				24, 		'JFD_NriReligionAtlas_24.dds',			1, 				1),
			('JFD_NRI_RELIGION_ATLAS', 				16, 		'JFD_NriReligionAtlas_16.dds',			1, 				1),
			('JFD_NRI_ALPHA_ATLAS', 				128, 		'JFD_NriAlphaAtlas_128.dds',			1, 				1),
			('JFD_NRI_ALPHA_ATLAS', 				80, 		'JFD_NriAlphaAtlas_80.dds',				1, 				1),
			('JFD_NRI_ALPHA_ATLAS', 				64, 		'JFD_NriAlphaAtlas_64.dds',				1, 				1),
			('JFD_NRI_ALPHA_ATLAS', 				48, 		'JFD_NriAlphaAtlas_48.dds',				1, 				1),
			('JFD_NRI_ALPHA_ATLAS', 				45, 		'JFD_NriAlphaAtlas_45.dds',				1, 				1),
			('JFD_NRI_ALPHA_ATLAS', 				32, 		'JFD_NriAlphaAtlas_32.dds',				1, 				1),
			('JFD_NRI_ALPHA_ATLAS', 				24, 		'JFD_NriAlphaAtlas_24.dds',				1, 				1),
			('JFD_NRI_ALPHA_ATLAS', 				16, 		'JFD_NriAlphaAtlas_16.dds',				1, 				1),
			('JFD_UNIT_FLAG_MBURICHI_ATLAS', 		32, 		'JFD_MburichiUnitFlag_32.dds',			1, 				1);
--==========================================================================================================================
-- IconFontTextures
--==========================================================================================================================
INSERT INTO IconFontTextures 
			(IconFontTexture, 						IconFontTextureFile)
VALUES		('ICON_FONT_TEXTURE_JFD_ODINANI',		'JFD_ReligionOdinaniFontIcons_22');
--==========================================================================================================================
-- IconFontMapping
--==========================================================================================================================
INSERT INTO IconFontMapping 
			(IconName, 								IconFontTexture,						IconMapping)
VALUES		('ICON_RELIGION_JFD_ODINANI', 			'ICON_FONT_TEXTURE_JFD_ODINANI',		1);
--==========================================================================================================================
--==========================================================================================================================