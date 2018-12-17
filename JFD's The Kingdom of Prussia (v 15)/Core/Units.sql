--==========================================================================================================================
-- Units
--==========================================================================================================================	
INSERT INTO Units 	
			(Class, Type, 						PrereqTech, Combat, 	Cost, 		FaithCost,		RequiresFaithPurchaseEnabled,	Moves, 	CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 							Strategy, 									Help, 								 	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,							PortraitIndex, 	IconAtlas)
SELECT		 Class, ('UNIT_JFD_LANDWEHR'), 		PrereqTech, Combat+2, 	Cost-15, 	FaithCost-30,	RequiresFaithPurchaseEnabled,	Moves,	CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_JFD_LANDWEHR'), 		('TXT_KEY_CIV5_JFD_LANDWEHR_TEXT'), 	('TXT_KEY_UNIT_JFD_LANDWEHR_STRATEGY'), 	('TXT_KEY_UNIT_HELP_JFD_LANDWEHR'),  	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, ObsoleteTech, XPValueDefense, GoodyHutUpgradeUnitClass, ('ART_DEF_UNIT_JFD_LANDWEHR'), 	0,					('JFD_UNIT_FLAG_LANDWEHR_ATLAS'),		2, 				('JFD_PRUSSIA_ATLAS')
FROM Units WHERE (Type = 'UNIT_RIFLEMAN');

INSERT INTO Units 	
			(Class,	Type, 						PrereqTech, Combat,		Cost,		FaithCost,		RequiresFaithPurchaseEnabled,	Moves,	CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 							Strategy, 									Help, 									MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,							PortraitIndex, 	IconAtlas,				MoveRate)
SELECT		 Class,	('UNIT_JFD_DEATHS_HEAD'),	PrereqTech, Combat+2, 	Cost,	 	FaithCost,		RequiresFaithPurchaseEnabled,	Moves,	CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_JFD_DEATHS_HEAD'), 	('TXT_KEY_CIV5_JFD_DEATHS_HEAD_TEXT'), 	('TXT_KEY_UNIT_JFD_DEATHS_HEAD_STRATEGY'), 	('TXT_KEY_UNIT_HELP_JFD_DEATHS_HEAD'), 	MilitarySupport, MilitaryProduction, Pillage, IgnoreBuildingDefense, AdvancedStartCost, GoodyHutUpgradeUnitClass, CombatLimit, ObsoleteTech, XPValueDefense, ('ART_DEF_UNIT_JFD_DEATHS_HEAD'),	0,					('JFD_UNIT_FLAG_DEATHS_HEAD_ATLAS'),	3, 				('JFD_PRUSSIA_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_CAVALRY');
--==========================================================================================================================
-- UnitGameplay2DScripts
--==========================================================================================================================	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_LANDWEHR'), 		SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_RIFLEMAN');
	
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_DEATHS_HEAD'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_CAVALRY');	
--==========================================================================================================================
-- Unit_AITypes
--==========================================================================================================================	
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_JFD_LANDWEHR'), 		UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_RIFLEMAN');	
	
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_JFD_DEATHS_HEAD'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_CAVALRY');	
--==========================================================================================================================
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================	
INSERT INTO Unit_ResourceQuantityRequirements 	
			(UnitType, 					ResourceType)
SELECT		('UNIT_JFD_DEATHS_HEAD'), 	ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_CAVALRY');	
--==========================================================================================================================
-- Unit_ClassUpgrades
--==========================================================================================================================	
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_JFD_LANDWEHR'),		UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_RIFLEMAN');	
	
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_JFD_DEATHS_HEAD'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_CAVALRY');	
--==========================================================================================================================
-- Unit_Flavors
--==========================================================================================================================	
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_JFD_LANDWEHR'), 		FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_RIFLEMAN');	

INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_JFD_DEATHS_HEAD'),	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_CAVALRY');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================	
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		('UNIT_JFD_DEATHS_HEAD'),	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_CAVALRY');

INSERT INTO Unit_FreePromotions 
			(UnitType, 					PromotionType)
VALUES		('UNIT_JFD_DEATHS_HEAD', 	'PROMOTION_JFD_DEATHS_HEAD'),
			('UNIT_JFD_DEATHS_HEAD', 	'PROMOTION_JFD_DEATHS_HEAD_1'),
			('UNIT_JFD_DEATHS_HEAD', 	'PROMOTION_JFD_DEATHS_HEAD_2'),
			('UNIT_JFD_LANDWEHR', 		'PROMOTION_MOBILITY'),
			('UNIT_JFD_LANDWEHR', 		'PROMOTION_CAN_MOVE_AFTER_ATTACKING');
--==========================================================================================================================	
--==========================================================================================================================