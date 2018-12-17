--==========================================================================================================================	
-- BuildingsClasses
--==========================================================================================================================
INSERT INTO BuildingClasses 	
			(Type, 								DefaultBuilding, 				Description)
VALUES		('BUILDINGCLASS_PHOENICIA_GOLD', 	'BUILDING_PHOENICIA_GOLD', 		'TXT_KEY_BUILDING_PHOENICIA_GOLD');

-- Disabled for balance purposes		
--INSERT INTO BuildingClasses 	
--			(Type, 								DefaultBuilding, 				Description)
--VALUES		('BUILDINGCLASS_CEDARS_MERCHANT', 	'BUILDING_CEDARS_MERCHANT', 	'TXT_KEY_BUILDING_CEDARS_MERCHANT');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================
INSERT INTO Buildings 	
			(Type, 							BuildingClass, 						Description,						GreatWorkCount, Cost, FaithCost, PrereqTech,	NeverCapture,	NukeImmune)
VALUES		('BUILDING_PHOENICIA_GOLD', 	'BUILDINGCLASS_PHOENICIA_GOLD',		'TXT_KEY_BUILDING_PHOENICIA_GOLD',	-1, 			-1,   -1, 		 null,			1,				1);

-- Disabled for balance purposes
--INSERT INTO Buildings 	
--			(Type, 							BuildingClass, 						Description,						GreatWorkCount, Cost, FaithCost, PrereqTech,	SpecialistType,			GreatPeopleRateChange, 	NeverCapture,	NukeImmune)
--VALUES		('BUILDING_CEDARS_MERCHANT', 	'BUILDINGCLASS_CEDARS_MERCHANT',	'TXT_KEY_BUILDING_CEDARS_MERCHANT',	-1, 			-1,   -1, 		 null,			'SPECIALIST_MERCHANT',	3,						1,				1);
--==========================================================================================================================	
--==========================================================================================================================	