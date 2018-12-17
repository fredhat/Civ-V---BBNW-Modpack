--==========================================================================================================================
-- Leaders
--==========================================================================================================================		
INSERT INTO Leaders 
			(Type, 					Description, 					Civilopedia, 						CivilopediaTag, 							ArtDefineTag, 		VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 			PortraitIndex)
VALUES		('LEADER_JFD_HAAKON', 	'TXT_KEY_LEADER_JFD_HAAKON', 	'TXT_KEY_LEADER_JFD_HAAKON_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_HAAKON', 	'Haakon_Scene.xml', 6, 						5, 						6, 							7, 			6, 				5, 				5, 						5, 				6, 			5, 			6, 				5, 			5, 			'JFD_NORWAY_ATLAS', 1);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 			MajorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_HAAKON', 	'MAJOR_CIV_APPROACH_WAR', 			8),
			('LEADER_JFD_HAAKON', 	'MAJOR_CIV_APPROACH_HOSTILE', 		7),
			('LEADER_JFD_HAAKON', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	7),
			('LEADER_JFD_HAAKON', 	'MAJOR_CIV_APPROACH_GUARDED', 		6),
			('LEADER_JFD_HAAKON', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_JFD_HAAKON', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_JFD_HAAKON', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		5);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 			MinorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_HAAKON', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_JFD_HAAKON', 	'MINOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_JFD_HAAKON', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_JFD_HAAKON', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_JFD_HAAKON', 	'MINOR_CIV_APPROACH_BULLY', 		7);
--==========================================================================================================================
-- Leader_Flavors
--==========================================================================================================================					
INSERT INTO Leader_Flavors 
			(LeaderType, 			FlavorType, 						Flavor)
VALUES		('LEADER_JFD_HAAKON', 	'FLAVOR_OFFENSE', 					6),
			('LEADER_JFD_HAAKON', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_JFD_HAAKON', 	'FLAVOR_CITY_DEFENSE', 				6),
			('LEADER_JFD_HAAKON', 	'FLAVOR_MILITARY_TRAINING', 		6),
			('LEADER_JFD_HAAKON', 	'FLAVOR_RECON', 					6),
			('LEADER_JFD_HAAKON', 	'FLAVOR_RANGED', 					2),
			('LEADER_JFD_HAAKON', 	'FLAVOR_MOBILE', 					8),
			('LEADER_JFD_HAAKON', 	'FLAVOR_NAVAL', 					8),
			('LEADER_JFD_HAAKON', 	'FLAVOR_NAVAL_RECON', 				9),
			('LEADER_JFD_HAAKON', 	'FLAVOR_NAVAL_GROWTH', 				10),
			('LEADER_JFD_HAAKON', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	10),
			('LEADER_JFD_HAAKON', 	'FLAVOR_AIR', 						3),
			('LEADER_JFD_HAAKON', 	'FLAVOR_EXPANSION', 				7),
			('LEADER_JFD_HAAKON', 	'FLAVOR_GROWTH', 					7),
			('LEADER_JFD_HAAKON', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_JFD_HAAKON', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_JFD_HAAKON', 	'FLAVOR_PRODUCTION', 				6),
			('LEADER_JFD_HAAKON', 	'FLAVOR_GOLD', 						7),
			('LEADER_JFD_HAAKON', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_JFD_HAAKON', 	'FLAVOR_CULTURE', 					4),
			('LEADER_JFD_HAAKON', 	'FLAVOR_HAPPINESS', 				4),
			('LEADER_JFD_HAAKON', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_JFD_HAAKON', 	'FLAVOR_WONDER', 					4),
			('LEADER_JFD_HAAKON', 	'FLAVOR_RELIGION', 					7),
			('LEADER_JFD_HAAKON', 	'FLAVOR_DIPLOMACY', 				8),
			('LEADER_JFD_HAAKON', 	'FLAVOR_SPACESHIP', 				4),
			('LEADER_JFD_HAAKON', 	'FLAVOR_WATER_CONNECTION', 			6),
			('LEADER_JFD_HAAKON', 	'FLAVOR_NUKE', 						3),
			('LEADER_JFD_HAAKON', 	'FLAVOR_USE_NUKE', 					3),
			('LEADER_JFD_HAAKON', 	'FLAVOR_ESPIONAGE', 				6),
			('LEADER_JFD_HAAKON', 	'FLAVOR_AIRLIFT', 					5),
			('LEADER_JFD_HAAKON', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_JFD_HAAKON', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_JFD_HAAKON', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		8),
			('LEADER_JFD_HAAKON', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_JFD_HAAKON', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_JFD_HAAKON', 	'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================
-- Leader_Traits
--==========================================================================================================================					
INSERT INTO Leader_Traits 
			(LeaderType, 		TraitType)
VALUES		('LEADER_JFD_HAAKON', 	'TRAIT_JFD_NORWAY');
--==========================================================================================================================			
--==========================================================================================================================