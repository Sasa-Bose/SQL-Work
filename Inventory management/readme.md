# 📦 Inventory Management System

## 📌 Overview
The **Inventory Management System** is a complete end-to-end application built using **MySQL** for backend database management and **Streamlit** for frontend interaction.  
The system allows users to manage categories, suppliers, products, purchases, and sales, while also generating a Monthly Sales Report.  
All database operations are validated and automated using triggers, ensuring accurate real-time inventory updates.

---

## 🧩 Database Design

### 📘 ER Diagram Description
The ER model (see `inventory_management.jpg`) includes the following tables:

- **Products**  
  Central table connected to all others.

- **Categories → Products**  
  - *One-to-Many*  
  - Each Category can have many Products.

- **Suppliers → Products**  
  - *One-to-Many*  
  - A Supplier can supply multiple Products.

- **Products → Sales**  
  - *One-to-Many*  
  - A Product can appear in multiple Sales records.

- **Products → Purchases**  
  - *One-to-Many*  
  - A Product can appear in multiple Purchases.

- **Suppliers → Purchases**  
  - *One-to-Many*  
  - A Supplier can have multiple Purchase transactions.

This design ensures a clean, normalized structure suitable for inventory tracking.

---

## 🗄️ MySQL Implementation

### 🏗️ Tables & Relationships
All tables were created according to the ER diagram, including:

- `categories`  
- `suppliers`  
- `products`  
- `purchases`  
- `sales`  

Each table includes appropriate primary keys, foreign keys, constraints, and relationships.

### ⚙️ SQL Triggers
The system utilizes triggers to keep inventory accurate:

- **`before_sale_insert`**  
  Validates or adjusts data before a sale record is inserted.

- **`after_sale_insert`**  
  Automatically updates product stock after a sale.

- **`after_purchase_insert`**  
  Updates product stock when new inventory is purchased.

These ensure data integrity and minimize manual updates.

### 📊 SQL View
A dedicated view is created for analytics:

- **`monthly_sales_report`**  
  Generates aggregated monthly sales totals used in the Streamlit report.

### 🧪 Testing
Dummy data was inserted into all tables to validate:
- Trigger execution  
- View functionality  
- Relationship constraints  

All tests passed successfully.

### 📁 SQL File
All database creation scripts, triggers, relationships, and test inserts are stored in:
inventory_management.sql

---

## 🖥️ Streamlit Web Application

### 🚀 Technologies Used
- **Streamlit** – User interface  
- **mysql-connector-python** – Database connectivity  
- **pandas** – Data handling & display  

### 📄 Main Application File
app.py
Contains UI pages, CRUD operations, and database interaction logic.

---

## 🔧 Features Available in the UI

### 📂 Category Management
- View Categories  
- Add Category  
- Update Category  
- Delete Category  

### 🚚 Supplier Management
- View Suppliers  
- Add Supplier  
- Update Supplier  
- Delete Supplier  

### 🛒 Product Management
- View Products  
- Add Product  
- Update Product  
- Delete Product  

### 📥 Purchase Management
- View Purchases  
- Add Purchase  
- Update Purchase  
- Delete Purchase  

### 📤 Sales Management
- View Sales  
- Add Sale  
- Update Sale  
- Delete Sale  
(Triggers automatically adjust stock levels.)

### 📈 Reports
- **Monthly Sales Report**  
  Uses the SQL View `monthly_sales_report` to display aggregated results.

---

## 🧭 How to Use
1. Run the MySQL scripts from `inventory_management.sql`.  
2. Ensure the MySQL server is running.  
3. Install required Python libraries:  
   ```bash
   pip install streamlit mysql-connector-python pandas
4. Run the application app.py

---

## Project Highlights
Clean relational database & ER modeling
Automated inventory control using triggers
Fully functional CRUD operations
Real-time interaction through Streamlit
Analytical reporting via SQL Views
Modular and scalable design


