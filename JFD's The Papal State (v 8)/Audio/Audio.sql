--==========================================================================================================================	
-- Audio_Sounds
--==========================================================================================================================		
INSERT INTO Audio_Sounds 
			(SoundID, 															Filename, 												LoadType)
VALUES		('SND_LEADER_MUSIC_JFD_PIUS_PEACE', 								'Pius_Peace',											'DynamicResident'),
			('SND_LEADER_MUSIC_JFD_PIUS_WAR', 									'Pius_War', 											'DynamicResident'),		
			('SND_GREAT_ARTIST_WRITER_O_BONE_JESU', 							'GW_Art_Writing-O_Bone_Jesu', 							'DynamicResident'),
			('SND_GREAT_MUSICIAN_ALLEGRI_MISEREREI_MEI_DEUS', 					'GW_Gregorio_Allegri-Misererei_Mei_Deus', 				'DynamicResident'),
			('SND_GREAT_MUSICIAN_PALESTRINA_ALMA_REDEMPTORIS_MATER', 			'GW_Palestrina-Alma_Redemptoris_Mater', 				'DynamicResident'),
			('SND_GREAT_MUSICIAN_PALESTRINA_MISSA_PAPAE_MARCELLI_CREDO', 		'GW_Palestrina-Missa_Papae_Marcelli_Credo', 			'DynamicResident'),
			('SND_GREAT_MUSICIAN_BRUMEL_MISSA_ET_ECCE_TERRAE_MOTUS_GLORIA', 	'GW_Antoine_Brumel-Missa_Et_ecce_terrae_motus_Gloria',	'DynamicResident'),
			('SND_GREAT_MUSICIAN_VINDERS_O_MORS_INEVITABILIS', 					'GW_Jheronimus_Vinders-O_Mors_Inevitabilis', 			'DynamicResident'),
			('SND_GREAT_MUSICIAN_SHEPPARD_MEDIA_VITA', 							'GW_John_Sheppard-Media_Vita', 							'DynamicResident'),
			('SND_GREAT_MUSICIAN_OCKEGHEM_INTEMERATA', 							'GW_Johannes_Ockeghem-Intemerata', 						'DynamicResident'),
			('SND_GREAT_MUSICIAN_MOZART_REQUIEM', 								'GW_Mozart-Requiem', 									'DynamicResident'),
			('SND_GREAT_MUSICIAN_VERDI_DIES_IRAE', 								'GW_Verdi-Dies_Irae', 									'DynamicResident'),
			('SND_GREAT_MUSICIAN_SCHUBERT_AVE_MARIA', 							'GW_Franz_Schubert-Ave_Maria', 							'DynamicResident');
--==========================================================================================================================	
-- Audio_2DSounds
--==========================================================================================================================		
INSERT INTO Audio_2DSounds 
			(ScriptID, 															SoundID, 														SoundType, 				MinVolume, 	MaxVolume,  TaperSoundtrackVolume,	IsMusic, Looping)
VALUES		('AS2D_LEADER_MUSIC_JFD_PIUS_PEACE', 								'SND_LEADER_MUSIC_JFD_PIUS_PEACE', 								'GAME_MUSIC', 			60, 		60, 		-1.0,					1, 		 0),
			('AS2D_LEADER_MUSIC_JFD_PIUS_WAR', 									'SND_LEADER_MUSIC_JFD_PIUS_WAR', 								'GAME_MUSIC', 			60, 		60, 		-1.0,					1,		 0),
			('AS2D_GREAT_ARTIST_WRITER_O_BONE_JESU', 							'SND_GREAT_ARTIST_WRITER_O_BONE_JESU', 							'GAME_MUSIC_STINGS', 	100, 		100, 		0.0,					0,		 0),
			('AS2D_GREAT_MUSICIAN_ALLEGRI_MISEREREI_MEI_DEUS', 					'SND_GREAT_MUSICIAN_ALLEGRI_MISEREREI_MEI_DEUS', 				'GAME_MUSIC_STINGS', 	100, 		100, 		0.0,					0,		 0),
			('AS2D_GREAT_MUSICIAN_PALESTRINA_ALMA_REDEMPTORIS_MATER', 			'SND_GREAT_MUSICIAN_PALESTRINA_ALMA_REDEMPTORIS_MATER', 		'GAME_MUSIC_STINGS', 	100, 		100, 		0.0,					0,		 0),
			('AS2D_GREAT_MUSICIAN_PALESTRINA_MISSA_PAPAE_MARCELLI_CREDO', 		'SND_GREAT_MUSICIAN_PALESTRINA_MISSA_PAPAE_MARCELLI_CREDO', 	'GAME_MUSIC_STINGS', 	100, 		100, 		0.0,					0,		 0),
			('AS2D_GREAT_MUSICIAN_BRUMEL_MISSA_ET_ECCE_TERRAE_MOTUS_GLORIA', 	'SND_GREAT_MUSICIAN_BRUMEL_MISSA_ET_ECCE_TERRAE_MOTUS_GLORIA', 	'GAME_MUSIC_STINGS', 	100, 		100, 		0.0,					0,		 0),
			('AS2D_GREAT_MUSICIAN_VINDERS_O_MORS_INEVITABILIS', 				'SND_GREAT_MUSICIAN_VINDERS_O_MORS_INEVITABILIS', 				'GAME_MUSIC_STINGS', 	100, 		100, 		0.0,					0,		 0),
			('AS2D_GREAT_MUSICIAN_SHEPPARD_MEDIA_VITA', 						'SND_GREAT_MUSICIAN_SHEPPARD_MEDIA_VITA', 						'GAME_MUSIC_STINGS', 	100, 		100, 		0.0,					0,		 0),
			('AS2D_GREAT_MUSICIAN_OCKEGHEM_INTEMERATA', 						'SND_GREAT_MUSICIAN_OCKEGHEM_INTEMERATA', 						'GAME_MUSIC_STINGS', 	100, 		100, 		0.0,					0,		 0),
			('AS2D_GREAT_MUSICIAN_MOZART_REQUIEM', 								'SND_GREAT_MUSICIAN_MOZART_REQUIEM', 							'GAME_MUSIC_STINGS', 	100, 		100, 		0.0,					0,		 0),
			('AS2D_GREAT_MUSICIAN_VERDI_DIES_IRAE', 							'SND_GREAT_MUSICIAN_VERDI_DIES_IRAE', 							'GAME_MUSIC_STINGS', 	100, 		100, 		0.0,					0,		 0),
			('AS2D_GREAT_MUSICIAN_SCHUBERT_AVE_MARIA', 							'SND_GREAT_MUSICIAN_SCHUBERT_AVE_MARIA', 						'GAME_MUSIC_STINGS', 	100, 		100, 		0.0,					0,		 0);
--==========================================================================================================================		
--==========================================================================================================================