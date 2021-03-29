-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : mer. 02 déc. 2020 à 12:32
-- Version du serveur :  10.4.14-MariaDB
-- Version de PHP : 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `rpg_games`
--

-- --------------------------------------------------------

--
-- Structure de la table `ability`
--

CREATE TABLE `ability` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `mana_cost` int(11) NOT NULL,
  `damage_min` int(11) NOT NULL,
  `damage_max` int(11) NOT NULL,
  `is_ulti` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `ability`
--

INSERT INTO `ability` (`id`, `name`, `mana_cost`, `damage_min`, `damage_max`, `is_ulti`) VALUES
(1, 'Slithereen Crush', 115, 260, 260, 0),
(2, 'Breathe Fire', 130, 300, 300, 0),
(3, 'Dragon Tail', 100, 100, 100, 0),
(4, 'Wild Axes', 80, 240, 240, 0),
(5, 'Primal Roar', 200, 300, 300, 1),
(6, 'Acid Spray', 160, 30, 30, 0),
(7, 'Unstable Concoction', 120, 400, 400, 0),
(8, 'Hoof Stomp', 130, 250, 250, 0),
(9, 'Double Edge', 130, 300, 300, 0),
(10, 'Chaos Bolt', 140, 150, 300, 0),
(11, 'Storm Hammer', 140, 320, 320, 0),
(12, 'Gush', 120, 260, 260, 0),
(13, 'Ravage', 325, 400, 400, 1),
(14, 'Burrowstrike', 140, 280, 280, 0),
(15, 'Epicenter', 300, 130, 130, 1),
(16, 'Starstorm', 155, 300, 300, 0),
(17, 'Sacred Arrow', 100, 330, 330, 0),
(18, 'Impale', 155, 280, 280, 0),
(19, 'Vendetta', 260, 500, 500, 1),
(20, 'Earth Spike', 160, 260, 260, 0),
(21, 'Finger of Death', 650, 850, 850, 1),
(22, 'Dragon Slave', 145, 310, 310, 0),
(23, 'Light Strike Array', 130, 200, 200, 0),
(24, 'Laguna Blade', 680, 900, 900, 1),
(25, 'Laser', 170, 320, 320, 0),
(26, 'Heat-Seeking Missile', 140, 350, 350, 0),
(27, 'Arc Lightning', 80, 150, 150, 0),
(28, 'Lightning Bolt', 140, 350, 350, 0),
(29, 'Thundergod\'s Wrath', 450, 500, 500, 1),
(30, 'Assassinate', 275, 650, 650, 1),
(31, 'Lucent Beam', 120, 300, 300, 0),
(32, 'Eclipse', 250, 1500, 1500, 1),
(33, 'Ice Shards', 115, 280, 280, 0),
(34, 'Snowball', 75, 220, 280, 0),
(35, 'Walrus PUNCH!', 100, 520, 520, 1),
(36, 'Split Earth', 140, 225, 225, 0),
(37, 'Lightning Storm', 140, 210, 210, 0),
(38, 'Pulse Nova', 110, 600, 600, 1),
(39, 'Brain Sap', 180, 400, 400, 0),
(40, 'Fiend\'s Grip', 400, 1290, 1290, 1),
(41, 'Firestorm', 130, 420, 420, 0),
(42, 'Blade Fury', 90, 700, 700, 0);

-- --------------------------------------------------------

--
-- Structure de la table `game`
--

CREATE TABLE `game` (
  `id` int(11) NOT NULL,
  `map_id` int(11) NOT NULL,
  `team_victory_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `played_on` datetime NOT NULL,
  `duration` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `game`
--

INSERT INTO `game` (`id`, `map_id`, `team_victory_id`, `name`, `played_on`, `duration`) VALUES
(1, 1, 15, 'Compétitive 1', '2020-12-01 12:23:41', 71),
(2, 2, 15, 'Compétitive 2', '2020-12-02 06:26:35', 21),
(3, 3, 15, 'Compétitive 3', '2020-12-01 19:29:55', 36),
(4, 2, 16, 'Casual 1', '2020-12-01 13:18:48', 62),
(5, 1, 16, 'Casual 2', '2020-11-30 15:26:14', 29),
(6, 1, 16, 'Compétitive 4', '2020-12-01 12:23:41', 48),
(7, 1, 15, 'Compétive 5', '2020-11-27 06:18:29', 27);

-- --------------------------------------------------------

--
-- Structure de la table `hero`
--

CREATE TABLE `hero` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `hp_max` int(11) NOT NULL,
  `mana_max` int(11) NOT NULL,
  `level` int(11) NOT NULL,
  `attack_min` int(11) NOT NULL,
  `attack_max` int(11) NOT NULL,
  `defense` int(11) NOT NULL,
  `ability_resistance` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `hero`
--

INSERT INTO `hero` (`id`, `name`, `hp_max`, `mana_max`, `level`, `attack_min`, `attack_max`, `defense`, `ability_resistance`) VALUES
(1, 'Zeus', 1580, 1287, 25, 134, 142, 8, 25),
(2, 'Lina', 1740, 1491, 25, 137, 149, 6, 25),
(3, 'Tinker', 1760, 1383, 25, 133, 139, 9, 25),
(4, 'Lion', 1600, 1299, 25, 131, 137, 9, 25),
(5, 'Sven', 2160, 639, 25, 139, 141, 12, 25),
(6, 'Tidehunter', 2420, 771, 25, 136, 142, 8, 25),
(7, 'Slardar', 2340, 687, 25, 137, 145, 16, 25),
(8, 'Sand King', 2080, 819, 25, 117, 127, 9, 25),
(9, 'Dragon Knight', 2240, 771, 25, 133, 139, 11, 25),
(10, 'Chaos Knight', 2260, 627, 25, 132, 162, 11, 25),
(11, 'Centaur Warunner', 2940, 807, 25, 173, 175, 6, 25),
(12, 'Alchemist', 1980, 891, 25, 113, 122, 9, 25),
(13, 'Nyx Assassin', 1760, 897, 25, 106, 110, 14, 25),
(14, 'Juggernaut', 1640, 639, 25, 117, 121, 17, 25),
(15, 'Razor', 1980, 951, 25, 107, 109, 13, 25),
(16, 'Sniper', 1380, 999, 25, 121, 127, 16, 25),
(17, 'Luna', 1660, 891, 25, 131, 137, 19, 25),
(18, 'Tuskar', 2520, 771, 25, 143, 147, 13, 25),
(19, 'Leshrac', 1800, 1374, 25, 128, 132, 15, 25),
(20, 'Bane', 1880, 1083, 25, 119, 125, 15, 25),
(21, 'Underlord', 2140, 939, 25, 134, 140, 11, 25),
(22, 'Terrorblade', 1300, 759, 25, 163, 169, 30, 25),
(23, 'Mirana', 1600, 879, 25, 133, 138, 17, 25),
(24, 'Beastmaster', 2040, 807, 25, 129, 133, 8, 25);

-- --------------------------------------------------------

--
-- Structure de la table `hero_ability`
--

CREATE TABLE `hero_ability` (
  `id` int(11) NOT NULL,
  `hero_id` int(11) NOT NULL,
  `ability_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `hero_ability`
--

INSERT INTO `hero_ability` (`id`, `hero_id`, `ability_id`) VALUES
(1, 12, 6),
(2, 12, 7),
(3, 20, 40),
(4, 20, 39),
(5, 11, 9),
(6, 11, 8),
(7, 10, 10),
(8, 9, 3),
(9, 9, 2),
(10, 14, 42),
(12, 19, 36),
(13, 19, 37),
(14, 19, 38),
(15, 2, 22),
(16, 2, 24),
(17, 2, 23),
(18, 4, 20),
(19, 4, 21),
(20, 17, 31),
(21, 17, 32),
(22, 13, 18),
(23, 13, 19),
(24, 8, 15),
(25, 8, 14),
(26, 7, 1),
(27, 16, 30),
(28, 5, 11),
(29, 6, 13),
(30, 6, 12),
(31, 18, 34),
(32, 18, 33),
(33, 3, 25),
(34, 3, 26),
(35, 21, 41),
(36, 1, 27),
(37, 1, 29),
(38, 1, 28),
(39, 23, 16),
(40, 23, 17),
(41, 24, 4),
(42, 24, 5);

-- --------------------------------------------------------

--
-- Structure de la table `map`
--

CREATE TABLE `map` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `height` int(11) NOT NULL,
  `width` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `map`
--

INSERT INTO `map` (`id`, `name`, `height`, `width`) VALUES
(1, 'Grassland', 640, 800),
(2, 'Iceland', 480, 540),
(3, 'Mountain', 360, 480);

-- --------------------------------------------------------

--
-- Structure de la table `participe`
--

CREATE TABLE `participe` (
  `id` int(11) NOT NULL,
  `nb_kill` int(11) NOT NULL,
  `nb_death` int(11) NOT NULL,
  `nb_assistance` int(11) NOT NULL,
  `hero_id` int(11) NOT NULL,
  `game_id` int(11) NOT NULL,
  `team_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `participe`
--

INSERT INTO `participe` (`id`, `nb_kill`, `nb_death`, `nb_assistance`, `hero_id`, `game_id`, `team_id`) VALUES
(1, 12, 0, 23, 14, 1, 15),
(2, 2, 5, 35, 4, 1, 15),
(3, 4, 7, 13, 23, 1, 16),
(4, 3, 11, 11, 13, 1, 16),
(5, 6, 9, 15, 1, 1, 16),
(6, 7, 7, 22, 20, 1, 15),
(7, 3, 15, 29, 18, 1, 15),
(8, 8, 9, 21, 7, 1, 15),
(9, 5, 8, 25, 8, 1, 16),
(10, 17, 9, 13, 22, 1, 16),
(11, 13, 1, 5, 12, 2, 16),
(12, 7, 4, 10, 10, 2, 15),
(13, 6, 11, 6, 24, 2, 15),
(14, 5, 15, 21, 19, 2, 16),
(15, 2, 11, 24, 13, 2, 15),
(16, 7, 13, 7, 7, 2, 15),
(17, 5, 6, 6, 22, 2, 15),
(18, 6, 7, 22, 23, 2, 16),
(19, 3, 7, 11, 6, 2, 16),
(20, 6, 7, 22, 4, 2, 16),
(21, 8, 6, 23, 16, 4, 15),
(22, 12, 10, 20, 4, 4, 15),
(23, 17, 12, 11, 2, 4, 15),
(24, 8, 8, 6, 23, 4, 16),
(25, 6, 2, 6, 22, 4, 16),
(26, 10, 4, 9, 10, 4, 16),
(27, 6, 3, 14, 14, 4, 15),
(28, 10, 10, 5, 15, 4, 15),
(29, 3, 15, 5, 2, 4, 16),
(30, 13, 7, 4, 5, 4, 16),
(31, 6, 9, 8, 10, 3, 15),
(32, 5, 8, 11, 8, 3, 15),
(33, 2, 11, 13, 7, 3, 16),
(34, 10, 4, 12, 14, 3, 16),
(35, 5, 10, 19, 20, 3, 16),
(36, 14, 3, 7, 2, 3, 16),
(37, 4, 12, 30, 21, 3, 15),
(38, 19, 5, 12, 16, 3, 15),
(39, 13, 1, 6, 9, 3, 15),
(40, 5, 6, 10, 19, 3, 16),
(41, 20, 1, 14, 16, 5, 16),
(42, 5, 5, 14, 20, 5, 16),
(43, 4, 7, 18, 23, 5, 16),
(44, 5, 7, 14, 14, 5, 16),
(45, 8, 7, 8, 9, 5, 16),
(46, 5, 6, 10, 19, 5, 15),
(47, 5, 10, 9, 15, 5, 15),
(48, 6, 6, 11, 18, 5, 15),
(49, 9, 9, 8, 17, 5, 15),
(50, 0, 11, 8, 4, 5, 15),
(51, 1, 12, 11, 21, 6, 15),
(52, 7, 8, 3, 5, 6, 15),
(53, 8, 8, 10, 1, 6, 15),
(54, 2, 12, 12, 7, 6, 15),
(55, 3, 6, 11, 20, 6, 15),
(56, 13, 3, 21, 12, 6, 16),
(57, 5, 7, 20, 2, 6, 16),
(58, 3, 4, 22, 18, 6, 16),
(59, 19, 2, 3, 14, 6, 16),
(60, 6, 5, 24, 8, 6, 16),
(61, 2, 9, 19, 2, 7, 15),
(62, 2, 8, 13, 24, 7, 15),
(63, 4, 7, 27, 13, 7, 15),
(64, 9, 6, 14, 4, 7, 15),
(65, 24, 7, 7, 17, 7, 15),
(66, 13, 5, 17, 1, 7, 16),
(67, 6, 12, 15, 6, 7, 16),
(68, 2, 8, 23, 16, 7, 16),
(69, 13, 10, 9, 10, 7, 16),
(70, 3, 8, 22, 20, 7, 16);

-- --------------------------------------------------------

--
-- Structure de la table `team`
--

CREATE TABLE `team` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Déchargement des données de la table `team`
--

INSERT INTO `team` (`id`, `name`) VALUES
(15, 'Team Dire'),
(16, 'Team Radiant');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `ability`
--
ALTER TABLE `ability`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `game`
--
ALTER TABLE `game`
  ADD PRIMARY KEY (`id`),
  ADD KEY `map_id` (`map_id`),
  ADD KEY `team_victory_id` (`team_victory_id`);

--
-- Index pour la table `hero`
--
ALTER TABLE `hero`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `hero_ability`
--
ALTER TABLE `hero_ability`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hero_id` (`hero_id`),
  ADD KEY `ability_id` (`ability_id`);

--
-- Index pour la table `map`
--
ALTER TABLE `map`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `participe`
--
ALTER TABLE `participe`
  ADD PRIMARY KEY (`id`),
  ADD KEY `hero_id` (`hero_id`),
  ADD KEY `game_id` (`game_id`),
  ADD KEY `team_id` (`team_id`);

--
-- Index pour la table `team`
--
ALTER TABLE `team`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `ability`
--
ALTER TABLE `ability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT pour la table `game`
--
ALTER TABLE `game`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `hero`
--
ALTER TABLE `hero`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT pour la table `hero_ability`
--
ALTER TABLE `hero_ability`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT pour la table `map`
--
ALTER TABLE `map`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT pour la table `participe`
--
ALTER TABLE `participe`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT pour la table `team`
--
ALTER TABLE `team`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `game`
--
ALTER TABLE `game`
  ADD CONSTRAINT `game_ibfk_1` FOREIGN KEY (`map_id`) REFERENCES `map` (`id`),
  ADD CONSTRAINT `game_ibfk_2` FOREIGN KEY (`team_victory_id`) REFERENCES `team` (`id`);

--
-- Contraintes pour la table `hero_ability`
--
ALTER TABLE `hero_ability`
  ADD CONSTRAINT `hero_ability_ibfk_1` FOREIGN KEY (`hero_id`) REFERENCES `hero` (`id`),
  ADD CONSTRAINT `hero_ability_ibfk_2` FOREIGN KEY (`ability_id`) REFERENCES `ability` (`id`);

--
-- Contraintes pour la table `participe`
--
ALTER TABLE `participe`
  ADD CONSTRAINT `participe_ibfk_1` FOREIGN KEY (`hero_id`) REFERENCES `hero` (`id`),
  ADD CONSTRAINT `participe_ibfk_2` FOREIGN KEY (`game_id`) REFERENCES `game` (`id`),
  ADD CONSTRAINT `participe_ibfk_3` FOREIGN KEY (`team_id`) REFERENCES `team` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
