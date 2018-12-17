--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================	
INSERT INTO UnitPromotions 
			(Type, 									Description, 									Help, 												Sound, 				AttackMod,	DefenseMod,	ExperiencePercent, 	CityAttack, CannotBeChosen, LostWithUpgrade,	PortraitIndex,	IconAtlas, 			PediaType, 			PediaEntry,										ShowInPedia)
VALUES		('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'TXT_KEY_PROMOTION_JFD_LINCOLN_SPEECH_ONE',		'TXT_KEY_PROMOTION_JFD_LINCOLN_SPEECH_ONE_HELP', 	'AS2D_IF_LEVELUP',	25, 		0, 			0, 					0, 			1, 				0,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_LINCOLN_SPEECH_ONE',		0),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'TXT_KEY_PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'TXT_KEY_PROMOTION_JFD_LINCOLN_SPEECH_THREE_HELP', 	'AS2D_IF_LEVELUP',	0, 			0, 			50, 				0, 			1, 				0,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_LINCOLN_SPEECH_THREE',	0),
			('PROMOTION_JFD_PARROTT_DEFENSE', 		'TXT_KEY_PROMOTION_JFD_PARROTT_DEFENSE',		'TXT_KEY_PROMOTION_JFD_PARROTT_DEFENSE_HELP', 		'AS2D_IF_LEVELUP',	0, 			25, 		0, 					0, 			1, 				0,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PARROTT_DEFENSE',		0),
			('PROMOTION_JFD_PARROTT_RIFLE', 		'TXT_KEY_PROMOTION_JFD_PARROTT_RIFLE',			'TXT_KEY_PROMOTION_JFD_PARROTT_RIFLE_HELP', 		'AS2D_IF_LEVELUP', 	0, 			0, 			0, 					0, 			1, 				1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PARROTT_RIFLE',			1),
			('PROMOTION_JFD_BONUS_VS_LAND', 		'TXT_KEY_PROMOTION_JFD_BONUS_VS_LAND',			'TXT_KEY_PROMOTION_JFD_BONUS_VS_LAND_HELP', 		'AS2D_IF_LEVELUP', 	0, 			0, 			0, 					0, 			1, 				0,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_BONUS_VS_LAND',			1),
			('PROMOTION_JFD_BONUS_VS_CITIES', 		'TXT_KEY_PROMOTION_JFD_BONUS_VS_CITIES',		'TXT_KEY_PROMOTION_JFD_BONUS_VS_CITIES_HELP', 		'AS2D_IF_LEVELUP', 	0, 			0, 			0, 					150, 		1, 				1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_BONUS_VS_CITIES',		1);
--==========================================================================================================================
-- UnitPromotions_Domains
--==========================================================================================================================	
INSERT INTO UnitPromotions_Domains
			(PromotionType, 						DomainType, 		Modifier)
VALUES		('PROMOTION_JFD_BONUS_VS_LAND', 		'DOMAIN_LAND', 		50);
--==========================================================================================================================
-- UnitPromotions_UnitCombats
--==========================================================================================================================	
INSERT INTO UnitPromotions_UnitCombats
			(PromotionType, 						UnitCombatType)
VALUES 		('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_RECON'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_ARCHER'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_MOUNTED'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_MELEE'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_SIEGE'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_GUN'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_ARMOR'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_HELICOPTER'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_NAVALRANGED'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_NAVALMELEE'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_CARRIER'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_SUBMARINE'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_FIGHTER'),
			('PROMOTION_JFD_LINCOLN_SPEECH_ONE',	'UNITCOMBAT_BOMBER'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_RECON'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_ARCHER'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_MOUNTED'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_MELEE'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_SIEGE'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_GUN'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_ARMOR'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_HELICOPTER'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_NAVALRANGED'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_NAVALMELEE'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_CARRIER'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_SUBMARINE'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_FIGHTER'),
			('PROMOTION_JFD_LINCOLN_SPEECH_THREE',	'UNITCOMBAT_BOMBER');
--==========================================================================================================================
--==========================================================================================================================