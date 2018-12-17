--==========================================================================================================================
-- Audio_Sounds
--==========================================================================================================================
INSERT INTO Audio_Sounds 
			(SoundID, 								Filename, 			LoadType)
VALUES		('SND_LEADER_MUSIC_JFD_LINCOLN_PEACE', 	'Lincoln_Peace',	'DynamicResident'),
			('SND_LEADER_MUSIC_JFD_LINCOLN_WAR', 	'Lincoln_War',		'DynamicResident');			
--==========================================================================================================================
-- Audio_2DSounds
--==========================================================================================================================
INSERT INTO Audio_2DSounds 
			(ScriptID, 								SoundID, 								SoundType, 		MinVolume, 	MaxVolume,	IsMusic,	Looping)
VALUES		('AS2D_LEADER_MUSIC_JFD_LINCOLN_PEACE', 'SND_LEADER_MUSIC_JFD_LINCOLN_PEACE',	'GAME_MUSIC',	50, 		50, 		1, 			0),
			('AS2D_LEADER_MUSIC_JFD_LINCOLN_WAR', 	'SND_LEADER_MUSIC_JFD_LINCOLN_WAR', 	'GAME_MUSIC',	50, 		50, 		1,			0);
--==========================================================================================================================
--==========================================================================================================================