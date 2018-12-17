--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================		
INSERT INTO Civilizations 	
			(Type, 							Description,				ShortDescription, 				Adjective, 						CivilopediaTag, 				DefaultPlayerColor, 		ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, IconAtlas, 			PortraitIndex, 	AlphaIconAtlas, 			SoundtrackTag, 	MapImage, 				DawnOfManQuote, 						DawnOfManAudio,					DawnOfManImage)
SELECT		('CIVILIZATION_TUSCANY'), 		('TXT_KEY_TUSCANY_DESC'),	('TXT_KEY_TUSCANY_SHORT_DESC'), ('TXT_KEY_TUSCANY_ADJECTIVE'),	('TXT_KEY_CIVLOPEDIA_TUSCANY'), ('PLAYERCOLOR_TUSCANY'), 	ArtDefineTag, ArtStyleType, ArtStyleSuffix, ArtStylePrefix, ('TUSCANY_ATLAS'), 	0, 				('TUSCANY_ALPHA_ATLAS'), 	('France'),		('TuscanyMap512.dds'),	('TXT_KEY_DAWN_OF_MAN_TUSCANY_TEXT'), 	('AS2D_DOM_SPEECH_TUSCANY'),	('Tuscany_DOM.dds')
FROM Civilizations WHERE Type = 'CIVILIZATION_ROME';
--==========================================================================================================================	
-- Civilization_CityNames
--==========================================================================================================================	
INSERT INTO Civilization_CityNames
			(CivilizationType, 			CityName)
VALUES		('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_FLORENCE'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_PISA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_SIENA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_LUCCA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_AREZZO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_PRATO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_GROSSETO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_SAN_GIMIGNANO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_FIESOLE'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_PIETRASANTA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_PISTOIA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_CARRARA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_PIENZA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_VOLTERRA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_LIVORNO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_CORTONA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_MONTEPULCIANO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_VIAREGGIO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_PITIGLIANO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_CASTIGLION_FIORENTINO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_LUCIGNANO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_SANSEPOLCRO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_CERTALDO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_ORBETELLO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_PIOMBINO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_BARGA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_CARMIGNANO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_MONTALCINO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_SUVERETO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_POPPI'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_FIVIZZANO'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_PONTREMOLI'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_PESCIA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_SCANDICCI'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_MONTEVARCHI'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_PONTEDERA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_QUARRATA'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_EMPOLI'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_MONTERIGGIONI'),
			('CIVILIZATION_TUSCANY', 	'TXT_KEY_CITY_NAME_TUSCANY_VINCI');
--==========================================================================================================================	
-- Civilization_FreeBuildingClasses
--==========================================================================================================================			
INSERT INTO Civilization_FreeBuildingClasses 
			(CivilizationType, 				BuildingClassType)
SELECT		('CIVILIZATION_TUSCANY'), 		BuildingClassType
FROM Civilization_FreeBuildingClasses WHERE CivilizationType = 'CIVILIZATION_ROME';
--==========================================================================================================================	
-- Civilization_FreeTechs
--==========================================================================================================================		
INSERT INTO Civilization_FreeTechs 
			(CivilizationType, 				TechType)
SELECT		('CIVILIZATION_TUSCANY'), 		TechType
FROM Civilization_FreeTechs WHERE CivilizationType = 'CIVILIZATION_ROME';
--==========================================================================================================================	
-- Civilization_FreeUnits
--==========================================================================================================================		
INSERT INTO Civilization_FreeUnits 
			(CivilizationType, 				UnitClassType, Count, UnitAIType)
SELECT		('CIVILIZATION_TUSCANY'), 		UnitClassType, Count, UnitAIType
FROM Civilization_FreeUnits WHERE CivilizationType = 'CIVILIZATION_ROME';
--==========================================================================================================================	
-- Civilization_Leaders
--==========================================================================================================================		
INSERT INTO Civilization_Leaders 
			(CivilizationType, 				LeaderheadType)
VALUES		('CIVILIZATION_TUSCANY', 		'LEADER_LORENZO');
--==========================================================================================================================	
-- Civilization_UnitClassOverrides 
--==========================================================================================================================		
INSERT INTO Civilization_UnitClassOverrides 
			(CivilizationType, 				UnitClassType, 				UnitType)
VALUES		('CIVILIZATION_TUSCANY', 		'UNITCLASS_KNIGHT', 		'UNIT_TUSCAN_CONDOTTIERE');
--==========================================================================================================================	
-- Civilization_BuildingClassOverrides 
--==========================================================================================================================	
INSERT INTO Civilization_BuildingClassOverrides 
			(CivilizationType, 				BuildingClassType, 			BuildingType)
VALUES		('CIVILIZATION_TUSCANY', 		'BUILDINGCLASS_GARDEN', 	'BUILDING_DUOMO');
--==========================================================================================================================	
-- Civilization_Religions
--==========================================================================================================================		
INSERT INTO Civilization_Religions 
			(CivilizationType, 				ReligionType)
VALUES		('CIVILIZATION_TUSCANY', 		'RELIGION_CHRISTIANITY');
--==========================================================================================================================	
-- Civilization_SpyNames
--==========================================================================================================================	
INSERT INTO Civilization_SpyNames 
			(CivilizationType, 				SpyName)
VALUES		('CIVILIZATION_TUSCANY', 		'TXT_KEY_SPY_NAME_TUSCANY_0'),
			('CIVILIZATION_TUSCANY', 		'TXT_KEY_SPY_NAME_TUSCANY_1'),
			('CIVILIZATION_TUSCANY', 		'TXT_KEY_SPY_NAME_TUSCANY_2'),
			('CIVILIZATION_TUSCANY', 		'TXT_KEY_SPY_NAME_TUSCANY_3'),
			('CIVILIZATION_TUSCANY', 		'TXT_KEY_SPY_NAME_TUSCANY_4'),
			('CIVILIZATION_TUSCANY', 		'TXT_KEY_SPY_NAME_TUSCANY_5'),
			('CIVILIZATION_TUSCANY', 		'TXT_KEY_SPY_NAME_TUSCANY_6'),
			('CIVILIZATION_TUSCANY', 		'TXT_KEY_SPY_NAME_TUSCANY_7'),
			('CIVILIZATION_TUSCANY', 		'TXT_KEY_SPY_NAME_TUSCANY_8'),
			('CIVILIZATION_TUSCANY', 		'TXT_KEY_SPY_NAME_TUSCANY_9');
--==========================================================================================================================		
--==========================================================================================================================