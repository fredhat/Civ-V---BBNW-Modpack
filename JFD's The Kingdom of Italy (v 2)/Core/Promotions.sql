--==========================================================================================================================	
-- UnitPromotions
--==========================================================================================================================		
INSERT INTO UnitPromotions 
			(Type, 									Description, 									Help, 												Sound, 				CannotBeChosen, PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_JFD_CARABINEIRI', 			'TXT_KEY_PROMOTION_JFD_CARABINEIRI', 			'TXT_KEY_PROMOTION_JFD_CARABINEIRI_HELP',			'AS2D_IF_LEVELUP', 	1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_CARABINEIRI'),
			('PROMOTION_JFD_CARABINEIRI_POLICING', 	'TXT_KEY_PROMOTION_JFD_CARABINEIRI_POLICING', 	'TXT_KEY_PROMOTION_JFD_CARABINEIRI_POLICING_HELP',	'AS2D_IF_LEVELUP', 	1, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_CARABINEIRI_POLICING');
--==========================================================================================================================	
-- UnitPromotions_UnitCombatMods
--==========================================================================================================================		
INSERT INTO UnitPromotions_UnitCombatMods
			(PromotionType,					UnitCombatType,		Modifier)
VALUES		('PROMOTION_JFD_CARABINEIRI',	'UNITCOMBAT_GUN',	33);
--==========================================================================================================================		
--==========================================================================================================================