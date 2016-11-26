DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


INSERT INTO `users` (`id`, `name`, `email`) VALUES
(1, 'neo',  'neo@thematrix.com'),
(2, 'trinity',  'trinity@thematrix.com'),
(3, 'morpheus', 'morpheus@thematrix.com');