--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================	
INSERT INTO UnitPromotions 
			(Type, 									Description, 									Help, 											Sound, 				CannotBeChosen, 	IgnoreZOC, LostWithUpgrade, 	GoldenAgeValueFromKills,	NearbyEnemyCombatMod,	NearbyEnemyCombatRange,	AdjacentMod,	PortraitIndex, 	IconAtlas, 						PediaType, 			PediaEntry,									ShowInPedia)
VALUES		('PROMOTION_JFD_PRUSSIAN_VETERAN_4', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_4', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_HELP', 	'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					200,						0,						0,						0,				2, 				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_4',	0),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_3', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_3', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_HELP', 	'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					150,						0,						0,						0,				2, 				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_3',	0),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_2', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_2', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_HELP', 	'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					100,						0,						0,						0,				2, 				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_2',	0),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_1', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_1', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_HELP', 	'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					50,							0,						0,						0,				2, 				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_1',	0),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_0', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_0', 	'TXT_KEY_PROMOTION_JFD_PRUSSIAN_RECRUIT_HELP', 	'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					0,							0,						0,						0,				2, 				'EXPANSION2_PROMOTION_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_PRUSSIAN_VETERAN_0',	0),
			('PROMOTION_JFD_DEATHS_HEAD', 			'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD', 			'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD_HELP', 		'AS2D_IF_LEVELUP', 	1, 					0, 			1, 					0,							-10,					2,						0,				59, 			'ABILITY_ATLAS', 				'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD',		1),
			('PROMOTION_JFD_DEATHS_HEAD_1', 		'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD_1', 			'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD_1_HELP', 	'AS2D_IF_LEVELUP', 	1, 					0, 			1, 					0,							0,						0,						0,				59, 			'ABILITY_ATLAS', 				'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD_1',		1),
			('PROMOTION_JFD_DEATHS_HEAD_2', 		'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD_2', 			'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD_2_HELP', 	'AS2D_IF_LEVELUP', 	1, 					1, 			0, 					0,							0,						0,						0,				59, 			'ABILITY_ATLAS', 				'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_DEATHS_HEAD_2',		1),
			('PROMOTION_JFD_BEWEGUNGSKRIEG', 		'TXT_KEY_PROMOTION_JFD_BEWEGUNGSKRIEG', 		'TXT_KEY_PROMOTION_JFD_BEWEGUNGSKRIEG_HELP', 	'AS2D_IF_LEVELUP', 	1, 					0, 			0, 					0, 							0,						0,						15,				59, 			'ABILITY_ATLAS', 				'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_BEWEGUNGSKRIEG',		1);
--==========================================================================================================================
-- UnitPromotions_UnitCombats
--==========================================================================================================================	
INSERT INTO UnitPromotions_UnitCombats 
			(PromotionType, 						UnitCombatType)
VALUES		('PROMOTION_JFD_PRUSSIAN_VETERAN_0', 	'UNITCOMBAT_MOUNTED'),
			('PROMOTION_JFD_BEWEGUNGSKRIEG', 		'UNITCOMBAT_MOUNTED'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_1', 	'UNITCOMBAT_MOUNTED'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_2', 	'UNITCOMBAT_MOUNTED'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_3', 	'UNITCOMBAT_MOUNTED'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_4', 	'UNITCOMBAT_MOUNTED'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_0', 	'UNITCOMBAT_GUN'),
			('PROMOTION_JFD_BEWEGUNGSKRIEG', 		'UNITCOMBAT_GUN'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_1', 	'UNITCOMBAT_GUN'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_2', 	'UNITCOMBAT_GUN'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_3', 	'UNITCOMBAT_GUN'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_4', 	'UNITCOMBAT_GUN'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_0', 	'UNITCOMBAT_MELEE'),
			('PROMOTION_JFD_BEWEGUNGSKRIEG', 		'UNITCOMBAT_MELEE'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_1', 	'UNITCOMBAT_MELEE'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_2', 	'UNITCOMBAT_MELEE'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_3', 	'UNITCOMBAT_MELEE'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_4', 	'UNITCOMBAT_MELEE'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_0', 	'UNITCOMBAT_ARMOR'),
			('PROMOTION_JFD_BEWEGUNGSKRIEG', 		'UNITCOMBAT_ARMOR'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_1', 	'UNITCOMBAT_ARMOR'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_2', 	'UNITCOMBAT_ARMOR'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_3', 	'UNITCOMBAT_ARMOR'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_4', 	'UNITCOMBAT_ARMOR'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_0', 	'UNITCOMBAT_RECON'),
			('PROMOTION_JFD_BEWEGUNGSKRIEG', 		'UNITCOMBAT_RECON'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_1', 	'UNITCOMBAT_RECON'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_2', 	'UNITCOMBAT_RECON'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_3', 	'UNITCOMBAT_RECON'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_4', 	'UNITCOMBAT_RECON'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_0', 	'UNITCOMBAT_HELICOPTER'),
			('PROMOTION_JFD_BEWEGUNGSKRIEG', 		'UNITCOMBAT_HELICOPTER'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_1', 	'UNITCOMBAT_HELICOPTER'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_2', 	'UNITCOMBAT_HELICOPTER'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_3', 	'UNITCOMBAT_HELICOPTER'),
			('PROMOTION_JFD_PRUSSIAN_VETERAN_4', 	'UNITCOMBAT_HELICOPTER');
--==========================================================================================================================	
--==========================================================================================================================