--==========================================================================================================================
-- Resources
--==========================================================================================================================
INSERT INTO Resources 
			(Type,							Description,							Civilopedia, 										ArtDefineTag,							ResourceClassType, 		Happiness,  AITradeModifier, 	'Unique', 	IconString, 						PortraitIndex, 	IconAtlas)
VALUES		('RESOURCE_MC_ORCA',			'TXT_KEY_RESOURCE_MC_ORCA',				'TXT_KEY_CIV5_RESOURCE_MC_ORCA_TEXT',				'ART_DEF_RESOURCE_MC_ORCA',				'RESOURCECLASS_LUXURY',	4,			10,					2, 			'[ICON_RES_MC_ORCA]',				5, 				'MC_CHINOOK_ATLAS'),
			('RESOURCE_MC_SALMON',			'TXT_KEY_RESOURCE_MC_SALMON',			'TXT_KEY_CIV5_RESOURCE_MC_SALMON_TEXT',				'ART_DEF_RESOURCE_MC_SALMON',			'RESOURCECLASS_BONUS',	0,			0,					3, 			'[ICON_RES_MC_SALMON]',				4, 				'MC_CHINOOK_ATLAS'),
			('RESOURCE_MC_BREEDING_GROUND',	'TXT_KEY_RESOURCE_MC_BREEDING_GROUND',	'TXT_KEY_CIV5_RESOURCE_MC_BREEDING_GROUND_TEXT',	'ART_DEF_RESOURCE_MC_BREEDING_GROUND',	'RESOURCECLASS_BONUS',	0,			0,					0, 			'[ICON_RES_MC_BREEDING_GROUND]',	0, 				'MC_BREEDING_GROUND_ATLAS');
--==========================================================================================================================
-- Resource_YieldChanges
--==========================================================================================================================
INSERT INTO Resource_YieldChanges 
			(ResourceType, 				YieldType, 			Yield)
VALUES		('RESOURCE_MC_ORCA',		'YIELD_FOOD',		1),
			('RESOURCE_MC_ORCA',		'YIELD_GOLD',		1),
			('RESOURCE_MC_ORCA',		'YIELD_CULTURE',	1),
			('RESOURCE_MC_SALMON',		'YIELD_FOOD',		1),
			('RESOURCE_MC_SALMON',		'YIELD_CULTURE', 	1);
--==========================================================================================================================
-- Resource_Flavors
--==========================================================================================================================
INSERT INTO Resource_Flavors 	
			(ResourceType, 				FlavorType, 			Flavor)
VALUES		('RESOURCE_MC_SALMON', 		'FLAVOR_GROWTH',	 	10),
			('RESOURCE_MC_SALMON', 		'FLAVOR_CULTURE', 		10),
			('RESOURCE_MC_ORCA', 		'FLAVOR_HAPPINESS', 	10),
			('RESOURCE_MC_ORCA', 		'FLAVOR_CULTURE', 		10);
--==========================================================================================================================
-- Improvement_ResourceTypes
--==========================================================================================================================
INSERT INTO Improvement_ResourceTypes
			(ResourceType, 				ImprovementType)
VALUES		('RESOURCE_MC_SALMON',		'IMPROVEMENT_FISHING_BOATS'),
			('RESOURCE_MC_ORCA',		'IMPROVEMENT_FISHING_BOATS');
--==========================================================================================================================
-- Improvement_ResourceType_Yields
--==========================================================================================================================
INSERT INTO Improvement_ResourceType_Yields
			(ResourceType, 				ImprovementType,				YieldType,			Yield)
VALUES		('RESOURCE_MC_ORCA',		'IMPROVEMENT_FISHING_BOATS',	'YIELD_FOOD',		1),
			('RESOURCE_MC_SALMON',		'IMPROVEMENT_FISHING_BOATS',	'YIELD_FOOD',		1);
--==========================================================================================================================
--==========================================================================================================================		