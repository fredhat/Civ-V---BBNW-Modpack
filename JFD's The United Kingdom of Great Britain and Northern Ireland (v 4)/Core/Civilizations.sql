--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================	
INSERT INTO Civilizations
			(Type, 									Description, 								ShortDescription, 								Adjective, 										CivilopediaTag, 			DefaultPlayerColor, 				 ArtDefineTag, 						ArtStyleType, 			ArtStyleSuffix, ArtStylePrefix, IconAtlas, 						PortraitIndex, 	AlphaIconAtlas, 					SoundtrackTag, 	MapImage, 						DawnOfManQuote, 						DawnOfManImage)
VALUES		('CIVILIZATION_JFD_UNITED_KINGDOM', 	'TXT_KEY_CIV_JFD_UNITED_KINGDOM_DESC', 		'TXT_KEY_CIV_JFD_UNITED_KINGDOM_SHORT_DESC', 	'TXT_KEY_CIV_JFD_UNITED_KINGDOM_ADJECTIVE',		'TXT_KEY_CIV5_ENGLAND', 	'PLAYERCOLOR_JFD_UNITED_KINGDOM',	 'ART_DEF_CIVILIZATION_ENGLAND', 	'ARTSTYLE_EUROPEAN', 	'_EURO', 		'EUROPEAN ', 	'JFD_UNITED_KINGDOM_ATLAS', 	0, 				'JFD_UNITED_KINGDOM_ALPHA_ATLAS', 	'England', 		'UnitedKingdomMap512.dds', 		'TXT_KEY_CIV_JFD_CHURCHILL_DAWN', 		'Churchill_DOM.dds');
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================	
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_LONDON'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_BIRMINGHAM'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_LEEDS'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_MANCHESTER'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_EDINBURGH'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_CARDIFF'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_BELFAST'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_GLASGOW'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_LIVERPOOL'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_NEWCASTLE'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_OXFORD'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_BRISTOL'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_ABERDEEN'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_SHEFFIELD'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_SOUTHAMPTON'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_PORTSMOUTH'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_LEICESTER'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_COVENTRY'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_BRIGHTON'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_SWANSEA'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_DUNDEE'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_CANTERBURG'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_CAMBRIDGE'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_PLYMOUTH'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_YORK'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_DERBY'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_NORWICH'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_EXETER'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_BATH'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_INVERNESS'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_NEWPORT'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 'TXT_KEY_CITY_NAME_JFD_CHURCHILL_LONDONDERRY');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================	
INSERT INTO Civilization_FreeBuildingClasses
			(CivilizationType, 						BuildingClassType)
VALUES		('CIVILIZATION_JFD_UNITED_KINGDOM', 	'BUILDINGCLASS_PALACE');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================	
INSERT INTO Civilization_FreeTechs
			(CivilizationType, 						TechType)
VALUES		('CIVILIZATION_JFD_UNITED_KINGDOM',	 	'TECH_AGRICULTURE');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================	
INSERT INTO Civilization_FreeUnits
			(CivilizationType, 						UnitClassType, 			Count, 	UnitAIType)
VALUES		('CIVILIZATION_JFD_UNITED_KINGDOM', 	'UNITCLASS_SETTLER', 	1, 		'UNITAI_SETTLE');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================	
INSERT INTO Civilization_Religions
			(CivilizationType, 						ReligionType)
VALUES		('CIVILIZATION_JFD_UNITED_KINGDOM',		'RELIGION_PROTESTANTISM');
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================	
INSERT INTO Civilization_Leaders
			(CivilizationType, 						LeaderheadType)
VALUES		('CIVILIZATION_JFD_UNITED_KINGDOM',		'LEADER_JFD_CHURCHILL');
--==========================================================================================================================	
-- Civilization_UnitClassOverrides
--==========================================================================================================================	
INSERT INTO Civilization_UnitClassOverrides
			(CivilizationType, 						UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_JFD_UNITED_KINGDOM', 	'UNITCLASS_BATTLESHIP', 	'UNIT_JFD_DREADNOUGHT'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 	'UNITCLASS_FIGHTER', 		'UNIT_JFD_SPITFIRE');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames
			(CivilizationType, 						SpyName)
VALUES		('CIVILIZATION_JFD_UNITED_KINGDOM', 	'TXT_KEY_SPY_NAME_JFD_UNITED_KINGDOM_0'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 	'TXT_KEY_SPY_NAME_JFD_UNITED_KINGDOM_1'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 	'TXT_KEY_SPY_NAME_JFD_UNITED_KINGDOM_2'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 	'TXT_KEY_SPY_NAME_JFD_UNITED_KINGDOM_3'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 	'TXT_KEY_SPY_NAME_JFD_UNITED_KINGDOM_4'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 	'TXT_KEY_SPY_NAME_JFD_UNITED_KINGDOM_5'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 	'TXT_KEY_SPY_NAME_JFD_UNITED_KINGDOM_6'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 	'TXT_KEY_SPY_NAME_JFD_UNITED_KINGDOM_7'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 	'TXT_KEY_SPY_NAME_JFD_UNITED_KINGDOM_8'),
			('CIVILIZATION_JFD_UNITED_KINGDOM', 	'TXT_KEY_SPY_NAME_JFD_UNITED_KINGDOM_9');
--==========================================================================================================================	
-- Civilization_Start_Along_Ocean
--==========================================================================================================================		
INSERT INTO Civilization_Start_Along_Ocean 
			(CivilizationType, 						StartAlongOcean)
VALUES		('CIVILIZATION_JFD_UNITED_KINGDOM', 	1);
--==========================================================================================================================	
--==========================================================================================================================