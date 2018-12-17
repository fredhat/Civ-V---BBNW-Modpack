--==========================================================================================================================
-- POLICY BRANCHES
--==========================================================================================================================
-- PolicyBranchTypes
--------------------------------------------------------------------------------------------------------------------------
--Honor
UPDATE PolicyBranchTypes
SET Help = 'TXT_KEY_POLICY_F0S_HONOR_HELP'
WHERE Type = 'POLICY_BRANCH_HONOR';
--==========================================================================================================================
-- POLICIES
--==========================================================================================================================
-- Policies
--------------------------------------------------------------------------------------------------------------------------
--Honor Opener
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_HONOR_HELP', AlwaysSeeBarbCamps = 0
WHERE Type = 'POLICY_HONOR';

--Warrior Code
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_WARRIOR_CODE_HELP'
WHERE Type = 'POLICY_WARRIOR_CODE';

--Discipline
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_DISCIPLINE_HELP'
WHERE Type = 'POLICY_DISCIPLINE';

--Military Caste
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_MILITARY_CASTE_HELP', HappinessPerGarrisonedUnit = 2, GarrisonFreeMaintenance = 1
WHERE Type = 'POLICY_MILITARY_CASTE';

--Military Tradition
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_MILITARY_TRADITION_HELP'
WHERE Type = 'POLICY_MILITARY_TRADITION';

--Professional Army
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_PROFESSIONAL_ARMY_HELP', MilitaryUnitGiftExtraInfluence = 5
WHERE Type = 'POLICY_PROFESSIONAL_ARMY';

--Honor Finisher
UPDATE Policies
SET UnitGoldMaintenanceMod = -25
WHERE Type = 'POLICY_HONOR_FINISHER';
--------------------------------------------------------------------------------------------------------------------------
-- Policy_UnitCombatProductionModifiers
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_UnitCombatProductionModifiers WHERE PolicyType = 'POLICY_WARRIOR_CODE';

INSERT INTO Policy_UnitCombatProductionModifiers 
		(PolicyType, 					UnitCombatType,						ProductionModifier)
VALUES	('POLICY_WARRIOR_CODE', 		'UNITCOMBAT_MELEE',					25),
		('POLICY_WARRIOR_CODE', 		'UNITCOMBAT_RECON',					25),
		('POLICY_WARRIOR_CODE', 		'UNITCOMBAT_ARCHER',				25),
		('POLICY_WARRIOR_CODE', 		'UNITCOMBAT_MOUNTED',				25),
		('POLICY_WARRIOR_CODE', 		'UNITCOMBAT_SIEGE',					25),
		('POLICY_WARRIOR_CODE', 		'UNITCOMBAT_GUN',					25),
		('POLICY_WARRIOR_CODE', 		'UNITCOMBAT_ARMOR',					25),
		('POLICY_WARRIOR_CODE', 		'UNITCOMBAT_HELICOPTER',			25),
		('POLICY_WARRIOR_CODE', 		'UNITCOMBAT_MOUNTED_RANGED',		25),
		('POLICY_WARRIOR_CODE', 		'UNITCOMBAT_AA',					25);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassProductionModifiers
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_BuildingClassProductionModifiers WHERE PolicyType = 'POLICY_PROFESSIONAL_ARMY';

INSERT INTO Policy_BuildingClassProductionModifiers 
		(PolicyType, 					BuildingClassType,					ProductionModifier)
VALUES	('POLICY_PROFESSIONAL_ARMY', 	'BUILDINGCLASS_BARRACKS',			50),
		('POLICY_PROFESSIONAL_ARMY', 	'BUILDINGCLASS_ARMORY',				50),
		('POLICY_PROFESSIONAL_ARMY', 	'BUILDINGCLASS_MILITARY_ACADEMY',	50);
--------------------------------------------------------------------------------------------------------------------------
-- Policy_Flavors
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_Flavors WHERE PolicyType = 'POLICY_PROFESSIONAL_ARMY';

INSERT INTO Policy_Flavors 
		(PolicyType, 					FlavorType,							Flavor)
VALUES	('POLICY_DISCIPLINE', 			'FLAVOR_DEFENSE',					10),
		('POLICY_DISCIPLINE', 			'FLAVOR_MILITARY_TRAINING',			15),
		('POLICY_PROFESSIONAL_ARMY', 	'FLAVOR_GOLD',						5),
		('POLICY_PROFESSIONAL_ARMY', 	'FLAVOR_DIPLOMACY',					5);
--==========================================================================================================================
--==========================================================================================================================