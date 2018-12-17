--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================	
INSERT INTO Civilizations
			(Type, 								Description, 					ShortDescription, 						Adjective, 								Civilopedia,						CivilopediaTag,				DefaultPlayerColor, 		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				PortraitIndex, 	AlphaIconAtlas, 			SoundtrackTag, 	MapImage, 				DawnOfManQuote, 						DawnOfManImage)
SELECT		('CIVILIZATION_JFD_ITALY'), 		('TXT_KEY_CIV_JFD_ITALY_DESC'), ('TXT_KEY_CIV_JFD_ITALY_SHORT_DESC'), 	('TXT_KEY_CIV_JFD_ITALY_ADJECTIVE'),	('TXT_KEY_CIV5_JFD_ITALY_TEXT_1'),	('TXT_KEY_CIV5_JFD_ITALY'), ('PLAYERCOLOR_JFD_ITALY'),	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('JFD_ITALY_ATLAS'),	0, 				('JFD_ITALY_ALPHA_ATLAS'), ('Rome'), 		('ItalyMap512.dds'), 	('TXT_KEY_CIV_JFD_MUSSOLINI_DAWN'), 	('DOM_Mussolini.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_VENICE');
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================	
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_NAME_ROME'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_MILAN'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_NAPLES'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_TURIN'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_PALERMO'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_VENICE'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_GENOA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_FLORENCE'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_BOLOGNA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_BARI'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_CATANIA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_VERONA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_PARMA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_LIVORNO'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_CAGLIARI'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_FOGGIA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_SALERNO'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_FORLI'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_PISA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_ASTI'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_MESSINA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_TRIESTE'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_PRATO'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_VICENZA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_BRESCIA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_MODENA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_PADUA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_SIRACUSA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_FERRARA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_NOVARA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_TARANTO'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_PERUGIA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_LATINA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_BERGAMO'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_PESCARA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_MONZA'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_SASSARI'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_RIMINI'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_TERNI'),
			('CIVILIZATION_JFD_ITALY', 			'TXT_KEY_CITY_JFD_ITALY_VITTORIA');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================	
INSERT INTO Civilization_FreeBuildingClasses
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_JFD_ITALY'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_VENICE');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================	
INSERT INTO Civilization_FreeTechs
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_JFD_ITALY'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_VENICE');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================	
INSERT INTO Civilization_FreeUnits
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_JFD_ITALY'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_VENICE');
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================	
INSERT INTO Civilization_Leaders
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_JFD_ITALY',		'LEADER_JFD_MUSSOLINI');
--==========================================================================================================================	
-- Civilization_UnitClassOverrides
--==========================================================================================================================	
INSERT INTO Civilization_UnitClassOverrides
			(CivilizationType, 				UnitClassType, 					UnitType)
VALUES		('CIVILIZATION_JFD_ITALY', 		'UNITCLASS_GREAT_WAR_INFANTRY', 'UNIT_JFD_CARABINEIRI'),
			('CIVILIZATION_JFD_ITALY', 		'UNITCLASS_IRONCLAD', 			'UNIT_JFD_CAIO_DUILIO_CLASS');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames
			(CivilizationType, 			SpyName)
VALUES		('CIVILIZATION_JFD_ITALY', 	'TXT_KEY_SPY_NAME_JFD_ITALY_0'),
			('CIVILIZATION_JFD_ITALY', 	'TXT_KEY_SPY_NAME_JFD_ITALY_1'),
			('CIVILIZATION_JFD_ITALY', 	'TXT_KEY_SPY_NAME_JFD_ITALY_2'),
			('CIVILIZATION_JFD_ITALY', 	'TXT_KEY_SPY_NAME_JFD_ITALY_3'),
			('CIVILIZATION_JFD_ITALY', 	'TXT_KEY_SPY_NAME_JFD_ITALY_4'),
			('CIVILIZATION_JFD_ITALY', 	'TXT_KEY_SPY_NAME_JFD_ITALY_5'),
			('CIVILIZATION_JFD_ITALY', 	'TXT_KEY_SPY_NAME_JFD_ITALY_6'),
			('CIVILIZATION_JFD_ITALY', 	'TXT_KEY_SPY_NAME_JFD_ITALY_7'),
			('CIVILIZATION_JFD_ITALY', 	'TXT_KEY_SPY_NAME_JFD_ITALY_8'),
			('CIVILIZATION_JFD_ITALY', 	'TXT_KEY_SPY_NAME_JFD_ITALY_9');
--==========================================================================================================================	
-- Civilization_Start_Along_Ocean
--==========================================================================================================================	
INSERT INTO Civilization_Start_Along_Ocean
			(CivilizationType, 					StartAlongOcean)
VALUES		('CIVILIZATION_JFD_ITALY', 			1);
--==========================================================================================================================	
--==========================================================================================================================