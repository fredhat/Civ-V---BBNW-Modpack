--==========================================================================================================================
-- ArtDefine_Landmarks
--==========================================================================================================================
INSERT INTO ArtDefine_Landmarks 
			(Era, 	State, 	Scale, 	ImprovementType, 							LayoutHandler,	ResourceType,				Model,																TerrainContour)
VALUES		('Any', 'Any', 	1.0,	'ART_DEF_IMPROVEMENT_OFFSHORE_PLATFORM', 	'SNAPSHOT',		'ART_DEF_RESOURCE_NONE',	'Assets/Buildings/Improvements/Oil_Rig/Water/Oil_Platform.fxsxml',	1);
--==========================================================================================================================
-- IconTextureAtlases
--==========================================================================================================================
INSERT INTO IconTextureAtlases 
			(Atlas, 					IconSize, 	Filename, 						IconsPerRow, 	IconsPerColumn)
VALUES		('F0S_MISC_FIXES_ATLAS', 	256, 		'F0S_MiscFixesAtlas_256.dds',	1, 				1),
			('F0S_MISC_FIXES_ATLAS', 	128, 		'F0S_MiscFixesAtlas_128.dds',	1, 				1),
			('F0S_MISC_FIXES_ATLAS', 	64, 		'F0S_MiscFixesAtlas_64.dds',	1, 				1),
			('F0S_MISC_FIXES_ATLAS', 	45, 		'F0S_MiscFixesAtlas_45.dds',	1, 				1);
--==========================================================================================================================
--==========================================================================================================================