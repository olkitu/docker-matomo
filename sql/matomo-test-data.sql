--
-- Dumping data for table `matomo_user`
--

INSERT INTO `matomo_user` (`login`, `password`, `email`, `superuser_access`, `date_registered`, `ts_password_modified`, `twofactor_secret`) VALUES
('admin', '$2y$10$CfAPFuJTUm20Ad9qmmfrquaCltzUQYbII0/ysEf8GqKDDG7YTjU6a', 'admin@example.org', 1, NOW(), NOW(), '');


--
-- Dumping data for table `matomo_site`
--

INSERT INTO `matomo_site` (`idsite`, `name`, `main_url`, `ts_created`, `ecommerce`, `sitesearch`, `sitesearch_keyword_parameters`, `sitesearch_category_parameters`, `timezone`, `currency`, `exclude_unknown_urls`, `excluded_ips`, `excluded_parameters`, `excluded_user_agents`, `group`, `type`, `keep_url_fragment`, `creator_login`) VALUES
(1, 'Localhost', 'http://localhost', NOW(), 0, 1, '', '', 'Europe/Helsinki', 'EUR', 0, '', '', '', '', 'website', 0, NULL);
