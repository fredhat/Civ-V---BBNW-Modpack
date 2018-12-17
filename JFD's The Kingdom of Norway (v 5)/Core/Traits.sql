--==========================================================================================================================
-- Traits
--==========================================================================================================================		
INSERT INTO Traits 
			(Type, 					Description, 					ShortDescription,					FreeBuilding)
VALUES		('TRAIT_JFD_NORWAY', 	'TXT_KEY_TRAIT_JFD_NORWAY', 	'TXT_KEY_TRAIT_JFD_NORWAY_SHORT',	'BUILDING_JFD_NORWAY_FISH');	
--==========================================================================================================================
-- Trait_ResourceQuantityModifiers
--==========================================================================================================================	
INSERT INTO Trait_ResourceQuantityModifiers 
			(TraitType, 			ResourceType, 				ResourceQuantityModifier)
VALUES		('TRAIT_JFD_NORWAY', 	'RESOURCE_CRAB', 			100),
			('TRAIT_JFD_NORWAY', 	'RESOURCE_PEARLS', 			100),
			('TRAIT_JFD_NORWAY', 	'RESOURCE_WHALE', 			100),
			('TRAIT_JFD_NORWAY', 	'RESOURCE_JFD_SHELLFISH', 	100),
			('TRAIT_JFD_NORWAY', 	'RESOURCE_MC_ORCA', 		100),
			('TRAIT_JFD_NORWAY', 	'RESOURCE_CORAL', 			100);
--==========================================================================================================================	
--==========================================================================================================================