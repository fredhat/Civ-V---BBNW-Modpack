--==========================================================================================================================
-- Units
--------------------------------	
INSERT OR REPLACE INTO Units 	
			(Class, 	Type, 					 PrereqTech, RangedCombat, 		Range, Special, Combat, 	Cost, 		FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, Description, 					 Civilopedia, 							Strategy, 									Help, 									Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, UnitArtInfo, 					 UnitFlagIconOffset, UnitFlagAtlas,							PortraitIndex, 	IconAtlas,					MoveRate)
SELECT		 Class,		('UNIT_JFD_TWO_DECKER'), PrereqTech, RangedCombat-1,	Range, Special, Combat-1,	Cost-20,	FaithCost, RequiresFaithPurchaseEnabled, Moves, CombatClass, Domain, DefaultUnitAI, ('TXT_KEY_UNIT_JFD_TWO_DECKER'), ('TXT_KEY_CIV5_JFD_TWO_DECKER_TEXT'), 	('TXT_KEY_UNIT_JFD_TWO_DECKER_STRATEGY'),   ('TXT_KEY_UNIT_HELP_JFD_TWO_DECKER'), 	Pillage, MilitarySupport, MilitaryProduction, IgnoreBuildingDefense, Mechanized, AdvancedStartCost, RangedCombatLimit, CombatLimit, XPValueDefense, ('ART_DEF_UNIT_JFD_TWO_DECKER'), 0,					 ('JFD_UNIT_FLAG_TWO_DECKER_ATLAS'),	2, 				('JFD_RUSSIA_PETER_ATLAS'),	MoveRate
FROM Units WHERE (Type = 'UNIT_FRIGATE');

UPDATE Units
SET Moves = 5, Help = 'TXT_KEY_UNIT_JFD_COSSACK_HELP', Strategy = 'TXT_KEY_UNIT_JFD_COSSACK_STRATEGY'
WHERE Type = 'UNIT_RUSSIAN_COSSACK';
--------------------------------	
-- UnitGameplay2DScripts
--------------------------------		
INSERT OR REPLACE INTO UnitGameplay2DScripts 	
			(UnitType, 					SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_TWO_DECKER'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_FRIGATE');
--------------------------------		
-- Unit_AITypes
--------------------------------		
INSERT OR REPLACE INTO Unit_AITypes 	
			(UnitType, 					UnitAIType)
SELECT		('UNIT_JFD_TWO_DECKER'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_FRIGATE');
--------------------------------	
-- Unit_ClassUpgrades
--------------------------------	
INSERT OR REPLACE INTO Unit_ClassUpgrades 	
			(UnitType, 					UnitClassType)
SELECT		('UNIT_JFD_TWO_DECKER'),	UnitClassType
FROM Unit_ClassUpgrades WHERE (UnitType = 'UNIT_FRIGATE');	
--------------------------------	
-- Unit_Flavors
--------------------------------		
INSERT OR REPLACE INTO Unit_Flavors 	
			(UnitType, 					FlavorType, Flavor)
SELECT		('UNIT_JFD_TWO_DECKER'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_FRIGATE');
--------------------------------	
-- Unit_FreePromotions
--------------------------------	
INSERT INTO Unit_FreePromotions 	
			(UnitType, 					PromotionType)
SELECT		('UNIT_JFD_TWO_DECKER'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_FRIGATE');	

INSERT OR REPLACE INTO Unit_FreePromotions
			(UnitType, 					PromotionType)
VALUES		('UNIT_JFD_TWO_DECKER', 	'PROMOTION_JFD_TWO_DECKER'),
			('UNIT_JFD_TWO_DECKER', 	'PROMOTION_JFD_SECOND_HAND_INFO'),
			('UNIT_RUSSIAN_COSSACK', 	'PROMOTION_JFD_COSSACK');
--==========================================================================================================================
--==========================================================================================================================