--==========================================================================================================================
-- Technologies
--==========================================================================================================================
UPDATE Technologies
SET InternationalTradeRoutesChange = 2
WHERE Type = 'TECH_ANIMAL_HUSBANDRY';

UPDATE Technologies
SET InternationalTradeRoutesChange = 2
WHERE Type = 'TECH_SAILING';

UPDATE Technologies
SET InternationalTradeRoutesChange = 2
WHERE Type = 'TECH_ENGINEERING';

UPDATE Technologies
SET InternationalTradeRoutesChange = 2
WHERE Type = 'TECH_COMPASS';

UPDATE Technologies
SET InternationalTradeRoutesChange = 2
WHERE Type = 'TECH_BANKING';

UPDATE Technologies
SET InternationalTradeRoutesChange = 2
WHERE Type = 'TECH_BIOLOGY';

UPDATE Technologies
SET InternationalTradeRoutesChange = 2
WHERE Type = 'TECH_RAILROAD';

UPDATE Technologies
SET InternationalTradeRoutesChange = 2
WHERE Type = 'TECH_PENICILIN';
--==========================================================================================================================
-- Technology_PrereqTechs
--==========================================================================================================================
DELETE FROM Technology_PrereqTechs WHERE TechType = 'TECH_PENICILIN';

INSERT INTO Technology_PrereqTechs 	
			(TechType, 				PrereqTech)
VALUES		('TECH_ARCHITECTURE', 	'TECH_ASTRONOMY'),
			('TECH_DYNAMITE', 		'TECH_RIFLING'),
			('TECH_PLASTIC', 		'TECH_REFRIGERATION'),
			('TECH_PENICILIN', 		'TECH_PLASTIC');
--==========================================================================================================================		
--==========================================================================================================================