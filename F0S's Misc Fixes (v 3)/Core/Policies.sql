--==========================================================================================================================	
-- Policies
--==========================================================================================================================			
-- Tradition
UPDATE Policies
SET CityGrowthMod = 10
WHERE Type = 'POLICY_TRADITION_FINISHER';

UPDATE Policies
SET GarrisonFreeMaintenance = 0
WHERE Type = 'POLICY_OLIGARCHY';

UPDATE Policies
SET WonderProductionModifier = 10
WHERE Type = 'POLICY_ARISTOCRACY';

-- Liberty
UPDATE Policies
SET BuildingGoldMaintenanceMod = -20
WHERE Type = 'POLICY_LIBERTY_FINISHER';

UPDATE Policies
SET BuildingProductionModifier = 10
WHERE Type = 'POLICY_REPUBLIC';

UPDATE Policies
SET HappinessPerTradeRoute = 200, UnhappinessMod = -10
WHERE Type = 'POLICY_MERITOCRACY';

UPDATE Policies
SET NumCitiesPolicyCostDiscount = -50
WHERE Type = 'POLICY_REPRESENTATION';

-- Aesthetics
UPDATE Policies
SET HappinessToCulture = 100
WHERE Type = 'POLICY_FINE_ARTS';

UPDATE Policies
SET SharedReligionTourismModifier = 25, TradeRouteTourismModifier = 25, OpenBordersTourismModifier = 25
WHERE Type = 'POLICY_ETHICS';

-- Freedom
UPDATE Policies
SET SharedIdeologyTradeGoldChange = 4
WHERE Type = 'POLICY_ECONOMIC_UNION';

UPDATE Policies
SET CityStrengthMod = 50
WHERE Type = 'POLICY_THEIR_FINEST_HOUR';

-- Order
UPDATE Policies
SET BuildingPurchaseCostModifier = -35
WHERE Type = 'POLICY_SKYSCRAPERS';

UPDATE Policies
SET LessHappyTourismModifier = 50
WHERE Type = 'POLICY_DICTATORSHIP_PROLETARIAT';

UPDATE Policies
SET SharedIdeologyTourismModifier = 50
WHERE Type = 'POLICY_CULTURAL_REVOLUTION';

UPDATE Policies
SET WorkerSpeedModifier = 25
WHERE Type = 'POLICY_RESETTLEMENT';

-- Autocracy
UPDATE Policies
SET UnitPurchaseCostModifier = -35
WHERE Type = 'POLICY_MOBILIZATION';

UPDATE Policies
SET CommonFoeTourismModifier = 100
WHERE Type = 'POLICY_CULT_PERSONALITY';

UPDATE Policies
SET MinorBullyScoreModifier = 100
WHERE Type = 'POLICY_GUNBOAT_DIPLOMACY';

UPDATE Policies
SET UnitGoldMaintenanceMod = -35
WHERE Type = 'POLICY_NATIONALISM';

-- New Policies
INSERT INTO Policies
			(Type,					Description,							MilitaryUnitGiftExtraInfluence,	CityStateUnitFrequencyModifier,	CityWorkingChange)
VALUES		('POLICY_F0S_GREECE',	'TXT_KEY_POLICY_F0S_GREECE_SHORT',		5,								100,							0),
			('POLICY_F0S_VENICE',	'TXT_KEY_POLICY_F0S_VENICE_SHORT',		0,								0,								1);
--==========================================================================================================================	
-- Policy_BuildingClassYieldChanges
--==========================================================================================================================
INSERT INTO Policy_BuildingClassYieldChanges 	
			(PolicyType, 					BuildingClassType, 					YieldType,			YieldChange)
VALUES		('POLICY_CULTURAL_CENTERS',		'BUILDINGCLASS_MONUMENT',			'YIELD_CULTURE',	1),
			('POLICY_CULTURAL_CENTERS',		'BUILDINGCLASS_AMPHITHEATER',		'YIELD_CULTURE',	1),
			('POLICY_CULTURAL_CENTERS',		'BUILDINGCLASS_OPERA_HOUSE',		'YIELD_CULTURE',	1),
			('POLICY_CULTURAL_CENTERS',		'BUILDINGCLASS_MUSEUM',				'YIELD_CULTURE',	1),
			('POLICY_CULTURAL_CENTERS',		'BUILDINGCLASS_BROADCAST_TOWER',	'YIELD_CULTURE',	1);
--==========================================================================================================================	
-- Policy_ImprovementYieldChanges
--==========================================================================================================================
INSERT INTO Policy_ImprovementYieldChanges 	
			(PolicyType, 						ImprovementType, 		YieldType,			Yield)
VALUES		('POLICY_SCIENTIFIC_REVOLUTION',	'IMPROVEMENT_ACADEMY',	'YIELD_SCIENCE',	2);
--==========================================================================================================================	
-- Policy_CapitalYieldChanges
--==========================================================================================================================
UPDATE Policy_CapitalYieldChanges
SET Yield = 10
WHERE PolicyType = 'POLICY_THIRD_ALTERNATIVE';
--==========================================================================================================================	
-- Policy_BuildingClassProductionModifiers
--==========================================================================================================================
DELETE FROM Policy_BuildingClassProductionModifiers WHERE PolicyType = 'POLICY_PROFESSIONAL_ARMY';

UPDATE Policy_BuildingClassProductionModifiers
SET ProductionModifier = 50
WHERE PolicyType = 'POLICY_SOCIALIST_REALISM';

UPDATE Policy_BuildingClassProductionModifiers
SET ProductionModifier = 50
WHERE PolicyType = 'POLICY_WORKERS_FACULTIES';

UPDATE Policy_BuildingClassProductionModifiers
SET ProductionModifier = 50
WHERE PolicyType = 'POLICY_POLICE_STATE';

INSERT INTO Policy_BuildingClassProductionModifiers 	
			(PolicyType, 			BuildingClassType, 				ProductionModifier)
VALUES		('POLICY_OLIGARCHY', 	'BUILDINGCLASS_WALLS',			50),
			('POLICY_OLIGARCHY', 	'BUILDINGCLASS_CASTLE',	 		50),
			('POLICY_OLIGARCHY',	'BUILDINGCLASS_ARSENAL', 		50),
			('POLICY_OLIGARCHY',	'BUILDINGCLASS_MILITARY_BASE', 	50);	
--==========================================================================================================================	
-- Policy_BuildingClassHappiness
--==========================================================================================================================
UPDATE Policy_BuildingClassHappiness
SET Happiness = 4
WHERE PolicyType = 'POLICY_POLICE_STATE';

INSERT INTO Policy_BuildingClassHappiness 	
			(PolicyType, 					BuildingClassType,			Happiness)
VALUES		('POLICY_CAPITALISM', 			'BUILDINGCLASS_MARKET',		1),
			('POLICY_URBANIZATION', 		'BUILDINGCLASS_GRANARY',	1),
			('POLICY_URBANIZATION', 		'BUILDINGCLASS_AQUEDUCT',	1),
			('POLICY_ACADEMY_SCIENCES', 	'BUILDINGCLASS_LIBRARY',	1),
			('POLICY_ACADEMY_SCIENCES', 	'BUILDINGCLASS_UNIVERSITY',	1),
			('POLICY_FORTIFIED_BORDERS', 	'BUILDINGCLASS_WALLS',		1);
--==========================================================================================================================	
-- Policy_BuildingClassTourismModifiers
--==========================================================================================================================
UPDATE Policy_BuildingClassTourismModifiers
SET TourismModifier = 50
WHERE PolicyType = 'POLICY_MEDIA_CULTURE';
--==========================================================================================================================	
-- Policy_GreatWorkYieldChanges
--==========================================================================================================================
UPDATE Policy_GreatWorkYieldChanges
SET Yield = 2
WHERE PolicyType = 'POLICY_CREATIVE_EXPRESSION';
--==========================================================================================================================	
-- Policy_TourismOnUnitCreation
--==========================================================================================================================
UPDATE Policy_TourismOnUnitCreation
SET Tourism = 300
WHERE PolicyType = 'POLICY_FUTURISM';
--==========================================================================================================================		
--==========================================================================================================================