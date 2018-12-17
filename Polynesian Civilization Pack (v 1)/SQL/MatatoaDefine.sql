-- Insert SQL Rules Here 
INSERT INTO ArtDefine_UnitInfos
		(Type,									DamageStates,	Formation)
SELECT	('ART_DEF_UNIT_MC_RAPA_NUI_MATATOA'),	DamageStates,	Formation
FROM ArtDefine_UnitInfos WHERE Type = 'ART_DEF_UNIT_U_MAYAN_ATLALIST';

INSERT INTO ArtDefine_UnitInfoMemberInfos
		(UnitInfoType,							UnitMemberInfoType,								NumMembers)
SELECT	('ART_DEF_UNIT_MC_RAPA_NUI_MATATOA'),	('ART_DEF_UNIT_MEMBER_MC_RAPA_NUI_MATATOA'),	NumMembers
FROM ArtDefine_UnitInfoMemberInfos WHERE UnitInfoType = 'ART_DEF_UNIT_U_MAYAN_ATLALIST';

INSERT INTO ArtDefine_UnitMemberCombats
		(UnitMemberType,								EnableActions,	DisableActions,	MoveRadius,	ShortMoveRadius,	ChargeRadius,	AttackRadius,	RangedAttackRadius,	MoveRate,	ShortMoveRate,	TurnRateMin,	TurnRateMax,	TurnFacingRateMin,	TurnFacingRateMax,	RollRateMin,	RollRateMax,	PitchRateMin,	PitchRateMax,	LOSRadiusScale,	TargetRadius,	TargetHeight,	HasShortRangedAttack,	HasLongRangedAttack,	HasLeftRightAttack,	HasStationaryMelee,	HasStationaryRangedAttack,	HasRefaceAfterCombat,	ReformBeforeCombat,	HasIndependentWeaponFacing,	HasOpponentTracking,	HasCollisionAttack,	AttackAltitude,	AltitudeDecelerationDistance,	OnlyTurnInMovementActions,	RushAttackFormation)
SELECT	('ART_DEF_UNIT_MEMBER_MC_RAPA_NUI_MATATOA'),	EnableActions,	DisableActions,	MoveRadius,	ShortMoveRadius,	ChargeRadius,	AttackRadius,	RangedAttackRadius,	MoveRate,	ShortMoveRate,	TurnRateMin,	TurnRateMax,	TurnFacingRateMin,	TurnFacingRateMax,	RollRateMin,	RollRateMax,	PitchRateMin,	PitchRateMax,	LOSRadiusScale,	TargetRadius,	TargetHeight,	HasShortRangedAttack,	HasLongRangedAttack,	HasLeftRightAttack,	HasStationaryMelee,	HasStationaryRangedAttack,	HasRefaceAfterCombat,	ReformBeforeCombat,	HasIndependentWeaponFacing,	HasOpponentTracking,	HasCollisionAttack,	AttackAltitude,	AltitudeDecelerationDistance,	OnlyTurnInMovementActions,	RushAttackFormation
FROM ArtDefine_UnitMemberCombats WHERE UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_MAYAN_ATLALIST';

INSERT INTO ArtDefine_UnitMemberCombatWeapons
		(UnitMemberType,								"Index",	SubIndex,	ID,	VisKillStrengthMin,	VisKillStrengthMax,	ProjectileSpeed,	ProjectileTurnRateMin,	ProjectileTurnRateMax,	HitEffect,	HitEffectScale,	HitRadius,	ProjectileChildEffectScale,	AreaDamageDelay,	ContinuousFire,	WaitForEffectCompletion,	TargetGround,	IsDropped,	WeaponTypeTag,	WeaponTypeSoundOverrideTag)
SELECT 	('ART_DEF_UNIT_MEMBER_MC_RAPA_NUI_MATATOA'),	"Index",	SubIndex,	ID,	VisKillStrengthMin,	VisKillStrengthMax,	ProjectileSpeed,	ProjectileTurnRateMin,	ProjectileTurnRateMax,	HitEffect,	HitEffectScale,	HitRadius,	ProjectileChildEffectScale,	AreaDamageDelay,	ContinuousFire,	WaitForEffectCompletion,	TargetGround,	IsDropped,	WeaponTypeTag,	WeaponTypeSoundOverrideTag
FROM ArtDefine_UnitMemberCombatWeapons	WHERE (UnitMemberType = 'ART_DEF_UNIT_MEMBER_U_MAYAN_ATLALIST');

INSERT INTO ArtDefine_UnitMemberInfos
		(Type,											Scale,	ZOffset,	Domain,		Model,					MaterialTypeTag,	 MaterialTypeSoundOverrideTag)
SELECT	('ART_DEF_UNIT_MEMBER_MC_RAPA_NUI_MATATOA'),	Scale,	ZOffset,	Domain,		('matatoa.fxsxml'),		MaterialTypeTag,	 MaterialTypeSoundOverrideTag
FROM ArtDefine_UnitMemberInfos WHERE Type = 'ART_DEF_UNIT_MEMBER_U_MAYAN_ATLALIST';