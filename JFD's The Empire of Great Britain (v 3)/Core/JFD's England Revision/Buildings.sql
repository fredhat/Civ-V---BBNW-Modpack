--==========================================================================================================================	
-- BUILDINGS
--==========================================================================================================================	
-- Buildings
------------------------------	
INSERT INTO Buildings 	
			(Type, 								BuildingClass, Cost,	GoldMaintenance, Happiness, GreatWorkSlotType,				GreatWorkCount, PrereqTech, FreeStartEra, Description, 							Civilopedia, 						 Help, 										Strategy,								 	ArtDefineTag, 	MinAreaSize, NeverCapture, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_PLAYHOUSE'),			BuildingClass, Cost,	0,				 Happiness, ('GREAT_WORK_SLOT_LITERATURE'),	1,				PrereqTech, FreeStartEra, ('TXT_KEY_BUILDING_JFD_PLAYHOUSE'),  ('TXT_KEY_CIV5_JFD_PLAYHOUSE_TEXT'), ('TXT_KEY_BUILDING_JFD_PLAYHOUSE_HELP'),   ('TXT_KEY_BUILDING_JFD_PLAYHOUSE_STRATEGY'), ArtDefineTag,	MinAreaSize, NeverCapture, HurryCostModifier, 3, 				('JFD_ENGLAND_HENRY_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_THEATRE');	
------------------------------	                                                                                                                 				
-- Building_ClassesNeededInCity
------------------------------		
INSERT INTO Building_ClassesNeededInCity 	
			(BuildingType, 						BuildingClassType)
SELECT		('BUILDING_JFD_PLAYHOUSE'),			BuildingClassType
FROM Building_ClassesNeededInCity WHERE (BuildingType = 'BUILDING_THEATRE');
------------------------------	
-- Building_Flavors
------------------------------		
INSERT INTO Building_Flavors 	
			(BuildingType, 						FlavorType,		Flavor)
SELECT		('BUILDING_JFD_PLAYHOUSE'),			FlavorType,		Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_THEATRE');

INSERT INTO Building_Flavors 	
			(BuildingType, 						FlavorType,						Flavor)
VALUES		('BUILDING_JFD_PLAYHOUSE',			'FLAVOR_CULTURE',				30);
--==========================================================================================================================	
-- GREAT WORKS
--==========================================================================================================================	
-- GreatWorks
--------------------------------	
INSERT INTO GreatWorks 
			(Type, 								GreatWorkClassType,			Description,								Quote,											Audio,							Image)
VALUES		('GREAT_WORK_JFD_ELIZABETHAN_1', 	'GREAT_WORK_LITERATURE',	'TXT_KEY_GREAT_WORK_JFD_ELIZABETHAN_1', 	'TXT_KEY_GREAT_WORK_QUOTE_JFD_ELIZABETHAN_1', 	'AS2D_GREAT_ARTIST_ARTWORK',	'GreatWriter_Background.dds'),
			('GREAT_WORK_JFD_ELIZABETHAN_2', 	'GREAT_WORK_LITERATURE',	'TXT_KEY_GREAT_WORK_JFD_ELIZABETHAN_2', 	'TXT_KEY_GREAT_WORK_QUOTE_JFD_ELIZABETHAN_2', 	'AS2D_GREAT_ARTIST_ARTWORK',	'GreatWriter_Background.dds'),
			('GREAT_WORK_JFD_ELIZABETHAN_3', 	'GREAT_WORK_LITERATURE',	'TXT_KEY_GREAT_WORK_JFD_ELIZABETHAN_3', 	'TXT_KEY_GREAT_WORK_QUOTE_JFD_ELIZABETHAN_3', 	'AS2D_GREAT_ARTIST_ARTWORK',	'GreatWriter_Background.dds'),
			('GREAT_WORK_JFD_ELIZABETHAN_4', 	'GREAT_WORK_LITERATURE',	'TXT_KEY_GREAT_WORK_JFD_ELIZABETHAN_4', 	'TXT_KEY_GREAT_WORK_QUOTE_JFD_ELIZABETHAN_4', 	'AS2D_GREAT_ARTIST_ARTWORK',	'GreatWriter_Background.dds');
--==========================================================================================================================		
--==========================================================================================================================