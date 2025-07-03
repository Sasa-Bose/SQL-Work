# 🏠 Nashville Housing Data Cleaning Project (SQL)

This project focuses on cleaning and preparing the **Nashville Housing** dataset for further analysis and visualization. Using SQL Server, the raw data was cleaned, standardized, and transformed to improve data quality and usability.

---

## 📁 Dataset

- **Source:** Nashville Housing Dataset
- **Table Name:** `PortfolioProject.dbo.NashvilleHousing`
- **Content:** Real estate transaction records including property addresses, sale dates, prices, ownership details, and legal references.

---

## 🎯 Objectives

- Standardize inconsistent data formats
- Fill in missing values using logical assumptions
- Break down and structure complex fields (e.g., addresses)
- Normalize categorical fields (e.g., "Y" → "Yes")
- Identify and handle duplicate records
- Prepare the data for analysis and visualization

---

## 🛠️ SQL Data Cleaning Steps

### 1. ✅ Standardizing Date Format

- Converted `SaleDate` to standard `DATE` format.
- Created a new column `SaleDateConverted` to avoid overwriting raw data.

---

### 2. 🏷️ Filling Missing Property Addresses

- Used a **self join** on `ParcelID` to fill missing `PropertyAddress` values from other rows with the same `ParcelID`.
- Assumed that properties with identical `ParcelID` share the same address.

---

### 3. 📦 Splitting Address Columns

- Split `PropertyAddress` into:
  - `PropertySplitAddress`
  - `PropertySplitCity`

- Split `OwnerAddress` into:
  - `OwnerSplitAddress`
  - `OwnerSplitCity`
  - `OwnerSplitState`

This made it easier to filter and analyze data by individual location components.

---

### 4. ✔️ Standardizing "SoldAsVacant" Values

- Cleaned up inconsistent categorical values in the `SoldAsVacant` column:
  - Replaced `"Y"` with `"Yes"` and `"N"` with `"No"`

---

### 5. 🧹 Removing Duplicates

- Used a **CTE with `ROW_NUMBER()`** to identify duplicate rows based on:
  - `ParcelID`, `PropertyAddress`, `SalePrice`, `SaleDate`, `LegalReference`
- Filtered out rows where `row_num > 1`, flagging them as duplicates.
- Suggested creating a temporary table or backup before deletion for safety.

---

### 6. 🗂️ Removing Unused Columns

- Recommended dropping unnecessary columns like:
  - `OwnerAddress`, `TaxDistrict`, `PropertyAddress`, and `SaleDate`
- Emphasized **not modifying original raw data**, and to make changes on a working copy.

---

## 🧠 Key Insights

- Data cleaning ensures consistency and accuracy, especially when preparing data for BI dashboards.
- Address parsing and formatting improves location-based analysis.
- Using SQL window functions like `ROW_NUMBER()` is powerful for identifying duplicates.
- Maintaining raw data integrity is essential — all changes were done on derived columns.

---

## 🛠️ Tools Used

- **SQL Server**
- **SQL Server Management Studio (SSMS)**
- **CTEs**, **Window Functions**, and **String Functions**

---

## 📌 Future Improvements

- Add validations to check address parsing accuracy.
- Automate cleaning with stored procedures or ETL tools.
- Export cleaned data into Power BI or Tableau for visualization.
- Build a data pipeline to handle updated datasets in real-time.
