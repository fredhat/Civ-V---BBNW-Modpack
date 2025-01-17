--==========================================================================================================================
-- AUDIO
--==========================================================================================================================
-- Audio_Sounds
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID,									FileName,					LoadType)
VALUES	('SND_WONDER_SPEECH_JFD_SMITHSONIAN',		'Wonder_Smithsonian',		'DynamicResident');
------------------------------------------------------------------------------------------------------------------------
-- Audio_2DSounds
------------------------------------------------------------------------------------------------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID,									SoundID,								SoundType,		MinVolume,	MaxVolume)
VALUES	('AS2D_WONDER_SPEECH_JFD_SMITHSONIAN',		'SND_WONDER_SPEECH_JFD_SMITHSONIAN',	'GAME_SPEECH',	80,			80);
--==========================================================================================================================
-- ICON ATLASES
--==========================================================================================================================
-- IconTextureAtlases
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 					IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_TRIBE_WONDER_ATLAS',	256, 		'JFD_TribesWonder_256.dds',		1, 				1),
		('JFD_TRIBE_WONDER_ATLAS',	128, 		'JFD_TribesWonder_128.dds',		1, 				1),
		('JFD_TRIBE_WONDER_ATLAS',	80, 		'JFD_TribesWonder_80.dds',		1, 				1),
		('JFD_TRIBE_WONDER_ATLAS',	64, 		'JFD_TribesWonder_64.dds',		1, 				1),
		('JFD_TRIBE_WONDER_ATLAS',	45, 		'JFD_TribesWonder_45.dds',		1, 				1),
		('JFD_TRIBE_WONDER_ATLAS',	32, 		'JFD_TribesWonder_32.dds',		1, 				1);
--==========================================================================================================================
--==========================================================================================================================