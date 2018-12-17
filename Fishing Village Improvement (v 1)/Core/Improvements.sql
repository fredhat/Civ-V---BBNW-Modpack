--==========================================================================================================================
-- Improvements
--==========================================================================================================================
INSERT INTO Improvements
			(Type,							Water,	Description,						Civilopedia,								ArtDefineTag,						RequiresXAdjacentLand,	DestroyedWhenPillaged,	PillageGold,	PortraitIndex,	IconAtlas)
VALUES		('IMPROVEMENT_CL_KAMPUNG',		1,		'TXT_KEY_IMPROVEMENT_CL_KAMPUNG',	'TXT_KEY_IMPROVEMENT_CL_KAMPUNG_PEDIA',		'ART_DEF_IMPROVEMENT_CL_KAMPUNG', 	1,						1,						10,				0,				'CL_KAMPUNG_ATLAS');
--==========================================================================================================================
-- Improvement_ValidTerrains
--==========================================================================================================================
INSERT INTO Improvement_ValidTerrains
			(ImprovementType,			TerrainType)
VALUES		('IMPROVEMENT_CL_KAMPUNG',	'TERRAIN_COAST');
--==========================================================================================================================
-- Improvement_Yields
--==========================================================================================================================
INSERT INTO Improvement_Yields
			(ImprovementType,			YieldType,		Yield)
VALUES		('IMPROVEMENT_CL_KAMPUNG',	'YIELD_FOOD',	1);
--==========================================================================================================================
-- Improvement_TechYieldChanges
--==========================================================================================================================
INSERT INTO Improvement_TechYieldChanges
			(ImprovementType,			TechType,		YieldType,		Yield)
VALUES		('IMPROVEMENT_CL_KAMPUNG',	'TECH_BIOLOGY',	'YIELD_FOOD',	1);
--==========================================================================================================================
-- Improvement_Flavors
--==========================================================================================================================
INSERT INTO Improvement_Flavors
			(ImprovementType,			FlavorType,					Flavor)
VALUES		('IMPROVEMENT_CL_KAMPUNG',	'FLAVOR_TILE_IMPROVEMENT',	20),
			('IMPROVEMENT_CL_KAMPUNG',	'FLAVOR_GROWTH',			1);
--==========================================================================================================================
-- Builds
--==========================================================================================================================
INSERT INTO Builds
			(Type,					PrereqTech,			Water,	CanBeEmbarked,	Time,	ImprovementType,			Description,					EntityEvent,			HotKey, 	OrderPriority,	IconIndex,	IconAtlas)
VALUES		('BUILD_CL_KAMPUNG',	'TECH_COMPASS',		1,		1,				700,	'IMPROVEMENT_CL_KAMPUNG',	'TXT_KEY_BUILD_CL_KAMPUNG',		'ENTITY_EVENT_BUILD',	'KB_V',		96,				1,			'CL_KAMPUNG_ATLAS');
--==========================================================================================================================
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds
			(UnitType,			BuildType)
VALUES		('UNIT_WORKER',		'BUILD_CL_KAMPUNG');
--==========================================================================================================================
--==========================================================================================================================