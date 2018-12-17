--==========================================================================================================================	
-- Policies
--==========================================================================================================================	
INSERT INTO Policies
			(Type, 								Description,								UnitGoldMaintenanceMod, UnhappinessMod, UnitPurchaseCostModifier, 	MilitaryProductionModifier)
VALUES		('POLICY_JFD_LINCOLN_DUMMY',		'TXT_KEY_TRAIT_JFD_AMERICA_LINCOLN_SHORT',	0,						0,				0, 							0),
			('POLICY_JFD_LINCOLN_SPEECH_ONE',	'TXT_KEY_TRAIT_JFD_AMERICA_LINCOLN_SHORT',	0,						0,				0, 							0),
			('POLICY_JFD_LINCOLN_SPEECH_TWO',	'TXT_KEY_TRAIT_JFD_AMERICA_LINCOLN_SHORT',	-25,					0,				0, 							0),
			('POLICY_JFD_LINCOLN_SPEECH_THREE', 'TXT_KEY_TRAIT_JFD_AMERICA_LINCOLN_SHORT',	0,						0,				0, 							0),
			('POLICY_JFD_LINCOLN_SPEECH_FOUR',	'TXT_KEY_TRAIT_JFD_AMERICA_LINCOLN_SHORT',	0,						0,				0, 							25),
			('POLICY_JFD_LINCOLN_SPEECH_FIVE',	'TXT_KEY_TRAIT_JFD_AMERICA_LINCOLN_SHORT',	0,						-25,			0, 							0),
			('POLICY_JFD_LINCOLN_SPEECH_SIX',	'TXT_KEY_TRAIT_JFD_AMERICA_LINCOLN_SHORT',	0,						0,				-25, 						0);			
--==========================================================================================================================	
-- Policy_FreePromotions
--==========================================================================================================================	
INSERT INTO Policy_FreePromotions 
			(PolicyType, 						PromotionType)
VALUES		('POLICY_JFD_LINCOLN_SPEECH_ONE', 	'PROMOTION_JFD_LINCOLN_SPEECH_ONE'),
			('POLICY_JFD_LINCOLN_SPEECH_THREE', 'PROMOTION_JFD_LINCOLN_SPEECH_THREE');
--==========================================================================================================================
-- Traits
--==========================================================================================================================
INSERT INTO Traits 
			(Type, 							Description, 							ShortDescription)
VALUES		('TRAIT_JFD_AMERICA_LINCOLN', 	'TXT_KEY_TRAIT_JFD_AMERICA_LINCOLN', 	'TXT_KEY_TRAIT_JFD_AMERICA_LINCOLN_SHORT');
--==========================================================================================================================
--==========================================================================================================================