--==========================================================================================================================	
-- Belief_BuildingClassYieldChanges
--==========================================================================================================================
INSERT INTO Belief_BuildingClassYieldChanges 
		(BeliefType, 				BuildingClassType, 					YieldType, 				YieldChange)
VALUES	('BELIEF_FEED_WORLD', 		'BUILDINGCLASS_JFD_CHAPEL_ART', 	'YIELD_FOOD',			1),
		('BELIEF_FEED_WORLD', 		'BUILDINGCLASS_JFD_CHAPEL_MUSIC', 	'YIELD_FOOD',			1),
		('BELIEF_RELIGIOUS_ART', 	'BUILDINGCLASS_JFD_CHAPEL_ART', 	'YIELD_CULTURE',		1),
		('BELIEF_RELIGIOUS_ART', 	'BUILDINGCLASS_JFD_CHAPEL_MUSIC', 	'YIELD_CULTURE',		1);
--==========================================================================================================================	
--==========================================================================================================================