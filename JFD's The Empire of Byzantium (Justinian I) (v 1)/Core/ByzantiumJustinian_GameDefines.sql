--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
		(Type, 						BuildingClass,	Cost, Happiness, GoldMaintenance, PrereqTech,	Description, 						Help, 									Civilopedia, 							Strategy,								 	ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, IconAtlas)
SELECT	'BUILDING_JFD_HIPPODROME',	BuildingClass,	Cost, Happiness, GoldMaintenance, PrereqTech,	'TXT_KEY_BUILDING_JFD_HIPPODROME',	'TXT_KEY_BUILDING_JFD_HIPPODROME_HELP',	'TXT_KEY_BUILDING_JFD_HIPPODROME_TEXT',	'TXT_KEY_BUILDING_JFD_HIPPODROME_STRATEGY',	ArtDefineTag, MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, 2, 			 'JFD_BYZANTIUM_JUSTINIAN_ATLAS'
FROM Buildings WHERE Type = 'BUILDING_CIRCUS';	
------------------------------	
-- Building_DomainFreeExperiences
------------------------------	
INSERT INTO Building_DomainFreeExperiences 	
		(BuildingType, 				DomainType,			Experience)
VALUES	('BUILDING_JFD_HIPPODROME',	'DOMAIN_LAND',		15);
------------------------------	
-- Building_ResourceQuantityRequirements
------------------------------	
INSERT INTO Building_ResourceQuantityRequirements 	
		(BuildingType, 				ResourceType,		Cost)
VALUES	('BUILDING_JFD_HIPPODROME',	'RESOURCE_HORSE',	1);
------------------------------	
-- Building_Flavors
------------------------------	
INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType,		Flavor)
SELECT	'BUILDING_JFD_HIPPODROME',	FlavorType,		Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_CIRCUS';

INSERT INTO Building_Flavors 	
		(BuildingType, 				FlavorType,						Flavor)
VALUES	('BUILDING_JFD_HIPPODROME',	'FLAVOR_MILITARY_TRAINING',		20),
		('BUILDING_JFD_HIPPODROME',	'FLAVOR_GOLD',					15);
--------------------------------
-- Building_YieldChanges 
--------------------------------	
INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType,		Yield)
SELECT	'BUILDING_JFD_HIPPODROME',	YieldType,		Yield
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_CIRCUS';

INSERT INTO Building_YieldChanges 	
		(BuildingType, 				YieldType,		Yield)
VALUES	('BUILDING_JFD_HIPPODROME',	'YIELD_CULTURE',2);
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------	
--Cataphract
UPDATE Units
SET Class = 'UNITCLASS_KNIGHT', PrereqTech = 'TECH_CHIVALRY', Moves = 3, Combat = 25, Cost = 120, FaithCost = 240, ObsoleteTech = 'TECH_MILITARY_SCIENCE', GoodyHutUpgradeUnitClass = 'UNITCLASS_CAVALRY', Help = 'TXT_KEY_JFD_CATAPHRACT_HELP', Strategy = 'TXT_KEY_JFD_CATAPHRACT_STRATEGY'
WHERE Type = 'UNIT_BYZANTINE_CATAPHRACT';
--------------------------------	
-- Unit_ClassUpgrades
--------------------------------	
DELETE FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_BYZANTINE_CATAPHRACT';
INSERT INTO Unit_ClassUpgrades 	
		(UnitType, 						UnitClassType)
SELECT	'UNIT_BYZANTINE_CATAPHRACT',	UnitClassType
FROM Unit_ClassUpgrades WHERE UnitType = 'UNIT_KNIGHT';
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders		
		(Type, 								Description, 						CivilopediaTag, 								ArtDefineTag, 						VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 							PortraitIndex)
VALUES	('LEADER_JFD_JUSTINIAN', 			'TXT_KEY_LEADER_JFD_JUSTINIAN',		'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_JUSTINIAN', 	'Janboruta_Justinian_Scene.xml',	9, 						3, 						2, 							7, 			6, 				5, 				5, 						5, 				5, 			6, 			4, 				3, 			4, 			'JFD_BYZANTIUM_JUSTINIAN_ATLAS', 	1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 						MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_JUSTINIAN', 			'MAJOR_CIV_APPROACH_WAR', 			7),
		('LEADER_JFD_JUSTINIAN', 			'MAJOR_CIV_APPROACH_HOSTILE', 		4),
		('LEADER_JFD_JUSTINIAN', 			'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
		('LEADER_JFD_JUSTINIAN', 			'MAJOR_CIV_APPROACH_GUARDED', 		7),
		('LEADER_JFD_JUSTINIAN', 			'MAJOR_CIV_APPROACH_AFRAID', 		3),
		('LEADER_JFD_JUSTINIAN', 			'MAJOR_CIV_APPROACH_FRIENDLY', 		3),
		('LEADER_JFD_JUSTINIAN', 			'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--------------------------------	
-- Leader_MinorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 						MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_JUSTINIAN', 			'MINOR_CIV_APPROACH_IGNORE', 		5),
		('LEADER_JFD_JUSTINIAN', 			'MINOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_JFD_JUSTINIAN', 			'MINOR_CIV_APPROACH_PROTECTIVE', 	3),
		('LEADER_JFD_JUSTINIAN', 			'MINOR_CIV_APPROACH_CONQUEST', 		7),
		('LEADER_JFD_JUSTINIAN', 			'MINOR_CIV_APPROACH_BULLY', 		3);
--------------------------------			
-- Leader_Flavors
--------------------------------									
INSERT INTO Leader_Flavors 
		(LeaderType, 						FlavorType, 						Flavor)
VALUES	('LEADER_JFD_JUSTINIAN', 			'FLAVOR_OFFENSE', 					7),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_DEFENSE', 					7),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_CITY_DEFENSE', 				6),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_MILITARY_TRAINING', 		8),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_RECON', 					5),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_RANGED', 					5),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_MOBILE', 					7),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_NAVAL', 					5),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_NAVAL_RECON', 				4),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_NAVAL_GROWTH', 				4),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_AIR', 						4),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_EXPANSION', 				8),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_GROWTH', 					6),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_TILE_IMPROVEMENT', 			5),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_INFRASTRUCTURE', 			8),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_PRODUCTION', 				7),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_GOLD', 						5),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_SCIENCE', 					4),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_CULTURE', 					4),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_HAPPINESS', 				6),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_GREAT_PEOPLE', 				4),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_WONDER', 					4),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_RELIGION', 					6),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_DIPLOMACY', 				4),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_SPACESHIP', 				2),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_WATER_CONNECTION', 			3),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_NUKE', 						2),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_ESPIONAGE', 				3),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_AIRLIFT', 					2),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_JUSTINIAN', 			'FLAVOR_AIR_CARRIER', 				5);
--------------------------------			
-- Leader_Traits
--------------------------------			
INSERT INTO Leader_Traits 
		(LeaderType, 						TraitType)
VALUES	('LEADER_JFD_JUSTINIAN', 			'TRAIT_JFD_BYZANTIUM_JUSTINIAN');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 								Description, 								ShortDescription)
VALUES	('TRAIT_JFD_BYZANTIUM_JUSTINIAN',	'TXT_KEY_TRAIT_JFD_BYZANTIUM_JUSTINIAN', 	'TXT_KEY_TRAIT_JFD_BYZANTIUM_JUSTINIAN_SHORT');	
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
		(Type, 										DerivativeCiv,			  Description,								  ShortDescription, 								Adjective, 										 CivilopediaTag, DefaultPlayerColor,					ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 						 PortraitIndex,  AlphaIconAtlas, 						 SoundtrackTag, MapImage, 								 DawnOfManQuote,									DawnOfManImage)
SELECT	'CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',		'CIVILIZATION_BYZANTIUM', 'TXT_KEY_CIV_JFD_BYZANTIUM_JUSTINIAN_DESC', 'TXT_KEY_CIV_JFD_BYZANTIUM_JUSTINIAN_SHORT_DESC',	'TXT_KEY_CIV_JFD_BYZANTIUM_JUSTINIAN_ADJECTIVE', CivilopediaTag, 'PLAYERCOLOR_JFD_BYZANTIUM_JUSTINIAN', ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_BYZANTIUM_JUSTINIAN_ATLAS', 0, 			 'JFD_BYZANTIUM_JUSTINIAN_ALPHA_ATLAS',  'Byzantium', 	'Regalman_MapByzantiumJustinian512.dds', 'TXT_KEY_CIV5_DAWN_JFD_BYZANTIUM_JUSTINIAN_TEXT',	'Janboruta_ByzantiumJustinian_DOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_BYZANTIUM';
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames
		(CivilizationType,                         CityName)
VALUES	('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_1'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_2'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_3'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_4'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_5'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_6'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_7'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_8'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_9'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_10'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_11'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_12'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_13'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_14'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_15'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_16'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_17'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_18'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_19'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_20'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_21'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_22'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_23'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_24'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_25'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_26'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_27'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_28'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_29'),
		('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',   'TXT_KEY_CITY_NAME_JFD_BYZANTIUM_JUSTINIAN_30');
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 							BuildingClassType)
SELECT	'CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 							TechType)
SELECT	'CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',		TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 							UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--------------------------------	
-- Civilization_Leaders
--------------------------------	
INSERT INTO Civilization_Leaders 
		(CivilizationType, 							LeaderheadType)
VALUES	('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN',	'LEADER_JFD_JUSTINIAN');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------	
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 							BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN', 	'BUILDINGCLASS_CIRCUS',		'BUILDING_JFD_HIPPODROME');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------	
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 							UnitClassType, 				UnitType)
VALUES	('CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN', 	'UNITCLASS_KNIGHT',			'UNIT_BYZANTINE_CATAPHRACT');
--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions 
		(CivilizationType, 							ReligionType)
SELECT	'CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN', 	ReligionType
FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 							SpyName)
SELECT	'CIVILIZATION_JFD_BYZANTIUM_JUSTINIAN', 	SpyName
FROM Civilization_SpyNames WHERE CivilizationType = 'CIVILIZATION_BYZANTIUM';
--==========================================================================================================================
--==========================================================================================================================