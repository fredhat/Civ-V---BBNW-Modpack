INSERT INTO ArtDefine_LandmarkTypes
		(Type, 								LandmarkType, 	FriendlyName)
VALUES	('ART_DEF_IMPROVEMENT_KAKUREZATO', 	'Improvement', 	'KAKUREZATO');

INSERT INTO ArtDefine_Landmarks
		(Era, 	State, 					Scale, 	ImprovementType, 					LayoutHandler, 	ResourceType, 			Model, 					TerrainContour)
VALUES	('Any', 'UnderConstruction', 	0.8, 	'ART_DEF_IMPROVEMENT_KAKUREZATO', 	'SNAPSHOT', 	'ART_DEF_RESOURCE_ALL', 'Kakurezato_hb.fxsxml', 1),
		('Any', 'Constructed', 			0.8, 	'ART_DEF_IMPROVEMENT_KAKUREZATO', 	'SNAPSHOT', 	'ART_DEF_RESOURCE_ALL', 'Kakurezato_01.fxsxml', 1),
		('Any', 'Pillaged', 			0.8, 	'ART_DEF_IMPROVEMENT_KAKUREZATO', 	'SNAPSHOT', 	'ART_DEF_RESOURCE_ALL', 'Kakurezato_pl.fxsxml', 1);

INSERT INTO ArtDefine_StrategicView
		(StrategicViewType, 				TileType, 		Asset)
VALUES	('ART_DEF_IMPROVEMENT_KAKUREZATO', 'Improvement',	'SV_Kakurezato.dds');