--==========================================================================================================================	
-- Civilizations
--==========================================================================================================================	
UPDATE MinorCivilizations
SET Description = 'TXT_KEY_CITYSTATE_JFD_KARYES_DESC',
	ShortDescription = 'TXT_KEY_CITYSTATE_JFD_KARYES_SHORT_DESC',
	Adjective = 'TXT_KEY_CITYSTATE_JFD_KARYES_ADJECTIVE',
	Civilopedia = 'TXT_KEY_CIV5_JFD_KARYES_TEXT_1'
WHERE Type = 'MINOR_CIV_VATICAN_CITY';

UPDATE MinorCivilization_CityNames
SET CityName = 'TXT_KEY_CITYSTATE_JFD_KARYES'
WHERE MinorCivType = 'MINOR_CIV_VATICAN_CITY';	
--==========================================================================================================================
--==========================================================================================================================