--==========================================================================================================================
-- Builds
--==========================================================================================================================
INSERT INTO Builds
			(Type,					ImprovementType, 		Description,					Help,								Kill,	OrderPriority,	IconIndex,	IconAtlas,					HotKey, EntityEvent)
VALUES		('BUILD_MISSION',		'IMPROVEMENT_MISSION',	'TXT_KEY_BUILD_F0S_MISSION',	'TXT_KEY_BUILD_F0S_MISSION_HELP',	1,		96,				0,			'F0S_MISSION_BUILD_ATLAS',	'KB_J',	'ENTITY_EVENT_MINE');
--==========================================================================================================================
-- BuildFeatures
--==========================================================================================================================
INSERT INTO BuildFeatures
			(BuildType, 			FeatureType, 		PrereqTech, 			Production, Remove)
VALUES		('BUILD_MISSION',		'FEATURE_JUNGLE',	'TECH_BRONZE_WORKING', 	0, 			1),
			('BUILD_MISSION',		'FEATURE_FOREST',	'TECH_MINING', 			20, 		1),
			('BUILD_MISSION',		'FEATURE_MARSH',	'TECH_MASONRY', 		0, 			1);
--==========================================================================================================================
--==========================================================================================================================