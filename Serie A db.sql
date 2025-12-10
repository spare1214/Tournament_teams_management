CREATE TABLE `dm_season` (
  `season_id` str PRIMARY KEY,
  `display_name` str,
  `year_start` int,
  `year_end` int,
  `active` bool
);

CREATE TABLE `dm_matchday` (
  `matchday_id` str PRIMARY KEY,
  `season_id` str,
  `display_name` str,
  `code_serie_a_api` str,
  `matchday_number` int,
  `latest` bool
);

CREATE TABLE `dm_team` (
  `team_id` str PRIMARY KEY,
  `name` str,
  `city` str
);

CREATE TABLE `ft_match` (
  `matchday_id` str,
  `team_home_id` str,
  `team_away_id` str,
  `date_id` str,
  `goals_home` int,
  `goals_away` int,
  `result_symbol` str,
  `concluded` bool,
  `extra_time_first_half_minutes` int,
  `extra_time_second_half_minutes` int,
  `extra_time_total_minutes` int,
  `duration_minutes` int,
  PRIMARY KEY (`matchday_id`, `team_home_id`, `team_away_id`)
);

CREATE TABLE `dm_player` (
  `player_id` str PRIMARY KEY,
  `name` str,
  `year_birth` int,
  `id_latest_team` str,
  `latest_fantamaster_role` str
);

CREATE TABLE `ft_player_role` (
  `player_id` str,
  `season_id` str,
  `source_id` str,
  `role` str,
  PRIMARY KEY (`player_id`, `season_id`, `source_id`)
);

CREATE TABLE `ft_match_player` (
  `matchday_id` str,
  `team_id` str,
  `player_id` str,
  `goals` int,
  `assits` int,
  `penalties_taken` int,
  `penalties_scored` int,
  `penalties_missed` int,
  `goals_concided` int,
  `red_cards` int,
  `yellow_cards` int,
  `grade` float,
  `fantasy_grade` float,
  `swapped_out` bool,
  `swapped_in` bool,
  `swapped_out_minute` int,
  `swapped_in_minute` int,
  `minutes_played` int,
  `home_game` bool,
  PRIMARY KEY (`matchday_id`, `team_id`, `player_id`)
);

CREATE TABLE `ft_stats_team_matchday` (
  `matchday_id` str,
  `team_id` str,
  `league_placement` int,
  `points` int,
  `matches_won` int,
  `matches_drawn` int,
  `matches_lost` int,
  `goals_scored` int,
  `goals_conceded` int,
  `goals_difference` int,
  `last_five_points` int,
  `last_five_matches_won` int,
  `last_five_matches_drawn` int,
  `last_five_matches_lost` int,
  `last_five_goals_scored` int,
  `last_five_goals_conceded` int,
  `last_five_goals_difference` int,
  PRIMARY KEY (`matchday_id`, `team_id`)
);

CREATE TABLE `dm_bonus` (
  `bonus_id` str PRIMARY KEY,
  `value` float
);

ALTER TABLE `ft_match` ADD FOREIGN KEY (`team_home_id`) REFERENCES `dm_team` (`team_id`);

ALTER TABLE `ft_match` ADD FOREIGN KEY (`team_away_id`) REFERENCES `dm_team` (`team_id`);

ALTER TABLE `ft_match` ADD FOREIGN KEY (`matchday_id`) REFERENCES `dm_matchday` (`matchday_id`);

ALTER TABLE `ft_match_player` ADD FOREIGN KEY (`matchday_id`) REFERENCES `dm_matchday` (`matchday_id`);

ALTER TABLE `ft_match_player` ADD FOREIGN KEY (`team_id`) REFERENCES `dm_team` (`team_id`);

ALTER TABLE `ft_stats_team_matchday` ADD FOREIGN KEY (`matchday_id`) REFERENCES `dm_matchday` (`matchday_id`);

ALTER TABLE `ft_stats_team_matchday` ADD FOREIGN KEY (`team_id`) REFERENCES `dm_team` (`team_id`);

ALTER TABLE `ft_match_player` ADD FOREIGN KEY (`player_id`) REFERENCES `dm_player` (`player_id`);

ALTER TABLE `ft_player_role` ADD FOREIGN KEY (`player_id`) REFERENCES `dm_player` (`player_id`);

ALTER TABLE `dm_matchday` ADD FOREIGN KEY (`season_id`) REFERENCES `dm_season` (`season_id`);
