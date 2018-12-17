--==========================================================================================================================	
-- UnitPromotions
--==========================================================================================================================		
INSERT INTO UnitPromotions 
			(Type, 							CityAttack,	Description, 							Help, 										Sound, 				CannotBeChosen, LostWithUpgrade,	PortraitIndex, 	IconAtlas, 				PediaType, 			PediaEntry,							ShowInPedia)
VALUES		('PROMOTION_JFD_DOJO', 			0,			'TXT_KEY_PROMOTION_JFD_DOJO', 			'TXT_KEY_PROMOTION_JFD_DOJO_HELP',			'AS2D_IF_LEVELUP', 	1, 				0,					59, 			'ABILITY_ATLAS', 		'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_DOJO',		0),
			('PROMOTION_JFD_YAMATO', 		100,		'TXT_KEY_PROMOTION_JFD_YAMATO', 		'TXT_KEY_PROMOTION_JFD_YAMATO_HELP',		'AS2D_IF_LEVELUP', 	1, 				1,					59, 			'ABILITY_ATLAS', 		'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_YAMATO',		1),
			('PROMOTION_JFD_SAMURAI', 		0,			'TXT_KEY_PROMOTION_JFD_SAMURAI', 		'TXT_KEY_PROMOTION_JFD_SAMURAI_HELP',		'AS2D_IF_LEVELUP', 	1, 				1,					0, 				'WAY_WARRIOR_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_SAMURAI',	1);
--==========================================================================================================================		
--==========================================================================================================================