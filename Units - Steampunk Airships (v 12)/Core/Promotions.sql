--==========================================================================================================================
-- PROMOTIONS
--==========================================================================================================================
ALTER TABLE UnitPromotions ADD ShowInUnitPanel INTEGER DEFAULT 1;
ALTER TABLE UnitPromotions ADD ShowInEnemyUnitPanel INTEGER DEFAULT 1;
--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================	
INSERT INTO UnitPromotions 
			(Type, 											Description, 											Help, 														Sound, 				DefenseMod,	FlatMovementCost,	HoveringUnit,	CanMoveImpassable,	TechPrereq,		EmbarkedDeepWater,	EmbarkDefenseModifier,	CannotBeChosen, LostWithUpgrade,	PortraitIndex,	IconAtlas, 			PediaType, 			PediaEntry,												ShowInPedia)
VALUES		('PROMOTION_CLOSE_AIR_SUPPORT', 				'TXT_KEY_PROMOTION_CLOSE_AIR_SUPPORT',					'TXT_KEY_PROMOTION_CLOSE_AIR_SUPPORT_HELP', 				'AS2D_IF_LEVELUP',	0,	 		0,					0,				0,					null,			0,					0,						1, 				1, 					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_CLOSE_AIR_SUPPORT',					1),
			('PROMOTION_CLOSE_AIR_SUPPORT_DEFENSE', 		'TXT_KEY_PROMOTION_CLOSE_AIR_SUPPORT_DEFENSE',			'TXT_KEY_PROMOTION_CLOSE_AIR_SUPPORT_DEFENSE_HELP', 		'AS2D_IF_LEVELUP', 	25, 		0,					0,				0,					null,			0,					0,						1, 				0, 					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_CLOSE_AIR_SUPPORT_DEFENSE',			0),
			('PROMOTION_ANTI_SIEGE', 						'TXT_KEY_PROMOTION_ANTI_SIEGE',							'TXT_KEY_PROMOTION_ANTI_SIEGE_HELP', 						'AS2D_IF_LEVELUP', 	0, 			0,					0,				0,					null,			0,					0,						1, 				1, 					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_ANTI_SIEGE',							1),
			('PROMOTION_INFERNAL_MOVEMENT_I', 				'TXT_KEY_PROMOTION_INFERNAL_MOVEMENT_I',				'TXT_KEY_PROMOTION_INFERNAL_MOVEMENT_I_HELP', 				'AS2D_IF_LEVELUP', 	0, 			1,					1,				0,					null,			0,					0,						1, 				1, 					58, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_INFERNAL_MOVEMENT_I',				1),
			('PROMOTION_INFERNAL_MOVEMENT_II', 				'TXT_KEY_PROMOTION_INFERNAL_MOVEMENT_II',				'TXT_KEY_PROMOTION_INFERNAL_MOVEMENT_II_HELP', 				'AS2D_IF_LEVELUP', 	0, 			1,					1,				1,					null,			0,					0,						1, 				1, 					58, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_INFERNAL_MOVEMENT_II',				1),
			('PROMOTION_DEEPWATER_EMBARKATION', 			'TXT_KEY_PROMOTION_DEEPWATER_EMBARKATION',				'TXT_KEY_PROMOTION_DEEPWATER_EMBARKATION_HELP', 			'AS2D_IF_LEVELUP', 	0, 			0,					0,				0,					'TECH_OPTICS',	1,					0,						1, 				0, 					22, 			'PROMOTION_ATLAS', 	'PEDIA_SHARED', 	'TXT_KEY_PROMOTION_DEEPWATER_EMBARKATION',				1),
			('PROMOTION_DEFENSIVE_DEEPWATER_EMBARKATION', 	'TXT_KEY_PROMOTION_DEFENSIVE_DEEPWATER_EMBARKATION',	'TXT_KEY_PROMOTION_DEFENSIVE_DEEPWATER_EMBARKATION_HELP', 	'AS2D_IF_LEVELUP', 	0, 			0,					0,				0,					null,			1,					100,					1, 				0, 					22, 			'PROMOTION_ATLAS', 	'PEDIA_SHARED', 	'TXT_KEY_PROMOTION_DEFENSIVE_DEEPWATER_EMBARKATION',	1);
--==========================================================================================================================
-- UnitPromotions_UnitCombats
--==========================================================================================================================	
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_HELICOPTER' AND PromotionType = 'PROMOTION_EMBARKATION';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_HELICOPTER' AND PromotionType = 'PROMOTION_DEFENSIVE_EMBARKATION';
DELETE FROM UnitPromotions_UnitCombats WHERE UnitCombatType = 'UNITCOMBAT_HELICOPTER' AND PromotionType = 'PROMOTION_ALLWATER_EMBARKATION';

INSERT INTO UnitPromotions_UnitCombats
			(PromotionType, 								UnitCombatType)
VALUES 		('PROMOTION_DEEPWATER_EMBARKATION',				'UNITCOMBAT_HELICOPTER'),
			('PROMOTION_DEFENSIVE_DEEPWATER_EMBARKATION',	'UNITCOMBAT_HELICOPTER');
--==========================================================================================================================
-- UnitPromotions_UnitCombatMods
--==========================================================================================================================	
INSERT INTO UnitPromotions_UnitCombatMods
			(PromotionType, 			UnitCombatType, 		Modifier)
VALUES		('PROMOTION_ANTI_SIEGE', 	'UNITCOMBAT_SIEGE', 	33);
--==========================================================================================================================
--==========================================================================================================================