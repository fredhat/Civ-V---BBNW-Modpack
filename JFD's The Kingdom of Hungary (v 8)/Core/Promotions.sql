--==========================================================================================================================	
-- UnitPromotions
--==========================================================================================================================		
INSERT OR REPLACE INTO UnitPromotions 
			(Type, 										Description, 										Help, 													Sound, 				CannotBeChosen, LostWithUpgrade,	IgnoreZOC,	ExperiencePercent, 	PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_JFD_CEREMONIAL_DRAGOONS', 		'TXT_KEY_PROMOTION_JFD_CEREMONIAL_DRAGOONS', 		'TXT_KEY_PROMOTION_JFD_CEREMONIAL_DRAGOONS_HELP', 		'AS2D_IF_LEVELUP', 	1, 				1,					0,			0, 					58, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_CEREMONIAL_DRAGOONS'),
			('PROMOTION_JFD_DRAGOON_EXPERIENCE_BONUS', 	'TXT_KEY_PROMOTION_JFD_DRAGOON_EXPERIENCE_BONUS', 	'TXT_KEY_PROMOTION_JFD_DRAGOON_EXPERIENCE_BONUS_HELP', 	'AS2D_IF_LEVELUP', 	1, 				0,					0,			50, 				59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_DRAGOON_EXPERIENCE_BONUS'),
			('PROMOTION_JFD_DRAGOON_MOUNTED_BONUS', 	'TXT_KEY_PROMOTION_JFD_DRAGOON_MOUNTED_BONUS', 		'TXT_KEY_PROMOTION_JFD_DRAGOON_MOUNTED_BONUS_HELP', 	'AS2D_IF_LEVELUP', 	1, 				0,					0,			0, 					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_DRAGOON_MOUNTED_BONUS'),
			('PROMOTION_JFD_LIGHT_CAVALRY', 			'TXT_KEY_PROMOTION_JFD_LIGHT_CAVALRY', 				'TXT_KEY_PROMOTION_JFD_LIGHT_CAVALRY_HELP', 			'AS2D_IF_LEVELUP', 	1, 				0,					1,			0, 					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_LIGHT_CAVALRY');
--==========================================================================================================================	
-- UnitPromotions_UnitCombatMods
--==========================================================================================================================		
INSERT OR REPLACE INTO UnitPromotions_UnitCombatMods 
			(PromotionType, 							UnitCombatType, 				Modifier)
VALUES		('PROMOTION_JFD_DRAGOON_MOUNTED_BONUS', 	'UNITCOMBAT_MOUNTED', 			15),
			('PROMOTION_JFD_DRAGOON_MOUNTED_BONUS', 	'UNITCOMBAT_MOUNTED_RANGED', 	15);
--==========================================================================================================================		
--==========================================================================================================================