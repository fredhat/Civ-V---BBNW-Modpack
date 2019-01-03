--==========================================================================================================================	
-- Traits
--==========================================================================================================================	
INSERT INTO Traits 
			(Type, 							Description, 							ShortDescription,							FreeBuilding,					FreeUnit,					FreeUnitPrereqTech)
VALUES		('TRAIT_JFD_DENMARK_NORWAY', 	'TXT_KEY_TRAIT_JFD_DENMARK_NORWAY', 	'TXT_KEY_TRAIT_JFD_DENMARK_NORWAY_SHORT',	'BUILDING_JFD_DENMARK_NORWAY',	'UNITCLASS_GREAT_ADMIRAL',	'TECH_SAILING');

UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_JFD_VIKING_FURY', ExtraEmbarkMoves = 2
WHERE Type = 'TRAIT_VIKING_FURY';

UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_JFD_AMPHIB_WARLORD', ShortDescription = 'TXT_KEY_TRAIT_JFD_AMPHIB_WARLORD_SHORT'
WHERE Type = 'TRAIT_AMPHIB_WARLORD';
--==========================================================================================================================	
-- Trait_FreePromotionUnitCombats
--==========================================================================================================================	
DELETE FROM Trait_FreePromotionUnitCombats WHERE TraitType = 'TRAIT_AMPHIB_WARLORD';

INSERT INTO Trait_FreePromotionUnitCombats 
			(TraitType, 					UnitCombatType,						PromotionType)
VALUES		('TRAIT_VIKING_FURY', 			'UNITCOMBAT_GUN',					'PROMOTION_FREE_PILLAGE_MOVES'),
			('TRAIT_VIKING_FURY', 			'UNITCOMBAT_MELEE',					'PROMOTION_AMPHIBIOUS'),
			('TRAIT_VIKING_FURY', 			'UNITCOMBAT_GUN',					'PROMOTION_AMPHIBIOUS');
--==========================================================================================================================	
--==========================================================================================================================