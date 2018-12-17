--==========================================================================================================================
-- BUILDING CLASSES
--==========================================================================================================================
-- BuildingClasses
--------------------------------------------------------------------------------------------------------------------------		
INSERT INTO BuildingClasses
		(Type,								DefaultBuilding,					Description,				MaxGlobalInstances)
VALUES	('BUILDINGCLASS_JFD_BELEM_TOWER',	'BUILDING_JFD_BELEM_TOWER',			'TXT_KEY_JFD_BELEM_TOWER',	1);
--------------------------------------------------------------------------------------------------------------------------
-- Civilization_BuildingClassOverrides
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Civilization_BuildingClassOverrides
		(CivilizationType, 					BuildingClassType, 					BuildingType)
VALUES	('CIVILIZATION_BARBARIAN',			'BUILDINGCLASS_JFD_BELEM_TOWER', 	null);

INSERT INTO Civilization_BuildingClassOverrides
		(CivilizationType, 					BuildingClassType, 					BuildingType)
VALUES	('CIVILIZATION_MINOR',				'BUILDINGCLASS_JFD_BELEM_TOWER', 	null);
--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
--------------------------------------------------------------------------------------------------------------------------				
--Factory
UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_JFD_FACTORY_HELP', Strategy = 'TXT_KEY_BUILDING_JFD_FACTORY_STRATEGY'
WHERE Type = 'BUILDING_FACTORY';
--------------------------
-- Wonders
--------------------------
--Belem Tower
INSERT INTO Buildings			
		(Type, 							BuildingClass, 						Cost, 	PrereqTech, 		MaxStartEra, 		Water,	PolicyBranchType,				Description, 						 Help, 									Civilopedia, 							FreePromotion,			Quote, 									 Defense,	ExtraCityHitPoints, NukeImmune, HurryCostModifier,  MinAreaSize,	ConquestProb, 	NeverCapture,	IconAtlas, 							PortraitIndex, 	WonderSplashAudio,						WonderSplashImage, 			WonderSplashAnchor)
VALUES	('BUILDING_JFD_BELEM_TOWER',	'BUILDINGCLASS_JFD_BELEM_TOWER', 	625, 	'TECH_NAVIGATION',	'ERA_INDUSTRIAL',	1,		'POLICY_BRANCH_EXPLORATION',	'TXT_KEY_BUILDING_JFD_BELEM_TOWER',	 'TXT_KEY_WONDER_JFD_BELEM_TOWER_HELP',	'TXT_KEY_WONDER_JFD_BELEM_TOWER_PEDIA',	'PROMOTION_JFD_BELEM',	'TXT_KEY_WONDER_JFD_BELEM_TOWER_QUOTE',	 1000,		20,					1, 			-1, 				-1, 			100, 			0,				'JFD_EXPLORATION_WONDER_ATLAS', 	0, 				'AS2D_WONDER_SPEECH_JFD_BELEM_TOWER',	'Wonder_BelemTower.dds', 	'L,B');

-- Louvre
UPDATE Buildings
SET PolicyBranchType = null
WHERE Type = 'BUILDING_LOUVRE';
----------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldChanges
		(BuildingType,					YieldType,				Yield)
VALUES	('BUILDING_JFD_BELEM_TOWER',	'YIELD_CULTURE',		1);
--------------------------------------------------------------------------------------------------------------------------
-- Building_FreeUnits
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_FreeUnits
		(BuildingType,					UnitType,					NumUnits)
VALUES	('BUILDING_GREAT_LIGHTHOUSE',	'UNIT_GREAT_ADMIRAL',		1);

INSERT INTO Building_FreeUnits
		(BuildingType,					UnitType,					NumUnits)
VALUES	('BUILDING_JFD_BELEM_TOWER',	'UNIT_JFD_EXPLORER',		2);
--------------------------------------------------------------------------------------------------------------------------
-- Building_ResourceYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_ResourceYieldChanges
		(BuildingType,	ResourceType, 				YieldType,				Yield)
SELECT	Type,			'RESOURCE_JFD_RUBBER',		'YIELD_PRODUCTION', 	1
FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_FACTORY';

INSERT INTO Building_ResourceYieldChanges
		(BuildingType,	ResourceType, 				YieldType,				Yield)
SELECT	Type,			'RESOURCE_JFD_SULFUR',		'YIELD_PRODUCTION', 	1
FROM Buildings WHERE BuildingClass = 'BUILDINGCLASS_FACTORY';

CREATE TRIGGER JFDExCE_Building_ResourceYieldChanges
AFTER INSERT ON Buildings 
WHEN NEW.BuildingClass = 'BUILDINGCLASS_FACTORY'
BEGIN
	INSERT INTO Building_ResourceYieldChanges
			(BuildingType,		ResourceType, 				YieldType,				Yield)
	SELECT	Type,				'RESOURCE_JFD_RUBBER',		'YIELD_PRODUCTION', 	1
	FROM Buildings WHERE Type = NEW.Type AND BuildingClass = 'BUILDINGCLASS_FACTORY';

	INSERT INTO Building_ResourceYieldChanges
			(BuildingType,		ResourceType, 				YieldType,				Yield)
	SELECT	Type,				'RESOURCE_JFD_SULFUR',		'YIELD_PRODUCTION', 	1
	FROM Buildings WHERE Type = NEW.Type AND BuildingClass = 'BUILDINGCLASS_FACTORY';
END;
--------------------------------------------------------------------------------------------------------------------------
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_Flavors
		(BuildingType,					FlavorType,				Flavor)
VALUES	('BUILDING_JFD_BELEM_TOWER',	'FLAVOR_WONDER',		30);

INSERT INTO Building_Flavors
		(BuildingType,					FlavorType,				Flavor)
VALUES	('BUILDING_JFD_BELEM_TOWER',	'FLAVOR_RECON',			30);

INSERT INTO Building_Flavors
		(BuildingType,					FlavorType,				Flavor)
VALUES	('BUILDING_JFD_BELEM_TOWER',	'FLAVOR_GREAT_PEOPLE',	5);

INSERT INTO Building_Flavors
		(BuildingType,					FlavorType,				Flavor)
VALUES	('BUILDING_JFD_BELEM_TOWER',	'FLAVOR_CITY_DEFENSE',	30);
--==========================================================================================================================
--==========================================================================================================================