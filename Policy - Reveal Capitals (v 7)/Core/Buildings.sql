--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 		 		DefaultBuilding, 						Description)
VALUES		('BUILDINGCLASS_CS_DUMMY_SCIENCE', 			'BUILDING_CS_DUMMY_SCIENCE',			'TXT_KEY_BUILDING_F0S_CS_DUMMY_SCIENCE'),
			('BUILDINGCLASS_CS_DUMMY_CULTURE', 			'BUILDING_CS_DUMMY_CULTURE',			'TXT_KEY_BUILDING_F0S_CS_DUMMY_CULTURE'),
			('BUILDINGCLASS_CS_DUMMY_CULTURE_GA', 		'BUILDING_CS_DUMMY_CULTURE_GA',			'TXT_KEY_BUILDING_F0S_CS_DUMMY_CULTURE_GA'),
			('BUILDINGCLASS_POLICY_DUMMY_TRADE_ROUTE', 	'BUILDING_POLICY_DUMMY_TRADE_ROUTE',	'TXT_KEY_BUILDING_F0S_POLICY_DUMMY_TRADE_ROUTE'),
			('BUILDINGCLASS_MILITARISTIC_CS_BONUS', 	'BUILDING_MILITARISTIC_CS_BONUS',		'TXT_KEY_BUILDING_F0S_MILITARISTIC_CS_BONUS');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================		
INSERT INTO Buildings 	
			(Type, 						 			BuildingClass, 								GreatWorkCount, Cost,	FaithCost,	PrereqTech,	MinAreaSize,	NumTradeRouteBonus,	NeverCapture,	NukeImmune,	Description)
VALUES		('BUILDING_CS_DUMMY_SCIENCE', 			'BUILDINGCLASS_CS_DUMMY_SCIENCE', 			-1,				-1,		-1,			null, 		-1,				0,					1,				1,			'TXT_KEY_BUILDING_F0S_CS_DUMMY_SCIENCE'),
			('BUILDING_CS_DUMMY_CULTURE', 			'BUILDINGCLASS_CS_DUMMY_CULTURE', 			-1,				-1,		-1,			null, 		-1,				0,					1,				1,			'TXT_KEY_BUILDING_F0S_CS_DUMMY_CULTURE'),
			('BUILDING_CS_DUMMY_CULTURE_GA', 		'BUILDINGCLASS_CS_DUMMY_CULTURE_GA', 		-1,				-1,		-1,			null, 		-1,				0,					1,				1,			'TXT_KEY_BUILDING_F0S_CS_DUMMY_CULTURE_GA'),
			('BUILDING_POLICY_DUMMY_TRADE_ROUTE', 	'BUILDINGCLASS_POLICY_DUMMY_TRADE_ROUTE', 	-1,				-1,		-1,			null, 		-1,				1,					1,				1,			'TXT_KEY_BUILDING_F0S_POLICY_DUMMY_TRADE_ROUTE'),
			('BUILDING_MILITARISTIC_CS_BONUS', 		'BUILDINGCLASS_MILITARISTIC_CS_BONUS', 		-1,				-1,		-1,			null, 		-1,				0,					1,				1,			'TXT_KEY_BUILDING_F0S_MILITARISTIC_CS_BONUS');
--==========================================================================================================================	
-- Building_DomainFreeExperiences
--==========================================================================================================================		
INSERT INTO Building_DomainFreeExperiences 	
			(BuildingType, 								DomainType, Experience)
SELECT		('BUILDING_MILITARISTIC_CS_BONUS'),			DomainType, 5
FROM Building_DomainFreeExperiences WHERE (BuildingType = 'BUILDING_BARRACKS');
--==========================================================================================================================		
--==========================================================================================================================		