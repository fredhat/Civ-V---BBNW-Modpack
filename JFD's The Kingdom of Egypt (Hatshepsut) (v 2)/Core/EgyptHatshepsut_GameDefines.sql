--==========================================================================================================================
-- BUILDING CLASSES
--==========================================================================================================================
-- BuildingClasses
--------------------------------
INSERT INTO BuildingClasses
		(Type,									DefaultBuilding)
VALUES	('BUILDINGCLASS_JFD_EGYPT_HATSHEPSUT',	'BUILDING_JFD_BURIAL_TOMB_HAPPINESS');
--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
-- Buildings
------------------------------	
INSERT INTO Buildings
		(Type, 									Cost, 	FaithCost, 	GreatWorkCount, Happiness,	BuildingClass, 							Description, 										Help, 												NukeImmune, NeverCapture)
VALUES	('BUILDING_JFD_BURIAL_TOMB_HAPPINESS',	-1,		-1,			-1,				2,			'BUILDINGCLASS_JFD_EGYPT_HATSHEPSUT',	'TXT_KEY_BUILDING_JFD_BURIAL_TOMB_HAPPINESS_DESC',	'TXT_KEY_BUILDING_JFD_BURIAL_TOMB_HAPPINESS_HELP', 	1,			1);

UPDATE Buildings
SET Cost = 40, Happiness = 0, PrereqTech = 'TECH_POTTERY', Help = 'TXT_KEY_BUILDING_JFD_BURIAL_TOMB_HELP', Strategy = 'TXT_KEY_BUILDING_JFD_BURIAL_TOMB_STRATEGY', BuildingClass = 'BUILDINGCLASS_SHRINE' 
WHERE Type = 'BUILDING_BURIAL_TOMB';
--------------------------------
-- Building_ClassesNeededInCity
--------------------------------
DELETE FROM Building_ClassesNeededInCity
WHERE BuildingType = 'BUILDING_BURIAL_TOMB';
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
INSERT INTO Units 	
		(Type, 						HurryCostModifier, Trade, Immobile, Moves,	NoMaintenance, Class,	PrereqTech,	Special, Combat, CombatLimit, WorkRate, CivilianAttackPriority, Cost, Moves, MoveRate, CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 								Strategy, 										Help, 										MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 						UnitFlagAtlas, 							UnitFlagIconOffset, PortraitIndex,	IconAtlas)
SELECT	'UNIT_JFD_MERCHANT_BARGE', 	HurryCostModifier, Trade, Immobile,	Moves,	NoMaintenance, Class,	PrereqTech, Special, Combat, CombatLimit, WorkRate, CivilianAttackPriority, Cost, Moves, MoveRate, CombatClass, Domain,	DefaultUnitAI, 'TXT_KEY_UNIT_JFD_MERCHANT_BARGE', 	'TXT_KEY_CIV5_JFD_MERCHANT_BARGE_TEXT',		'TXT_KEY_UNIT_JFD_MERCHANT_BARGE_STRATEGY', 	'TXT_KEY_UNIT_JFD_MERCHANT_BARGE_HELP',		MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, 'ART_DEF_UNIT_JFD_MERCHANT_BARGE', 	'JFD_MERCHANT_BARGE_FLAG_ART_ATLAS',	0,					2,				'JFD_EGYPT_HATSHEPSUT_ATLAS'
FROM Units WHERE Type = 'UNIT_CARGO_SHIP';
--------------------------------
-- UnitGameplay2DScripts
--------------------------------
INSERT INTO UnitGameplay2DScripts 	
		(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT	'UNIT_JFD_MERCHANT_BARGE', 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_CARGO_SHIP';	
--------------------------------
-- Unit_AITypes
--------------------------------
INSERT INTO Unit_AITypes 	
		(UnitType, 					UnitAIType)
SELECT	'UNIT_JFD_MERCHANT_BARGE', 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_CARGO_SHIP';
--------------------------------
-- Unit_Flavors
--------------------------------
INSERT INTO Unit_Flavors 	
		(UnitType, 					FlavorType, Flavor)
SELECT	'UNIT_JFD_MERCHANT_BARGE', 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_CARGO_SHIP';
--------------------------------
-- Unit_Flavors
--------------------------------
INSERT INTO Unit_FreePromotions 	
		(UnitType, 					PromotionType)
SELECT	'UNIT_JFD_MERCHANT_BARGE', 	PromotionType
FROM Unit_FreePromotions WHERE UnitType = 'UNIT_CARGO_SHIP';
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 						Description, 						Civilopedia, 							CivilopediaTag, 								ArtDefineTag, 						VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex)
VALUES	('LEADER_JFD_HATSHEPSUT', 	'TXT_KEY_LEADER_JFD_HATSHEPSUT',	'TXT_KEY_LEADER_JFD_HATSHEPSUT_PEDIA',	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_HATSHEPSUT', 	'Sukritact_Hatshepsut_Diplo.xml',	4, 						3, 						4, 							6, 			5, 				6, 				5, 						4, 				4, 			6, 			3, 				5, 			4, 			'JFD_EGYPT_HATSHEPSUT_ATLAS', 	1);
--------------------------------		
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_HATSHEPSUT', 	'MAJOR_CIV_APPROACH_WAR', 			3),
		('LEADER_JFD_HATSHEPSUT', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
		('LEADER_JFD_HATSHEPSUT', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
		('LEADER_JFD_HATSHEPSUT', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
		('LEADER_JFD_HATSHEPSUT', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
		('LEADER_JFD_HATSHEPSUT', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_HATSHEPSUT', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------							
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_HATSHEPSUT', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
		('LEADER_JFD_HATSHEPSUT', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
		('LEADER_JFD_HATSHEPSUT', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	2),
		('LEADER_JFD_HATSHEPSUT', 	'MINOR_CIV_APPROACH_CONQUEST', 		2),
		('LEADER_JFD_HATSHEPSUT', 	'MINOR_CIV_APPROACH_BULLY', 		4);
--------------------------------	
-- Leader_Flavors
--------------------------------							
INSERT INTO Leader_Flavors 
		(LeaderType, 				FlavorType, 						Flavor)
VALUES	('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_OFFENSE', 					5),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_DEFENSE', 					4),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_CITY_DEFENSE', 				5),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_MILITARY_TRAINING', 		5),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_RECON', 					6),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_RANGED', 					3),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_MOBILE', 					3),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_NAVAL', 					5),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_NAVAL_RECON', 				6),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_NAVAL_GROWTH', 				4),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	3),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_AIR', 						2),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_EXPANSION', 				5),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_GROWTH', 					8),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_TILE_IMPROVEMENT', 			3),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_INFRASTRUCTURE', 			3),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_PRODUCTION', 				4),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_GOLD', 						6),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_SCIENCE', 					3),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_CULTURE', 					4),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_HAPPINESS', 				6),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_GREAT_PEOPLE', 				5),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_WONDER', 					4),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_RELIGION', 					5),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_DIPLOMACY', 				2),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_SPACESHIP', 				2),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_WATER_CONNECTION', 			5),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_NUKE', 						3),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_ESPIONAGE', 				2),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_AIRLIFT', 					2),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_I_TRADE_DESTINATION', 		8),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_I_TRADE_ORIGIN', 			6),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		9),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		4),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_HATSHEPSUT', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
		(LeaderType, 				TraitType)
VALUES	('LEADER_JFD_HATSHEPSUT', 	'TRAIT_JFD_EGYPT_HATSHEPSUT');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 							Description, 							ShortDescription)
VALUES	('TRAIT_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_TRAIT_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_TRAIT_JFD_EGYPT_HATSHEPSUT_SHORT');
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 	
		(Type, 								  DerivativeCiv,		Description, ShortDescription, Adjective,									 Civilopedia, CivilopediaTag, DefaultPlayerColor,					ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas,						PortraitIndex,	AlphaIconAtlas,						SoundtrackTag,  MapImage, 								DawnOfManQuote, 							DawnOfManImage)
SELECT	'CIVILIZATION_JFD_EGYPT_HATSHEPSUT',  'CIVILIZATION_EGYPT',	Description, ShortDescription, 'TXT_KEY_CIV_JFD_EGYPT_HATSHEPSUT_ADJECTIVE', Civilopedia, CivilopediaTag, 'PLAYERCOLOR_JFD_EGYPT_HATSHEPSUT',	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, 'JFD_EGYPT_HATSHEPSUT_ATLAS',	0,				'JFD_EGYPT_HATSHEPSUT_ALPHA_ATLAS',	'Egypt', 		'Regalman_MapEgyptHatshepsut512.dds',	'TXT_KEY_CIV5_DAWN_EGYPT_HATSHEPSUT_TEXT',	'Sukritact_Hatshepsut_DOM.dds'
FROM Civilizations WHERE Type = 'CIVILIZATION_EGYPT';	
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames 
		(CivilizationType, 						CityName)
VALUES	('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_1'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_2'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_3'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_4'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_5'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_6'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_7'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_8'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_9'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_10'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_11'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_12'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_13'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_14'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_15'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_16'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_17'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_18'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_19'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_20'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_21'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_22'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_23'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_24'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_25'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_CITY_NAME_JFD_EGYPT_HATSHEPSUT_26');
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
		(CivilizationType, 						BuildingClassType)
SELECT	'CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_EGYPT';
--------------------------------		
-- Civilization_FreeTechs
--------------------------------			
INSERT INTO Civilization_FreeTechs 
		(CivilizationType, 						TechType)
SELECT	'CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_EGYPT';
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
		(CivilizationType, 						UnitClassType, Count, UnitAIType)
SELECT	'CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_EGYPT';
--------------------------------	
-- Civilization_Leaders
--------------------------------		
INSERT INTO Civilization_Leaders 
		(CivilizationType, 						LeaderheadType)
VALUES	('CIVILIZATION_JFD_EGYPT_HATSHEPSUT',	'LEADER_JFD_HATSHEPSUT');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
		(CivilizationType, 						BuildingClassType, 			BuildingType)
VALUES	('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'BUILDINGCLASS_SHRINE',		'BUILDING_BURIAL_TOMB');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
		(CivilizationType, 						UnitClassType, 				UnitType)
VALUES	('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'UNITCLASS_CARGO_SHIP',		'UNIT_JFD_MERCHANT_BARGE');
--------------------------------	
-- Civilization_Religions
--------------------------------			
INSERT INTO Civilization_Religions
		(CivilizationType, 						ReligionType)
SELECT	'CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	ReligionType
FROM Civilization_Religions WHERE CivilizationType = 'CIVILIZATION_EGYPT';
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 						SpyName)
VALUES	('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_SPY_NAME_CIVILIZATION_JFD_EGYPT_HATSHEPSUT_1'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_SPY_NAME_CIVILIZATION_JFD_EGYPT_HATSHEPSUT_2'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_SPY_NAME_CIVILIZATION_JFD_EGYPT_HATSHEPSUT_3'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_SPY_NAME_CIVILIZATION_JFD_EGYPT_HATSHEPSUT_4'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_SPY_NAME_CIVILIZATION_JFD_EGYPT_HATSHEPSUT_5'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_SPY_NAME_CIVILIZATION_JFD_EGYPT_HATSHEPSUT_6'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_SPY_NAME_CIVILIZATION_JFD_EGYPT_HATSHEPSUT_7'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_SPY_NAME_CIVILIZATION_JFD_EGYPT_HATSHEPSUT_8'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_SPY_NAME_CIVILIZATION_JFD_EGYPT_HATSHEPSUT_9'),
		('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	'TXT_KEY_SPY_NAME_CIVILIZATION_JFD_EGYPT_HATSHEPSUT_10');
--------------------------------	
-- Civilization_Start_Along_Ocean
--------------------------------			
INSERT INTO Civilization_Start_Along_Ocean
		(CivilizationType, 						StartAlongOcean)
VALUES	('CIVILIZATION_JFD_EGYPT_HATSHEPSUT', 	1);
--==========================================================================================================================
--==========================================================================================================================