--==========================================================================================================================
-- POLICY BRANCHES
--==========================================================================================================================
-- PolicyBranchTypes
--------------------------------------------------------------------------------------------------------------------------
--Autocracy
UPDATE PolicyBranchTypes
SET Title = 'TXT_KEY_JFD_AUTOCRACY_TITLE'
WHERE Type = 'POLICY_BRANCH_AUTOCRACY';

--Exploration
UPDATE PolicyBranchTypes
SET Title = 'TXT_KEY_JFD_EXPLORATION_TITLE', Help = 'TXT_KEY_POLICY_JFD_EXPLORATION_HELP'
WHERE Type = 'POLICY_BRANCH_EXPLORATION';
--==========================================================================================================================
-- POLICIES
--==========================================================================================================================
-- Policies
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policies
		(Type,						Description)
VALUES	('POLICY_JFD_EXPLORATION',	'TXT_KEY_POLICY_JFD_EXPLORATION');

--Exploration Opener
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_JFD_EXPLORATION_HELP'
WHERE Type = 'POLICY_EXPLORATION';

--Maritime Infrastructure
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_JFD_MARITIME_INFRASTRUCTURE_HELP', PortraitIndex = 8, IconAtlas = 'POLICY_ATLAS', IconAtlasAchieved = 'POLICY_A_ATLAS', GridX = 4
WHERE Type = 'POLICY_MARITIME_INFRASTRUCTURE';

--Naval Tradition
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_JFD_NAVAL_TRADITION_HELP', IncludesOneShotFreeUnits = 1, GreatAdmiralRateModifier = 50, PortraitIndex = 7, IconAtlas = 'POLICY_ATLAS_EXP2', IconAtlasAchieved = 'POLICY_A_ATLAS_EXP2', GridY = 2
WHERE Type = 'POLICY_NAVAL_TRADITION';

--Navigation School
UPDATE Policies
SET Description = 'TXT_KEY_POLICY_JFD_NAVIGATION_SCHOOL', Help = 'TXT_KEY_POLICY_JFD_NAVIGATION_SCHOOL_HELP', Civilopedia = 'TXT_KEY_CIV5_POLICY_JFD_NAVIGATION_SCHOOL_TEXT', IncludesOneShotFreeUnits = 0, GreatAdmiralRateModifier = 0, NewCityExtraPopulation = 2, PortraitIndex = 6, IconAtlas = 'POLICY_ATLAS_EXP2', IconAtlasAchieved = 'POLICY_A_ATLAS_EXP2', GridX = 2, GridY = 1
WHERE Type = 'POLICY_NAVIGATION_SCHOOL';

--Merchant Navy
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_JFD_MERCHANT_NAVY_HELP', SeaTradeRouteGoldChange = 200, PortraitIndex = 8, IconAtlas = 'POLICY_ATLAS_EXP2', IconAtlasAchieved = 'POLICY_A_ATLAS_EXP2'
WHERE Type = 'POLICY_MERCHANT_NAVY';

--Treasure Fleets
UPDATE Policies
SET Description = 'TXT_KEY_POLICY_JFD_VICEGERENTRY', Help = 'TXT_KEY_POLICY_JFD_VICEGERENTRY_HELP', Civilopedia = 'TXT_KEY_CIV5_POLICY_JFD_VICEGERENTRY_TEXT', SeaTradeRouteGoldChange = 0, InternalTradeRouteYieldModifier = 50, PortraitIndex = 10, IconAtlas = 'POLICY_ATLAS', IconAtlasAchieved = 'POLICY_A_ATLAS'
WHERE Type = 'POLICY_TREASURE_FLEETS';

--Exploration Finisher
UPDATE Policies
SET CityWorkingChange = 1
WHERE Type = 'POLICY_EXPLORATION_FINISHER';
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassYieldChanges
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_BuildingClassYieldChanges WHERE PolicyType = 'POLICY_MERCHANT_NAVY';
--------------------------------------------------------------------------------------------------------------------------
-- Policy_FreeBuilding
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassProductionModifiers 
		(PolicyType, 						BuildingClassType, 			ProductionModifier)
VALUES	('POLICY_MARITIME_INFRASTRUCTURE',	'BUILDINGCLASS_LIGHTHOUSE', 50),
		('POLICY_MARITIME_INFRASTRUCTURE',	'BUILDINGCLASS_HARBOR', 	50),
		('POLICY_MARITIME_INFRASTRUCTURE',	'BUILDINGCLASS_SEAPORT', 	50);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassCultureChanges
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_BuildingClassCultureChanges WHERE PolicyType = 'POLICY_MERCHANT_NAVY';
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassHappiness
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_BuildingClassHappiness WHERE PolicyType = 'POLICY_NAVAL_TRADITION';

INSERT INTO Policy_BuildingClassHappiness 
		(PolicyType, 					BuildingClassType, 			Happiness)
VALUES	('POLICY_TREASURE_FLEETS', 		'BUILDINGCLASS_HARBOR', 	2);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_UnitCombatProductionModifiers
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_UnitCombatProductionModifiers 
		(PolicyType, 					UnitCombatType, 			ProductionModifier)
SELECT	'POLICY_NAVAL_TRADITION', 		Type, 						25
FROM UnitCombatInfos WHERE Type IN ('UNITCOMBAT_NAVALMELEE', 'UNITCOMBAT_NAVALRANGED', 'UNITCOMBAT_SUBMARINE', 'UNITCOMBAT_CARRIER');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_FreePromotions
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_FreePromotions WHERE PolicyType = 'POLICY_NAVIGATION_SCHOOL';

INSERT INTO Policy_FreePromotions 
		(PolicyType, 					PromotionType)
VALUES	('POLICY_EXPLORATION', 			'PROMOTION_EXPLORATION_EMBARK');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_FreeUnitClasses
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_FreeUnitClasses WHERE PolicyType = 'POLICY_NAVIGATION_SCHOOL';

INSERT INTO Policy_FreeUnitClasses 
		(PolicyType, 					UnitClassType,						Count)
VALUES	('POLICY_NAVAL_TRADITION', 		'UNITCLASS_GREAT_ADMIRAL',			1);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_PrereqPolicies
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_PrereqPolicies WHERE PolicyType = 'POLICY_MERCHANT_NAVY';
DELETE FROM Policy_PrereqPolicies WHERE PolicyType = 'POLICY_NAVIGATION_SCHOOL';

INSERT INTO Policy_PrereqPolicies 
		(PolicyType, 					PrereqPolicy)
VALUES	('POLICY_MERCHANT_NAVY', 		'POLICY_NAVIGATION_SCHOOL'),
		('POLICY_MERCHANT_NAVY', 		'POLICY_MARITIME_INFRASTRUCTURE');
		
INSERT INTO Policy_PrereqPolicies 
		(PolicyType, 					PrereqPolicy)
VALUES	('POLICY_NAVAL_TRADITION', 		'POLICY_MARITIME_INFRASTRUCTURE');
--------------------------------------------------------------------------------------------------------------------------
-- Policy_Flavors
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_Flavors WHERE PolicyType IN ('POLICY_NAVAL_TRADITION', 'POLICY_TREASURE_FLEETS', 'POLICY_NAVIGATION_SCHOOL', 'POLICY_EXPLORATION_FINISHER');

INSERT INTO Policy_Flavors
		(PolicyType,					FlavorType,				Flavor)
VALUES	('POLICY_NAVAL_TRADITION',		'FLAVOR_NAVAL',			20),
		('POLICY_NAVAL_TRADITION',		'FLAVOR_PRODUCTION',	10),
		('POLICY_NAVIGATION_SCHOOL',	'FLAVOR_EXPANSION',		10),
		('POLICY_TREASURE_FLEETS',		'FLAVOR_HAPPINESS',		10),
		('POLICY_TREASURE_FLEETS',		'FLAVOR_PRODUCTION',	5),
		('POLICY_TREASURE_FLEETS',		'FLAVOR_GROWTH',		5),
		('POLICY_EXPLORATION_FINISHER',	'FLAVOR_EXPANSION',		10);
--==========================================================================================================================
--==========================================================================================================================