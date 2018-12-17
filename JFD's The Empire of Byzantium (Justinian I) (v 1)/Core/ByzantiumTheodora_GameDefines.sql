--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
		(Type, 							Description, 							Help, 										Sound, 				MovesChange,	CannotBeChosen, PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_STOUDION', 		'TXT_KEY_PROMOTION_JFD_STOUDION',		'TXT_KEY_PROMOTION_JFD_STOUDION_HELP', 		'AS2D_IF_LEVELUP', 	1,				1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_STOUDION');
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------	
UPDATE Units
SET Help = 'TXT_KEY_JFD_DROMON_HELP', Strategy = 'TXT_KEY_JFD_DROMON_STRATEGY', ObsoleteTech='TECH_COMPASS', Combat = 10, RangedCombat = 12
WHERE Type = 'UNIT_BYZANTINE_DROMON';
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 						BuildingClass, Cost, GreatPeopleRateModifier, GoldMaintenance, PrereqTech,	Description, 						Civilopedia, 							Help, 									Strategy,								 	ArtDefineTag, 	MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT	'BUILDING_JFD_STOUDION',	BuildingClass, Cost, GreatPeopleRateModifier, GoldMaintenance, PrereqTech,	'TXT_KEY_BUILDING_JFD_STOUDION',	'TXT_KEY_BUILDING_JFD_STOUDION_TEXT',	'TXT_KEY_BUILDING_JFD_STOUDION_HELP', 	'TXT_KEY_BUILDING_JFD_STOUDION_STRATEGY',	ArtDefineTag,	MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, 3, 				'JFD_BYZANTIUM_JUSTINIAN_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_GARDEN';	
------------------------------	
-- Building_Flavors
------------------------------	
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType, Flavor)
SELECT	'BUILDING_JFD_STOUDION',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_GARDEN';

INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType,			Flavor)
VALUES	('BUILDING_JFD_STOUDION',	'FLAVOR_RELIGION',	20);
--------------------------------
-- Building_YieldChanges 
--------------------------------	
INSERT INTO Building_YieldChanges 
		(BuildingType, 				YieldType, 		Yield)
VALUES	('BUILDING_JFD_STOUDION', 	'YIELD_FAITH',	2);

INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType, Yield)
SELECT	'BUILDING_JFD_STOUDION',	YieldType, Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_GARDEN';
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 								BonusReligiousBelief,	Description, 								ShortDescription)
VALUES	('TRAIT_JFD_BYZANTIUM_THEODORA', 	1,						'TXT_KEY_TRAIT_JFD_BYZANTIUM_THEODORA', 	'TXT_KEY_TRAIT_JFD_BYZANTIUM_THEODORA_SHORT');
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leader_Traits
--------------------------------	
UPDATE Leader_Traits 
SET TraitType = 'TRAIT_JFD_BYZANTIUM_THEODORA'
WHERE LeaderType = 'LEADER_THEODORA';
--------------------------------
-- Leader_Flavors
--------------------------------	
UPDATE Leader_Flavors 
SET Flavor = 9
WHERE LeaderType = 'LEADER_THEODORA' AND FlavorType = 'FLAVOR_RELIGION';
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================
-- Civilization_BuildingClassOverrides 
--------------------------------	
DELETE FROM Civilization_BuildingClassOverrides WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_BYZANTIUM', 		'BUILDINGCLASS_GARDEN',		'BUILDING_JFD_STOUDION');	
--------------------------------
-- Civilization_UnitClassOverrides 
--------------------------------
DELETE FROM Civilization_UnitClassOverrides WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM' AND UnitType = 'UNIT_BYZANTINE_CATAPHRACT';
--==========================================================================================================================
--==========================================================================================================================