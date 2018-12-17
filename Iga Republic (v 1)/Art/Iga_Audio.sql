------------------------------
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 				Filename, 	LoadType)
VALUES	('SND_BIRTH_NINJA',		'Yooo',		'DynamicResident'),
		('SND_SELECT_NINJA',	'Tok',		'DynamicResident');
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 				SoundID, 			SoundType, 		TaperSoundtrackVolume,	DontTriggerDuplicates,	MinVolume, 	MaxVolume,  IsMusic, Looping)
VALUES	('AS2D_BIRTH_NINJA', 	'SND_BIRTH_NINJA',	'GAME_SFX', 	-1.0,					1,						60, 		60, 		0, 		 0),
		('AS2D_SELECT_NINJA', 	'SND_SELECT_NINJA',	'GAME_SFX', 	-1.0,					1,						60, 		60, 		0, 		 0);
------------------------------	