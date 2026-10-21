-- Correlations between supply indicators across the 53 districts (2022)
SELECT
  ROUND(CORR(gps, hospital_beds), 2)       AS corr_gps_beds,
  ROUND(CORR(doctors, hospital_beds), 2)   AS corr_doctors_beds,
  ROUND(CORR(gps, doctors), 2)             AS corr_gps_doctors,
  ROUND(CORR(pediatricians, doctors), 2)   AS corr_pediatricians_doctors,
  COUNT(*)                                 AS kreise
FROM `medical-analytics-511709.nrw_healthcare.supply_wide`
WHERE year = 2022;
