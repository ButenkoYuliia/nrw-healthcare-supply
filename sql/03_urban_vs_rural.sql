-- Average supply in urban (kreisfreie Städte) vs rural districts per year
SELECT
  year,
  kreis_type,
  COUNT(*) AS kreise,
  ROUND(AVG(gps), 2)           AS avg_gps,
  ROUND(AVG(doctors), 2)       AS avg_doctors,
  ROUND(AVG(pediatricians), 2) AS avg_pediatricians,
  ROUND(AVG(hospital_beds), 2) AS avg_hospital_beds
FROM `medical-analytics-511709.nrw_healthcare.supply_wide`
WHERE year BETWEEN 2015 AND 2024
GROUP BY year, kreis_type
ORDER BY year, kreis_type;
