--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================		
INSERT INTO Civilizations 	
			(Type, 							Description,				ShortDescription, 					Adjective, 					Civilopedia, 						CivilopediaTag, 				DefaultPlayerColor, 		ArtDefineTag, 						ArtStyleType, 			ArtStyleSuffix, ArtStylePrefix, IconAtlas, 				PortraitIndex, 	AlphaIconAtlas, 			SoundtrackTag, 	MapImage, 				DawnOfManQuote, 						DawnOfManImage)
VALUES		('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_JFD_BELGIUM_DESC',	'TXT_KEY_JFD_BELGIUM_SHORT_DESC', 	'TXT_KEY_JFD_BELGIUM_ADJ',	'TXT_KEY_CIV5_JFD_BELGIUM_TEXT_1', 	'TXT_KEY_CIV5_JFD_BELGIUM', 	'PLAYERCOLOR_JFD_BELGIUM', 	'ART_DEF_CIVILIZATION_ENGLAND', 	'ARTSTYLE_EUROPEAN', 	'_EURO', 		'EUROPEAN ',	'JFD_BELGIUM_ATLAS', 	0, 				'JFD_BELGIUM_ALPHA_ATLAS', 	'France', 		'BelgiumMap512.dds',	'TXT_KEY_CIV5_DOM_JFD_ALBERT_TEXT', 	'Albert_DOM.dds');
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================	
INSERT INTO Civilization_CityNames 
			(CivilizationType, 				CityName)
VALUES		('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_BRUSSELS'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_ANTWERP'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_GHENT'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_CHARLEROI'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_LIEGE'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_BRUGES'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_NAMUR'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_LEUVEN'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_MONS'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_AALST'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_MECHELEN'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_LA_LOUVIERE'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_KORTRIJE'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_HASSELT'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_OSTEND'),
			('CIVILIZATION_JFD_BELGIUM', 	'TXT_KEY_CITY_NAME_JFD_IXELLES');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 					BuildingClassType)
VALUES		('CIVILIZATION_JFD_BELGIUM', 		'BUILDINGCLASS_PALACE');
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 					TechType)
VALUES		('CIVILIZATION_JFD_BELGIUM', 		'TECH_AGRICULTURE');
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 					UnitClassType, 			Count, 	UnitAIType)
VALUES		('CIVILIZATION_JFD_BELGIUM', 		'UNITCLASS_SETTLER', 	1, 		'UNITAI_SETTLE');
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 					LeaderheadType)
VALUES		('CIVILIZATION_JFD_BELGIUM', 		'LEADER_JFD_ALBERT');
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 					UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_JFD_BELGIUM', 		'UNITCLASS_GATLINGGUN', 	'UNIT_JFD_CHASSEUR');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================	
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 					BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_JFD_BELGIUM', 		'BUILDINGCLASS_THEATRE', 	'BUILDING_JFD_CHOCOLATE_HOUSE');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================		
INSERT INTO Civilization_Religions 
			(CivilizationType, 					ReligionType)
VALUES		('CIVILIZATION_JFD_BELGIUM', 		'RELIGION_CHRISTIANITY');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 					SpyName)
VALUES		('CIVILIZATION_JFD_BELGIUM', 		'TXT_KEY_SPY_NAME_JFD_BELGIUM_0'),
			('CIVILIZATION_JFD_BELGIUM', 		'TXT_KEY_SPY_NAME_JFD_BELGIUM_1'),
			('CIVILIZATION_JFD_BELGIUM', 		'TXT_KEY_SPY_NAME_JFD_BELGIUM_2'),
			('CIVILIZATION_JFD_BELGIUM', 		'TXT_KEY_SPY_NAME_JFD_BELGIUM_3'),
			('CIVILIZATION_JFD_BELGIUM', 		'TXT_KEY_SPY_NAME_JFD_BELGIUM_4'),
			('CIVILIZATION_JFD_BELGIUM', 		'TXT_KEY_SPY_NAME_JFD_BELGIUM_5'),
			('CIVILIZATION_JFD_BELGIUM', 		'TXT_KEY_SPY_NAME_JFD_BELGIUM_6'),
			('CIVILIZATION_JFD_BELGIUM', 		'TXT_KEY_SPY_NAME_JFD_BELGIUM_7'),
			('CIVILIZATION_JFD_BELGIUM', 		'TXT_KEY_SPY_NAME_JFD_BELGIUM_8'),
			('CIVILIZATION_JFD_BELGIUM', 		'TXT_KEY_SPY_NAME_JFD_BELGIUM_9');
--==========================================================================================================================		
--==========================================================================================================================