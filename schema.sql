-- Schema for managing teams (squadre) and players (giocatori)
-- Designed for MariaDB / MySQL with InnoDB engine

CREATE DATABASE IF NOT EXISTS campionato
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;
USE campionato;

-- Table of football clubs participating in the championship
CREATE TABLE IF NOT EXISTS squadre (
  id_squadra INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nome_club VARCHAR(100) NOT NULL,
  citta VARCHAR(80) NOT NULL,
  anno_fondazione SMALLINT UNSIGNED NOT NULL,
  budget DECIMAL(15,2) NOT NULL DEFAULT 0.00,
  CONSTRAINT uq_squadre_nome UNIQUE (nome_club),
  CONSTRAINT chk_anno_fondazione CHECK (anno_fondazione BETWEEN 1850 AND YEAR(CURDATE()))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Table of players; each player optionally belongs to a club
CREATE TABLE IF NOT EXISTS giocatori (
  id_giocatore INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(60) NOT NULL,
  cognome VARCHAR(60) NOT NULL,
  ruolo VARCHAR(30) NOT NULL,
  numero_maglia TINYINT UNSIGNED NOT NULL,
  id_squadra INT UNSIGNED NULL,
  CONSTRAINT chk_numero_maglia CHECK (numero_maglia BETWEEN 1 AND 99),
  CONSTRAINT fk_giocatori_squadra
    FOREIGN KEY (id_squadra)
    REFERENCES squadre(id_squadra)
    ON UPDATE CASCADE
    ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Helpful indexes for fast lookups by club and player name
CREATE INDEX idx_giocatori_cognome ON giocatori (cognome);
CREATE INDEX idx_giocatori_squadra ON giocatori (id_squadra);
