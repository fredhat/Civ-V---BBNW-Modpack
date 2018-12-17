--==========================================================================================================================
-- Improvements
--==========================================================================================================================
UPDATE Improvements
SET NoTwoAdjacent = 1
WHERE Type = 'IMPROVEMENT_OFFSHORE_PLATFORM';
--==========================================================================================================================
-- Improvement_Yields
--==========================================================================================================================
UPDATE Improvement_Yields
SET Yield = 6
WHERE ImprovementType = 'IMPROVEMENT_CUSTOMS_HOUSE';

UPDATE Improvement_Yields
SET Yield = 6
WHERE ImprovementType = 'IMPROVEMENT_ACADEMY';

INSERT INTO Improvement_Yields 	
			(ImprovementType,					YieldType,			Yield)
VALUES		('IMPROVEMENT_FISHING_BOATS',		'YIELD_PRODUCTION',	1),
			('IMPROVEMENT_OFFSHORE_PLATFORM',	'YIELD_PRODUCTION',	3);
--==========================================================================================================================
-- Improvement_ValidTerrains
--==========================================================================================================================
INSERT INTO Improvement_ValidTerrains 	
			(ImprovementType,					TerrainType)
VALUES		('IMPROVEMENT_OFFSHORE_PLATFORM',	'TERRAIN_OCEAN');
--==========================================================================================================================
-- Improvement_ResourceType_Yields
--==========================================================================================================================
DELETE FROM Improvement_ResourceType_Yields WHERE ImprovementType = 'IMPROVEMENT_PLANTATION' AND ResourceType = 'RESOURCE_BANANA';

UPDATE Improvement_ResourceType_Yields
SET Yield = 1
WHERE ImprovementType = 'IMPROVEMENT_OFFSHORE_PLATFORM';

INSERT INTO Improvement_ResourceType_Yields 	
			(ImprovementType,				ResourceType,		YieldType,		Yield)
VALUES		('IMPROVEMENT_PLANTATION',		'RESOURCE_BANANA',	'YIELD_FOOD',	1);
--==========================================================================================================================
-- Improvement_Yields
--==========================================================================================================================
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_FISHING_BOATS';
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_PLANTATION';

UPDATE Improvement_TechYieldChanges
SET Yield = 2
WHERE ImprovementType = 'IMPROVEMENT_CUSTOMS_HOUSE';

UPDATE Improvement_TechYieldChanges
SET Yield = 2
WHERE ImprovementType = 'IMPROVEMENT_MANUFACTORY';

INSERT INTO Improvement_TechYieldChanges 	
			(ImprovementType,					TechType,			YieldType,			Yield)
VALUES		('IMPROVEMENT_BRAZILWOOD_CAMP',		'TECH_MACHINERY',	'YIELD_PRODUCTION',	1);
--==========================================================================================================================
-- Improvement_TechNoFreshWaterYieldChanges
--==========================================================================================================================
INSERT INTO Improvement_TechNoFreshWaterYieldChanges 	
			(ImprovementType,				TechType,				YieldType,		Yield)
VALUES		('IMPROVEMENT_PLANTATION',		'TECH_FERTILIZER',		'YIELD_FOOD',	1);
--==========================================================================================================================
-- Improvement_TechFreshWaterYieldChanges
--==========================================================================================================================
INSERT INTO Improvement_TechFreshWaterYieldChanges 	
			(ImprovementType,				TechType,				YieldType,		Yield)
VALUES		('IMPROVEMENT_PLANTATION',		'TECH_CIVIL_SERVICE',	'YIELD_FOOD',	1);
--==========================================================================================================================
--==========================================================================================================================