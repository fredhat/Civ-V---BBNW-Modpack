--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
-- New BuildingClasses
INSERT INTO BuildingClasses 	
			(Type, 						 		 		DefaultBuilding, 					Description)
VALUES		('BUILDINGCLASS_F0S_AGORA_BONUS',			'BUILDING_F0S_AGORA_BONUS_FOOD',	'TXT_KEY_BUILDING_F0S_AGORA_BONUS'),
			('BUILDINGCLASS_F0S_CELT_FAITH',			'BUILDING_F0S_CELT_FAITH',			'TXT_KEY_BUILDING_F0S_CELT_FAITH'),
			('BUILDINGCLASS_F0S_MONGOLIAN_GOLD',		'BUILDING_F0S_MONGOLIAN_GOLD',		'TXT_KEY_BUILDING_F0S_MONGOLIAN_GOLD'),
			('BUILDINGCLASS_F0S_ARTEMIS_FOOD_BONUS',	'BUILDING_F0S_ARTEMIS_FOOD_BONUS',	'TXT_KEY_BUILDING_F0S_ARTEMIS_FOOD_BONUS');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================			
-- World Wonders
UPDATE Buildings
SET NumTradeRouteBonus = 2
WHERE Type = 'BUILDING_COLOSSUS';

UPDATE Buildings
SET FreeBuilding = 'BUILDINGCLASS_MOSQUE', FreeBuildingThisCity = null
WHERE Type = 'BUILDING_MOSQUE_OF_DJENNE';

UPDATE Buildings
SET Water = 1
WHERE Type = 'BUILDING_STATUE_OF_LIBERTY';

UPDATE Buildings
SET CityWorkingChange = 1
WHERE Type = 'BUILDING_ANGKOR_WAT';

UPDATE Buildings
SET FreeBuildingThisCity = 'BUILDINGCLASS_BROADCAST_TOWER'
WHERE Type = 'BUILDING_EIFFEL_TOWER';

-- National Wonders
UPDATE Buildings
SET NumTradeRouteBonus = 2
WHERE Type = 'BUILDING_NATIONAL_TREASURY';

UPDATE Buildings
SET GoldMaintenance = 0
WHERE Type = 'BUILDING_TOURIST_CENTER';

UPDATE Buildings
SET GlobalEspionageModifier = 25
WHERE Type = 'BUILDING_INTELLIGENCE_AGENCY';

-- Standard Buildings
UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_HOSPITAL_HELP'
WHERE Type = 'BUILDING_HOSPITAL';

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_MUSEUM_HELP'
WHERE Type = 'BUILDING_MUSEUM';

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_OPERA_HOUSE_HELP'
WHERE Type = 'BUILDING_OPERA_HOUSE';

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_AMPHITHEATER_HELP'
WHERE Type = 'BUILDING_AMPHITHEATER';

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_MARKET_HELP'
WHERE Type = 'BUILDING_MARKET';

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_MOSQUE_HELP'
WHERE Type = 'BUILDING_MOSQUE';

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_PAGODA_HELP'
WHERE Type = 'BUILDING_PAGODA';

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_CATHEDRAL_HELP'
WHERE Type = 'BUILDING_CATHEDRAL';

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_TEMPLE_HELP'
WHERE Type = 'BUILDING_TEMPLE';

UPDATE Buildings
SET UnlockedByBelief = 1, FaithCost = 50
WHERE Type = 'BUILDING_LIBRARY';

UPDATE Buildings
SET FaithCost = 100
WHERE Type = 'BUILDING_UNIVERSITY';

UPDATE Buildings
SET FaithCost = 150
WHERE Type = 'BUILDING_PUBLIC_SCHOOL';

UPDATE Buildings
SET Mountain = 0, NearbyMountainRequired = 1
WHERE Type = 'BUILDING_OBSERVATORY';

UPDATE Buildings
SET BuildingProductionModifier = 15
WHERE Type = 'BUILDING_WINDMILL';

UPDATE Buildings
SET TradeRouteSeaGoldBonus = 200
WHERE Type = 'BUILDING_HARBOR';

UPDATE Buildings
SET GoldMaintenance = 1
WHERE Type = 'BUILDING_WATERMILL';

-- Unique Buildings
UPDATE Buildings
SET TradeRouteRecipientBonus = 2, TradeRouteTargetBonus = 2
WHERE Type = 'BUILDING_BAZAAR';

UPDATE Buildings
SET SpecialistType = 'SPECIALIST_SCIENTIST', SpecialistCount = 1, UnlockedByBelief = 1, FaithCost = 50
WHERE Type = 'BUILDING_ROYAL_LIBRARY';

UPDATE Buildings
SET SpecialistCount = 3, FaithCost = 100
WHERE Type = 'BUILDING_WAT';

UPDATE Buildings
SET GoldMaintenance = 0
WHERE Type = 'BUILDING_IKANDA';

UPDATE Buildings
SET GoldMaintenance = 0
WHERE Type = 'BUILDING_CANDI';

UPDATE Buildings
SET Help = null
WHERE Type = 'BUILDING_WALLS_OF_BABYLON';

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_CEILIDH_HALL_HELP', GoldMaintenance = 0, Happiness = 2
WHERE Type = 'BUILDING_CEILIDH_HALL';

UPDATE Buildings
SET UnlockedByBelief = 1, FaithCost = 50
WHERE Type = 'BUILDING_PAPER_MAKER';

UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_STELE_HELP', GoldMaintenance = 0
WHERE Type = 'BUILDING_STELE';

UPDATE Buildings
SET FoodKept = 15
WHERE Type = 'BUILDING_FLOATING_GARDENS';

-- New Buildings
INSERT INTO Buildings 	
			(Type, 										FreeStartEra, GoldMaintenance, 	PrereqTech, BuildingClass, Cost,	FaithCost,	NukeImmune, MinAreaSize, NeverCapture,	Description, 										Civilopedia, 	Help, 													Strategy,	PortraitIndex, 	IconAtlas,	ShowInPedia)
SELECT		('BUILDING_F0S_ROMAN_BARRACKS'),			FreeStartEra, 0,				PrereqTech, BuildingClass, Cost,	FaithCost,	NukeImmune, MinAreaSize, 1,				('TXT_KEY_BUILDING_F0S_ROMAN_BARRACKS'), 			Civilopedia, 	('TXT_KEY_BUILDING_F0S_ROMAN_BARRACKS_HELP'), 			Strategy,	PortraitIndex, 	IconAtlas,	0
FROM Buildings WHERE Type = 'BUILDING_BARRACKS';

INSERT INTO Buildings 	
			(Type, 										FreeStartEra, GoldMaintenance, 	PrereqTech, BuildingClass, Cost,	FaithCost,	NukeImmune, MinAreaSize, NeverCapture,	Description, 										Civilopedia, 	Help, 													Strategy,	PortraitIndex, 	IconAtlas,	ShowInPedia)
SELECT		('BUILDING_F0S_ROMAN_ARMORY'),				FreeStartEra, 0,				PrereqTech, BuildingClass, Cost,	FaithCost,	NukeImmune, MinAreaSize, 1,				('TXT_KEY_BUILDING_F0S_ROMAN_ARMORY'), 				Civilopedia, 	('TXT_KEY_BUILDING_F0S_ROMAN_ARMORY_HELP'), 			Strategy,	PortraitIndex, 	IconAtlas,	0
FROM Buildings WHERE Type = 'BUILDING_ARMORY';

INSERT INTO Buildings 	
			(Type, 										FreeStartEra, GoldMaintenance, 	PrereqTech, BuildingClass, Cost,	FaithCost,	NukeImmune, MinAreaSize, NeverCapture,	Description, 										Civilopedia, 	Help, 													Strategy,	PortraitIndex, 	IconAtlas,	ShowInPedia)
SELECT		('BUILDING_F0S_ROMAN_MILITARY_ACADEMY'),	FreeStartEra, 0,				PrereqTech, BuildingClass, Cost,	FaithCost,	NukeImmune, MinAreaSize, 1,				('TXT_KEY_BUILDING_F0S_ROMAN_MILITARY_ACADEMY'), 	Civilopedia, 	('TXT_KEY_BUILDING_F0S_ROMAN_MILITARY_ACADEMY_HELP'), 	Strategy,	PortraitIndex, 	IconAtlas,	0
FROM Buildings WHERE Type = 'BUILDING_MILITARY_ACADEMY';

INSERT INTO Buildings 	
			(Type, 						AllowsWaterRoutes,	GreatWorkCount, GreatWorkSlotType,	BuildingClass, PrereqTech, Cost,	FaithCost,	UnlockedByBelief, SpecialistType, SpecialistCount, GoldMaintenance, MinAreaSize,	ConquestProb, Description, 						Civilopedia, 							Help, 									Strategy,									ArtDefineTag, PortraitIndex,	IconAtlas)
SELECT		('BUILDING_F0S_AGORA'),		AllowsWaterRoutes,	GreatWorkCount,	GreatWorkSlotType,	BuildingClass, PrereqTech, Cost,	FaithCost,	UnlockedByBelief, SpecialistType, SpecialistCount, 0, 				MinAreaSize,	ConquestProb, ('TXT_KEY_BUILDING_F0S_AGORA'),	('TXT_KEY_BUILDING_F0S_AGORA_TEXT'),	('TXT_KEY_BUILDING_F0S_AGORA_HELP'),	('TXT_KEY_BUILDING_F0S_AGORA_STRATEGY'),	ArtDefineTag, 0, 				('F0S_MISC_FIXES_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_AMPHITHEATER';

INSERT INTO Buildings 	
			(Type, 						 			BuildingClass, 							GreatWorkCount, Cost, FaithCost, PrereqTech,	NeverCapture,	NukeImmune,	FoodKept,	UnmoddedHappiness,	CityConnectionTradeRouteModifier,	Description, 								Help)
VALUES		('BUILDING_F0S_AGORA_BONUS_FOOD', 		'BUILDINGCLASS_F0S_AGORA_BONUS', 		-1,				-1,   -1, 		 null, 		 	1,				1,			0,			0,					0,									'TXT_KEY_BUILDING_F0S_AGORA_BONUS', 		'TXT_KEY_BUILDING_F0S_AGORA_BONUS_HELP'),
			('BUILDING_F0S_AGORA_BONUS_HAPPY', 		'BUILDINGCLASS_F0S_AGORA_BONUS', 		-1,				-1,   -1, 		 null, 		 	1,				1,			0,			1,					0,									'TXT_KEY_BUILDING_F0S_AGORA_BONUS', 		'TXT_KEY_BUILDING_F0S_AGORA_BONUS_HELP'),
			('BUILDING_F0S_AGORA_BONUS_CULTURE', 	'BUILDINGCLASS_F0S_AGORA_BONUS', 		-1,				-1,   -1, 		 null, 		 	1,				1,			0,			0,					0,									'TXT_KEY_BUILDING_F0S_AGORA_BONUS', 		'TXT_KEY_BUILDING_F0S_AGORA_BONUS_HELP'),
			('BUILDING_F0S_AGORA_BONUS_FAITH', 		'BUILDINGCLASS_F0S_AGORA_BONUS', 		-1,				-1,   -1, 		 null, 		 	1,				1,			0,			0,					0,									'TXT_KEY_BUILDING_F0S_AGORA_BONUS', 		'TXT_KEY_BUILDING_F0S_AGORA_BONUS_HELP'),
			('BUILDING_F0S_AGORA_BONUS_XP', 		'BUILDINGCLASS_F0S_AGORA_BONUS', 		-1,				-1,   -1, 		 null, 		 	1,				1,			0,			0,					0,									'TXT_KEY_BUILDING_F0S_AGORA_BONUS', 		'TXT_KEY_BUILDING_F0S_AGORA_BONUS_HELP'),
			('BUILDING_F0S_CELT_FAITH', 			'BUILDINGCLASS_F0S_CELT_FAITH', 		-1,				-1,   -1, 		 null, 		 	1,				1,			0,			0,					0,									'TXT_KEY_BUILDING_F0S_CELT_FAITH', 			'TXT_KEY_BUILDING_F0S_CELT_FAITH_HELP'),
			('BUILDING_F0S_MONGOLIAN_GOLD', 		'BUILDINGCLASS_F0S_MONGOLIAN_GOLD', 	-1,				-1,   -1, 		 null, 		 	1,				1,			0,			0,					25,									'TXT_KEY_BUILDING_F0S_MONGOLIAN_GOLD', 		'TXT_KEY_BUILDING_F0S_MONGOLIAN_GOLD_HELP'),
			('BUILDING_F0S_ARTEMIS_FOOD_BONUS', 	'BUILDINGCLASS_F0S_ARTEMIS_FOOD_BONUS', -1,				-1,   -1, 		 null, 		 	1,				1,			15,			0,					0,									'TXT_KEY_BUILDING_F0S_ARTEMIS_FOOD_BONUS', 	'TXT_KEY_BUILDING_F0S_ARTEMIS_FOOD_BONUS_HELP');
--==========================================================================================================================	
-- Building_ClassesNeededInCity
--==========================================================================================================================
DELETE FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_MUSEUM';

UPDATE Building_ClassesNeededInCity
SET BuildingClassType = 'BUILDINGCLASS_OPERA_HOUSE'
WHERE BuildingType = 'BUILDING_BROADCAST_TOWER';

INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 			BuildingClassType)
VALUES		('BUILDING_HARBOR', 	'BUILDINGCLASS_LIGHTHOUSE');

INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 								BuildingClassType)
SELECT		('BUILDING_F0S_ROMAN_BARRACKS'),			BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_BARRACKS';

INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 								BuildingClassType)
SELECT		('BUILDING_F0S_ROMAN_ARMORY'),				BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_ARMORY';

INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 								BuildingClassType)
SELECT		('BUILDING_F0S_ROMAN_MILITARY_ACADEMY'),	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_MILITARY_ACADEMY';

INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 								BuildingClassType)
SELECT		('BUILDING_F0S_AGORA'),						BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_AMPHITHEATER';
--==========================================================================================================================	
-- Building_FreeUnits
--==========================================================================================================================
INSERT INTO Building_FreeUnits 	
			(BuildingType, 			UnitType, 				NumUnits)
VALUES		('BUILDING_MUSEUM', 	'UNIT_ARCHAEOLOGIST',	1);
--==========================================================================================================================	
-- Building_DomainFreeExperiencePerGreatWork
--==========================================================================================================================
UPDATE Building_DomainFreeExperiencePerGreatWork
SET Experience = 15
WHERE BuildingType = 'BUILDING_ROYAL_LIBRARY';
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================
UPDATE Building_YieldChanges
SET Yield = 6
WHERE BuildingType = 'BUILDING_HOSPITAL';

UPDATE Building_YieldChanges
SET Yield = 3
WHERE BuildingType = 'BUILDING_WINDMILL';

UPDATE Building_YieldChanges
SET Yield = 2
WHERE BuildingType = 'BUILDING_MUSEUM';

UPDATE Building_YieldChanges
SET Yield = 2
WHERE BuildingType = 'BUILDING_OPERA_HOUSE';

UPDATE Building_YieldChanges
SET Yield = 2
WHERE BuildingType = 'BUILDING_AMPHITHEATER';

UPDATE Building_YieldChanges
SET Yield = 2
WHERE BuildingType = 'BUILDING_BROADCAST_TOWER';

UPDATE Building_YieldChanges
SET Yield = 2
WHERE BuildingType = 'BUILDING_CEILIDH_HALL';

UPDATE Building_YieldChanges
SET Yield = 4
WHERE BuildingType = 'BUILDING_MACHU_PICHU' AND YieldType = 'YIELD_GOLD';

INSERT INTO Building_YieldChanges
			(BuildingType, 				YieldType,	Yield)
SELECT		('BUILDING_F0S_AGORA'),		YieldType,	2
FROM Building_YieldChanges WHERE BuildingType = 'BUILDING_AMPHITHEATER';

INSERT INTO Building_YieldChanges 	
			(BuildingType, 							YieldType, 			Yield)
VALUES		('BUILDING_CEILIDH_HALL', 				'YIELD_FAITH',		2),
			('BUILDING_F0S_CELT_FAITH', 			'YIELD_FAITH',	 	1),
			('BUILDING_F0S_AGORA_BONUS_FOOD',		'YIELD_FOOD', 		1),
			('BUILDING_F0S_AGORA_BONUS_CULTURE',	'YIELD_CULTURE', 	1),
			('BUILDING_F0S_AGORA_BONUS_FAITH',		'YIELD_FAITH',	 	1);	
--==========================================================================================================================	
-- Building_TerrainYieldChanges
--==========================================================================================================================
INSERT INTO Building_TerrainYieldChanges 	
			(BuildingType, 				TerrainType,		YieldType, 			Yield)
VALUES		('BUILDING_OBSERVATORY', 	'TERRAIN_TUNDRA',	'YIELD_SCIENCE',	1),
			('BUILDING_OBSERVATORY', 	'TERRAIN_SNOW',		'YIELD_SCIENCE',	1);
--==========================================================================================================================	
-- Building_UnitCombatProductionModifiers
--==========================================================================================================================
INSERT INTO Building_UnitCombatProductionModifiers 	
			(BuildingType, 			UnitCombatType, 				Modifier)
VALUES		('BUILDING_STABLE', 	'UNITCOMBAT_MOUNTED_RANGED',	1);
--==========================================================================================================================	
-- Building_GlobalYieldModifiers
--==========================================================================================================================
DELETE FROM Building_GlobalYieldModifiers WHERE BuildingType = 'BUILDING_TEMPLE_ARTEMIS';
--==========================================================================================================================	
-- Building_YieldModifiers
--==========================================================================================================================
DELETE FROM Building_YieldModifiers WHERE BuildingType = 'BUILDING_FLOATING_GARDENS';

UPDATE Building_YieldModifiers
SET Yield = 33
WHERE BuildingType = 'BUILDING_SATRAPS_COURT';

UPDATE Building_YieldModifiers
SET Yield = 33
WHERE BuildingType = 'BUILDING_STOCK_EXCHANGE';

UPDATE Building_YieldModifiers
SET Yield = 33
WHERE BuildingType = 'BUILDING_OBSERVATORY';
--==========================================================================================================================	
-- Building_FeatureYieldChanges
--==========================================================================================================================
DELETE FROM Building_FeatureYieldChanges WHERE BuildingType = 'BUILDING_WAT';

INSERT INTO Building_FeatureYieldChanges 	
			(BuildingType, 					FeatureType,				YieldType, 			Yield)
VALUES		('BUILDING_UNIVERSITY', 		'FEATURE_MARSH',			'YIELD_SCIENCE',	2),
			('BUILDING_WAT', 				'FEATURE_JUNGLE',			'YIELD_SCIENCE',	3),
			('BUILDING_WAT', 				'FEATURE_MARSH',			'YIELD_SCIENCE',	3),
			('BUILDING_FLOATING_GARDENS', 	'FEATURE_LAKE_VICTORIA',	'YIELD_FOOD',		1);
--==========================================================================================================================	
-- Building_LakePlotYieldChanges
--==========================================================================================================================
UPDATE Building_LakePlotYieldChanges
SET Yield = 1
WHERE BuildingType = 'BUILDING_FLOATING_GARDENS';
--==========================================================================================================================	
-- Building_SeaResourceYieldChanges
--==========================================================================================================================
DELETE FROM Building_SeaResourceYieldChanges WHERE BuildingType = 'BUILDING_LIGHTHOUSE';

INSERT INTO Building_SeaResourceYieldChanges 	
			(BuildingType, 			YieldType, 		Yield)
VALUES		('BUILDING_HARBOR', 	'YIELD_GOLD',	1);
--==========================================================================================================================	
-- Building_ResourceYieldChanges
--==========================================================================================================================
INSERT INTO Building_ResourceYieldChanges 	
			(BuildingType, 			ResourceType,		YieldType, 		Yield)
VALUES		('BUILDING_GRANARY', 	'RESOURCE_BISON',	'YIELD_FOOD',	1),
			('BUILDING_MINT', 		'RESOURCE_COPPER',	'YIELD_GOLD',	2);
--==========================================================================================================================	
-- Building_LocalResourceOrs
--==========================================================================================================================
INSERT INTO Building_LocalResourceOrs 	
			(BuildingType, 			ResourceType)
VALUES		('BUILDING_MINT', 		'RESOURCE_COPPER');
--==========================================================================================================================	
-- Building_DomainFreeExperiences
--==========================================================================================================================
INSERT INTO Building_DomainFreeExperiences 	
			(BuildingType, 								DomainType, Experience)
SELECT		('BUILDING_F0S_ROMAN_BARRACKS'),			DomainType, 20
FROM Building_DomainFreeExperiences WHERE BuildingType = 'BUILDING_BARRACKS';

INSERT INTO Building_DomainFreeExperiences 	
			(BuildingType, 								DomainType, Experience)
SELECT		('BUILDING_F0S_ROMAN_ARMORY'),				DomainType, 20
FROM Building_DomainFreeExperiences WHERE BuildingType = 'BUILDING_ARMORY';

INSERT INTO Building_DomainFreeExperiences 	
			(BuildingType, 								DomainType, Experience)
SELECT		('BUILDING_F0S_ROMAN_MILITARY_ACADEMY'),	DomainType, 20
FROM Building_DomainFreeExperiences WHERE BuildingType = 'BUILDING_MILITARY_ACADEMY';

INSERT INTO Building_DomainFreeExperiences 	
			(BuildingType, 								DomainType, Experience)
SELECT		('BUILDING_F0S_AGORA_BONUS_XP'),			DomainType, 5
FROM Building_DomainFreeExperiences WHERE BuildingType = 'BUILDING_BARRACKS';
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================
INSERT INTO Building_Flavors 	
			(BuildingType, 								FlavorType, Flavor)
SELECT		('BUILDING_F0S_ROMAN_BARRACKS'),			FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_BARRACKS';

INSERT INTO Building_Flavors 	
			(BuildingType, 								FlavorType, Flavor)
SELECT		('BUILDING_F0S_ROMAN_ARMORY'),				FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_ARMORY';

INSERT INTO Building_Flavors 	
			(BuildingType, 								FlavorType, Flavor)
SELECT		('BUILDING_F0S_ROMAN_MILITARY_ACADEMY'),	FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_MILITARY_ACADEMY';

INSERT INTO Building_Flavors 	
			(BuildingType, 								FlavorType, Flavor)
SELECT		('BUILDING_F0S_AGORA'),						FlavorType, Flavor
FROM Building_Flavors WHERE BuildingType = 'BUILDING_AMPHITHEATER';
--==========================================================================================================================		
--==========================================================================================================================