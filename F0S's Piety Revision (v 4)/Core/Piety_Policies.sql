--==========================================================================================================================
-- POLICIES
--==========================================================================================================================
-- Policies
--------------------------------------------------------------------------------------------------------------------------	
--Organised Religion
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_ORGANIZED_RELIGION_HELP', GridX = 2, GridY = 1
WHERE Type = 'POLICY_ORGANIZED_RELIGION';

--Theocracy
UPDATE Policies
SET GridX = 2, GridY = 2
WHERE Type = 'POLICY_THEOCRACY';

--Mandate of Heaven
UPDATE Policies
SET FaithCostModifier = -25, GridX = 4, GridY = 1
WHERE Type = 'POLICY_MANDATE_OF_HEAVEN';

--Reformation
UPDATE Policies
SET GridX = 4, GridY = 3
WHERE Type = 'POLICY_REFORMATION';

--Monasticism
UPDATE Policies
SET Description = 'TXT_KEY_POLICY_F0S_MONASTICISM', Help = 'TXT_KEY_POLICY_F0S_MONASTICISM_HELP', Civilopedia = 'TXT_KEY_POLICY_F0S_MONASTICISM_TEXT', SecondReligionPantheon = 0, GridX = 4, GridY = 2
WHERE Type = 'POLICY_FREE_RELIGION';
--------------------------------------------------------------------------------------------------------------------------
-- Policy_CapitalYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_CapitalYieldChanges 
		(PolicyType, 				YieldType, 					Yield)
VALUES	('POLICY_PIETY', 			'YIELD_FAITH', 				1);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassProductionModifiers
--------------------------------------------------------------------------------------------------------------------------
UPDATE Policy_BuildingClassProductionModifiers
SET ProductionModifier = 50
WHERE PolicyType = 'POLICY_PIETY';
--------------------------------------------------------------------------------------------------------------------------
-- Policy_ImprovementCultureChanges
--------------------------------------------------------------------------------------------------------------------------
UPDATE Policy_ImprovementCultureChanges
SET CultureChange = 4
WHERE ImprovementType = 'IMPROVEMENT_HOLY_SITE';

INSERT INTO Policy_ImprovementCultureChanges
		(PolicyType, 					ImprovementType,			CultureChange)
VALUES	('POLICY_PIETY_FINISHER', 		'IMPROVEMENT_MISSION',		2);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_ImprovementYieldChanges
--------------------------------------------------------------------------------------------------------------------------
UPDATE Policy_ImprovementYieldChanges
SET Yield = 4
WHERE ImprovementType = 'IMPROVEMENT_HOLY_SITE';

INSERT INTO Policy_ImprovementYieldChanges
		(PolicyType, 					ImprovementType,			YieldType,			Yield)
VALUES	('POLICY_FREE_RELIGION', 		'IMPROVEMENT_HOLY_SITE',	'YIELD_SCIENCE',	4),
		('POLICY_FREE_RELIGION', 		'IMPROVEMENT_MISSION',		'YIELD_SCIENCE',	2),
		('POLICY_THEOCRACY', 			'IMPROVEMENT_MISSION',		'YIELD_GOLD',		2);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassYieldChanges
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_BuildingClassYieldChanges WHERE PolicyType = 'POLICY_ORGANIZED_RELIGION';

INSERT INTO Policy_BuildingClassYieldChanges 
		(PolicyType, 					BuildingClassType,				YieldType, 					YieldChange)
VALUES	('POLICY_ORGANIZED_RELIGION', 	'BUILDINGCLASS_SHRINE',			'YIELD_FAITH',				1);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassHappiness
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassHappiness 
		(PolicyType, 					BuildingClassType,				Happiness)
VALUES	('POLICY_ORGANIZED_RELIGION', 	'BUILDINGCLASS_SHRINE',			1);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_Flavors
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_Flavors WHERE PolicyType = 'POLICY_FREE_RELIGION';

INSERT INTO Policy_Flavors 
		(PolicyType, 					FlavorType,			Flavor)
VALUES	('POLICY_ORGANIZED_RELIGION', 	'FLAVOR_HAPPINESS',	10),
		('POLICY_FREE_RELIGION', 		'FLAVOR_RELIGION',	10),
		('POLICY_FREE_RELIGION', 		'FLAVOR_CULTURE',	10),
		('POLICY_FREE_RELIGION', 		'FLAVOR_SCIENCE',	10);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_PrereqPolicies
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_PrereqPolicies WHERE PolicyType IN ('POLICY_FREE_RELIGION', 'POLICY_REFORMATION');

INSERT INTO Policy_PrereqPolicies 
		(PolicyType, 					PrereqPolicy)
VALUES	('POLICY_FREE_RELIGION', 		'POLICY_ORGANIZED_RELIGION'),
		('POLICY_FREE_RELIGION', 		'POLICY_MANDATE_OF_HEAVEN');

INSERT INTO Policy_PrereqPolicies 
		(PolicyType, 					PrereqPolicy)
VALUES	('POLICY_REFORMATION', 			'POLICY_FREE_RELIGION');
--==========================================================================================================================
--==========================================================================================================================