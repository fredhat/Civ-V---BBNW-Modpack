--==========================================================================================================================
-- Improvements
--==========================================================================================================================
INSERT INTO Improvements
			(Type,						Description,						Civilopedia,									ArtDefineTag,					PillageGold,	NoTwoAdjacent,	PortraitIndex,	IconAtlas)
VALUES		('IMPROVEMENT_MISSION',		'TXT_KEY_IMPROVEMENT_F0S_MISSION',	'TXT_KEY_CIV5_IMPROVEMENTS_F0S_MISSION_TEXT',	'ART_DEF_IMPROVEMENT_MISSION', 	20,				1,				0,				'F0S_MISSION_ATLAS');
--==========================================================================================================================
-- Improvement_ValidTerrains
--==========================================================================================================================
INSERT INTO Improvement_ValidTerrains
			(ImprovementType,			TerrainType)
VALUES		('IMPROVEMENT_MISSION',		'TERRAIN_GRASS'),
			('IMPROVEMENT_MISSION',		'TERRAIN_PLAINS'),
			('IMPROVEMENT_MISSION',		'TERRAIN_DESERT'),
			('IMPROVEMENT_MISSION',		'TERRAIN_TUNDRA'),
			('IMPROVEMENT_MISSION',		'TERRAIN_SNOW');
--==========================================================================================================================
-- Improvement_Yields
--==========================================================================================================================
INSERT INTO Improvement_Yields
			(ImprovementType,			YieldType,			Yield)
VALUES		('IMPROVEMENT_MISSION',		'YIELD_FAITH',		2);
--==========================================================================================================================
-- Improvement_Flavors
--==========================================================================================================================
INSERT INTO Improvement_Flavors
			(ImprovementType,			FlavorType,					Flavor)
VALUES		('IMPROVEMENT_MISSION',		'FLAVOR_TILE_IMPROVEMENT',	20),	
			('IMPROVEMENT_MISSION',		'FLAVOR_RELIGION',			1);
--==========================================================================================================================
--==========================================================================================================================