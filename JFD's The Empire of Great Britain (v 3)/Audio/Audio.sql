--==========================================================================================================================
-- Audio_Sounds
--==========================================================================================================================	
INSERT INTO Audio_Sounds 
			(SoundID, 									Filename, 			LoadType)
VALUES		('SND_LEADER_MUSIC_JFD_VICTORIA_PEACE', 	'Victoria_Peace', 	'DynamicResident'),
			('SND_LEADER_MUSIC_JFD_VICTORIA_WAR', 		'Victoria_War', 	'DynamicResident');			
--==========================================================================================================================
-- Audio_2DSounds
--==========================================================================================================================	
INSERT INTO Audio_2DSounds 
			(ScriptID, 									SoundID, 								SoundType, 		MinVolume, 	MaxVolume,	IsMusic, Looping)
VALUES		('AS2D_LEADER_MUSIC_JFD_VICTORIA_PEACE', 	'SND_LEADER_MUSIC_JFD_VICTORIA_PEACE',	'GAME_MUSIC', 	50, 		50, 		1, 		0),
			('AS2D_LEADER_MUSIC_JFD_VICTORIA_WAR', 		'SND_LEADER_MUSIC_JFD_VICTORIA_WAR', 	'GAME_MUSIC', 	50, 		50, 		1,		0);
--==========================================================================================================================	
--==========================================================================================================================