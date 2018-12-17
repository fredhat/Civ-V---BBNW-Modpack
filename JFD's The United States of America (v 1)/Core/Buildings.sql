--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 		 		DefaultBuilding, 						Description)
VALUES		('BUILDINGCLASS_JFD_LINCOLN_SPEECH_THREE', 	'BUILDING_JFD_LINCOLN_SPEECH_THREE',	'TXT_KEY_BUILDING_LINCOLN_SPEECH_THREE');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================		
INSERT INTO Buildings 	
			(Type, 						 				BuildingClass, 								GreatWorkCount, Cost,	FaithCost,	PrereqTech,	NeverCapture,	NukeImmune,	Description, 								Help)
VALUES		('BUILDING_JFD_LINCOLN_SPEECH_THREE', 		'BUILDINGCLASS_JFD_LINCOLN_SPEECH_THREE', 	-1,				-1,		-1,			null, 		1,				1,			'TXT_KEY_BUILDING_LINCOLN_SPEECH_THREE', 	'TXT_KEY_BUILDING_LINCOLN_SPEECH_THREE_HELP');
--==========================================================================================================================	
-- Building_DomainFreeExperiences
--==========================================================================================================================		
INSERT INTO Building_DomainFreeExperiences 	
			(BuildingType, 								DomainType, Experience)
SELECT		('BUILDING_JFD_LINCOLN_SPEECH_THREE'),		DomainType, Experience
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_BARRACKS');
--==========================================================================================================================		
--==========================================================================================================================		