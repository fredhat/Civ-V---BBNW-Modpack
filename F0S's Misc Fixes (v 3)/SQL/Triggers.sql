-- Give all cannon units PROMOTION_BATTERY_INFO
INSERT INTO Unit_FreePromotions
		(UnitType, 	PromotionType)
SELECT	Type, 		('PROMOTION_BATTERY_INFO')
FROM Units WHERE Class = 'UNITCLASS_CANNON';
	
-- Update any additional recon units to have PROMOTION_BATTERY_INFO as well
CREATE TRIGGER FreeBattery
AFTER INSERT ON Units
WHEN 'UNITCLASS_CANNON' = NEW.Class
BEGIN
	INSERT INTO Unit_FreePromotions
			(UnitType, PromotionType)
	VALUES	(NEW.Type, 'PROMOTION_BATTERY_INFO');
END;

-- Give all naval melee units PROMOTION_NO_CAPTURE
INSERT INTO Unit_FreePromotions
		(UnitType, 	PromotionType)
SELECT	Type, 		('PROMOTION_NO_CAPTURE')
FROM Units WHERE CombatClass = 'UNITCOMBAT_NAVALMELEE' AND NOT Type = 'UNIT_CHOLA_THALAI_THIRVAI';
	
-- Update any additional naval melee units to have PROMOTION_NO_CAPTURE as well
CREATE TRIGGER NoCityCapture
AFTER INSERT ON Units
WHEN 'UNITCOMBAT_NAVALMELEE' = NEW.CombatClass AND NOT 'UNIT_CHOLA_THALAI_THIRVAI' = NEW.Type
BEGIN
	INSERT INTO Unit_FreePromotions
			(UnitType, PromotionType)
	VALUES	(NEW.Type, 'PROMOTION_NO_CAPTURE');
END;

-- Give all mounted ranged units all ranged promotions
INSERT INTO UnitPromotions_UnitCombats
		(PromotionType, UnitCombatType)
SELECT	PromotionType, 	('UNITCOMBAT_MOUNTED_RANGED')
FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_ARCHER';
	
-- Update mounted ranged units to have any additional ranged promotions
CREATE TRIGGER MountedRangedPromotions
AFTER INSERT ON UnitPromotions_UnitCombats
WHEN 'UNITCOMBAT_ARCHER' = NEW.UnitCombatType
BEGIN
	INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,		UnitCombatType)
	VALUES	(NEW.PromotionType,	'UNITCOMBAT_MOUNTED_RANGED');
END;

-- Give all aa units all ranged promotions
INSERT INTO UnitPromotions_UnitCombats
		(PromotionType, UnitCombatType)
SELECT	PromotionType,	('UNITCOMBAT_AA')
FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_ARCHER';
	
-- Update aa units to have any additional ranged promotions
CREATE TRIGGER AAPromotions
AFTER INSERT ON UnitPromotions_UnitCombats
WHEN 'UNITCOMBAT_ARCHER' = NEW.UnitCombatType
BEGIN
	INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,		UnitCombatType)
	VALUES	(NEW.PromotionType,	'UNITCOMBAT_AA');
END;