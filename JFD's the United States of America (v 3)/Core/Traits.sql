--==========================================================================================================================	
-- Traits
--==========================================================================================================================	
INSERT INTO Traits 
			(Type, 								Description, 							ShortDescription)
VALUES		('TRAIT_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_TRAIT_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_TRAIT_JFD_AMERICA_ROOSEVELT_SHORT');

UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_JFD_AMERICA_WASHINGTON'
WHERE Type = 'TRAIT_RIVER_EXPANSION';
--==========================================================================================================================	
-- Trait_ImprovementYieldChanges
--==========================================================================================================================	
-- Disabled for balance purposes
/*
INSERT INTO Trait_ImprovementYieldChanges 
			(TraitType, 						ImprovementType,	YieldType,			Yield)
SELECT		('TRAIT_JFD_AMERICA_ROOSEVELT'), 	Type,				('YIELD_CULTURE'),	2
FROM Improvements WHERE CreatedByGreatPerson = 1;

CREATE TRIGGER JFD_ImprovementsYieldChangesAmericaRoosevelt
AFTER INSERT ON Improvements WHEN NEW.CreatedByGreatPerson = 1
BEGIN
	INSERT INTO Trait_ImprovementYieldChanges 
			(TraitType, 						ImprovementType,	YieldType,			Yield)
	VALUES	('TRAIT_JFD_AMERICA_ROOSEVELT', 	NEW.Type,			'YIELD_CULTURE',	2);
END;
*/
--==========================================================================================================================	
-- Trait_FreePromotionUnitCombats
--==========================================================================================================================	
DELETE FROM Trait_FreePromotionUnitCombats WHERE TraitType = 'TRAIT_RIVER_EXPANSION';

INSERT INTO Trait_FreePromotionUnitCombats 
			(TraitType, 				UnitCombatType, 				PromotionType)
VALUES		('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_RECON', 			'PROMOTION_SENTRY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_ARCHER', 			'PROMOTION_SENTRY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_MOUNTED', 			'PROMOTION_SENTRY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_MOUNTED_RANGED', 	'PROMOTION_SENTRY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_MELEE', 			'PROMOTION_SENTRY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_SIEGE', 			'PROMOTION_SENTRY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_GUN', 				'PROMOTION_SENTRY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_ARMOR', 			'PROMOTION_SENTRY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_HELICOPTER', 		'PROMOTION_SENTRY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_AA', 				'PROMOTION_SENTRY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_RECON', 			'PROMOTION_MOBILITY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_CIVILIAN', 			'PROMOTION_MOBILITY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_GREAT_PEOPLE', 		'PROMOTION_MOBILITY'),
			('TRAIT_RIVER_EXPANSION', 	'UNITCOMBAT_RELIGIOUS', 		'PROMOTION_MOBILITY');
--==========================================================================================================================	
--==========================================================================================================================