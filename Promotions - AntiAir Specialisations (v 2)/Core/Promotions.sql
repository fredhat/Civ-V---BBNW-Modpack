--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================	
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions 
		(Type, 							Description,							Help,										Sound,				OrderPriority,	NumInterceptionChange,	InterceptChanceChange,	PromotionPrereqOr1,			PromotionPrereqOr2,		PortraitIndex,	IconAtlas,			PediaType,		PediaEntry)
VALUES	('PROMOTION_AA_INTERCEPT_1',	'TXT_KEY_PROMOTION_AA_INTERCEPT_1',		'TXT_KEY_PROMOTION_AA_INTERCEPT_1_HELP',	'AS2D_IF_LEVELUP',	1,				0,						25,						null,						null,					27,				'PROMOTION_ATLAS',	'PEDIA_AIR',	'TXT_KEY_PROMOTION_AA_INTERCEPT_1'),
		('PROMOTION_AA_INTERCEPT_2',	'TXT_KEY_PROMOTION_AA_INTERCEPT_2',		'TXT_KEY_PROMOTION_AA_INTERCEPT_2_HELP',	'AS2D_IF_LEVELUP',	1,				0,						25,						'PROMOTION_AA_INTERCEPT_1',	null,					29,				'PROMOTION_ATLAS',	'PEDIA_AIR',	'TXT_KEY_PROMOTION_AA_INTERCEPT_2'),
		('PROMOTION_AA_FLAK_1',			'TXT_KEY_PROMOTION_AA_FLAK_1',			'TXT_KEY_PROMOTION_AA_FLAK_1_HELP',			'AS2D_IF_LEVELUP',	1,				0,						0,						null,						null,					3,				'PROMOTION_ATLAS',	'PEDIA_AIR',	'TXT_KEY_PROMOTION_AA_FLAK_1'),
		('PROMOTION_AA_FLAK_2',			'TXT_KEY_PROMOTION_AA_FLAK_2',			'TXT_KEY_PROMOTION_AA_FLAK_2_HELP',			'AS2D_IF_LEVELUP',	1,				0,						0,						'PROMOTION_AA_FLAK_1',		null,					4,				'PROMOTION_ATLAS',	'PEDIA_AIR',	'TXT_KEY_PROMOTION_AA_FLAK_2'),
		('PROMOTION_AA_RAPID_FIRE',		'TXT_KEY_PROMOTION_AA_RAPID_FIRE',		'TXT_KEY_PROMOTION_AA_RAPID_FIRE_HELP',		'AS2D_IF_LEVELUP',	6,				1,						0,						'PROMOTION_AA_INTERCEPT_2',	'PROMOTION_AA_FLAK_2',	47,				'PROMOTION_ATLAS',	'PEDIA_AIR',	'TXT_KEY_PROMOTION_AA_RAPID_FIRE');

UPDATE UnitPromotions
SET PromotionPrereqOr5 = 'PROMOTION_AA_INTERCEPT_1', PromotionPrereqOr6 = 'PROMOTION_AA_FLAK_1'
WHERE Type = 'PROMOTION_COVER_1';

UPDATE UnitPromotions
SET PromotionPrereqOr3 = 'PROMOTION_AA_INTERCEPT_2', PromotionPrereqOr4 = 'PROMOTION_AA_FLAK_2'
WHERE Type = 'PROMOTION_REPAIR';
--------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions_UnitCombatMods
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions_UnitCombatMods 
		(PromotionType, 				UnitCombatType,				Modifier)
VALUES	('PROMOTION_AA_FLAK_1', 		'UNITCOMBAT_HELICOPTER',	50),
		('PROMOTION_AA_FLAK_2', 		'UNITCOMBAT_HELICOPTER',	50);
--------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions_Domains
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions_Domains 
		(PromotionType, 				DomainType,					Modifier)
VALUES	('PROMOTION_AA_FLAK_1', 		'DOMAIN_AIR',				50),
		('PROMOTION_AA_FLAK_2', 		'DOMAIN_AIR',				50);
--------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions_UnitCombats
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions_UnitCombats 
		(PromotionType, 				UnitCombatType)
VALUES	('PROMOTION_AA_INTERCEPT_1', 	'UNITCOMBAT_AA'),
		('PROMOTION_AA_INTERCEPT_2', 	'UNITCOMBAT_AA'),
		('PROMOTION_AA_FLAK_1', 		'UNITCOMBAT_AA'),
		('PROMOTION_AA_FLAK_2', 		'UNITCOMBAT_AA'),
		('PROMOTION_COVER_1', 			'UNITCOMBAT_AA'),
		('PROMOTION_COVER_2', 			'UNITCOMBAT_AA'),
		('PROMOTION_REPAIR', 			'UNITCOMBAT_AA'),
		('PROMOTION_AA_RAPID_FIRE', 	'UNITCOMBAT_AA');
--==========================================================================================================================	
--==========================================================================================================================