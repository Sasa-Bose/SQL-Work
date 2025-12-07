# 🔐 RBAC Auth System  
### A Complete Role-Based Access Control & User Management Database (SQL Server)

## 📌 Overview
**RBAC Auth System** is a structured SQL Server–based authentication and authorization system built using the principles of Role-Based Access Control (RBAC).  
It manages users, roles, permissions, and login activity while providing secure stored procedures for user creation, permission retrieval, and login auditing.

This project is ideal for backend applications requiring a robust authentication and authorization foundation.

---

## 🗄️ Database Structure

### 📁 Database
`Auth_System`

### 🧩 Tables Overview

#### **1. roles**
Stores system roles such as admin, user, and moderator.

#### **2. permissions**
Defines granular permissions such as reading users, managing roles, etc.

#### **3. role_permissions**
Many-to-many relationship table connecting roles and permissions.

#### **4. users**
Stores user account information including username, email, password hash, assigned role, and activity status.

#### **5. login_log**
Tracks login activity including:
- User ID  
- Timestamp  
- IP Address  
- User Agent  
- Success / Failure status  

---

## 🔑 Key Features

### ✔️ Role-Based Access Control (RBAC)
- Roles (admin, user, moderator)
- Permissions for each role
- Users inherit permissions through role assignments

### ✔️ Idempotent Seed Data
The script includes checks to prevent duplicate insertion of:
- Default roles  
- Default permissions  
- Role–permission mappings  

### ✔️ Performance Indexing
Indexes implemented for:
- Usernames  
- Emails  
- Login times  
- User ID lookups  

---

## 🔧 Stored Procedures & Their Purpose

### **1. `sp_log_login`**
- Logs every login attempt into the `login_log` table.  
- Stores success/failure, IP address, timestamp, and user agent.  
- Useful for auditing and security monitoring.

### **2. `sp_get_user_permissions`**
- Retrieves all permissions assigned to a user through their role.  
- Ensures permission resolution is centralized and consistent.  
- Useful for backend authorization checks.

### **3. `sp_create_user`**
- Securely creates a new user inside a transaction.  
- Ensures safe insertion of username, email, password hash, and role.  
- Returns the ID of the newly created user.  
- Ensures rollback on errors.

---


---

## 🚀 How to Use
1. Run the SQL file to create the database, tables, relationships, indexes, seed data, and stored procedures.  
2. Use stored procedures to:
   - Create new users  
   - Retrieve user permissions  
   - Log login activity  
3. Integrate with any backend system such as:
   - Python  
   - Node.js  
   - Java  
   - .NET  

---

## 🎯 Project Highlights
- Clean RBAC schema  
- Secure procedure-driven system  
- Idempotent database script  
- Built-in auditing  
- Scalable design for real-world applications  

---

## 📜 License
Open-source — modify and use freely.



