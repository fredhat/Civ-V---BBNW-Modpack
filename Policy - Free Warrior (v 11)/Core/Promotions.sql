--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================	
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------
UPDATE UnitPromotions
SET AdjacentMod = 25, Help = 'TXT_KEY_PROMOTION_F0S_DISCIPLINE_HELP'
WHERE Type = 'PROMOTION_ADJACENT_BONUS';
--------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions_UnitCombats
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM UnitPromotions_UnitCombats WHERE PromotionType = 'PROMOTION_ADJACENT_BONUS';

INSERT INTO UnitPromotions_UnitCombats 
		(PromotionType, 					UnitCombatType)
VALUES	('PROMOTION_ADJACENT_BONUS', 		'UNITCOMBAT_MELEE'),
		('PROMOTION_ADJACENT_BONUS', 		'UNITCOMBAT_RECON'),
		('PROMOTION_ADJACENT_BONUS', 		'UNITCOMBAT_MOUNTED'),
		('PROMOTION_ADJACENT_BONUS', 		'UNITCOMBAT_GUN'),
		('PROMOTION_ADJACENT_BONUS', 		'UNITCOMBAT_ARMOR'),
		('PROMOTION_ADJACENT_BONUS', 		'UNITCOMBAT_HELICOPTER');
--==========================================================================================================================	
--==========================================================================================================================