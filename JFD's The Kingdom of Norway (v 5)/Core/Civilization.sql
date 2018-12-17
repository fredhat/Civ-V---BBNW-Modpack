--==========================================================================================================================
-- Civilizations
--==========================================================================================================================			
INSERT INTO Civilizations 	
			(Type, 							Description, 						ShortDescription, 						Adjective, 								Civilopedia, 						CivilopediaTag, 				DefaultPlayerColor, 		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				AlphaIconAtlas, 			PortraitIndex,	SoundtrackTag, 	MapImage, 				DawnOfManQuote, 						DawnOfManImage)
SELECT		('CIVILIZATION_JFD_NORWAY'), 	('TXT_KEY_CIV_JFD_NORWAY_DESC'), 	('TXT_KEY_CIV_JFD_NORWAY_SHORT_DESC'), 	('TXT_KEY_CIV_JFD_NORWAY_ADJECTIVE'), 	('TXT_KEY_CIV5_NORWAY_TEXT_1'),		('TXT_KEY_CIV5_NORWAY'), 		('PLAYERCOLOR_JFD_NORWAY'), ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('JFD_NORWAY_ATLAS'),   ('JFD_NORWAY_ALPHA_ATLAS'), 0, 				('Denmark'), 	('NorwayMap512.dds'), 	('TXT_KEY_CIV5_DOM_JFD_HAAKON_TEXT'), 	('Haakon_DOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_DENMARK');
--==========================================================================================================================
-- Civilization_CityNames
--==========================================================================================================================		
DELETE FROM Civilization_CityNames WHERE CityName IN ('TXT_KEY_CITY_NAME_OSLO', 'TXT_KEY_CITY_NAME_BERGEN', 'TXT_KEY_CITY_NAME_TRONDHEIM');
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_OSLO'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_TRONDHEIM'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_BERGEN'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_EIDSVOLL'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_TROMSO'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_STAVANGER'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_TONSBERG'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_LILLEHAMMER'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_ROROS'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_SARPSBORG'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_ALESUND'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_BODO'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_KRISTIANSAND'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_AVALDSNES'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_ELVERUM'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_VARDO'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_GRIP'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_SANDNES'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_RJUKAN'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_DRAMMEN'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_ARENDAL'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_HALDEN'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_KONGSBERG'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_HAMAR'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_NAMSOS'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_SKIEN'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_EGERSUND'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_NORDKAPP'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_ALTA'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_LEVANGER'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_KAUTOKEINO'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_CITY_NAME_JFD_KARASJOK');
--==========================================================================================================================
-- Civilization_FreeBuildingClasses
--==========================================================================================================================		
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_JFD_NORWAY'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_DENMARK');
--==========================================================================================================================
-- Civilization_FreeTechs
--==========================================================================================================================	
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_JFD_NORWAY'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_DENMARK');
--==========================================================================================================================
-- Civilization_FreeUnits
--==========================================================================================================================	
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_JFD_NORWAY'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_DENMARK');
--==========================================================================================================================
-- Civilization_Leaders
--==========================================================================================================================		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_JFD_NORWAY', 	'LEADER_JFD_HAAKON');
--==========================================================================================================================
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================	
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 				BuildingType)
VALUES		('CIVILIZATION_JFD_NORWAY', 	'BUILDINGCLASS_TEMPLE', 		'BUILDING_JFD_STAVE_CHURCH');
--==========================================================================================================================
-- Civilization_UnitClassOverrides 
--==========================================================================================================================
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 					UnitType)
VALUES		('CIVILIZATION_JFD_NORWAY', 	'UNITCLASS_SWORDSMAN', 			'UNIT_JFD_BIRKEBEINER');
--==========================================================================================================================
-- Civilization_Religions
--==========================================================================================================================	
INSERT INTO Civilization_Religions
			(CivilizationType, 				ReligionType)
VALUES		('CIVILIZATION_JFD_NORWAY',		'RELIGION_CHRISTIANITY');
--==========================================================================================================================
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_SPY_NAME_JFD_NORWAY_0'),	
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_SPY_NAME_JFD_NORWAY_1'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_SPY_NAME_JFD_NORWAY_2'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_SPY_NAME_JFD_NORWAY_3'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_SPY_NAME_JFD_NORWAY_4'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_SPY_NAME_JFD_NORWAY_5'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_SPY_NAME_JFD_NORWAY_6'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_SPY_NAME_JFD_NORWAY_7'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_SPY_NAME_JFD_NORWAY_8'),
			('CIVILIZATION_JFD_NORWAY', 	'TXT_KEY_SPY_NAME_JFD_NORWAY_9');
--==========================================================================================================================
-- Civilization_Start_Along_Ocean
--==========================================================================================================================	
INSERT INTO Civilization_Start_Along_Ocean 
			(CivilizationType, 				StartAlongOcean)
VALUES		('CIVILIZATION_JFD_NORWAY', 	1);
--==========================================================================================================================	
--==========================================================================================================================