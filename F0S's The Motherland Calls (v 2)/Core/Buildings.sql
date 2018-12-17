--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================
INSERT INTO BuildingClasses 	
			(Type, 							DefaultBuilding, 		Description,					MaxGlobalInstances)
VALUES		('BUILDINGCLASS_MOTHERLAND', 	'BUILDING_MOTHERLAND',	'TXT_KEY_BUILDING_MOTHERLAND',	1);
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================			
DELETE FROM Buildings WHERE Type = 'BUILDING_KREMLIN';

INSERT INTO Buildings 	
			(Type, 					BuildingClass,				Description,						Help,									Civilopedia,							Quote,									Cost,	PrereqTech,			PolicyBranchType,		NukeImmune,	HurryCostModifier,	MinAreaSize,	ConquestProb,	FreePolicies,	IconAtlas,				PortraitIndex,	WonderSplashImage,			WonderSplashAnchor)
VALUES		('BUILDING_MOTHERLAND', 'BUILDINGCLASS_MOTHERLAND',	'TXT_KEY_BUILDING_F0S_MOTHERLAND',	'TXT_KEY_WONDER_F0S_MOTHERLAND_HELP',	'TXT_KEY_WONDER_F0S_MOTHERLAND_PEDIA',	'TXT_KEY_WONDER_F0S_MOTHERLAND_QUOTE',	1060,	'TECH_RAILROAD',	'POLICY_BRANCH_ORDER',	1,			-1,					-1,				100,			1,				'BW_ATLAS_MOTHERLAND',	0,				'motherland_splash.dds',	'R,B');

INSERT INTO Buildings 	
			(Type, 					BuildingClass,				Description,						Help,									Civilopedia,							Quote,									Cost,	PrereqTech,				ArtDefineTag,	MaxStartEra,		SpecialistType,			NearbyTerrainRequired,	EnhancedYieldTech,	GreatPeopleRateChange,	NukeImmune,	ExtraSpies,	Espionage,	HurryCostModifier,	MinAreaSize,	ConquestProb,	DisplayPosition,	IconAtlas,		PortraitIndex,	WonderSplashImage,			WonderSplashAudio)
VALUES		('BUILDING_KREMLIN', 	'BUILDINGCLASS_KREMLIN',	'TXT_KEY_BUILDING_KREMLIN',			'TXT_KEY_WONDER_F0S_KREMLIN_HELP',		'TXT_KEY_WONDER_KREMLIN_DESC',			'TXT_KEY_WONDER_KREMLIN_QUOTE',			300,	'TECH_METAL_CASTING',	'KREMLIN',		'ERA_RENAISSANCE',	'SPECIALIST_ENGINEER',	'TERRAIN_TUNDRA',		'TECH_BIOLOGY',		1,						1,			1,			1,			-1,					-1,				100,			1,					'BW_ATLAS_2',	13,				'WonderConceptKremlin.dds',	'AS2D_WONDER_SPEECH_THE_KREMLIN');
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================
INSERT INTO Building_YieldChanges 	
			(BuildingType, 				YieldType, 			Yield)
VALUES		('BUILDING_MOTHERLAND', 	'YIELD_CULTURE', 	1);
--==========================================================================================================================	
-- Building_FeatureYieldChanges
--==========================================================================================================================
INSERT INTO Building_FeatureYieldChanges 	
			(BuildingType, 				FeatureType,		YieldType, 			Yield)
VALUES		('BUILDING_KREMLIN', 		'FEATURE_FOREST',	'YIELD_CULTURE', 	1);
--==========================================================================================================================	
-- Building_TerrainYieldChanges
--==========================================================================================================================
INSERT INTO Building_TerrainYieldChanges 	
			(BuildingType, 				TerrainType,		YieldType, 			Yield)
VALUES		('BUILDING_KREMLIN', 		'TERRAIN_TUNDRA',	'YIELD_PRODUCTION', 1);
--==========================================================================================================================	
-- Building_TechEnhancedYieldChanges
--==========================================================================================================================
INSERT INTO Building_TechEnhancedYieldChanges 	
			(BuildingType, 				YieldType, 			Yield)
VALUES		('BUILDING_KREMLIN', 		'YIELD_GOLD', 		6);
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================
DELETE FROM Building_Flavors WHERE BuildingType = 'BUILDING_KREMLIN';

INSERT INTO Building_Flavors 	
			(BuildingType, 				FlavorType, 			Flavor)
VALUES		('BUILDING_MOTHERLAND', 	'FLAVOR_CITY_DEFENSE',	30),
			('BUILDING_MOTHERLAND', 	'FLAVOR_CULTURE', 		10),
			('BUILDING_MOTHERLAND', 	'FLAVOR_WONDER', 		25),
			('BUILDING_MOTHERLAND', 	'FLAVOR_GREAT_PEOPLE', 	10),
			('BUILDING_KREMLIN', 		'FLAVOR_ESPIONAGE', 	10),
			('BUILDING_KREMLIN', 		'FLAVOR_PRODUCTION', 	20),
			('BUILDING_KREMLIN', 		'FLAVOR_GOLD', 			10),
			('BUILDING_KREMLIN', 		'FLAVOR_CULTURE', 		20),
			('BUILDING_KREMLIN', 		'FLAVOR_WONDER', 		15),
			('BUILDING_KREMLIN', 		'FLAVOR_GREAT_PEOPLE', 	10);
--==========================================================================================================================	
-- Building_UnitCombatProductionModifiers
--==========================================================================================================================
DELETE FROM Building_UnitCombatProductionModifiers WHERE BuildingType = 'BUILDING_KREMLIN';
--==========================================================================================================================		
--==========================================================================================================================