--======Mvemba(Old Kongo Leader)======--

--5.1 Founder Belief Bug Fix
INSERT INTO Requirements(RequirementId, RequirementType) VALUES
	('BBG_REQUIRES_PLAYER_IS_RELIGIOUS_CONVERT', 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES'),
	('BBG_REQUIRES_PLAYER_FOUNDED_RELIGION_OR_MVEMBA', 'REQUIREMENT_REQUIREMENTSET_IS_MET');

INSERT INTO RequirementSets(RequirementSetId, RequirementSetType) VALUES
	('BBG_REQSET_FOUNDER_OR_MVEMBA', 'REQUIREMENTSET_TEST_ANY');

INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
	('BBG_REQSET_FOUNDER_OR_MVEMBA', 'REQUIRES_PLAYER_FOUNDED_RELIGION'),
	('BBG_REQSET_FOUNDER_OR_MVEMBA', 'BBG_REQUIRES_PLAYER_IS_RELIGIOUS_CONVERT');

INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
	('BBG_REQUIRES_PLAYER_IS_RELIGIOUS_CONVERT', 'LeaderType', 'LEADER_MVEMBA'),
	('BBG_REQUIRES_PLAYER_FOUNDED_RELIGION_OR_MVEMBA', 'RequirementSetId', 'BBG_REQSET_FOUNDER_OR_MVEMBA');

-- Temporarily removed 
-- UPDATE RequirementSetRequirements SET RequirementId = 'BBG_REQUIRES_PLAYER_FOUNDED_RELIGION_OR_MVEMBA' WHERE RequirementId = 'REQUIRES_PLAYER_FOUNDED_RELIGION' AND RequirementSetId <> 'BBG_REQSET_FOUNDER_OR_MVEMBA';

-- Mvemba military unit get forest and jungle free move instead of Ngao
DELETE FROM UnitAbilityModifiers WHERE ModifierId='NAGAO_FOREST_MOVEMENT';

INSERT INTO Modifiers(ModifierId, ModifierType) VALUES
    ('BBG_MILITARY_UNITS_IGNORE_WOODS', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_MILITARY_UNITS_IGNORE_WOODS', 'AbilityType', 'BBG_IGNORE_WOODS_ABILITY');
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_LEADER_RELIGIOUS_CONVERT', 'BBG_MILITARY_UNITS_IGNORE_WOODS');

INSERT INTO Types(Type, Kind) VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'KIND_ABILITY');
INSERT INTO TypeTags(Type, Tag) VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_RECON'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_MELEE'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_RANGED'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_ANTI_CAVALRY'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_LIGHT_CAVALRY'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_HEAVY_CAVALRY'),
    ('BBG_IGNORE_WOODS_ABILITY', 'CLASS_SIEGE');

INSERT INTO UnitAbilities(UnitAbilityType, Name, Description, Inactive, ShowFloatTextWhenEarned, Permanent)  VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'LOC_BBG_IGNORE_WOODS_ABILITY_NAME', 'LOC_BBG_IGNORE_WOODS_ABILITY_DESCRIPTION', 1, 0, 1);
INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
    ('BBG_IGNORE_WOODS_ABILITY', 'RANGER_IGNORE_FOREST_MOVEMENT_PENALTY');


-- 18/06/23 Moved relic bonus from kongo to Mvemba only
UPDATE TraitModifiers SET TraitType='TRAIT_LEADER_RELIGIOUS_CONVERT' WHERE ModifierId='TRAIT_GREAT_WORK_FAITH_RELIC';
UPDATE TraitModifiers SET TraitType='TRAIT_LEADER_RELIGIOUS_CONVERT' WHERE ModifierId='TRAIT_GREAT_WORK_FOOD_RELIC';
UPDATE TraitModifiers SET TraitType='TRAIT_LEADER_RELIGIOUS_CONVERT' WHERE ModifierId='TRAIT_GREAT_WORK_PRODUCTION_RELIC';
UPDATE TraitModifiers SET TraitType='TRAIT_LEADER_RELIGIOUS_CONVERT' WHERE ModifierId='TRAIT_GREAT_WORK_GOLD_RELIC';

--=======Kongo(Civilization)==========--
-- +100% prod towards archealogists
INSERT OR IGNORE INTO TraitModifiers (TraitType, ModifierId) VALUES
	('TRAIT_CIVILIZATION_NKISI', 'TRAIT_ARCHAEOLOGIST_PROD_BBG');
INSERT OR IGNORE INTO Modifiers (ModifierId, ModifierType) VALUES
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION');
INSERT OR IGNORE INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'UnitType', 'UNIT_ARCHAEOLOGIST'),
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'Amount', '100');

-- NGao 3PM
-- 16/04/23 Revert
-- UPDATE Units SET BaseMoves=3 WHERE UnitType='UNIT_KONGO_SHIELD_BEARER';

-- Put back writer point.
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_NKISI', 'TRAIT_DOUBLE_WRITER_POINTS');

-- +4 faith for each sculture and artifact
UPDATE ModifierArguments SET Value='4' WHERE Name='YieldChange' AND ModifierId IN ('TRAIT_GREAT_WORK_FAITH_SCULPTURE', 'TRAIT_GREAT_WORK_FAITH_ARTIFACT');


