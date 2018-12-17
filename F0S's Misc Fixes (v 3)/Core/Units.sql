--==========================================================================================================================	
-- Units
--==========================================================================================================================
-- Civilian Units
UPDATE Units
SET Cost = 50
WHERE Type = 'UNIT_CARAVAN';

UPDATE Units
SET Cost = 30
WHERE Type = 'UNIT_WORKBOAT';

UPDATE Units
SET Cost = 180
WHERE Type = 'UNIT_ARCHAEOLOGIST';

UPDATE Units
SET Moves = 4
WHERE Type = 'UNIT_GREAT_GENERAL';

UPDATE Units
SET FaithCost = 180, WorkRate = 1
WHERE Type = 'UNIT_MISSIONARY';

UPDATE Units
SET FaithCost = 180, Moves = 4
WHERE Type = 'UNIT_INQUISITOR';

-- Standard Units
UPDATE Units
SET Help = 'TXT_KEY_UNIT_F0S_BARBARIAN_AXMAN_HELP', Strategy = null
WHERE Type = 'UNIT_BARBARIAN_AXMAN';

UPDATE Units
SET Help = 'TXT_KEY_UNIT_F0S_GALLEY_HELP', Strategy = null
WHERE Type = 'UNIT_GALLEY';

UPDATE Units
SET Combat = 28
WHERE Type = 'UNIT_LANCER';

UPDATE Units
SET Combat = 30
WHERE Type = 'UNIT_PRIVATEER';

UPDATE Units
SET Moves = 4
WHERE Type = 'UNIT_IRONCLAD';

UPDATE Units
SET ObsoleteTech = 'TECH_BALLISTICS', GoodyHutUpgradeUnitClass = 'UNITCLASS_ANTI_TANK_GUN'
WHERE Type = 'UNIT_ARTILLERY';

UPDATE Units
SET PrereqTech = 'TECH_BALLISTICS', Combat = 33, RangedCombat = 44, Cost = 350, FaithCost = 700, Range = 3, CombatClass = 'UNITCOMBAT_SIEGE', DefaultUnitAI = 'UNITAI_CITY_BOMBARD', GoodyHutUpgradeUnitClass = 'UNITCLASS_ROCKET_ARTILLERY', AdvancedStartCost = 30, MoveRate = 'ARTILLERY'
WHERE Type = 'UNIT_ANTI_TANK_GUN';

UPDATE Units
SET FaithCost = 700, RequiresFaithPurchaseEnabled = 1
WHERE Type = 'UNIT_WWI_TANK';

UPDATE Units
SET Moves = 3
WHERE Type = 'UNIT_ROCKET_ARTILLERY';

UPDATE Units
SET Cost = 375, FaithCost = 750
WHERE Type = 'UNIT_MARINE';

UPDATE Units
SET Combat = 15
WHERE Type = 'UNIT_SWORDSMAN';

-- Unique Units
UPDATE Units
SET ExtraMaintenanceCost = 1, RangedCombat = 21, Cost = 115
WHERE Type = 'UNIT_VENETIAN_GALLEASS';

UPDATE Units
SET RangedCombat = 15
WHERE Type = 'UNIT_CHINESE_CHUKONU';

UPDATE Units
SET RangedCombat = 17, Moves = 4, CombatClass = 'UNITCOMBAT_MOUNTED_RANGED'
WHERE Type = 'UNIT_MONGOLIAN_KESHIK';

UPDATE Units
SET Combat = 15, Cost = 60, FaithCost = 120
WHERE Type = 'UNIT_KRIS_SWORDSMAN';

UPDATE Units
SET FaithCost = 400
WHERE Type = 'UNIT_SHOSHONE_COMANCHE_RIDERS';

UPDATE Units
SET FaithCost = 90
WHERE Type = 'UNIT_SHOSHONE_PATHFINDER';

UPDATE Units
SET Cost = 45, FaithCost = 90
WHERE Type = 'UNIT_BABYLONIAN_BOWMAN';

UPDATE Units
SET Cost = 30, FaithCost = 60
WHERE Type = 'UNIT_MAYAN_ATLATLIST';

UPDATE Units
SET RangedCombat = 8
WHERE Type = 'UNIT_INCAN_SLINGER';

UPDATE Units
SET CombatClass = 'UNITCOMBAT_MOUNTED_RANGED'
WHERE Type = 'UNIT_HUN_HORSE_ARCHER';

UPDATE Units
SET Combat = 18
WHERE Type = 'UNIT_ROMAN_LEGION';

UPDATE Units
SET Combat = 12
WHERE Type = 'UNIT_CELT_PICTISH_WARRIOR';

UPDATE Units
SET Moves = 3, CombatClass = 'UNITCOMBAT_MOUNTED_RANGED'
WHERE Type = 'UNIT_ARABIAN_CAMELARCHER';
--==========================================================================================================================	
-- Unit_AITypes
--==========================================================================================================================
DELETE FROM Unit_AITypes WHERE UnitType = 'UNIT_ANTI_TANK_GUN';

INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
VALUES		('UNIT_ANTI_TANK_GUN', 	'UNITAI_CITY_BOMBARD'),
			('UNIT_ANTI_TANK_GUN', 	'UNITAI_RANGED');
--==========================================================================================================================	
-- Unit_ClassUpgrades
--==========================================================================================================================
UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_ANTI_TANK_GUN'
WHERE UnitType = 'UNIT_ARTILLERY';

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_ROCKET_ARTILLERY'
WHERE UnitType = 'UNIT_ANTI_TANK_GUN';

INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 				UnitClassType)
VALUES		('UNIT_BATTLESHIP', 	'UNITCLASS_MISSILE_CRUISER');
--==========================================================================================================================	
-- Unit_Flavors
--==========================================================================================================================
DELETE FROM Unit_Flavors WHERE UnitType = 'UNIT_ANTI_TANK_GUN';

INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType,			Flavor)
VALUES		('UNIT_ANTI_TANK_GUN', 	'FLAVOR_OFFENSE',	6),
			('UNIT_ANTI_TANK_GUN', 	'FLAVOR_DEFENSE',	6),
			('UNIT_ANTI_TANK_GUN', 	'FLAVOR_RANGED',	12);
--==========================================================================================================================	
-- Unit_FreePromotions
--==========================================================================================================================
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_ANTI_TANK_GUN';
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_DESTROYER' AND PromotionType = 'PROMOTION_INTERCEPTION_II';
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_MISSILE_CRUISER' AND PromotionType = 'PROMOTION_INTERCEPTION_IV';
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_ROMAN_BALLISTA' AND PromotionType = 'PROMOTION_MUST_SET_UP';
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_ATOMIC_BOMB' AND PromotionType = 'PROMOTION_EVASION_I';
DELETE FROM Unit_FreePromotions WHERE UnitType = 'UNIT_CHINESE_CHUKONU' AND PromotionType = 'PROMOTION_SECOND_ATTACK';

INSERT INTO Unit_FreePromotions 	
			(UnitType, 						PromotionType)
VALUES		('UNIT_BRAZILIAN_PRACINHA', 	'PROMOTION_FOREIGN_LANDS'),
			('UNIT_HUN_HORSE_ARCHER', 		'PROMOTION_CAN_MOVE_AFTER_ATTACKING'),
			('UNIT_VENETIAN_GALLEASS', 		'PROMOTION_STEAM_POWERED'),
			('UNIT_VENETIAN_GALLEASS', 		'PROMOTION_FIRE_SUPPORT'),
			('UNIT_ANTI_TANK_GUN', 			'PROMOTION_INDIRECT_FIRE'),
			('UNIT_ANTI_TANK_GUN', 			'PROMOTION_ONLY_DEFENSIVE'),
			('UNIT_ANTI_TANK_GUN', 			'PROMOTION_CITY_SIEGE_WEAK'),
			('UNIT_ANTI_TANK_GUN', 			'PROMOTION_ANTI_TANK'),
			('UNIT_ANTI_TANK_GUN', 			'PROMOTION_NO_DEFENSIVE_BONUSES'),
			('UNIT_ANTI_TANK_GUN', 			'PROMOTION_MUST_SET_UP'),
			('UNIT_ANTI_TANK_GUN', 			'PROMOTION_SIGHT_PENALTY'),
			('UNIT_MISSILE_CRUISER', 		'PROMOTION_INTERCEPTION_III'),
			('UNIT_MISSILE_CRUISER', 		'PROMOTION_INDIRECT_FIRE'),
			('UNIT_DESTROYER', 				'PROMOTION_INTERCEPTION_III'),
			('UNIT_MARINE', 				'PROMOTION_STEAM_POWERED'),
			('UNIT_CHINESE_CHUKONU', 		'PROMOTION_LOGISTICS'),
			('UNIT_TREBUCHET', 				'PROMOTION_INDIRECT_FIRE');
--==========================================================================================================================	
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================
INSERT INTO Unit_ResourceQuantityRequirements 	
			(UnitType, 					ResourceType)
VALUES		('UNIT_HUN_HORSE_ARCHER', 	'RESOURCE_HORSE');
--==========================================================================================================================	
-- Unit_YieldFromKills
--==========================================================================================================================
UPDATE Unit_YieldFromKills
SET Yield = 100
WHERE UnitType = 'UNIT_CELT_PICTISH_WARRIOR';
--==========================================================================================================================		
--==========================================================================================================================