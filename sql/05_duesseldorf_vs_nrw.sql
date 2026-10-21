-- Düsseldorf compared with the NRW district average, 2015-2024
WITH nrw AS (
  SELECT
    year,
    ROUND(AVG(gps), 2)           AS nrw_gps,
    ROUND(AVG(doctors), 2)       AS nrw_doctors,
    ROUND(AVG(hospital_beds), 2) AS nrw_beds
  FROM `medical-analytics-511709.nrw_healthcare.supply_wide`
  GROUP BY year
)
SELECT
  w.year,
  w.gps            AS dus_gps,
  n.nrw_gps,
  w.doctors        AS dus_doctors,
  n.nrw_doctors,
  w.hospital_beds  AS dus_beds,
  n.nrw_beds
FROM `medical-analytics-511709.nrw_healthcare.supply_wide` AS w
JOIN nrw AS n USING (year)
WHERE w.ags = '05111'
  AND w.year BETWEEN 2015 AND 2024
ORDER BY w.year;
