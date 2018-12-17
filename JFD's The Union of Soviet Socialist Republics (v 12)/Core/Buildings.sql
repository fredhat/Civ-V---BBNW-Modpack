--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 		 		DefaultBuilding, 									Description)
VALUES		('BUILDINGCLASS_JFD_STALIN_SATELLITES', 	'BUILDING_JFD_STALIN_SATELLITES', 					'TXT_KEY_BUILDING_JFD_STALIN_SATELLITES');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO Buildings 	
			(Type, 									BuildingClass, Cost, 	GoldMaintenance, PrereqTech, PlotCultureCostModifier,	Description, 										Civilopedia, 												Help, 												Strategy,								 				ArtDefineTag, 	MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, PortraitIndex, 	IconAtlas)
SELECT		('BUILDING_JFD_STALIN_COMMISSARIAT'),	BuildingClass, Cost-25, GoldMaintenance, PrereqTech, -25,						('TXT_KEY_BUILDING_JFD_STALIN_COMMISSARIAT_DESC'), 	('TXT_KEY_CIV5_BUILDINGS_JFD_STALIN_COMMISSARIAT_TEXT'), 	('TXT_KEY_BUILDING_JFD_STALIN_COMMISSARIAT_HELP'), 	('TXT_KEY_BUILDING_JFD_STALIN_COMMISSARIAT_STRATEGY'),	ArtDefineTag,	MinAreaSize, NeverCapture, Espionage, EspionageModifier, HurryCostModifier, 2, 				('JFD_USSR_STALIN_ATLAS')
FROM Buildings WHERE (Type = 'BUILDING_CONSTABLE');	

INSERT INTO Buildings 	
			(Type, 						 			BuildingClass, 							GreatWorkCount, Cost, FaithCost, PrereqTech,	Description, 								Help,											NeverCapture,	NukeImmune,	PortraitIndex,	IconAtlas)
VALUES		('BUILDING_JFD_STALIN_SATELLITES', 		'BUILDINGCLASS_JFD_STALIN_SATELLITES', 	-1,				-1,   -1, 		 null, 			'TXT_KEY_BUILDING_JFD_STALIN_SATELLITES', 	'TXT_KEY_BUILDING_JFD_STALIN_SATELLITES_HELP',	1,				1,			0,				'JFD_USSR_STALIN_ATLAS');
--==========================================================================================================================
-- Building_UnitCombatProductionModifiers
--==========================================================================================================================		
INSERT INTO Building_UnitCombatProductionModifiers
			(BuildingType, 						UnitCombatType,				Modifier)
VALUES		('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_RECON',			5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_ARCHER',		5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_MOUNTED',		5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_MELEE',			5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_SIEGE',			5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_GUN',			5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_ARMOR',			5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_HELICOPTER',	5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_NAVALRANGED',	5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_FIGHTER',		5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_BOMBER',		5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_NAVALMELEE',	5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_CARRIER',		5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_SUBMARINE',		5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_AA',			5),
			('BUILDING_JFD_STALIN_SATELLITES',	'UNITCOMBAT_MOUNTED_RANGED',5);
--==========================================================================================================================
-- Building_Flavors
--==========================================================================================================================		
INSERT INTO Building_Flavors 	
			(BuildingType, 							FlavorType, Flavor)
SELECT		('BUILDING_JFD_STALIN_COMMISSARIAT'),	FlavorType, Flavor
FROM Building_Flavors WHERE (BuildingType = 'BUILDING_CONSTABLE');	

INSERT INTO Building_Flavors 
			(BuildingType, 							FlavorType, 					Flavor)
VALUES		('BUILDING_JFD_STALIN_COMMISSARIAT', 	'FLAVOR_EXPANSION', 			20),
			('BUILDING_JFD_STALIN_COMMISSARIAT', 	'FLAVOR_PRODUCTION', 			25),
			('BUILDING_JFD_STALIN_COMMISSARIAT', 	'FLAVOR_MILITARY_TRAINING', 	15);
--==========================================================================================================================	
--==========================================================================================================================	