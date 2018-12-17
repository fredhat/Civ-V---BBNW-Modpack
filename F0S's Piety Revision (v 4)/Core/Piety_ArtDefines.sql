INSERT INTO ArtDefine_LandmarkTypes
		(Type, 							LandmarkType, 	FriendlyName)
VALUES	('ART_DEF_IMPROVEMENT_MISSION', 'Improvement', 	'European');

INSERT INTO ArtDefine_Landmarks
		(Era, 	State, 					Scale, ImprovementType, 				LayoutHandler, 	ResourceType, 			Model, 					TerrainContour)
VALUES	('Any', 'UnderConstruction', 	0.75,  'ART_DEF_IMPROVEMENT_MISSION', 	'SNAPSHOT', 	'ART_DEF_RESOURCE_ALL', 'sistineTI_HB.fxsxml', 	1),
		('Any', 'Constructed',       	0.75,  'ART_DEF_IMPROVEMENT_MISSION', 	'SNAPSHOT', 	'ART_DEF_RESOURCE_ALL', 'sistineTI_B.fxsxml',  	1),
		('Any', 'Pillaged',          	0.75,  'ART_DEF_IMPROVEMENT_MISSION', 	'SNAPSHOT', 	'ART_DEF_RESOURCE_ALL', 'WTI_PL.fxsxml', 		1);

INSERT INTO ArtDefine_StrategicView
		(StrategicViewType, 			TileType, 		Asset)
VALUES	('ART_DEF_IMPROVEMENT_MISSION', 'Improvement', 	'sv_mission.dds');