--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================			
INSERT OR REPLACE INTO BuildingClasses 
			(DefaultBuilding, 			Type, 							Description)
VALUES		('BUILDING_JFD_FLANDERS', 	'BUILDINGCLASS_JFD_FLANDERS',	'TXT_KEY_BUILDING_JFD_FLANDERS'),
			('BUILDING_JFD_BELFORT_2', 	'BUILDINGCLASS_JFD_BELFORT_2',	'TXT_KEY_BUILDING_JFD_BELFORT'),
			('BUILDING_JFD_BELFORT_3', 	'BUILDINGCLASS_JFD_BELFORT_3',	'TXT_KEY_BUILDING_JFD_BELFORT'),
			('BUILDING_JFD_F_GOLD',	 	'BUILDINGCLASS_JFD_F_GOLD',		'TXT_KEY_BUILDING_JFD_FLANDERS_G');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================			
INSERT INTO Buildings
			(Type, 						BuildingClass, Cost,	PrereqTech,		 FreeStartEra,	AllowsRangeStrike, ExtraCityHitPoints,		Defense,		ArtInfoCulturalVariation, Description,						Help,									Civilopedia,									Strategy,									ArtDefineTag, MinAreaSize, 	HurryCostModifier, 	IconAtlas,				ConquestProb, 	PortraitIndex)
SELECT		('BUILDING_JFD_BELFORT'),	BuildingClass, Cost-60,	('TECH_GUILDS'), FreeStartEra,	AllowsRangeStrike, ExtraCityHitPoints-10,	Defense-400,	ArtInfoCulturalVariation, ('TXT_KEY_BUILDING_JFD_BELFORT'),	('TXT_KEY_BUILDING_JFD_BELFORT_HELP'),	('TXT_KEY_CIV5_BUILDINGS_JFD_BELFORT_TEXT'),	('TXT_KEY_BUILDING_JFD_BELFORT_STRATEGY'),	ArtDefineTag, MinAreaSize, 	HurryCostModifier, 	('JFD_FLANDERS_ATLAS'),	66, 			3	
FROM Buildings WHERE Type = 'BUILDING_CASTLE';	

INSERT INTO Buildings
			(Type, 						BuildingClass,					 Cost,		PrereqTech,		FreeStartEra,	AllowsRangeStrike, ExtraCityHitPoints,		Defense,		ArtInfoCulturalVariation, Description,						Help,									Civilopedia,									Strategy,									ArtDefineTag, MinAreaSize, 	HurryCostModifier, 	IconAtlas,				ConquestProb, 	PortraitIndex,  ShowInPedia)
SELECT		('BUILDING_JFD_BELFORT_2'),	('BUILDINGCLASS_JFD_BELFORT_2'), Cost-60,	null,			FreeStartEra,	AllowsRangeStrike, ExtraCityHitPoints-10,	Defense-400,	ArtInfoCulturalVariation, ('TXT_KEY_BUILDING_JFD_BELFORT'),	('TXT_KEY_BUILDING_JFD_BELFORT_HELP'),	('TXT_KEY_CIV5_BUILDINGS_JFD_BELFORT_TEXT'),	('TXT_KEY_BUILDING_JFD_BELFORT_STRATEGY'),	ArtDefineTag, MinAreaSize, 	HurryCostModifier, 	('JFD_FLANDERS_ATLAS'),	66, 			3,				0	
FROM Buildings WHERE Type = 'BUILDING_CASTLE';	

INSERT INTO Buildings
			(Type, 						BuildingClass,					 Cost,		PrereqTech,		FreeStartEra,	AllowsRangeStrike, ExtraCityHitPoints,		Defense,		ArtInfoCulturalVariation, Description,						Help,									Civilopedia,									Strategy,									ArtDefineTag, MinAreaSize, 	HurryCostModifier, 	IconAtlas,				ConquestProb, 	PortraitIndex,	ShowInPedia)
SELECT		('BUILDING_JFD_BELFORT_3'),	('BUILDINGCLASS_JFD_BELFORT_3'), Cost-60,	null,			FreeStartEra,	AllowsRangeStrike, ExtraCityHitPoints-10,	Defense-400,	ArtInfoCulturalVariation, ('TXT_KEY_BUILDING_JFD_BELFORT'),	('TXT_KEY_BUILDING_JFD_BELFORT_HELP'),	('TXT_KEY_CIV5_BUILDINGS_JFD_BELFORT_TEXT'),	('TXT_KEY_BUILDING_JFD_BELFORT_STRATEGY'),	ArtDefineTag, MinAreaSize, 	HurryCostModifier, 	('JFD_FLANDERS_ATLAS'),	66, 			3,				0
FROM Buildings WHERE Type = 'BUILDING_CASTLE';	

INSERT OR REPLACE INTO Buildings 
			(Type, 							BuildingClass, 					BuildingProductionModifier, GreatWorkCount, Cost, 	FaithCost,	NukeImmune,	NeverCapture,	Description, 							Help)
VALUES		('BUILDING_JFD_FLANDERS', 		'BUILDINGCLASS_JFD_FLANDERS',	5,							-1,				-1, 	-1,			1,			1,				'TXT_KEY_BUILDING_JFD_FLANDERS', 		'TXT_KEY_BUILDING_JFD_FLANDERS_HELP');

INSERT OR REPLACE INTO Buildings 
			(Type, 							BuildingClass, 					GreatWorkCount, Cost, 	FaithCost,	NukeImmune,	NeverCapture,	Description, 							Help)
VALUES		('BUILDING_JFD_F_GOLD', 		'BUILDINGCLASS_JFD_F_GOLD',		-1,				-1, 	-1,			1,			1,				'TXT_KEY_BUILDING_JFD_FLANDERS_G', 		'TXT_KEY_BUILDING_JFD_FLANDERS_HELP_G');

INSERT OR REPLACE INTO Building_BuildingClassYieldChanges 
			(BuildingType, 					BuildingClassType, 					YieldType, 			YieldChange)
VALUES		('BUILDING_NEUSCHWANSTEIN', 	'BUILDINGCLASS_JFD_BELFORT_2',		'YIELD_GOLD',		3),
			('BUILDING_NEUSCHWANSTEIN', 	'BUILDINGCLASS_JFD_BELFORT_3',		'YIELD_GOLD',		3),
			('BUILDING_NEUSCHWANSTEIN', 	'BUILDINGCLASS_JFD_BELFORT_2',		'YIELD_CULTURE',	2),
			('BUILDING_NEUSCHWANSTEIN', 	'BUILDINGCLASS_JFD_BELFORT_3',		'YIELD_CULTURE',	2);
			
INSERT OR REPLACE INTO Building_BuildingClassHappiness 
			(BuildingType, 					BuildingClassType, 					Happiness)
VALUES		('BUILDING_NEUSCHWANSTEIN', 	'BUILDINGCLASS_JFD_BELFORT_2',		1),
			('BUILDING_NEUSCHWANSTEIN', 	'BUILDINGCLASS_JFD_BELFORT_3',		1);
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================					
INSERT INTO Building_Flavors
			(BuildingType, 				FlavorType, Flavor)
SELECT		('BUILDING_JFD_BELFORT'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CASTLE';

INSERT INTO Building_Flavors
			(BuildingType, 				FlavorType, Flavor)
SELECT		('BUILDING_JFD_BELFORT_2'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CASTLE';	

INSERT INTO Building_Flavors
			(BuildingType, 				FlavorType, Flavor)
SELECT		('BUILDING_JFD_BELFORT_3'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CASTLE';	

INSERT INTO Building_Flavors 
			(BuildingType, 				FlavorType,			Flavor)
VALUES		('BUILDING_JFD_BELFORT', 	'FLAVOR_CULTURE',	30),
			('BUILDING_JFD_BELFORT_2', 	'FLAVOR_CULTURE',	30),
			('BUILDING_JFD_BELFORT_3', 	'FLAVOR_CULTURE',	30);
--==========================================================================================================================	
-- Building_ClassesNeededInCity
--==========================================================================================================================					
INSERT INTO Building_ClassesNeededInCity 
			(BuildingType, 				BuildingClassType)
VALUES		('BUILDING_JFD_BELFORT', 	'BUILDINGCLASS_MARKET'),
			('BUILDING_JFD_BELFORT_2', 	'BUILDINGCLASS_TEMPLE'),
			('BUILDING_JFD_BELFORT_2', 	'BUILDINGCLASS_CASTLE'),
			('BUILDING_JFD_BELFORT_3', 	'BUILDINGCLASS_UNIVERSITY'),
			('BUILDING_JFD_BELFORT_3', 	'BUILDINGCLASS_JFD_BELFORT_2');
			
INSERT INTO Building_YieldChanges 
			(BuildingType, 				YieldType,		Yield)
VALUES		('BUILDING_JFD_F_GOLD', 	'YIELD_GOLD',	1);
--==========================================================================================================================	
-- Policy_BuildingClassHappiness
--==========================================================================================================================					
INSERT INTO Policy_BuildingClassHappiness 
			(PolicyType, 					BuildingClassType,				Happiness)
VALUES		('POLICY_FORTIFIED_BORDERS', 	'BUILDINGCLASS_JFD_BELFORT_2',	1),
			('POLICY_FORTIFIED_BORDERS', 	'BUILDINGCLASS_JFD_BELFORT_3',	1);
--==========================================================================================================================
--==========================================================================================================================