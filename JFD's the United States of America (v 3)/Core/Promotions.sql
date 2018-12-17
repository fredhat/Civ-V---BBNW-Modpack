--==========================================================================================================================	
-- UnitPromotions
--==========================================================================================================================		
INSERT INTO UnitPromotions 
			(Type, 							EmbarkDefenseModifier, 	Description, 							Help, 										Sound, 				CannotBeChosen, PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_JFD_ARMS_FACTORY', 	50,						'TXT_KEY_PROMOTION_JFD_ARMS_FACTORY', 	'TXT_KEY_PROMOTION_JFD_ARMS_FACTORY_HELP',	'AS2D_IF_LEVELUP', 	1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_ARMS_FACTORY');
--==========================================================================================================================	
-- UnitPromotions_UnitCombats
--==========================================================================================================================	
INSERT INTO UnitPromotions_UnitCombats
			(PromotionType,					UnitCombatType)
VALUES		('PROMOTION_JFD_ARMS_FACTORY',	'UNITCOMBAT_ARMOR'),
			('PROMOTION_JFD_ARMS_FACTORY',	'UNITCOMBAT_SIEGE');
--==========================================================================================================================		
--==========================================================================================================================