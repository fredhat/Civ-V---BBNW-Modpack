--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================	
-- UnitPromotions
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions
		(Type, 								Description, 								Help, 											Sound, 				ExtraNavalMovement,		EmbarkExtraVisibility,	EmbarkDefenseModifier,	CannotBeChosen, PortraitIndex,		IconAtlas, 				PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_BELEM', 			'TXT_KEY_PROMOTION_JFD_BELEM',				'TXT_KEY_PROMOTION_JFD_BELEM_HELP',				'AS2D_IF_LEVELUP',	1,						1,						50,						1, 				33, 				'PROMOTION_ATLAS', 		'PEDIA_SHARED',		'TXT_KEY_PROMOTION_JFD_BELEM');

INSERT INTO UnitPromotions
		(Type, 								Description, 								Help, 											Sound, 				ExtraNavalMovement,		EmbarkExtraVisibility,	CannotBeChosen, PortraitIndex,		IconAtlas, 				PediaType, 			PediaEntry,								ShowInPedia)
VALUES	('PROMOTION_EXPLORATION_EMBARK', 	'TXT_KEY_PROMOTION_EXPLORATION_EMBARK',		'TXT_KEY_PROMOTION_EXPLORATION_EMBARK_HELP',	'AS2D_IF_LEVELUP',	1,						1,						1, 				33, 				'PROMOTION_ATLAS', 		'PEDIA_SHARED',		'TXT_KEY_PROMOTION_EXPLORATION_EMBARK',	0);

INSERT INTO UnitPromotions
		(Type, 								Description, 								Help, 											Sound, 				CannotBeChosen, PortraitIndex,		IconAtlas, 				PediaType, 			PediaEntry)
VALUES	('PROMOTION_JFD_GREAT_RECON',		'TXT_KEY_PROMOTION_JFD_GREAT_RECON',		'TXT_KEY_PROMOTION_JFD_GREAT_RECON_HELP',		'AS2D_IF_LEVELUP',	1, 				59, 				'ABILITY_ATLAS', 		'PEDIA_SCOUTING',	'TXT_KEY_PROMOTION_JFD_GREAT_RECON');
--------------------------------------------------------------------------------------------------------------------------
-- UnitPromotions_UnitCombats
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO UnitPromotions_UnitCombats
		(PromotionType,					UnitCombatType)
SELECT	'PROMOTION_JFD_BELEM', 			Type
FROM UnitCombatInfos WHERE Type IN ('UNITCOMBAT_MELEE', 'UNITCOMBAT_CIVILIAN' ,'UNITCOMBAT_GREAT_PEOPLE', 'UNITCOMBAT_RELIGIOUS', 'UNITCOMBAT_ARCHER', 'UNITCOMBAT_ARMOR', 'UNITCOMBAT_SIEGE', 'UNITCOMBAT_RECON', 'UNITCOMBAT_GUN', 'UNITCOMBAT_HELICOPTER', 'UNITCOMBAT_MOUNTED', 'UNITCOMBAT_MOUNTED_RANGED', 'UNITCOMBAT_AA');

INSERT INTO UnitPromotions_UnitCombats
		(PromotionType,					UnitCombatType)
SELECT	'PROMOTION_EXPLORATION_EMBARK', Type
FROM UnitCombatInfos WHERE Type IN ('UNITCOMBAT_MELEE', 'UNITCOMBAT_CIVILIAN' ,'UNITCOMBAT_GREAT_PEOPLE', 'UNITCOMBAT_RELIGIOUS', 'UNITCOMBAT_ARCHER', 'UNITCOMBAT_ARMOR', 'UNITCOMBAT_SIEGE', 'UNITCOMBAT_RECON', 'UNITCOMBAT_GUN', 'UNITCOMBAT_HELICOPTER', 'UNITCOMBAT_MOUNTED', 'UNITCOMBAT_MOUNTED_RANGED', 'UNITCOMBAT_AA');

INSERT INTO UnitPromotions_UnitCombats
		(PromotionType,							UnitCombatType)
VALUES	('PROMOTION_JFD_GREAT_RECON',			'UNITCOMBAT_RECON');
--==========================================================================================================================	
--==========================================================================================================================