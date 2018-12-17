--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================
INSERT INTO UnitPromotions 
			(Type, 										Description, 									Help, 												Sound, 				CannotBeChosen, DefenseMod, 	HPHealedIfDestroyEnemy, LostWithUpgrade,	PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry,										ShowInPedia)
VALUES		('PROMOTION_JFD_PAPAL_STATES', 				'TXT_KEY_PROMOTION_PAPAL_STATES', 				'TXT_KEY_PROMOTION_PAPAL_STATES_HELP', 				'AS2D_IF_LEVELUP', 	1, 				0, 				0, 						0,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_PAPAL_STATES',				0),
			('PROMOTION_JFD_SWISS_GUARD', 				'TXT_KEY_PROMOTION_SWISS_GUARD', 				'TXT_KEY_PROMOTION_SWISS_GUARD_HELP', 				'AS2D_IF_LEVELUP', 	1, 				25, 			0, 						0,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_SWISS_GUARD',				1),
			('PROMOTION_JFD_SWISS_GUARD_TOURISM', 		'TXT_KEY_PROMOTION_SWISS_GUARD_TOURISM', 		'TXT_KEY_PROMOTION_SWISS_GUARD_TOURISM_HELP', 		'AS2D_IF_LEVELUP', 	1, 				0, 				0, 						1,					58, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_SWISS_GUARD_TOURISM',		1),
			('PROMOTION_JFD_SWISS_GUARD_HEALING', 		'TXT_KEY_PROMOTION_SWISS_GUARD_HEALING', 		'TXT_KEY_PROMOTION_SWISS_GUARD_HEALING_HELP', 		'AS2D_IF_LEVELUP', 	1, 				0, 				50, 					1,					32, 			'PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_SWISS_GUARD_HEALING',		0),
			('PROMOTION_JFD_SWISS_GUARD_HEALING_INFO', 	'TXT_KEY_PROMOTION_SWISS_GUARD_HEALING_INFO', 	'TXT_KEY_PROMOTION_SWISS_GUARD_HEALING_INFO_HELP', 	'AS2D_IF_LEVELUP', 	1, 				0, 				0, 						1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_SWISS_GUARD_HEALING_INFO',	1);
--==========================================================================================================================
--==========================================================================================================================