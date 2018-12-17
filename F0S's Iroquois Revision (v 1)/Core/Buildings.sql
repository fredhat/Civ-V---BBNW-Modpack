--==========================================================================================================================	
-- Buildings
--==========================================================================================================================			
UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_LONGHOUSE_HELP', Strategy = 'TXT_KEY_BUILDING_F0S_LONGHOUSE_STRATEGY'
WHERE Type = 'BUILDING_LONGHOUSE';
--==========================================================================================================================	
-- Building_YieldModifiers
--==========================================================================================================================
INSERT INTO Building_YieldModifiers 	
			(BuildingType, 				YieldType, 			Yield)
VALUES		('BUILDING_LONGHOUSE', 		'YIELD_PRODUCTION', 10);
--==========================================================================================================================		
--==========================================================================================================================