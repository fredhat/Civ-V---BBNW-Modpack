--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================	
-- IconTextureAtlases
------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 											IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_BYZANTIUM_JUSTINIAN_ATLAS', 					256, 		'JFD_ByzantiumJustinianAtlas_256.dds',		2, 				2),
		('JFD_BYZANTIUM_JUSTINIAN_ATLAS', 					128, 		'JFD_ByzantiumJustinianAtlas_128.dds',		2, 				2),
		('JFD_BYZANTIUM_JUSTINIAN_ATLAS', 					80, 		'JFD_ByzantiumJustinianAtlas_80.dds',		2, 				2),
		('JFD_BYZANTIUM_JUSTINIAN_ATLAS', 					64, 		'JFD_ByzantiumJustinianAtlas_64.dds',		2, 				2),
		('JFD_BYZANTIUM_JUSTINIAN_ATLAS', 					45, 		'JFD_ByzantiumJustinianAtlas_45.dds',		2, 				2),
		('JFD_BYZANTIUM_JUSTINIAN_ATLAS', 					32, 		'JFD_ByzantiumJustinianAtlas_32.dds',		2, 				2),
		('JFD_BYZANTIUM_JUSTINIAN_ALPHA_ATLAS', 			128, 		'JFD_ByzantiumJustinianAlphaAtlas_128.dds',	1,				1),
		('JFD_BYZANTIUM_JUSTINIAN_ALPHA_ATLAS', 			80, 		'JFD_ByzantiumJustinianAlphaAtlas_80.dds',	1, 				1),
		('JFD_BYZANTIUM_JUSTINIAN_ALPHA_ATLAS', 			64, 		'JFD_ByzantiumJustinianAlphaAtlas_64.dds',	1, 				1),
		('JFD_BYZANTIUM_JUSTINIAN_ALPHA_ATLAS', 			48, 		'JFD_ByzantiumJustinianAlphaAtlas_48.dds',	1, 				1),
		('JFD_BYZANTIUM_JUSTINIAN_ALPHA_ATLAS', 			45, 		'JFD_ByzantiumJustinianAlphaAtlas_45.dds',	1, 				1),
		('JFD_BYZANTIUM_JUSTINIAN_ALPHA_ATLAS', 			32, 		'JFD_ByzantiumJustinianAlphaAtlas_32.dds',	1, 				1),
		('JFD_BYZANTIUM_JUSTINIAN_ALPHA_ATLAS', 			24, 		'JFD_ByzantiumJustinianAlphaAtlas_24.dds',	1, 				1),
		('JFD_BYZANTIUM_JUSTINIAN_ALPHA_ATLAS', 			16, 		'JFD_ByzantiumJustinianAlphaAtlas_16.dds',	1, 				1);
------------------------------
-- Colors
------------------------------		
INSERT INTO Colors 
		(Type, 												Red, 	Green, 	Blue, 	Alpha)
VALUES	('COLOR_PLAYER_JFD_BYZANTIUM_JUSTINIAN_ICON', 		0.192,	0.101,	0.239,	1),
		('COLOR_PLAYER_JFD_BYZANTIUM_JUSTINIAN_BACKGROUND',	0.772,	0.6, 	0.172,	1);
------------------------------
-- PlayerColors
------------------------------			
INSERT INTO PlayerColors 
		(Type, 										PrimaryColor, 									SecondaryColor, 									TextColor)
VALUES	('PLAYERCOLOR_JFD_BYZANTIUM_JUSTINIAN',		'COLOR_PLAYER_JFD_BYZANTIUM_JUSTINIAN_ICON', 	'COLOR_PLAYER_JFD_BYZANTIUM_JUSTINIAN_BACKGROUND', 	'COLOR_PLAYER_WHITE_TEXT');
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 										Filename, 									LoadType)
VALUES	('SND_LEADER_MUSIC_JFD_JUSTINIAN_PEACE', 		'Justinian_Peace',							'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_JUSTINIAN_WAR', 			'Justinian_War',							'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 										SoundID, 									SoundType, 		MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_AMBIENCE_LEADER_JFD_JUSTINIAN_AMBIENCE',	'SND_AMBIENCE_HARUN_AL_RASHID_AMBIENCE', 	'GAME_SFX', 	50, 		50, 		0, 		 1),
		('AS2D_LEADER_MUSIC_JFD_JUSTINIAN_PEACE', 		'SND_LEADER_MUSIC_JFD_JUSTINIAN_PEACE',		'GAME_MUSIC', 	60, 		60, 		1, 		 0),
		('AS2D_LEADER_MUSIC_JFD_JUSTINIAN_WAR', 		'SND_LEADER_MUSIC_JFD_JUSTINIAN_WAR', 		'GAME_MUSIC', 	60, 		60, 		1,		 0);
--==========================================================================================================================	
--==========================================================================================================================