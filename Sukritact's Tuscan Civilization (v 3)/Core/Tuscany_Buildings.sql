--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 					BuildingClass, Cost, GoldMaintenance, 	PrereqTech, Description, 						Civilopedia, 							Help, 								Strategy,							 ArtDefineTag, MinAreaSize, ConquestProb, GreatWorkSlotType, 				GreatWorkCount, GreatPeopleRateModifier, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_DUOMO'),		BuildingClass, Cost, 0, 				PrereqTech, ('TXT_KEY_BUILDING_DUOMO_DESC'),	('TXT_KEY_CIV5_BUILDING_DUOMO_TEXT'),	('TXT_KEY_BUILDING_DUOMO_HELP'),	('TXT_KEY_BUILDING_DUOMO_STRATEGY'), ArtDefineTag, MinAreaSize, ConquestProb, ('GREAT_WORK_SLOT_ART_ARTIFACT'), 1,				GreatPeopleRateModifier, HurryCostModifier, 3, 				('TUSCANY_ATLAS')
FROM Buildings WHERE Type = 'BUILDING_GARDEN';
--==========================================================================================================================
-- Building_Flavors
--==========================================================================================================================
INSERT INTO Building_Flavors 	
			(BuildingType, 		FlavorType, Flavor)
SELECT		('BUILDING_DUOMO'),	FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_GARDEN');
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================		
-- Disabled for balance purposes
--INSERT INTO Building_YieldChanges 	
--			(BuildingType, 				YieldType, 			Yield)
--VALUES		('BUILDING_DUOMO', 			'YIELD_FAITH', 	2);
--==========================================================================================================================	
-- Building_YieldFromGreatWorksInBuilding
--==========================================================================================================================		
INSERT INTO Building_YieldFromGreatWorksInBuilding 	
			(BuildingType, 				YieldType, 			Yield)
VALUES		('BUILDING_DUOMO', 			'YIELD_GOLD', 		2);
--==========================================================================================================================
--==========================================================================================================================