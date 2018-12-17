--==========================================================================================================================	
-- Policies
--==========================================================================================================================	
INSERT INTO Policies	
			(Type,							Description,								NumCitiesPolicyCostDiscount)
VALUES		('POLICY_JFD_PETRINE_RUSSIA',	'TXT_KEY_TRAIT_JFD_PETRINE_RUSSIA_SHORT', 	-50);
--==========================================================================================================================	
-- Traits
--==========================================================================================================================	
INSERT INTO Traits 
			(Type, 							Description, 							ShortDescription)
VALUES		('TRAIT_JFD_PETRINE_RUSSIA', 	'TXT_KEY_TRAIT_JFD_PETRINE_RUSSIA', 	'TXT_KEY_TRAIT_JFD_PETRINE_RUSSIA_SHORT');

UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_JFD_STRATEGIC_RICHES'
WHERE Type = 'TRAIT_STRATEGIC_RICHES';
--==========================================================================================================================	
--==========================================================================================================================