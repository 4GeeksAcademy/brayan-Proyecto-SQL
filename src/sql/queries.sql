-- queries.sql
-- Complete each mission by writing your SQL query below the instructions.
-- Don't forget to end each query with a semicolon ;

SELECT * FROM regions;
SELECT * FROM species;
SELECT * FROM climate;
SELECT * FROM observations;


-- MISSION 1
-- Your query here
-- Misión 1: Regiones con mayor biodiversidad (join para combinar tablas observations, species y regions)

SELECT regions.name, regions.country, COUNT(DISTINCT species.id) AS total_species
FROM observations
JOIN species ON observations.species_id = species.id
JOIN regions ON observations.region_id = regions.id
GROUP BY regions.name, regions.country
ORDER BY total_species DESC;

-- MISSION 2
-- Your query here:
-- Misión 2: Meses con mayor actividad de observación (strftime para extraer el mes de la fecha de observacion)

SELECT strftime('%m', observations.observation_date) AS month, COUNT(*) AS total
FROM observations
GROUP BY month
ORDER BY total DESC;

-- MISSION 3
-- Your query here:
-- Misión 3: Especies poco registradas (HAVING para filtrar las especies con menos de 5 individuos observados)


SELECT species.scientific_name, species.common_name, SUM(observations.count) AS total_count
FROM observations
JOIN species ON observations.species_id = species.id
GROUP BY species.id
HAVING total_count < 5
ORDER BY total_count ASC;

-- MISSION 4
-- Your query here:
-- Misión 4: Región con más especies distintas observadas (LIMIT 1 para obtener solo la región con más especies distintas observadas)

SELECT regions.name, regions.country, COUNT(DISTINCT observations.species_id) AS species_count
FROM observations
JOIN regions ON observations.region_id = regions.id
GROUP BY regions.name, regions.country
ORDER BY species_count DESC
LIMIT 1;

-- MISSION 5
-- Your query here:
-- Misión 5: Especies más observadas (LIMIT 10 para obtener solo las 10 especies mas observada)

SELECT species.scientific_name, species.common_name, COUNT(*) AS total_observations
FROM observations
JOIN species ON observations.species_id = species.id
GROUP BY species.id
ORDER BY total_observations DESC
LIMIT 10;

-- MISSION 6
-- Your query here:
-- Misión 6: Observadores mas activos 

SELECT observations.observer, COUNT(*) AS total
FROM observations
GROUP BY observations.observer
ORDER BY total DESC
LIMIT 10;

-- MISSION 7
-- Your query here:
-- Misión 7: Especies nunca observadas (LEFT JOIN para obtener las especies que no tienen observaciones)

SELECT species.scientific_name, species.common_name
FROM species
LEFT JOIN observations ON species.id = observations.species_id
WHERE observations.species_id IS NULL;

-- MISSION 8
-- Your query here:
-- Misión 8: Fechas con más especies distintas observadas 

SELECT observations.observation_date, COUNT(DISTINCT observations.species_id) AS distinct_species
FROM observations
GROUP BY observations.observation_date
ORDER BY distinct_species DESC
LIMIT 10;
