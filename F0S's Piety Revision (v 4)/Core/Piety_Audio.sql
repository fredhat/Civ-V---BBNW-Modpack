--==========================================================================================================================	
-- AUDIO
--==========================================================================================================================			
-- Audio_Sounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Audio_Sounds
		(SoundID, 							FileName, 				LoadType)
VALUES	('SND_GREAT_WORK_JFD_RELIC', 		'JFD_RelicFX', 			'DynamicResident');
--------------------------------------------------------------------------------------------------------------------------
-- Audio_2DSounds
--------------------------------------------------------------------------------------------------------------------------	
INSERT OR REPLACE INTO Audio_2DSounds
		(ScriptID, 							SoundID, 						DontTriggerDuplicates,	TaperSoundtrackVolume,	MinVolume,	MaxVolume,	SoundType)
VALUES	('AS2D_GREAT_WORK_JFD_RELIC', 		'SND_GREAT_WORK_JFD_RELIC', 	1,						0.0,					75,			75,			'GAME_SFX');
--==========================================================================================================================
--==========================================================================================================================