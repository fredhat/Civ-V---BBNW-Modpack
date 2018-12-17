--==========================================================================================================================	
-- Units
--==========================================================================================================================	
UPDATE Units
SET Help = 'TXT_KEY_UNIT_F0S_WINGED_HUSSAR_HELP', Strategy = 'TXT_KEY_UNIT_F0S_WINGED_HUSSAR_STRATEGY', ObsoleteTech = 'TECH_STEAM_POWER', GoodyHutUpgradeUnitClass = 'UNITCLASS_AIRSHIP'
WHERE Type = 'UNIT_POLISH_WINGED_HUSSAR';

UPDATE Unit_ClassUpgrades
SET UnitClassType = 'UNITCLASS_AIRSHIP'
WHERE UnitType = 'UNIT_POLISH_WINGED_HUSSAR';
--==========================================================================================================================		
--==========================================================================================================================