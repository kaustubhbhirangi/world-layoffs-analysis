# 🗺️ World Layoff Trends Analysis (SQL + Power BI)

This project analyzes global tech layoffs using structured SQL queries and visualizes the insights using Power BI. The dataset includes information on companies, locations, dates, and the number of employees laid off. The goal is to uncover key patterns and trends in workforce reductions over time.

---

## 🔍 Project Objectives

- Analyze which companies had the most layoffs
- Identify years and months with peak layoff activity
- Examine geographic trends in layoffs
- Discover companies that laid off their entire workforce
- Generate rolling totals and yearly rankings
- Visualize insights through an interactive Power BI dashboard

---

## 🛠️ Tech Stack

- **Database**: MySQL
- **Language**: SQL
- **Visualization**: Power BI
- **Tools**: CTEs, Window Functions, Aggregates, Date Functions

---

## 📈 Key SQL Features Used

- **Data cleaning**: Removing nulls, duplicates, and formatting inconsistencies
- **Aggregate functions**: `SUM`, `MAX`, `MIN`
- **Date functions**: `YEAR()`, `SUBSTRING()`
- **Window functions**: `DENSE_RANK()`, `SUM() OVER()`
- **Common Table Expressions (CTEs)**
- **Filtering and sorting**

---

## 📊 Power BI Dashboard

An interactive Power BI dashboard was built to complement the SQL analysis. It includes:

- Yearly and monthly trends in layoffs
- Top companies by total layoffs
- Geographic heatmaps showing layoff locations
- Filters to explore data by year, location, and industry

-📎 [Click here to see dashboard preview](dashboard/dashboard_preview.png)
-📁 [Dashboard pbix file located here](dashboard)

---

## 🧠 Insights Discovered

- A few major tech companies account for a significant portion of total layoffs
- Startups often laid off 100% of their workforce, indicating business shutdowns
- Layoffs peaked in 2020, especially during Covid virus spread & lockdown
- The U.S. led in total layoffs, with some cities being more affected than others
- Full project insights available in (output/insights_summary.md)


---
## 📬 Contact

Project made by **Kaustubh Bhirangi**

For questions or collaboration, feel free to reach out:

- 📧 [kaustubh.bhirangiwork@gmail.com](mailto:your.email@example.com)
- 🔗 [http://www.linkedin.com/in/Kaustubh-Bhirangi](https://linkedin.com/in/yourprofile)
