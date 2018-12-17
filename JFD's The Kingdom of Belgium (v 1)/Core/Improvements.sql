--==========================================================================================================================
-- Improvements
--==========================================================================================================================
INSERT INTO Improvements
			(Type,									OutsideBorders, SpecificCivRequired,	CivilizationType,			Description,	Civilopedia,	ArtDefineTag,	PillageGold,	PortraitIndex,	IconAtlas,	ShowInPedia)
SELECT		('IMPROVEMENT_JFD_BELGIAN_PLANTATION'),	1,				1,						'CIVILIZATION_JFD_BELGIUM',	Description,	Civilopedia,	ArtDefineTag, 	PillageGold,	PortraitIndex,	IconAtlas,	0
FROM Improvements WHERE Type = 'IMPROVEMENT_PLANTATION';
--==========================================================================================================================
-- Improvement_ResourceTypes
--==========================================================================================================================
INSERT INTO Improvement_ResourceTypes
			(ImprovementType,							ResourceType)
SELECT		('IMPROVEMENT_JFD_BELGIAN_PLANTATION'), 	ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_PLANTATION';

CREATE TRIGGER JFD_Belgian_Plantation_ResourceTypes
AFTER INSERT ON Improvement_ResourceTypes 
WHEN NEW.ImprovementType = 'IMPROVEMENT_PLANTATION'
BEGIN
	INSERT INTO Improvement_ResourceTypes
			(ImprovementType,						ResourceType)
	VALUES	('IMPROVEMENT_JFD_BELGIAN_PLANTATION', 	NEW.ResourceType);
END;	
--==========================================================================================================================
-- Improvement_ResourceType_Yields
--==========================================================================================================================
INSERT INTO Improvement_ResourceType_Yields
			(ImprovementType,							ResourceType, YieldType, Yield)
SELECT		('IMPROVEMENT_JFD_BELGIAN_PLANTATION'), 	ResourceType, YieldType, Yield
FROM Improvement_ResourceType_Yields WHERE ImprovementType = 'IMPROVEMENT_PLANTATION';

DELETE FROM Improvement_ResourceType_Yields WHERE ImprovementType = 'IMPROVEMENT_JFD_BELGIAN_PLANTATION' AND ResourceType = 'RESOURCE_BANANA';

INSERT INTO Improvement_ResourceType_Yields
			(ImprovementType,							ResourceType, 		YieldType, 		Yield)
VALUES		('IMPROVEMENT_JFD_BELGIAN_PLANTATION', 		'RESOURCE_BANANA', 	'YIELD_FOOD', 	1);

CREATE TRIGGER JFD_Belgian_Plantation_ResourceType_Yields
AFTER INSERT ON Improvement_ResourceType_Yields 
WHEN (NEW.ImprovementType = 'IMPROVEMENT_PLANTATION' AND NOT NEW.ResourceType = 'RESOURCE_BANANA')
BEGIN
	INSERT INTO Improvement_ResourceType_Yields
			(ImprovementType,						ResourceType, 		YieldType, 		Yield)
	VALUES	('IMPROVEMENT_JFD_BELGIAN_PLANTATION', 	NEW.ResourceType, 	NEW.YieldType, 	NEW.Yield);
END;	
--==========================================================================================================================
-- Improvement_TechNoFreshWaterYieldChanges
--==========================================================================================================================
INSERT INTO Improvement_TechNoFreshWaterYieldChanges
			(ImprovementType,						TechType, 				YieldType, 		Yield)
VALUES 		('IMPROVEMENT_JFD_BELGIAN_PLANTATION', 	'TECH_FERTILIZER', 		'YIELD_FOOD', 	1);
--==========================================================================================================================
-- Improvement_TechFreshWaterYieldChanges
--==========================================================================================================================
INSERT INTO Improvement_TechFreshWaterYieldChanges
			(ImprovementType,						TechType, 				YieldType, 		Yield)
VALUES 		('IMPROVEMENT_JFD_BELGIAN_PLANTATION', 	'TECH_CIVIL_SERVICE', 	'YIELD_FOOD', 	1);
--==========================================================================================================================
-- Belief_ImprovementYieldChanges
--==========================================================================================================================
INSERT INTO Belief_ImprovementYieldChanges
			(BeliefType,	ImprovementType,						YieldType, Yield)
SELECT		BeliefType,		('IMPROVEMENT_JFD_BELGIAN_PLANTATION'),	YieldType, Yield
FROM Belief_ImprovementYieldChanges WHERE ImprovementType = 'IMPROVEMENT_PLANTATION';

CREATE TRIGGER JFD_Belgian_Plantation_Belief_ImprovementYieldChanges
AFTER INSERT ON Belief_ImprovementYieldChanges 
WHEN NEW.ImprovementType = 'IMPROVEMENT_PLANTATION'
BEGIN
	INSERT INTO Belief_ImprovementYieldChanges
			(BeliefType,		ImprovementType,						YieldType, 		Yield)
	VALUES	(NEW.BeliefType, 	'IMPROVEMENT_JFD_BELGIAN_PLANTATION', 	NEW.YieldType, 	NEW.Yield);
END;
--==========================================================================================================================
--==========================================================================================================================