--=======================================================================================================================
-- BuildingClasses
--=======================================================================================================================
INSERT INTO BuildingClasses
			(Type, 										DefaultBuilding, 						Description)
VALUES		('BUILDINGCLASS_JFD_ITALIAN_PRODUCTION', 	'BUILDING_JFD_ITALIAN_PRODUCTION', 		'TXT_KEY_BUILDING_JFD_ITALIAN_PRODUCTION_DESC');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings		
			(Type, 										BuildingClass, 			  					BuildingProductionModifier, Cost, 	FaithCost,	GreatWorkCount,	GoldMaintenance, Happiness,		PrereqTech, Description, 								Help,											NeverCapture,	NukeImmune,	IconAtlas,		PortraitIndex,	ShowInPedia)
VALUES		('BUILDING_JFD_ITALIAN_PRODUCTION', 		'BUILDINGCLASS_JFD_ITALIAN_PRODUCTION', 	25,							-1, 	-1,			0,				0, 				 2,				null, 		'TXT_KEY_BUILDING_JFD_ITALIAN_PRODUCTION', 	'TXT_KEY_BUILDING_JFD_ITALIAN_PRODUCTION_HELP',	1,				1,			'BW_ATLAS_1',	27,				0);
--==========================================================================================================================	
--==========================================================================================================================