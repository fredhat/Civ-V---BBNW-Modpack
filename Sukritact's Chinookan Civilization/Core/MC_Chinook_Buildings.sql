--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 	DefaultBuilding, 						Description)
VALUES		('BUILDINGCLASS_MC_CHINOOK', 	'BUILDING_MC_PLANKHOUSE_DUMMY', 		'TXT_KEY_BUILDING_MC_PLANKHOUSE_DUMMY');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 							AllowsWaterRoutes, HurryCostModifier, FreeStartEra,			BuildingClass, PrereqTech, 		Cost,	FaithCost, ConquestProb, SpecialistType, SpecialistCount, GoldMaintenance, 	MinAreaSize, Description, 							Civilopedia, 							Help, 										Strategy,										ArtDefineTag, PortraitIndex,	IconAtlas)
SELECT		('BUILDING_MC_PLANKHOUSE'),		AllowsWaterRoutes, HurryCostModifier, 'ERA_RENAISSANCE',	BuildingClass, 'TECH_POTTERY', 	60,		FaithCost, ConquestProb, SpecialistType, SpecialistCount, GoldMaintenance, 	MinAreaSize, ('TXT_KEY_BUILDING_MC_PLANKHOUSE'),	('TXT_KEY_CIV5_MC_PLANKHOUSE_TEXT'),	('TXT_KEY_BUILDING_MC_PLANKHOUSE_HELP'),	('TXT_KEY_BUILDING_MC_PLANKHOUSE_STRATEGY'),	ArtDefineTag, 3, 				('MC_CHINOOK_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_LIGHTHOUSE';
--==========================================================================================================================	
-- Buildings: Invisible
--==========================================================================================================================
INSERT INTO Buildings 	
			(Type, 								BuildingClass, 				Description,							Help,											GreatWorkCount,	Cost,	FaithCost,	PrereqTech, 	TradeRouteSeaGoldBonus,	TradeRouteLandGoldBonus,	NukeImmune,	NeverCapture)
VALUES		('BUILDING_MC_PLANKHOUSE_DUMMY', 	'BUILDINGCLASS_MC_CHINOOK',	'TXT_KEY_BUILDING_MC_PLANKHOUSE_DUMMY',	'TXT_KEY_BUILDING_MC_PLANKHOUSE_DUMMY_HELP',	-1, 			-1,   		-1,		null,			200,					200,						1,			1);
--==========================================================================================================================	
-- Building_ClassesNeededInCity
--==========================================================================================================================	
INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 				BuildingClassType)
SELECT		('BUILDING_MC_PLANKHOUSE'),	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_LIGHTHOUSE';	
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================	
INSERT INTO Building_YieldChanges
			(BuildingType, 				YieldType, Yield)
SELECT		('BUILDING_MC_PLANKHOUSE'),	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_LIGHTHOUSE';	
--==========================================================================================================================	
-- Building_SeaPlotYieldChanges
--==========================================================================================================================	
INSERT INTO Building_SeaPlotYieldChanges
			(BuildingType, 				YieldType, Yield)
SELECT		('BUILDING_MC_PLANKHOUSE'),	YieldType, Yield
FROM Building_SeaPlotYieldChanges WHERE BuildingType = 'BUILDING_LIGHTHOUSE';
--==========================================================================================================================	
-- Building_LakePlotYieldChanges
--==========================================================================================================================	
INSERT INTO Building_LakePlotYieldChanges
			(BuildingType, 				YieldType,		Yield)
VALUES		('BUILDING_MC_PLANKHOUSE',	'YIELD_FOOD', 	1);
--==========================================================================================================================	
-- Building_FeatureYieldChanges
--==========================================================================================================================	
INSERT INTO Building_FeatureYieldChanges
			(BuildingType, 				FeatureType,				YieldType,		Yield)
VALUES		('BUILDING_MC_PLANKHOUSE',	'FEATURE_LAKE_VICTORIA',	'YIELD_FOOD', 	1);
--==========================================================================================================================	
-- Building_ResourceYieldChanges
--==========================================================================================================================	
INSERT INTO Building_ResourceYieldChanges
			(BuildingType, 				ResourceType,					YieldType,			Yield)
VALUES		('BUILDING_HARBOR',			'RESOURCE_MC_BREEDING_GROUND',	'YIELD_GOLD', 		-1),
			('BUILDING_SEAPORT',		'RESOURCE_MC_BREEDING_GROUND',	'YIELD_PRODUCTION', -1),
			('BUILDING_SEAPORT',		'RESOURCE_MC_BREEDING_GROUND',	'YIELD_GOLD', 		-1);
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================	
INSERT INTO Building_Flavors 	
			(BuildingType, 				FlavorType, Flavor)
SELECT		('BUILDING_MC_PLANKHOUSE'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_LIGHTHOUSE';

INSERT OR REPLACE INTO Building_Flavors 	
			(BuildingType, 				FlavorType, Flavor)
SELECT		('BUILDING_MC_PLANKHOUSE'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CARAVANSARY';

INSERT OR REPLACE INTO Building_Flavors 	
			(BuildingType, 				FlavorType, Flavor)
SELECT		('BUILDING_MC_PLANKHOUSE'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_HARBOR';

DELETE FROM Building_Flavors
WHERE BuildingType = 'BUILDING_MC_PLANKHOUSE' AND FlavorType = 'FLAVOR_WATER_CONNECTION';
--==========================================================================================================================	
--==========================================================================================================================	