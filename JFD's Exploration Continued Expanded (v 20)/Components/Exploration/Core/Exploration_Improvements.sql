--==========================================================================================================================
-- IMPROVEMENTS
--==========================================================================================================================
-- Improvement_ValidTerrains
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Improvement_ValidTerrains WHERE ImprovementType = 'IMPROVEMENT_FARM' AND TerrainType = 'TERRAIN_DESERT';
--------------------------------------------------------------------------------------------------------------------------
-- Improvement_ResourceTypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Improvement_ResourceTypes
		(ResourceType, 			ImprovementType)
SELECT	Type,					'IMPROVEMENT_LUMBERMILL'
FROM Resources WHERE Type IN ('RESOURCE_JFD_CEDAR', 'RESOURCE_JFD_OAK');

INSERT INTO Improvement_ResourceTypes
		(ResourceType, 			ImprovementType)
SELECT	Type,					'IMPROVEMENT_MINE'
FROM Resources WHERE Type IN ('RESOURCE_JFD_OBSIDIAN');

INSERT INTO Improvement_ResourceTypes
		(ResourceType, 			ImprovementType)
SELECT	Type,					'IMPROVEMENT_MINE'
FROM Resources WHERE Type IN ('RESOURCE_JFD_SULFUR');

INSERT INTO Improvement_ResourceTypes
		(ResourceType, 			ImprovementType)
SELECT	Type,					'IMPROVEMENT_PLANTATION'
FROM Resources WHERE Type IN ('RESOURCE_JFD_RUBBER');

INSERT INTO Improvement_ResourceTypes
		(ResourceType, 			ImprovementType)
SELECT	Type,					'IMPROVEMENT_PLANTATION'
FROM Resources WHERE Type IN ('RESOURCE_JFD_GINGER', 'RESOURCE_JFD_OPIUM', 'RESOURCE_JFD_SAFFRON', 'RESOURCE_JFD_VANILLA');

INSERT INTO Improvement_ResourceTypes
		(ResourceType, 				ImprovementType)
SELECT 	'RESOURCE_JFD_FEATHERS',	Type
FROM Improvements WHERE Type IN ('IMPROVEMENT_TRADING_POST_X', 'IMPROVEMENT_TRADING_POST', 'IMPROVEMENT_VILLAGE');

CREATE TRIGGER JFDExCE_Improvement_ResourceTypesFeathers
AFTER INSERT ON Improvements 
WHEN NEW.Type IN ('IMPROVEMENT_TRADING_POST_X', 'IMPROVEMENT_TRADING_POST', 'IMPROVEMENT_VILLAGE')
BEGIN
	INSERT INTO Improvement_ResourceTypes
			(ResourceType, 				ImprovementType)
	VALUES	('RESOURCE_JFD_FEATHERS',	NEW.Type);
END;
--------------------------------------------------------------------------------------------------------------------------
-- Improvement_ResourceType_Yields
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Improvement_ResourceType_Yields
		(ResourceType, 			ImprovementType,			YieldType,		Yield)
SELECT	Type,					'IMPROVEMENT_LUMBERMILL',	'YIELD_GOLD',	1
FROM Resources WHERE Type IN ('RESOURCE_JFD_CEDAR', 'RESOURCE_JFD_OAK');

INSERT INTO Improvement_ResourceType_Yields
		(ResourceType, 			ImprovementType,			YieldType,		Yield)
SELECT	Type,					'IMPROVEMENT_MINE',			'YIELD_GOLD',	1
FROM Resources WHERE Type IN ('RESOURCE_JFD_OBSIDIAN');

INSERT INTO Improvement_ResourceType_Yields
		(ResourceType, 			ImprovementType,			YieldType,		Yield)
SELECT	Type,					'IMPROVEMENT_MINE',			'YIELD_GOLD',	1
FROM Resources WHERE Type IN ('RESOURCE_JFD_SULFUR');

INSERT INTO Improvement_ResourceType_Yields
		(ResourceType, 			ImprovementType,			YieldType,		Yield)
SELECT	Type,					'IMPROVEMENT_PLANTATION',	'YIELD_GOLD',	1
FROM Resources WHERE Type IN ('RESOURCE_JFD_RUBBER');

INSERT INTO Improvement_ResourceType_Yields
		(ResourceType, 			ImprovementType,			YieldType,		Yield)
SELECT	Type,					'IMPROVEMENT_PLANTATION',	'YIELD_GOLD',	1
FROM Resources WHERE Type IN ('RESOURCE_JFD_SAFFRON');

INSERT INTO Improvement_ResourceType_Yields 	
		(ResourceType, 			ImprovementType,	YieldType, 		Yield)
SELECT	'RESOURCE_JFD_GINGER',	ImprovementType,	YieldType, 		Yield
FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_DYE';

INSERT INTO Improvement_ResourceType_Yields 	
		(ResourceType, 			ImprovementType,	YieldType, 		Yield)
SELECT	'RESOURCE_JFD_OPIUM',	ImprovementType,	YieldType, 		Yield
FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_DYE';

INSERT INTO Improvement_ResourceType_Yields 	
		(ResourceType, 			ImprovementType,	YieldType, 		Yield)
SELECT	'RESOURCE_JFD_VANILLA',	ImprovementType,	YieldType, 		Yield
FROM Improvement_ResourceType_Yields WHERE ResourceType = 'RESOURCE_SPICES';

INSERT INTO Improvement_ResourceType_Yields
		(ResourceType, 				ImprovementType,				YieldType,		Yield)
VALUES	('RESOURCE_JFD_FEATHERS',	'IMPROVEMENT_TRADING_POST_X',	'YIELD_GOLD',	1),
		('RESOURCE_JFD_FEATHERS',	'IMPROVEMENT_TRADING_POST',		'YIELD_GOLD',	1),
		('RESOURCE_JFD_FEATHERS',	'IMPROVEMENT_VILLAGE',			'YIELD_GOLD',	1);
--==========================================================================================================================
--==========================================================================================================================