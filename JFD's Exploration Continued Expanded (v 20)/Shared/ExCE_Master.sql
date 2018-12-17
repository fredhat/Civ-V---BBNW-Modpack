--==========================================================================================================================
-- UnitCombatInfos
--==========================================================================================================================
-- UnitCombatInfos
------------------------------------------------------------
INSERT OR REPLACE INTO UnitCombatInfos
		(Type, 								Description)
VALUES	('UNITCOMBAT_CIVILIAN',				'TXT_KEY_UNITCOMBAT_CIVILIAN'),
		('UNITCOMBAT_GREAT_PEOPLE',			'TXT_KEY_UNITCOMBAT_GREAT_PEOPLE'),
		('UNITCOMBAT_RELIGIOUS',			'TXT_KEY_UNITCOMBAT_RELIGIOUS');
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------------------------------------------------------------------------------------------------
UPDATE Units
SET CombatClass = 'UNITCOMBAT_CIVILIAN'
WHERE Class IN ('UNITCLASS_WORKER', 'UNITCLASS_SETTLER', 'UNITCLASS_ARCHAEOLOGIST', 'UNITCLASS_WORKBOAT', 'UNITCLASS_CARGO_SHIP', 'UNITCLASS_CARAVAN') AND CombatClass IS NULL;	

UPDATE Units
SET CombatClass = 'UNITCOMBAT_GREAT_PEOPLE'
WHERE Special = 'SPECIALUNIT_PEOPLE' AND CombatClass IS NULL;

UPDATE Units
SET CombatClass = 'UNITCOMBAT_RELIGIOUS'
WHERE Class IN ('UNITCLASS_MISSIONARY', 'UNITCLASS_INQUISITOR', 'UNITCLASS_PROPHET') AND CombatClass IS NULL;	

CREATE TRIGGER JFDExCE_Units_CombatClassCivilian
AFTER INSERT ON Units 
WHEN NEW.Class IN ('UNITCLASS_WORKER', 'UNITCLASS_SETTLER', 'UNITCLASS_ARCHAEOLOGIST', 'UNITCLASS_WORKBOAT', 'UNITCLASS_CARGO_SHIP', 'UNITCLASS_CARAVAN')
BEGIN
	UPDATE Units
	SET CombatClass = 'UNITCOMBAT_CIVILIAN'
	WHERE Class = NEW.Class AND CombatClass IS NULL;		
END;

CREATE TRIGGER JFDExCE_Units_CombatClassGreatPerson
AFTER INSERT ON Units 
WHEN NEW.Special = 'SPECIALUNIT_PEOPLE'
BEGIN
	UPDATE Units
	SET CombatClass = 'UNITCOMBAT_GREAT_PEOPLE'
	WHERE Special = NEW.Special AND CombatClass IS NULL;
END;

CREATE TRIGGER JFDExCE_Units_CombatClassReligious
AFTER INSERT ON Units 
WHEN NEW.Class IN ('UNITCLASS_MISSIONARY', 'UNITCLASS_INQUISITOR', 'UNITCLASS_PROPHET')
BEGIN
	UPDATE Units
	SET CombatClass = 'UNITCOMBAT_RELIGIOUS'
	WHERE Class = NEW.Class AND CombatClass IS NULL;	
END;
--==========================================================================================================================
--==========================================================================================================================