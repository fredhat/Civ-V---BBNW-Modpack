--==========================================================================================================================
-- Units
--==========================================================================================================================	
INSERT INTO Units 	
			(Class,	Type, 						PrereqTech, Combat, 	FaithCost,		RequiresFaithPurchaseEnabled, Cost,		Moves, 	CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 										Strategy, 									Help, 									MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, UnitArtInfo, 						UnitFlagAtlas, 							UnitFlagIconOffset, PortraitIndex,	IconAtlas)
SELECT		Class,	('UNIT_JFD_BIRKEBEINER'), 	PrereqTech, 15, 		FaithCost-30,	RequiresFaithPurchaseEnabled, Cost-15, 	Moves, 	CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_JFD_BIRKEBEINER'), 	('TXT_KEY_CIVILOPEDIA_UNITS_JFD_BIRKEBEINER_TEXT'), ('TXT_KEY_UNIT_JFD_BIRKEBEINER_STRATEGY'), 	('TXT_KEY_UNIT_HELP_JFD_BIRKEBEINER'),	MilitarySupport, MilitaryProduction, Pillage, ObsoleteTech, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, XPValueAttack, XPValueDefense, Conscription, ('ART_DEF_UNIT_JFD_BIRKEBEINER'), 	('JFD_UNIT_FLAG_BIRKEBEINER_ATLAS'),	0,					3, 				('JFD_NORWAY_ATLAS')
FROM Units WHERE (Type = 'UNIT_SWORDSMAN');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_BIRKEBEINER'), 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_SWORDSMAN');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================	
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_JFD_BIRKEBEINER'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_SWORDSMAN');
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================	
INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_JFD_BIRKEBEINER'), 		FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_SWORDSMAN');
--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================	
INSERT INTO Unit_ResourceQuantityRequirements 
			(UnitType, 						ResourceType)
VALUES		('UNIT_JFD_BIRKEBEINER', 		'RESOURCE_IRON');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================	
INSERT OR REPLACE INTO Unit_FreePromotions 
			(UnitType, 						PromotionType)
VALUES		('UNIT_JFD_BIRKEBEINER', 		'PROMOTION_JFD_BIRKEBEINER'),
			('UNIT_JFD_BIRKEBEINER', 		'PROMOTION_IGNORE_TERRAIN_COST');
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================	
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_JFD_BIRKEBEINER'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_SWORDSMAN');	
--==========================================================================================================================	
--==========================================================================================================================