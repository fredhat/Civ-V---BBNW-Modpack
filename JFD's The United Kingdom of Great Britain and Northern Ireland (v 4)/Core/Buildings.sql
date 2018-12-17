--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 		 			DefaultBuilding, 							Description)
VALUES		('BUILDINGCLASS_JFD_SEA_TRADE_PRODUCTION', 		'BUILDING_JFD_SEA_TRADE_PRODUCTION',		'TXT_KEY_BUILDING_JFD_SEA_TRADE_PRODUCTION'),
			('BUILDINGCLASS_JFD_NAVAL_AND_AIR_PRODUCTION', 	'BUILDING_JFD_NAVAL_AND_AIR_PRODUCTION',	'TXT_KEY_BUILDING_JFD_NAVAL_AND_AIR_PRODUCTION'),
			('BUILDINGCLASS_JFD_CHURCHILL_TRACKER', 		'BUILDING_JFD_CHURCHILL_TRACKER',			'TXT_KEY_BUILDING_JFD_CHURCHILL_TRACKER');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================		
INSERT INTO Buildings 	
			(Type, 						 				BuildingClass, 									GreatWorkCount, Cost,	FaithCost,	PrereqTech,	NeverCapture,	NukeImmune,	Description, 										Help,													IconAtlas,				PortraitIndex,	ShowInPedia)
VALUES		('BUILDING_JFD_SEA_TRADE_PRODUCTION', 		'BUILDINGCLASS_JFD_SEA_TRADE_PRODUCTION', 		-1,				-1,		-1,			null, 		1,				1,			'TXT_KEY_BUILDING_JFD_SEA_TRADE_PRODUCTION', 		'TXT_KEY_BUILDING_JFD_SEA_TRADE_PRODUCTION_HELP',		null,					0,				0),
			('BUILDING_JFD_NAVAL_AND_AIR_PRODUCTION', 	'BUILDINGCLASS_JFD_NAVAL_AND_AIR_PRODUCTION',	-1,				-1,		-1,			null, 		1,				1,			'TXT_KEY_BUILDING_JFD_NAVAL_AND_AIR_PRODUCTION', 	'TXT_KEY_BUILDING_JFD_NAVAL_AND_AIR_PRODUCTION_HELP',	null,					0,				0),
			('BUILDING_JFD_CHURCHILL_TRACKER', 			'BUILDINGCLASS_JFD_CHURCHILL_TRACKER',			0,				-1,		-1,			null, 		1,				1,			'TXT_KEY_BUILDING_JFD_CHURCHILL_TRACKER', 			'TXT_KEY_BUILDING_JFD_CHURCHILL_TRACKER_HELP',			'TECH_ATLAS_1',			30,				0);
--==========================================================================================================================	
-- Building_YieldModifiers
--==========================================================================================================================		
INSERT INTO Building_YieldChanges
			(BuildingType, 								YieldType, 			Yield)
VALUES		('BUILDING_JFD_SEA_TRADE_PRODUCTION', 		'YIELD_PRODUCTION', 1);	
--==========================================================================================================================	
-- Building_DomainProductionModifiers
--==========================================================================================================================		
INSERT INTO Building_DomainProductionModifiers
			(BuildingType, 								DomainType, 		Modifier)
VALUES		('BUILDING_JFD_NAVAL_AND_AIR_PRODUCTION', 	'DOMAIN_SEA', 		5),	
			('BUILDING_JFD_NAVAL_AND_AIR_PRODUCTION', 	'DOMAIN_AIR', 		5);
--==========================================================================================================================		
--==========================================================================================================================		