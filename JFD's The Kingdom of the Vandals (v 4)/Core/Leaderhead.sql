--==========================================================================================================================
-- Leaders
--==========================================================================================================================		
INSERT INTO Leaders 
			(Type, 						Description, 					Civilopedia, 								CivilopediaTag, 						ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 					PortraitIndex)
VALUES		('LEADER_JFD_GENSERIC', 	'TXT_KEY_LEADER_JFD_GENSERIC', 	'TXT_KEY_FOR_SCENARIO_LEADER_GENSERIC', 	'TXT_KEY_FOR_SCENARIO_LEADER_GENSERIC', 'Genseric_Scene.xml',	6, 						3, 						2, 							7, 			5, 				4, 				7, 						4, 				3, 			4, 			4, 				4, 			8, 			'JFD_THE_VANDALS_ATLAS',	1);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_GENSERIC', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_JFD_GENSERIC', 	'MAJOR_CIV_APPROACH_HOSTILE', 		8),
			('LEADER_JFD_GENSERIC', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	4),
			('LEADER_JFD_GENSERIC', 	'MAJOR_CIV_APPROACH_GUARDED', 		4),
			('LEADER_JFD_GENSERIC', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_JFD_GENSERIC', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_JFD_GENSERIC', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_GENSERIC', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_JFD_GENSERIC', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_JFD_GENSERIC', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_JFD_GENSERIC', 	'MINOR_CIV_APPROACH_CONQUEST', 		6),
			('LEADER_JFD_GENSERIC', 	'MINOR_CIV_APPROACH_BULLY', 		8);
--==========================================================================================================================
-- Leader_Flavors
--==========================================================================================================================					
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_JFD_GENSERIC', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_DEFENSE', 					3),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_CITY_DEFENSE', 				3),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_MILITARY_TRAINING', 		7),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_RECON', 					5),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_RANGED', 					3),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_MOBILE', 					4),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_NAVAL', 					7),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_NAVAL_RECON', 				6),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_NAVAL_GROWTH', 				6),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	7),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_AIR', 						3),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_EXPANSION', 				6),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_GROWTH', 					6),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_INFRASTRUCTURE', 			5),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_GOLD', 						8),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_SCIENCE', 					5),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_CULTURE', 					3),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_HAPPINESS', 				3),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_WONDER', 					3),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_RELIGION', 					2),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_DIPLOMACY', 				4),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_SPACESHIP', 				3),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_WATER_CONNECTION', 			4),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_NUKE', 						2),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_ESPIONAGE', 				5),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_AIRLIFT', 					4),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		8),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_JFD_GENSERIC', 	'FLAVOR_AIR_CARRIER', 				5);

UPDATE Leader_Flavors
SET Flavor = 6
WHERE LeaderType = 'LEADER_SULEIMAN' AND FlavorType = 'FLAVOR_RELIGION';

UPDATE Leader_Flavors
SET Flavor = 7
WHERE LeaderType = 'LEADER_SULEIMAN' AND FlavorType = 'FLAVOR_SCIENCE';
--==========================================================================================================================
-- Leader_Traits
--==========================================================================================================================	
DELETE FROM Leader_Traits WHERE LeaderType = 'LEADER_SULEIMAN';				
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_JFD_GENSERIC', 'TRAIT_CONVERTS_SEA_BARBARIANS'),
			('LEADER_SULEIMAN', 	'TRAIT_JFD_OTTOMANS');
--==========================================================================================================================			
--==========================================================================================================================	