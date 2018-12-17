--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================		
INSERT INTO Civilizations 	
			(Type, 										Description,								ShortDescription, 									Adjective, 	Civilopedia, 	CivilopediaTag,	DefaultPlayerColor, 					ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 							PortraitIndex, 	AlphaIconAtlas, 						SoundtrackTag, 	MapImage, 							DawnOfManQuote, 							DawnOfManImage)
SELECT		('CIVILIZATION_JFD_AMERICA_ROOSEVELT'), 	('TXT_KEY_CIV_JFD_AMERICA_ROOSEVELT_DESC'),	('TXT_KEY_CIV_JFD_AMERICA_ROOSEVELT_SHORT_DESC'),	Adjective,	Civilopedia, 	CivilopediaTag, ('PLAYERCOLOR_JFD_AMERICA_ROOSEVELT'), 	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('JFD_AMERICA_ROOSEVELT_ATLAS'), 	0, 				('JFD_AMERICA_ROOSEVELT_ALPHA_ATLAS'), 	('America'), 	('AmericaRooseveltMap512.dds'),		('TXT_KEY_CIV5_DOM_JFD_ROOSEVELT_TEXT'), 	('DOM_Roosevelt.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_AMERICA');
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================	
INSERT INTO Civilization_CityNames 
			(CivilizationType, 						CityName)
VALUES		('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_WASHINGTON'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_NEW_YORK'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_DETROIT'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_PHILADELPHIA'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_LOS_ANGELES'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_CHICAGO'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_BOSTON'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_BUFFALO'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_SAN_FRANCISCO'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_ATLANTA'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_HOUSTON'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_ST_LOUIS'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_SEATTLE'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_PORTLAND'),
			('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'TXT_KEY_CITY_NAME_JFD_ROOSEVELT_MIAMI');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 						BuildingClassType)
SELECT		('CIVILIZATION_JFD_AMERICA_ROOSEVELT'), BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_AMERICA');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 						TechType)
SELECT		('CIVILIZATION_JFD_AMERICA_ROOSEVELT'), TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_AMERICA');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 						UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_JFD_AMERICA_ROOSEVELT'), UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_AMERICA');
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 						LeaderheadType)
VALUES		('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'LEADER_JFD_ROOSEVELT');
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================	
DELETE FROM Civilization_UnitClassOverrides WHERE UnitType = 'UNIT_AMERICAN_B17';	
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 						UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'UNITCLASS_BOMBER', 		'UNIT_AMERICAN_B17');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================	
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 						BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_JFD_AMERICA_ROOSEVELT', 	'BUILDINGCLASS_FACTORY', 	'BUILDING_JFD_ARMS_FACTORY'),
			('CIVILIZATION_AMERICA',				'BUILDINGCLASS_STABLE', 	'BUILDING_JFD_RANCH');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================		
INSERT INTO Civilization_Religions 
			(CivilizationType, 						ReligionType)
SELECT		('CIVILIZATION_JFD_AMERICA_ROOSEVELT'), ReligionType
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_AMERICA');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 						SpyName)
SELECT		('CIVILIZATION_JFD_AMERICA_ROOSEVELT'), SpyName
FROM Civilization_SpyNames WHERE (CivilizationType = 'CIVILIZATION_AMERICA');
--==========================================================================================================================	
-- Civilization_Start_Region_Avoid
--==========================================================================================================================	
INSERT INTO Civilization_Start_Region_Avoid 
			(CivilizationType, 			RegionType)
VALUES		('CIVILIZATION_AMERICA', 	'REGION_HILLS');
--==========================================================================================================================		
--==========================================================================================================================