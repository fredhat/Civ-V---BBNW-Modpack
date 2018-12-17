--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================			
INSERT OR REPLACE INTO BuildingClasses 
			(DefaultBuilding, 							Type, 											Description)
VALUES		('BUILDING_JFD_VEGVAR_FAITH', 				'BUILDINGCLASS_JFD_VEGVAR',						'TXT_KEY_BUILDING_JFD_VEGVAR_FAITH'),
			('BUILDING_JFD_HUNGARY_DUMMY', 				'BUILDINGCLASS_JFD_HUNGARY_DUMMY',				'TXT_KEY_BUILDING_JFD_HUNGARY_DUMMY'),
			('BUILDING_JFD_AUSTRIAN_GREAT_PEOPLE_GEN', 	'BUILDINGCLASS_JFD_AUSTRIAN_GP', 				'TXT_KEY_BUILDING_JFD_AUSTRIAN_GREAT_PEOPLE_GEN'),
			('BUILDING_JFD_AUSTRIAN_WRITER', 			'BUILDINGCLASS_JFD_AUSTRIAN_SPECIALISTS', 		'TXT_KEY_BUILDING_JFD_AUSTRIAN_WRITER'),
			('BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM', 	'BUILDINGCLASS_JFD_AUSTRIAN_DRAGOON_TOURISM', 	'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM'),
			('BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_2', 'BUILDINGCLASS_JFD_AUSTRIAN_DRAGOON_TOURISM_2', 'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM'),
			('BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_3', 'BUILDINGCLASS_JFD_AUSTRIAN_DRAGOON_TOURISM_3', 'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM'),
			('BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_4', 'BUILDINGCLASS_JFD_AUSTRIAN_DRAGOON_TOURISM_4', 'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM'),
			('BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_5', 'BUILDINGCLASS_JFD_AUSTRIAN_DRAGOON_TOURISM_5', 'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================			
INSERT INTO Buildings
			(Type, 						BuildingClass, Cost,	GoldMaintenance,	PrereqTech, ExtraCityHitPoints,	Defense, ArtInfoCulturalVariation,	AllowsRangeStrike,	Description,					 Help,									Civilopedia,								Strategy,									ArtDefineTag, MinAreaSize, 	HurryCostModifier, 	IconAtlas,				ConquestProb, 	NukeImmune,	PortraitIndex)
SELECT		('BUILDING_JFD_VEGVAR'),	BuildingClass, Cost,	GoldMaintenance,	PrereqTech, ExtraCityHitPoints,	Defense, ArtInfoCulturalVariation,	AllowsRangeStrike,	('TXT_KEY_BUILDING_JFD_VEGVAR'), ('TXT_KEY_BUILDING_JFD_VEGVAR_HELP'),	('TXT_KEY_CIV5_BUILDINGS_JFD_VEGVAR_TEXT'),	('TXT_KEY_BUILDING_JFD_VEGVAR_STRATEGY'),	ArtDefineTag, MinAreaSize, 	HurryCostModifier, 	('JFD_HUNGARY_ATLAS'),	100, 			1,			3	
FROM Buildings WHERE Type = 'BUILDING_CASTLE';		

INSERT OR REPLACE INTO Buildings 
			(Type, 											BuildingClass, 									GreatWorkCount, Cost, 	FaithCost,	PrereqTech, TechEnhancedTourism,	EnhancedYieldTech,	ReligiousPressureModifier,	GreatPeopleRateModifier,	NeverCapture,	NukeImmune,	Description, 										Help)
VALUES		('BUILDING_JFD_AUSTRIAN_GREAT_PEOPLE_GEN', 		'BUILDINGCLASS_JFD_AUSTRIAN_GP',				-1,				-1, 	-1,			null, 		0,						null,				0,							1,							1,				1,			'TXT_KEY_BUILDING_JFD_AUSTRIAN_GREAT_PEOPLE_GEN',	'TXT_KEY_BUILDING_JFD_AUSTRIAN_GREAT_PEOPLE_GEN_HELP'),
			('BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM', 		'BUILDINGCLASS_JFD_AUSTRIAN_DRAGOON_TOURISM',	-1,				-1, 	-1,			null, 		1,						'TECH_RADIO',		0,							0,							1,				1,			'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM',	'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_HELP'),
			('BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_2', 	'BUILDINGCLASS_JFD_AUSTRIAN_DRAGOON_TOURISM_2',	-1,				-1, 	-1,			null, 		2,						'TECH_RADIO',		0,							0,							1,				1,			'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM',	'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_2_HELP'),
			('BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_3', 	'BUILDINGCLASS_JFD_AUSTRIAN_DRAGOON_TOURISM_3',	-1,				-1, 	-1,			null, 		3,						'TECH_RADIO',		0,							0,							1,				1,			'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM',	'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_3_HELP'),
			('BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_4', 	'BUILDINGCLASS_JFD_AUSTRIAN_DRAGOON_TOURISM_4',	-1,				-1, 	-1,			null, 		4,						'TECH_RADIO',		0,							0,							1,				1,			'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM',	'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_4_HELP'),
			('BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_5', 	'BUILDINGCLASS_JFD_AUSTRIAN_DRAGOON_TOURISM_5',	-1,				-1, 	-1,			null, 		5,						'TECH_RADIO',		0,							0,							1,				1,			'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM',	'TXT_KEY_BUILDING_JFD_AUSTRIAN_DRAGOON_TOURISM_5_HELP'),
			('BUILDING_JFD_VEGVAR_FAITH', 					'BUILDINGCLASS_JFD_VEGVAR',						-1,				-1, 	-1,			null, 		0,						null,				0,							0,							1,				1,			'TXT_KEY_BUILDING_JFD_VEGVAR_FAITH', 				'TXT_KEY_BUILDING_JFD_VEGVAR_FAITH_HELP'),
			('BUILDING_JFD_VEGVAR_PRESSURE', 				'BUILDINGCLASS_JFD_VEGVAR',						-1,				-1, 	-1,			null, 		0,						null,				25,							0,							1,				1,			'TXT_KEY_BUILDING_JFD_VEGVAR_PRESSURE', 			'TXT_KEY_BUILDING_JFD_VEGVAR_PRESSURE_HELP'),
			('BUILDING_JFD_HUNGARY_DUMMY', 					'BUILDINGCLASS_JFD_HUNGARY_DUMMY',				-1,				-1, 	-1,			null, 		0,						null,				0,							0,							1,				1,			'TXT_KEY_BUILDING_JFD_HUNGARY_DUMMY', 				'TXT_KEY_BUILDING_JFD_HUNGARY_DUMMY_HELP');

INSERT OR REPLACE INTO Buildings 	
			(Type, 						 					BuildingClass, 									GreatWorkCount,	Cost,	FaithCost,	PrereqTech,		Description, 								SpecialistType,			SpecialistCount,	NukeImmune,	NeverCapture,	IconAtlas,				PortraitIndex,	ShowInPedia)
VALUES		('BUILDING_JFD_AUSTRIAN_ARTIST', 				'BUILDINGCLASS_JFD_AUSTRIAN_SPECIALISTS', 		0,				-1,		-1, 		null, 			'TXT_KEY_BUILDING_JFD_AUSTRIAN_ARTIST',		'SPECIALIST_ARTIST',	1,					1, 			1,				'EXPANSION_BW_ATLAS_1',	4,				0),
			('BUILDING_JFD_AUSTRIAN_MUSICIAN', 				'BUILDINGCLASS_JFD_AUSTRIAN_SPECIALISTS', 		0,				-1,		-1, 		null, 			'TXT_KEY_BUILDING_JFD_AUSTRIAN_MUSICIAN',	'SPECIALIST_MUSICIAN',	1,					1, 			1,				'EXPANSION_BW_ATLAS_1',	4,				0);
			
UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_JFD_COFFEE_HOUSE_HELP', Strategy = 'TXT_KEY_BUILDING_JFD_COFFEE_HOUSE_STRATEGY', Happiness = 2, GreatPeopleRateModifier = 0, SpecialistType = 'SPECIALIST_WRITER', NukeImmune = 1, NeverCapture = 1
WHERE Type = 'BUILDING_COFFEE_HOUSE';
--==========================================================================================================================	
-- Building_ClassesNeededInCity
--==========================================================================================================================					
INSERT INTO Building_ClassesNeededInCity
			(BuildingType, 				BuildingClassType)
SELECT		('BUILDING_JFD_VEGVAR'),	BuildingClassType
FROM Building_ClassesNeededInCity WHERE BuildingType = 'BUILDING_CASTLE';	
--==========================================================================================================================	
-- Building_YieldChanges
--==========================================================================================================================					
INSERT INTO Building_YieldChanges 
			(BuildingType, 				YieldType,			Yield)
VALUES		('BUILDING_JFD_VEGVAR', 	'YIELD_CULTURE',	2);
--==========================================================================================================================	
-- Building_YieldModifiers
--==========================================================================================================================					
UPDATE Building_YieldModifiers
SET Yield = 10
WHERE BuildingType = 'BUILDING_COFFEE_HOUSE';
--==========================================================================================================================	
-- Building_Flavors
--==========================================================================================================================					
INSERT INTO Building_Flavors 
			(BuildingType, 					FlavorType,				Flavor)
VALUES		('BUILDING_JFD_VEGVAR', 		'FLAVOR_CITY_DEFENSE',	50),
			('BUILDING_JFD_VEGVAR', 		'FLAVOR_RELIGION',		10),
			('BUILDING_COFFEE_HOUSE',		'FLAVOR_CULTURE',		20);
--==========================================================================================================================		
--==========================================================================================================================