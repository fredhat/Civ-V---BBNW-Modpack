INSERT INTO ArtDefine_LandmarkTypes
		(Type,											LandmarkType,	FriendlyName)
VALUES	('ART_DEF_IMPROVEMENT_MC_SCOTTISH_CLAN_CASTLE',	'Improvement',	'MC_SCOTTISH_CLAN_CASTLE');

INSERT INTO ArtDefine_Landmarks
		(Era, 	State, 					Scale, ImprovementType,									LayoutHandler,	ResourceType,			Model,					TerrainContour)
VALUES	('Any', 'UnderConstruction',	0.08,  'ART_DEF_IMPROVEMENT_MC_SCOTTISH_CLAN_CASTLE',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'clancastle_hb.fxsxml',	1),
		('Any', 'Constructed',			0.08,  'ART_DEF_IMPROVEMENT_MC_SCOTTISH_CLAN_CASTLE',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'clancastle.fxsxml',	1),
		('Any', 'Pillaged',				0.08,  'ART_DEF_IMPROVEMENT_MC_SCOTTISH_CLAN_CASTLE',	'SNAPSHOT',		'ART_DEF_RESOURCE_ALL', 'clancastle_pl.fxsxml',	1);

INSERT INTO ArtDefine_StrategicView
		(StrategicViewType,								TileType,		Asset)
VALUES	('ART_DEF_IMPROVEMENT_MC_SCOTTISH_CLAN_CASTLE', 'Improvement',	'sv_clancastle.dds');