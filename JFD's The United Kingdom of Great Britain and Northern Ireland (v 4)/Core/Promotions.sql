--==========================================================================================================================	
-- UnitPromotions
--==========================================================================================================================		
INSERT INTO UnitPromotions 
			(Type, 							IgnoreZoC, 	FriendlyLandsModifier, 	Description, 							Help, 										Sound, 				CannotBeChosen, LostWithUpgrade,	PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_JFD_RAF', 			0,			50,						'TXT_KEY_PROMOTION_JFD_RAF', 			'TXT_KEY_PROMOTION_JFD_RAF_HELP',			'AS2D_IF_LEVELUP', 	1, 				1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_RAF'),
			('PROMOTION_JFD_DREADNOUGHT', 	1,			0,						'TXT_KEY_PROMOTION_JFD_DREADNOUGHT', 	'TXT_KEY_PROMOTION_JFD_DREADNOUGHT_HELP',	'AS2D_IF_LEVELUP', 	1, 				0,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_DREADNOUGHT');
--==========================================================================================================================		
--==========================================================================================================================