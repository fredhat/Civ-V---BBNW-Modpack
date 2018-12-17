--=======================================================================================================================
-- BuildingClasses
--=======================================================================================================================
INSERT INTO BuildingClasses
			(Type, 										DefaultBuilding, 						Description)
VALUES		('BUILDINGCLASS_JFD_PETRINE_EXPANSION', 	'BUILDING_JFD_PETRINE_EXPANSION', 		'TXT_KEY_BUILDING_JFD_PETRINE_EXPANSION_DESC');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings		
			(Type, 								BuildingClass, 			  					Cost, 	FaithCost,	GreatWorkCount,	Happiness,	PlotCultureCostModifier, 	PlotBuyCostModifier,	PrereqTech, Help,												Description, 									NeverCapture,	NukeImmune)
VALUES		('BUILDING_JFD_PETRINE_EXPANSION', 	'BUILDINGCLASS_JFD_PETRINE_EXPANSION', 		-1, 	-1,			-1,				2,			-25,						-25,					NULL, 		'TXT_KEY_BUILDING_JFD_PETRINE_EXPANSION_HELP',		'TXT_KEY_BUILDING_JFD_PETRINE_EXPANSION', 		1,				1);
--------------------------------	
-- Russia (Catherine)
--------------------------------
UPDATE Buildings
SET Defense = 500, GoldMaintenance = 0, Help = 'TXT_KEY_BUILDING_JFD_KREPOST_HELP', Strategy = 'TXT_KEY_BUILDING_JFD_KREPOST_STRATEGY'
WHERE Type = 'BUILDING_KREPOST';

INSERT INTO Buildings 	
			(Type, 					BuildingClass, Cost,	GoldMaintenance, PrereqTech, Description, 						Civilopedia, 						Help, 									Strategy,								 Happiness,	PlotBuyCostModifier,	ArtDefineTag, 	MinAreaSize, ConquestProb, GreatPeopleRateModifier, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_BANYA'),	BuildingClass, Cost,	GoldMaintenance, PrereqTech, ('TXT_KEY_BUILDING_JFD_BANYA'), 	('TXT_KEY_CIV5_JFD_BANYA_TEXT'), 	('TXT_KEY_BUILDING_JFD_BANYA_HELP'), 	('TXT_KEY_BUILDING_JFD_BANYA_STRATEGY'), 2,			-25,					ArtDefineTag,	MinAreaSize, ConquestProb, GreatPeopleRateModifier,	HurryCostModifier, 3, 				('JFD_RUSSIA_PETER_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_GARDEN');	
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================		
-- Russia (Catherine)
--------------------------------
INSERT INTO Building_Flavors 	
			(BuildingType, 			FlavorType, Flavor)
SELECT		('BUILDING_JFD_BANYA'),	FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_GARDEN');	

INSERT INTO Building_Flavors
			(BuildingType,			FlavorType,				Flavor)
VALUES		('BUILDING_KREPOST',	'FLAVOR_HAPPINESS',		20),
			('BUILDING_KREPOST',	'FLAVOR_CITY_DEFENSE',	20),
			('BUILDING_JFD_BANYA',	'FLAVOR_HAPPINESS',		30),
			('BUILDING_JFD_BANYA',	'FLAVOR_EXPANSION',		25),
			('BUILDING_JFD_BANYA',	'FLAVOR_GOLD',			20);
--==========================================================================================================================	
--==========================================================================================================================	