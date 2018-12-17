--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 									Filename, 			LoadType)
VALUES	('SND_LEADER_MUSIC_JFD_PHILIP_II_PEACE', 	'PhilipII_Peace',	'DynamicResident'),
		('SND_LEADER_MUSIC_JFD_PHILIP_II_WAR',		'PhilipII_War', 	'DynamicResident');		
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 									SoundID, 									SoundType, 		TaperSoundtrackVolume,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_LEADER_MUSIC_JFD_PHILIP_II_PEACE', 	'SND_LEADER_MUSIC_JFD_PHILIP_II_PEACE', 	'GAME_MUSIC', 	-1.0,					60, 		60, 		1, 		 0),
		('AS2D_LEADER_MUSIC_JFD_PHILIP_II_WAR', 	'SND_LEADER_MUSIC_JFD_PHILIP_II_WAR', 		'GAME_MUSIC', 	-1.0,					60, 		60, 		1,		 0);
--==========================================================================================================================	
--==========================================================================================================================