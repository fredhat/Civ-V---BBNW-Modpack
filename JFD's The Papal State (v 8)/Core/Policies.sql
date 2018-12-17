--==========================================================================================================================	
-- Policy_BuildingClassYieldModifiers
--==========================================================================================================================
INSERT INTO Policy_BuildingClassYieldModifiers 
		(PolicyType, 			BuildingClassType, 					YieldType, 		YieldMod)
VALUES	('POLICY_THEOCRACY', 	'BUILDINGCLASS_JFD_CHAPEL_ART', 	'YIELD_GOLD',	10),
		('POLICY_THEOCRACY', 	'BUILDINGCLASS_JFD_CHAPEL_MUSIC', 	'YIELD_GOLD',	10);
--==========================================================================================================================	
-- Policy_BuildingClassProductionModifiers
--==========================================================================================================================
INSERT INTO Policy_BuildingClassProductionModifiers 
		(PolicyType, 			BuildingClassType, 					ProductionModifier)
VALUES	('POLICY_PIETY', 		'BUILDINGCLASS_JFD_CHAPEL_ART', 	50),
		('POLICY_PIETY', 		'BUILDINGCLASS_JFD_CHAPEL_MUSIC', 	50);
--==========================================================================================================================	
--==========================================================================================================================	