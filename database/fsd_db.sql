-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : jeu. 02 oct. 2025 à 15:21
-- Version du serveur : 10.4.32-MariaDB
-- Version de PHP : 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `fsd_db`
--

-- --------------------------------------------------------

--
-- Structure de la table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('fsd-batiment-cache-contact@administra.site|127.0.0.1', 'i:1;', 1758894078),
('fsd-batiment-cache-contact@administra.site|127.0.0.1:timer', 'i:1758894078;', 1758894078),
('fsd-batiment-cache-contact@fsd-batiment|127.0.0.1', 'i:1;', 1758905619),
('fsd-batiment-cache-contact@fsd-batiment|127.0.0.1:timer', 'i:1758905619;', 1758905619),
('fsd-batiment-cache-contact@fsdbatiment.fr|127.0.0.1', 'i:1;', 1758640955),
('fsd-batiment-cache-contact@fsdbatiment.fr|127.0.0.1:timer', 'i:1758640955;', 1758640955);

-- --------------------------------------------------------

--
-- Structure de la table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `home_page_section`
--

CREATE TABLE `home_page_section` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `section_key` varchar(255) NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`content`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `home_page_section`
--

INSERT INTO `home_page_section` (`id`, `section_key`, `content`, `created_at`, `updated_at`) VALUES
(1, 'hero', '\"{\\\"slides\\\":[{\\\"title\\\":\\\"Construisons vos r\\u00eaves\\\",\\\"subtitle\\\":\\\"Des projets de construction fiables et durables, r\\u00e9alis\\u00e9s par des experts.\\\",\\\"button_text\\\":\\\"Demander un devis\\\",\\\"background_image\\\":\\\"http:\\/\\/127.0.0.1:8000\\/storage\\/uploads\\/homepage\\/68ae2588f1fe6.jpg\\\"},{\\\"title\\\":\\\"Nos Services de Construction\\\",\\\"subtitle\\\":\\\"R\\u00e9novation, ma\\u00e7onnerie, gros \\u0153uvre, et am\\u00e9nagement int\\u00e9rieur.\\\",\\\"button_text\\\":\\\"Voir nos services\\\",\\\"background_image\\\":\\\"http:\\/\\/127.0.0.1:8000\\/storage\\/uploads\\/homepage\\/68ae258abd39c.jpg\\\"}]}\"', NULL, '2025-08-26 19:22:18'),
(2, 'services', '\"{\\\"title\\\":\\\"ce que nous faisons\\\",\\\"subtitle\\\":\\\"nos services\\\",\\\"description\\\":\\\"D\\u00e9couvrez comment nous pouvons vous accompagner efficacement.\\\",\\\"services_ids\\\":[\\\"5\\\",\\\"6\\\",\\\"7\\\",\\\"8\\\",\\\"9\\\"]}\"', NULL, '2025-09-26 19:15:54'),
(3, 'whyChooseUs', '\"{\\\"title\\\":\\\"Pourquoi choisir Administra ?\\\",\\\"description\\\":\\\"Chez Administra, nous combinons expertise, innovation et engagement pour garantir la r\\u00e9ussite de vos projets. Notre approche personnalis\\u00e9e vous assure un accompagnement sur-mesure, dans le respect des d\\u00e9lais et des budgets.\\\",\\\"items\\\":[{\\\"text\\\":\\\"Solutions innovantes adapt\\u00e9es \\u00e0 vos besoins sp\\u00e9cifiques\\\"},{\\\"text\\\":\\\"\\u00c9quipe d\\u00e9di\\u00e9e et experte \\u00e0 votre \\u00e9coute\\\"},{\\\"text\\\":\\\"Respect strict des d\\u00e9lais et transparence totale\\\"},{\\\"text\\\":\\\"Support et accompagnement post-projet assur\\u00e9s\\\"}],\\\"background_image\\\":\\\"http:\\/\\/127.0.0.1:8000\\/storage\\/uploads\\/homepage\\/XX7gGeqiBud8mVR05ighgTtmF0mSEOe8mUUUySSB.jpg\\\"}\"', NULL, '2025-08-21 15:24:11'),
(5, 'testimonials', '\"{\\\"title\\\":\\\"Ce que disent nos clients\\\",\\\"items\\\":[{\\\"name\\\":\\\"Nadia L.\\\",\\\"role\\\":\\\"Entrepreneure\\\",\\\"message\\\":\\\"Service rapide et professionnel. Je recommande vivement pour tout besoin administratif.\\\"},{\\\"name\\\":\\\"Marc D.\\\",\\\"role\\\":\\\"Consultant\\\",\\\"message\\\":\\\"Une \\u00e9quipe \\u00e0 l\\u2019\\u00e9coute et tr\\u00e8s r\\u00e9active. Mon entreprise a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e sans souci.\\\"},{\\\"name\\\":\\\"Yacine T.\\\",\\\"role\\\":\\\"Ind\\u00e9pendant\\\",\\\"message\\\":\\\"Professionnalisme, clart\\u00e9 et efficacit\\u00e9. Tr\\u00e8s satisfait de l\\u2019accompagnement re\\u00e7u.\\\"},{\\\"name\\\":\\\"Mahmoud B\\\",\\\"role\\\":\\\"G\\u00e9rant\\\",\\\"message\\\":\\\"Professionnalisme, clart\\u00e9 et efficacit\\u00e9. Tr\\u00e8s satisfait de l\\u2019accompagnement re\\u00e7u.\\\"}]}\"', NULL, '2025-08-07 04:03:28'),
(6, 'footer', '\"{\\\"entreprise\\\":\\\"ADMINISTRA\\\",\\\"email\\\":\\\"contact@administra.fr\\\",\\\"phone\\\":\\\"+33 6 12 34 56 79\\\",\\\"adress\\\":\\\"123 rue Exemple, 75000 Paris\\\",\\\"title\\\":\\\"Nos coordonn\\u00e9es\\\",\\\"description\\\":\\\"Nous vous r\\u00e9pondrons dans les meilleurs d\\u00e9lais.\\\",\\\"socials\\\":{\\\"facebook\\\":\\\"https:\\/\\/facebook.com\\/administra\\\",\\\"linkedin\\\":\\\"https:\\/\\/linkedin.com\\/company\\/administra\\\",\\\"instagram\\\":\\\"https:\\/\\/instagram.com\\/administra\\\"}}\"', NULL, '2025-08-06 15:47:58'),
(7, 'aboutus', '\"{\\\"title\\\":\\\"\\u00c0 propos de nous\\\",\\\"subtitle\\\":\\\"Nous sommes une entreprise sp\\u00e9cialis\\u00e9e dans la ma\\u00e7onnerie et la construction durable, au service de nos clients depuis plus de 15 ans.\\\",\\\"long_description\\\":\\\"<p><p><\\/p><p>\\u00a0Notre entreprise sp\\u00e9cialis\\u00e9e dans la ma\\u00e7onnerie et la construction durable accompagne ses clients avec passion et expertise. Nous allions savoir-faire traditionnel et innovation technique pour garantir la qualit\\u00e9, la fiabilit\\u00e9 et la p\\u00e9rennit\\u00e9 de chaque projet.<\\/p><p><\\/p><\\/p><p><p><\\/p><p>\\u00a0Notre \\u00e9quipe d\\u2019artisans qualifi\\u00e9s et d\\u2019ing\\u00e9nieurs exp\\u00e9riment\\u00e9s offre un accompagnement personnalis\\u00e9, adapt\\u00e9 \\u00e0 vos besoins, de la conception \\u00e0 la livraison finale.<\\/p><p><\\/p><\\/p><p><br><\\/p>\\\"}\"', NULL, '2025-08-21 15:20:06'),
(8, 'ParallaxStats', '\"{\\\"title\\\":\\\"B\\u00e2tissons ensemble votre avenir\\\",\\\"description\\\":\\\"Depuis plus de 15 ans, notre entreprise met son expertise au service de vos projets de construction, en alliant innovation, qualit\\u00e9 et respect des d\\u00e9lais.\\\",\\\"badge\\\":\\\"+500 chantiers livr\\u00e9s\\\",\\\"stats\\\":[{\\\"value\\\":\\\"+15\\\",\\\"label\\\":\\\"Ann\\u00e9es d\\u2019exp\\u00e9rience\\\"},{\\\"value\\\":\\\"250+\\\",\\\"label\\\":\\\"Projets r\\u00e9alis\\u00e9s\\\"},{\\\"value\\\":\\\"98%\\\",\\\"label\\\":\\\"Clients satisfaits\\\"},{\\\"value\\\":\\\"24\\/7\\\",\\\"label\\\":\\\"Assistance chantier\\\"}],\\\"background_image\\\":\\\"http:\\/\\/127.0.0.1:8000\\/storage\\/uploads\\/homepage\\/wlzfO0a8CZaab8JZe2lNrQbagJ8KQHb2EFpBe4oI.webp\\\",\\\"image\\\":\\\"http:\\/\\/127.0.0.1:8000\\/storage\\/uploads\\/homepage\\/S3H262MtiVEBwXfSGQlxfJQhEwzxmF1Tg32hs7DV.png\\\"}\"', NULL, '2025-08-26 12:41:22'),
(9, 'projects', '\"{\\\"title\\\":\\\"Nos Projets\\\",\\\"subtitle\\\":\\\"Expertise\\\",\\\"description\\\":\\\"Plongez dans notre univers cr\\u00e9atif \\u00e0 travers une s\\u00e9lection de projets r\\u00e9cents. Chaque r\\u00e9alisation t\\u00e9moigne de notre expertise et de notre passion pour le design moderne.\\\\r\\\\n\\\\r\\\\nFaites d\\u00e9filer pour explorer nos r\\u00e9alisations les plus marquantes.\\\",\\\"project_ids\\\":[\\\"15\\\",\\\"14\\\",\\\"6\\\",\\\"5\\\",\\\"2\\\",\\\"3\\\"]}\"', NULL, '2025-09-29 13:24:23');

-- --------------------------------------------------------

--
-- Structure de la table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_07_30_225132_create_home_page_section', 2),
(5, '2025_08_18_234634_create_settings_table', 3),
(7, '2025_08_19_210648_create_projects_table', 3),
(8, '2025_08_19_210837_create_project_images_table', 3),
(9, '2025_08_19_210608_create_services_table', 1),
(10, '2025_09_15_121743_create-pages-table', 4),
(11, '2025_09_15_124809_alter_projects_content_column', 4),
(12, '2025_09_23_150016_alter_table_service', 1),
(13, '2025_09_23_150106_alter_table_project', 1),
(14, '2025_09_23_150233_alter_table_page', 5);

-- --------------------------------------------------------

--
-- Structure de la table `pages`
--

CREATE TABLE `pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `slug` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `pages`
--

INSERT INTO `pages` (`id`, `title`, `content`, `slug`, `created_at`, `updated_at`, `meta_title`, `meta_description`, `meta_keywords`) VALUES
(1, 'Mentions légales', '<p><br></p><p><br></p><p><br></p><p><strong>Éditeur du site :</strong></p><p><br></p><p><br></p><p>Administra</p><p>N° SIREN : 983 535 386</p><p>Email : <a href=\"mailto:contact@administra.site\" rel=\"noopener noreferrer\" target=\"_blank\" style=\"color: rgb(0, 102, 204);\">contact@administra.site</a></p><p>Whatsapp : +33 7 82 70 14 57</p><p><br></p><p><br></p><p><br></p><p><strong>Hébergement :</strong></p><p><br></p><p><br></p><p>Le site Administra est hébergé par Hostinger International Ltd.</p><p>Adresse : 61 Lordou Vironos Street, 6023 Larnaca, Chypre</p><p>Site web : <a href=\"https://www.hostinger.fr/\" rel=\"noopener noreferrer\" target=\"_blank\">https://www.hostinger.fr</a></p><p>Email : support@hostinger.com</p><p><br></p><p><br></p><p><br></p><p><strong>Propriété intellectuelle :</strong></p><p><br></p><p><br></p><p>Tout le contenu présent sur ce site (textes, images, vidéos, logos) est la propriété exclusive d\'Administra ou de ses partenaires. Toute reproduction totale ou partielle est interdite sans autorisation préalable.</p><p><br></p><p><br></p><p><br></p><p><strong>Protection des données personnelles :</strong></p><p><br></p><p><br></p><p>Les informations collectées via le site sont utilisées uniquement pour répondre aux demandes des utilisateurs. Conformément au RGPD, vous disposez d’un droit d’accès, de modification et de suppression de vos données en contactant <a href=\"mailto:contact@administra.site\" rel=\"noopener noreferrer\" target=\"_blank\">contact@administra.site</a>.</p><p><br></p><p><br></p><p><br></p><p><strong>Cookies :</strong></p><p><br></p><p><br></p><p>Le site peut utiliser des cookies pour améliorer l’expérience utilisateur. Vous pouvez gérer les cookies via les paramètres de votre navigateur.</p><p><br></p><p><br></p><p><br></p><p><strong>Responsabilité :</strong></p><p><br></p><p><br></p><p>Administra ne peut être tenu responsable des dommages directs ou indirects liés à l’utilisation de ce site.</p><p><br></p><p><br></p>', 'mentions-l-gales', '2025-10-01 10:14:38', '2025-10-01 10:14:38', 'Mentions légales', NULL, NULL);

-- --------------------------------------------------------

--
-- Structure de la table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `projects`
--

CREATE TABLE `projects` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `projects`
--

INSERT INTO `projects` (`id`, `title`, `slug`, `description`, `content`, `location`, `date`, `created_at`, `updated_at`, `meta_title`, `meta_description`, `meta_keywords`) VALUES
(2, 'Construction Villa Moderne', 'construction-villa-moderne', 'Villa haut standing avec design contemporain et finitions de luxe.', NULL, 'Paris, France', '2025-04-10', '2025-08-22 08:44:03', '2025-10-01 09:33:25', 'Construction Villa Moderne', NULL, NULL),
(3, 'Immeuble Résidentiel', 'immeuble-residentiel', 'Un projet immobilier de 20 appartements avec parking et espaces verts.', NULL, 'Lyon, France', '2025-01-10', '2025-08-22 08:44:51', '2025-10-01 09:33:05', NULL, NULL, NULL),
(5, 'Rénovation Bureau', 'renovation-bureau', 'Transformation d\'un ancien entrepôt en bureaux modernes et lumineux.', '<h2>Rénovation d’un ancien entrepôt en bureaux modernes</h2><p>\r\n\r\n</p><p>\r\nÀ Marseille, nous avons transformé un ancien entrepôt de 1 200 m² en un espace de bureaux lumineux et fonctionnel.\r\nL’objectif était de créer un lieu de travail moderne, confortable et économe en énergie.\r\n</p><p>\r\n\r\n</p><p>\r\nLe projet a inclus l’isolation thermique, la pose de grandes verrières pour maximiser la lumière naturelle, \r\nla rénovation complète des réseaux (électricité, plomberie, ventilation) ainsi que l’aménagement d’espaces collaboratifs et salles de réunion.\r\n</p><p>\r\n\r\n</p><p>\r\nRésultat : des bureaux design, modulables et adaptés aux besoins d’une équipe de 120 personnes, livrés dans le respect des délais.\r\n</p>', 'Marseille, France', '2025-05-07', '2025-08-22 10:41:35', '2025-10-01 09:32:49', NULL, NULL, NULL),
(6, 'Ravalement de Façade Immeuble Haussmannien', 'ravalement-de-facade-immeuble-haussmannien', 'Ce projet concernait un immeuble du XIXe siècle situé au cœur de Paris.', '<p>&lt;h2&gt;Ravalement et rénovation d’un immeuble haussmannien&lt;/h2&gt;</p><p>&lt;p&gt;</p><p>Ce projet concernait un immeuble du XIXe siècle situé au cœur de Paris.&nbsp;</p><p>Nous avons procédé au &lt;strong&gt;nettoyage haute pression&lt;/strong&gt;, à la réparation des fissures,&nbsp;</p><p>et à l’application d’un enduit respirant respectant l’architecture d’origine.</p><p>&lt;/p&gt;</p><p>&lt;p&gt;</p><p>Les balcons en fer forgé ont été restaurés et repeints, et les moulures décoratives en pierre ont été rénovées avec soin.&nbsp;</p><p>Cette intervention a redonné à la façade tout son charme d’époque, tout en respectant les normes de sécurité et d’urbanisme.</p><p>&lt;/p&gt;</p><p><br></p>', 'Paris, France', '2025-08-01', '2025-08-26 16:25:38', '2025-10-01 09:32:30', 'Ravalement de Façade Immeuble Haussmannien', 'Ravalement de Façade Immeuble', NULL),
(14, 'Installation Salle de Bain', 'installation-salle-de-bain', 'Installation complète d’une salle de bain moderne avec douche à l’italienne, meubles suspendus et carrelage mural design.', '<p>&lt;h2&gt;Installation complète d’une salle de bain moderne&lt;/h2&gt;</p><p>&lt;p&gt;</p><p>Nous avons transformé une ancienne salle de bain en un espace moderne et fonctionnel de 12 m².&nbsp;</p><p>Le projet a inclus la &lt;strong&gt;pose d’une douche à l’italienne&lt;/strong&gt; avec paroi en verre,&nbsp;</p><p>un &lt;strong&gt;meuble double vasque suspendu&lt;/strong&gt;, ainsi que l’installation d’un WC encastré.</p><p>&lt;/p&gt;</p><p>&lt;p&gt;</p><p>Un carrelage mural design effet marbre a été choisi pour donner une touche élégante,&nbsp;</p><p>accompagné d’un éclairage LED intégré pour créer une ambiance chaleureuse.&nbsp;</p><p>Toute la plomberie a été refaite aux normes, assurant une parfaite étanchéité et durabilité.</p><p>&lt;/p&gt;</p><p><br></p>', 'Boulogne-Billancourt, France', '2025-12-03', '2025-09-29 12:48:01', '2025-09-29 12:48:01', NULL, NULL, NULL),
(15, 'Terrassement & VRD – Terrain constructible', 'terrassement-vrd-terrain-constructible', 'Terrassement complet et viabilisation d’un terrain de 800 m² destiné à accueillir une construction résidentielle.', '<p>&lt;h2&gt;Terrassement et viabilisation d’un terrain constructible&lt;/h2&gt;</p><p>&lt;p&gt;</p><p>Notre équipe est intervenue pour préparer un terrain de 800 m² en vue de la construction d’une maison individuelle.&nbsp;</p><p>Le chantier a débuté par le &lt;strong&gt;décapage de la terre végétale&lt;/strong&gt; et le &lt;strong&gt;nivellement du terrain&lt;/strong&gt;.</p><p>&lt;/p&gt;</p><p>&lt;p&gt;</p><p>Nous avons réalisé les &lt;strong&gt;tranchées&lt;/strong&gt; pour l’alimentation en eau, électricité et assainissement (VRD).&nbsp;</p><p>Une plateforme stabilisée a été mise en place pour accueillir les futures fondations.&nbsp;</p><p>Le terrain est désormais prêt à recevoir la construction dans les meilleures conditions.</p><p>&lt;/p&gt;</p><p><br></p>', 'Saint-Denis, France', '2024-06-29', '2025-09-29 12:49:29', '2025-10-01 09:29:20', 'Terrassement & VRD – Terrain constructible', 'Terrassement complet et viabilisation d’un terrain de 800 m² destiné à accueillir une construction résidentielle.', 'Terrassement');

-- --------------------------------------------------------

--
-- Structure de la table `project_images`
--

CREATE TABLE `project_images` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `project_id` bigint(20) UNSIGNED NOT NULL,
  `path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `project_images`
--

INSERT INTO `project_images` (`id`, `project_id`, `path`, `created_at`, `updated_at`) VALUES
(3, 5, 'projects/vNWs8m2HLetXohKIEATRL2j6U6B5Wlx0tzF60KdA.avif', '2025-08-22 10:41:36', '2025-08-22 10:41:36'),
(11, 5, 'projects/hKmdYzBnKPoAqiTI3h2CYpPiYV9ftQS1oSGHl7Jq.jpg', '2025-09-28 10:36:22', '2025-09-28 10:36:22'),
(12, 5, 'projects/k5jMpctocOvTumxgX0MALP2etTfk4DkTpHW0Yq4h.jpg', '2025-09-28 14:24:48', '2025-09-28 14:24:48'),
(13, 5, 'projects/pshXE7SPC9On7DjWorgt7nthFxCDhXj53RnM858y.jpg', '2025-09-28 14:24:49', '2025-09-28 14:24:49'),
(14, 6, 'projects/vidWxweE8I5sep5oVQVpQAUKAs9Rysz8Q3PsXdOx.jpg', '2025-09-29 12:39:43', '2025-09-29 12:39:43'),
(15, 14, 'projects/g2EXqObJpskpLmMUYfdXVUkTNh06BAElpNBhDdU3.jpg', '2025-09-29 12:48:01', '2025-09-29 12:48:01');

-- --------------------------------------------------------

--
-- Structure de la table `services`
--

CREATE TABLE `services` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `long_description` text DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `background_image` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `services`
--

INSERT INTO `services` (`id`, `title`, `slug`, `description`, `long_description`, `icon`, `background_image`, `created_at`, `updated_at`, `meta_title`, `meta_description`, `meta_keywords`) VALUES
(5, 'Maçonnerie générale', 'maconnerie-generale', 'Fondations solides pour tous vos projets.', '<p><br></p><p><br></p><p> Notre service de <strong>maçonnerie</strong> couvre la construction de murs porteurs, </p><p> cloisons, dalles en béton, ainsi que la rénovation et réparation de structures existantes. </p><p> Nous garantissons un travail de qualité respectant les normes de sécurité.</p><p><br></p>', NULL, '/storage/uploads/services/21hDGOhJrEDHYEiagpMVz0b40iXHBM3ak4rhJo97.jpg', '2025-09-26 19:02:41', '2025-09-28 14:27:07', 'Maçonnerie générale - Fondations, murs, rénovation', 'Entreprise spécialisée en maçonnerie générale : fondations, dalles, murs porteurs et aménagements extérieurs. Travaux fiables et conformes aux normes.', 'maçonnerie, construction, fondations, murs porteurs, rénovation, aménagement extérieur'),
(6, 'Peinture & Finitions', 'peinture-finitions', 'Des finitions esthétiques et durables.', '<p><br></p><p> </p><p>Nos peintres qualifiés interviennent pour des <strong>travaux intérieurs et extérieurs</strong> avec des matériaux professionnels.</p><p><br></p><p>Préparation, application, finitions : chaque étape est maîtrisée pour un rendu impeccable.</p><p><br></p><p><br></p>', NULL, '/storage/uploads/services/t1mdPNgKLok9AGE5v5BV8bYYlJlYnAicnoTHvIVd.jpg', '2025-09-26 19:02:41', '2025-09-28 14:28:19', 'Peinture et Finitions - Intérieur & Extérieur', 'Services de peinture et finitions esthétiques et durables pour vos travaux intérieurs et extérieurs. Application professionnelle avec un rendu impeccable.', 'peinture intérieure, peinture extérieure, finitions, rénovation, décoration, travaux'),
(7, 'Plomberie & Sanitaires', 'plomberie-sanitaires', 'Installation et dépannage rapide.', '<p><br></p><p><br></p><p>Nous prenons en charge <strong>l’installation, la rénovation et le dépannage</strong> de vos réseaux d’eau et équipements sanitaires.</p><p><br></p><p>Nos plombiers interviennent avec rigueur, dans le respect des délais et de la sécurité.</p><p><br></p><p> </p><p><br></p>', NULL, NULL, '2025-09-26 19:06:23', '2025-09-26 19:07:17', 'Plomberie & Sanitaires - Installation et Dépannage', 'Installation, rénovation et dépannage de plomberie et sanitaires. Intervention rapide et fiable pour vos réseaux d’eau et équipements.', 'Installation, rénovation et dépannage de plomberie et sanitaires. Intervention rapide et fiable pour vos réseaux d’eau et équipements.'),
(8, 'Ravalement de façade', 'ravalement-de-facade', 'Redonnez vie à vos façades.', '<p><br></p><p><br></p><p>Un ravalement bien réalisé préserve <strong>l’esthétique et l’étanchéité</strong> de votre bâtiment.</p><p><br></p><p>Nous utilisons des <strong>enduits techniques</strong> et travaillons dans le respect des normes thermiques et urbaines.</p><p><br></p><p> </p><p><br></p>', NULL, '/storage/uploads/services/QwDAX4YdamsLT5hNjCMkfEVxznF06QZ9lRFDsEiM.jpg', '2025-09-26 19:06:23', '2025-09-28 18:07:54', 'Ravalement de façade - Esthétique et protectio', 'Redonnez vie à vos façades grâce à un ravalement professionnel. Esthétique, étanchéité et respect des normes thermiques et urbaines', 'ravalement de façade, rénovation, enduits, étanchéité, isolation, bâtiment'),
(9, 'Terrassement & VRD', 'terrassement-vrd', 'Préparer le terrain pour vos fondations.', '<p><br></p><p><br></p><p>Nous réalisons tous types de <strong>terrassement, nivellement, tranchées</strong> et raccordements aux réseaux.</p><p><br></p><p>Équipés et expérimentés, nous assurons une mise en œuvre efficace en toute sécurité.</p><p><br></p><p> </p><p><br></p>', NULL, NULL, '2025-09-26 19:06:23', '2025-09-26 19:14:18', 'Terrassement & VRD - Préparation des fondations', 'Travaux de terrassement et VRD : nivellement, tranchées et raccordements aux réseaux. Interventions sécurisées et efficaces.', 'terrassement, VRD, nivellement, tranchées, fondations, raccordement réseaux');

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('2bt2jusrAgNNMR4A9x359YtiJauaST3xOlWTIhIW', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSG9MZ0VNYjRDUG5yV1lYTFRjaG9LcGNYVDNMUTBtWGRtREpxWG9wUyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1759329612),
('FLvheTsem0xDuZzm6DdofZFMocI7gRKd5dZhQkGs', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoieUJpWFBuYU40djNtU1pES2RsdVc4N21BcE9KWlpEOVBqdGR5VTFRdCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjE6e3M6ODoiaW50ZW5kZWQiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wYWdlcyI7fX0=', 1759410072),
('HtRTtI2L3tPohpIJ0DR978ZhSkhYuyQpLSLX8PJ1', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiWXhsQVZwaktNQmhJcjladElsWlR4OFduTjRsVGhWVTdjREx6UDV4WSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNzoiaHR0cDovLzEyNy4wLjAuMTo4MDAwL3BhZ2VzIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9wYWdlcyI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1759359789),
('nbeVpLUZAERMEiDTdU4MxoBxcEp3l3XYi8YnWiQS', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTWhmeTFDNXRicGZVYjRkdVFVYXRjNzZvS1pEZUJGRkR1ZDBKNERQNiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1759397424),
('p1XrhOq7l89Ep2LyyJbugh8CHJZo11QRZHttj4Wq', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiQVNLVTdFamhsTmQwYWt5cFloU1FpaFVKQThncnJQejNmU29IUktHUCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1759340139),
('vyaSxWEHDh7O4ZFZnxGWFV5gbvOhXylZRRWKLSUk', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiRnRkM2c5NXpTVmszMFltWThpUlRrcXNCaDAwZUxrNmx4aktZUGZ5SSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1759396342),
('xiOHkSHGFfqSHfTi2AEJRUe0bpSkNM40oSJYK1n5', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/140.0.0.0 Safari/537.36', 'YToyOntzOjY6Il90b2tlbiI7czo0MDoiZk1GSlN2SW5Nc0tmbmZoZW9md3BkaHJBMmttRDhqdU5MYTlXdGprRCI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1759407713);

-- --------------------------------------------------------

--
-- Structure de la table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'company_name', 'fsd batiment', '2025-08-20 18:01:03', '2025-08-20 18:01:03'),
(2, 'email', 'contact@fsdbatiment.fr', '2025-08-20 18:01:04', '2025-08-20 18:01:04'),
(3, 'phone', '0617238647', '2025-08-20 18:01:04', '2025-08-20 18:01:04'),
(4, 'adress', 'Paris, France', '2025-08-20 18:01:04', '2025-08-20 18:01:04'),
(5, 'meta_title', NULL, '2025-08-20 18:01:04', '2025-08-20 18:01:04'),
(6, 'meta_description', NULL, '2025-08-20 18:01:04', '2025-08-20 18:01:04'),
(7, 'socials', '{}', '2025-08-20 18:01:04', '2025-08-20 18:01:04'),
(8, 'logo', '/storage/uploads/settings/EAcR95D4eRDQt1u9aFSiw8dOcYNGptDccfahPfKG.png', '2025-08-20 18:01:04', '2025-09-28 18:53:12');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(2, 'Admin', 'contact@fsd-batiment.fr', NULL, '$2y$12$uT7TfZxR73nxhaK7jPtJ.ux/X.LdmbcDAV74G1AuKct8ya8FvDcKu', 'Hd82zAcndkA7qh3fn8Ic4OhAzosUKEMlt0NlEyyjxA2OIBiK2ZFifICzbbJV', '2025-07-30 21:25:39', '2025-09-17 08:30:45');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Index pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Index pour la table `home_page_section`
--
ALTER TABLE `home_page_section`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `home_page_section_section_key_unique` (`section_key`);

--
-- Index pour la table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Index pour la table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`);

--
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Index pour la table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `project_images`
--
ALTER TABLE `project_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `project_images_project_id_foreign` (`project_id`);

--
-- Index pour la table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Index pour la table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Index pour la table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `home_page_section`
--
ALTER TABLE `home_page_section`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT pour la table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `projects`
--
ALTER TABLE `projects`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `project_images`
--
ALTER TABLE `project_images`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT pour la table `services`
--
ALTER TABLE `services`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `project_images`
--
ALTER TABLE `project_images`
  ADD CONSTRAINT `project_images_project_id_foreign` FOREIGN KEY (`project_id`) REFERENCES `projects` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
