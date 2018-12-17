--==========================================================================================================================
-- ArtDefines
--==========================================================================================================================
INSERT INTO ArtDefine_StrategicView
			(StrategicViewType, 					TileType,			Asset)
VALUES 		('ART_DEF_IMPROVEMENT_PLANT_FOREST',	'Improvement',		'SV_PlantForest.dds');

INSERT INTO ArtDefine_LandmarkTypes
			(Type,									LandmarkType,		FriendlyName)
VALUES 		('ART_DEF_IMPROVEMENT_PLANT_FOREST',	'Improvement',		'PlantForest');

INSERT INTO ArtDefine_Landmarks
			(Era,	State,					Scale,	ImprovementType,					LayoutHandler,	ResourceType,				Model,								TerrainContour)
VALUES		('Any',	'UnderConstruction',	0.86,	'ART_DEF_IMPROVEMENT_PLANT_FOREST', 'SNAPSHOT',		'ART_DEF_RESOURCE_NONE',	'HB_Plantation_MID_Incense.fxsxml', 1),
			('Any',	'Constructed',			0.86,	'ART_DEF_IMPROVEMENT_PLANT_FOREST', 'SNAPSHOT',		'ART_DEF_RESOURCE_NONE',	'Plantation_MID_Incense.fxsxml',	1),
			('Any',	'Pillaged',				0.86,	'ART_DEF_IMPROVEMENT_PLANT_FOREST', 'SNAPSHOT',		'ART_DEF_RESOURCE_NONE',	'PL_Plantation_MID_Incense.fxsxml', 1);
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 						IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES		('REFOREST_ATLAS', 				256, 		'ForestAtlas256.dds',			1, 				1),
			('REFOREST_ATLAS', 				64, 		'ForestAtlas64.dds',			1, 				1),
			('UNIT_ACTION_REFOREST_ATLAS', 	64, 		'UnitAction64_Forest.dds',		1, 				1),
			('UNIT_ACTION_REFOREST_ATLAS', 	45, 		'UnitAction45_Forest.dds',		1, 				1);
--==========================================================================================================================
--==========================================================================================================================
