INSERT INTO ArtDefine_LandmarkTypes
		(Type,							LandmarkType,	FriendlyName)
VALUES	('ART_DEF_IMPROVEMENT_SCHLOSS', 'Improvement',	'SCHLOSS');

INSERT INTO ArtDefine_Landmarks
		(Era,	State,					Scale, ImprovementType,					LayoutHandler,	ResourceType,			Model,					TerrainContour)
VALUES	('Any', 'UnderConstruction',	0.20,  'ART_DEF_IMPROVEMENT_SCHLOSS',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'schloss_hb.fxsxml',	1),
		('Any', 'Constructed',			0.20,  'ART_DEF_IMPROVEMENT_SCHLOSS',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'schloss.fxsxml',		1),
		('Any', 'Pillaged',				0.20,  'ART_DEF_IMPROVEMENT_SCHLOSS',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'schloss_pl.fxsxml',	1);

INSERT INTO ArtDefine_StrategicView
		(StrategicViewType,				TileType,		Asset)
VALUES	('ART_DEF_IMPROVEMENT_SCHLOSS', 'Improvement',	'sv_schloss.dds');