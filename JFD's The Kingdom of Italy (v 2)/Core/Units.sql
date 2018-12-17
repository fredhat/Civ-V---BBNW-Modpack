--==========================================================================================================================	
-- Units
--==========================================================================================================================		
INSERT INTO Units 	
			(Class, 	Type, 						PrereqTech, Combat,		Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 							Strategy, 									Help, 									MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, Pillage, XPValueDefense, UnitArtInfoEraVariation, UnitArtInfo, 						UnitFlagIconOffset, UnitFlagAtlas,						PortraitIndex, 	IconAtlas)
SELECT		Class,		('UNIT_JFD_CARABINEIRI'), 	PrereqTech, Combat+4,	Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_JFD_CARABINEIRI'), ('TXT_KEY_CIV5_JFD_CARABINEIRI_TEXT'), 	('TXT_KEY_UNIT_JFD_CARABINEIRI_STRATEGY'), 	('TXT_KEY_UNIT_HELP_JFD_CARABINEIRI'), 	MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, AdvancedStartCost, CombatLimit, Pillage, XPValueDefense, UnitArtInfoEraVariation, ('ART_DEF_UNIT_JFD_CARABINEIRI'), 0,					('JFD_CARABINEIRI_FLAG_ART_ATLAS'),	2, 				('JFD_ITALY_ATLAS')
FROM Units WHERE (Type = 'UNIT_GREAT_WAR_INFANTRY');

INSERT INTO Units 	
			(Class, 	Type, 								PrereqTech, Combat,		Cost, FaithCost, RequiresFaithPurchaseEnabled, Moves, 	CombatClass, Domain, DefaultUnitAI, Description, 						Civilopedia, 											Strategy, 											Help, 											MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Pillage, AdvancedStartCost, CombatLimit, XPValueDefense, UnitArtInfoEraVariation, UnitArtInfo, 								UnitFlagIconOffset, UnitFlagAtlas,					PortraitIndex, 	IconAtlas,					MoveRate)
SELECT		Class,		('UNIT_JFD_CAIO_DUILIO_CLASS'), 	PrereqTech, Combat+5,	Cost, FaithCost, RequiresFaithPurchaseEnabled, 4, 		CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_CAIO_DUILIO_CLASS'),	('TXT_KEY_CIVILOPEDIA_UNITS_CAIO_DUILIO_CLASS_TEXT'), 	('TXT_KEY_UNIT_JFD_CAIO_DUILIO_CLASS_STRATEGY'), 	('TXT_KEY_UNIT_JFD_CAIO_DUILIO_CLASS_HELP'), 	MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Pillage, AdvancedStartCost, CombatLimit, XPValueDefense, UnitArtInfoEraVariation, ('ART_DEF_UNIT_CONFEDERATE_IRONCLAD'), 	1,					('CIVIL_WAR_UNIT_FLAG_ATLAS'),	3, 				('CIVIL_WAR_UNIT_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_IRONCLAD');
--==========================================================================================================================	
-- UnitGameplay2DScripts
--==========================================================================================================================		
INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_CARABINEIRI'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_WAR_INFANTRY');	

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 						SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_CAIO_DUILIO_CLASS'), SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_IRONCLAD');	
--==========================================================================================================================	
-- Unit_AITypes
--==========================================================================================================================		
INSERT INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_JFD_CARABINEIRI'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GREAT_WAR_INFANTRY');	

INSERT INTO Unit_AITypes 	
			(UnitType, 							UnitAIType)
SELECT		('UNIT_JFD_CAIO_DUILIO_CLASS'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_IRONCLAD');	
--==========================================================================================================================	
-- Unit_ClassUpgrades
--==========================================================================================================================		
INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_JFD_CARABINEIRI'), 	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_GREAT_WAR_INFANTRY');	

INSERT INTO Unit_ClassUpgrades 	
			(UnitType, 						UnitClassType)
SELECT		('UNIT_JFD_CAIO_DUILIO_CLASS'), UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_IRONCLAD');	
--==========================================================================================================================	
-- Unit_Flavors
--==========================================================================================================================		
INSERT INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_JFD_CARABINEIRI'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_WAR_INFANTRY');	

INSERT INTO Unit_Flavors 	
			(UnitType, 						FlavorType, Flavor)
SELECT		('UNIT_JFD_CAIO_DUILIO_CLASS'), FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_IRONCLAD');	
--==========================================================================================================================	
-- Unit_ResourceQuantityRequirements
--==========================================================================================================================		
INSERT INTO Unit_ResourceQuantityRequirements 	
			(UnitType, 						ResourceType)
SELECT		('UNIT_JFD_CAIO_DUILIO_CLASS'), ResourceType
FROM Unit_ResourceQuantityRequirements WHERE (UnitType = 'UNIT_IRONCLAD');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT INTO Unit_FreePromotions
			(UnitType, 						PromotionType)
VALUES		('UNIT_JFD_CARABINEIRI', 		'PROMOTION_JFD_CARABINEIRI'),
			('UNIT_JFD_CARABINEIRI', 		'PROMOTION_JFD_CARABINEIRI_POLICING'),
			('UNIT_JFD_CAIO_DUILIO_CLASS', 	'PROMOTION_STEAM_POWERED'),
			('UNIT_JFD_CAIO_DUILIO_CLASS', 	'PROMOTION_HEAVY_PAYLOAD'),
			('UNIT_JFD_CAIO_DUILIO_CLASS', 	'PROMOTION_COASTAL_RAIDER_1');
--==========================================================================================================================		
--==========================================================================================================================