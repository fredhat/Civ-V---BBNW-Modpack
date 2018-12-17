--==========================================================================================================================	
-- Units
--==========================================================================================================================
INSERT OR REPLACE INTO Units 	
			(Class, 	Type, 								ShowInPedia,	GoldenAgeTurns, CivilianAttackPriority, Special, Cost,	FaithCost, RequiresFaithPurchaseEnabled, Moves, Domain, DefaultUnitAI, Description, UnitArtInfo, UnitFlagIconOffset, UnitFlagAtlas,	PortraitIndex, 	IconAtlas,	MoveRate)
SELECT		 Class,		('UNIT_JFD_ELIZABETHAN_ADMIRAL'), 	0,				8,				CivilianAttackPriority, Special, Cost,	FaithCost, RequiresFaithPurchaseEnabled, Moves, Domain, DefaultUnitAI, Description, UnitArtInfo, UnitFlagIconOffset, UnitFlagAtlas,	PortraitIndex, 	IconAtlas,	MoveRate
FROM Units WHERE (Type = 'UNIT_GREAT_ADMIRAL');

INSERT INTO Units 	
			(Class, 				Type, 							ShowInPedia,	Cost,	Moves,	Domain,			DefaultUnitAI,		Description, 						 	AdvancedStartCost,	UnitArtInfo, 					UnitFlagIconOffset,		UnitFlagAtlas,					PortraitIndex,	IconAtlas, 					MoveRate)
VALUES		('UNITCLASS_WRITER',	'UNIT_JFD_ELIZABETHAN_WRITER', 	0,				-1,		2,		'DOMAIN_LAND',	'UNITAI_WRITER',	'TXT_KEY_UNIT_JFD_ELIZABETHAN_WRITER',	-1,					'ART_DEF_UNIT_GREAT_WRITER',	8,						'EXPANSION2_UNIT_FLAG_ATLAS',	8, 				'EXPANSION2_UNIT_ATLAS',	'GREAT_PERSON');
--==========================================================================================================================	
-- UnitGameplay2DScripts
--==========================================================================================================================		
INSERT OR REPLACE INTO UnitGameplay2DScripts 	
			(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_ELIZABETHAN_ADMIRAL'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_GREAT_ADMIRAL');	

INSERT INTO UnitGameplay2DScripts 	
			(UnitType, 							SelectionSound, FirstSelectionSound)
SELECT		('UNIT_JFD_ELIZABETHAN_WRITER'), 	SelectionSound, FirstSelectionSound
FROM UnitGameplay2DScripts WHERE (UnitType = 'UNIT_WRITER');
--==========================================================================================================================	
-- Unit_AITypes
--==========================================================================================================================		
INSERT OR REPLACE INTO Unit_AITypes 	
			(UnitType, 							UnitAIType)
SELECT		('UNIT_JFD_ELIZABETHAN_ADMIRAL'), 	UnitAIType
FROM Unit_AITypes WHERE (UnitType = 'UNIT_GREAT_ADMIRAL');
--==========================================================================================================================	
-- Unit_Flavors
--==========================================================================================================================		
INSERT OR REPLACE INTO Unit_Flavors 	
			(UnitType, 							FlavorType, Flavor)
SELECT		('UNIT_JFD_ELIZABETHAN_ADMIRAL'), 	FlavorType, Flavor
FROM Unit_Flavors WHERE (UnitType = 'UNIT_GREAT_ADMIRAL');
--==========================================================================================================================	
-- Unit_UniqueNames
--==========================================================================================================================		
INSERT OR REPLACE INTO Unit_UniqueNames 	
			(UnitType, 							UniqueName)
VALUES		('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_RICHARD_FITZALAN'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_JOHN_ARUNDELL'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_RICHARD_BRADLEY'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_RICHARD_BROOKE'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_GEORGE_CAREW'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_ARTHUR_CHAMPERNOWNE'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_WILLIAM_GONSON'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_RICHARD_HARLISTON'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_RICHARD_HAWKINS'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_JOHN_HAWKINS'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_WALTER_HUNGERFORD'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_RICHARD_LEVESON'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_EDWARD_CLINTON'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_ROBERT_MANSELL'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_JOHN_PENINGTON'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_THOMAS_HOWARD'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_FRANCIS_DRAKE'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_WALTER_RALEIGH'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_MARTIN_FROBISHER'),
			('UNIT_JFD_ELIZABETHAN_ADMIRAL', 	'TXT_KEY_JFD_SIR_HUMPHREY_GILBERT');
			
INSERT INTO Unit_UniqueNames 
			(UnitType, 							UniqueName,												GreatWorkType)
VALUES		('UNIT_JFD_ELIZABETHAN_WRITER',		'TXT_KEY_GREAT_PERSON_JFD_WILLIAM_SHAKESPEARE_DESC',	'GREAT_WORK_JFD_ELIZABETHAN_1'),
			('UNIT_JFD_ELIZABETHAN_WRITER',		'TXT_KEY_GREAT_PERSON_JFD_CHRISTOPHER_MARLOWE_DESC',	'GREAT_WORK_JFD_ELIZABETHAN_2'),
			('UNIT_JFD_ELIZABETHAN_WRITER',		'TXT_KEY_GREAT_PERSON_JFD_BEN_JOHNSON_DESC',			'GREAT_WORK_JFD_ELIZABETHAN_3'),
			('UNIT_JFD_ELIZABETHAN_WRITER',		'TXT_KEY_GREAT_PERSON_JFD_JOHN_FLETCHER_DESC',			'GREAT_WORK_JFD_ELIZABETHAN_4');
--==========================================================================================================================
-- Unit_FreePromotions
--==========================================================================================================================
INSERT OR REPLACE INTO Unit_FreePromotions 	
			(UnitType, 							PromotionType)
SELECT		('UNIT_JFD_ELIZABETHAN_ADMIRAL'), 	PromotionType
FROM Unit_FreePromotions WHERE (UnitType = 'UNIT_GREAT_ADMIRAL');
--==========================================================================================================================		
--==========================================================================================================================