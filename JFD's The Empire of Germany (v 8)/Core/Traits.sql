--==========================================================================================================================
-- Traits
--==========================================================================================================================	
INSERT INTO Traits 
			(Type, 								Description, 								ShortDescription)
VALUES		('TRAIT_JFD_GERMANY', 				'TXT_KEY_TRAIT_JFD_GERMANY', 				'TXT_KEY_TRAIT_JFD_GERMANY_SHORT'),
			('TRAIT_JFD_BISMARCKIAN_GERMANY', 	'TXT_KEY_TRAIT_JFD_BISMARCKIAN_GERMANY', 	'TXT_KEY_TRAIT_JFD_BISMARCKIAN_GERMANY_SHORT');	
--==========================================================================================================================
-- Trait_FreePromotionUnitCombats
--==========================================================================================================================	
INSERT INTO Trait_FreePromotionUnitCombats 
			(TraitType, 			UnitCombatType, 			PromotionType)
VALUES		('TRAIT_JFD_GERMANY', 	'UNITCOMBAT_MELEE', 		'PROMOTION_SPAWN_GENERALS_II'),
			('TRAIT_JFD_GERMANY', 	'UNITCOMBAT_RECON', 		'PROMOTION_SPAWN_GENERALS_II'),
			('TRAIT_JFD_GERMANY', 	'UNITCOMBAT_MOUNTED', 		'PROMOTION_SPAWN_GENERALS_II'),
			('TRAIT_JFD_GERMANY', 	'UNITCOMBAT_GUN', 			'PROMOTION_SPAWN_GENERALS_II'),
			('TRAIT_JFD_GERMANY', 	'UNITCOMBAT_HELICOPTER',	'PROMOTION_SPAWN_GENERALS_II'),
			('TRAIT_JFD_GERMANY', 	'UNITCOMBAT_ARMOR', 		'PROMOTION_SPAWN_GENERALS_II');
--==========================================================================================================================	
--==========================================================================================================================