--==========================================================================================================================	
-- Traits
--==========================================================================================================================
INSERT OR REPLACE INTO Traits 
			(Type, 						JFD_EnhancedGoldenAgeFromAdmirals,	ExtraEmbarkMoves,	Description, 						ShortDescription)
VALUES		('TRAIT_JFD_ENGLAND', 		1,									2,					'TXT_KEY_TRAIT_JFD_ENGLAND',		'TXT_KEY_TRAIT_JFD_ENGLAND_SHORT');

INSERT OR REPLACE INTO Trait_FreePromotionUnitCombats
			(TraitType, 			UnitCombatType,				PromotionType)
VALUES		('TRAIT_JFD_ENGLAND', 	'UNITCOMBAT_NAVALMELEE',	'PROMOTION_OCEAN_MOVEMENT'),
			('TRAIT_JFD_ENGLAND', 	'UNITCOMBAT_NAVALRANGED',	'PROMOTION_OCEAN_MOVEMENT'),
			('TRAIT_JFD_ENGLAND', 	'UNITCOMBAT_SUBMARINE',		'PROMOTION_OCEAN_MOVEMENT'),
			('TRAIT_JFD_ENGLAND', 	'UNITCOMBAT_CARRIER',		'PROMOTION_OCEAN_MOVEMENT');
--==========================================================================================================================	
--==========================================================================================================================


