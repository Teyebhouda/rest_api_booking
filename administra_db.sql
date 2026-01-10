-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : ven. 08 août 2025 à 16:22
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
-- Base de données : `administra_db`
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
(1, 'hero', '\"{\\\"title\\\":\\\"Simplifiez vos d\\u00e9marches administratives.\\\",\\\"subtitle\\\":\\\"Nous g\\u00e9rons vos formalit\\u00e9s pour vous, rapidement et efficacement.\\\",\\\"button_text\\\":\\\"Nous Contacter\\\",\\\"background_image\\\":\\\"http:\\/\\/127.0.0.1:8000\\/storage\\/uploads\\/homepage\\/vEXBATdt94DVKjRNiPcd1HRnoqfzNMLJivvEm73Q.png\\\"}\"', NULL, '2025-08-07 11:00:55'),
(2, 'services', '\"{\\\"title\\\":\\\"Nos services\\\",\\\"subtitle\\\":\\\"D\\u00e9couvrez comment nous pouvons vous accompagner efficacement.\\\",\\\"items\\\":[{\\\"title\\\":\\\"D\\u00e9marches administratives\\\",\\\"description\\\":\\\"Nous g\\u00e9rons vos formalit\\u00e9s avec rigueur : constitution de dossier, d\\u00e9p\\u00f4t, suivi administratif, pour vous faire gagner du temps et \\u00e9viter les erreurs.\\\",\\\"longDescription\\\":\\\"<p><br><\\/p><h3><br><\\/h3><h3><br><\\/h3><h3><br><\\/h3><h3>Accompagnement sur mesure<\\/h3><p>Nous g\\u00e9rons les d\\u00e9marches de A \\u00e0 Z : constitution du dossier, d\\u00e9p\\u00f4t, suivi...<\\/p><ul><li>aaaaaa<\\/li><li>aaaaaaaaa<\\/li><li>aaaaaaa<\\/li><\\/ul><p><br><\\/p><p><br><\\/p><p><br><\\/p><p><br><\\/p><p><br><\\/p>\\\",\\\"icon\\\":\\\"https:\\/\\/cdn-icons-png.flaticon.com\\/512\\/1828\\/1828859.png\\\"},{\\\"title\\\":\\\"Recours et d\\u00e9marches juridiques\\\",\\\"description\\\":\\\"Nos juristes vous accompagnent dans les proc\\u00e9dures : r\\u00e9daction de recours, appui juridique et suivi personnalis\\u00e9.\\\",\\\"longDescription\\\":\\\"<p><br><\\/p><h3>Accompagnement sur mesure<\\/h3><p><br><\\/p><p><br><\\/p><p>Nous g\\u00e9rons les d\\u00e9marches de A \\u00e0 Z : constitution du dossier, d\\u00e9p\\u00f4t, suivi...<\\/p><p><br><\\/p><p><br><\\/p><p><br><\\/p><p><br><\\/p><p><br><\\/p>\\\",\\\"icon\\\":\\\"https:\\/\\/cdn-icons-png.flaticon.com\\/512\\/2920\\/2920239.png\\\"},{\\\"title\\\":\\\"Admissions exceptionnelles\\\",\\\"description\\\":\\\"Traitement rapide et suivi de vos demandes d\\u2019admission exceptionnelle au s\\u00e9jour avec un accompagnement personnalis\\u00e9.\\\",\\\"icon\\\":\\\"https:\\/\\/cdn-icons-png.flaticon.com\\/512\\/990\\/990162.png\\\"},{\\\"title\\\":\\\"Informatique & Internet\\\",\\\"description\\\":\\\"Support technique, d\\u00e9veloppement web, cybers\\u00e9curit\\u00e9 et assistance informatique pour tous vos besoins num\\u00e9riques.\\\",\\\"icon\\\":\\\"https:\\/\\/cdn-icons-png.flaticon.com\\/512\\/2412\\/2412669.png\\\"},{\\\"title\\\":\\\"Publicit\\u00e9\\\",\\\"description\\\":\\\"Cr\\u00e9ation graphique, campagnes publicitaires et gestion de la communication visuelle pour am\\u00e9liorer votre visibilit\\u00e9.\\\",\\\"icon\\\":\\\"https:\\/\\/cdn-icons-png.flaticon.com\\/512\\/1670\\/1670045.png\\\"},{\\\"title\\\":\\\"Gestion & comptabilit\\u00e9\\\",\\\"description\\\":\\\"Suivi comptable, conseils financiers et aide \\u00e0 la gestion pour garantir la sant\\u00e9 financi\\u00e8re de votre entreprise.\\\",\\\"icon\\\":\\\"https:\\/\\/cdn-icons-png.flaticon.com\\/512\\/4334\\/4334852.png\\\"}]}\"', NULL, '2025-08-07 09:44:46'),
(3, 'whyChooseUs', '\"{\\\"title\\\":\\\"Pourquoi choisir Administra ?\\\",\\\"description\\\":\\\"Chez Administra, nous combinons expertise, innovation et engagement pour garantir la r\\u00e9ussite de vos projets. Notre approche personnalis\\u00e9e vous assure un accompagnement sur-mesure, dans le respect des d\\u00e9lais et des budgets.\\\",\\\"items\\\":[{\\\"text\\\":\\\"Solutions innovantes adapt\\u00e9es \\u00e0 vos besoins sp\\u00e9cifiques\\\"},{\\\"text\\\":\\\"\\u00c9quipe d\\u00e9di\\u00e9e et experte \\u00e0 votre \\u00e9coute\\\"},{\\\"text\\\":\\\"Respect strict des d\\u00e9lais et transparence totale\\\"},{\\\"text\\\":\\\"Support et accompagnement post-projet assur\\u00e9s\\\"}],\\\"background_image\\\":\\\"http:\\/\\/127.0.0.1:8000\\/storage\\/uploads\\/homepage\\/KHm5vY2sDpYig25tVBx1AO8KaaWdiR1iiMdRDZCr.jpg\\\"}\"', NULL, '2025-08-07 10:57:02'),
(5, 'testimonials', '\"{\\\"title\\\":\\\"Ce que disent nos clients\\\",\\\"items\\\":[{\\\"name\\\":\\\"Nadia L.\\\",\\\"role\\\":\\\"Entrepreneure\\\",\\\"message\\\":\\\"Service rapide et professionnel. Je recommande vivement pour tout besoin administratif.\\\"},{\\\"name\\\":\\\"Marc D.\\\",\\\"role\\\":\\\"Consultant\\\",\\\"message\\\":\\\"Une \\u00e9quipe \\u00e0 l\\u2019\\u00e9coute et tr\\u00e8s r\\u00e9active. Mon entreprise a \\u00e9t\\u00e9 cr\\u00e9\\u00e9e sans souci.\\\"},{\\\"name\\\":\\\"Yacine T.\\\",\\\"role\\\":\\\"Ind\\u00e9pendant\\\",\\\"message\\\":\\\"Professionnalisme, clart\\u00e9 et efficacit\\u00e9. Tr\\u00e8s satisfait de l\\u2019accompagnement re\\u00e7u.\\\"},{\\\"name\\\":\\\"Mahmoud B\\\",\\\"role\\\":\\\"G\\u00e9rant\\\",\\\"message\\\":\\\"Professionnalisme, clart\\u00e9 et efficacit\\u00e9. Tr\\u00e8s satisfait de l\\u2019accompagnement re\\u00e7u.\\\"}]}\"', NULL, '2025-08-07 04:03:28'),
(6, 'footer', '\"{\\\"entreprise\\\":\\\"ADMINISTRA\\\",\\\"email\\\":\\\"contact@administra.fr\\\",\\\"phone\\\":\\\"+33 6 12 34 56 79\\\",\\\"adress\\\":\\\"123 rue Exemple, 75000 Paris\\\",\\\"title\\\":\\\"Nos coordonn\\u00e9es\\\",\\\"description\\\":\\\"Nous vous r\\u00e9pondrons dans les meilleurs d\\u00e9lais.\\\",\\\"socials\\\":{\\\"facebook\\\":\\\"https:\\/\\/facebook.com\\/administra\\\",\\\"linkedin\\\":\\\"https:\\/\\/linkedin.com\\/company\\/administra\\\",\\\"instagram\\\":\\\"https:\\/\\/instagram.com\\/administra\\\"}}\"', NULL, '2025-08-06 15:47:58');

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
(4, '2025_07_30_225132_create_home_page_section', 2);

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
('31ECrjEvIIZJ7E2cdrDQw34QaIEMy0uN9JZhDCBB', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiYm00M2NXR1hWU1RYSTRTWlY2QWg1ckUyYkpYOWxZNDhnYTFsWEJQbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1754578419),
('A96sCAq7Cq5nkm6HHziWbFTvmb5trcoHNNkv3Pe3', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNko0OGQxZnRvMVUxa0NlZzFkQXdGSEc0QjRUUzVldWkxM1BtTUJ1YiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1754601927),
('Ad6S08OjRwv9FMKWsa5ADIcflCgN6SZoPYU2bADY', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiTzZmTEpCWEVQZ1E2NHhQWVZyazVtWVVzRDBrWU5vSmFzNGc0dnlDNyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly9kNjE2MTM2NDYxYjYubmdyb2stZnJlZS5hcHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1754577853),
('g2J8JRTFMh9IbvG3otYazgDoZQrkxYYpMSzye44c', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiV1lXOG5LNmJtMmRXVEJzakJ2MXZWQmJoS1Z5TWhTQ01mODdibEIyZCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1754643781),
('gw1n0lDASLBbKsL0A6ojMkVcDnUE6Hk2cjIOY88o', NULL, '127.0.0.1', 'Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) SamsungBrowser/28.0 Chrome/130.0.0.0 Mobile Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiT1c0aXpybFU2NDlCeEpIRkowbzNKYVdTSlRUbjNaMEVwSHdrSGczbyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly85Y2NkODcwMTk3ZTcubmdyb2stZnJlZS5hcHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1754601015),
('GzgoEvlCn8tkq6rD5mgbYbJmSGK3SGWSy4U9ijij', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiNUpmMUhJQU50ZFJKWEszZjRaSmdoS3l3eUZvOVRUbDVxaTNRU3JTOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly85Y2NkODcwMTk3ZTcubmdyb2stZnJlZS5hcHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1754601061),
('jooT1I3cCCOrkee7SFZVCo5ZBEvx2woJLoijQ5Ww', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibXdzd29tcDZtWWpjd1lNYkU2bHpqWVlhM1NqQkVpR0RPMmd4ckJiciI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly85Y2NkODcwMTk3ZTcubmdyb2stZnJlZS5hcHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1754601940),
('k82C3qeoDS6UZ6NU2oZVAk9qfPwh6NyTjxPHwlIV', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiVFAwTTU1bmRRemNXZEJSTXNoWWJyZXhaWXhVd1ZVWUllT3VXd0pUOSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6MzoidXJsIjthOjE6e3M6ODoiaW50ZW5kZWQiO3M6MjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9ob21lIjt9fQ==', 1754575885),
('lQcMxs8N8CaOkJZPAZulhu66XvvaE9elGny1vaZd', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoibEhOWG9Jb1ZKMFF2eDNjamJwV0V2SjRDUUVLVnNOOFN2VHN2cldraSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly84NTU4NWY0ZWExNDMubmdyb2stZnJlZS5hcHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1754578833),
('t433nBVZPXsjSdEYeWH2FObhfHqNoOpDlv39Ccxn', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiaGhUS1RHY2ZZUUNWNlhlbmNmTmlYVUhsUlBqV2t5Wno4eXJ5YzhwbSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjY6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9ob21lIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1754643843),
('t7PnBRyf7qx8AbloBu5Y5KqzPpYzqnGD1jBwktrH', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/138.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoieDhqekpTMkt3bTIzWmRDTXNITUhUQ2VRcTJBVVF5MDZwVVZZeFY1dCI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjMxOiJodHRwOi8vMTI3LjAuMC4xOjgwMDAvZGFzaGJvYXJkIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6Mjt9', 1754662733),
('unJ8xEvFoRnl7B96XxvcCxl94M4YbhhFAdZxjcnF', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiM2lRQUh3aFp0RHVQUFVDZ1lxS3hzTlZqVUdCbldQRzY0a0I4THozeiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NTA6Imh0dHA6Ly9iZjdkOWI4MzU3MzkwMmNkNjM3NGI3ZGM4OWRlMGQxOS5zZXJ2ZW8ubmV0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==', 1754577171),
('zd5FG4NBZnrfQckpOizPjzoBs9GK0OxbHNctR9tX', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiV2syQmEyVHIzakxXYUc5Y1FBQzk0ZlN4OUpxc25Md0JObENwcXZrMyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1754589298),
('zSXTscdP0yKpnBcQtdM8TWjyLreewtTqjDmm5YVM', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiUHFvUkdYT1hFNjdZYWlsUU1nZ1pvUGRkSThNVll3ejM5NVpuZ05GMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHA6Ly85Y2NkODcwMTk3ZTcubmdyb2stZnJlZS5hcHAiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1754600762);

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
(2, 'Admin', 'contact@administra.fr', NULL, '$2y$12$uT7TfZxR73nxhaK7jPtJ.ux/X.LdmbcDAV74G1AuKct8ya8FvDcKu', NULL, '2025-07-30 21:25:39', '2025-07-30 21:25:39');

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
-- Index pour la table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Index pour la table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT pour la table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT pour la table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
