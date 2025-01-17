--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 						Description, 						Civilopedia, 							CivilopediaTag, 								ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 						PortraitIndex)
VALUES		('LEADER_JFD_NICHOLAS', 	'TXT_KEY_LEADER_JFD_NICHOLAS', 		'TXT_KEY_LEADER_JFD_NICHOLAS_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_NICHOLAS', 	'Nicholas_Scene.xml',	4, 						8, 						4, 							3, 			5, 				8, 				3, 						6, 				8, 			8, 			8, 				6, 			2, 			'JFD_RUSSIA_NICHOLAS_ATLAS', 	1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_NICHOLAS', 	'MAJOR_CIV_APPROACH_WAR', 			4),
			('LEADER_JFD_NICHOLAS', 	'MAJOR_CIV_APPROACH_HOSTILE', 		2),
			('LEADER_JFD_NICHOLAS', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	2),
			('LEADER_JFD_NICHOLAS', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_JFD_NICHOLAS', 	'MAJOR_CIV_APPROACH_AFRAID', 		6),
			('LEADER_JFD_NICHOLAS', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		6),
			('LEADER_JFD_NICHOLAS', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		4);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_NICHOLAS', 	'MINOR_CIV_APPROACH_IGNORE', 		5),
			('LEADER_JFD_NICHOLAS', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_JFD_NICHOLAS', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_JFD_NICHOLAS', 	'MINOR_CIV_APPROACH_CONQUEST', 		3),
			('LEADER_JFD_NICHOLAS', 	'MINOR_CIV_APPROACH_BULLY', 		3);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_JFD_NICHOLAS', 	'FLAVOR_OFFENSE', 					2),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_DEFENSE', 					6),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_CITY_DEFENSE', 				5),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_MILITARY_TRAINING', 		5),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_RECON', 					4),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_RANGED', 					4),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_MOBILE', 					5),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_NAVAL', 					2),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_NAVAL_RECON', 				2),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_NAVAL_GROWTH', 				2),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	2),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_AIR', 						4),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_EXPANSION', 				9),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_GROWTH', 					8),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_TILE_IMPROVEMENT', 			6),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_GOLD', 						7),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_SCIENCE', 					2),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_CULTURE', 					5),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_HAPPINESS', 				3),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_GREAT_PEOPLE', 				4),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_WONDER', 					9),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_RELIGION', 					8),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_SPACESHIP', 				2),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_WATER_CONNECTION', 			2),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_NUKE', 						2),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_ESPIONAGE', 				3),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_AIRLIFT', 					2),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_JFD_NICHOLAS', 	'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================	
INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_JFD_NICHOLAS', 	'TRAIT_JFD_NICHOLAS_RUSSIA');
--==========================================================================================================================				
--==========================================================================================================================