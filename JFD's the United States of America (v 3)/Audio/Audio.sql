--==========================================================================================================================	
-- Audio_Sounds
--==========================================================================================================================		
INSERT INTO Audio_Sounds 
			(SoundID, 									Filename, 			LoadType)
VALUES		('SND_LEADER_MUSIC_JFD_ROOSEVELT_PEACE', 	'Roosevelt_Peace',	'DynamicResident'),
			('SND_LEADER_MUSIC_JFD_ROOSEVELT_WAR', 		'Roosevelt_War', 	'DynamicResident');			
--==========================================================================================================================	
-- Audio_2DSounds
--==========================================================================================================================		
INSERT INTO Audio_2DSounds 
			(ScriptID, 									SoundID, 								SoundType, 		MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES		('AS2D_LEADER_MUSIC_JFD_ROOSEVELT_PEACE', 	'SND_LEADER_MUSIC_JFD_ROOSEVELT_PEACE', 'GAME_MUSIC', 	50, 		50, 		1, 		 0),
			('AS2D_LEADER_MUSIC_JFD_ROOSEVELT_WAR', 	'SND_LEADER_MUSIC_JFD_ROOSEVELT_WAR', 	'GAME_MUSIC', 	50, 		50, 		1,		 0);
--==========================================================================================================================		
--==========================================================================================================================