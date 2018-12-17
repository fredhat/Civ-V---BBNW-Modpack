--==========================================================================================================================	
-- Units
--==========================================================================================================================
UPDATE Units
SET Help = 'TXT_KEY_UNIT_F0S_MOHAWK_WARRIOR_HELP', Strategy = 'TXT_KEY_UNIT_F0S_MOHAWK_WARRIOR_STRATEGY', Combat = 15
WHERE Type = 'UNIT_IROQUOIAN_MOHAWKWARRIOR';

INSERT INTO Units 	
			(Type, 							PrereqTech, Class, Capture, Cost, Moves, CivilianAttackPriority, Domain, ShowInPedia, 	DefaultUnitAI,	Description, Civilopedia, Help, Strategy, AdvancedStartCost, WorkRate, 	CombatLimit, UnitArtInfo, UnitArtInfoEraVariation, UnitFlagIconOffset, PortraitIndex, IconAtlas)
SELECT		('UNIT_F0S_IROQUOIS_WORKER'),	PrereqTech, Class, Capture, Cost, Moves, CivilianAttackPriority, Domain, 0,				DefaultUnitAI,	Description, Civilopedia, Help, Strategy, AdvancedStartCost, WorkRate,	CombatLimit, UnitArtInfo, UnitArtInfoEraVariation, UnitFlagIconOffset, PortraitIndex, IconAtlas
FROM Units WHERE Type = 'UNIT_WORKER';
--==========================================================================================================================	
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions 	
			(UnitType, 							PromotionType)
VALUES		('UNIT_IROQUOIAN_MOHAWKWARRIOR', 	'PROMOTION_F0S_FOREST_INVISIBLE_INFO'),
			('UNIT_IROQUOIAN_MOHAWKWARRIOR', 	'PROMOTION_WOODSMAN');
--==========================================================================================================================	
-- UnitGameplay2DScripts
--==========================================================================================================================
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_F0S_IROQUOIS_WORKER'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE UnitType = 'UNIT_WORKER';
--==========================================================================================================================	
-- Unit_AITypes
--==========================================================================================================================
INSERT INTO Unit_AITypes 	
			(UnitType, 						UnitAIType)
SELECT		('UNIT_F0S_IROQUOIS_WORKER'), 	UnitAIType
FROM Unit_AITypes WHERE UnitType = 'UNIT_WORKER';
--==========================================================================================================================	
-- Unit_Flavors
--==========================================================================================================================
INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_F0S_IROQUOIS_WORKER'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE UnitType = 'UNIT_WORKER';
--==========================================================================================================================	
-- Unit_Builds
--==========================================================================================================================
INSERT INTO Unit_Builds 	
			(UnitType, 						BuildType)
SELECT		('UNIT_F0S_IROQUOIS_WORKER'),	BuildType
FROM Unit_Builds WHERE UnitType = 'UNIT_WORKER';

INSERT INTO Unit_Builds
			(UnitType,						BuildType)
VALUES 		('UNIT_F0S_IROQUOIS_WORKER',	'BUILD_FOREST');

CREATE TRIGGER IroquoisWorkerBuildTrigger
AFTER INSERT ON Unit_Builds
WHEN 'UNIT_WORKER' = NEW.UnitType
BEGIN
	INSERT INTO Unit_Builds
			(UnitType, 						BuildType)
	VALUES	('UNIT_F0S_IROQUOIS_WORKER',	NEW.BuildType);
END;
--==========================================================================================================================		
--==========================================================================================================================