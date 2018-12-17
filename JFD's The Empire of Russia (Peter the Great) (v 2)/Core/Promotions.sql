--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================	
INSERT INTO UnitPromotions 
			(Type, 									Description, 									Help, 												Sound, 				IgnoreZoC,	EnemyHealChange,	NeutralHealChange,	FriendlyHealChange,	CannotBeChosen, LostWithUpgrade,	PortraitIndex,	IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_JFD_TWO_DECKER', 			'TXT_KEY_PROMOTION_JFD_TWO_DECKER',				'TXT_KEY_PROMOTION_JFD_TWO_DECKER_HELP', 			'AS2D_IF_LEVELUP', 	0,			0,					0,					0,					1, 				1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_TWO_DECKER'),
			('PROMOTION_JFD_SECOND_HAND_INFO', 		'TXT_KEY_PROMOTION_JFD_SECOND_HAND_INFO',		'TXT_KEY_PROMOTION_JFD_SECOND_HAND_INFO_HELP', 		'AS2D_IF_LEVELUP', 	0,			0,					0,					0,					1, 				1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_SECOND_HAND_INFO'),
			('PROMOTION_JFD_BANYA', 				'TXT_KEY_PROMOTION_JFD_BANYA',					'TXT_KEY_PROMOTION_JFD_BANYA_HELP', 				'AS2D_IF_LEVELUP', 	0,			10,					10,					10,					1, 				0,					32, 			'PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_BANYA'),
			('PROMOTION_JFD_COSSACK', 				'TXT_KEY_PROMOTION_JFD_COSSACK',				'TXT_KEY_PROMOTION_JFD_COSSACK_HELP', 				'AS2D_IF_LEVELUP', 	1,			0,					0,					0,					1, 				0,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_SECOND_HAND_INFO');
--------------------------------	
-- UnitPromotions_UnitCombatMods
--------------------------------	
INSERT INTO UnitPromotions_Domains
			(PromotionType, 				DomainType, 	Modifier)
VALUES		('PROMOTION_JFD_TWO_DECKER', 	'DOMAIN_LAND', 	25);
--==========================================================================================================================
--==========================================================================================================================