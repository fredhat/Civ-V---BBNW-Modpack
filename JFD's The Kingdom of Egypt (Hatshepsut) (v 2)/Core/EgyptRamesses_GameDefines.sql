--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 							River,	Cost,	FaithCost, GreatWorkCount,  UnlockedByBelief,	GoldMaintenance, PrereqTech,		FreeStartEra,	BuildingClass,	Description, 						Help, 									Civilopedia, 							  Strategy,								 	  ArtDefineTag, MinAreaSize, NeverCapture, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT	'BUILDING_JFD_NILOMETER',		River,	Cost,	FaithCost, GreatWorkCount,	UnlockedByBelief,	0,				 'TECH_CALENDAR',	FreeStartEra,	BuildingClass,	'TXT_KEY_BUILDING_JFD_NILOMETER',	'TXT_KEY_BUILDING_JFD_NILOMETER_HELP',	'TXT_KEY_CIV5_BUILDINGS_NILOMETER_TEXT',  'TXT_KEY_BUILDING_JFD_NILOMETER_STRATEGY',  ArtDefineTag,	MinAreaSize, NeverCapture, HurryCostModifier, 3, 				'JFD_EGYPT_HATSHEPSUT_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_WATERMILL';

INSERT INTO Buildings
		(Type, 							Cost, 	FaithCost, 	GreatWorkCount, UnlockedByBelief,	GoldMaintenance, PrereqTech,	FreeStartEra,	BuildingClass, 							Description, 								Help, 										NukeImmune,		NeverCapture)
VALUES	('BUILDING_JFD_EGYPT_RAMESSES',	-1,		-1,			-1,				0,					0,				 null,			null,			'BUILDINGCLASS_JFD_EGYPT_HATSHEPSUT',	'TXT_KEY_BUILDING_JFD_EGYPT_RAMESSES_DESC',	'TXT_KEY_BUILDING_JFD_EGYPT_RAMESSES_HELP', 1,				1);
------------------------------
-- Building_UnitCombatProductionModifiers
------------------------------	
INSERT INTO Building_UnitCombatProductionModifiers 	
		(BuildingType, 					UnitCombatType,					Modifier)
VALUES	('BUILDING_JFD_EGYPT_RAMESSES',	'UNITCOMBAT_ARCHER',			33),
		('BUILDING_JFD_EGYPT_RAMESSES',	'UNITCOMBAT_MOUNTED_RANGED',	33),
		('BUILDING_JFD_EGYPT_RAMESSES',	'UNITCOMBAT_SIEGE',				33);
------------------------------
-- Building_FeatureYieldChanges
------------------------------	
INSERT INTO Building_FeatureYieldChanges 	
		(BuildingType, 				FeatureType,			YieldType,		Yield)
VALUES	('BUILDING_JFD_NILOMETER',	'FEATURE_FLOOD_PLAINS',	'YIELD_GOLD',	1);
------------------------------
-- Building_YieldChanges
------------------------------	
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType,			Yield)
VALUES	('BUILDING_JFD_NILOMETER',	'YIELD_FOOD',		2),
		('BUILDING_JFD_NILOMETER',	'YIELD_PRODUCTION',	2);
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType,		Flavor)
SELECT	'BUILDING_JFD_NILOMETER',	FlavorType,		Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_WATERMILL';
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
UPDATE Units 
SET Help = 'TXT_KEY_UNIT_JFD_WAR_CHARIOT_HELP', Strategy = 'TXT_KEY_UNIT_JFD_WAR_CHARIOT_STRATEGY', Combat = 7, RangedCombat = 11, CombatClass = 'UNITCOMBAT_MOUNTED_RANGED'
WHERE Type = 'UNIT_EGYPTIAN_WARCHARIOT';
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
---- Leader_MajorCivApproachBiases
----------------------------------		
UPDATE Leader_MajorCivApproachBiases
SET Bias = 8
WHERE LeaderType = 'LEADER_RAMESSES' AND MajorCivApproachType = 'MAJOR_CIV_APPROACH_WAR';
----------------------------------	
---- Leader_MinorCivApproachBiases
----------------------------------							
UPDATE Leader_MinorCivApproachBiases
SET Bias = 8
WHERE LeaderType = 'LEADER_RAMESSES' AND MinorCivApproachType = 'MINOR_CIV_APPROACH_CONQUEST';
----------------------------------	
---- Leader_Flavors
----------------------------------							
UPDATE Leader_Flavors
SET Flavor = 7
WHERE LeaderType = 'LEADER_RAMESSES' AND FlavorType = 'FLAVOR_OFFENSE';

UPDATE Leader_Flavors
SET Flavor = 8
WHERE LeaderType = 'LEADER_RAMESSES' AND FlavorType = 'FLAVOR_RANGED';
----------------------------------	
-- Leader_Traits
--------------------------------	
UPDATE Leader_Traits 
SET TraitType = 'TRAIT_JFD_EGYPT_RAMESSES'
WHERE LeaderType = 'LEADER_RAMESSES';	
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 							Description, 							ShortDescription)
VALUES	('TRAIT_JFD_EGYPT_RAMESSES', 	'TXT_KEY_TRAIT_JFD_EGYPT_RAMESSES', 	'TXT_KEY_TRAIT_JFD_EGYPT_RAMESSES_SHORT');
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilization_CityNames 
--------------------------------	
DELETE FROM Civilization_CityNames WHERE CivilizationType = 'CIVILIZATION_EGYPT';
INSERT INTO Civilization_CityNames 
		(CivilizationType, 		CityName)
VALUES	('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_1'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_2'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_3'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_4'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_5'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_6'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_7'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_8'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_9'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_10'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_11'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_12'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_13'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_14'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_15'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_16'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_17'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_18'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_19'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_20'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_21'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_22'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_23'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_24'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_25'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_26'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_27'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_28'),
		('CIVILIZATION_EGYPT', 	'TXT_KEY_CITY_NAME_CIVILIZATION_EGYPT_RAMESSES_29');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
DELETE FROM Civilization_BuildingClassOverrides WHERE CivilizationType = 'CIVILIZATION_EGYPT';
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 		BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_EGYPT', 	'BUILDINGCLASS_WATERMILL',	'BUILDING_JFD_NILOMETER');
--------------------------------	
-- Civilization_Start_Along_River
--------------------------------		
INSERT INTO Civilization_Start_Along_River 
		(CivilizationType, 		StartAlongRiver)
VALUES	('CIVILIZATION_EGYPT', 	1);
--==========================================================================================================================
--==========================================================================================================================