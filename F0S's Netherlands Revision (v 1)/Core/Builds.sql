--==========================================================================================================================
-- Builds
--==========================================================================================================================
UPDATE Builds
SET Water = 1, CanBeEmbarked = 1, PrereqTech = 'TECH_ENGINEERING', EntityEvent = 'ENTITY_EVENT_BUILD', Help = 'TXT_KEY_BUILD_IMPROVEMENTS_F0S_POLDER_REC', Recommendation = 'TXT_KEY_BUILD_IMPROVEMENTS_F0S_POLDER_REC'
WHERE Type = 'BUILD_POLDER';
--==========================================================================================================================
--==========================================================================================================================