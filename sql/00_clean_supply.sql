-- Restore leading zeros in district codes (AGS) and fix data types
CREATE OR REPLACE TABLE `medical-analytics-511709.nrw_healthcare.supply` AS
SELECT
  LPAD(CAST(ags AS STRING), 5, '0') AS ags,
  kreis,
  indicator,
  CAST(year AS INT64) AS year,
  CAST(value AS FLOAT64) AS value,
  kreis_type
FROM `medical-analytics-511709.nrw_healthcare.supply_long`;
