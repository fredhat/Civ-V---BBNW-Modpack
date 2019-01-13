--==========================================================================================================================
-- UnitCombatInfos
--==========================================================================================================================	
-- UnitCombatInfos
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitCombatInfos 
		(Type, 							Description)
VALUES	('UNITCOMBAT_AA', 				'TXT_KEY_UNITCOMBAT_AA'),
		('UNITCOMBAT_MOUNTED_RANGED', 	'TXT_KEY_UNITCOMBAT_MOUNTED_RANGED');
--==========================================================================================================================
-- Units
--==========================================================================================================================	
-- Units
--------------------------------------------------------------------------------------------------------------------------
UPDATE Units
SET Combat = 45, RangedCombat = 55, CombatClass = 'UNITCOMBAT_AA', Help = 'TXT_KEY_UNIT_F0S_ANTI_AIRCRAFT_HELP', Strategy = 'TXT_KEY_UNIT_F0S_ANTI_AIRCRAFT_STRATEGY'
WHERE Type = 'UNIT_ANTI_AIRCRAFT_GUN';

UPDATE Units
SET Combat = 60, RangedCombat = 70, CombatClass = 'UNITCOMBAT_AA', Help = 'TXT_KEY_UNIT_F0S_MOBILE_SAM_HELP', Strategy = 'TXT_KEY_UNIT_F0S_MOBILE_SAM_STRATEGY'
WHERE Type = 'UNIT_MOBILE_SAM';

UPDATE Units
SET CombatClass = 'UNITCOMBAT_MOUNTED_RANGED', Help = 'TXT_KEY_UNIT_F0S_CHARIOT_ARCHER_HELP', Strategy = 'TXT_KEY_UNIT_F0S_CHARIOT_ARCHER_STRATEGY'
WHERE Type = 'UNIT_CHARIOT_ARCHER';
--------------------------------------------------------------------------------------------------------------------------
-- Unit_FreePromotions
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_ANTI_AIRCRAFT_GUN' AND PromotionType = 'PROMOTION_INTERCEPTION_IV';

INSERT INTO Unit_FreePromotions 
		(UnitType, 						PromotionType)
VALUES	('UNIT_ANTI_AIRCRAFT_GUN', 		'PROMOTION_ONLY_DEFENSIVE'),
		('UNIT_ANTI_AIRCRAFT_GUN', 		'PROMOTION_INTERCEPTION_III');

DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_MOBILE_SAM' AND PromotionType = 'PROMOTION_INTERCEPTION_IV';

INSERT INTO Unit_FreePromotions 
		(UnitType, 						PromotionType)
VALUES	('UNIT_MOBILE_SAM', 			'PROMOTION_ONLY_DEFENSIVE'),
		('UNIT_MOBILE_SAM', 			'PROMOTION_INTERCEPTION_III'),
		('UNIT_MOBILE_SAM', 			'PROMOTION_INDIRECT_FIRE');
--------------------------------------------------------------------------------------------------------------------------
-- Unit_AITypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_AITypes 
		(UnitType, 						UnitAIType)
VALUES	('UNIT_ANTI_AIRCRAFT_GUN', 		'UNITAI_DEFENSE'),
		('UNIT_ANTI_AIRCRAFT_GUN', 		'UNITAI_RANGED'),
		('UNIT_MOBILE_SAM', 			'UNITAI_DEFENSE'),
		('UNIT_MOBILE_SAM', 			'UNITAI_RANGED');
--------------------------------------------------------------------------------------------------------------------------
-- Unit_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Unit_Flavors 
		(UnitType, 						FlavorType,				Flavor)
VALUES	('UNIT_ANTI_AIRCRAFT_GUN', 		'FLAVOR_OFFENSE',		4),
		('UNIT_ANTI_AIRCRAFT_GUN', 		'FLAVOR_RANGED',		12),
		('UNIT_MOBILE_SAM', 			'FLAVOR_OFFENSE',		4),
		('UNIT_MOBILE_SAM', 			'FLAVOR_RANGED',		12);
--==========================================================================================================================	
--==========================================================================================================================