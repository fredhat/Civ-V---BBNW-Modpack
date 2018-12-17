--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================	
INSERT INTO UnitPromotions 
			(Type, 									Description, 								Help, 												Sound, 				CannotBeChosen, LostWithUpgrade,	AlwaysHeal, PortraitIndex,	IconAtlas, 			PediaType, 			PediaEntry,								ShowInPedia)
VALUES		('PROMOTION_JFD_CHASSEUR_INFO', 		'TXT_KEY_PROMOTION_JFD_CHASSEUR_INFO',		'TXT_KEY_PROMOTION_JFD_CHASSEUR_INFO_HELP', 		'AS2D_IF_LEVELUP', 	1, 				1, 					0, 			59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_CHASSEUR_INFO',	1),
			('PROMOTION_JFD_CHASSEUR_MARCH', 		'TXT_KEY_PROMOTION_JFD_CHASSEUR_MARCH',		'TXT_KEY_PROMOTION_JFD_CHASSEUR_MARCH_HELP', 		'AS2D_IF_LEVELUP', 	1, 				1, 					1, 			31, 			'PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_CHASSEUR_MARCH',	0);
--==========================================================================================================================
--==========================================================================================================================