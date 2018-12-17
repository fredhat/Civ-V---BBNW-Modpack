--==========================================================================================================================
-- Civilization_UnitClassOverrides
--==========================================================================================================================
DELETE FROM Civilization_UnitClassOverrides WHERE UnitType = 'UNIT_GREEK_HOPLITE';
--==========================================================================================================================
-- Civilization_BuildingClassOverrides
--==========================================================================================================================
INSERT INTO Civilization_BuildingClassOverrides
			(CivilizationType, 			BuildingClassType, 					BuildingType)
VALUES		('CIVILIZATION_GREECE', 	'BUILDINGCLASS_AMPHITHEATER', 		'BUILDING_F0S_AGORA'),
			('CIVILIZATION_ROME', 		'BUILDINGCLASS_BARRACKS', 			'BUILDING_F0S_ROMAN_BARRACKS'),
			('CIVILIZATION_ROME', 		'BUILDINGCLASS_ARMORY', 			'BUILDING_F0S_ROMAN_ARMORY'),
			('CIVILIZATION_ROME', 		'BUILDINGCLASS_MILITARY_ACADEMY', 	'BUILDING_F0S_ROMAN_MILITARY_ACADEMY');
--==========================================================================================================================		
--==========================================================================================================================