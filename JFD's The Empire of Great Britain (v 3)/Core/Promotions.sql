--==========================================================================================================================	
-- UnitPromotions
--==========================================================================================================================	
INSERT OR REPLACE INTO UnitPromotions 
			(Type, 											HealOutsideFriendly,	Description, 											Help, 														Sound, 				CannotBeChosen, PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry,											ShowInPedia)
VALUES		('PROMOTION_JFD_REDCOAT_GARRISON', 				0,						'TXT_KEY_PROMOTION_JFD_REDCOAT_GARRISON',				'TXT_KEY_PROMOTION_JFD_REDCOAT_GARRISON_HELP',				'AS2D_IF_LEVELUP', 	1, 				59, 			'PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_REDCOAT_GARRISON',			1),
			('PROMOTION_JFD_GRAND_CARRACK_HEAL', 			1,						'TXT_KEY_PROMOTION_JFD_GRAND_CARRACK_HEAL',				'TXT_KEY_PROMOTION_JFD_GRAND_CARRACK_HEAL_HELP',			'AS2D_IF_LEVELUP', 	1, 				59, 			'PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_GRAND_CARRACK_HEAL',			0),
			('PROMOTION_JFD_GRAND_CARRACK_HEAL_INFO', 		0,						'TXT_KEY_PROMOTION_JFD_GRAND_CARRACK_HEAL_INFO',		'TXT_KEY_PROMOTION_JFD_GRAND_CARRACK_HEAL_INFO_HELP',		'AS2D_IF_LEVELUP', 	1, 				59, 			'PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_GRAND_CARRACK_HEAL_INFO',	1);
--==========================================================================================================================		
--==========================================================================================================================