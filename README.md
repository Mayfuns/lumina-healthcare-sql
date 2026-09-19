# Lumina — Healthcare SQL Analytics

A PostgreSQL case study analysing healthcare operations, patient journeys, readmissions, treatment costs, payments and revenue.

[View the full portfolio case study](https://mayfuns.github.io/mariam-analytics-portfolio/lumina.html)

![Lumina healthcare SQL project preview](04_results/project-preview.png)

## Project overview

Lumina brings operational, clinical and financial healthcare data together in a relational SQL workflow.

The project focuses on using PostgreSQL to answer practical questions around service utilisation, patient flow, 30-day readmissions, treatment costs, insurance, payments and revenue.

## Business question

**How can operational and financial healthcare data be queried together to identify patterns that matter for service performance?**

## Tools and SQL techniques

- PostgreSQL
- SQL
- JOINs
- GROUP BY
- HAVING
- CASE expressions
- Conditional aggregation
- Subqueries
- Date functions
- Relational data analysis

## Analysis areas

### Admissions & service use
Patient activity, utilisation and patterns in healthcare demand.

### Length of stay & recovery
Operational measures used to understand patient flow and recovery experience.

### 30-day readmissions
Repeat utilisation following discharge, analysed using date logic.

### Costs, payments & revenue
Treatment costs, insurance, payments and revenue examined alongside service activity.

## Analytical workflow

1. **Understand the schema**  
   Identify the main entities, keys and relationships across the database.

2. **Join related tables**  
   Bring together patient, admission, treatment and financial information.

3. **Aggregate and segment**  
   Use grouped summaries, conditional logic and filters to compare service and patient groups.

4. **Interpret patterns**  
   Translate query outputs into operational and financial findings.

## SQL capabilities demonstrated

- Connecting related healthcare tables with JOIN operations.
- Using GROUP BY and HAVING for service-level and category-level analysis.
- Applying CASE expressions and conditional aggregation to build analytical categories.
- Using subqueries to answer multi-stage questions.
- Applying date functions for length of stay and 30-day readmission analysis.

## Repository structure

```text
01_sql/
  ├── analysis.sql
  ├── readmissions.sql
  ├── financial-analysis.sql
  └── README.md

02_database/
  ├── schema.sql
  ├── relationships.md
  └── README.md

03_data/
  ├── source / sample data where redistribution is permitted
  └── data-dictionary.md

04_results/
  ├── query-output screenshots
  └── project-preview.png

05_documentation/
  ├── methodology.md
  └── project-notes.md
```

## Decision-support perspective

The value of this project is in connecting operational and financial questions rather than reporting them separately. Admissions, patient outcomes, treatment costs, insurance and revenue can be analysed within one relational workflow to surface areas that deserve further investigation.

## Portfolio

- [Portfolio homepage](https://mayfuns.github.io/mariam-analytics-portfolio/)
- [Lumina full case study](https://mayfuns.github.io/mariam-analytics-portfolio/lumina.html)
- [GitHub profile](https://github.com/Mayfuns)

---

**Mariam Adetoyi**  
Data Analyst | SQL | Healthcare Analytics
