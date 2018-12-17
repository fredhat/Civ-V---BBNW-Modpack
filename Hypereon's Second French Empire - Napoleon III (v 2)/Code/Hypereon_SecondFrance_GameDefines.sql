--=======================================================================================================================
-- BUILDINGCLASSES
--=======================================================================================================================	
-- BuildingClasses
------------------------------	
INSERT OR REPLACE INTO BuildingClasses 
			(DefaultBuilding, 							Type, 											Description)
VALUES		('BUILDING_HYPEREON_SECONDFRANCE_TRAIT', 	'BUILDINGCLASS_HYPEREON_SECONDFRANCE_TRAIT', 	'TXT_KEY_BUILDING_HYPEREON_SECONDFRANCE_TRAIT'),
			('BUILDING_HYPEREON_GRANDE_ECOLE_BASE', 	'BUILDINGCLASS_HYPEREON_GRANDE_ECOLE_BASE', 	'TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_BASE'),
			('BUILDING_HYPEREON_GRANDE_ECOLE_SCIENCE', 	'BUILDINGCLASS_HYPEREON_GRANDE_ECOLE_SCIENCE', 	'TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_SCIENCE'),
			('BUILDING_HYPEREON_GRANDE_ECOLE_MILITARY', 'BUILDINGCLASS_HYPEREON_GRANDE_ECOLE_MILITARY', 'TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_MILITARY'),
			('BUILDING_HYPEREON_GRANDE_ECOLE_ECONOMY', 	'BUILDINGCLASS_HYPEREON_GRANDE_ECOLE_ECONOMY', 	'TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_ECONOMY');
--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================
-- Buildings
------------------------------	
INSERT OR REPLACE INTO Buildings 
			(Type, 										BuildingClass, 									GreatWorkCount, Cost, 	FaithCost,	GoldMaintenance,	WorkerSpeedModifier,	CultureRateModifier,	PrereqTech, NeverCapture,	NukeImmune,	Description, 									Help)
VALUES		('BUILDING_HYPEREON_SECONDFRANCE_TRAIT', 	'BUILDINGCLASS_HYPEREON_SECONDFRANCE_TRAIT',	-1,				-1, 	-1,			0,					50,						20,						NULL, 		1,				1,			'TXT_KEY_BUILDING_HYPEREON_SECONDFRANCE_TRAIT',	'TXT_KEY_BUILDING_HYPEREON_SECONDFRANCE_TRAIT_HELP');

INSERT OR REPLACE INTO Buildings 
			(Type, 										BuildingClass, 									GreatWorkCount, Cost, 	FaithCost,	GoldMaintenance,	PrereqTech, NeverCapture,	NukeImmune,	Description, 								Civilopedia,								Help,											Strategy,												PortraitIndex,	IconAtlas)
VALUES		('BUILDING_HYPEREON_GRANDE_ECOLE_BASE', 	'BUILDINGCLASS_HYPEREON_GRANDE_ECOLE_BASE',		-1,				-1, 	-1,			0,					NULL, 		1,				1,			'TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE',	'TXT_KEY_CIV5_HYPEREON_GRANDE_ECOLE_TEXT',	'TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_HELP',	'TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_STRATEGY',		2, 				'HYPEREON_SECONDFRANCE_ATLAS');

INSERT INTO Buildings 	
			(Type, 										Defense,	CapturePlunderModifier, BuildingClass, 	Cost,	FaithCost,	UnlockedByBelief, SpecialistType, 	SpecialistCount,  	GoldMaintenance, 	PrereqTech,	Description, 								Civilopedia, 									Help, 												Strategy,								 				ArtDefineTag, 	MinAreaSize, NeverCapture, 	NukeImmune,	Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_HYPEREON_GRANDE_ECOLE'),			Defense,	CapturePlunderModifier,	BuildingClass, 	Cost,	150,		UnlockedByBelief, SpecialistType, 	SpecialistCount,	GoldMaintenance, 	PrereqTech,	('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE'),	('TXT_KEY_CIV5_HYPEREON_GRANDE_ECOLE_TEXT'), 	('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_HELP'), 	('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_STRATEGY'),	ArtDefineTag,	MinAreaSize, 1, 			1,			Espionage, EspionageModifier, HurryCostModifier, 2, 				('HYPEREON_SECONDFRANCE_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_PUBLIC_SCHOOL');

INSERT INTO Buildings 	
			(Type, 										Defense,	CapturePlunderModifier, BuildingClass, 										Cost,	FaithCost,		UnlockedByBelief, 	MutuallyExclusiveGroup, SpecialistType, 			SpecialistCount,  	GoldMaintenance, 	PrereqTech,	GreatPeopleRateModifier, 	Description, 											Civilopedia, 											Help, 														Strategy,								 						ArtDefineTag, 	MinAreaSize, NeverCapture, 	NukeImmune,	Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, 	IconAtlas,							ShowInPedia)
SELECT		('BUILDING_HYPEREON_GRANDE_ECOLE_SCIENCE'),	Defense,	CapturePlunderModifier,	('BUILDINGCLASS_HYPEREON_GRANDE_ECOLE_SCIENCE'), 	Cost/2,	75,				UnlockedByBelief, 	75, 					('SPECIALIST_SCIENTIST'), 	1,  				0, 					NULL,		15,							('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_SCIENCE'),		('TXT_KEY_CIV5_HYPEREON_GRANDE_ECOLE_SCIENCE_TEXT'), 	('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_SCIENCE_HELP'), 	('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_SCIENCE_STRATEGY'),	ArtDefineTag,	MinAreaSize, 1, 			1,			Espionage, EspionageModifier, HurryCostModifier, 2, 				('HYPEREON_SECONDFRANCE_ATLAS'),	0
FROM Buildings WHERE (Type = 'BUILDING_PUBLIC_SCHOOL');	

INSERT INTO Buildings 	
			(Type, 										Defense,	CapturePlunderModifier, BuildingClass, 										Cost,	FaithCost,		UnlockedByBelief, 	MutuallyExclusiveGroup, SpecialistType, 			SpecialistCount,  	GoldMaintenance, 	PrereqTech,								Description, 											Civilopedia, 											Help, 														Strategy,								 						ArtDefineTag, 	MinAreaSize, NeverCapture, 	NukeImmune,	Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, 	IconAtlas,							ShowInPedia)
SELECT		('BUILDING_HYPEREON_GRANDE_ECOLE_MILITARY'),Defense,	CapturePlunderModifier,	('BUILDINGCLASS_HYPEREON_GRANDE_ECOLE_MILITARY'), 	Cost/2,	75,				UnlockedByBelief, 	75, 					('SPECIALIST_ENGINEER'), 	1,  				0, 					NULL,									('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_MILITARY'),	('TXT_KEY_CIV5_HYPEREON_GRANDE_ECOLE_MILITARY_TEXT'), 	('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_MILITARY_HELP'), 	('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_MILITARY_STRATEGY'),	ArtDefineTag,	MinAreaSize, 1, 			1,			Espionage, EspionageModifier, HurryCostModifier, 2, 				('HYPEREON_SECONDFRANCE_ATLAS'),	0
FROM Buildings WHERE (Type = 'BUILDING_PUBLIC_SCHOOL');	

INSERT INTO Buildings 	
			(Type, 										Defense,	CapturePlunderModifier, BuildingClass, 										Cost,	FaithCost,		UnlockedByBelief, 	MutuallyExclusiveGroup, SpecialistType, 			SpecialistCount,  	GoldMaintenance, 	PrereqTech,	BuildingProductionModifier,	Description, 											Civilopedia, 											Help, 														Strategy,								 						ArtDefineTag, 	MinAreaSize, NeverCapture, 	NukeImmune,	Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, 	IconAtlas,							ShowInPedia)
SELECT		('BUILDING_HYPEREON_GRANDE_ECOLE_ECONOMY'),	Defense,	CapturePlunderModifier,	('BUILDINGCLASS_HYPEREON_GRANDE_ECOLE_ECONOMY'), 	Cost/2,	75,				UnlockedByBelief, 	75, 					('SPECIALIST_MERCHANT'), 	1,  				0, 					NULL,		15,							('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_ECONOMY'),		('TXT_KEY_CIV5_HYPEREON_GRANDE_ECOLE_ECONOMY_TEXT'), 	('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_ECONOMY_HELP'), 	('TXT_KEY_BUILDING_HYPEREON_GRANDE_ECOLE_ECONOMY_STRATEGY'),	ArtDefineTag,	MinAreaSize, 1, 			1,			Espionage, EspionageModifier, HurryCostModifier, 2, 				('HYPEREON_SECONDFRANCE_ATLAS'),	0
FROM Buildings WHERE (Type = 'BUILDING_PUBLIC_SCHOOL');	
------------------------------	
-- Building_DomainFreeExperiences
------------------------------		
INSERT INTO Building_DomainFreeExperiences 	
			(BuildingType, 									DomainType, Experience)
SELECT		('BUILDING_HYPEREON_GRANDE_ECOLE_MILITARY'),	DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_BARRACKS');
------------------------------
-- Building_Flavors
------------------------------	
INSERT INTO Building_Flavors 	
			(BuildingType, 						FlavorType, Flavor)
SELECT		('BUILDING_HYPEREON_GRANDE_ECOLE'),	FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');

INSERT INTO Building_Flavors 	
			(BuildingType, 								FlavorType,					Flavor)
VALUES		('BUILDING_HYPEREON_GRANDE_ECOLE_SCIENCE',	'FLAVOR_GREAT_PEOPLE',		20),
			('BUILDING_HYPEREON_GRANDE_ECOLE_SCIENCE',	'FLAVOR_SCIENCE',			20),
			('BUILDING_HYPEREON_GRANDE_ECOLE_MILITARY',	'FLAVOR_PRODUCTION',		20),
			('BUILDING_HYPEREON_GRANDE_ECOLE_MILITARY',	'FLAVOR_MILITARY_TRAINING',	20),
			('BUILDING_HYPEREON_GRANDE_ECOLE_ECONOMY',	'FLAVOR_GOLD',				20),
			('BUILDING_HYPEREON_GRANDE_ECOLE_ECONOMY',	'FLAVOR_PRODUCTION',		20);
------------------------------	
-- Building_ClassesNeededInCity
------------------------------	
INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 								BuildingClassType)
VALUES		('BUILDING_HYPEREON_GRANDE_ECOLE',			'BUILDINGCLASS_UNIVERSITY'),
			('BUILDING_HYPEREON_GRANDE_ECOLE_SCIENCE',	'BUILDINGCLASS_HYPEREON_GRANDE_ECOLE_BASE'),
			('BUILDING_HYPEREON_GRANDE_ECOLE_MILITARY',	'BUILDINGCLASS_HYPEREON_GRANDE_ECOLE_BASE'),
			('BUILDING_HYPEREON_GRANDE_ECOLE_ECONOMY',	'BUILDINGCLASS_HYPEREON_GRANDE_ECOLE_BASE');
------------------------------	
-- Building_YieldModifiers
------------------------------	
INSERT INTO Building_YieldModifiers 	
			(BuildingType, 								YieldType, 			Yield)
VALUES		('BUILDING_HYPEREON_SECONDFRANCE_TRAIT',	'YIELD_PRODUCTION', 20);
------------------------------	
-- Building_YieldChanges
------------------------------	
INSERT INTO Building_YieldChanges 	
			(BuildingType, 						YieldType, Yield)
SELECT		('BUILDING_HYPEREON_GRANDE_ECOLE'),	YieldType, Yield
FROM Building_YieldChanges WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');
------------------------------	
-- Building_YieldChangesPerPop
------------------------------	
INSERT INTO Building_YieldChangesPerPop 	
			(BuildingType, 						YieldType, Yield)
SELECT		('BUILDING_HYPEREON_GRANDE_ECOLE'),	YieldType, Yield
FROM Building_YieldChangesPerPop WHERE (BuildingType = 'BUILDING_PUBLIC_SCHOOL');
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
			(Type, 								Description, 								Civilopedia, 									CivilopediaTag, 										ArtDefineTag, 				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex)
VALUES		('LEADER_HYPEREON_NAPOLEONIII', 	'TXT_KEY_LEADER_HYPEREON_NAPOLEONIII', 		'TXT_KEY_LEADER_HYPEREON_NAPOLEONIII_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_HYPEREON_NAPOLEONIII', 	'NapoleonIII_Scene.xml',	6, 						7, 						5, 							8, 			6, 				3, 				6, 						6, 				3, 			4, 			4, 				8, 			7, 			'HYPEREON_SECONDFRANCE_ATLAS', 	1);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 						MajorCivApproachType, 				Bias)
VALUES		('LEADER_HYPEREON_NAPOLEONIII', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_HYPEREON_NAPOLEONIII', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
			('LEADER_HYPEREON_NAPOLEONIII', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
			('LEADER_HYPEREON_NAPOLEONIII', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'MAJOR_CIV_APPROACH_AFRAID', 		6),
			('LEADER_HYPEREON_NAPOLEONIII', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		7),
			('LEADER_HYPEREON_NAPOLEONIII', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--------------------------------	
-- Leader_MinorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 						MinorCivApproachType, 				Bias)
VALUES		('LEADER_HYPEREON_NAPOLEONIII', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_HYPEREON_NAPOLEONIII', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_HYPEREON_NAPOLEONIII', 	'MINOR_CIV_APPROACH_CONQUEST', 		7),
			('LEADER_HYPEREON_NAPOLEONIII', 	'MINOR_CIV_APPROACH_BULLY', 		6);
--------------------------------	
-- Leader_Flavors
--------------------------------						
INSERT INTO Leader_Flavors 
			(LeaderType, 						FlavorType, 						Flavor)
VALUES		('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_OFFENSE', 					8),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_DEFENSE', 					4),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_MILITARY_TRAINING', 		7),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_RECON', 					4),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_RANGED', 					6),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_MOBILE', 					3),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_NAVAL', 					5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_NAVAL_RECON', 				5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_AIR', 						6),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_GROWTH', 					5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_INFRASTRUCTURE', 			8),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_GOLD', 						8),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_SCIENCE', 					5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_CULTURE', 					9),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_GREAT_PEOPLE', 				5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_WONDER', 					7),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_RELIGION', 					3),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_SPACESHIP', 				3),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_WATER_CONNECTION', 			5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_NUKE', 						7),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_USE_NUKE', 					6),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_ESPIONAGE', 				7),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_AIRLIFT', 					3),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_ARCHAEOLOGY', 				8),
			('LEADER_HYPEREON_NAPOLEONIII', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------	
INSERT INTO Leader_Traits 
			(LeaderType, 						TraitType)
VALUES		('LEADER_HYPEREON_NAPOLEONIII', 	'TRAIT_HYPEREON_SECONDFRANCE');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
			(Type, 								Description, 							ShortDescription)
VALUES		('TRAIT_HYPEREON_SECONDFRANCE', 	'TXT_KEY_TRAIT_HYPEREON_SECONDFRANCE', 	'TXT_KEY_TRAIT_HYPEREON_SECONDFRANCE_SHORT');	
--==========================================================================================================================	
-- PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
------------------------------
INSERT INTO UnitPromotions 
			(Type, 										Description, 									Help, 												Sound, 				CannotBeChosen, FriendlyLandsAttackModifier, 	PortraitIndex,  IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_HYPEREON_COLONIAL_DRAFT',		'TXT_KEY_PROMOTION_HYPEREON_COLONIAL_DRAFT',	'TXT_KEY_PROMOTION_HYPEREON_COLONIAL_DRAFT_HELP',	'AS2D_IF_LEVELUP', 	1,				0, 								59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_HYPEREON_COLONIAL_DRAFT'),
			('PROMOTION_HYPEREON_COLONIAL_ARMY',		'TXT_KEY_PROMOTION_HYPEREON_COLONIAL_ARMY',		'TXT_KEY_PROMOTION_HYPEREON_COLONIAL_ARMY_HELP',	'AS2D_IF_LEVELUP', 	1,				20, 							59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_HYPEREON_COLONIAL_ARMY');
--==========================================================================================================================	
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------	
INSERT INTO Units 	
			(Class,					Type, 						PrereqTech,	Range, RangedCombat, Combat,	FaithCost,		RequiresFaithPurchaseEnabled, 	Cost,		Moves, 		CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 							Strategy, 									Help, 									MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 						UnitFlagAtlas, 							UnitFlagIconOffset, PortraitIndex,	IconAtlas)
SELECT		('UNITCLASS_RIFLEMAN'),	('UNIT_HYPEREON_ZOUAVE'), 	PrereqTech,	Range, RangedCombat, Combat-4,	FaithCost-100,	RequiresFaithPurchaseEnabled, 	Cost-50,	Moves+1, 	CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_HYPEREON_ZOUAVE'), 	('TXT_KEY_CIV5_HYPEREON_ZOUAVE_TEXT'),	('TXT_KEY_UNIT_HYPEREON_ZOUAVE_STRATEGY'), ('TXT_KEY_UNIT_HYPEREON_ZOUAVE_HELP'),	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, ('ART_DEF_UNIT_HYPEREON_ZOUAVE'), 	('HYPEREON_UNIT_FLAG_ZOUAVE_ATLAS'),	0,					3, 				('HYPEREON_SECONDFRANCE_ATLAS')
FROM Units WHERE (Type = 'UNIT_RIFLEMAN');
--------------------------------
-- UnitGameplay2DScripts
--------------------------------	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_HYPEREON_ZOUAVE'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_RIFLEMAN');
--------------------------------
-- Unit_AITypes
--------------------------------	
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_HYPEREON_ZOUAVE'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_RIFLEMAN');
--------------------------------
-- Unit_Flavors
--------------------------------	
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_HYPEREON_ZOUAVE'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_RIFLEMAN');
--------------------------------
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 
			(UnitType, 					PromotionType)
VALUES		('UNIT_HYPEREON_ZOUAVE', 	'PROMOTION_HYPEREON_COLONIAL_DRAFT'),
			('UNIT_HYPEREON_ZOUAVE', 	'PROMOTION_HYPEREON_COLONIAL_ARMY');
--------------------------------
-- Unit_ClassUpgrades
--------------------------------	
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_HYPEREON_ZOUAVE'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_RIFLEMAN');
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
INSERT INTO Civilizations 		
			(Type, 										Description,									ShortDescription, 									Adjective, 											Civilopedia,		CivilopediaTag,			DefaultPlayerColor,						ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 							PortraitIndex, 	AlphaIconAtlas, 						SoundtrackTag, 		MapImage, 					DawnOfManQuote, 							DawnOfManImage)
SELECT		('CIVILIZATION_HYPEREON_SECONDFRANCE'), 	('TXT_KEY_CIV_HYPEREON_SECONDFRANCE_DESC'), 	('TXT_KEY_CIV_HYPEREON_SECONDFRANCE_SHORT_DESC'),	('TXT_KEY_CIV_HYPEREON_SECONDFRANCE_ADJECTIVE'),	Civilopedia,		CivilopediaTag, 	 	('PLAYERCOLOR_HYPEREON_SECONDFRANCE'),	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('HYPEREON_SECONDFRANCE_ATLAS'), 	0, 				('HYPEREON_SECONDFRANCE_ALPHA_ATLAS'), 	('France'), 		('MapNapoleonIII512.dds'),	('TXT_KEY_CIV5_DAWN_SECONDFRANCE_TEXT'),	('NapoleonIII_DOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_FRANCE');
--------------------------------	
-- Civilization_CityNames
--------------------------------	
INSERT INTO Civilization_CityNames 
			(CivilizationType, 						CityName)
VALUES		('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_01'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_02'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_03'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_04'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_05'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_06'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_07'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_08'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_09'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_10'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_11'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_12'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_13'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_14'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_15'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_16'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_17'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_18'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_19'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_20'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_21'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_22'),	
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_23'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_24'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_25'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_26'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_27'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_28'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_29'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_30'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_31'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_32'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_33'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_34'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_35'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_36'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_37'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_38'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_39'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_40'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_41'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_42'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_43'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_CITY_NAME_HYPEREON_SECONDFRANCE_44');			
--------------------------------	
-- Civilization_FreeBuildingClasses
--------------------------------			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 							BuildingClassType)
SELECT		('CIVILIZATION_HYPEREON_SECONDFRANCE'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_FRANCE');
--------------------------------	
-- Civilization_FreeTechs
--------------------------------		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 							TechType)
SELECT		('CIVILIZATION_HYPEREON_SECONDFRANCE'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_FRANCE');
--------------------------------	
-- Civilization_FreeUnits
--------------------------------		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 							UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_HYPEREON_SECONDFRANCE'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_FRANCE');
--------------------------------	
-- Civilization_Leaders
--------------------------------		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 						LeaderheadType)
VALUES		('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'LEADER_HYPEREON_NAPOLEONIII');
--------------------------------	
-- Civilization_BuildingClassOverrides 
--------------------------------		
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 						BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'BUILDINGCLASS_PUBLIC_SCHOOL',		'BUILDING_HYPEREON_GRANDE_ECOLE');
--------------------------------	
-- Civilization_UnitClassOverrides 
--------------------------------		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 						UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'UNITCLASS_RIFLEMAN',	'UNIT_HYPEREON_ZOUAVE');
--------------------------------	
-- Civilization_Religions
--------------------------------		
INSERT INTO Civilization_Religions 
			(CivilizationType, 						ReligionType)
VALUES		('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'RELIGION_CHRISTIANITY');
--------------------------------	
-- Civilization_Start_Region_Priority
--------------------------------		
INSERT INTO Civilization_Start_Region_Priority 
			(CivilizationType, 						RegionType)
VALUES		('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'REGION_GRASS');
--------------------------------	
-- Civilization_SpyNames
--------------------------------	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
VALUES		('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_SPY_NAME_HYPEREON_SECONDFRANCE_0'),	
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_SPY_NAME_HYPEREON_SECONDFRANCE_1'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_SPY_NAME_HYPEREON_SECONDFRANCE_2'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_SPY_NAME_HYPEREON_SECONDFRANCE_3'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_SPY_NAME_HYPEREON_SECONDFRANCE_4'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_SPY_NAME_HYPEREON_SECONDFRANCE_5'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_SPY_NAME_HYPEREON_SECONDFRANCE_6'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_SPY_NAME_HYPEREON_SECONDFRANCE_7'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_SPY_NAME_HYPEREON_SECONDFRANCE_8'),
			('CIVILIZATION_HYPEREON_SECONDFRANCE', 	'TXT_KEY_SPY_NAME_HYPEREON_SECONDFRANCE_9');
--==========================================================================================================================
--==========================================================================================================================