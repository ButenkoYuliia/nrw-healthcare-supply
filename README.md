# Where Are GPs Missing in NRW?

Regional analysis of healthcare supply across the **53 districts (Kreise and kreisfreie Städte) of North Rhine-Westphalia**: general practitioners (Hausärzte), specialists, pediatricians and hospital beds, 2015–2024.

[![Tableau dashboard](https://public.tableau.com/static/images/NR/NRWHealthcareSupply/NRWHealthcare/1.png)](https://public.tableau.com/views/NRWHealthcareSupply/NRWHealthcare)

## Links

- 📊 **Tableau dashboard:** [Where Are GPs Missing in NRW?](https://public.tableau.com/views/NRWHealthcareSupply/NRWHealthcare)
- 📓 **Analysis notebook:** [nrw_healthcare_analysis.ipynb](nrw_healthcare_analysis.ipynb) · [open in Colab](https://colab.research.google.com/github/ButenkoYuliia/nrw-healthcare-supply/blob/main/nrw_healthcare_analysis.ipynb)
- 🗄️ **SQL queries (BigQuery):** [sql/](sql/)

## Business question

Where in NRW is the supply of GPs, specialists and hospital beds lowest, how has it changed since 2015, and which districts should be prioritised for support?

**Audience:** health insurers, Kassenärztliche Vereinigungen, hospital planners and municipalities.

## Data

Source: **INKAR**, Federal Institute for Research on Building, Urban Affairs and Spatial Development (BBSR), Bonn. *Laufende Raumbeobachtung des BBSR, Ausgabe 07/2025.*

| Indicator | Unit | Years |
|---|---|---|
| All doctors, GPs (Hausärzte), general practitioners, internists | per 10,000 residents | 2015–2024 |
| Pediatricians | per 10,000 children under 15 | 2015–2024 |
| Hospital beds | per 1,000 residents | 2004–2022 |
| Population | residents | 1995–2023 |

District type: **urban** = kreisfreie Städte and Städteregion Aachen (22), **rural** = Kreise (31).

## Method

1. **Data preparation:** INKAR export (wide, one column per indicator and year) reshaped into long format, loaded into **Google BigQuery**.
2. **SQL** ([sql/](sql/)): cleaning (restoring leading zeros in district codes), pivot to one row per district and year, GP ranking, urban vs rural comparison, risk zones, Düsseldorf vs NRW, correlations.
3. **Python** (pandas, SciPy, seaborn):
   - trends 2015–2024 for urban and rural districts;
   - **Mann-Whitney U test** for urban vs rural differences;
   - **Wilcoxon signed-rank test** for the 2015 → 2024 change in GP supply;
   - correlation matrix of all indicators.
4. **Risk zones:** districts whose GP supply in 2024 is below the NRW median **and** lower than in 2015.
5. **Tableau:** district map, ranking with median line, risk-zone table, key findings.

## Key findings

| | |
|---|---|
| GP supply range (2024) | **4.3** (Herne) to **7.2** (Leverkusen) per 10,000 residents, a gap of 1.7× |
| Risk-zone districts | **19 of 53**, home to **~6.0 million people (33 % of NRW)** |
| Districts with fewer GPs than in 2015 | **30 of 53** (median change −2.4 %) |
| Sharpest declines | Lippe −22 %, Krefeld −21 %, Hochsauerlandkreis −20 %, Mönchengladbach −19 %, Herne −18 % |

- **Low GP supply is not only a rural problem.** The weakest districts mix Ruhr cities (Herne, Gelsenkirchen, Duisburg) and rural districts (Lippe, Hochsauerlandkreis, Wesel).
- **Urban and rural districts no longer differ in GP supply** (median 5.86 vs 5.73, Mann-Whitney p = 0.89). Urban districts lost GPs faster after 2015.
- **Cities still have far more specialists and hospital capacity:** all doctors 16.3 vs 12.7, pediatricians 6.5 vs 4.4, hospital beds 8.2 vs 5.3 per 1,000 (all p < 0.01), partly because they serve neighbouring districts.
- **The decline is concentrated, not universal:** across all 53 districts the 2015 → 2024 change is not statistically significant (Wilcoxon p = 0.11), but a group of districts lost 10–22 %.
- **GP supply is unrelated to hospital beds** (r = 0.09). Specialists cluster where hospitals are (all doctors ↔ beds r = 0.54); pediatricians follow overall doctor density (r = 0.90).
- **Düsseldorf:** GP supply fell from 6.53 to 6.06 per 10,000 (−7 %), still above the NRW median; hospital beds fell from 8.3 to 6.9 per 1,000 between 2015 and 2022 (−17 %).

## Recommendations

- Prioritise GP recruitment support (funding for new practices, Weiterbildung in Allgemeinmedizin) in the **19 risk-zone districts**, starting with Lippe, Herne, Hochsauerlandkreis, Krefeld and Mönchengladbach.
- Include **Ruhr cities** in support programmes, not only rural areas.
- Plan GP supply **separately from hospital capacity**, since the two are not linked.

## Limitations

- INKAR values are district averages; differences within a district (e.g. between city quarters) are not visible.
- Doctor counts are headcounts, not full-time equivalents, and do not include doctors' age, so upcoming retirements are not reflected.
- Hospital beds are counted at the hospital's location, so cities look better supplied partly because they serve patients from surrounding districts.

## Tools

Google BigQuery (SQL) · Python (pandas, NumPy, SciPy, matplotlib, seaborn) · Google Colab · Tableau Public

## Repository structure

```
├── nrw_healthcare_analysis.ipynb     # analysis notebook
├── sql/                              # BigQuery queries 00–06
├── data/
│   ├── raw/inkar_kreise_nrw.csv      # original INKAR export
│   ├── nrw_healthcare_long.csv       # long format (loaded into BigQuery)
│   ├── nrw_supply_wide.csv           # one row per district and year
│   └── nrw_tableau_districts.csv     # one row per district, used in Tableau
└── README.md
```

## Author

**Yuliia Butenko** · Data Analyst with a background in clinical nursing · [GitHub](https://github.com/ButenkoYuliia) · [Tableau Public](https://public.tableau.com/app/profile/yuliia.butenko/vizzes)
