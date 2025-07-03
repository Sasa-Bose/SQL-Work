# 🦠 COVID-19 Data Analysis (SQL Project)

This project involves performing exploratory data analysis (EDA) on COVID-19 data using **SQL Server**. The data comes from *Our World in Data* and focuses on COVID deaths and vaccinations from **January 28, 2020 to December 3, 2020**.

---

## 📁 Dataset Sources

- `covid_deaths` — Daily data on COVID cases, deaths, and population.
- `covid_vaccination` — Data on COVID-19 vaccinations by location and date.

Both datasets were taken from the [Our World in Data](https://ourworldindata.org/coronavirus) public COVID dataset and stored in SQL Server.

---

## 📊 Objectives

- Analyze global trends in COVID-19 cases and deaths.
- Identify countries with the highest infection and death rates.
- Measure the impact of COVID on different continents.
- Track vaccination progress across countries.
- Create SQL views and temporary tables to support BI visualization tools.

---

## 📌 Key SQL Operations Performed

### 1. **Initial Data Exploration**
- Viewed raw data in `covid_deaths` and `covid_vaccination` tables.
- Ordered by location and date for easier analysis.

### 2. **COVID Cases & Deaths in India**
- Calculated the death percentage in India:
  - `Death Percentage = (Total Deaths / Total Cases) * 100`
- Calculated percentage of population infected:
  - `Percent Infected = (Total Cases / Population) * 100`

### 3. **Highest Infection Rate by Country**
- Identified countries with the highest infection rates relative to their populations.

### 4. **Highest Death Count per Population**
- Ranked countries by total COVID-19 deaths.
- Aggregated total deaths by continent.

### 5. **Global Trends**
- Tracked total global cases and deaths by date.
- Calculated daily death percentages globally.

### 6. **Vaccination Progress**
- Used **CTEs** (Common Table Expressions) to calculate the rolling number of people vaccinated.
- Created temporary tables to store and analyze:
  - `RollingPeopleVaccinated / Population * 100`
- Built a **SQL view** for use in BI tools (e.g., Tableau, Power BI).

---

## 📈 View for Visualization

A SQL view `PercentPopulationVaccinated` was created to simplify access for visualization tools:

- Contains data by location, date, population, and rolling vaccinated totals.
- Useful for building dashboards and tracking vaccination coverage globally.

---

## 🧠 Key Insights

- Some countries had over 10% of their population infected by December 2020.
- Death rates varied significantly by country and continent.
- Vaccination efforts started making a visible impact by late 2020.
- SQL window functions and views allowed efficient tracking of vaccination progress over time.

---

## 🛠️ Tools Used

- **SQL Server**
- **SSMS (SQL Server Management Studio)**
- **Data Source**: [Our World in Data COVID-19 Dataset](https://ourworldindata.org/coronavirus)

---

## 📌 Future Improvements

- Integrate updated COVID data for analysis beyond December 2020.
- Incorporate vaccine types and distribution efficiency.
- Build an automated ETL pipeline to refresh the SQL tables.
- Visualize the data using Power BI or Tableau dashboards.

---

## 📬 Contact

For questions or collaborations, feel free to reach out via GitHub or LinkedIn.

---
