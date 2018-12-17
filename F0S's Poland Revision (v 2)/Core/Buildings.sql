--==========================================================================================================================	
-- Buildings
--==========================================================================================================================
-- Ducal Stables
--------------------------------	
UPDATE Buildings
SET Help = 'TXT_KEY_BUILDING_F0S_DUCAL_STABLES_HELP', Strategy = 'TXT_KEY_BUILDING_F0S_DUCAL_STABLES_STRATEGY'
WHERE Type = 'BUILDING_DUCAL_STABLE';
--==========================================================================================================================	
-- Building_UnitCombatProductionModifiers
--==========================================================================================================================					
INSERT OR REPLACE INTO Building_UnitCombatProductionModifiers 
			(BuildingType, 									UnitCombatType,					Modifier)
VALUES		('BUILDING_DUCAL_STABLE', 						'UNITCOMBAT_MOUNTED_RANGED',	15);
--==========================================================================================================================	
-- Building_UnitCombatFreeExperiences
--==========================================================================================================================					
INSERT OR REPLACE INTO Building_UnitCombatFreeExperiences 
			(BuildingType, 									UnitCombatType,					Experience)
VALUES		('BUILDING_DUCAL_STABLE', 						'UNITCOMBAT_MOUNTED_RANGED',	15);
--==========================================================================================================================		
--==========================================================================================================================