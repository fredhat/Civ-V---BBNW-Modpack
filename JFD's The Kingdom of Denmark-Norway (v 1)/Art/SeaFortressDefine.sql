INSERT INTO ArtDefine_LandmarkTypes
		(Type,										LandmarkType,	FriendlyName)
VALUES	('ART_DEF_IMPROVEMENT_JFD_SEA_FORTRESS',	'Improvement',	'SEAFORTRESS');

INSERT INTO ArtDefine_Landmarks
		(Era, 	State, 					Scale,	ImprovementType,						LayoutHandler,	ResourceType,			Model,					TerrainContour)
VALUES	('Any', 'UnderConstruction',	1.3,	'ART_DEF_IMPROVEMENT_JFD_SEA_FORTRESS', 'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'Feitoria_HB.fxsxml',	1),
		('Any', 'Constructed',			0.5,	'ART_DEF_IMPROVEMENT_JFD_SEA_FORTRESS', 'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'Anc_Citadel.fxsxml',	1),
		('Any', 'Pillaged',				1.3,	'ART_DEF_IMPROVEMENT_JFD_SEA_FORTRESS', 'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'Feitoria_PIL.fxsxml',	1);

INSERT INTO ArtDefine_StrategicView
		(StrategicViewType,							TileType,		Asset)
VALUES	('ART_DEF_IMPROVEMENT_JFD_SEA_FORTRESS',	'Improvement',	'sv_Citadel.dds');