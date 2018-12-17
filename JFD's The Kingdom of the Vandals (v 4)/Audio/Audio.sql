--==========================================================================================================================
-- Audio_Sounds
--==========================================================================================================================
INSERT INTO Audio_Sounds 
			(SoundID, 									Filename, 				LoadType)
VALUES		('SND_LEADER_MUSIC_JFD_GENSERIC_PEACE', 	'Genseric_Peace', 		'DynamicResident'),
			('SND_LEADER_MUSIC_JFD_GENSERIC_WAR', 		'Genseric_War', 		'DynamicResident');			
--==========================================================================================================================
-- Audio_2DSounds
--==========================================================================================================================
INSERT INTO Audio_2DSounds 
			(ScriptID, 									SoundID, 									SoundType, 	MinVolume, 	MaxVolume, IsMusic, Looping)
VALUES		('AS2D_LEADER_MUSIC_JFD_GENSERIC_PEACE',	'SND_LEADER_MUSIC_JFD_GENSERIC_PEACE', 		'GAME_MUSIC', 120, 		120, 		1, 		0),
			('AS2D_LEADER_MUSIC_JFD_GENSERIC_WAR', 		'SND_LEADER_MUSIC_JFD_GENSERIC_WAR', 		'GAME_MUSIC', 120, 		120, 		1,		0);
--==========================================================================================================================
--==========================================================================================================================