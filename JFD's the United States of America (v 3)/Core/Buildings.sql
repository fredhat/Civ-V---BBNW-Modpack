--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT OR REPLACE INTO BuildingClasses 	
			(Type, 						 						DefaultBuilding, 							Description)
VALUES		('BUILDINGCLASS_JFD_ROOSEVELT_PRODUCTION_DUMMY', 	'BUILDING_JFD_ROOSEVELT_PRODUCTION_DUMMY', 	'TXT_KEY_BUILDING_JFD_ROOSEVELT_PRODUCTION_DUMMY'),
			('BUILDINGCLASS_JFD_ROOSEVELT_ENGINEER_DUMMY', 		'BUILDING_JFD_ROOSEVELT_ENGINEER_DUMMY', 	'TXT_KEY_BUILDING_JFD_ROOSEVELT_ENGINEER_DUMMY'),
			('BUILDINGCLASS_JFD_ROOSEVELT_GOLD_DUMMY', 			'BUILDING_JFD_ROOSEVELT_GOLD_DUMMY', 		'TXT_KEY_BUILDING_JFD_ROOSEVELT_GOLD_DUMMY'),
			('BUILDINGCLASS_JFD_ROOSEVELT_MERCHANT_DUMMY', 		'BUILDING_JFD_ROOSEVELT_MERCHANT_DUMMY', 	'TXT_KEY_BUILDING_JFD_ROOSEVELT_MERCHANT_DUMMY'),
			('BUILDINGCLASS_JFD_ROOSEVELT_INDUSTRY_MONITOR', 	'BUILDING_JFD_ROOSEVELT_INDUSTRY_MONITOR', 	'TXT_KEY_BUILDING_JFD_ROOSEVELT_INDUSTRY_MONITOR'),
			('BUILDINGCLASS_JFD_ROOSEVELT_ECONOMY_MONITOR', 	'BUILDING_JFD_ROOSEVELT_ECONOMY_MONITOR', 	'TXT_KEY_BUILDING_JFD_ROOSEVELT_ECONOMY_MONITOR');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 							BuildingClass, Cost, GoldMaintenance, 	PrereqTech, Description, 							Civilopedia, 							Help, 											Strategy,										XBuiltTriggersIdeologyChoice,	TrainedFreePromotion,			SpecialistType, SpecialistCount, ArtDefineTag,	MinAreaSize, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_ARMS_FACTORY'),	BuildingClass, Cost, GoldMaintenance, 	PrereqTech, ('TXT_KEY_BUILDING_JFD_ARMS_FACTORY'), ('TXT_KEY_CIV5_BUILDINGS_FACTORY_TEXT'), ('TXT_KEY_BUILDING_JFD_ARMS_FACTORY_HELP'), 	('TXT_KEY_BUILDING_JFD_ARMS_FACTORY_STRATEGY'),	1,								'PROMOTION_JFD_ARMS_FACTORY',	SpecialistType, SpecialistCount, ArtDefineTag,	MinAreaSize, ConquestProb, HurryCostModifier, 2, 				('JFD_AMERICA_ROOSEVELT_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_FACTORY');	

INSERT OR REPLACE INTO Buildings 	
			(Type, 						 					BuildingClass, 										GreatWorkCount,	Cost,	FaithCost,	PrereqTech,		SpecialistType,			GreatPeopleRateChange,	Description, 										Help,														NeverCapture,	NukeImmune,	IconAtlas,			PortraitIndex,	ShowInPedia)
VALUES		('BUILDING_JFD_ROOSEVELT_PRODUCTION_DUMMY',		'BUILDINGCLASS_JFD_ROOSEVELT_PRODUCTION_DUMMY', 	-1,				-1,		-1, 		null, 			null,					0,						'TXT_KEY_BUILDING_JFD_ROOSEVELT_PRODUCTION_DUMMY',	'TXT_KEY_BUILDING_JFD_ROOSEVELT_PRODUCTION_DUMMY_HELP',		1,				1,			null,				0,				0),
			('BUILDING_JFD_ROOSEVELT_ENGINEER_DUMMY',		'BUILDINGCLASS_JFD_ROOSEVELT_ENGINEER_DUMMY', 		-1,				-1,		-1, 		null, 			'SPECIALIST_ENGINEER',	1,						'TXT_KEY_BUILDING_JFD_ROOSEVELT_ENGINEER_DUMMY',	'TXT_KEY_BUILDING_JFD_ROOSEVELT_ENGINEER_DUMMY_HELP',		1,				1,			null,				0,				0),
			('BUILDING_JFD_ROOSEVELT_GOLD_DUMMY',			'BUILDINGCLASS_JFD_ROOSEVELT_GOLD_DUMMY', 			-1,				-1,		-1, 		null, 			null,					0,						'TXT_KEY_BUILDING_JFD_ROOSEVELT_GOLD_DUMMY',		'TXT_KEY_BUILDING_JFD_ROOSEVELT_GOLD_DUMMY_HELP',			1,				1,			null,				0,				0),
			('BUILDING_JFD_ROOSEVELT_MERCHANT_DUMMY',		'BUILDINGCLASS_JFD_ROOSEVELT_MERCHANT_DUMMY', 		-1,				-1,		-1, 		null, 			'SPECIALIST_MERCHANT',	1,						'TXT_KEY_BUILDING_JFD_ROOSEVELT_MERCHANT_DUMMY',	'TXT_KEY_BUILDING_JFD_ROOSEVELT_MERCHANT_DUMMY_HELP',		1,				1,			null,				0,				0),
			('BUILDING_JFD_ROOSEVELT_INDUSTRY_MONITOR',		'BUILDINGCLASS_JFD_ROOSEVELT_INDUSTRY_MONITOR', 	0,				-1,		-1, 		null, 			null,					0,						'TXT_KEY_BUILDING_JFD_ROOSEVELT_INDUSTRY_MONITOR',	null,														1,				1,			'TECH_ATLAS_1', 	49,				0),
			('BUILDING_JFD_ROOSEVELT_ECONOMY_MONITOR',		'BUILDINGCLASS_JFD_ROOSEVELT_ECONOMY_MONITOR', 		0,				-1,		-1, 		null, 			null,					0,						'TXT_KEY_BUILDING_JFD_ROOSEVELT_ECONOMY_MONITOR',	null,														1,				1,			'TECH_ATLAS_1',		31,				0);

INSERT OR REPLACE INTO Buildings 	
			(Type, 					BuildingClass, Cost, GoldMaintenance, 	PrereqTech,			Description, 					Civilopedia, 						Help, 									Strategy,									ArtDefineTag, 	MinAreaSize, ConquestProb, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_RANCH'),	BuildingClass, Cost, GoldMaintenance, 	'TECH_TRAPPING',	('TXT_KEY_BUILDING_JFD_RANCH'), ('TXT_KEY_CIV5_JFD_RANCH_TEXT'), 	('TXT_KEY_BUILDING_JFD_RANCH_HELP'), 	('TXT_KEY_BUILDING_JFD_RANCH_STRATEGY'),	ArtDefineTag,	MinAreaSize, ConquestProb, HurryCostModifier, 3, 				('JFD_AMERICA_ROOSEVELT_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_STABLE');
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================		
INSERT INTO Building_Flavors 	
			(BuildingType, 					FlavorType, Flavor)
SELECT		('BUILDING_JFD_ARMS_FACTORY'),	FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_FACTORY');	
--------------------------------	
-- America (Washington)
--------------------------------
INSERT OR REPLACE INTO Building_Flavors 	
			(BuildingType, 			FlavorType, Flavor)
SELECT		('BUILDING_JFD_RANCH'),	FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_STABLE');
--==========================================================================================================================	
-- Building_ClassesNeededInCity
--==========================================================================================================================		
INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 					BuildingClassType)
SELECT		('BUILDING_JFD_ARMS_FACTORY'),	BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_FACTORY');	
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================		
INSERT INTO Building_YieldChanges 	
			(BuildingType, 					YieldType, Yield)
SELECT		('BUILDING_JFD_ARMS_FACTORY'),	YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_FACTORY');

INSERT INTO Building_YieldChanges 	
			(BuildingType, 								YieldType, 			Yield)
VALUES		('BUILDING_JFD_ROOSEVELT_PRODUCTION_DUMMY',	'YIELD_PRODUCTION',	1),
			('BUILDING_JFD_ROOSEVELT_GOLD_DUMMY',		'YIELD_GOLD',		1);
--==========================================================================================================================	
-- Building_YieldModifiers
--==========================================================================================================================		
INSERT INTO Building_YieldModifiers 	
			(BuildingType, 					YieldType, Yield)
SELECT		('BUILDING_JFD_ARMS_FACTORY'),	YieldType, Yield
FROM Building_YieldModifiers WHERE (BuildingType = 'BUILDING_FACTORY');
--==========================================================================================================================	
-- Building_ResourceQuantityRequirements
--==========================================================================================================================		
INSERT INTO Building_ResourceQuantityRequirements 	
			(BuildingType, 					ResourceType, Cost)
SELECT		('BUILDING_JFD_ARMS_FACTORY'),	ResourceType, Cost
FROM Building_ResourceQuantityRequirements WHERE (BuildingType = 'BUILDING_FACTORY');	
--==========================================================================================================================	
-- Building_UnitCombatProductionModifiers
--==========================================================================================================================	
-- America (Washington)
--------------------------------	
INSERT OR REPLACE INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, 			UnitCombatType, 				Modifier)
VALUES		('BUILDING_JFD_RANCH',	'UNITCOMBAT_MOUNTED',			10),
			('BUILDING_JFD_RANCH',	'UNITCOMBAT_MOUNTED_RANGED',	10);

INSERT INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, 					UnitCombatType,			Modifier)
VALUES		('BUILDING_JFD_ARMS_FACTORY',	'UNITCOMBAT_SIEGE',		15),
			('BUILDING_JFD_ARMS_FACTORY',	'UNITCOMBAT_ARMOR',		15);
--==========================================================================================================================	
-- Building_DomainProductionModifiers
--==========================================================================================================================	
INSERT INTO Building_DomainProductionModifiers 	
			(BuildingType, 					DomainType,		Modifier)
VALUES		('BUILDING_JFD_ARMS_FACTORY',	'DOMAIN_AIR',	15);
--==========================================================================================================================	
-- Building_ResourceYieldChanges
--==========================================================================================================================	
-- America (Washington)
--------------------------------	
INSERT OR REPLACE INTO Building_ResourceYieldChanges 	
			(BuildingType, 			ResourceType, YieldType,	Yield)
SELECT		('BUILDING_JFD_RANCH'),	ResourceType, YieldType,	Yield
FROM Building_ResourceYieldChanges WHERE (BuildingType = 'BUILDING_STABLE');

INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, 			ResourceType, 		YieldType,				Yield)
VALUES		('BUILDING_JFD_RANCH',	'RESOURCE_BISON',	'YIELD_PRODUCTION' ,	1),
			('BUILDING_JFD_RANCH',	'RESOURCE_DEER',	'YIELD_PRODUCTION' ,	1);
--==========================================================================================================================	
--==========================================================================================================================	