--=======================================================================================================================
-- BuildingClasses
--=======================================================================================================================
INSERT OR REPLACE INTO BuildingClasses
			(Type, 									DefaultBuilding, 					Description)
VALUES		('BUILDINGCLASS_JFD_HANNIBAL_CARTHAGE', 'BUILDING_JFD_HANNIBAL_CARTHAGE', 	'TXT_KEY_BUILDING_JFD_CARTHAGE_HANNIBAL'),
			('BUILDINGCLASS_JFD_DIDO_CARTHAGE', 	'BUILDING_JFD_DIDO_CARTHAGE', 		'TXT_KEY_BUILDING_JFD_CARTHAGE_DIDO');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT OR REPLACE INTO Buildings 	
			(Type, 						BuildingClass, Cost, GoldMaintenance, PrereqTech, Water, TradeRouteSeaDistanceModifier, TradeRouteSeaGoldBonus, Description, 						Civilopedia, 						Help, 									Strategy,								 	ArtDefineTag, 	ArtInfoEraVariation, DisplayPosition, AllowsWaterRoutes, MinAreaSize, ConquestProb, GreatPeopleRateModifier,	FreshWater, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_COTHON'),	BuildingClass, Cost, GoldMaintenance, PrereqTech, Water, TradeRouteSeaDistanceModifier, 200, 					('TXT_KEY_BUILDING_JFD_COTHON'), 	('TXT_KEY_CIV5_JFD_COTHON_TEXT'), 	('TXT_KEY_BUILDING_JFD_COTHON_HELP'), 	('TXT_KEY_BUILDING_JFD_COTHON_STRATEGY'), 	ArtDefineTag,	ArtInfoEraVariation, DisplayPosition, AllowsWaterRoutes, MinAreaSize, ConquestProb, GreatPeopleRateModifier,	FreshWater,	HurryCostModifier, 1, 				('JFD_CARTHAGE_DIDO_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_HARBOR');	

INSERT OR REPLACE INTO Buildings		
			(Type, 								BuildingClass, 			  				Cost, 	FaithCost,	GreatWorkCount,	BuildingProductionModifier, Defense,	 PrereqTech, Help,												Description, 								NeverCapture,	NukeImmune)
VALUES		('BUILDING_JFD_HANNIBAL_CARTHAGE', 	'BUILDINGCLASS_JFD_HANNIBAL_CARTHAGE', 	-1, 	-1,			-1,				1, 				 			0,			 null, 		'TXT_KEY_BUILDING_JFD_CARTHAGE_HANNIBAL_HELP',		'TXT_KEY_BUILDING_JFD_CARTHAGE_HANNIBAL',	1,				1),
			('BUILDING_JFD_DIDO_CARTHAGE', 		'BUILDINGCLASS_JFD_DIDO_CARTHAGE', 		-1, 	-1,			-1,				0, 				 			100,		 null, 		'TXT_KEY_BUILDING_JFD_CARTHAGE_DIDO_HELP',			'TXT_KEY_BUILDING_JFD_CARTHAGE_DIDO',		1,				1);
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================		
INSERT OR REPLACE INTO Building_Flavors 	
			(BuildingType, 					FlavorType, Flavor)
SELECT		('BUILDING_JFD_COTHON'),		FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_HARBOR');	

INSERT OR REPLACE INTO Building_Flavors
			(BuildingType,					FlavorType,				Flavor)
VALUES		('BUILDING_JFD_COTHON',			'FLAVOR_DEFENSE',		25),
			('BUILDING_JFD_COTHON',			'FLAVOR_CITY_DEFENSE',	20);
--==========================================================================================================================	
-- Building_SeaResourceYieldChanges
--==========================================================================================================================
INSERT OR REPLACE INTO Building_SeaPlotYieldChanges
			(BuildingType,				YieldType,		Yield)
VALUES		('BUILDING_JFD_COTHON',		'YIELD_GOLD',	1);

INSERT OR REPLACE INTO Building_DomainProductionModifiers
			(BuildingType,				DomainType,		Modifier)
VALUES		('BUILDING_JFD_COTHON',		'DOMAIN_SEA',	15);
--==========================================================================================================================	
--==========================================================================================================================	