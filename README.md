# SQL Script: ySQL-Over-300-lLnes-of-Codes-Project
## 📄 Description
This SQL script performs [brief summary — e.g., "data aggregation and ranking for job titles such as Data Analyst and Senior Data Analyst using window functions"]. It extracts distinct combinations of job titles and custom fields, calculates frequencies, and uses window functions to provide insights such as rankings and totals.

## 🧰 Requirements
- Database: MySQL
- Schema/Table: Assumes existence of `luke.luke_excel_sql` table
- Required columns:
  - `job_title_short`
  - `custom`

## 🚀 How to Run
1. Open your SQL editor or database tool
2. Connect to the database containing the `luke.luke_excel_sql` table.
3. Execute the script.
4. View results ordered by custom count and optionally filtered by job title.

## ✨ Features
- Uses `GROUP BY` and `COUNT()` to aggregate results
- Includes `WINDOW FUNCTIONS` such as:
  - `SUM(...) OVER (...)` for total counts
  - `RANK() OVER (...)` for ranking `custom` values
- Filterable by job titles of interest

## 📌 Notes
- Make sure your database supports window functions.
- You may adjust the `LIMIT` clause depending on your data volume.
- Replace `"Senior Data Analyst"` or `"Data Analyst"` with your desired job titles to generalize.

## 📂 File Contents
- `your_script.sql`: Main SQL script

## ✍️ Author
Adejare Oluwasegun Samuel
## 📅 Last Updated
June 30, 2025
