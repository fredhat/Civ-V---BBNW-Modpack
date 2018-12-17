--==========================================================================================================================	
-- Leaders
--==========================================================================================================================			
INSERT INTO Leaders 
			(Type, 						Description, 					Civilopedia, 							CivilopediaTag, 								ArtDefineTag, 			VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 			PortraitIndex)
VALUES		('LEADER_JFD_MUSSOLINI', 	'TXT_KEY_LEADER_JFD_MUSSOLINI', 'TXT_KEY_LEADER_JFD_MUSSOLINI_PEDIA', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_MUSSOLINI', 	'Mussolini_Scene.xml',	8, 						3, 						6, 							8, 			4, 				4, 				4, 						4, 				3, 			4, 			2, 				2, 			4, 			'JFD_ITALY_ATLAS', 1);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================						
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_MUSSOLINI', 	'MAJOR_CIV_APPROACH_WAR', 			6),
			('LEADER_JFD_MUSSOLINI', 	'MAJOR_CIV_APPROACH_HOSTILE', 		3),
			('LEADER_JFD_MUSSOLINI', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	5),
			('LEADER_JFD_MUSSOLINI', 	'MAJOR_CIV_APPROACH_GUARDED', 		5),
			('LEADER_JFD_MUSSOLINI', 	'MAJOR_CIV_APPROACH_AFRAID', 		4),
			('LEADER_JFD_MUSSOLINI', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		3),
			('LEADER_JFD_MUSSOLINI', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		3);
--==========================================================================================================================	
-- Leader_MajorCivApproachBiases
--==========================================================================================================================		
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_MUSSOLINI', 	'MINOR_CIV_APPROACH_IGNORE', 		4),
			('LEADER_JFD_MUSSOLINI', 	'MINOR_CIV_APPROACH_FRIENDLY', 		3),
			('LEADER_JFD_MUSSOLINI', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	2),
			('LEADER_JFD_MUSSOLINI', 	'MINOR_CIV_APPROACH_CONQUEST', 		7),
			('LEADER_JFD_MUSSOLINI', 	'MINOR_CIV_APPROACH_BULLY', 		4);
--==========================================================================================================================	
-- Leader_Flavors
--==========================================================================================================================						
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_JFD_MUSSOLINI', 	'FLAVOR_OFFENSE', 					7),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_DEFENSE', 					4),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_CITY_DEFENSE', 				4),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_MILITARY_TRAINING', 		7),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_RECON', 					6),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_RANGED', 					5),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_MOBILE', 					5),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_NAVAL', 					8),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_NAVAL_RECON', 				7),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_NAVAL_GROWTH', 				7),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	6),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_AIR', 						4),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_EXPANSION', 				8),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_GROWTH', 					4),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_TILE_IMPROVEMENT', 			4),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_INFRASTRUCTURE', 			6),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_PRODUCTION', 				8),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_GOLD', 						4),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_SCIENCE', 					4),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_CULTURE', 					4),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_HAPPINESS', 				6),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_WONDER', 					2),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_RELIGION', 					2),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_DIPLOMACY', 				3),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_SPACESHIP', 				2),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_WATER_CONNECTION', 			3),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_NUKE', 						2),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_ESPIONAGE', 				7),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_AIRLIFT', 					1),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_JFD_MUSSOLINI', 	'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================	
-- Leader_Traits
--==========================================================================================================================						
INSERT INTO Leader_Traits 
			(LeaderType, 				TraitType)
VALUES		('LEADER_JFD_MUSSOLINI', 	'TRAIT_JFD_ITALY');
--==========================================================================================================================				
--==========================================================================================================================