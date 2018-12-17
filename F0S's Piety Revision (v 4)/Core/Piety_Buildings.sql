--==========================================================================================================================
-- BUILDING CLASSES
--==========================================================================================================================
-- BuildingClasses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding, 							Description)
VALUES	('BUILDINGCLASS_F0S_ALTAR', 				'BUILDING_F0S_ALTAR', 						'TXT_KEY_BUILDING_F0S_ALTAR');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding, 							Description)
VALUES	('BUILDINGCLASS_F0S_CHURCH', 				'BUILDING_F0S_CHURCH', 						'TXT_KEY_BUILDING_F0S_CHURCH');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding, 							Description)
VALUES	('BUILDINGCLASS_F0S_SYNAGOGUE', 			'BUILDING_F0S_SYNAGOGUE', 					'TXT_KEY_BUILDING_F0S_SYNAGOGUE');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding, 							Description,						MaxGlobalInstances)
VALUES	('BUILDINGCLASS_F0S_RELIQUARY', 			'BUILDING_F0S_RELIQUARY', 					'TXT_KEY_BUILDING_F0S_RELIQUARY',	1);

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding)
VALUES	('BUILDINGCLASS_F0S_PIETY_DUMMY_TRADE', 	'BUILDING_F0S_PIETY_DUMMY_TRADE');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding)
VALUES	('BUILDINGCLASS_F0S_PIETY_DUMMY_FAITH', 	'BUILDING_F0S_PIETY_DUMMY_FAITH');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding)
VALUES	('BUILDINGCLASS_F0S_PIETY_DUMMY_GOLDEN_AGE','BUILDING_F0S_PIETY_DUMMY_GOLDEN_AGE');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding)
VALUES	('BUILDINGCLASS_F0S_PIETY_DUMMY_DIPLOMAT', 	'BUILDING_F0S_PIETY_DUMMY_DIPLOMAT');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding)
VALUES	('BUILDINGCLASS_F0S_PIETY_DUMMY_SPY', 		'BUILDING_F0S_PIETY_DUMMY_SPY');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding)
VALUES	('BUILDINGCLASS_F0S_PIETY_DUMMY_PRESSURE', 	'BUILDING_F0S_PIETY_DUMMY_PRESSURE');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding)
VALUES	('BUILDINGCLASS_F0S_PIETY_DUMMY_GWP',	 	'BUILDING_F0S_PIETY_DUMMY_GWP');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding)
VALUES	('BUILDINGCLASS_F0S_PIETY_DUMMY_GAP', 		'BUILDING_F0S_PIETY_DUMMY_GAP');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding)
VALUES	('BUILDINGCLASS_F0S_PIETY_DUMMY_GMP', 		'BUILDING_F0S_PIETY_DUMMY_GMP');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding)
VALUES	('BUILDINGCLASS_F0S_PIETY_DUMMY_XP', 		'BUILDING_F0S_PIETY_DUMMY_XP');

INSERT INTO BuildingClasses 
		(Type, 										DefaultBuilding)
VALUES	('BUILDINGCLASS_F0S_PIETY_DUMMY_LAKES', 	'BUILDING_F0S_PIETY_DUMMY_LAKES');
--==========================================================================================================================
-- BUILDINGS
--==========================================================================================================================
-- Buildings
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Buildings
		(Type,										BuildingClass,								Cost,	FaithCost,	UnlockedByBelief,	Happiness,  	Description,						Civilopedia,							Strategy,										Help,										TrainedFreePromotion,				ReligiousPressureModifier,	ConquestProb,	ArtDefineTag,	MinAreaSize,	IconAtlas,						PortraitIndex)
VALUES	('BUILDING_F0S_ALTAR', 						'BUILDINGCLASS_F0S_ALTAR',					-1,		200,		1,					1,				'TXT_KEY_BUILDING_F0S_ALTAR',		'TXT_KEY_BUILDING_F0S_ALTAR_TEXT',		'TXT_KEY_BUILDING_F0S_ALTAR_STRATEGY',			'TXT_KEY_BUILDING_F0S_ALTAR_HELP',			'PROMOTION_F0S_ALTAR',				0,							100,			'TEMPLE',		-1,				'F0S_PIETY_BUILDINGS_ATLAS',	8);

INSERT INTO Buildings 																
		(Type,										BuildingClass,								Cost,	FaithCost,	UnlockedByBelief,	Happiness,  	Description,						Civilopedia,							Strategy,										Help,										TrainedFreePromotion,				ReligiousPressureModifier,	ConquestProb,	ArtDefineTag,	MinAreaSize,	IconAtlas,						PortraitIndex)
VALUES	('BUILDING_F0S_CHURCH',						'BUILDINGCLASS_F0S_CHURCH', 				-1,		200,		1,					1,				'TXT_KEY_BUILDING_F0S_CHURCH',		'TXT_KEY_BUILDING_F0S_CHURCH_TEXT',		'TXT_KEY_BUILDING_F0S_CHURCH_STRATEGY',			'TXT_KEY_BUILDING_F0S_CHURCH_HELP',			null,								50,							100,			'TEMPLE',		-1,				'F0S_PIETY_BUILDINGS_ATLAS',	0);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	FaithCost,	UnlockedByBelief,	Happiness,  	Description,						Civilopedia,							Strategy,										Help,										TrainedFreePromotion,				ReligiousPressureModifier,	ConquestProb,	ArtDefineTag,	MinAreaSize,	IconAtlas,						PortraitIndex)
VALUES	('BUILDING_F0S_SYNAGOGUE',					'BUILDINGCLASS_F0S_SYNAGOGUE',				-1,		200,		1,					1,				'TXT_KEY_BUILDING_F0S_SYNAGOGUE',	'TXT_KEY_BUILDING_F0S_SYNAGOGUE_TEXT',	'TXT_KEY_BUILDING_F0S_SYNAGOGUE_STRATEGY',		'TXT_KEY_BUILDING_F0S_SYNAGOGUE_HELP',		null,								0,							100,			'TEMPLE',		-1,				'F0S_PIETY_BUILDINGS_ATLAS',	1);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		ConquestProb,  	GreatWorkSlotType,					GreatWorkCount,	Description,						Help,										ThemingBonusHelp,							ArtDefineTag,	IconAtlas,						PortraitIndex,	ShowInPedia)
VALUES	('BUILDING_F0S_RELIQUARY',					'BUILDINGCLASS_F0S_RELIQUARY',				-1,		null,		-1,				-1,			1,				100,			'GREAT_WORK_SLOT_ART_ARTIFACT',		4,				'TXT_KEY_BUILDING_F0S_RELIQUARY',	'TXT_KEY_BUILDING_F0S_RELIQUARY_HELP',		'TXT_KEY_RELIQUARY_F0S_THEMING_BONUS_HELP',	'TEMPLE',		'F0S_PIETY_BUILDINGS_ATLAS',	5,				0);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		NeverCapture,	GreatWorkCount,	NumTradeRouteBonus,	IconAtlas,		PortraitIndex)
VALUES	('BUILDING_F0S_PIETY_DUMMY_TRADE',			'BUILDINGCLASS_F0S_PIETY_DUMMY_TRADE',		-1,		null,		-1,				-1,			1,				1,				-1,				1,					'BW_ATLAS_1',	63);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		NeverCapture,	GreatWorkCount,	IconAtlas,		PortraitIndex)
VALUES	('BUILDING_F0S_PIETY_DUMMY_FAITH',			'BUILDINGCLASS_F0S_PIETY_DUMMY_FAITH',		-1,		null,		-1,				-1,			1,				1,				-1,				'BW_ATLAS_1',	63);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		NeverCapture,	GreatWorkCount,	GoldenAge,		IconAtlas,		PortraitIndex)
VALUES	('BUILDING_F0S_PIETY_DUMMY_GOLDEN_AGE',		'BUILDINGCLASS_F0S_PIETY_DUMMY_GOLDEN_AGE',	-1,		null,		-1,				-1,			1,				1,				-1,				1,				'BW_ATLAS_1',	63);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		NeverCapture,	GreatWorkCount,	ExtraLeagueVotes,		IconAtlas,		PortraitIndex)
VALUES	('BUILDING_F0S_PIETY_DUMMY_DIPLOMAT',		'BUILDINGCLASS_F0S_PIETY_DUMMY_DIPLOMAT',	-1,		null,		-1,				-1,			1,				1,				-1,				1,						'BW_ATLAS_1',	63);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		NeverCapture,	GreatWorkCount,	ExtraSpies,		IconAtlas,		PortraitIndex)
VALUES	('BUILDING_F0S_PIETY_DUMMY_SPY',			'BUILDINGCLASS_F0S_PIETY_DUMMY_SPY',		-1,		null,		-1,				-1,			1,				1,				-1,				1,				'BW_ATLAS_1',	63);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		NeverCapture,	GreatWorkCount,	ReligiousPressureModifier,	IconAtlas,		PortraitIndex)
VALUES	('BUILDING_F0S_PIETY_DUMMY_PRESSURE',		'BUILDINGCLASS_F0S_PIETY_DUMMY_PRESSURE',	-1,		null,		-1,				-1,			1,				1,				-1,				100,						'BW_ATLAS_1',	63);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		NeverCapture,	GreatWorkCount,	SpecialistType,			GreatPeopleRateChange,	IconAtlas,		PortraitIndex)
VALUES	('BUILDING_F0S_PIETY_DUMMY_GWP',			'BUILDINGCLASS_F0S_PIETY_DUMMY_GWP',		-1,		null,		-1,				-1,			1,				1,				-1,				'SPECIALIST_WRITER',	1,						'BW_ATLAS_1',	63);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		NeverCapture,	GreatWorkCount,	SpecialistType,			GreatPeopleRateChange,	IconAtlas,		PortraitIndex)
VALUES	('BUILDING_F0S_PIETY_DUMMY_GAP',			'BUILDINGCLASS_F0S_PIETY_DUMMY_GAP',		-1,		null,		-1,				-1,			1,				1,				-1,				'SPECIALIST_ARTIST',	1,						'BW_ATLAS_1',	63);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		NeverCapture,	GreatWorkCount,	SpecialistType,			GreatPeopleRateChange,	IconAtlas,		PortraitIndex)
VALUES	('BUILDING_F0S_PIETY_DUMMY_GMP',			'BUILDINGCLASS_F0S_PIETY_DUMMY_GMP',		-1,		null,		-1,				-1,			1,				1,				-1,				'SPECIALIST_MUSICIAN',	1,						'BW_ATLAS_1',	63);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		NeverCapture,	GreatWorkCount,	IconAtlas,		PortraitIndex)
VALUES	('BUILDING_F0S_PIETY_DUMMY_XP',				'BUILDINGCLASS_F0S_PIETY_DUMMY_XP',			-1,		null,		-1,				-1,			1,				1,				-1,				'BW_ATLAS_1',	63);

INSERT INTO Buildings 															
		(Type,										BuildingClass,								Cost,	PrereqTech,	MinAreaSize,	FaithCost,	NukeImmune,		NeverCapture,	GreatWorkCount,	IconAtlas,		PortraitIndex)
VALUES	('BUILDING_F0S_PIETY_DUMMY_LAKES',			'BUILDINGCLASS_F0S_PIETY_DUMMY_LAKES',		-1,		null,		-1,				-1,			1,				1,				-1,				'BW_ATLAS_1',	63);

--Monastery
UPDATE Buildings
SET SpecialistType = 'SPECIALIST_SCIENTIST', SpecialistCount = 1, UnlockedByBelief = 0, Strategy = 'TXT_KEY_BUILDING_F0S_MONASTERY_STRATEGY_PIETY', Help = 'TXT_KEY_BUILDING_F0S_MONASTERY_HELP_PIETY'
WHERE Type = 'BUILDING_MONASTERY';
--------------------------------------------------------------------------------------------------------------------------
-- Building_ThemingBonuses
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_ThemingBonuses 
		(BuildingType, 					Description, 							Bonus,	MustBeArtifact,	RequiresOwner,	AIPriority)
VALUES	('BUILDING_F0S_RELIQUARY', 		'TXT_KEY_RELIQUARY_F0S_THEMING_BONUS', 	4,		1,				1,				5);
--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldChanges 
		(BuildingType, 						YieldType, 						Yield)
VALUES	('BUILDING_F0S_ALTAR', 				'YIELD_FAITH', 					1),
		('BUILDING_F0S_ALTAR', 				'YIELD_CULTURE', 				1);
		
INSERT INTO Building_YieldChanges 
		(BuildingType, 						YieldType, 						Yield)
VALUES	('BUILDING_F0S_CHURCH', 			'YIELD_FAITH', 					1),
		('BUILDING_F0S_CHURCH', 			'YIELD_CULTURE', 				1);

INSERT INTO Building_YieldChanges 
		(BuildingType, 						YieldType, 						Yield)
VALUES	('BUILDING_F0S_SYNAGOGUE', 			'YIELD_FAITH', 					2),
		('BUILDING_F0S_SYNAGOGUE', 			'YIELD_CULTURE', 				3);
		
INSERT INTO Building_YieldChanges 
		(BuildingType, 						YieldType, 						Yield)
VALUES	('BUILDING_F0S_PIETY_DUMMY_FAITH', 	'YIELD_FAITH', 					2);

INSERT INTO Building_YieldChanges 
		(BuildingType, 						YieldType, 						Yield)
VALUES	('BUILDING_F0S_RELIQUARY', 			'YIELD_CULTURE', 				2);
--------------------------------------------------------------------------------------------------------------------------
-- Building_YieldFromGreatWorksInBuilding
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_YieldFromGreatWorksInBuilding 
		(BuildingType, 						YieldType, 						Yield)
VALUES	('BUILDING_F0S_RELIQUARY', 			'YIELD_FAITH', 					2);
--------------------------------------------------------------------------------------------------------------------------
-- Building_ResourceYieldChanges
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Building_ResourceYieldChanges WHERE BuildingType = 'BUILDING_MONASTERY';
--------------------------------------------------------------------------------------------------------------------------
-- Building_LakePlotYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_LakePlotYieldChanges 
		(BuildingType, 						YieldType, 						Yield)
VALUES	('BUILDING_F0S_PIETY_DUMMY_LAKES', 	'YIELD_FOOD', 					1),
		('BUILDING_F0S_PIETY_DUMMY_LAKES', 	'YIELD_CULTURE', 				1);
--------------------------------------------------------------------------------------------------------------------------
-- Building_DomainFreeExperiences
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_DomainFreeExperiences 
		(BuildingType, 						DomainType, 					Experience)
VALUES	('BUILDING_F0S_PIETY_DUMMY_XP', 	'DOMAIN_LAND', 					15),
		('BUILDING_F0S_PIETY_DUMMY_XP', 	'DOMAIN_SEA', 					15),
		('BUILDING_F0S_PIETY_DUMMY_XP', 	'DOMAIN_AIR', 					15);
--------------------------------------------------------------------------------------------------------------------------
-- Building_Flavors
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Building_Flavors 
		(BuildingType, 				FlavorType, 				Flavor)
VALUES	('BUILDING_MONASTERY', 		'FLAVOR_SCIENCE',			5),
		('BUILDING_F0S_ALTAR', 		'FLAVOR_RELIGION',			2),
		('BUILDING_F0S_ALTAR', 		'FLAVOR_CULTURE',			2),
		('BUILDING_F0S_ALTAR', 		'FLAVOR_HAPPINESS',			4),
		('BUILDING_F0S_ALTAR', 		'FLAVOR_MILITARY_TRAINING',	4),
		('BUILDING_F0S_CHURCH', 	'FLAVOR_RELIGION',			6),
		('BUILDING_F0S_CHURCH', 	'FLAVOR_CULTURE',			2),
		('BUILDING_F0S_CHURCH', 	'FLAVOR_HAPPINESS',			4),
		('BUILDING_F0S_SYNAGOGUE', 	'FLAVOR_RELIGION',			2),
		('BUILDING_F0S_SYNAGOGUE', 	'FLAVOR_CULTURE',			4),
		('BUILDING_F0S_SYNAGOGUE', 	'FLAVOR_HAPPINESS',			4);
--==========================================================================================================================
--==========================================================================================================================