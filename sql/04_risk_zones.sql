-- Risk zones: GP supply below the NRW median in 2024 AND lower than in 2015
WITH gp AS (
  SELECT
    kreis,
    kreis_type,
    MAX(IF(year = 2015, gps, NULL)) AS gps_2015,
    MAX(IF(year = 2024, gps, NULL)) AS gps_2024,
    MAX(IF(year = 2023, population, NULL)) AS population_2023
  FROM `medical-analytics-511709.nrw_healthcare.supply_wide`
  GROUP BY kreis, kreis_type
),
median AS (
  SELECT APPROX_QUANTILES(gps_2024, 2)[OFFSET(1)] AS median_gps
  FROM gp
)
SELECT
  kreis,
  kreis_type,
  gps_2015,
  gps_2024,
  ROUND((gps_2024 - gps_2015) / gps_2015 * 100, 1) AS change_pct,
  CAST(population_2023 AS INT64) AS population_2023,
  ROUND(median_gps, 2) AS nrw_median
FROM gp, median
WHERE gps_2024 < median_gps
  AND gps_2024 < gps_2015
ORDER BY change_pct;
