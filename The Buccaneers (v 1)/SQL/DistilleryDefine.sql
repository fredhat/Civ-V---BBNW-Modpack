INSERT INTO ArtDefine_LandmarkTypes
		(Type, 											LandmarkType, 	FriendlyName)
VALUES 	('ART_DEF_IMPROVEMENT_BUCCANEER_DISTILLERY', 	'Improvement', 	'BUCCANEER_DISTILLERY');

INSERT INTO ArtDefine_Landmarks
		(Era, 	State, 					Scale, 	ImprovementType, 							LayoutHandler, 	ResourceType, 			Model, 					TerrainContour)
VALUES	('Any', 'UnderConstruction', 	0.001,  'ART_DEF_IMPROVEMENT_BUCCANEER_DISTILLERY', 'SNAPSHOT', 	'ART_DEF_RESOURCE_ALL', 'distillery_hb.fxsxml', 1),
		('Any', 'Constructed', 			0.001,  'ART_DEF_IMPROVEMENT_BUCCANEER_DISTILLERY', 'SNAPSHOT', 	'ART_DEF_RESOURCE_ALL', 'distillery.fxsxml', 	1),
		('Any', 'Pillaged', 			0.001,  'ART_DEF_IMPROVEMENT_BUCCANEER_DISTILLERY', 'SNAPSHOT', 	'ART_DEF_RESOURCE_ALL', 'distillery_pl.fxsxml', 1);

INSERT INTO ArtDefine_StrategicView
		(StrategicViewType, 							TileType, 		Asset)
VALUES	('ART_DEF_IMPROVEMENT_BUCCANEER_DISTILLERY', 	'Improvement', 	'sv_distillery.dds');