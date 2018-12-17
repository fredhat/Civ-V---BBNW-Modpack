--==========================================================================================================================
-- Features
--==========================================================================================================================
UPDATE Features
SET AddsFreshWater = 1, SeeThrough = 0
WHERE Type = 'FEATURE_LAKE_VICTORIA';

UPDATE Features
SET FirstFinderGold = 300
WHERE Type = 'FEATURE_EL_DORADO';

UPDATE Features
SET InBorderHappiness = 2
WHERE Type = 'FEATURE_GEYSER';
--==========================================================================================================================
-- Feature_YieldChanges
--==========================================================================================================================
DELETE FROM Feature_YieldChanges WHERE FeatureType = 'FEATURE_REEF' AND YieldType = 'YIELD_PRODUCTION';

INSERT INTO Feature_YieldChanges 	
			(FeatureType, 			YieldType,		Yield)
VALUES		('FEATURE_EL_DORADO',	'YIELD_GOLD',	4),
			('FEATURE_FUJI',		'YIELD_FOOD',	2);

UPDATE Feature_YieldChanges
SET Yield = 8
WHERE FeatureType = 'FEATURE_GEYSER';

UPDATE Feature_YieldChanges
SET Yield = 4
WHERE FeatureType = 'FEATURE_EL_DORADO';

UPDATE Feature_YieldChanges
SET Yield = 12
WHERE FeatureType = 'FEATURE_VOLCANO';

UPDATE Feature_YieldChanges
SET Yield = 4
WHERE FeatureType = 'FEATURE_MESA';

UPDATE Feature_YieldChanges
SET Yield = 5
WHERE FeatureType = 'FEATURE_CRATER';

UPDATE Feature_YieldChanges
SET Yield = 4
WHERE FeatureType = 'FEATURE_KILIMANJARO';

UPDATE Feature_YieldChanges
SET Yield = 3
WHERE FeatureType = 'FEATURE_GIBRALTAR' AND YieldType = 'YIELD_FOOD';

UPDATE Feature_YieldChanges
SET Yield = 3
WHERE FeatureType = 'FEATURE_FUJI' AND YieldType = 'YIELD_GOLD';

UPDATE Feature_YieldChanges
SET Yield = 3
WHERE FeatureType = 'FEATURE_REEF' AND YieldType = 'YIELD_GOLD';

UPDATE Feature_YieldChanges
SET Yield = 3
WHERE FeatureType = 'FEATURE_REEF' AND YieldType = 'YIELD_SCIENCE';
--==========================================================================================================================
-- Natural_Wonder_Placement
--==========================================================================================================================
UPDATE Natural_Wonder_Placement
SET ChangeCoreTileToMountain = 0
WHERE NaturalWonderType = 'FEATURE_CRATER';

UPDATE Natural_Wonder_Placement
SET ChangeCoreTileToMountain = 0
WHERE NaturalWonderType = 'FEATURE_GEYSER';

UPDATE Natural_Wonder_Placement
SET RequiredNumberOfAdjacentShallowWater = 3
WHERE NaturalWonderType = 'FEATURE_VOLCANO';
--==========================================================================================================================
--==========================================================================================================================