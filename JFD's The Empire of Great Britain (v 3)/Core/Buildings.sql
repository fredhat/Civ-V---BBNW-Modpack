--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 		 		DefaultBuilding, 					Description)
VALUES		('BUILDINGCLASS_JFD_VICTORIAN_DUMMY', 		'BUILDING_JFD_VICTORIAN_SCIENCE',	'TXT_KEY_BUILDING_JFD_VICTORIAN_SCIENCE'),
			('BUILDINGCLASS_JFD_VICTORIAN_TRACKER', 	'BUILDING_JFD_COLONY_TRACKER',		'TXT_KEY_BUILDING_JFD_COLONY_TRACKER'),
			('BUILDINGCLASS_JFD_VICTORIAN_REDCOAT', 	'BUILDING_JFD_REDCOAT_PRODUCTION',	'TXT_KEY_BUILDING_JFD_REDCOAT_PRODUCTION');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================		
INSERT INTO Buildings 	
			(Type, 						 			BuildingClass, 							GreatWorkCount, Cost,	FaithCost,	PrereqTech,	NukeImmune,	NeverCapture,	Description, 									Help,												IconAtlas,					PortraitIndex,	ShowInPedia)
VALUES		('BUILDING_JFD_VICTORIAN_SCIENCE', 		'BUILDINGCLASS_JFD_VICTORIAN_DUMMY', 	-1, 			-1,		-1, 		null,		1,			1,				'TXT_KEY_BUILDING_JFD_VICTORIAN_SCIENCE', 		'TXT_KEY_BUILDING_JFD_VICTORIAN_SCIENCE_HELP',		null,						0,				0),
			('BUILDING_JFD_VICTORIAN_GOLD', 		'BUILDINGCLASS_JFD_VICTORIAN_DUMMY', 	-1, 			-1,		-1, 		null,		1,			1,				'TXT_KEY_BUILDING_JFD_VICTORIAN_GOLD',		 	'TXT_KEY_BUILDING_JFD_VICTORIAN_GOLD_HELP',			null,						0,				0),
			('BUILDING_JFD_COLONY_TRACKER', 		'BUILDINGCLASS_JFD_VICTORIAN_TRACKER', 	0,	 			-1,		-1, 		null,		1,			1,				'TXT_KEY_BUILDING_JFD_COLONY_TRACKER',		 	'TXT_KEY_BUILDING_JFD_COLONY_TRACKER_HELP',			'EXPANSION_TECH_ATLAS_1',	2,				0),
			('BUILDING_JFD_REDCOAT_PRODUCTION', 	'BUILDINGCLASS_JFD_VICTORIAN_REDCOAT', 	-1, 			-1,		-1, 		null,		1,			1,				'TXT_KEY_BUILDING_JFD_REDCOAT_PRODUCTION', 		'TXT_KEY_BUILDING_JFD_REDCOAT_PRODUCTION_HELP',		null,  						0,				0);
--==========================================================================================================================								
-- Building_YieldChanges																																	
--==========================================================================================================================		
INSERT INTO Building_YieldChanges
			(BuildingType, 							YieldType, 			Yield)
VALUES		('BUILDING_JFD_VICTORIAN_SCIENCE', 		'YIELD_SCIENCE',	1),
			('BUILDING_JFD_VICTORIAN_GOLD', 		'YIELD_GOLD',		1);
--==========================================================================================================================								
-- Building_YieldModifiers																																	
--==========================================================================================================================		
INSERT INTO Building_YieldModifiers
			(BuildingType, 							YieldType, 			Yield)
VALUES		('BUILDING_JFD_REDCOAT_PRODUCTION', 	'YIELD_PRODUCTION',	1);
--==========================================================================================================================		
--==========================================================================================================================