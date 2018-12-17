--==========================================================================================================================	
-- Traits
--==========================================================================================================================	
INSERT INTO Traits 
			(Type, 									Description, 								ShortDescription)
VALUES		('TRAIT_CRADLE_OF_THE_RENAISSANCE', 	'TXT_KEY_TRAIT_CRADLE_OF_THE_RENAISSANCE', 	'TXT_KEY_TRAIT_CRADLE_OF_THE_RENAISSANCE_SHORT');
--==========================================================================================================================	
-- Trait_SpecialistYieldChanges
--==========================================================================================================================	
INSERT INTO Trait_SpecialistYieldChanges 
			(TraitType, 							SpecialistType, 		YieldType,			Yield)
VALUES		('TRAIT_CRADLE_OF_THE_RENAISSANCE', 	'SPECIALIST_WRITER', 	'YIELD_SCIENCE',	3),
			('TRAIT_CRADLE_OF_THE_RENAISSANCE', 	'SPECIALIST_ARTIST', 	'YIELD_SCIENCE',	3),
			('TRAIT_CRADLE_OF_THE_RENAISSANCE', 	'SPECIALIST_MUSICIAN', 	'YIELD_SCIENCE',	3);
--==========================================================================================================================
--==========================================================================================================================