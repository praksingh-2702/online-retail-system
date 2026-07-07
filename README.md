# Online Retail Control Engine & Relational Schema

A responsive client-side e-commerce storefront prototype backed by a rigorously normalized 3NF MySQL database design. This project focuses on solving core transactional friction by implementing strict client-side data validation alongside highly disciplined referential integrity constraints to guarantee ACID-compliant properties during simulated checkout workflows.

---

## Key Structural Features

* **3NF Normalized Schema:** Complete database architecture separating entities into distinct tables (Users, Products, Orders, and Order Items) to eliminate data redundancy and prevent operational anomalies.
* **Referential Integrity Constraints:** Systemic implementation of `PRIMARY KEY`, `UNIQUE`, and `FOREIGN KEY` constraints (with explicit `ON DELETE CASCADE` and `ON DELETE RESTRICT` rules) to safeguard data relations.
* **Real-Time State Validation:** A dynamic client-side inventory tracking architecture that monitors row constraints in real-time, preventing users from allocating resources beyond live table capabilities.
* **Isolated Transaction Simulation:** A multi-phase transaction processor that validates system state rules before executing mutational writes, successfully tracking business metrics like product search queries and aggregate liabilities.

---

## Database Architecture (3NF MySQL)

The system maps entities following third normal form conventions to ensure strict transactional safety. Many-to-many associations between core orders and product catalogs are cleanly resolved via an associative line-item ledger.



### Relational Schema Blueprint (`schema.sql`)
```sql
CREATE DATABASE IF NOT EXISTS online_retail_db;
USE online_retail_db;

-- 1. Users Entity Table
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Products Inventory Table
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    CONSTRAINT chk_stock CHECK (stock_quantity >= 0)
) ENGINE=InnoDB;

-- 3. Orders Core Table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- 4. Order Items Associative Table (Resolves Many-to-Many Relationship)
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price_at_purchase DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE RESTRICT,
    CONSTRAINT chk_qty CHECK (quantity > 0)
) ENGINE=InnoDB;

Technology Stack & Operational Control  
Data Modeling: Structured Query Language (SQL), MySQL Server Workbench  

Engine & Interactivity: Vanilla JavaScript (ES6+ Engine, Runtime Memory Arrays)

Interface Layer: Semantic HTML5, CSS3 Variables, Fluid Flexbox/Grid Console Layouts

Local Infrastructure Deployment: VS Code, Git CLI, Live Server Ecosystem

 Interface Verification Logic
The application engine utilizes memory mappings that simulate production database performance natively in the browser.

Multi-Criteria Search & Filtering
The frontend catalog view responds dynamically to search indexing inputs and category dropdown filters, running live queries against the internal array state to render updated cards instantly without interface latency.

Multi-Phase Mutation Safety
Before allowing an active allocation to drop into the checkout queue, the engine performs a pre-flight isolation assertion check. If a user tries to add an item to their cart that exceeds the live stock_quantity constraint in the inventory table, the transaction is immediately aborted, triggering a structural alert to protect domain integrity.

 Local Development Setup
To review the interactive interface or debug the operational logic script on your machine, follow these commands:

Bash
# 1. Clone the master repository branch
git clone [https://github.com/praksingh-2702/online-retail-system.git](https://github.com/praksingh-2702/online-retail-system.git)

# 2. Enter into the target root directory
cd online-retail-system

# 3. Launch the environment inside VS Code
code .
To see the database model: Open schema.sql to inspect raw syntax structures, trigger constraints, and table schemas.

To run the storefront engine: Open index.html inside VS Code, right-click, and select "Open with Live Server" to spin up an active host point on port 5500.
