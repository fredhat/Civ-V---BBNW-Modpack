--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 							CivilopediaTag, 								ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex)
VALUES		('LEADER_JFD_ROOSEVELT', 	'TXT_KEY_LEADER_JFD_ROOSEVELT', 	'TXT_KEY_LEADER_JFD_ROOSEVELT_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_ROOSEVELT', 	'Roosevelt_Scene.xml',	8, 						6, 						2, 							6, 			7, 				6, 				8, 						6, 				6, 			6, 			5, 				5, 			2, 			'JFD_AMERICA_ROOSEVELT_ATLAS', 	1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_ROOSEVELT', 	'MAJOR_CIV_APPROACH_WAR', 			7),
			('LEADER_JFD_ROOSEVELT', 	'MAJOR_CIV_APPROACH_HOSTILE', 		2),
			('LEADER_JFD_ROOSEVELT', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	8),
			('LEADER_JFD_ROOSEVELT', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_JFD_ROOSEVELT', 	'MAJOR_CIV_APPROACH_AFRAID', 		3),
			('LEADER_JFD_ROOSEVELT', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_JFD_ROOSEVELT', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_ROOSEVELT', 	'MINOR_CIV_APPROACH_IGNORE', 		6),
			('LEADER_JFD_ROOSEVELT', 	'MINOR_CIV_APPROACH_FRIENDLY', 		8),
			('LEADER_JFD_ROOSEVELT', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	8),
			('LEADER_JFD_ROOSEVELT', 	'MINOR_CIV_APPROACH_CONQUEST', 		4);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_JFD_ROOSEVELT', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_DEFENSE', 					5),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_MILITARY_TRAINING', 		7),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_RECON', 					7),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_RANGED', 					6),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_MOBILE', 					8),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_NAVAL', 					4),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_NAVAL_RECON', 				4),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_AIR', 						3),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_EXPANSION', 				6),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_GROWTH', 					6),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_TILE_IMPROVEMENT', 			5),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_INFRASTRUCTURE', 			8),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_GOLD', 						6),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_CULTURE', 					5),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_GREAT_PEOPLE', 				6),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_WONDER', 					4),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_RELIGION', 					2),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_DIPLOMACY', 				5),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_SPACESHIP', 				3),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_WATER_CONNECTION', 			3),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_NUKE', 						12),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_USE_NUKE', 					12),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_AIRLIFT', 					3),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_JFD_ROOSEVELT', 	'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================	
INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_JFD_ROOSEVELT', 	'TRAIT_JFD_AMERICA_ROOSEVELT');
--==========================================================================================================================				
--==========================================================================================================================