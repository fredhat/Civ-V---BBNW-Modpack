--==========================================================================================================================	
-- UnitPromotions
--==========================================================================================================================
UPDATE UnitPromotions
SET Description = 'TXT_KEY_PROMOTION_F0S_MOHAWK', Help = 'TXT_KEY_PROMOTION_F0S_MOHAWK_HELP'
WHERE Type = 'PROMOTION_MOHAWK';

INSERT INTO UnitPromotions 						
		(Type, 										Description, 									Help, 													Sound, 				CannotBeChosen, Invisible,				LostWithUpgrade,	PortraitIndex, 	IconAtlas, 			PediaType, 				PediaEntry,										ShowInPedia)
VALUES	('PROMOTION_F0S_FOREST_INVISIBLE_INFO',		'TXT_KEY_PROMOTION_F0S_FOREST_INVISIBLE_INFO',	'TXT_KEY_PROMOTION_F0S_FOREST_INVISIBLE_INFO_HELP',		'AS2D_IF_LEVELUP', 	1, 				null,					1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 	'TXT_KEY_PROMOTION_F0S_FOREST_INVISIBLE_INFO',	1),
		('PROMOTION_F0S_FOREST_INVISIBLE',			'TXT_KEY_PROMOTION_F0S_FOREST_INVISIBLE',		'TXT_KEY_PROMOTION_F0S_FOREST_INVISIBLE_HELP',			'AS2D_IF_LEVELUP', 	1, 				'INVISIBLE_SUBMARINE',	1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 	'TXT_KEY_PROMOTION_F0S_FOREST_INVISIBLE',		0);
--==========================================================================================================================	
-- UnitPromotions_Features
--==========================================================================================================================
DELETE FROM UnitPromotions_Features WHERE PromotionType = 'PROMOTION_MOHAWK' AND FeatureType = 'FEATURE_JUNGLE';
--==========================================================================================================================
--==========================================================================================================================