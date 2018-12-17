--==========================================================================================================================	
-- Buildings
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 	DefaultBuilding)
VALUES		('BUILDINGCLASS_JFD_CHATEAU', 	'BUILDING_JFD_CHATEAU_GWP');

INSERT INTO Buildings 	
			(Type, 							BuildingClass, 					PrereqTech,	Cost, FaithCost, GreatWorkCount, NeverCapture,	NukeImmune,	SpecialistType, 		GreatPeopleRateChange)
VALUES		('BUILDING_JFD_CHATEAU_GWP',	'BUILDINGCLASS_JFD_CHATEAU', 	null,		-1,	  -1,		 -1,			 1, 			1,			'SPECIALIST_WRITER',	1),
			('BUILDING_JFD_CHATEAU_GAP',	'BUILDINGCLASS_JFD_CHATEAU', 	null,		-1,	  -1,		 -1,			 1, 			1,			'SPECIALIST_ARTIST',	1),
			('BUILDING_JFD_CHATEAU_GMP',	'BUILDINGCLASS_JFD_CHATEAU', 	null,		-1,	  -1,		 -1,			 1, 			1,			'SPECIALIST_MUSICIAN',	1);
--==========================================================================================================================	
-- IMPROVEMENTS
--==========================================================================================================================	
-- Improvements
--------------------------------
UPDATE Improvements
SET Civilopedia = 'TXT_KEY_IMPROVEMENTS_JFD_CHATEAU_TEXT',  Help = 'TXT_KEY_IMPROVEMENTS_JFD_CHATEAU_HELP', Permanent = 1, DefenseModifier = 0
WHERE Type = 'IMPROVEMENT_CHATEAU';
---------------------------------	
-- Improvement_Yields
---------------------------------	
DELETE FROM Improvement_Yields WHERE ImprovementType = 'IMPROVEMENT_CHATEAU';
INSERT INTO Improvement_Yields 
		(ImprovementType, 			YieldType, 			Yield)
VALUES	('IMPROVEMENT_CHATEAU', 	'YIELD_CULTURE', 	2),
		('IMPROVEMENT_CHATEAU', 	'YIELD_GOLD', 		2);
---------------------------------	
-- Improvement_TechYieldChanges
---------------------------------
DELETE FROM Improvement_TechYieldChanges WHERE ImprovementType = 'IMPROVEMENT_CHATEAU';
INSERT INTO Improvement_TechYieldChanges 
		(ImprovementType, 			TechType,			YieldType, 			Yield)
VALUES	('IMPROVEMENT_CHATEAU', 	'TECH_FLIGHT',		'YIELD_CULTURE', 	2);
---------------------------------	
-- Improvement_ResourceTypes
---------------------------------
INSERT INTO Improvement_ResourceTypes 	
		(ImprovementType, 			ResourceType)
SELECT	'IMPROVEMENT_CHATEAU', 		ResourceType
FROM Improvement_ResourceTypes WHERE ImprovementType = 'IMPROVEMENT_CITADEL';
--==========================================================================================================================	
-- Builds
--==========================================================================================================================	
-- Builds
--------------------------------
UPDATE Builds
SET Recommendation = 'TXT_KEY_BUILD_JFD_CHATEAU_REC', Help = 'TXT_KEY_BUILD_JFD_CHATEAU_HELP'
WHERE Type = 'BUILD_CHATEAU';
--==========================================================================================================================
-- UNITS
--==========================================================================================================================
-- Units
--------------------------------
UPDATE Units 
SET Help = 'TXT_KEY_UNIT_JFD_MUSKETEER_HELP', Strategy = 'TXT_KEY_UNIT_JFD_MUSKETEER_STRATEGY'
WHERE Type = 'UNIT_FRENCH_MUSKETEER';	
--==========================================================================================================================	
-- LEADERS
--==========================================================================================================================	
-- Leaders
--------------------------------			
INSERT INTO Leaders 
		(Type, 						Description, 						Civilopedia, 							CivilopediaTag, 								ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES	('LEADER_JFD_LOUIS_XIV', 	'TXT_KEY_LEADER_JFD_LOUIS_XIV', 	'TXT_KEY_LEADER_JFD_LOUIS_XIV_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_LOUIS_XIV', 	'LouisXIV_Scene.xml',	8, 						8, 						5, 							8, 			4, 				7, 				5, 						4, 				3, 			8, 			4, 				8, 			8, 			'JFD_FRANCE_ATLAS', 	1);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MajorCivApproachBiases 
		(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_LOUIS_XIV', 	'MAJOR_CIV_APPROACH_WAR', 			6),
		('LEADER_JFD_LOUIS_XIV', 	'MAJOR_CIV_APPROACH_HOSTILE', 		4),
		('LEADER_JFD_LOUIS_XIV', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
		('LEADER_JFD_LOUIS_XIV', 	'MAJOR_CIV_APPROACH_GUARDED', 		4),
		('LEADER_JFD_LOUIS_XIV', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
		('LEADER_JFD_LOUIS_XIV', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_LOUIS_XIV', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--------------------------------	
-- Leader_MajorCivApproachBiases
--------------------------------						
INSERT INTO Leader_MinorCivApproachBiases 
		(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES	('LEADER_JFD_LOUIS_XIV', 	'MINOR_CIV_APPROACH_IGNORE', 		2),
		('LEADER_JFD_LOUIS_XIV', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
		('LEADER_JFD_LOUIS_XIV', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	3),
		('LEADER_JFD_LOUIS_XIV', 	'MINOR_CIV_APPROACH_CONQUEST', 		6),
		('LEADER_JFD_LOUIS_XIV', 	'MINOR_CIV_APPROACH_BULLY', 		9);
--------------------------------	
-- Leader_Flavors
--------------------------------						
INSERT INTO Leader_Flavors 
		(LeaderType, 				FlavorType, 						Flavor)
VALUES	('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_OFFENSE', 					6),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_DEFENSE', 					4),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_CITY_DEFENSE', 				4),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_MILITARY_TRAINING', 		7),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_RECON', 					5),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_RANGED', 					5),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_MOBILE', 					4),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_NAVAL', 					3),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_NAVAL_RECON', 				2),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_NAVAL_GROWTH', 				2),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	2),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_AIR', 						3),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_EXPANSION', 				8),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_GROWTH', 					8),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_INFRASTRUCTURE', 			6),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_PRODUCTION', 				5),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_GOLD', 						2),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_SCIENCE', 					6),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_CULTURE', 					8),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_HAPPINESS', 				7),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_GREAT_PEOPLE', 				8),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_WONDER', 					9),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_RELIGION', 					7),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_DIPLOMACY', 				5),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_SPACESHIP', 				3),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_WATER_CONNECTION', 			4),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_NUKE', 						2),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_USE_NUKE', 					2),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_ESPIONAGE', 				8),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_AIRLIFT', 					2),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_ARCHAEOLOGY', 				5),
		('LEADER_JFD_LOUIS_XIV', 	'FLAVOR_AIR_CARRIER', 				5);
--------------------------------	
-- Leader_Traits
--------------------------------
INSERT INTO Leader_Traits 
		(LeaderType, 				TraitType)
VALUES	('LEADER_JFD_LOUIS_XIV', 	'TRAIT_JFD_FRANCE');
--==========================================================================================================================	
-- TRAITS
--==========================================================================================================================	
-- Traits
--------------------------------	
INSERT INTO Traits 
		(Type, 					Description, 					ShortDescription,						CapitalThemingBonusModifier)
VALUES	('TRAIT_JFD_FRANCE',	'TXT_KEY_TRAIT_JFD_LOUIS_XIV', 	'TXT_KEY_TRAIT_JFD_LOUIS_XIV_SHORT',	100);
--==========================================================================================================================	
-- CIVILIZATIONS
--==========================================================================================================================	
-- Civilizations
--------------------------------		
UPDATE Civilizations
SET DawnOfManQuote = 'TXT_KEY_CIV5_DOM_JFD_LOUIS_XIV_TEXT', DawnOfManAudio = null
WHERE Type = 'CIVILIZATION_FRANCE';
---------------------------------	
-- Civilization_CityNames
---------------------------------	
DELETE FROM Civilization_CityNames WHERE CivilizationType = 'CIVILIZATION_FRANCE';
INSERT INTO Civilization_CityNames 
		(CivilizationType, 			CityName)
VALUES	('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_PARIS'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_JFD_VERSAILLES'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_ORLEANS'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_LYONS'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_RHEIMS'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_TOURS'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_MARSEILLES'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_CHARTRES'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_AVIGNON'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_ROUEN'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_GRENOBLE'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_DJION'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_AMIENS'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_CHERBOURG'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_POITIERS'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_TOULOUSE'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_BAYONNE'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_STRASBOURG'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_BREST'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_BORDEAUX'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_RENNES'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_NICE'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_NANTES'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_REIMS'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_LE_MANS'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_MONTPELLIER'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_LIMOGES'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_NANCY'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_LILLE'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_CAEN'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_TOULON'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_NIMES'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_LOURDES'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_LE_HAVRE'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_CARCASSONNE'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_CANNES'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_AIX_EN_PROVINCE'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_LA_ROCHELLE'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_BOURGES'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_CITY_NAME_CALAIS');
---------------------------------	
-- Civilization_Leaders
---------------------------------	
DELETE FROM	Civilization_Leaders WHERE CivilizationType = 'CIVILIZATION_FRANCE';	
INSERT INTO Civilization_Leaders 
		(CivilizationType, 			LeaderheadType)
VALUES	('CIVILIZATION_FRANCE',		'LEADER_JFD_LOUIS_XIV');
---------------------------------	
-- Civilization_SpyNames
---------------------------------	
DELETE FROM Civilization_SpyNames WHERE CivilizationType = 'CIVILIZATION_FRANCE';	
INSERT INTO Civilization_SpyNames 
		(CivilizationType, 			SpyName)
VALUES	('CIVILIZATION_FRANCE', 	'TXT_KEY_SPY_NAME_JFD_FRANCE_LOUIS_XIV_0'),	
		('CIVILIZATION_FRANCE', 	'TXT_KEY_SPY_NAME_JFD_FRANCE_LOUIS_XIV_1'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_SPY_NAME_JFD_FRANCE_LOUIS_XIV_2'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_SPY_NAME_JFD_FRANCE_LOUIS_XIV_3'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_SPY_NAME_JFD_FRANCE_LOUIS_XIV_4'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_SPY_NAME_JFD_FRANCE_LOUIS_XIV_5'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_SPY_NAME_JFD_FRANCE_LOUIS_XIV_6'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_SPY_NAME_JFD_FRANCE_LOUIS_XIV_7'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_SPY_NAME_JFD_FRANCE_LOUIS_XIV_8'),
		('CIVILIZATION_FRANCE', 	'TXT_KEY_SPY_NAME_JFD_FRANCE_LOUIS_XIV_9');
---------------------------------	
-- Civilization_Start_Region_Priority
---------------------------------	
INSERT INTO Civilization_Start_Region_Priority 
		(CivilizationType, 			RegionType)
VALUES	('CIVILIZATION_FRANCE',		'REGION_PLAINS');
--==========================================================================================================================
--==========================================================================================================================