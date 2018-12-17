--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 									DefaultBuilding, 				Description)
VALUES		('BUILDINGCLASS_JFD_DENMARK_NORWAY', 	'BUILDING_JFD_DENMARK_NORWAY', 	'TXT_KEY_BUILDING_JFD_DENMARK_NORWAY'),
			('BUILDINGCLASS_JFD_SONGHAI_TRACKER', 	'BUILDING_JFD_SONGHAI_TRACKER',	'TXT_KEY_BUILDING_JFD_SONGHAI_TRACKER'),
			('BUILDINGCLASS_JFD_SONGHAI_SCIENCE', 	'BUILDING_JFD_SONGHAI_SCIENCE',	'TXT_KEY_BUILDING_JFD_SONGHAI_SCIENCE');
--==========================================================================================================================
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
		(Type, 						BuildingClass,	Cost, Happiness, GoldMaintenance, GreatPeopleRateModifier,	PrereqTech,	Description, 						Help, 									Civilopedia, 							Strategy,								 	ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT	'BUILDING_JFD_MEAD_HALL',	BuildingClass,	Cost, Happiness, GoldMaintenance, 10,						PrereqTech,	'TXT_KEY_BUILDING_JFD_MEAD_HALL',	'TXT_KEY_BUILDING_JFD_MEAD_HALL_HELP',	'TXT_KEY_BUILDING_JFD_MEAD_HALL_TEXT',	'TXT_KEY_BUILDING_JFD_MEAD_HALL_STRATEGY',	ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, 0, 			 'JFD_MEAD_HALL_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_CIRCUS';	

INSERT INTO Buildings 	
			(Type, 						 	BuildingClass, 							SpecialistType,						SpecialistCount,	AllowsWaterRoutes,	Water,	GreatWorkCount,	Cost, FaithCost, PrereqTech, Description, 								Help,											PortraitIndex,	IconAtlas,		ShowInPedia)
VALUES		('BUILDING_JFD_DENMARK_NORWAY', 'BUILDINGCLASS_JFD_DENMARK_NORWAY', 	'SPECIALIST_JFD_DENMARK_GENERAL',	3,					1,					1,		0,				-1,   -1, 		 NULL, 		 'TXT_KEY_BUILDING_JFD_DENMARK_NORWAY', 	'TXT_KEY_BUILDING_JFD_DENMARK_NORWAY_HELP',		13,				'TECH_ATLAS_1',	0),
			('BUILDING_JFD_SONGHAI_TRACKER','BUILDINGCLASS_JFD_SONGHAI_TRACKER', 	null,								0,					0,					0,		0,				-1,   -1, 		 NULL, 		 'TXT_KEY_BUILDING_JFD_SONGHAI_TRACKER', 	'TXT_KEY_BUILDING_JFD_SONGHAI_TRACKER_HELP',	47,				'TECH_ATLAS_1',	0),
			('BUILDING_JFD_SONGHAI_SCIENCE','BUILDINGCLASS_JFD_SONGHAI_SCIENCE', 	null,								0,					0,					0,		-1,				-1,   -1, 		 NULL, 		 'TXT_KEY_BUILDING_JFD_SONGHAI_SCIENCE', 	'TXT_KEY_BUILDING_JFD_SONGHAI_SCIENCE_HELP',	0,				null,			0);

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_JFD_MUD_PYRAMID_MOSQUE_HELP', Strategy = 'TXT_KEY_BUILDING_JFD_MUD_PYRAMID_MOSQUE_STRATEGY', Cost = 80, ReligiousPressureModifier = 50
WHERE Type = 'BUILDING_MUD_PYRAMID_MOSQUE';
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================	
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType,	Yield)
SELECT	'BUILDING_JFD_MEAD_HALL',	YieldType,	Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_CIRCUS';

INSERT INTO Building_YieldChanges
			(BuildingType, 							YieldType, 			Yield)
VALUES		('BUILDING_JFD_SONGHAI_SCIENCE', 		'YIELD_SCIENCE',	1);
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================	
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType,		Flavor)
SELECT	'BUILDING_JFD_MEAD_HALL',	FlavorType,		Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CIRCUS';
--==========================================================================================================================
-- Specialists
--==========================================================================================================================	
INSERT INTO Specialists
			(Type,								Description,								Strategy,											GreatPeopleTitle, 									Experience, Visible,	IconAtlas,			PortraitIndex)
VALUES		('SPECIALIST_JFD_DENMARK_GENERAL', 	'TXT_KEY_SPECIALIST_JFD_DENMARK_GENERAL',	'TXT_KEY_SPECIALIST_JFD_DENMARK_GENERAL_STRATEGY',	'TXT_KEY_SPECIALIST_JFD_DENMARK_GENERAL_TITLE', 	5,			1,			'CITIZEN_ATLAS',	0);
--==========================================================================================================================	
-- SpecialistFlavors
--==========================================================================================================================	
INSERT INTO SpecialistFlavors
			(SpecialistType,					FlavorType,					Flavor)
VALUES		('SPECIALIST_JFD_DENMARK_GENERAL',	'FLAVOR_MILITARY_TRAINING', 10),
			('SPECIALIST_JFD_DENMARK_GENERAL',	'FLAVOR_GROWTH', 			5),
			('SPECIALIST_JFD_DENMARK_GENERAL',	'FLAVOR_OFFENSE',			5),
			('SPECIALIST_JFD_DENMARK_GENERAL',	'FLAVOR_DEFENSE',			5);
--==========================================================================================================================	
-- Building_SpecialistYieldChanges
--==========================================================================================================================	
INSERT INTO SpecialistYields
			(SpecialistType,						YieldType,		Yield)
VALUES		('SPECIALIST_JFD_DENMARK_GENERAL',		'YIELD_FOOD',	2);

INSERT INTO Building_SpecialistYieldChanges
			(BuildingType,						SpecialistType,						YieldType,			Yield)
VALUES		('BUILDING_STATUE_OF_LIBERTY',		'SPECIALIST_JFD_DENMARK_GENERAL',	'YIELD_PRODUCTION',	1);
--==========================================================================================================================	
--==========================================================================================================================	