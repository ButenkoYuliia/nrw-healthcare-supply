-- 10 districts with the fewest GPs (Hausärzte) per 10,000 residents in 2024
WITH gp AS (
  SELECT
    kreis,
    kreis_type,
    MAX(IF(year = 2015, gps, NULL)) AS gps_2015,
    MAX(IF(year = 2024, gps, NULL)) AS gps_2024
  FROM `medical-analytics-511709.nrw_healthcare.supply_wide`
  GROUP BY kreis, kreis_type
)
SELECT
  RANK() OVER (ORDER BY gps_2024) AS rank_lowest,
  kreis,
  kreis_type,
  gps_2015,
  gps_2024,
  ROUND((gps_2024 - gps_2015) / gps_2015 * 100, 1) AS change_pct
FROM gp
ORDER BY gps_2024
LIMIT 10;
