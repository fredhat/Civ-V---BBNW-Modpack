--==========================================================================================================================	
-- Traits
--==========================================================================================================================	
INSERT OR REPLACE INTO Traits 
			(Type, 								Description, 							ShortDescription,								CrossesMountainsAfterGreatGeneral)
VALUES		('TRAIT_JFD_CARTHAGE_HANNIBAL', 	'TXT_KEY_TRAIT_JFD_CARTHAGE_HANNIBAL', 	'TXT_KEY_TRAIT_JFD_CARTHAGE_HANNIBAL_SHORT',	1),
			('TRAIT_JFD_CARTHAGE_DIDO', 		'TXT_KEY_TRAIT_JFD_CARTHAGE_DIDO', 		'TXT_KEY_TRAIT_JFD_CARTHAGE_DIDO_SHORT',		0);

INSERT OR REPLACE INTO Trait_FreePromotionUnitCombats
			(TraitType,							UnitCombatType, 				PromotionType)
VALUES		('TRAIT_JFD_CARTHAGE_HANNIBAL',		'UNITCOMBAT_RECON',				'PROMOTION_JFD_HUNDRED_AND_FOUR'),
			('TRAIT_JFD_CARTHAGE_HANNIBAL',		'UNITCOMBAT_ARCHER',			'PROMOTION_JFD_HUNDRED_AND_FOUR'),
			('TRAIT_JFD_CARTHAGE_HANNIBAL',		'UNITCOMBAT_MELEE',				'PROMOTION_JFD_HUNDRED_AND_FOUR'),
			('TRAIT_JFD_CARTHAGE_HANNIBAL',		'UNITCOMBAT_GUN',				'PROMOTION_JFD_HUNDRED_AND_FOUR'),
			('TRAIT_JFD_CARTHAGE_HANNIBAL',		'UNITCOMBAT_MOUNTED',			'PROMOTION_JFD_HUNDRED_AND_FOUR'),
			('TRAIT_JFD_CARTHAGE_HANNIBAL',		'UNITCOMBAT_MOUNTED_RANGED',	'PROMOTION_JFD_HUNDRED_AND_FOUR'),
			('TRAIT_JFD_CARTHAGE_HANNIBAL',		'UNITCOMBAT_ARMOR',				'PROMOTION_JFD_HUNDRED_AND_FOUR'),
			('TRAIT_JFD_CARTHAGE_HANNIBAL',		'UNITCOMBAT_HELICOPTER',		'PROMOTION_JFD_HUNDRED_AND_FOUR'),
			('TRAIT_JFD_CARTHAGE_HANNIBAL',		'UNITCOMBAT_AA',				'PROMOTION_JFD_HUNDRED_AND_FOUR');

INSERT OR REPLACE INTO Trait_FreePromotionUnitCombats
			(TraitType,							UnitCombatType, 				PromotionType)
VALUES		('TRAIT_JFD_CARTHAGE_DIDO',			'UNITCOMBAT_NAVALMELEE',		'PROMOTION_JFD_COTHON'),
			('TRAIT_JFD_CARTHAGE_DIDO',			'UNITCOMBAT_NAVALRANGED',		'PROMOTION_JFD_COTHON'),
			('TRAIT_JFD_CARTHAGE_DIDO',			'UNITCOMBAT_SUBMARINE',			'PROMOTION_JFD_COTHON'),
			('TRAIT_JFD_CARTHAGE_DIDO',			'UNITCOMBAT_CARRIER',			'PROMOTION_JFD_COTHON');
--==========================================================================================================================	
--==========================================================================================================================