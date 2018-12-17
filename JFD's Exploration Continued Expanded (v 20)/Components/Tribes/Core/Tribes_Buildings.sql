--==========================================================================================================================
-- BUILDING CLASSES
--==========================================================================================================================
-- BuildingClasses
------------------------------------------------------------------------------------------------------------------------
-- Wonders
--------------	
INSERT INTO BuildingClasses 
		(Type, 									DefaultBuilding, 					Description, 								MaxGlobalInstances)
VALUES	('BUILDINGCLASS_JFD_SMITHSONIAN',		'BUILDING_JFD_SMITHSONIAN', 		'TXT_KEY_BUILDING_JFD_SMITHSONIAN', 		1);
--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
-- Wonders
---------------
INSERT INTO Buildings 
		(Type, 							BuildingClass, 						Cost, 	PrereqTech, 			MaxStartEra, 	GreatWorkSlotType,					GreatWorkCount,	GreatWorksTourismModifier,	SpecialistType, 		GreatPeopleRateChange, 	FreeBuildingThisCity,		Description, 						Help, 									Civilopedia, 							Quote, 									ThemingBonusHelp,								NukeImmune, HurryCostModifier,  MinAreaSize,	ConquestProb, 	IconAtlas, 					PortraitIndex, 	WonderSplashAudio,						WonderSplashImage, 			WonderSplashAnchor)
VALUES	('BUILDING_JFD_SMITHSONIAN',	'BUILDINGCLASS_JFD_SMITHSONIAN',	750,	'TECH_ARCHAEOLOGY',		'ERA_MODERN',   'GREAT_WORK_SLOT_ART_ARTIFACT',		2,				100,						'SPECIALIST_SCIENTIST',	1,						'BUILDINGCLASS_MUSEUM',		'TXT_KEY_BUILDING_JFD_SMITHSONIAN',	'TXT_KEY_WONDER_JFD_SMITHSONIAN_HELP',	'TXT_KEY_WONDER_JFD_SMITHSONIAN_PEDIA',	'TXT_KEY_WONDER_JFD_SMITHSONIAN_QUOTE',	'TXT_KEY_JFD_SMITHSONIAN_THEMING_BONUS_HELP',	1,			-1,					-1,				100,			'JFD_TRIBE_WONDER_ATLAS',	0,				'AS2D_WONDER_SPEECH_JFD_SMITHSONIAN',	'Wonder_Smithsonian.dds',	'L,B');
------------------------------------------------------------------------------------------------------------------------
-- Building_YieldFromGreatWorksInCity
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldFromGreatWorksInCity 
		(BuildingType, 					YieldType,			Yield)
VALUES	('BUILDING_JFD_SMITHSONIAN',	'YIELD_SCIENCE',	2);
------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldChanges 
		(BuildingType, 					YieldType,			Yield)
VALUES	('BUILDING_JFD_SMITHSONIAN',	'YIELD_CULTURE',	2);

INSERT INTO Building_YieldChanges 
		(BuildingType, 					YieldType,			Yield)
VALUES	('BUILDING_JFD_SMITHSONIAN',	'YIELD_SCIENCE',	2);
------------------------------------------------------------------------------------------------------------------------
-- Building_ThemingBonuses
------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_ThemingBonuses 
		(BuildingType, 					Description,								Bonus,	MustBeArtifact,	RequiresUniquePlayers,	AIPriority)
VALUES	('BUILDING_JFD_SMITHSONIAN',	'TXT_KEY_THEMING_BONUS_JFD_SMITHSONIAN',	2,		1,				1,						3);
---------------
-- Wonders
---------------
INSERT INTO Building_Flavors 
		(BuildingType, 					FlavorType,						Flavor)
VALUES	('BUILDING_JFD_SMITHSONIAN',	'FLAVOR_SCIENCE',				30);

INSERT INTO Building_Flavors 
		(BuildingType, 					FlavorType,						Flavor)
VALUES	('BUILDING_JFD_SMITHSONIAN',	'FLAVOR_CULTURE',				30);

INSERT INTO Building_Flavors 
		(BuildingType, 					FlavorType,						Flavor)
VALUES	('BUILDING_JFD_SMITHSONIAN',	'FLAVOR_GREAT_PEOPLE',			10);

INSERT INTO Building_Flavors 
		(BuildingType, 					FlavorType,						Flavor)
VALUES	('BUILDING_JFD_SMITHSONIAN',	'FLAVOR_WONDER',				25);
--==========================================================================================================================
--==========================================================================================================================