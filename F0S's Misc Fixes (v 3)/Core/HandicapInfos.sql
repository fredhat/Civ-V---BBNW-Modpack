--==========================================================================================================================
-- HandicapInfos
--==========================================================================================================================
UPDATE HandicapInfos
SET HappinessDefault = 9, NumCitiesUnhappinessMod = 100, PopulationUnhappinessMod = 100, ProductionFreeUnits = 5, ProductionFreeUnitsPerCity = 2, RouteCostPercent = 100, UnitCostPercent = 100, BuildingCostPercent = 100, ResearchPercent = 100, PolicyPercent =100
WHERE Type = 'HANDICAP_AI_DEFAULT';
--==========================================================================================================================
-- HandicapInfo_Goodies
--==========================================================================================================================
DELETE FROM HandicapInfo_Goodies WHERE GoodyType = 'GOODY_MAP';
DELETE FROM HandicapInfo_Goodies WHERE GoodyType = 'GOODY_REVEAL_NEARBY_BARBS';

INSERT INTO HandicapInfo_Goodies 	
			(HandicapType,				GoodyType)
VALUES		('HANDICAP_SETTLER',		'GOODY_MAP'),
			('HANDICAP_CHIEFTAIN',		'GOODY_MAP'),
			('HANDICAP_WARLORD',		'GOODY_MAP'),
			('HANDICAP_PRINCE',			'GOODY_MAP'),
			('HANDICAP_AI_DEFAULT',		'GOODY_MAP'),
			('HANDICAP_SETTLER',		'GOODY_REVEAL_NEARBY_BARBS'),
			('HANDICAP_CHIEFTAIN',		'GOODY_REVEAL_NEARBY_BARBS'),
			('HANDICAP_AI_DEFAULT',		'GOODY_REVEAL_NEARBY_BARBS'),
			('HANDICAP_SETTLER',		'GOODY_WARRIOR'),
			('HANDICAP_CHIEFTAIN',		'GOODY_WARRIOR'),
			('HANDICAP_WARLORD',		'GOODY_WARRIOR'),
			('HANDICAP_PRINCE',			'GOODY_WARRIOR'),
			('HANDICAP_KING',			'GOODY_SCOUT'),
			('HANDICAP_EMPEROR',		'GOODY_SCOUT'),
			('HANDICAP_IMMORTAL',		'GOODY_SCOUT'),
			('HANDICAP_DEITY',			'GOODY_SCOUT'),
			('HANDICAP_SETTLER',		'GOODY_EXPERIENCE'),
			('HANDICAP_CHIEFTAIN',		'GOODY_EXPERIENCE'),
			('HANDICAP_WARLORD',		'GOODY_EXPERIENCE'),
			('HANDICAP_PRINCE',			'GOODY_EXPERIENCE'),
			('HANDICAP_KING',			'GOODY_EXPERIENCE'),
			('HANDICAP_EMPEROR',		'GOODY_EXPERIENCE'),
			('HANDICAP_IMMORTAL',		'GOODY_EXPERIENCE'),
			('HANDICAP_DEITY',			'GOODY_EXPERIENCE'),
			('HANDICAP_AI_DEFAULT',		'GOODY_EXPERIENCE');
--==========================================================================================================================
-- GoodyHuts
--==========================================================================================================================
UPDATE GoodyHuts
SET MapRange = 6, MapProb = 75
WHERE Type = 'GOODY_MAP';

UPDATE GoodyHuts
SET Experience = 15
WHERE Type = 'GOODY_EXPERIENCE';
--==========================================================================================================================		
--==========================================================================================================================