--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================	
INSERT INTO Civilizations
			(Type, 								Description, 							ShortDescription, 								Adjective, 									Civilopedia, 	CivilopediaTag, 		DefaultPlayerColor, 	ArtDefineTag, 					ArtStyleType, 			ArtStyleSuffix, ArtStylePrefix, IconAtlas, 			PortraitIndex, 	AlphaIconAtlas,		SoundtrackTag, 	MapImage, 					DawnOfManQuote, 					DawnOfManImage)
VALUES		('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TXT_KEY_CIV_JFD_GREAT_BRITAIN_DESC', 	'TXT_KEY_CIV_JFD_GREAT_BRITAIN_SHORT_DESC',		'TXT_KEY_CIV_JFD_GREAT_BRITAIN_ADJECTIVE',	null, 			'TXT_KEY_CIV5_ENGLAND', 'PLAYERCOLOR_ENGLAND',	'ART_DEF_CIVILIZATION_ENGLAND', 'ARTSTYLE_EUROPEAN', 	'_EURO', 		'EUROPEAN ', 	'CIV_COLOR_ATLAS', 	6, 				'CIV_ALPHA_ATLAS',	'England', 		'GreatBritainMap512.dds', 	'TXT_KEY_CIV_JFD_VICTORIA_DAWN', 	'Victoria_DOM.dds');
--------------------------------	
-- England
--------------------------------
INSERT OR REPLACE INTO Civilizations
			(Type, 						Description, 				ShortDescription, 					Adjective, 							Civilopedia, 	CivilopediaTag, 		DefaultPlayerColor, 		ArtDefineTag, 					ArtStyleType, 			ArtStyleSuffix, ArtStylePrefix, IconAtlas, 					PortraitIndex, 	AlphaIconAtlas,						SoundtrackTag, 	MapImage, 				DawnOfManQuote, 					DawnOfManImage, 		DawnOfManAudio)
VALUES		('CIVILIZATION_ENGLAND',	'TXT_KEY_CIV_ENGLAND_DESC', 'TXT_KEY_CIV_ENGLAND_SHORT_DESC',	'TXT_KEY_CIV_ENGLAND_ADJECTIVE',	null, 			'TXT_KEY_CIV5_ENGLAND', 'PLAYERCOLOR_JFD_ENGLAND',	'ART_DEF_CIVILIZATION_ENGLAND', 'ARTSTYLE_EUROPEAN', 	'_EURO', 		'EUROPEAN ', 	'JFD_GREAT_BRITAIN_ATLAS', 	0, 				'JFD_GREAT_BRITAIN_ALPHA_ATLAS',	'England', 		'MapEngland512.dds', 	'TXT_KEY_CIV5_DAWN_ENGLAND_TEXT', 	'DOM_Elizabeth.dds', 	'AS2D_DOM_SPEECH_ENGLAND');
--------------------------------	
-- Support to disable Elizabeth (ignore the above)
--------------------------------
INSERT INTO Policies
			(Type,							Description,						GridX,	GridY,	PortraitIndex,	IconAtlas,		IconAtlasAchieved,	GreatAdmiralRateModifier)
VALUES		('POLICY_ENGLAND_ADMIRALS',		'TXT_KEY_TRAIT_JFD_ENGLAND_SHORT',	1000,	1000,	47,				'POLICY_ATLAS',	'POLICY_A_ATLAS',	50);
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================	
INSERT INTO Civilization_CityNames
			(CivilizationType, 					CityName)
VALUES		('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_LONDON'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_BIRMINGHAM'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_LEEDS'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_MANCHESTER'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_EDINBURGH'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_DUBLIN'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_CARDIFF'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_BELFAST'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_GLASGOW'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_LIVERPOOL'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_NEWCASTLE'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_OXFORD'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_BRISTOL'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_ABERDEEN'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_SHEFFIELD'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_SOUTHAMPTON'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_PORTSMOUTH'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_LEICESTER'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_COVENTRY'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_BRIGHTON'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_SWANSEA'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_DUNDEE'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_CANTERBURG'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_CAMBRIDGE'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_PLYMOUTH'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_YORK'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_DERBY'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_NORWICH'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_EXETER'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_BATH'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_INVERNESS'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_NEWPORT'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 'TXT_KEY_CITY_NAME_JFD_VICTORIA_LONDONDERRY');

DELETE FROM Civilization_CityNames WHERE CivilizationType = 'CIVILIZATION_ENGLAND';
INSERT OR REPLACE INTO Civilization_CityNames 
			(CivilizationType, 			CityName)
VALUES		('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_01'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_02'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_03'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_04'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_05'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_06'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_07'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_08'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_09'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_10'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_11'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_12'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_13'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_14'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_15'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_16'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_17'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_18'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_19'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_20'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_21'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_22'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_23'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_24'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_25'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_26'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_27'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_28'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_29'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_CITY_NAME_JFD_ENGLAND_30');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================	
INSERT OR REPLACE INTO Civilization_FreeBuildingClasses
			(CivilizationType, 					BuildingClassType)
VALUES		('CIVILIZATION_JFD_GREAT_BRITAIN', 	'BUILDINGCLASS_PALACE');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================	
INSERT OR REPLACE INTO Civilization_FreeTechs
			(CivilizationType, 					TechType)
VALUES		('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TECH_AGRICULTURE');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================	
INSERT OR REPLACE INTO Civilization_FreeUnits
			(CivilizationType, 					UnitClassType, 			Count, 	UnitAIType)
VALUES		('CIVILIZATION_JFD_GREAT_BRITAIN', 	'UNITCLASS_SETTLER', 	1, 		'UNITAI_SETTLE');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================	
INSERT OR REPLACE INTO Civilization_Religions
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_JFD_GREAT_BRITAIN',	'RELIGION_PROTESTANTISM');
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================	
INSERT OR REPLACE INTO Civilization_Leaders
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_JFD_GREAT_BRITAIN',	'LEADER_JFD_VICTORIA');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================	
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 			BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_ENGLAND', 	'BUILDINGCLASS_THEATRE', 	'BUILDING_JFD_PLAYHOUSE');
--==========================================================================================================================	
-- Civilization_UnitClassOverrides
--==========================================================================================================================	
DELETE FROM Civilization_UnitClassOverrides WHERE CivilizationType = 'CIVILIZATION_ENGLAND';
INSERT OR REPLACE INTO Civilization_UnitClassOverrides
			(CivilizationType, 					UnitClassType, 			UnitType)
VALUES		('CIVILIZATION_ENGLAND', 			'UNITCLASS_GALLEASS', 	'UNIT_JFD_GRAND_CARRACK'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 	'UNITCLASS_FRIGATE', 	'UNIT_ENGLISH_SHIPOFTHELINE'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 	'UNITCLASS_RIFLEMAN', 	'UNIT_JFD_REDCOAT');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT OR REPLACE INTO Civilization_SpyNames
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TXT_KEY_SPY_NAME_JFD_GREAT_BRITAIN_0'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TXT_KEY_SPY_NAME_JFD_GREAT_BRITAIN_1'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TXT_KEY_SPY_NAME_JFD_GREAT_BRITAIN_2'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TXT_KEY_SPY_NAME_JFD_GREAT_BRITAIN_3'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TXT_KEY_SPY_NAME_JFD_GREAT_BRITAIN_4'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TXT_KEY_SPY_NAME_JFD_GREAT_BRITAIN_5'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TXT_KEY_SPY_NAME_JFD_GREAT_BRITAIN_6'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TXT_KEY_SPY_NAME_JFD_GREAT_BRITAIN_7'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TXT_KEY_SPY_NAME_JFD_GREAT_BRITAIN_8'),
			('CIVILIZATION_JFD_GREAT_BRITAIN', 	'TXT_KEY_SPY_NAME_JFD_GREAT_BRITAIN_9');

DELETE FROM Civilization_SpyNames WHERE CivilizationType = 'CIVILIZATION_ENGLAND';
INSERT OR REPLACE INTO Civilization_SpyNames
			(CivilizationType, 			SpyName)
VALUES		('CIVILIZATION_ENGLAND', 	'TXT_KEY_SPY_NAME_ENGLAND_0'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_SPY_NAME_ENGLAND_1'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_SPY_NAME_ENGLAND_2'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_SPY_NAME_ENGLAND_3'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_SPY_NAME_ENGLAND_4'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_SPY_NAME_ENGLAND_5'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_SPY_NAME_ENGLAND_6'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_SPY_NAME_ENGLAND_7'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_SPY_NAME_ENGLAND_8'),
			('CIVILIZATION_ENGLAND', 	'TXT_KEY_SPY_NAME_ENGLAND_9');
--==========================================================================================================================	
-- Civilization_Start_Along_Ocean
--==========================================================================================================================		
INSERT OR REPLACE INTO Civilization_Start_Along_Ocean 
			(CivilizationType, 					StartAlongOcean)
VALUES		('CIVILIZATION_JFD_GREAT_BRITAIN', 	1);
--==========================================================================================================================	
--==========================================================================================================================