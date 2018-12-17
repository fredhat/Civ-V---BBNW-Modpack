--==========================================================================================================================	
-- BuildingClasses
--==========================================================================================================================	
INSERT INTO BuildingClasses 	
			(Type, 						 				DefaultBuilding, 						Description)
VALUES		('BUILDINGCLASS_F0S_MERCHANT_TRADE_DUMMY', 	'BUILDING_F0S_MERCHANT_TRADE_DUMMY', 	'TXT_KEY_BUILDING_F0S_MERCHANT_TRADE_DUMMY');
--==========================================================================================================================	
-- Buildings
--==========================================================================================================================			
INSERT INTO Buildings
			(Type, 									BuildingClass, 								Cost, 	PrereqTech, Description,									Help,												MinAreaSize, 	GreatWorkCount, 	FaithCost,	NumTradeRouteBonus,	NukeImmune,		ConquestProb,	IconAtlas, 				PortraitIndex,	ShowInPedia)
VALUES		('BUILDING_F0S_MERCHANT_TRADE_DUMMY',	'BUILDINGCLASS_F0S_MERCHANT_TRADE_DUMMY', 	-1, 	null, 		'TXT_KEY_BUILDING_F0S_MERCHANT_TRADE_DUMMY',	'TXT_KEY_BUILDING_F0S_MERCHANT_TRADE_DUMMY_HELP',	-1, 			0, 					-1,			1,					1,				100,			'JFD_ESTATE_ATLAS', 	0,				0);
--==========================================================================================================================		
--==========================================================================================================================