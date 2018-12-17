--==========================================================================================================================
-- Units
--==========================================================================================================================	
INSERT INTO Units 	
			(Class,	Type, 					PrereqTech, 			 Combat, 	FaithCost, 		RequiresFaithPurchaseEnabled, Cost, 	Moves, 	CombatClass, Domain, DefaultUnitAI, Description, 					Civilopedia, 										Strategy, 								Help, 								MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 				UnitFlagAtlas, 					UnitFlagIconOffset, PortraitIndex,	IconAtlas)
SELECT		Class,	('UNIT_JFD_AXEMAN'), 	('TECH_BRONZE_WORKING'), 15, 		FaithCost-10, 	RequiresFaithPurchaseEnabled, Cost-5, 	Moves, 	CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_JFD_AXEMAN'), 	('TXT_KEY_CIVILOPEDIA_UNITS_VANDAL_AXEMAN_TEXT'), 	('TXT_KEY_UNIT_JFD_AXEMAN_STRATEGY'), 	('TXT_KEY_UNIT_HELP_JFD_AXEMAN'),	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, ('ART_DEF_UNIT_JFD_AXEMAN'), ('JFD_UNIT_FLAG_AXEMAN_ATLAS'), 0,					3, 				('JFD_THE_VANDALS_ATLAS')
FROM Units WHERE (Type = 'UNIT_SWORDSMAN');

INSERT INTO Units 	
			(Class,	Type, 						PrereqTech, Combat, 	Cost,	 Moves, CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 											Strategy, 									Help, 									MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, UnitFlagIconOffset, UnitFlagAtlas, PortraitIndex,  	IconAtlas, 					MoveRate)
SELECT		Class, 	('UNIT_JFD_TRIHEMIOLIA'),	PrereqTech, Combat+2, 	Cost+10, Moves, CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_JFD_TRIHEMIOLIA'), 	('TXT_KEY_CIVILOPEDIA_UNITS_VANDAL_TRIHEMIOLLA_TEXT'), 	('TXT_KEY_UNIT_JFD_TRIHEMIOLIA_STRATEGY'), 	('TXT_KEY_UNIT_HELP_JFD_TRIHEMIOLIA'), 	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, UnitFlagIconOffset, UnitFlagAtlas, 2, 			 	('JFD_THE_VANDALS_ATLAS'), 	MoveRate
FROM Units WHERE (Type = 'UNIT_TRIREME');

UPDATE Units 
SET UnitArtInfo = (CASE WHEN EXISTS(SELECT Type FROM Civilizations WHERE Type = 'CIVILIZATION_CARTHAGE')
		THEN 'ART_DEF_UNIT_U_CARTHAGE_QUINQUEREME'
		ELSE 'ART_DEF_UNIT_TRIREME' END) 
WHERE Type = 'UNIT_JFD_TRIHEMIOLIA';
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 				SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_AXEMAN'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SWORDSMAN');	

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_TRIHEMIOLIA'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_TRIREME');
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================	
INSERT INTO Unit_AITypes 
			(UnitType, 					UnitAIType)
VALUES		('UNIT_JFD_AXEMAN', 		'UNITAI_ATTACK'),	
			('UNIT_JFD_AXEMAN', 		'UNITAI_DEFENSE'),
			('UNIT_JFD_TRIHEMIOLIA', 	'UNITAI_ATTACK_SEA'),	
			('UNIT_JFD_TRIHEMIOLIA', 	'UNITAI_RESERVE_SEA'),
			('UNIT_JFD_TRIHEMIOLIA', 	'UNITAI_ESCORT_SEA'),	
			('UNIT_JFD_TRIHEMIOLIA', 	'UNITAI_EXPLORE_SEA');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================	
INSERT INTO Unit_Flavors 
			(UnitType, 					FlavorType, 						Flavor)
VALUES		('UNIT_JFD_AXEMAN', 		'FLAVOR_OFFENSE', 					5),	
			('UNIT_JFD_AXEMAN', 		'FLAVOR_DEFENSE', 					2),
			('UNIT_JFD_TRIHEMIOLIA', 	'FLAVOR_NAVAL_RECON', 				6),	
			('UNIT_JFD_TRIHEMIOLIA', 	'FLAVOR_NAVAL', 					14),	
			('UNIT_JFD_TRIHEMIOLIA', 	'FLAVOR_OFFENSE', 					6),	
			('UNIT_JFD_TRIHEMIOLIA', 	'FLAVOR_DEFENSE', 					3);
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================	
INSERT INTO Unit_FreePromotions 
			(UnitType, 						PromotionType)
VALUES		('UNIT_JFD_AXEMAN', 			'PROMOTION_CHARGE'),
			('UNIT_JFD_TRIHEMIOLIA', 		'PROMOTION_OCEAN_IMPASSABLE'),
			('UNIT_JFD_TRIHEMIOLIA', 		'PROMOTION_COASTAL_RAIDER_1'),
			('UNIT_JFD_TRIHEMIOLIA', 		'PROMOTION_COASTAL_RAIDER_2');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================	
INSERT INTO Unit_ClassUpgrades 
			(UnitType, 						UnitClassType)
VALUES		('UNIT_JFD_AXEMAN', 			'UNITCLASS_LONGSWORDSMAN'),
			('UNIT_JFD_TRIHEMIOLIA', 		'UNITCLASS_CARAVEL');	
--==========================================================================================================================	
--==========================================================================================================================	