--==========================================================================================================================
-- Improvements
--==========================================================================================================================
INSERT INTO Improvements
			(Type,									SpecificCivRequired,	CivilizationType,			NoTwoAdjacent,	HillsMakesValid,	Description,						Help,											Civilopedia,									ArtDefineTag,					BuildableOnResources,	DestroyedWhenPillaged,	Permanent,	PillageGold,	DefenseModifier,	PortraitIndex,	IconAtlas,			ShowInPedia)
VALUES		('IMPROVEMENT_JFD_SCHLOSS',				1,						'CIVILIZATION_JFD_BAVARIA',	1,				1,					'TXT_KEY_IMPROVEMENT_JFD_SCHLOSS',	'TXT_KEY_CIV5_IMPROVEMENTS_JFD_SCHLOSS_HELP',	'TXT_KEY_CIV5_IMPROVEMENTS_JFD_SCHLOSS_TEXT',	'ART_DEF_IMPROVEMENT_SCHLOSS', 	0,						0,						1,			50,				0,					0,				'JFD_SCHLOSS_ATLAS',1),
			('IMPROVEMENT_JFD_SCHLOSS_CULTURED',	1,						'CIVILIZATION_JFD_BAVARIA',	1,				1,					'TXT_KEY_IMPROVEMENT_JFD_SCHLOSS',	'TXT_KEY_CIV5_IMPROVEMENTS_JFD_SCHLOSS_HELP',	'TXT_KEY_CIV5_IMPROVEMENTS_JFD_SCHLOSS_TEXT',	'ART_DEF_IMPROVEMENT_SCHLOSS', 	0,						0,						1,			50,				50,					0,				'JFD_SCHLOSS_ATLAS',0);
--==========================================================================================================================
-- Improvement_ValidTerrains
--==========================================================================================================================
INSERT INTO Improvement_ValidTerrains
			(ImprovementType,				TerrainType)
VALUES		('IMPROVEMENT_JFD_SCHLOSS',		'TERRAIN_HILL');
--==========================================================================================================================
-- Improvement_Yields
--==========================================================================================================================
INSERT INTO Improvement_Yields
			(ImprovementType,						YieldType,			Yield)
VALUES		('IMPROVEMENT_JFD_SCHLOSS_CULTURED',	'YIELD_GOLD',		3),
			('IMPROVEMENT_JFD_SCHLOSS_CULTURED',	'YIELD_CULTURE',	3),
			('IMPROVEMENT_JFD_SCHLOSS',				'YIELD_CULTURE',	3);
--==========================================================================================================================
-- Improvement_ResourceTypes
--==========================================================================================================================
INSERT INTO Improvement_ResourceTypes 	
		(ImprovementType, 					ResourceType)
SELECT	'IMPROVEMENT_JFD_SCHLOSS', 			ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_CITADEL';

INSERT INTO Improvement_ResourceTypes 	
		(ImprovementType, 					ResourceType)
SELECT	'IMPROVEMENT_JFD_SCHLOSS_CULTURED', ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_CITADEL';
--==========================================================================================================================
-- Improvement_AdjacentMountainYieldChanges
--==========================================================================================================================
INSERT INTO Improvement_AdjacentMountainYieldChanges
			(ImprovementType,						YieldType,			Yield)
VALUES		('IMPROVEMENT_JFD_SCHLOSS',				'YIELD_CULTURE',	1),	
			('IMPROVEMENT_JFD_SCHLOSS_CULTURED',	'YIELD_CULTURE',	1);
--==========================================================================================================================
--==========================================================================================================================