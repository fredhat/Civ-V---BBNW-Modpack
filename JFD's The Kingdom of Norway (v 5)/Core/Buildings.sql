--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 		 	DefaultBuilding, 					Description)
VALUES		('BUILDINGCLASS_JFD_STAVE_STORAGE', 	'BUILDING_JFD_STAVE_STORAGE', 		'TXT_KEY_BUILDING_JFD_STAVE_STORAGE'),
			('BUILDINGCLASS_JFD_NORWAY_FISH', 		'BUILDING_JFD_NORWAY_FISH', 		'TXT_KEY_BUILDING_JFD_NORWAY_FISH');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 							BuildingClass, PrereqTech, Cost, GoldMaintenance, 	MinAreaSize, Description, 							Civilopedia, 								Help, 											Strategy,										ArtDefineTag,	ConquestProb, 	PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_STAVE_CHURCH'),	BuildingClass, PrereqTech, Cost, GoldMaintenance-1, MinAreaSize, ('TXT_KEY_BUILDING_JFD_STAVE_CHURCH'), ('TXT_KEY_CIV5_JFD_STAVE_CHURCH_TEXT'),		('TXT_KEY_BUILDING_JFD_STAVE_CHURCH_HELP'), 	('TXT_KEY_BUILDING_JFD_STAVE_CHURCH_STRATEGY'),	ArtDefineTag, 	ConquestProb,	2, 				('JFD_NORWAY_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_TEMPLE';		

INSERT INTO Buildings 	
			(Type, 						 	BuildingClass, 						FoodKept, 	GreatWorkCount, Cost, FaithCost, PrereqTech, Description, 							Help,										NeverCapture,	NukeImmune)
VALUES		('BUILDING_JFD_STAVE_STORAGE', 	'BUILDINGCLASS_JFD_STAVE_STORAGE',	1, 			-1, 			-1,   -1, 		 null, 		 'TXT_KEY_BUILDING_JFD_STAVE_STORAGE', 	'TXT_KEY_BUILDING_JFD_STAVE_STORAGE_HELP',	1,				1),
			('BUILDING_JFD_NORWAY_FISH', 	'BUILDINGCLASS_JFD_NORWAY_FISH',	0, 			-1, 			-1,   -1, 		 null, 		 'TXT_KEY_BUILDING_JFD_NORWAY_FISH', 	'TXT_KEY_BUILDING_JFD_NORWAY_FISH_HELP',	1,				1);
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================	
INSERT INTO Building_YieldChanges 	
			(BuildingType, 					YieldType, Yield)
SELECT		('BUILDING_JFD_STAVE_CHURCH'),	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_TEMPLE';		
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================	
INSERT INTO Building_Flavors 	
			(BuildingType, 					FlavorType, Flavor)
SELECT		('BUILDING_JFD_STAVE_CHURCH'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_TEMPLE';

INSERT INTO Building_Flavors
			(BuildingType,					FlavorType,			Flavor)
VALUES		('BUILDING_JFD_STAVE_CHURCH',	'FLAVOR_GROWTH',	10);
--==========================================================================================================================	
-- Building_ResourceYieldChanges
--==========================================================================================================================	
INSERT INTO Building_ResourceYieldChanges
			(BuildingType,					ResourceType,		YieldType,		Yield)
VALUES		('BUILDING_JFD_NORWAY_FISH',	'RESOURCE_FISH',	'YIELD_FAITH',	1);
--==========================================================================================================================	
--==========================================================================================================================