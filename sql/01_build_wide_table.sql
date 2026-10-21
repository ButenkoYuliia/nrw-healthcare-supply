-- Pivot long format into one row per district and year
CREATE OR REPLACE TABLE `medical-analytics-511709.nrw_healthcare.supply_wide` AS
SELECT
  ags,
  kreis,
  kreis_type,
  year,
  MAX(IF(indicator = 'doctors_per_10000', value, NULL))                AS doctors,
  MAX(IF(indicator = 'gps_per_10000', value, NULL))                    AS gps,
  MAX(IF(indicator = 'general_practitioners_per_10000', value, NULL))  AS general_practitioners,
  MAX(IF(indicator = 'internists_per_10000', value, NULL))             AS internists,
  MAX(IF(indicator = 'pediatricians_per_10000_children', value, NULL)) AS pediatricians,
  MAX(IF(indicator = 'hospital_beds_per_1000', value, NULL))           AS hospital_beds,
  MAX(IF(indicator = 'population', value, NULL))                       AS population
FROM `medical-analytics-511709.nrw_healthcare.supply`
GROUP BY ags, kreis, kreis_type, year;
