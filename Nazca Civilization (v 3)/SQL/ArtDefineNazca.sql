INSERT INTO ArtDefine_LandmarkTypes
		(Type,								LandmarkType,	FriendlyName)
VALUES	('ART_DEF_IMPROVEMENT_GEOGLYPHS',	'Improvement',	'GEOGLYPHS');

INSERT INTO ArtDefine_Landmarks
		(Era, 	State,					Scale,	ImprovementType,					LayoutHandler,	ResourceType,				Model,				TerrainContour)
VALUES	('Any', 'UnderConstruction',	0.80,	'ART_DEF_IMPROVEMENT_GEOGLYPHS',	'RANDOM',		'ART_DEF_RESOURCE_NONE',	'nazca_hb.fxsxml',	1),
		('Any', 'Constructed',			0.80,	'ART_DEF_IMPROVEMENT_GEOGLYPHS',	'RANDOM',		'ART_DEF_RESOURCE_NONE',	'nazca01.fxsxml',	1),
		('Any', 'Constructed',			0.80,	'ART_DEF_IMPROVEMENT_GEOGLYPHS',	'RANDOM',		'ART_DEF_RESOURCE_NONE',	'nazca02.fxsxml',	1),
		('Any', 'Constructed',			0.80,	'ART_DEF_IMPROVEMENT_GEOGLYPHS',	'RANDOM',		'ART_DEF_RESOURCE_NONE',	'nazca03.fxsxml',	1),
		('Any', 'Pillaged',				0.80,	'ART_DEF_IMPROVEMENT_GEOGLYPHS',	'RANDOM',		'ART_DEF_RESOURCE_NONE',	'nazca_pl.fxsxml',	1);