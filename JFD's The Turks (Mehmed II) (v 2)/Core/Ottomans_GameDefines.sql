--==========================================================================================================================	
-- UNITS
--==========================================================================================================================	
-- Units
------------------------------	
-- Sipahi
UPDATE Units
SET Help = 'TXT_KEY_UNIT_HELP_JFD_SIPAHI', Strategy = 'TXT_KEY_UNIT_OTTOMAN_JFD_SIPAHI_STRATEGY', Combat = 28, ObsoleteTech = 'TECH_STEAM_POWER', GoodyHutUpgradeUnitClass = 'UNITCLASS_AIRSHIP'
WHERE Type = 'UNIT_OTTOMAN_SIPAHI';
------------------------------	
-- Unit_FreePromotions
------------------------------	
UPDATE Unit_FreePromotions
SET PromotionType = 'PROMOTION_SMALL_CITY_PENALTY'
WHERE UnitType = 'UNIT_OTTOMAN_SIPAHI' AND PromotionType = 'PROMOTION_CITY_PENALTY';	
------------------------------	
-- Unit_ClassUpgrades
------------------------------	
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_AIRSHIP'
WHERE UnitType = 'UNIT_OTTOMAN_SIPAHI';	
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 					BuildingClass, Cost, Happiness,	FreshWater,	GreatPeopleRateModifier, FoodKept,	GoldMaintenance, PrereqTech,	Description, 					Civilopedia, 				Help, 								Strategy,								ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex,  IconAtlas)
SELECT	'BUILDING_JFD_HAMMAM',	BuildingClass, Cost, 2,			FreshWater,	GreatPeopleRateModifier, 10,		GoldMaintenance, PrereqTech,	'TXT_KEY_BUILDING_JFD_HAMMAM',	'TXT_KEY_JFD_HAMMAM_TEXT',	'TXT_KEY_BUILDING_JFD_HAMMAM_HELP', 'TXT_KEY_BUILDING_JFD_HAMMAM_STRATEGY',	ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, 3, 			  'JFD_TURKS_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_GARDEN';	
------------------------------	
-- Building_Flavors
------------------------------	
INSERT INTO Building_Flavors 
		(BuildingType, 				FlavorType,			Flavor)
VALUES	('BUILDING_JFD_HAMMAM',		'FLAVOR_GROWTH',	15),
		('BUILDING_JFD_HAMMAM',		'FLAVOR_GOLD',		10),
		('BUILDING_JFD_HAMMAM',		'FLAVOR_RELIGION',	10);

INSERT INTO Building_Flavors 	
		(BuildingType, 			FlavorType, Flavor)
SELECT	'BUILDING_JFD_HAMMAM',	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_GARDEN';
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--------------------------------	
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 			BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_OTTOMAN', 	'BUILDINGCLASS_GARDEN',		'BUILDING_JFD_HAMMAM');
--==========================================================================================================================
--==========================================================================================================================