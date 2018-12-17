--=======================================================================================================================
-- UnitClasses
--=======================================================================================================================
INSERT INTO UnitClasses
			(Type, 							DefaultUnit, 			Description)
VALUES		('UNITCLASS_AIRSHIP', 			'UNIT_AIRSHIP', 		'TXT_KEY_MOD_UNIT_AIRSHIP'),
			('UNITCLASS_SKY_FORTRESS', 		'UNIT_SKY_FORTRESS', 	'TXT_KEY_MOD_UNIT_SKY_FORTRESS');
--==========================================================================================================================
-- Units
--==========================================================================================================================
UPDATE Units 
SET ObsoleteTech = 'TECH_STEAM_POWER', GoodyHutUpgradeUnitClass = 'UNITCLASS_AIRSHIP'
WHERE Type = 'UNIT_LANCER';

INSERT INTO Units 	
			(Type, 					Class, 						PrereqTech, 			ObsoleteTech,			Combat,	Cost,	FaithCost,	RequiresFaithPurchaseEnabled,	Moves,	CombatClass,				Domain,			DefaultUnitAI,			Description, 						Civilopedia,							Strategy,									Help, 									MilitarySupport,	MilitaryProduction,	Pillage,	IgnoreBuildingDefense,	SendCanMoveIntoEvent,	GoodyHutUpgradeUnitClass,		AdvancedStartCost,	XPValueAttack,	XPValueDefense,	UnitArtInfo,									MoveRate,	UnitFlagIconOffset,	UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
VALUES		('UNIT_AIRSHIP',		'UNITCLASS_AIRSHIP',		'TECH_STEAM_POWER',		'TECH_COMBUSTION',		45,		250,	500,		1,								4,		'UNITCOMBAT_HELICOPTER',	'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	'TXT_KEY_MOD_UNIT_AIRSHIP',			'TXT_KEY_MOD_UNIT_AIRSHIP_TEXT',		'TXT_KEY_MOD_UNIT_AIRSHIP_STRATEGY', 		'TXT_KEY_MOD_UNIT_AIRSHIP_HELP',		1,					1,					1,			1,						1,						'UNITCLASS_SKY_FORTRESS',		50,					3,				3,				'ART_DEF_UNIT_SMOKEY_STEAM_AIRSHIP_LEVEL_1',	'WHEELED',	7,					'EXPANSION_SCEN_UNIT_FLAG_ATLAS',	7, 				'EXPANSION_SCEN_UNIT_ATLAS'),
			('UNIT_SKY_FORTRESS',	'UNITCLASS_SKY_FORTRESS',	'TECH_COMBUSTION',		null,					60,		350,	700,		1,								4,		'UNITCOMBAT_HELICOPTER',	'DOMAIN_LAND',	'UNITAI_FAST_ATTACK',	'TXT_KEY_MOD_UNIT_SKY_FORTRESS',	'TXT_KEY_MOD_UNIT_SKY_FORTRESS_TEXT',	'TXT_KEY_MOD_UNIT_SKY_FORTRESS_STRATEGY', 	'TXT_KEY_MOD_UNIT_SKY_FORTRESS_HELP',	1,					1,					1,			1,						0,						'UNITCLASS_HELICOPTER_GUNSHIP',	30,					3,				3,				'ART_DEF_UNIT_SMOKEY_STEAM_AIRSHIP',			'WHEELED',	8,					'EXPANSION_SCEN_UNIT_FLAG_ATLAS',	8, 				'EXPANSION_SCEN_UNIT_ATLAS');

UPDATE Units 
SET Combat = 80, FaithCost = 850, RequiresFaithPurchaseEnabled = 1, Strategy = 'TXT_KEY_MOD_UNIT_HELICOPTER_GUNSHIP_STRATEGY', Help = 'TXT_KEY_MOD_UNIT_HELICOPTER_GUNSHIP_HELP'
WHERE Type = 'UNIT_HELICOPTER_GUNSHIP';			
--==========================================================================================================================	
-- UnitGameplay2DScripts
--==========================================================================================================================	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, 		FirstSelectionSound)
VALUES		('UNIT_AIRSHIP', 		'AS2D_SELECT_BOMBER', 	'AS2D_BIRTH_BOMBER'),
			('UNIT_SKY_FORTRESS', 	'AS2D_SELECT_BOMBER', 	'AS2D_BIRTH_BOMBER');
--==========================================================================================================================	
-- Unit_AITypes
--==========================================================================================================================		
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
VALUES		('UNIT_AIRSHIP', 			'UNITAI_FAST_ATTACK'),
			('UNIT_AIRSHIP', 			'UNITAI_ATTACK_SEA'),
			('UNIT_AIRSHIP', 			'UNITAI_EXPLORE_SEA'),
			('UNIT_AIRSHIP', 			'UNITAI_ESCORT_SEA'),
			('UNIT_SKY_FORTRESS', 		'UNITAI_FAST_ATTACK'),
			('UNIT_SKY_FORTRESS', 		'UNITAI_ATTACK_SEA'),
			('UNIT_SKY_FORTRESS', 		'UNITAI_EXPLORE_SEA'),
			('UNIT_SKY_FORTRESS', 		'UNITAI_ESCORT_SEA'),
			('UNIT_HELICOPTER_GUNSHIP', 'UNITAI_ATTACK_SEA'),
			('UNIT_HELICOPTER_GUNSHIP', 'UNITAI_EXPLORE_SEA'),
			('UNIT_HELICOPTER_GUNSHIP', 'UNITAI_ESCORT_SEA');
--==========================================================================================================================	
-- Unit_ClassUpgrades
--==========================================================================================================================		
UPDATE Unit_ClassUpgrades 
SET UnitClassType = 'UNITCLASS_AIRSHIP'
WHERE UnitType = 'UNIT_LANCER';

INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 				UnitClassType)
VALUES		('UNIT_AIRSHIP', 		'UNITCLASS_SKY_FORTRESS'),
			('UNIT_SKY_FORTRESS', 	'UNITCLASS_HELICOPTER_GUNSHIP');
--==========================================================================================================================	
-- Unit_Flavors
--==========================================================================================================================		
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, 			Flavor)
VALUES		('UNIT_AIRSHIP', 			'FLAVOR_OFFENSE', 		12),
			('UNIT_AIRSHIP', 			'FLAVOR_DEFENSE', 		12),
			('UNIT_AIRSHIP', 			'FLAVOR_MOBILE', 		10),
			('UNIT_AIRSHIP', 			'FLAVOR_NAVAL', 		18),
			('UNIT_AIRSHIP', 			'FLAVOR_NAVAL_RECON', 	6),
			('UNIT_SKY_FORTRESS', 		'FLAVOR_OFFENSE', 		12),
			('UNIT_SKY_FORTRESS', 		'FLAVOR_DEFENSE', 		12),
			('UNIT_SKY_FORTRESS', 		'FLAVOR_MOBILE', 		14),
			('UNIT_SKY_FORTRESS', 		'FLAVOR_NAVAL', 		18),
			('UNIT_SKY_FORTRESS', 		'FLAVOR_NAVAL_RECON', 	6),
			('UNIT_HELICOPTER_GUNSHIP', 'FLAVOR_NAVAL', 		18),
			('UNIT_HELICOPTER_GUNSHIP', 'FLAVOR_NAVAL_RECON', 	6);
--==========================================================================================================================	
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================		
INSERT INTO Unit_ResourceQuantityRequirements 	
			(UnitType, 					ResourceType)
VALUES		('UNIT_AIRSHIP', 			'RESOURCE_OIL'),
			('UNIT_SKY_FORTRESS', 		'RESOURCE_OIL');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_HELICOPTER_GUNSHIP' AND PromotionType = 'PROMOTION_FLAT_MOVEMENT_COST';
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_HELICOPTER_GUNSHIP' AND PromotionType = 'PROMOTION_HOVERING_UNIT';
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_HELICOPTER_GUNSHIP' AND PromotionType = 'PROMOTION_ANTI_TANK';

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
VALUES		('UNIT_AIRSHIP', 			'PROMOTION_ANTI_SIEGE'),
			('UNIT_AIRSHIP', 			'PROMOTION_INFERNAL_MOVEMENT_I'),
			('UNIT_AIRSHIP', 			'PROMOTION_NO_DEFENSIVE_BONUSES'),
			('UNIT_AIRSHIP', 			'PROMOTION_NO_CAPTURE'),
			('UNIT_AIRSHIP', 			'PROMOTION_EXTRA_SIGHT_I'),
			('UNIT_SKY_FORTRESS', 		'PROMOTION_ANTI_SIEGE'),
			('UNIT_SKY_FORTRESS', 		'PROMOTION_INFERNAL_MOVEMENT_II'),
			('UNIT_SKY_FORTRESS', 		'PROMOTION_NO_DEFENSIVE_BONUSES'),
			('UNIT_SKY_FORTRESS', 		'PROMOTION_NO_CAPTURE'),
			('UNIT_SKY_FORTRESS', 		'PROMOTION_EXTRA_SIGHT_I'),
			('UNIT_HELICOPTER_GUNSHIP', 'PROMOTION_ANTI_TANK_WEAK'),
			('UNIT_HELICOPTER_GUNSHIP', 'PROMOTION_INFERNAL_MOVEMENT_II'),
			('UNIT_HELICOPTER_GUNSHIP', 'PROMOTION_EXTRA_SIGHT_I'),
			('UNIT_HELICOPTER_GUNSHIP', 'PROMOTION_CLOSE_AIR_SUPPORT');
--==========================================================================================================================		
--==========================================================================================================================