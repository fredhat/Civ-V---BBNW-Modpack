--==========================================================================================================================	
-- ArtDefine_StrategicView
--==========================================================================================================================	
INSERT OR REPLACE INTO ArtDefine_StrategicView 
			(StrategicViewType, 				TileType,	Asset)
VALUES		('ART_DEF_UNIT_JFD_BIRKEBEINER', 	'Unit', 	'sv_Birkebeiner.dds');
--==========================================================================================================================	
-- ArtDefine_UnitInfos
--==========================================================================================================================		
INSERT OR REPLACE INTO ArtDefine_UnitInfos 
			(Type, 								DamageStates,	Formation)
SELECT		('ART_DEF_UNIT_JFD_BIRKEBEINER'),	DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE (Type = 'ART_DEF_UNIT_U_SAXON_HUSCARL');
--==========================================================================================================================	
-- ArtDefine_UnitInfoMemberInfos
--==========================================================================================================================	
INSERT OR REPLACE INTO ArtDefine_UnitInfoMemberInfos 	
			(UnitInfoType,						UnitMemberInfoType,							NumMembers)
SELECT		('ART_DEF_UNIT_JFD_BIRKEBEINER'),	('ART_DEF_UNIT_MEMBER_U_SAXON_HUSCARL'), 	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE (UnitInfoType = 'ART_DEF_UNIT_U_SAXON_HUSCARL');
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 								IconSize, 	Filename, 								IconsPerRow, 	IconsPerColumn)
VALUES		('JFD_NORWAY_ATLAS', 					256, 		'JFD_NorwayAtlas_256.dds',				3, 				3),
			('JFD_NORWAY_ATLAS', 					128, 		'JFD_NorwayAtlas_128.dds',				3, 				3),
			('JFD_NORWAY_ATLAS', 					80, 		'JFD_NorwayAtlas_80.dds',				3, 				3),
			('JFD_NORWAY_ATLAS', 					64, 		'JFD_NorwayAtlas_64.dds',				3, 				3),
			('JFD_NORWAY_ATLAS', 					45, 		'JFD_NorwayAtlas_45.dds',				3, 				3),
			('JFD_NORWAY_ATLAS', 					32, 		'JFD_NorwayAtlas_32.dds',				3, 				3),
			('JFD_NORWAY_ALPHA_ATLAS', 				128, 		'JFD_NorwayAlphaAtlas_128.dds',			1, 				1),
			('JFD_NORWAY_ALPHA_ATLAS', 				80, 		'JFD_NorwayAlphaAtlas_80.dds',			1, 				1),
			('JFD_NORWAY_ALPHA_ATLAS', 				64, 		'JFD_NorwayAlphaAtlas_64.dds',			1, 				1),
			('JFD_NORWAY_ALPHA_ATLAS', 				48, 		'JFD_NorwayAlphaAtlas_48.dds',			1, 				1),
			('JFD_NORWAY_ALPHA_ATLAS', 				45, 		'JFD_NorwayAlphaAtlas_45.dds',			1, 				1),
			('JFD_NORWAY_ALPHA_ATLAS', 				32, 		'JFD_NorwayAlphaAtlas_32.dds',			1, 				1),
			('JFD_NORWAY_ALPHA_ATLAS', 				24, 		'JFD_NorwayAlphaAtlas_24.dds',			1, 				1),
			('JFD_NORWAY_ALPHA_ATLAS', 				16, 		'JFD_NorwayAlphaAtlas_16.dds',			1, 				1),
			('JFD_UNIT_FLAG_BIRKEBEINER_ATLAS', 	32, 		'Unit_Birkebeiner_Flag_32.dds',			1, 				1);
--==========================================================================================================================
--==========================================================================================================================