--==========================================================================================================================	
-- UNIT PROMOTIONS
--==========================================================================================================================	
-- UnitPromotions
-----------------------------------------------------------------------------------------------------	
INSERT INTO UnitPromotions 						
		(Type, 							Description, 							Help, 										Sound, 				ExperiencePercent,	UpgradeDiscount,	EnemyHealChange,	NeutralHealChange,	FriendlyHealChange,	CannotBeChosen, LostWithUpgrade,	PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry,								ShowInPedia)
VALUES	('PROMOTION_F0S_ALTAR',			'TXT_KEY_PROMOTION_F0S_ALTAR',			'TXT_KEY_PROMOTION_F0S_ALTAR_HELP',			'AS2D_IF_LEVELUP', 	0,					0,					0,					0,					0,					1, 				0,					59, 			'PROMOTION_ATLAS', 	'PEDIA_SHARED', 	'TXT_KEY_PROMOTION_F0S_ALTAR',			1),
		('PROMOTION_F0S_GODWAR',		'TXT_KEY_PROMOTION_F0S_GODWAR',			'TXT_KEY_PROMOTION_F0S_GODWAR_HELP',		'AS2D_IF_LEVELUP', 	50,					-50,				0,					0,					0,					1, 				0,					59, 			'PROMOTION_ATLAS', 	'PEDIA_SHARED', 	'TXT_KEY_PROMOTION_F0S_GODWAR',			0),
		('PROMOTION_F0S_SACRED_WATERS',	'TXT_KEY_PROMOTION_F0S_SACRED_WATERS',	'TXT_KEY_PROMOTION_F0S_SACRED_WATERS_HELP',	'AS2D_IF_LEVELUP', 	0,					0,					5,					5,					5,					1, 				0,					59, 			'PROMOTION_ATLAS', 	'PEDIA_SHARED', 	'TXT_KEY_PROMOTION_F0S_SACRED_WATERS',	1);
-----------------------------------------------------------------------------------------------------
-- UnitPromotions_UnitCombats
-----------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions_UnitCombats
		(PromotionType,				UnitCombatType)
VALUES	('PROMOTION_F0S_ALTAR',		'UNITCOMBAT_MELEE'),
		('PROMOTION_F0S_ALTAR',		'UNITCOMBAT_GUN');
-----------------------------------------------------------------------------------------------------
-- UnitPromotions_YieldFromKills
-----------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions_YieldFromKills
		(PromotionType,					YieldType,		Yield)
VALUES	('PROMOTION_F0S_ALTAR',			'YIELD_FAITH',	100);
--==========================================================================================================================
--==========================================================================================================================