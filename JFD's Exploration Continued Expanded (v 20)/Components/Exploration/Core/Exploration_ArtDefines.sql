--==========================================================================================================================
-- ICON ATLASES
--==========================================================================================================================
-- IconTextureAtlases
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconTextureAtlases 
		(Atlas, 								IconSize, 	Filename, 									IconsPerRow, 	IconsPerColumn)
VALUES	('JFD_EXPLORATION_RESOURCE_ATLAS',		256, 		'JFD_ExplorationResources_256.dds',			6, 				6),
		('JFD_EXPLORATION_RESOURCE_ATLAS',		128, 		'JFD_ExplorationResources_128.dds',			6, 				6),
		('JFD_EXPLORATION_RESOURCE_ATLAS',		80, 		'JFD_ExplorationResources_80.dds',			6, 				6),
		('JFD_EXPLORATION_RESOURCE_ATLAS',		64, 		'JFD_ExplorationResources_64.dds',			6, 				6),
		('JFD_EXPLORATION_RESOURCE_ATLAS',		45, 		'JFD_ExplorationResources_45.dds',			6, 				6),
		('JFD_EXPLORATION_UNIT_ATLAS',			256, 		'JFD_ExplorationUnits_256.dds',				4, 				2),
		('JFD_EXPLORATION_UNIT_ATLAS',			128, 		'JFD_ExplorationUnits_128.dds',				4, 				2),
		('JFD_EXPLORATION_UNIT_ATLAS',			80, 		'JFD_ExplorationUnits_80.dds',				4, 				2),
		('JFD_EXPLORATION_UNIT_ATLAS',			64, 		'JFD_ExplorationUnits_64.dds',				4, 				2),
		('JFD_EXPLORATION_UNIT_ATLAS',			45, 		'JFD_ExplorationUnits_45.dds',				4, 				2),
		('JFD_EXPLORATION_UNIT_ATLAS',			32, 		'JFD_ExplorationUnits_32.dds',				4, 				2),
		('JFD_EXPLORATION_WONDER_ATLAS',		256, 		'JFD_ExplorationWonders_256.dds',			1, 				1),
		('JFD_EXPLORATION_WONDER_ATLAS',		128, 		'JFD_ExplorationWonders_128.dds',			1, 				1),
		('JFD_EXPLORATION_WONDER_ATLAS',		80, 		'JFD_ExplorationWonders_80.dds',			1, 				1),
		('JFD_EXPLORATION_WONDER_ATLAS',		64, 		'JFD_ExplorationWonders_64.dds',			1, 				1),
		('JFD_EXPLORATION_WONDER_ATLAS',		45, 		'JFD_ExplorationWonders_45.dds',			1, 				1),
		('JFD_UNIT_FLAG_ADVENTURER_ATLAS',		32, 		'JFD_AdventurerUnitFlag_32.dds',			1, 				1),
		('JFD_UNIT_FLAG_EXPLORER_ATLAS',		32,			'JFD_ExplorerUnitFlag_32.dds',				1, 				1);
--==========================================================================================================================
-- FONT ICONS
--==========================================================================================================================
-- IconFontTextures
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconFontTextures 
		(IconFontTexture, 						IconFontTextureFile)
VALUES	('ICON_FONT_TEXTURE_JFD_CEDAR', 		'JFD_CedarFontIcon_22'),
		('ICON_FONT_TEXTURE_JFD_GINGER', 		'JFD_GingerFontIcon_22'),
		('ICON_FONT_TEXTURE_JFD_FEATHERS', 		'JFD_FeathersFontIcon_22'),
		('ICON_FONT_TEXTURE_JFD_LOTUS', 		'JFD_LotusFontIcon_22'),
		('ICON_FONT_TEXTURE_JFD_MANUSCRIPTS', 	'JFD_ManuscriptsFontIcon_22'),
		('ICON_FONT_TEXTURE_JFD_OAK', 			'JFD_OakFontIcon_22'),
		('ICON_FONT_TEXTURE_JFD_OBSIDIAN', 		'JFD_ObsidianFontIcon_22'),
		('ICON_FONT_TEXTURE_JFD_OPIUM', 		'JFD_OpiumFontIcon_22'),
		('ICON_FONT_TEXTURE_JFD_RUBBER', 		'JFD_RubberFontIcon_22'),
		('ICON_FONT_TEXTURE_JFD_SAFFRON', 		'JFD_SaffronFontIcon_22'),
		('ICON_FONT_TEXTURE_JFD_SULFUR', 		'JFD_SulfurFontIcon_22'),
		('ICON_FONT_TEXTURE_JFD_VANILLA', 		'JFD_VanillaFontIcon_22');	
--------------------------------------------------------------------------------------------------------------------------
-- IconFontMapping
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO IconFontMapping 
		(IconName, 								IconFontTexture,							IconMapping)
VALUES	('ICON_RES_JFD_CEDAR', 					'ICON_FONT_TEXTURE_JFD_CEDAR',				1),
		('ICON_RES_JFD_FEATHERS', 				'ICON_FONT_TEXTURE_JFD_FEATHERS',			1),
		('ICON_RES_JFD_GINGER', 				'ICON_FONT_TEXTURE_JFD_GINGER',				1),
		('ICON_RES_JFD_LOTUS', 					'ICON_FONT_TEXTURE_JFD_LOTUS',				1),
		('ICON_RES_JFD_MANUSCRIPTS', 			'ICON_FONT_TEXTURE_JFD_MANUSCRIPTS',		1),
		('ICON_RES_JFD_OAK', 					'ICON_FONT_TEXTURE_JFD_OAK',				1),
		('ICON_RES_JFD_OBSIDIAN', 				'ICON_FONT_TEXTURE_JFD_OBSIDIAN',			1),
		('ICON_RES_JFD_OPIUM', 					'ICON_FONT_TEXTURE_JFD_OPIUM',				1),
		('ICON_RES_JFD_RUBBER', 				'ICON_FONT_TEXTURE_JFD_RUBBER',				1),
		('ICON_RES_JFD_SAFFRON', 				'ICON_FONT_TEXTURE_JFD_SAFFRON',			1),
		('ICON_RES_JFD_SULFUR', 				'ICON_FONT_TEXTURE_JFD_SULFUR',				1),
		('ICON_RES_JFD_VANILLA', 				'ICON_FONT_TEXTURE_JFD_VANILLA',			1);	
--==========================================================================================================================
-- ART DEFINES
--==========================================================================================================================
-- ArtDefine_StrategicView
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_StrategicView 
		(StrategicViewType,						TileType,			Asset) 
VALUES	('ART_DEF_RESOURCE_JFD_CEDAR',			'Resource',			'sv_Cedar.dds'),
		('ART_DEF_RESOURCE_JFD_FEATHERS',		'Resource',			'sv_Feathers.dds'),
		('ART_DEF_RESOURCE_JFD_GINGER',			'Resource',			'sv_Ginger.dds'),
		('ART_DEF_RESOURCE_JFD_LOTUS',			'Resource',			'sv_Lotus.dds'),
		('ART_DEF_RESOURCE_JFD_OAK',			'Resource',			'sv_Oak.dds'),
		('ART_DEF_RESOURCE_JFD_OBSIDIAN',		'Resource',			'sv_Obsidian.dds'),
		('ART_DEF_RESOURCE_JFD_OPIUM',			'Resource',			'sv_Opium.dds'),
		('ART_DEF_RESOURCE_JFD_RUBBER',			'Resource',			'sv_Rubber.dds'),
		('ART_DEF_RESOURCE_JFD_SAFFRON',		'Resource',			'sv_Saffron.dds'),
		('ART_DEF_RESOURCE_JFD_SULFUR',			'Resource',			'sv_Sulfur.dds'),
		('ART_DEF_RESOURCE_JFD_VANILLA',		'Resource',			'sv_Vanilla.dds'),
		('ART_DEF_UNIT_JFD_ADVENTURER',			'Unit',				'sv_Adventurer.dds'),
		('ART_DEF_UNIT_JFD_EXPLORER',			'Unit',				'sv_GreatRecon.dds');	
--------------------------------------------------------------------------------------------------------------------------		
-- ArtDefine_LandmarkTypes
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_LandmarkTypes 
		(Type,									LandmarkType,		FriendlyName) 
VALUES	('ART_DEF_RESOURCE_JFD_CEDAR',			'Resource',			'Cedar'),
		('ART_DEF_RESOURCE_JFD_FEATHERS',		'Resource',			'Feathers'),
		('ART_DEF_RESOURCE_JFD_GINGER',			'Resource',			'Ginger'),
		('ART_DEF_RESOURCE_JFD_LOTUS',			'Resource',			'Lotus'),
		('ART_DEF_RESOURCE_JFD_OAK',			'Resource',			'Oak'),
		('ART_DEF_RESOURCE_JFD_OBSIDIAN',		'Resource',			'Obsidian'),
		('ART_DEF_RESOURCE_JFD_OPIUM',			'Resource',			'Opium'),
		('ART_DEF_RESOURCE_JFD_RUBBER',			'Resource',			'Rubber'),
		('ART_DEF_RESOURCE_JFD_SAFFRON',		'Resource',			'Saffron'),
		('ART_DEF_RESOURCE_JFD_SULFUR',			'Resource',			'Sulfur'),
		('ART_DEF_RESOURCE_JFD_VANILLA',		'Resource',			'Vanilla');	
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_Landmarks
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_Landmarks 
		(Era,			State,					Scale,					ImprovementType,								LayoutHandler,	ResourceType,						Model,										TerrainContour, Tech)
VALUES	('Any',			'Any',					1,						'ART_DEF_IMPROVEMENT_NONE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SULFUR',		'sulfur.fxsxml',							1,				null),
		('Ancient',		'UnderConstruction',	1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SULFUR',		'hb_med_sulfur_mine.fxsxml',				1,				null),
		('Ancient',		'Constructed',			1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SULFUR',		'med_mine_sulfur.fxsxml',					1,				null),
		('Ancient',		'Pillaged',				1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SULFUR',		'pl_med_mine_sulfur.fxsxml',				1,				null),
		('Industrial',	'UnderConstruction',	1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SULFUR',		'hb_ind_sulfur_mine.fxsxml',				1,				null),
		('Industrial',	'Constructed',			1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SULFUR',		'ind_mine_sulfur.fxsxml',					1,				null),
		('Industrial',	'Pillaged',				1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SULFUR',		'pl_ind_mine_sulfur.fxsxml',				1,				null),
		('Any',			'Any',					0.9399999976158142,		'ART_DEF_IMPROVEMENT_NONE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_VANILLA',		'Resource_Vanilla.fxsxml',					1,				null),
		('Ancient',		'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_VANILLA', 	'HB_Plantation_MID_Vanilla.fxsxml',			1,				null),
		('Ancient',		'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_VANILLA', 	'Plantation_MID_Vanilla.fxsxml',			1,				null),
		('Ancient',		'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_VANILLA', 	'PL_Plantation_MID_Vanilla.fxsxml',			1,				null),
		('Industrial',	'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_VANILLA', 	'HB_Plantation_IND_Vanilla.fxsxml',			1,				null),
		('Industrial',	'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_VANILLA', 	'Plantation_IND_Vanilla.fxsxml',			1,				null),
		('Industrial',	'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_VANILLA', 	'PL_Plantation_IND_Vanilla.fxsxml',			1,				null),
		('Any', 		'Any',					0.9399999976158142,		'ART_DEF_IMPROVEMENT_NONE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_RUBBER',		'resource_Rubber.fxsxml',					1,				null),
		('Ancient', 	'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_RUBBER',		'HB_Plantation_MID_Rubber.fxsxml',			1,				null),
		('Ancient', 	'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_RUBBER',		'plantation_mid_rubber.gr2',				1,				null),
		('Ancient', 	'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_RUBBER',		'pl_plantation_mid_rubber.fxsxml',			1,				null),
		('Industrial', 	'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_RUBBER',		'HB_Plantation_IND_Rubber.fxsxml',			1,				null),
		('Industrial', 	'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_RUBBER',		'Plantation_IND_Rubber.fxsxml',				1,				null),
		('Industrial', 	'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_RUBBER',		'PL_Plantation_IND_Rubber.fxsxml',			1,				null),
		('Any', 		'Any',					0.9399999976158142,		'ART_DEF_IMPROVEMENT_NONE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_GINGER',		'resource_ginger.fxsxml',					1,				null),
		('Ancient', 	'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_GINGER',		'HB_Plantation_MID_ginger.fxsxml',			1,				null),
		('Ancient', 	'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_GINGER',		'plantation_mid_ginger.fxsxml',				1,				null),
		('Ancient', 	'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_GINGER',		'pl_plantation_mid_ginger.fxsxml',			1,				null),
		('Industrial', 	'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_GINGER',		'HB_Plantation_IND_ginger.fxsxml',			1,				null),
		('Industrial', 	'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_GINGER',		'Plantation_IND_ginger.fxsxml',				1,				null),
		('Industrial', 	'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_GINGER',		'PL_Plantation_IND_ginger.fxsxml',			1,				null),
		('Any',			'Any',					0.9399999976158142,		'ART_DEF_IMPROVEMENT_NONE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OPIUM',		'Resource_Poppy.fxsxml',					1,				null),
		('Ancient',		'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OPIUM', 		'HB_Plantation_MID_Poppy.fxsxml',			1,				null),
		('Ancient',		'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OPIUM', 		'Plantation_MID_Poppy.fxsxml',				1,				null),
		('Ancient',		'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OPIUM', 		'PL_Plantation_MID_Poppy.fxsxml',			1,				null),
		('Industrial',	'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OPIUM', 		'HB_Plantation_IND_Poppy.fxsxml',			1,				null),
		('Industrial',	'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OPIUM', 		'Plantation_IND_Poppy.fxsxml',				1,				null),
		('Industrial',	'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OPIUM', 		'PL_Plantation_IND_Poppy.fxsxml',			1,				null),
		('Any',			'Any',					0.9399999976158142,		'ART_DEF_IMPROVEMENT_NONE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OAK',			'lumbertrees.fxsxml',						1,				null),
		('Ancient',		'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OAK', 		'HB_Plantation_MID_Lumbertrees.fxsxml',		1,				null),
		('Ancient',		'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OAK', 		'Plantation_MID_Lumbertrees.fxsxml',		1,				null),
		('Ancient',		'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OAK', 		'PL_Plantation_MID_Lumbertrees.fxsxml',		1,				null),
		('Industrial',	'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OAK', 		'HB_Plantation_IND_Lumbertrees.fxsxml',		1,				null),
		('Industrial',	'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OAK', 		'Plantation_IND_Lumbertrees.fxsxml',		1,				null),
		('Industrial',	'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OAK', 		'PL_Plantation_IND_Lumbertrees.fxsxml',		1,				null),
		('Any',			'Any',					0.9399999976158142,		'ART_DEF_IMPROVEMENT_NONE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_CEDAR',		'pinetrees.fxsxml',							1,				null),
		('Ancient',		'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_CEDAR', 		'HB_Plantation_MID_pinetrees.fxsxml',		1,				null),
		('Ancient',		'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_CEDAR', 		'Plantation_MID_pinetrees.fxsxml',			1,				null),
		('Ancient',		'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_CEDAR', 		'PL_Plantation_MID_pinetrees.fxsxml',		1,				null),
		('Industrial',	'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_CEDAR', 		'HB_Plantation_IND_pinetrees.fxsxml',		1,				null),
		('Industrial',	'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_CEDAR', 		'Plantation_IND_pinetrees.fxsxml',			1,				null),
		('Industrial',	'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_LUMBERMILL',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_CEDAR', 		'PL_Plantation_IND_pinetrees.fxsxml',		1,				null),
		('Any',			'Any',					0.07000000029802322,	'ART_DEF_IMPROVEMENT_NONE',						'ANIMATED',		'ART_DEF_RESOURCE_JFD_FEATHERS', 	'Feathers.fxsxml',							1,				null),
		('Any',			'Any',					0.07000000029802322,	'ART_DEF_IMPROVEMENT_TRADING_POST1',			'ANIMATED',		'ART_DEF_RESOURCE_JFD_FEATHERS', 	'Feathers.fxsxml',							1,				null),
		('Any',			'Any',					1,						'ART_DEF_IMPROVEMENT_NONE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OBSIDIAN',	'obsidian.fxsxml',							1,				null),
		('Ancient',		'UnderConstruction',	1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OBSIDIAN',	'hb_med_obsidian_mine.fxsxml',				1,				null),
		('Ancient',		'Constructed',			1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OBSIDIAN',	'med_mine_obsidian.fxsxml',					1,				null),
		('Ancient',		'Pillaged',				1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OBSIDIAN',	'pl_med_mine_obsidian.fxsxml',				1,				null),
		('Industrial',	'UnderConstruction',	1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OBSIDIAN',	'hb_ind_obsidian_mine.fxsxml',				1,				null),
		('Industrial',	'Constructed',			1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OBSIDIAN',	'ind_mine_obsidian.fxsxml',					1,				null),
		('Industrial',	'Pillaged',				1,						'ART_DEF_IMPROVEMENT_MINE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_OBSIDIAN',	'pl_ind_mine_obsidian.fxsxml',				1,				null),
		('Any',			'Any',					0.9399999976158142,		'ART_DEF_IMPROVEMENT_NONE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_LOTUS',		'Resource_Lotus.fxsxml',					1,				null),
		('Ancient',		'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_LOTUS', 		'HB_Plantation_MID_Lotus.fxsxml',			1,				null),
		('Ancient',		'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_LOTUS', 		'Plantation_MID_Lotus.fxsxml',				1,				null),
		('Ancient',		'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_LOTUS', 		'PL_Plantation_MID_Lotus.fxsxml',			1,				null),
		('Industrial',	'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_LOTUS', 		'HB_Plantation_IND_Lotus.fxsxml',			1,				null),
		('Industrial',	'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_LOTUS', 		'Plantation_IND_Lotus.fxsxml',				1,				null),
		('Industrial',	'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_LOTUS', 		'PL_Plantation_IND_Lotus.fxsxml',			1,				null),
		('Any',			'Any',					0.9399999976158142,		'ART_DEF_IMPROVEMENT_NONE',						'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SAFFRON',		'Resource_Saffron.fxsxml',					1,				null),
		('Ancient',		'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SAFFRON',		'HB_Plantation_MID_Saffron.fxsxml',			1,				null),
		('Ancient',		'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SAFFRON',		'Plantation_MID_Saffron.fxsxml',			1,				null),
		('Ancient',		'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SAFFRON',		'PL_Plantation_MID_Saffron.fxsxml',			1,				null),
		('Industrial',	'UnderConstruction',	0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SAFFRON',		'HB_Plantation_IND_Saffron.fxsxml',			1,				null),
		('Industrial',	'Constructed',			0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SAFFRON',		'Plantation_IND_Saffron.fxsxml',			1,				null),
		('Industrial',	'Pillaged',				0.9599999785423279,		'ART_DEF_IMPROVEMENT_PLANTATION',				'SNAPSHOT',		'ART_DEF_RESOURCE_JFD_SAFFRON',		'PL_Plantation_IND_Saffron.fxsxml',			1,				null);	
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfos
--------------------------------------------------------------------------------------------------------------------------			
INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates,	Formation)
SELECT 	'ART_DEF_UNIT_JFD_ADVENTURER', 			DamageStates, 	Formation
FROM ArtDefine_UnitInfos WHERE	Type = 'ART_DEF_UNIT_EXPLORER';		

INSERT INTO ArtDefine_UnitInfos 
		(Type, 									DamageStates,	Formation)
SELECT 	'ART_DEF_UNIT_JFD_EXPLORER', 			DamageStates, 	'Scout'
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_MUSKETMAN';		
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitInfoMemberInfos
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,								NumMembers)
SELECT 	'ART_DEF_UNIT_JFD_ADVENTURER', 			UnitMemberInfoType, 							NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_EXPLORER';	

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,								NumMembers)
SELECT 	'ART_DEF_UNIT_JFD_EXPLORER', 			'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_1',			2
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_SCOUT';	

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,								NumMembers)
SELECT 	'ART_DEF_UNIT_JFD_EXPLORER', 			'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_2',			1
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_MUSKETMAN';	

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,								NumMembers)
SELECT 	'ART_DEF_UNIT_JFD_EXPLORER', 			'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_3',			2
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_MUSKETMAN';	

INSERT INTO ArtDefine_UnitInfoMemberInfos 	
		(UnitInfoType,							UnitMemberInfoType,								NumMembers)
SELECT 	'ART_DEF_UNIT_JFD_EXPLORER', 			'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_4',			1
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_MUSKETMAN';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombats
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_1',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';	

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_2',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';	

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_3',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';	

INSERT INTO ArtDefine_UnitMemberCombats 
		(UnitMemberType,						EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_4',	EnableActions, DisableActions, MoveRadius, ShortMoveRadius, ChargeRadius, AttackRadius, RangedAttackRadius, MoveRate, ShortMoveRate, TurnRateMin, TurnRateMax, TurnFacingRateMin, TurnFacingRateMax, RollRateMin, RollRateMax, PitchRateMin, PitchRateMax, LOSRadiusScale, TargetRadius, TargetHeight, HasShortRangedAttack, HasLongRangedAttack, HasLeftRightAttack, HasStationaryMelee, HasStationaryRangedAttack, HasRefaceAfterCombat, ReformBeforeCombat, HasIndependentWeaponFacing, HasOpponentTracking, HasCollisionAttack, AttackAltitude, AltitudeDecelerationDistance, OnlyTurnInMovementActions, RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberCombatWeapons
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_1',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';	

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_2',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';	

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_3',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';	

INSERT INTO ArtDefine_UnitMemberCombatWeapons	
		(UnitMemberType,						"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_4',	"Index", SubIndex, ID, VisKillStrengthMin, VisKillStrengthMax, ProjectileSpeed, ProjectileTurnRateMin, ProjectileTurnRateMax, HitEffect, HitEffectScale, HitRadius, ProjectileChildEffectScale, AreaDamageDelay, ContinuousFire, WaitForEffectCompletion, TargetGround, IsDropped, WeaponTypeTag, WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';	
--------------------------------------------------------------------------------------------------------------------------
-- ArtDefine_UnitMemberInfos
--------------------------------------------------------------------------------------------------------------------------	
INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale, ZOffset, Domain, Model, 							MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_1',	Scale, ZOffset, Domain, 'conquistador_musket_1.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';	

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale, ZOffset, Domain, Model, 							MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_2',	Scale, ZOffset, Domain, 'conquistador_musket_2.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';	

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale, ZOffset, Domain, Model, 							MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_3',	Scale, ZOffset, Domain, 'conquistador_musket_3.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';	

INSERT INTO ArtDefine_UnitMemberInfos 	
		(Type, 									Scale, ZOffset, Domain, Model, 							MaterialTypeTag, MaterialTypeSoundOverrideTag)
SELECT 	'ART_DEF_UNIT_MEMBER_JFD_EXPLORER_4',	Scale, ZOffset, Domain, 'conquistador_musket_4.fxsxml',	MaterialTypeTag, MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_MUSKETMAN';
--==========================================================================================================================
-- AUDIO
--==========================================================================================================================	
-- Audio_Sounds
------------------------------	
INSERT INTO Audio_Sounds 
		(SoundID, 								Filename, 				LoadType)
VALUES	('SND_WONDER_SPEECH_JFD_BELEM_TOWER', 	'Wonder_BelemTower',	'DynamicResident');	
------------------------------
-- Audio_2DSounds
------------------------------	
INSERT INTO Audio_2DSounds 
		(ScriptID, 								SoundID, 								SoundType, 				TaperSoundtrackVolume,	MinVolume, 	MaxVolume)
VALUES	('AS2D_WONDER_SPEECH_JFD_BELEM_TOWER',	'SND_WONDER_SPEECH_JFD_BELEM_TOWER', 	'GAME_MUSIC_STINGS', 	0.0,					75, 		75);	
--==========================================================================================================================
--==========================================================================================================================