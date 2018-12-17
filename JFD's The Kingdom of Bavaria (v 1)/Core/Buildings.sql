--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 			DefaultBuilding, 					Description)
VALUES		('BUILDINGCLASS_JFD_BAVARIA_PRODUCTION','BUILDING_JFD_BAVARIAN_PRODUCTION',	'TXT_KEY_BUILDING_JFD_BAVARIAN_PRODUCTION'),
			('BUILDINGCLASS_JFD_BAVARIA_MUSIC', 	'BUILDING_JFD_BAVARIAN_MUSIC', 		'TXT_KEY_BUILDING_JFD_BAVARIAN_MUSIC'),
			('BUILDINGCLASS_JFD_BAVARIA_TOURISM', 	'BUILDING_JFD_BAVARIAN_TOURISM', 	'TXT_KEY_BUILDING_JFD_BAVARIAN_TOURISM');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 						 			BuildingClass, 							GreatWorkSlotType,			GreatWorkCount, Cost, FaithCost, PrereqTech, Description, 									Help,												WonderProductionModifier,	NeverCapture,	NukeImmune,	ConquestProb,	PortraitIndex,	IconAtlas)
VALUES		('BUILDING_JFD_BAVARIAN_MUSIC', 		'BUILDINGCLASS_JFD_BAVARIA_MUSIC', 		'GREAT_WORK_SLOT_MUSIC',	1, 				-1,   -1, 		 NULL, 		 'TXT_KEY_BUILDING_JFD_BAVARIAN_MUSIC', 		'TXT_KEY_BUILDING_JFD_BAVARIAN_MUSIC_HELP',			0,							0,				1,			100,			14,				'TECH_ATLAS_2'),
			('BUILDING_JFD_BAVARIAN_PRODUCTION', 	'BUILDINGCLASS_JFD_BAVARIA_PRODUCTION', null,						-1, 			-1,   -1, 		 NULL, 		 'TXT_KEY_BUILDING_JFD_BAVARIAN_PRODUCTION', 	'TXT_KEY_BUILDING_JFD_BAVARIAN_PRODUCTION_HELP',	25,							1,				1,			0,				0,				null),
			('BUILDING_JFD_BAVARIAN_TOURISM', 		'BUILDINGCLASS_JFD_BAVARIA_TOURISM', 	null,						-1, 			-1,   -1, 		 NULL, 		 'TXT_KEY_BUILDING_JFD_BAVARIAN_TOURISM', 		'TXT_KEY_BUILDING_JFD_BAVARIAN_TOURISM_HELP',		0,							1,				1,			0,				0,				null);
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================	
INSERT INTO Building_YieldChanges 	
			(BuildingType, 						 	YieldType, 			Yield)
VALUES		('BUILDING_JFD_BAVARIAN_TOURISM', 		'YIELD_TOURISM', 	1);
--==========================================================================================================================	
--==========================================================================================================================