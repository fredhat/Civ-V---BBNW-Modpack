--==========================================================================================================================
-- Audio_Sounds
--==========================================================================================================================	
INSERT INTO Audio_Sounds 
			(SoundID, 								Filename, 			LoadType)
VALUES		('SND_LEADER_MUSIC_JFD_HAAKON_PEACE', 	'Haakon_Peace', 	'DynamicResident'),
			('SND_LEADER_MUSIC_JFD_HAAKON_WAR', 	'Haakon_War', 		'DynamicResident');			
--==========================================================================================================================
-- Audio_2DSounds
--==========================================================================================================================	
INSERT INTO Audio_2DSounds 
			(ScriptID, 									SoundID, 								SoundType, 		MinVolume, 	MaxVolume,	IsMusic,	Looping)
VALUES		('AS2D_LEADER_MUSIC_JFD_HAAKON_PEACE', 		'SND_LEADER_MUSIC_JFD_HAAKON_PEACE', 	'GAME_MUSIC', 	60, 		60, 		1, 			0),
			('AS2D_LEADER_MUSIC_JFD_HAAKON_WAR', 		'SND_LEADER_MUSIC_JFD_HAAKON_WAR', 		'GAME_MUSIC', 	60, 		60, 		1,			0),
			('AS2D_LEADER_MUSIC_JFD_HAAKON_AMBIENCE', 	'SND_AMBIENCE_FOG_OF_WAR_BED', 			'GAME_SFX', 	60, 		60, 		0,			1);
--==========================================================================================================================	
--==========================================================================================================================