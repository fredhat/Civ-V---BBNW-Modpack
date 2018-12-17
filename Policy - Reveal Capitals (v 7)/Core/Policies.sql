--==========================================================================================================================
-- POLICY BRANCHES
--==========================================================================================================================
-- PolicyBranchTypes
--------------------------------------------------------------------------------------------------------------------------
--Patronage
UPDATE PolicyBranchTypes
SET Help = 'TXT_KEY_POLICY_F0S_PATRONAGE_HELP'
WHERE Type = 'POLICY_BRANCH_PATRONAGE';

--Commerce
UPDATE PolicyBranchTypes
SET Help = 'TXT_KEY_POLICY_F0S_COMMERCE_HELP'
WHERE Type = 'POLICY_BRANCH_COMMERCE';
--==========================================================================================================================
-- POLICIES
--==========================================================================================================================
-- Policies
--------------------------------------------------------------------------------------------------------------------------
--Patronage Opener
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_PATRONAGE_HELP', MinorFriendshipDecayMod = -34
WHERE Type = 'POLICY_PATRONAGE';

--Philanthropy
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_PHILANTHROPY_HELP'
WHERE Type = 'POLICY_PHILANTHROPY';

--Consulates
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_CONSULATES_HELP', MinorFriendshipMinimum = 25
WHERE Type = 'POLICY_CONSULATES';

--Scholasticism
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_SCHOLASTICISM_HELP'
WHERE Type = 'POLICY_SCHOLASTICISM';

--Cultural Diplomacy
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_CULTURAL_DIPLOMACY_HELP'
WHERE Type = 'POLICY_CULTURAL_DIPLOMACY';

--Merchant Confederacy
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_MERCHANT_CONFEDERACY_HELP', CityStateTradeChange = 300
WHERE Type = 'POLICY_MERCHANT_CONFEDERACY';

--Commerce Opener
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_COMMERCE_HELP'
WHERE Type = 'POLICY_COMMERCE';

--Mercenary Army
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_TRADE_UNIONS_HELP', UnitGoldMaintenanceMod = -15
WHERE Type = 'POLICY_TRADE_UNIONS';

--Entrepreneurship
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_ENTREPRENEURSHIP_HELP', GreatMerchantRateModifier = 50, EmbarkedExtraMoves = 0
WHERE Type = 'POLICY_ENTREPRENEURSHIP';

--Mercantilism
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_MERCANTILISM_HELP'
WHERE Type = 'POLICY_MERCANTILISM';

--Wagon Trains
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_CARAVANS_HELP', LandTradeRouteGoldChange = 200
WHERE Type = 'POLICY_CARAVANS';

--Protectionism
UPDATE Policies
SET Help = 'TXT_KEY_POLICY_F0S_PROTECTIONISM_HELP', StrategicResourceMod = 150
WHERE Type = 'POLICY_PROTECTIONISM';
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassYieldChanges
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Policy_BuildingClassYieldChanges WHERE PolicyType = 'POLICY_MERCANTILISM';
--------------------------------------------------------------------------------------------------------------------------
-- Policy_BuildingClassYieldModifiers
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Policy_BuildingClassYieldModifiers 
		(PolicyType, 				BuildingClassType,				YieldType,			YieldMod)
VALUES	('POLICY_MERCANTILISM', 	'BUILDINGCLASS_CARAVANSARY',	'YIELD_SCIENCE',	5),
		('POLICY_MERCANTILISM', 	'BUILDINGCLASS_MARKET',			'YIELD_SCIENCE',	5),
		('POLICY_MERCANTILISM', 	'BUILDINGCLASS_BANK',			'YIELD_SCIENCE',	5),
		('POLICY_MERCANTILISM', 	'BUILDINGCLASS_MINT',			'YIELD_SCIENCE',	5),
		('POLICY_MERCANTILISM', 	'BUILDINGCLASS_STOCK_EXCHANGE',	'YIELD_SCIENCE',	5);
--==========================================================================================================================
--==========================================================================================================================