--==========================================================================================================================
-- Improvements
--==========================================================================================================================
UPDATE Improvements
SET Help = 'TXT_KEY_IMPROVEMENTS_F0S_POLDER_HELP', Civilopedia = 'TXT_KEY_IMPROVEMENTS_F0S_POLDER_TEXT', Water = 1, AllowsWalkWater = 1, RequiresXAdjacentLand = 3, RequiresFeature = 0, Permanent = 1
WHERE Type = 'IMPROVEMENT_POLDER';
--==========================================================================================================================
-- Improvement_Yields
--==========================================================================================================================
UPDATE Improvement_Yields
SET Yield = 2
WHERE ImprovementType = 'IMPROVEMENT_POLDER';
--==========================================================================================================================
-- Improvement_TechYieldChanges
--==========================================================================================================================
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_POLDER' AND YieldType = 'YIELD_PRODUCTION';

INSERT INTO Improvement_TechYieldChanges 
			(ImprovementType, 		TechType, 			YieldType, 			Yield)
VALUES		('IMPROVEMENT_POLDER', 	'TECH_MACHINERY',	'YIELD_PRODUCTION',	1);
--==========================================================================================================================
-- Improvement_ValidFeatures
--==========================================================================================================================
DELETE FROM Improvement_ValidFeatures WHERE ImprovementType = 'IMPROVEMENT_POLDER';
--==========================================================================================================================
-- Improvement_ValidTerrains
--==========================================================================================================================
INSERT INTO Improvement_ValidTerrains
			(ImprovementType,		TerrainType)
VALUES		('IMPROVEMENT_POLDER',	'TERRAIN_COAST');
--==========================================================================================================================
--==========================================================================================================================