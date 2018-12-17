--==========================================================================================================================
-- UnitPromotions
--==========================================================================================================================	
INSERT OR REPLACE INTO UnitPromotions 
			(Type, 							Description, 								Help, 										Sound, 				CannotBeChosen, LostWithUpgrade, 	PortraitIndex, 	IconAtlas, 			PediaType, 			PediaEntry)
VALUES		('PROMOTION_JFD_BIRKEBEINER', 	'TXT_KEY_PROMOTION_JFD_BIRKEBEINER_DESC', 	'TXT_KEY_PROMOTION_JFD_BIRKEBEINER_HELP', 	'AS2D_IF_LEVELUP', 	1, 				1,					59, 			'ABILITY_ATLAS', 	'PEDIA_ATTRIBUTES', 'TXT_KEY_PROMOTION_JFD_BIRKEBEINER_DESC');
--==========================================================================================================================
-- UnitPromotions_Terrains
--==========================================================================================================================	
INSERT OR REPLACE INTO UnitPromotions_Terrains		
			(PromotionType, 				TerrainType, 		Attack, Defense)
VALUES		('PROMOTION_JFD_BIRKEBEINER', 	'TERRAIN_SNOW', 	33, 	33),
			('PROMOTION_JFD_BIRKEBEINER', 	'TERRAIN_TUNDRA', 	33, 	33);
--==========================================================================================================================
--==========================================================================================================================