-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 19, 2025 at 04:53 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sarno`
--

-- --------------------------------------------------------

--
-- Table structure for table `amministratore`
--

CREATE TABLE `amministratore` (
  `idAdmin` int(38) NOT NULL,
  `Nome` varchar(100) NOT NULL,
  `Cognome` varchar(100) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `idRuolo` int(38) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `materia`
--

CREATE TABLE `materia` (
  `idMateria` int(38) NOT NULL,
  `materia` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `professore`
--

CREATE TABLE `professore` (
  `idProfessore` int(38) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `cognome` varchar(100) NOT NULL,
  `classi` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `idRuolo` int(38) NOT NULL,
  `idMateria` int(38) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ruoli`
--

CREATE TABLE `ruoli` (
  `idRuolo` int(38) NOT NULL,
  `ruolo` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `studenti`
--

CREATE TABLE `studenti` (
  `idStudente` int(38) NOT NULL,
  `nome` varchar(100) DEFAULT NULL,
  `cognome` varchar(100) DEFAULT NULL,
  `classe` varchar(20) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `idRuolo` int(38) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `amministratore`
--
ALTER TABLE `amministratore`
  ADD PRIMARY KEY (`idAdmin`),
  ADD KEY `idRuoloAdmin` (`idRuolo`);

--
-- Indexes for table `materia`
--
ALTER TABLE `materia`
  ADD PRIMARY KEY (`idMateria`);

--
-- Indexes for table `professore`
--
ALTER TABLE `professore`
  ADD PRIMARY KEY (`idProfessore`),
  ADD KEY `idRuoloProfessore` (`idRuolo`),
  ADD KEY `idMateriaProfessore` (`idMateria`);

--
-- Indexes for table `ruoli`
--
ALTER TABLE `ruoli`
  ADD PRIMARY KEY (`idRuolo`);

--
-- Indexes for table `studenti`
--
ALTER TABLE `studenti`
  ADD PRIMARY KEY (`idStudente`),
  ADD KEY `idRuoloStudente` (`idRuolo`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `amministratore`
--
ALTER TABLE `amministratore`
  MODIFY `idAdmin` int(38) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `materia`
--
ALTER TABLE `materia`
  MODIFY `idMateria` int(38) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `professore`
--
ALTER TABLE `professore`
  MODIFY `idProfessore` int(38) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ruoli`
--
ALTER TABLE `ruoli`
  MODIFY `idRuolo` int(38) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `studenti`
--
ALTER TABLE `studenti`
  MODIFY `idStudente` int(38) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `amministratore`
--
ALTER TABLE `amministratore`
  ADD CONSTRAINT `idRuoloAdmin` FOREIGN KEY (`idRuolo`) REFERENCES `ruoli` (`idRuolo`);

--
-- Constraints for table `professore`
--
ALTER TABLE `professore`
  ADD CONSTRAINT `idMateriaProfessore` FOREIGN KEY (`idMateria`) REFERENCES `materia` (`idMateria`),
  ADD CONSTRAINT `idRuoloProfessore` FOREIGN KEY (`idRuolo`) REFERENCES `ruoli` (`idRuolo`);

--
-- Constraints for table `studenti`
--
ALTER TABLE `studenti`
  ADD CONSTRAINT `idRuoloStudente` FOREIGN KEY (`idRuolo`) REFERENCES `ruoli` (`idRuolo`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
