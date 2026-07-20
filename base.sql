CREATE DATABASE IF NOT EXISTS examenS2;
USE examenS2;

-- 1. Table membre
CREATE TABLE membre (
    id_membre INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    numero_etu VARCHAR(20) NOT NULL UNIQUE, -- UNIQUE au lieu d'une 2e PRIMARY KEY
    image_profile VARCHAR(255) DEFAULT 'default.png'
);

-- 2. Table categorie
CREATE TABLE categorie(
    id_categorie INT AUTO_INCREMENT PRIMARY KEY,
    nom_categorie VARCHAR(100) NOT NULL
);

-- 3. Table produit
CREATE TABLE produit(
    id_produit INT AUTO_INCREMENT PRIMARY KEY, -- Renommé et mis en AUTO_INCREMENT
    nom VARCHAR(100) NOT NULL,
    id_categorie INT,
    prix_reference INT, -- Utilise DECIMAL(10,2) si tu as des centimes
    FOREIGN KEY (id_categorie) REFERENCES categorie(id_categorie)
);

-- 4. Table produit_membre (Stock/Mise en vente d'un membre)
CREATE TABLE produit_membre(
    id_produit_membre INT AUTO_INCREMENT PRIMARY KEY, -- Ajout du AUTO_INCREMENT PRIMARY KEY
    id_produit INT NOT NULL,
    id_membre INT NOT NULL,
    prix_vente INT NOT NULL,
    quantite_dispo INT DEFAULT 0,
    date_dispo DATE,
    FOREIGN KEY (id_produit) REFERENCES produit(id_produit),
    FOREIGN KEY (id_membre) REFERENCES membre(id_membre)
);

-- 5. Table vente
CREATE TABLE vente(
    id_vente INT AUTO_INCREMENT PRIMARY KEY,
    date_vente DATE NOT NULL,   -- Renommé pour éviter le mot réservé "date"
    heure_vente TIME NOT NULL,   -- Renommé pour éviter le mot réservé "heure"
    id_produit_membre INT NOT NULL,
    quantite INT NOT NULL,
    FOREIGN KEY (id_produit_membre) REFERENCES produit_membre(id_produit_membre)
);

USE examenS2;

-- 1. Insertion des 10 Membres
INSERT INTO membre (nom, numero_etu, image_profile) VALUES
('Rakoto Jean', 'ETU0001', 'jean.png'),
('Rasoa Marie', 'ETU0002', 'marie.png'),
('Andry Bako', 'ETU0003', 'bako.png'),
('Rabe Paul', 'ETU0004', 'default.png'),
('Koto Marc', 'ETU0005', 'marc.png'),
('Soa Sarah', 'ETU0006', 'sarah.png'),
('Heriniaina Eric', 'ETU0007', 'default.png'),
('Naivo Luc', 'ETU0008', 'luc.png'),
('Voahirana Mialy', 'ETU0009', 'mialy.png'),
('Tiana Laura', 'ETU0010', 'laura.png');

-- 2. Insertion des 4 Catégories
INSERT INTO categorie (nom_categorie) VALUES
('plat'),
('boisson'),
('snack'),
('dessert');

-- 3. Insertion des 15 Produits
-- (1=plat, 2=boisson, 3=snack, 4=dessert)
INSERT INTO produit (nom, id_categorie, prix_reference) VALUES
-- Plats (Catégorie 1)
('Riz Henakisoa', 1, 6000),
('Mine Sao Poulet', 1, 5000),
('Sandwich Jambon', 1, 3000),
('Pizza Reine', 1, 8000),
-- Boissons (Catégorie 2)
('Coca Cola 50cl', 2, 2500),
('Jus d Orange Naturel', 2, 3000),
('Eau Minérale 1.5L', 2, 2000),
('Café Noir', 2, 1000),
-- Snacks (Catégorie 3)
('Samosa (la pièce)', 3, 500),
('Chips Piment', 3, 1500),
('Nems Poulet', 3, 1000),
('Cacahuètes Grillées', 3, 800),
-- Desserts (Catégorie 4)
('Tarte aux Pommes', 4, 3500),
('Gâteau Chocolat', 4, 4000),
('Yaourt Nature', 4, 1500);

-- 4. Insertion des 20 Produits mis en vente par les membres (produit_membre)
INSERT INTO produit_membre (id_produit, id_membre, prix_vente, quantite_dispo, date_dispo) VALUES
(1, 1, 5500, 10, '2026-07-20'),  -- Jean vend du Riz Henakisoa
(2, 2, 5000, 5,  '2026-07-20'),  -- Marie vend du Mine Sao
(3, 3, 2800, 15, '2026-07-20'),  -- Bako vend des Sandwichs
(5, 1, 2500, 20, '2026-07-20'),  -- Jean vend du Coca
(6, 4, 3000, 8,  '2026-07-21'),  -- Paul vend du Jus d'Orange
(9, 5, 500,  50, '2026-07-20'),  -- Marc vend des Samosas
(13, 6, 3500, 6,  '2026-07-21'),  -- Sarah vend des Tartes
(14, 7, 3800, 4,  '2026-07-20'),  -- Eric vend du Gâteau
(4, 8, 8000, 3,  '2026-07-22'),  -- Luc vend des Pizzas
(7, 9, 2000, 12, '2026-07-20'),  -- Mialy vend de l'Eau
(8, 10, 1000, 30, '2026-07-20'),  -- Laura vend du Café
(10, 2, 1400, 25, '2026-07-21'),  -- Marie vend des Chips
(11, 3, 1000, 40, '2026-07-20'),  -- Bako vend des Nems
(12, 5, 800,  30, '2026-07-20'),  -- Marc vend des Cacahuètes
(15, 6, 1500, 10, '2026-07-22'),  -- Sarah vend des Yaourts
(1, 4, 6000, 8,  '2026-07-21'),  -- Paul vend aussi du Riz Henakisoa
(5, 7, 2400, 15, '2026-07-20'),  -- Eric vend aussi du Coca
(9, 8, 500,  60, '2026-07-20'),  -- Luc vend aussi des Samosas
(13, 9, 3200, 5,  '2026-07-21'),  -- Mialy vend aussi de la Tarte
(2, 10, 4800, 7,  '2026-07-20');  -- Laura vend aussi du Mine Sao