--==========================================================================================================================
-- Builds
--==========================================================================================================================
INSERT INTO Builds
			(Type,				PrereqTech,				Time,	ImprovementType,			Description,				Help,								Recommendation,					EntityEvent,				HotKey,		OrderPriority,	IconAtlas,						IconIndex)
VALUES 		('BUILD_FOREST',	'TECH_FERTILIZER',		700,	'IMPROVEMENT_PLANT_FOREST',	'TXT_KEY_BUILD_F0S_FOREST',	'TXT_KEY_BUILD_F0S_FOREST_HELP',	'TXT_KEY_BUILD_F0S_FOREST_REC',	'ENTITY_EVENT_IRRIGATE',	'KB_F',		37,				'UNIT_ACTION_REFOREST_ATLAS',	0);
--==========================================================================================================================
-- Builds
--==========================================================================================================================
INSERT INTO BuildFeatures
			(BuildType,			FeatureType,		PrereqTech,				Time,   Production,	Remove)
VALUES 		('BUILD_FOREST',	'FEATURE_FOREST',	'TECH_MINING',			400,	20,			1),
			('BUILD_FOREST',	'FEATURE_JUNGLE',	'TECH_BRONZE_WORKING',	700,	0,			1),
			('BUILD_FOREST',	'FEATURE_MARSH',	'TECH_MASONRY',			600,	0,			1);
--==========================================================================================================================
--==========================================================================================================================