--==========================================================================================================================
-- Traits
--==========================================================================================================================		
UPDATE Traits
SET FaithFromUnimprovedForest = 0
WHERE Type = 'TRAIT_FAITH_FROM_NATURE';

UPDATE Traits
SET GoldenAgeGreatArtistRateModifier = 100, GoldenAgeGreatMusicianRateModifier = 100, GoldenAgeGreatWriterRateModifier = 100
WHERE Type = 'TRAIT_CARNIVAL';

UPDATE Traits
SET LandTradeRouteRangeBonus = 10
WHERE Type = 'TRAIT_LAND_TRADE_GOLD';

UPDATE Traits
SET CombatBonusVsLargerCiv = 25
WHERE Type = 'TRAIT_BONUS_AGAINST_TECH';

UPDATE Traits
SET CityStateCombatModifier = 0
WHERE Type = 'TRAIT_TERROR';

UPDATE Traits
SET GoldenAgeCombatModifier = 20
WHERE Type = 'TRAIT_ENHANCED_GOLDEN_AGES';

UPDATE Traits
SET CityStateBonusModifier = 100
WHERE Type = 'TRAIT_CITY_STATE_BONUSES';

UPDATE Traits
SET EmbarkedAllWater = 1
WHERE Type = 'TRAIT_SPICE';

UPDATE Traits
SET LandBarbarianConversionPercent = 50
WHERE Type = 'TRAIT_CULTURE_FROM_KILLS';

UPDATE Traits
SET FreeUnitPrereqTech = 'TECH_PHILOSOPHY'
WHERE Type = 'TRAIT_INGENIOUS';

UPDATE Traits
SET FreeUnit = 'UNITCLASS_WRITER', FreeUnitPrereqTech = 'TECH_WRITING'
WHERE Type = 'TRAIT_SLAYER_OF_TIAMAT';
--==========================================================================================================================	
-- Trait_ImprovementYieldChanges
--==========================================================================================================================
DELETE FROM Trait_ImprovementYieldChanges WHERE TraitType = 'TRAIT_SCHOLARS_JADE_HALL' AND ImprovementType = 'IMPROVEMENT_CUSTOMS_HOUSE';
DELETE FROM Trait_ImprovementYieldChanges WHERE TraitType = 'TRAIT_SCHOLARS_JADE_HALL' AND ImprovementType = 'IMPROVEMENT_MANUFACTORY';
DELETE FROM Trait_ImprovementYieldChanges WHERE TraitType = 'TRAIT_SCHOLARS_JADE_HALL' AND ImprovementType = 'IMPROVEMENT_CITADEL';
DELETE FROM Trait_ImprovementYieldChanges WHERE TraitType = 'TRAIT_SCHOLARS_JADE_HALL' AND ImprovementType = 'IMPROVEMENT_LANDMARK';
DELETE FROM Trait_ImprovementYieldChanges WHERE TraitType = 'TRAIT_SCHOLARS_JADE_HALL' AND ImprovementType = 'IMPROVEMENT_HOLY_SITE';
--==========================================================================================================================	
-- Trait_SpecialistYieldChanges
--==========================================================================================================================
DELETE FROM Trait_SpecialistYieldChanges WHERE TraitType = 'TRAIT_SCHOLARS_JADE_HALL' AND SpecialistType = 'SPECIALIST_ARTIST';
DELETE FROM Trait_SpecialistYieldChanges WHERE TraitType = 'TRAIT_SCHOLARS_JADE_HALL' AND SpecialistType = 'SPECIALIST_MERCHANT';
DELETE FROM Trait_SpecialistYieldChanges WHERE TraitType = 'TRAIT_SCHOLARS_JADE_HALL' AND SpecialistType = 'SPECIALIST_ENGINEER';
DELETE FROM Trait_SpecialistYieldChanges WHERE TraitType = 'TRAIT_SCHOLARS_JADE_HALL' AND SpecialistType = 'SPECIALIST_WRITER';
DELETE FROM Trait_SpecialistYieldChanges WHERE TraitType = 'TRAIT_SCHOLARS_JADE_HALL' AND SpecialistType = 'SPECIALIST_MUSICIAN';
--==========================================================================================================================	
-- Trait_YieldChangesPerTradePartner
--==========================================================================================================================
UPDATE Trait_YieldChangesPerTradePartner
SET Yield = 2
WHERE TraitType = 'TRAIT_GATEWAY_AFRICA' AND YieldType = 'YIELD_GOLD';
--==========================================================================================================================	
-- Trait_MovesChangeUnitCombats
--==========================================================================================================================
INSERT INTO Trait_MovesChangeUnitCombats 	
			(TraitType, 		UnitCombatType,					MovesChange)
VALUES		('TRAIT_TERROR', 	'UNITCOMBAT_MOUNTED_RANGED',	1);
--==========================================================================================================================	
-- Trait_FreePromotionUnitCombats
--==========================================================================================================================
INSERT INTO Trait_FreePromotionUnitCombats 	
			(TraitType, 					UnitCombatType,					PromotionType)
VALUES		('TRAIT_TERROR', 				'UNITCOMBAT_MOUNTED', 			'PROMOTION_FOREIGN_LANDS'),
			('TRAIT_TERROR', 				'UNITCOMBAT_MOUNTED_RANGED', 	'PROMOTION_FOREIGN_LANDS'),
			('TRAIT_FAITH_FROM_NATURE', 	'UNITCOMBAT_MELEE', 			'PROMOTION_STRENGTH_FROM_FAITH_INFO'),
			('TRAIT_FAITH_FROM_NATURE', 	'UNITCOMBAT_GUN', 				'PROMOTION_STRENGTH_FROM_FAITH_INFO'),
			('TRAIT_FAITH_FROM_NATURE', 	'UNITCOMBAT_RECON', 			'PROMOTION_STRENGTH_FROM_FAITH_INFO'),
			('TRAIT_FAITH_FROM_NATURE', 	'UNITCOMBAT_MOUNTED', 			'PROMOTION_STRENGTH_FROM_FAITH_INFO'),
			('TRAIT_FAITH_FROM_NATURE', 	'UNITCOMBAT_ARMOR', 			'PROMOTION_STRENGTH_FROM_FAITH_INFO'),
			('TRAIT_FAITH_FROM_NATURE', 	'UNITCOMBAT_HELICOPTER', 		'PROMOTION_STRENGTH_FROM_FAITH_INFO');
--==========================================================================================================================	
-- Trait_ResourceQuantityModifiers
--==========================================================================================================================
INSERT INTO Trait_ResourceQuantityModifiers 	
			(TraitType, 		ResourceType,		ResourceQuantityModifier)
VALUES		('TRAIT_TERROR', 	'RESOURCE_HORSE',	100);
--==========================================================================================================================	
--==========================================================================================================================