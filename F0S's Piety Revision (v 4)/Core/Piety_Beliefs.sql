--==========================================================================================================================
-- BELIEFS
--==========================================================================================================================
-- Pantheon
----------------------
UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_GODDESS_HUNT', ShortDescription = 'TXT_KEY_BELIEF_F0S_GODDESS_HUNT_SHORT'
WHERE Type = 'BELIEF_GODDESS_HUNT';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_FERTILITY_RITES', ShortDescription = 'TXT_KEY_BELIEF_F0S_FERTILITY_RITES_SHORT'
WHERE Type = 'BELIEF_FERTILITY_RITES';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_GOD_CRAFTSMEN', ShortDescription = 'TXT_KEY_BELIEF_F0S_GOD_CRAFTSMEN_SHORT', MinPopulation = 0
WHERE Type = 'BELIEF_GOD_CRAFTSMEN';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_GOD_SEA', ShortDescription = 'TXT_KEY_BELIEF_F0S_GOD_SEA_SHORT'
WHERE Type = 'BELIEF_GOD_SEA';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_OPEN_SKY', ShortDescription = 'TXT_KEY_BELIEF_F0S_OPEN_SKY_SHORT', PlotCultureCostModifier = -25
WHERE Type = 'BELIEF_OPEN_SKY';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_MESSENGER_GODS', ShortDescription = 'TXT_KEY_BELIEF_F0S_MESSENGER_GODS_SHORT'
WHERE Type = 'BELIEF_MESSENGER_GODS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_ONE_WITH_NATURE', ShortDescription = 'TXT_KEY_BELIEF_F0S_ONE_WITH_NATURE_SHORT'
WHERE Type = 'BELIEF_ONE_WITH_NATURE';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_FORMAL_LITURGY', ShortDescription = 'TXT_KEY_BELIEF_F0S_FORMAL_LITURGY_SHORT'
WHERE Type = 'BELIEF_FORMAL_LITURGY';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_STONE_CIRCLES', ShortDescription = 'TXT_KEY_BELIEF_F0S_STONE_CIRCLES_SHORT'
WHERE Type = 'BELIEF_STONE_CIRCLES';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_GOD_WAR', ShortDescription = 'TXT_KEY_BELIEF_F0S_GOD_WAR_SHORT', MaxDistance = 6, FaithFromKills = 100
WHERE Type = 'BELIEF_GOD_WAR';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_SACRED_WATERS', ShortDescription = 'TXT_KEY_BELIEF_F0S_SACRED_WATERS_SHORT'
WHERE Type = 'BELIEF_SACRED_WATERS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_GODDESS_LOVE', ShortDescription = 'TXT_KEY_BELIEF_F0S_GODDESS_LOVE_SHORT', MinPopulation = 0, HappinessPerCity = 0
WHERE Type = 'BELIEF_GODDESS_LOVE';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_SETTLEMENTS', ShortDescription = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_SETTLEMENTS_SHORT', PlotCultureCostModifier = 0
WHERE Type = 'BELIEF_RELIGIOUS_SETTLEMENTS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_GOD_FESTIVALS', ShortDescription = 'TXT_KEY_BELIEF_F0S_GOD_FESTIVALS_SHORT'
WHERE Type = 'BELIEF_GOD_FESTIVALS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_ORAL_TRADITION', ShortDescription = 'TXT_KEY_BELIEF_F0S_ORAL_TRADITION_SHORT'
WHERE Type = 'BELIEF_ORAL_TRADITION';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_ANCESTOR_WORSHIP', ShortDescription = 'TXT_KEY_BELIEF_F0S_ANCESTOR_WORSHIP_SHORT'
WHERE Type = 'BELIEF_ANCESTOR_WORSHIP';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_DESERT_FOLKLORE', ShortDescription = 'TXT_KEY_BELIEF_F0S_DESERT_FOLKLORE_SHORT'
WHERE Type = 'BELIEF_DESERT_FOLKLORE';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_SACRED_PATH', ShortDescription = 'TXT_KEY_BELIEF_F0S_SACRED_PATH_SHORT'
WHERE Type = 'BELIEF_SACRED_PATH';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_GODDESS_STRATEGY', ShortDescription = 'TXT_KEY_BELIEF_F0S_GODDESS_STRATEGY_SHORT', CityRangeStrikeModifier = 0
WHERE Type = 'BELIEF_GODDESS_STRATEGY';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_FAITH_HEALERS', ShortDescription = 'TXT_KEY_BELIEF_F0S_FAITH_HEALERS_SHORT', FriendlyHealChange = 0
WHERE Type = 'BELIEF_FAITH_HEALERS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_MONUMENT_GODS', ShortDescription = 'TXT_KEY_BELIEF_F0S_MONUMENT_GODS_SHORT', ObsoleteEra = 'ERA_RENAISSANCE'
WHERE Type = 'BELIEF_MONUMENT_GODS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_DANCE_AURORA', ShortDescription = 'TXT_KEY_BELIEF_F0S_DANCE_AURORA_SHORT'
WHERE Type = 'BELIEF_DANCE_AURORA';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_TEARS_OF_GODS', ShortDescription = 'TXT_KEY_BELIEF_F0S_TEARS_OF_GODS_SHORT'
WHERE Type = 'BELIEF_TEARS_OF_GODS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_EARTH_MOTHER', ShortDescription = 'TXT_KEY_BELIEF_F0S_EARTH_MOTHER_SHORT'
WHERE Type = 'BELIEF_EARTH_MOTHER';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_GOD_KING', ShortDescription = 'TXT_KEY_BELIEF_F0S_GOD_KING_SHORT'
WHERE Type = 'BELIEF_GOD_KING';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_SUN_GOD', ShortDescription = 'TXT_KEY_BELIEF_F0S_SUN_GOD_SHORT'
WHERE Type = 'BELIEF_SUN_GOD';

INSERT INTO Beliefs 
		(Type, 								Description, 								ShortDescription, 								Pantheon)
VALUES	('BELIEF_F0S_RITUAL_SACRIFICES', 	'TXT_KEY_BELIEF_F0S_RITUAL_SACRIFICES', 	'TXT_KEY_BELIEF_F0S_RITUAL_SACRIFICES_SHORT',	1),
		('BELIEF_F0S_SACRED_GROVES', 		'TXT_KEY_BELIEF_F0S_SACRED_GROVES', 		'TXT_KEY_BELIEF_F0S_SACRED_GROVES_SHORT',		1),
		('BELIEF_F0S_SACRED_MEDICINES', 	'TXT_KEY_BELIEF_F0S_SACRED_MEDICINES', 		'TXT_KEY_BELIEF_F0S_SACRED_MEDICINES_SHORT',	1),
		('BELIEF_F0S_SPIRIT_ANIMALS', 		'TXT_KEY_BELIEF_F0S_SPIRIT_ANIMALS', 		'TXT_KEY_BELIEF_F0S_SPIRIT_ANIMALS_SHORT',		1);
----------------------
-- Founder
----------------------
UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_PEACE_LOVING', ShortDescription = 'TXT_KEY_BELIEF_F0S_PEACE_LOVING_SHORT', HappinessPerXPeacefulForeignFollowers = 0
WHERE Type = 'BELIEF_PEACE_LOVING';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_INTERFAITH_DIALOGUE', ShortDescription = 'TXT_KEY_BELIEF_F0S_INTERFAITH_DIALOGUE_SHORT', SciencePerOtherReligionFollower = 25
WHERE Type = 'BELIEF_INTERFAITH_DIALOGUE';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_CEREMONIAL_BURIAL', ShortDescription = 'TXT_KEY_BELIEF_F0S_CEREMONIAL_BURIAL_SHORT', HappinessPerFollowingCity = 1
WHERE Type = 'BELIEF_CEREMONIAL_BURIAL';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_CHURCH_PROPERTY', ShortDescription = 'TXT_KEY_BELIEF_F0S_CHURCH_PROPERTY_SHORT', GoldPerFollowingCity = 0
WHERE Type = 'BELIEF_CHURCH_PROPERTY';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_TITHE', ShortDescription = 'TXT_KEY_BELIEF_F0S_TITHE_SHORT'
WHERE Type = 'BELIEF_TITHE';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_INITIATION_RITES', ShortDescription = 'TXT_KEY_BELIEF_F0S_INITIATION_RITES_SHORT', GoldPerFirstCityConversion = 200
WHERE Type = 'BELIEF_INITIATION_RITES';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_PAPAL_PRIMACY', ShortDescription = 'TXT_KEY_BELIEF_F0S_PAPAL_PRIMACY_SHORT', CityStateInfluenceModifier = 25
WHERE Type = 'BELIEF_PAPAL_PRIMACY';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_PILGRIMAGE', ShortDescription = 'TXT_KEY_BELIEF_F0S_PILGRIMAGE_SHORT'
WHERE Type = 'BELIEF_PILGRIMAGE';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_WORLD_CHURCH', ShortDescription = 'TXT_KEY_BELIEF_F0S_WORLD_CHURCH_SHORT'
WHERE Type = 'BELIEF_WORLD_CHURCH';

INSERT INTO Beliefs 
		(Type, 								Description, 								ShortDescription, 								Founder)
VALUES	('BELIEF_F0S_SPIRITUAL_TRADERS', 	'TXT_KEY_BELIEF_F0S_SPIRITUAL_TRADERS', 	'TXT_KEY_BELIEF_F0S_SPIRITUAL_TRADERS_SHORT',	1);
----------------------
-- Follower
----------------------
UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_FEED_WORLD', ShortDescription = 'TXT_KEY_BELIEF_F0S_FEED_WORLD_SHORT'
WHERE Type = 'BELIEF_FEED_WORLD';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_SWORD_PLOWSHARES', ShortDescription = 'TXT_KEY_BELIEF_F0S_SWORD_PLOWSHARES_SHORT', CityGrowthModifier = 0, RequiresPeace = 0
WHERE Type = 'BELIEF_SWORD_PLOWSHARES';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_GURUSHIP', ShortDescription = 'TXT_KEY_BELIEF_F0S_GURUSHIP_SHORT'
WHERE Type = 'BELIEF_GURUSHIP';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_HOLY_WARRIORS', ShortDescription = 'TXT_KEY_BELIEF_F0S_HOLY_WARRIORS_SHORT'
WHERE Type = 'BELIEF_HOLY_WARRIORS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_CATHEDRALS', ShortDescription = 'TXT_KEY_BELIEF_F0S_CATHEDRALS_SHORT'
WHERE Type = 'BELIEF_CATHEDRALS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_MOSQUES', ShortDescription = 'TXT_KEY_BELIEF_F0S_MOSQUES_SHORT'
WHERE Type = 'BELIEF_MOSQUES';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_PAGODAS', ShortDescription = 'TXT_KEY_BELIEF_F0S_PAGODAS_SHORT'
WHERE Type = 'BELIEF_PAGODAS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_MONASTERIES', ShortDescription = 'TXT_KEY_BELIEF_F0S_MONASTERIES_SHORT'
WHERE Type = 'BELIEF_MONASTERIES';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_PEACE_GARDENS', ShortDescription = 'TXT_KEY_BELIEF_F0S_PEACE_GARDENS_SHORT'
WHERE Type = 'BELIEF_PEACE_GARDENS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_CHORAL_MUSIC', ShortDescription = 'TXT_KEY_BELIEF_F0S_CHORAL_MUSIC_SHORT', MinFollowers = 0
WHERE Type = 'BELIEF_CHORAL_MUSIC';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_ART', ShortDescription = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_ART_SHORT'
WHERE Type = 'BELIEF_RELIGIOUS_ART';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_LITURGICAL_DRAMA', ShortDescription = 'TXT_KEY_BELIEF_F0S_LITURGICAL_DRAMA_SHORT', MinFollowers = 0
WHERE Type = 'BELIEF_LITURGICAL_DRAMA';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_ASCETISM', ShortDescription = 'TXT_KEY_BELIEF_F0S_ASCETISM_SHORT', MinFollowers = 0
WHERE Type = 'BELIEF_ASCETISM';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_CENTER', ShortDescription = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_CENTER_SHORT', MinFollowers = 0
WHERE Type = 'BELIEF_RELIGIOUS_CENTER';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_COMMUNITY', ShortDescription = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_COMMUNITY_SHORT'
WHERE Type = 'BELIEF_RELIGIOUS_COMMUNITY';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_DIVINE_INSPIRATION', ShortDescription = 'TXT_KEY_BELIEF_F0S_DIVINE_INSPIRATION_SHORT'
WHERE Type = 'BELIEF_DIVINE_INSPIRATION';

INSERT INTO Beliefs 
		(Type, 								Description, 								ShortDescription, 								Follower)
VALUES	('BELIEF_F0S_SIGNS_HEAVEN', 		'TXT_KEY_BELIEF_F0S_SIGNS_HEAVEN', 			'TXT_KEY_BELIEF_F0S_SIGNS_HEAVEN_SHORT',		1),
		('BELIEF_F0S_SPIRITUAL_EXCHANGE', 	'TXT_KEY_BELIEF_F0S_SPIRITUAL_EXCHANGE', 	'TXT_KEY_BELIEF_F0S_SPIRITUAL_EXCHANGE_SHORT',	1),
		('BELIEF_F0S_SYNAGOGUES', 			'TXT_KEY_BELIEF_F0S_SYNAGOGUES', 			'TXT_KEY_BELIEF_F0S_SYNAGOGUES_SHORT',			1),
		('BELIEF_F0S_WORK_ETHIC', 			'TXT_KEY_BELIEF_F0S_WORK_ETHIC', 			'TXT_KEY_BELIEF_F0S_WORK_ETHIC_SHORT',			1);
----------------------
-- Enhancer
----------------------
UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_TEXTS', ShortDescription = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_TEXTS_SHORT'
WHERE Type = 'BELIEF_RELIGIOUS_TEXTS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_RELIQUARY', ShortDescription = 'TXT_KEY_BELIEF_F0S_RELIQUARY_SHORT', GreatPersonExpendedFaith = 100
WHERE Type = 'BELIEF_RELIQUARY';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_JUST_WAR', ShortDescription = 'TXT_KEY_BELIEF_F0S_JUST_WAR_SHORT', CombatModifierEnemyCities = 25
WHERE Type = 'BELIEF_JUST_WAR';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_DEFENDER_FAITH', ShortDescription = 'TXT_KEY_BELIEF_F0S_DEFENDER_FAITH_SHORT', CombatModifierFriendlyCities = 25
WHERE Type = 'BELIEF_DEFENDER_FAITH';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_ITINERANT_PREACHERS', ShortDescription = 'TXT_KEY_BELIEF_F0S_ITINERANT_PREACHERS_SHORT', SpreadDistanceModifier = 50
WHERE Type = 'BELIEF_ITINERANT_PREACHERS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_MESSIAH', ShortDescription = 'TXT_KEY_BELIEF_F0S_MESSIAH_SHORT'
WHERE Type = 'BELIEF_MESSIAH';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_MISSIONARY_ZEAL', ShortDescription = 'TXT_KEY_BELIEF_F0S_MISSIONARY_ZEAL_SHORT', MissionaryStrengthModifier = 0
WHERE Type = 'BELIEF_MISSIONARY_ZEAL';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_HOLY_ORDER', ShortDescription = 'TXT_KEY_BELIEF_F0S_HOLY_ORDER_SHORT', MissionaryCostModifier = 0
WHERE Type = 'BELIEF_HOLY_ORDER';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_UNITY', ShortDescription = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_UNITY_SHORT'
WHERE Type = 'BELIEF_RELIGIOUS_UNITY';

INSERT INTO Beliefs 
		(Type, 								Description, 								ShortDescription, 									SpyPressure,	Enhancer)
VALUES	('BELIEF_F0S_UNDERGROUND_SECT', 	'TXT_KEY_BELIEF_F0S_UNDERGROUND_SECT_NEW', 	'TXT_KEY_BELIEF_F0S_UNDERGROUND_SECT_NEW_SHORT',	5,				1);
----------------------
-- Reformation
----------------------
UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_CHARITABLE_MISSIONS', ShortDescription = 'TXT_KEY_BELIEF_F0S_CHARITABLE_MISSIONS_SHORT', CityStateInfluenceModifier = 0
WHERE Type = 'BELIEF_CHARITABLE_MISSIONS';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_EVANGELISM', ShortDescription = 'TXT_KEY_BELIEF_F0S_EVANGELISM_SHORT', OtherReligionPressureErosion = 0, CityGrowthModifier = 10
WHERE Type = 'BELIEF_EVANGELISM';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_HEATHEN_CONVERSION', ShortDescription = 'TXT_KEY_BELIEF_F0S_HEATHEN_CONVERSION_SHORT'
WHERE Type = 'BELIEF_HEATHEN_CONVERSION';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_JESUIT_EDUCATION', ShortDescription = 'TXT_KEY_BELIEF_F0S_JESUIT_EDUCATION_SHORT'
WHERE Type = 'BELIEF_JESUIT_EDUCATION';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_FERVOR', ShortDescription = 'TXT_KEY_BELIEF_F0S_RELIGIOUS_FERVOR_SHORT'
WHERE Type = 'BELIEF_RELIGIOUS_FERVOR';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_SACRED_SITES', ShortDescription = 'TXT_KEY_BELIEF_F0S_SACRED_SITES_SHORT'
WHERE Type = 'BELIEF_SACRED_SITES';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_TO_GLORY_OF_GOD', ShortDescription = 'TXT_KEY_BELIEF_F0S_TO_GLORY_OF_GOD_SHORT'
WHERE Type = 'BELIEF_TO_GLORY_OF_GOD';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_UNDERGROUND_SECT', ShortDescription = 'TXT_KEY_BELIEF_F0S_UNDERGROUND_SECT_SHORT', SpyPressure = 0
WHERE Type = 'BELIEF_UNDERGROUND_SECT';

UPDATE Beliefs
SET Description = 'TXT_KEY_BELIEF_F0S_UNITY_OF_PROPHETS', ShortDescription = 'TXT_KEY_BELIEF_F0S_UNITY_OF_PROPHETS_SHORT', OtherReligionPressureErosion = 50
WHERE Type = 'BELIEF_UNITY_OF_PROPHETS';

INSERT INTO Beliefs 
		(Type, 								Description, 								ShortDescription, 								Reformation)
VALUES	('BELIEF_F0S_HOLY_RELICS', 			'TXT_KEY_BELIEF_F0S_HOLY_RELICS', 			'TXT_KEY_BELIEF_F0S_HOLY_RELICS_SHORT',			1);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_BuildingClassYieldChanges
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_BuildingClassYieldChanges;

INSERT INTO Belief_BuildingClassYieldChanges 
		(BeliefType, 						BuildingClassType, 					YieldType, 				YieldChange)
VALUES	('BELIEF_ANCESTOR_WORSHIP', 		'BUILDINGCLASS_SHRINE', 			'YIELD_CULTURE',		1),
		('BELIEF_GOD_KING', 				'BUILDINGCLASS_PALACE', 			'YIELD_FOOD',			1),
		('BELIEF_GOD_KING', 				'BUILDINGCLASS_PALACE', 			'YIELD_PRODUCTION',		1),
		('BELIEF_GOD_KING', 				'BUILDINGCLASS_PALACE', 			'YIELD_CULTURE',		1),
		('BELIEF_GOD_KING', 				'BUILDINGCLASS_PALACE', 			'YIELD_FAITH',			1),
		('BELIEF_GOD_KING', 				'BUILDINGCLASS_PALACE', 			'YIELD_GOLD',			1),
		('BELIEF_GOD_KING', 				'BUILDINGCLASS_PALACE', 			'YIELD_SCIENCE',		1),
		('BELIEF_FEED_WORLD', 				'BUILDINGCLASS_SHRINE', 			'YIELD_FOOD',			1),
		('BELIEF_FEED_WORLD', 				'BUILDINGCLASS_TEMPLE', 			'YIELD_FOOD',			2),
		('BELIEF_HOLY_WARRIORS', 			'BUILDINGCLASS_BARRACKS', 			'YIELD_FAITH',			1),
		('BELIEF_HOLY_WARRIORS', 			'BUILDINGCLASS_ARMORY', 			'YIELD_FAITH',			1),
		('BELIEF_HOLY_WARRIORS', 			'BUILDINGCLASS_MILITARY_ACADEMY', 	'YIELD_FAITH',			1),
		('BELIEF_PEACE_GARDENS', 			'BUILDINGCLASS_GARDEN', 			'YIELD_FOOD',			2),
		('BELIEF_RELIGIOUS_ART', 			'BUILDINGCLASS_TEMPLE', 			'YIELD_CULTURE',		2),
		('BELIEF_LITURGICAL_DRAMA', 		'BUILDINGCLASS_AMPHITHEATER', 		'YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_PALACE', 			'YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_HEROIC_EPIC', 		'YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_NATIONAL_COLLEGE', 	'YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_NATIONAL_EPIC', 		'YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_CIRCUS_MAXIMUS', 	'YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_NATIONAL_TREASURY', 	'YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_IRONWORKS', 			'YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_OXFORD_UNIVERSITY', 	'YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_HERMITAGE', 			'YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_TOURIST_CENTER', 	'YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_INTELLIGENCE_AGENCY','YIELD_FAITH',			2),
		('BELIEF_DIVINE_INSPIRATION', 		'BUILDINGCLASS_GRAND_TEMPLE', 		'YIELD_FAITH',			2);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_BuildingClassHappiness
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_BuildingClassHappiness;

INSERT INTO Belief_BuildingClassHappiness 
		(BeliefType, 						BuildingClassType, 				Happiness)
VALUES	('BELIEF_ANCESTOR_WORSHIP', 		'BUILDINGCLASS_SHRINE', 		1),
		('BELIEF_PEACE_GARDENS', 			'BUILDINGCLASS_GARDEN', 		2),
		('BELIEF_CHORAL_MUSIC', 			'BUILDINGCLASS_OPERA_HOUSE', 	2);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_BuildingClassTourism
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_BuildingClassTourism;

INSERT INTO Belief_BuildingClassTourism 
		(BeliefType, 					BuildingClassType,			Tourism)
VALUES	('BELIEF_SACRED_SITES', 		'BUILDINGCLASS_MONASTERY',	2);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_BuildingClassFaithPurchase
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_BuildingClassFaithPurchase;

INSERT INTO Belief_BuildingClassFaithPurchase 
		(BeliefType, 					BuildingClassType)
VALUES	('BELIEF_CATHEDRALS', 			'BUILDINGCLASS_CATHEDRAL'),
		('BELIEF_MOSQUES', 				'BUILDINGCLASS_MOSQUE'),
		('BELIEF_PAGODAS', 				'BUILDINGCLASS_PAGODA'),
		('BELIEF_ASCETISM', 			'BUILDINGCLASS_F0S_ALTAR'),
		('BELIEF_RELIGIOUS_CENTER', 	'BUILDINGCLASS_F0S_CHURCH'),
		('BELIEF_F0S_SYNAGOGUES', 		'BUILDINGCLASS_F0S_SYNAGOGUE'),
		('BELIEF_JESUIT_EDUCATION', 	'BUILDINGCLASS_LIBRARY'),
		('BELIEF_JESUIT_EDUCATION', 	'BUILDINGCLASS_UNIVERSITY'),
		('BELIEF_JESUIT_EDUCATION', 	'BUILDINGCLASS_OBSERVATORY'),
		('BELIEF_JESUIT_EDUCATION', 	'BUILDINGCLASS_PUBLIC_SCHOOL'),
		('BELIEF_JESUIT_EDUCATION', 	'BUILDINGCLASS_LABORATORY');
--------------------------------------------------------------------------------------------------------------------------
-- Belief_CityYieldChanges
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_CityYieldChanges;

INSERT INTO Belief_CityYieldChanges 
		(BeliefType, 					YieldType, 				Yield)
VALUES	('BELIEF_GOD_CRAFTSMEN', 		'YIELD_PRODUCTION', 	1),
		('BELIEF_EVANGELISM', 			'YIELD_FOOD', 			2);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_EraFaithUnitPurchase
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_EraFaithUnitPurchase;

INSERT INTO Belief_EraFaithUnitPurchase 
		(BeliefType, 					EraType)
VALUES	('BELIEF_RELIGIOUS_FERVOR', 	'ERA_ANCIENT'),
		('BELIEF_RELIGIOUS_FERVOR', 	'ERA_CLASSICAL'),
		('BELIEF_RELIGIOUS_FERVOR', 	'ERA_MEDIEVAL'),
		('BELIEF_RELIGIOUS_FERVOR', 	'ERA_RENAISSANCE'),
		('BELIEF_RELIGIOUS_FERVOR', 	'ERA_INDUSTRIAL'),
		('BELIEF_RELIGIOUS_FERVOR', 	'ERA_MODERN'),
		('BELIEF_RELIGIOUS_FERVOR', 	'ERA_POSTMODERN'),
		('BELIEF_RELIGIOUS_FERVOR', 	'ERA_FUTURE');
--------------------------------------------------------------------------------------------------------------------------
-- Belief_FeatureYieldChanges
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_FeatureYieldChanges;

INSERT INTO Belief_FeatureYieldChanges 
		(BeliefType, 						FeatureType, 			YieldType,				Yield)
VALUES	('BELIEF_RELIGIOUS_SETTLEMENTS', 	'FEATURE_OASIS', 		'YIELD_FOOD',			1),
		('BELIEF_RELIGIOUS_SETTLEMENTS', 	'FEATURE_OASIS', 		'YIELD_CULTURE',		1),
		('BELIEF_DESERT_FOLKLORE', 			'FEATURE_FLOOD_PLAINS', 'YIELD_FAITH',			-1),
		('BELIEF_SACRED_PATH', 				'FEATURE_JUNGLE', 		'YIELD_CULTURE',		1),
		('BELIEF_F0S_SACRED_GROVES', 		'FEATURE_FOREST', 		'YIELD_CULTURE',		1),
		('BELIEF_GODDESS_STRATEGY', 		'FEATURE_ATOLL', 		'YIELD_PRODUCTION',		1),
		('BELIEF_GODDESS_STRATEGY', 		'FEATURE_ATOLL', 		'YIELD_CULTURE',		1);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_YieldChangePerForeignCity
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_YieldChangePerForeignCity;

INSERT INTO Belief_YieldChangePerForeignCity 
		(BeliefType, 					YieldType, 			Yield)
VALUES	('BELIEF_INITIATION_RITES', 	'YIELD_GOLD', 		2);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_YieldChangePerXForeignFollowers
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_YieldChangePerXForeignFollowers;

INSERT INTO Belief_YieldChangePerXForeignFollowers 
		(BeliefType, 					YieldType, 			ForeignFollowers)
VALUES	('BELIEF_WORLD_CHURCH', 		'YIELD_CULTURE', 	4),
		('BELIEF_WORLD_CHURCH', 		'YIELD_FAITH', 		4),
		('BELIEF_INTERFAITH_DIALOGUE', 	'YIELD_SCIENCE', 	4);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_ImprovementYieldChanges
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_ImprovementYieldChanges;

INSERT INTO Belief_ImprovementYieldChanges 
		(BeliefType, 					ImprovementType, 				YieldType,				Yield)
VALUES	('BELIEF_GODDESS_HUNT', 		'IMPROVEMENT_CAMP', 			'YIELD_FOOD',			1),
		('BELIEF_GOD_SEA', 				'IMPROVEMENT_FISHING_BOATS', 	'YIELD_FAITH',			1),
		('BELIEF_ORAL_TRADITION', 		'IMPROVEMENT_PLANTATION', 		'YIELD_CULTURE',		1),
		('BELIEF_ORAL_TRADITION', 		'IMPROVEMENT_PLANTATION', 		'YIELD_GOLD',			1),
		('BELIEF_F0S_WORK_ETHIC', 		'IMPROVEMENT_HOLY_SITE', 		'YIELD_PRODUCTION',		2),
		('BELIEF_F0S_WORK_ETHIC', 		'IMPROVEMENT_MISSION', 			'YIELD_PRODUCTION',		1),
		('BELIEF_STONE_CIRCLES', 		'IMPROVEMENT_QUARRY', 			'YIELD_PRODUCTION',		1),
		('BELIEF_STONE_CIRCLES', 		'IMPROVEMENT_QUARRY', 			'YIELD_FAITH',			1);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_MaxYieldModifierPerFollower
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_MaxYieldModifierPerFollower;

INSERT INTO Belief_MaxYieldModifierPerFollower 
		(BeliefType, 					YieldType, 				Max)
VALUES	('BELIEF_RELIGIOUS_COMMUNITY', 	'YIELD_PRODUCTION', 	15),
		('BELIEF_MONASTERIES', 			'YIELD_GOLD', 			15),
		('BELIEF_SWORD_PLOWSHARES', 	'YIELD_SCIENCE', 		15);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_ResourceYieldChanges
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_ResourceYieldChanges;

INSERT INTO Belief_ResourceYieldChanges 
		(BeliefType, 					ResourceType, 				YieldType,				Yield)
VALUES	('BELIEF_FERTILITY_RITES', 		'RESOURCE_WHEAT', 			'YIELD_FOOD',			1),
		('BELIEF_GOD_CRAFTSMEN', 		'RESOURCE_IRON', 			'YIELD_PRODUCTION',		1),
		('BELIEF_OPEN_SKY', 			'RESOURCE_COW', 			'YIELD_CULTURE',		1),
		('BELIEF_OPEN_SKY', 			'RESOURCE_SHEEP', 			'YIELD_CULTURE',		1),
		('BELIEF_MESSENGER_GODS', 		'RESOURCE_FISH', 			'YIELD_GOLD',			3),
		('BELIEF_MESSENGER_GODS', 		'RESOURCE_WHALE', 			'YIELD_GOLD',			3),
		('BELIEF_MESSENGER_GODS', 		'RESOURCE_CRAB', 			'YIELD_GOLD',			3),
		('BELIEF_MESSENGER_GODS', 		'RESOURCE_MC_ORCA', 		'YIELD_GOLD',			3),
		('BELIEF_MESSENGER_GODS', 		'RESOURCE_MC_SALMON', 		'YIELD_GOLD',			3),
		('BELIEF_FORMAL_LITURGY', 		'RESOURCE_GOLD', 			'YIELD_CULTURE',		1),
		('BELIEF_FORMAL_LITURGY', 		'RESOURCE_GOLD', 			'YIELD_FAITH',			1),
		('BELIEF_FORMAL_LITURGY', 		'RESOURCE_SILVER', 			'YIELD_CULTURE',		1),
		('BELIEF_FORMAL_LITURGY', 		'RESOURCE_SILVER', 			'YIELD_FAITH',			1),
		('BELIEF_FORMAL_LITURGY', 		'RESOURCE_COPPER', 			'YIELD_CULTURE',		1),
		('BELIEF_FORMAL_LITURGY', 		'RESOURCE_COPPER', 			'YIELD_FAITH',			1),
		('BELIEF_GODDESS_LOVE', 		'RESOURCE_DYE', 			'YIELD_GOLD',			1),
		('BELIEF_GODDESS_LOVE', 		'RESOURCE_SILK', 			'YIELD_GOLD',			1),
		('BELIEF_GODDESS_LOVE', 		'RESOURCE_COTTON', 			'YIELD_GOLD',			1),
		('BELIEF_GODDESS_LOVE', 		'RESOURCE_JFD_SAFFRON', 	'YIELD_GOLD',			1),
		('BELIEF_GODDESS_LOVE', 		'RESOURCE_DYE', 			'YIELD_FAITH',			1),
		('BELIEF_GODDESS_LOVE', 		'RESOURCE_SILK', 			'YIELD_FAITH',			1),
		('BELIEF_GODDESS_LOVE', 		'RESOURCE_COTTON', 			'YIELD_FAITH',			1),
		('BELIEF_GODDESS_LOVE', 		'RESOURCE_JFD_SAFFRON', 	'YIELD_FAITH',			1),
		('BELIEF_GOD_FESTIVALS', 		'RESOURCE_WINE', 			'YIELD_CULTURE',		2),
		('BELIEF_GOD_FESTIVALS', 		'RESOURCE_PERFUME', 		'YIELD_CULTURE',		2),
		('BELIEF_GOD_FESTIVALS', 		'RESOURCE_TOBACCO', 		'YIELD_CULTURE',		2),
		('BELIEF_SACRED_PATH', 			'RESOURCE_JFD_LOTUS', 		'YIELD_FAITH',			1),
		('BELIEF_SACRED_PATH', 			'RESOURCE_JFD_FEATHERS', 	'YIELD_FAITH',			1),
		('BELIEF_GODDESS_STRATEGY', 	'RESOURCE_PEARLS', 			'YIELD_PRODUCTION',		1),
		('BELIEF_GODDESS_STRATEGY', 	'RESOURCE_PEARLS', 			'YIELD_CULTURE',		1),
		('BELIEF_GODDESS_STRATEGY', 	'RESOURCE_CORAL', 			'YIELD_PRODUCTION',		1),
		('BELIEF_GODDESS_STRATEGY', 	'RESOURCE_CORAL', 			'YIELD_CULTURE',		1),
		('BELIEF_GODDESS_STRATEGY', 	'RESOURCE_JFD_SHELLFISH', 	'YIELD_PRODUCTION',		1),
		('BELIEF_GODDESS_STRATEGY', 	'RESOURCE_JFD_SHELLFISH', 	'YIELD_CULTURE',		1),
		('BELIEF_FAITH_HEALERS', 		'RESOURCE_SUGAR', 			'YIELD_CULTURE',		1),
		('BELIEF_FAITH_HEALERS', 		'RESOURCE_SUGAR', 			'YIELD_FAITH',			1),
		('BELIEF_FAITH_HEALERS', 		'RESOURCE_INCENSE', 		'YIELD_CULTURE',		1),
		('BELIEF_FAITH_HEALERS', 		'RESOURCE_INCENSE', 		'YIELD_FAITH',			1),
		('BELIEF_FAITH_HEALERS', 		'RESOURCE_SALT', 			'YIELD_CULTURE',		1),
		('BELIEF_FAITH_HEALERS', 		'RESOURCE_SALT', 			'YIELD_FAITH',			1),
		('BELIEF_TEARS_OF_GODS', 		'RESOURCE_GEMS', 			'YIELD_FAITH',			2),
		('BELIEF_TEARS_OF_GODS', 		'RESOURCE_AMBER', 			'YIELD_FAITH',			2),
		('BELIEF_TEARS_OF_GODS', 		'RESOURCE_LAPIS', 			'YIELD_FAITH',			2),
		('BELIEF_EARTH_MOTHER', 		'RESOURCE_TRUFFLES', 		'YIELD_FOOD',			1),
		('BELIEF_EARTH_MOTHER', 		'RESOURCE_TEA', 			'YIELD_FOOD',			1),
		('BELIEF_EARTH_MOTHER', 		'RESOURCE_COFFEE', 			'YIELD_FOOD',			1),
		('BELIEF_EARTH_MOTHER', 		'RESOURCE_OLIVE', 			'YIELD_FOOD',			1),
		('BELIEF_SUN_GOD', 				'RESOURCE_BANANA', 			'YIELD_FOOD',			1),
		('BELIEF_SUN_GOD', 				'RESOURCE_CITRUS', 			'YIELD_FOOD',			1),
		('BELIEF_SUN_GOD', 				'RESOURCE_COCOA', 			'YIELD_FOOD',			1),
		('BELIEF_SUN_GOD', 				'RESOURCE_JFD_VANILLA', 	'YIELD_FOOD',			1),
		('BELIEF_F0S_RITUAL_SACRIFICES','RESOURCE_IVORY', 			'YIELD_FAITH',			2),
		('BELIEF_F0S_RITUAL_SACRIFICES','RESOURCE_JADE', 			'YIELD_FAITH',			2),
		('BELIEF_F0S_RITUAL_SACRIFICES','RESOURCE_JFD_OBSIDIAN', 	'YIELD_FAITH',			2),
		('BELIEF_F0S_SACRED_GROVES', 	'RESOURCE_JFD_CEDAR', 		'YIELD_FAITH',			1),
		('BELIEF_F0S_SACRED_GROVES', 	'RESOURCE_JFD_OAK', 		'YIELD_FAITH',			1),
		('BELIEF_F0S_SACRED_MEDICINES', 'RESOURCE_SPICES', 			'YIELD_FOOD',			1),
		('BELIEF_F0S_SACRED_MEDICINES', 'RESOURCE_SPICES', 			'YIELD_FAITH',			1),
		('BELIEF_F0S_SACRED_MEDICINES', 'RESOURCE_JFD_GINGER', 		'YIELD_FOOD',			1),
		('BELIEF_F0S_SACRED_MEDICINES', 'RESOURCE_JFD_GINGER', 		'YIELD_FAITH',			1),
		('BELIEF_F0S_SACRED_MEDICINES', 'RESOURCE_JFD_OPIUM', 		'YIELD_FOOD',			1),
		('BELIEF_F0S_SACRED_MEDICINES', 'RESOURCE_JFD_OPIUM', 		'YIELD_FAITH',			1),
		('BELIEF_F0S_SPIRIT_ANIMALS', 	'RESOURCE_HORSE', 			'YIELD_FAITH',			1),
		('BELIEF_F0S_SPIRIT_ANIMALS', 	'RESOURCE_DEER', 			'YIELD_FAITH',			1),
		('BELIEF_F0S_SPIRIT_ANIMALS', 	'RESOURCE_FUR', 			'YIELD_FAITH',			1),
		('BELIEF_F0S_SPIRIT_ANIMALS', 	'RESOURCE_BISON', 			'YIELD_FAITH',			1),
		('BELIEF_F0S_SPIRIT_ANIMALS', 	'RESOURCE_BISON_MOD', 		'YIELD_FAITH',			1);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_TerrainYieldChanges
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_TerrainYieldChanges;

INSERT INTO Belief_TerrainYieldChanges 
		(BeliefType, 					TerrainType,			YieldType, 			Yield)
VALUES	('BELIEF_DESERT_FOLKLORE', 		'TERRAIN_DESERT',		'YIELD_FAITH', 		1),
		('BELIEF_DANCE_AURORA', 		'TERRAIN_TUNDRA',		'YIELD_FAITH', 		1),
		('BELIEF_DANCE_AURORA', 		'TERRAIN_SNOW',			'YIELD_FAITH', 		1);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_YieldChangeAnySpecialist
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_YieldChangeAnySpecialist;
--------------------------------------------------------------------------------------------------------------------------
-- Belief_YieldChangeTradeRoute
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_YieldChangeTradeRoute;

INSERT INTO Belief_YieldChangeTradeRoute 
		(BeliefType, 						YieldType, 			Yield)
VALUES	('BELIEF_F0S_SPIRITUAL_EXCHANGE', 	'YIELD_SCIENCE', 	3),
		('BELIEF_F0S_SPIRITUAL_EXCHANGE', 	'YIELD_FAITH', 		3);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_YieldChangeNaturalWonder
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_YieldChangeNaturalWonder;

INSERT INTO Belief_YieldChangeNaturalWonder 
		(BeliefType, 					YieldType, 			Yield)
VALUES	('BELIEF_ONE_WITH_NATURE', 		'YIELD_FAITH', 		5);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_YieldChangeWorldWonder
--------------------------------------------------------------------------------------------------------------------------
DELETE FROM Belief_YieldChangeWorldWonder;

INSERT INTO Belief_YieldChangeWorldWonder 
		(BeliefType, 					YieldType, 			Yield)
VALUES	('BELIEF_DIVINE_INSPIRATION', 	'YIELD_FAITH', 		2);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_SpecialistYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Belief_SpecialistYieldChanges 
		(BeliefType, 			SpecialistType,							YieldType, 				Yield)
VALUES	('BELIEF_GURUSHIP', 	'SPECIALIST_WRITER',					'YIELD_CULTURE', 		1),
		('BELIEF_GURUSHIP', 	'SPECIALIST_ARTIST',					'YIELD_CULTURE', 		1),
		('BELIEF_GURUSHIP', 	'SPECIALIST_MUSICIAN',					'YIELD_CULTURE', 		1),
		('BELIEF_GURUSHIP', 	'SPECIALIST_SCIENTIST',					'YIELD_SCIENCE', 		1),
		('BELIEF_GURUSHIP', 	'SPECIALIST_MERCHANT',					'YIELD_GOLD', 			1),
		('BELIEF_GURUSHIP', 	'SPECIALIST_ENGINEER',					'YIELD_PRODUCTION', 	1),
		('BELIEF_GURUSHIP', 	'SPECIALIST_JFD_PRUSSIAN_GENERAL',		'YIELD_FOOD', 			1),
		('BELIEF_GURUSHIP', 	'SPECIALIST_JFD_DENMARK_GENERAL',		'YIELD_FOOD', 			1);
--------------------------------------------------------------------------------------------------------------------------
-- Belief_PlotYieldChanges
--------------------------------------------------------------------------------------------------------------------------
INSERT INTO Belief_PlotYieldChanges 
		(BeliefType, 					PlotType,			YieldType, 			Yield)
VALUES	('BELIEF_F0S_SIGNS_HEAVEN', 	'PLOT_MOUNTAIN',	'YIELD_FOOD',	 	2),
		('BELIEF_F0S_SIGNS_HEAVEN', 	'PLOT_MOUNTAIN',	'YIELD_FAITH', 		2);
--==========================================================================================================================
--==========================================================================================================================