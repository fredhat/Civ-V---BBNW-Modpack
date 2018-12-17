--==========================================================================================================================
-- BuildingClasses
--==========================================================================================================================
INSERT INTO BuildingClasses
			(Type, 								DefaultBuilding, 				Description)
VALUES	    ('BUILDINGCLASS_JFD_OTTOMANS',		'BUILDING_JFD_OTTOMANS_FAITH', 	'TXT_KEY_JFD_OTTOMANS_FAITH');
--==========================================================================================================================
-- Buildings
--==========================================================================================================================
INSERT INTO Buildings
			(Type, 								BuildingClass, 					Cost,	FaithCost, 	GreatWorkCount,	NukeImmune, ConquestProb, 	PrereqTech, Description,					Help)
VALUES		('BUILDING_JFD_OTTOMANS_FAITH', 	'BUILDINGCLASS_JFD_OTTOMANS', 	-1, 	-1,			-1, 			1,			0,				null,		'TXT_KEY_JFD_OTTOMANS_FAITH',	'TXT_KEY_JFD_OTTOMANS_FAITH_HELP'),
			('BUILDING_JFD_OTTOMANS_CULTURE', 	'BUILDINGCLASS_JFD_OTTOMANS', 	-1, 	-1,			-1, 			1,			0,				null,		'TXT_KEY_JFD_OTTOMANS_CULTURE',	'TXT_KEY_JFD_OTTOMANS_CULTURE_HELP'),
			('BUILDING_JFD_OTTOMANS_SCIENCE', 	'BUILDINGCLASS_JFD_OTTOMANS', 	-1, 	-1,			-1, 			1,			0,				null,		'TXT_KEY_JFD_OTTOMANS_SCIENCE',	'TXT_KEY_JFD_OTTOMANS_SCIENCE_HELP'),
			('BUILDING_JFD_OTTOMANS_TRACK_F', 	'BUILDINGCLASS_JFD_OTTOMANS', 	-1, 	-1,			-1, 			1,			0,				null,		'TXT_KEY_JFD_OTTOMANS_FAITH',	'TXT_KEY_JFD_OTTOMANS_FAITH_HELP'),
			('BUILDING_JFD_OTTOMANS_TRACK_C', 	'BUILDINGCLASS_JFD_OTTOMANS', 	-1, 	-1,			-1, 			1,			0,				null,		'TXT_KEY_JFD_OTTOMANS_CULTURE',	'TXT_KEY_JFD_OTTOMANS_CULTURE_HELP'),
			('BUILDING_JFD_OTTOMANS_TRACK_S', 	'BUILDINGCLASS_JFD_OTTOMANS', 	-1, 	-1,			-1, 			1,			0,				null,		'TXT_KEY_JFD_OTTOMANS_SCIENCE',	'TXT_KEY_JFD_OTTOMANS_SCIENCE_HELP');

INSERT INTO Building_YieldChanges
			(BuildingType,						YieldType,			Yield)
VALUES		('BUILDING_JFD_OTTOMANS_FAITH',		'YIELD_FAITH',		1),
			('BUILDING_JFD_OTTOMANS_CULTURE',	'YIELD_CULTURE',	1),
			('BUILDING_JFD_OTTOMANS_SCIENCE',	'YIELD_SCIENCE',	1);
--==========================================================================================================================
-- Policies
--==========================================================================================================================	
INSERT INTO Policies
			(Type,							Description,							UnitUpgradeCostMod)
VALUES		('POLICY_JFD_VANDALS',			'TXT_KEY_TRAIT_JFD_VANDALS_SHORT',		-33);
--==========================================================================================================================
-- Traits
--==========================================================================================================================
INSERT INTO Traits
			(Type, 					Description, 					ShortDescription)
VALUES		('TRAIT_JFD_OTTOMANS', 	'TXT_KEY_TRAIT_JFD_OTTOMANS', 	'TXT_KEY_TRAIT_JFD_OTTOMANS_SHORT');

UPDATE Traits
SET Description = 'TXT_KEY_TRAIT_JFD_VANDALS', ShortDescription = 'TXT_KEY_TRAIT_JFD_VANDALS_SHORT'
WHERE Type = 'TRAIT_CONVERTS_SEA_BARBARIANS';
--==========================================================================================================================
-- Trait_SpecialistYieldChanges
--==========================================================================================================================
INSERT INTO Trait_SpecialistYieldChanges 
			(TraitType, 			SpecialistType, 		YieldType,			Yield)
VALUES		('TRAIT_JFD_OTTOMANS',	'SPECIALIST_WRITER',	'YIELD_FAITH',		1),
			('TRAIT_JFD_OTTOMANS',	'SPECIALIST_ARTIST',	'YIELD_FAITH',		1),
			('TRAIT_JFD_OTTOMANS',	'SPECIALIST_MUSICIAN',	'YIELD_FAITH',		1),
			('TRAIT_JFD_OTTOMANS',	'SPECIALIST_SCIENTIST',	'YIELD_FAITH',		1),
			('TRAIT_JFD_OTTOMANS',	'SPECIALIST_MERCHANT',	'YIELD_FAITH',		1),
			('TRAIT_JFD_OTTOMANS',	'SPECIALIST_ENGINEER',	'YIELD_FAITH',		1);
--==========================================================================================================================
--==========================================================================================================================