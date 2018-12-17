--==========================================================================================================================
-- Policies
--==========================================================================================================================	
INSERT INTO Policies
			(Type,							Description,							AfraidMinorPerTurnInfluence,	MinorBullyScoreModifier)
VALUES		('POLICY_JFD_STALIN_QUICK',		'TXT_KEY_TRAIT_JFD_USSR_STALIN_SHORT',	350,							50),
			('POLICY_JFD_STALIN_STANDARD',	'TXT_KEY_TRAIT_JFD_USSR_STALIN_SHORT',	300,							50),
			('POLICY_JFD_STALIN_EPIC',		'TXT_KEY_TRAIT_JFD_USSR_STALIN_SHORT',	250,							50),
			('POLICY_JFD_STALIN_MARATHON',	'TXT_KEY_TRAIT_JFD_USSR_STALIN_SHORT',	200,							50);
--==========================================================================================================================
-- Traits
--==========================================================================================================================		
INSERT INTO Traits 
			(Type, 							Description, 						ShortDescription)
VALUES		('TRAIT_JFD_USSR_STALIN', 		'TXT_KEY_TRAIT_JFD_USSR_STALIN', 	'TXT_KEY_TRAIT_JFD_USSR_STALIN_SHORT');
--==========================================================================================================================
--==========================================================================================================================