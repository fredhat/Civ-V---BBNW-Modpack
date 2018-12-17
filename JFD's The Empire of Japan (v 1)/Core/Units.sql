--==========================================================================================================================	
-- Units
--==========================================================================================================================		
INSERT INTO Units 	
			(Type, 					PrereqTech,	Class, Combat,	RangedCombat,	CombatClass,	Cost, Moves,	Range, Domain, DefaultUnitAI,			Description, 					Civilopedia, 						Strategy, 								Help, 								SpecialCargo,			DomainCargo,	Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, 					UnitFlagIconOffset, UnitFlagAtlas,					PortraitIndex, 	IconAtlas,					MoveRate)
SELECT		('UNIT_JFD_YAMATO'),	PrereqTech,	Class, Combat,	RangedCombat,	CombatClass,	Cost, Moves-1,	Range, Domain, ('UNITAI_CITY_BOMBARD'),	('TXT_KEY_UNIT_JFD_YAMATO'), 	('TXT_KEY_UNIT_JFD_YAMATO_TEXT'), 	('TXT_KEY_UNIT_JFD_YAMATO_STRATEGY'), 	('TXT_KEY_UNIT_HELP_JFD_YAMATO'), 	'SPECIALUNIT_FIGHTER',	'DOMAIN_AIR',	Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, ('ART_DEF_UNIT_JFD_YAMATO'), 	0,					('JFD_YAMATO_FLAG_ART_ATLAS'),	2, 				('JFD_JAPAN_TOJO_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_BATTLESHIP');

UPDATE Units
SET RangedCombat = 50, Cost = 350,  Help = 'TXT_KEY_UNIT_HELP_JFD_ZERO', Strategy = 'TXT_KEY_UNIT_JFD_ZERO_STRATEGY'
WHERE Type = 'UNIT_JAPANESE_ZERO';

UPDATE Units
SET Combat = 24, ObsoleteTech = 'TECH_RIFLING', GoodyHutUpgradeUnitClass = 'UNITCLASS_RIFLEMAN',  Help = 'TXT_KEY_UNIT_HELP_JFD_SAMURAI', Strategy = 'TXT_KEY_UNIT_JFD_SAMURAI_STRATEGY'
WHERE Type = 'UNIT_JAPANESE_SAMURAI';
--==========================================================================================================================	
-- Unit_YieldFromKills
--==========================================================================================================================		
INSERT INTO Unit_YieldFromKills 	
			(UnitType, 					YieldType, 			Yield)
VALUES		('UNIT_JAPANESE_SAMURAI', 	'YIELD_CULTURE', 	100);
--==========================================================================================================================	
-- UnitGameplay2DScripts
--==========================================================================================================================		
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_YAMATO'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_BATTLESHIP');
--==========================================================================================================================	
-- Unit_AITypes
--==========================================================================================================================		
INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_JFD_YAMATO'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_BATTLESHIP');

INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
SELECT		('UNIT_JFD_YAMATO'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_CARRIER');

INSERT INTO Unit_AITypes 	
			(UnitType, 				UnitAIType)
VALUES		('UNIT_JFD_YAMATO', 	'UNITAI_CITY_BOMBARD');
--==========================================================================================================================	
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================		
INSERT INTO Unit_ResourceQuantityRequirements 	
			(UnitType, 				ResourceType)
SELECT		('UNIT_JFD_YAMATO'), 	ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_BATTLESHIP');
--==========================================================================================================================	
-- Unit_ClassUpgrades
--==========================================================================================================================		
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 				UnitClassType)
VALUES		('UNIT_JFD_YAMATO', 	'UNITCLASS_MISSILE_CRUISER');

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_RIFLEMAN'
WHERE UnitType = 'UNIT_JAPANESE_SAMURAI';
--==========================================================================================================================	
-- Unit_Flavors
--==========================================================================================================================		
INSERT INTO Unit_Flavors 	
			(UnitType, 				FlavorType, Flavor)
SELECT		('UNIT_JFD_YAMATO'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_BATTLESHIP');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
DELETE FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_JAPANESE_SAMURAI' AND PromotionType = 'PROMOTION_SHOCK_1');

INSERT INTO Unit_FreePromotions 	
			(UnitType, 				PromotionType)
SELECT		('UNIT_JFD_YAMATO'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_BATTLESHIP');

INSERT INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
VALUES		('UNIT_JFD_YAMATO', 		'PROMOTION_JFD_YAMATO'),
			('UNIT_JFD_YAMATO', 		'PROMOTION_CARGO_II'),
			('UNIT_JAPANESE_ZERO', 		'PROMOTION_AIR_RANGE'),
			('UNIT_JAPANESE_SAMURAI', 	'PROMOTION_JFD_SAMURAI');
--==========================================================================================================================		
--==========================================================================================================================