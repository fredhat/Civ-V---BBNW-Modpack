--==========================================================================================================================
-- Leaders
--==========================================================================================================================		
INSERT INTO Leaders 
			(Type, 						Description, 					Civilopedia, 											CivilopediaTag, 							ArtDefineTag, 				VictoryCompetitiveness, WonderCompetitiveness, 	MinorCivCompetitiveness, 	Boldness, 	DiploBalance, 	WarmongerHate, 	DenounceWillingness, 	DoFWillingness, Loyalty, 	Neediness, 	Forgiveness, 	Chattiness, Meanness, 	IconAtlas, 				PortraitIndex)
VALUES		('LEADER_JFD_ROBRECHT', 	'TXT_KEY_LEADER_JFD_ROBRECHT', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD__ROBRECHT_TEXT_1', 	'TXT_KEY_CIVILOPEDIA_LEADERS_JFD_ROBRECHT', 'Robrecht_Scene.xml',		4, 						2, 						2, 							7, 			6, 				5, 				2, 						5, 				5, 			4, 			4, 				4, 			2, 			'JFD_FLANDERS_ATLAS',	1);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MajorCivApproachBiases 
			(LeaderType, 				MajorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_ROBRECHT', 	'MAJOR_CIV_APPROACH_WAR', 			3),
			('LEADER_JFD_ROBRECHT', 	'MAJOR_CIV_APPROACH_HOSTILE', 		2),
			('LEADER_JFD_ROBRECHT', 	'MAJOR_CIV_APPROACH_DECEPTIVE', 	3),
			('LEADER_JFD_ROBRECHT', 	'MAJOR_CIV_APPROACH_GUARDED', 		7),
			('LEADER_JFD_ROBRECHT', 	'MAJOR_CIV_APPROACH_AFRAID', 		5),
			('LEADER_JFD_ROBRECHT', 	'MAJOR_CIV_APPROACH_FRIENDLY', 		5),
			('LEADER_JFD_ROBRECHT', 	'MAJOR_CIV_APPROACH_NEUTRAL', 		6);
--==========================================================================================================================
-- Leader_MajorCivApproachBiases
--==========================================================================================================================					
INSERT INTO Leader_MinorCivApproachBiases 
			(LeaderType, 				MinorCivApproachType, 				Bias)
VALUES		('LEADER_JFD_ROBRECHT', 	'MINOR_CIV_APPROACH_IGNORE', 		6),
			('LEADER_JFD_ROBRECHT', 	'MINOR_CIV_APPROACH_FRIENDLY', 		4),
			('LEADER_JFD_ROBRECHT', 	'MINOR_CIV_APPROACH_PROTECTIVE', 	4),
			('LEADER_JFD_ROBRECHT', 	'MINOR_CIV_APPROACH_CONQUEST', 		5),
			('LEADER_JFD_ROBRECHT', 	'MINOR_CIV_APPROACH_BULLY', 		5);
--==========================================================================================================================
-- Leader_Flavors
--==========================================================================================================================					
INSERT INTO Leader_Flavors 
			(LeaderType, 				FlavorType, 						Flavor)
VALUES		('LEADER_JFD_ROBRECHT', 	'FLAVOR_OFFENSE', 					4),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_DEFENSE', 					7),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_CITY_DEFENSE', 				7),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_MILITARY_TRAINING', 		4),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_RECON', 					2),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_RANGED', 					2),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_MOBILE', 					3),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_NAVAL', 					3),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_NAVAL_RECON', 				2),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_NAVAL_GROWTH', 				4),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_NAVAL_TILE_IMPROVEMENT', 	4),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_AIR', 						3),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_EXPANSION', 				3),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_GROWTH', 					5),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_TILE_IMPROVEMENT', 			8),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_INFRASTRUCTURE', 			8),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_PRODUCTION', 				7),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_GOLD', 						6),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_SCIENCE', 					2),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_CULTURE', 					6),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_HAPPINESS', 				3),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_GREAT_PEOPLE', 				3),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_WONDER', 					2),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_RELIGION', 					4),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_DIPLOMACY', 				2),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_SPACESHIP', 				2),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_WATER_CONNECTION', 			3),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_NUKE', 						2),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_USE_NUKE', 					2),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_ESPIONAGE', 				2),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_AIRLIFT', 					4),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_I_TRADE_DESTINATION', 		5),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_I_TRADE_ORIGIN', 			5),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_I_SEA_TRADE_ROUTE', 		5),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_I_LAND_TRADE_ROUTE', 		5),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_ARCHAEOLOGY', 				5),
			('LEADER_JFD_ROBRECHT', 	'FLAVOR_AIR_CARRIER', 				5);
--==========================================================================================================================
-- Leader_Traits
--==========================================================================================================================
INSERT INTO Leader_Traits 
			(LeaderType, 			TraitType)
VALUES		('LEADER_JFD_ROBRECHT', 'TRAIT_JFD_FLANDERS');
--==========================================================================================================================			
--==========================================================================================================================	