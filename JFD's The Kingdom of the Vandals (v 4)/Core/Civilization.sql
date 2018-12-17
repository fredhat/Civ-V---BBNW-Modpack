--==========================================================================================================================
-- Civilizations
--==========================================================================================================================			
INSERT INTO Civilizations 	
			(Type, 								Description, 							ShortDescription, 							Adjective, 									Civilopedia, 							CivilopediaTag, 				DefaultPlayerColor, 			 ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				AlphaIconAtlas, 					PortraitIndex,	SoundtrackTag, 	MapImage, 				DawnOfManQuote, 						DawnOfManImage)
SELECT		('CIVILIZATION_JFD_THE_VANDALS'), 	('TXT_KEY_CIV_JFD_THE_VANDALS_DESC'), 	('TXT_KEY_CIV_JFD_THE_VANDALS_SHORT_DESC'), ('TXT_KEY_CIV_JFD_THE_VANDALS_ADJECTIVE'), 	('TXT_KEY_CIV5_THE_VANDALS_TEXT_1'),	('TXT_KEY_CIV5_THE_VANDALS'), 	('PLAYERCOLOR_JFD_THE_VANDALS'), ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('JFD_THE_VANDALS_ATLAS'), ('JFD_THE_VANDALS_ALPHA_ATLAS'), 	0, 				('Songhai'), 	('VandalsMap512.dds'), 	('TXT_KEY_CIV5_DOM_JFD_GENSERIC_TEXT'), ('Genseric_DOM.dds')
FROM Civilizations WHERE (Type = 'CIVILIZATION_CARTHAGE');
--==========================================================================================================================
-- Civilization_CityNames
--==========================================================================================================================		
INSERT INTO Civilization_CityNames 
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_CAPUT_VARGA'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_HIPPO_REGIUS'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_LEPTUS_MAGNA'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_CARTENNA'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_BULLA_REGIA'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_LILYBAEUM'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_CATANE'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_CIRTA'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_CARALIS'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_ALERIA'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_PANORMUS'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_TACAPE'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_SALDE'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_CAPUT_VADA'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_TRICAMERON'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_HADRUMETUM'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_TRIPOLIS'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_CITY_NAME_JFD_THAGASTE');
--==========================================================================================================================
-- Civilization_FreeBuildingClasses
--==========================================================================================================================		
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
SELECT		('CIVILIZATION_JFD_THE_VANDALS'), 	BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE (CivilizationType = 'CIVILIZATION_CARTHAGE');
--==========================================================================================================================
-- Civilization_FreeTechs
--==========================================================================================================================	
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
SELECT		('CIVILIZATION_JFD_THE_VANDALS'), 	TechType
FROM Civilization_FreeTechs WHERE (CivilizationType = 'CIVILIZATION_CARTHAGE');
--==========================================================================================================================
-- Civilization_FreeUnits
--==========================================================================================================================	
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_JFD_THE_VANDALS'), 	UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE (CivilizationType = 'CIVILIZATION_CARTHAGE');
--==========================================================================================================================
-- Civilization_Leaders
--==========================================================================================================================		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_JFD_THE_VANDALS', 	'LEADER_JFD_GENSERIC');
--==========================================================================================================================
-- Civilization_UnitClassOverrides 
--==========================================================================================================================	
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_JFD_THE_VANDALS', 	'UNITCLASS_SWORDSMAN', 		'UNIT_JFD_AXEMAN'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'UNITCLASS_TRIREME', 		'UNIT_JFD_TRIHEMIOLIA');
--==========================================================================================================================
-- Civilization_Religions
--==========================================================================================================================	
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
SELECT		('CIVILIZATION_JFD_THE_VANDALS'), 	ReligionType			
FROM Civilization_Religions WHERE (CivilizationType = 'CIVILIZATION_DENMARK');
--==========================================================================================================================
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_SPY_NAME_JFD_THE_VANDALS_0'),	
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_SPY_NAME_JFD_THE_VANDALS_1'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_SPY_NAME_JFD_THE_VANDALS_2'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_SPY_NAME_JFD_THE_VANDALS_3'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_SPY_NAME_JFD_THE_VANDALS_4'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_SPY_NAME_JFD_THE_VANDALS_5'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_SPY_NAME_JFD_THE_VANDALS_6'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_SPY_NAME_JFD_THE_VANDALS_7'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_SPY_NAME_JFD_THE_VANDALS_8'),
			('CIVILIZATION_JFD_THE_VANDALS', 	'TXT_KEY_SPY_NAME_JFD_THE_VANDALS_9');
--==========================================================================================================================
-- Civilization_Start_Along_Ocean
--==========================================================================================================================	
INSERT INTO Civilization_Start_Along_Ocean 
			(CivilizationType, 					StartAlongOcean)
VALUES		('CIVILIZATION_JFD_THE_VANDALS', 	1);
--==========================================================================================================================	
--==========================================================================================================================