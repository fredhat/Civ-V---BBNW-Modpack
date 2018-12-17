--==========================================================================================================================
-- Improvements
--==========================================================================================================================
INSERT INTO Improvements
			(Type,							DestroyedWhenPillaged,	OutsideBorders,	Description,								Help,											Civilopedia,									ArtDefineTag,						IconAtlas,			SpecificCivRequired,	CivilizationType,			PortraitIndex,	ShowInPedia)
VALUES		('IMPROVEMENT_PLANT_FOREST',	1,						1,				'TXT_KEY_IMPROVEMENTS_F0S_PLANT_FOREST',	'TXT_KEY_IMPROVEMENTS_F0S_PLANT_FOREST_HELP',	'TXT_KEY_IMPROVEMENTS_F0S_PLANT_FOREST_TEXT',	'ART_DEF_IMPROVEMENT_PLANT_FOREST',	'REFOREST_ATLAS',	1,						'CIVILIZATION_IROQUOIS',	0,				0);
--==========================================================================================================================
-- Improvement_ValidTerrains
--==========================================================================================================================
INSERT INTO Improvement_ValidTerrains 	
			(ImprovementType,				TerrainType)
VALUES		('IMPROVEMENT_PLANT_FOREST',	'TERRAIN_GRASS'),
			('IMPROVEMENT_PLANT_FOREST',	'TERRAIN_PLAINS'),
			('IMPROVEMENT_PLANT_FOREST',	'TERRAIN_TUNDRA');
--==========================================================================================================================
--==========================================================================================================================