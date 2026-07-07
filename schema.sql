-- ===================================================
-- ONLINE RETAIL SYSTEM DATABASE ARCHITECTURE (3NF)
-- Enforces data integrity, entity relations, and constraints
-- ===================================================

CREATE DATABASE IF NOT EXISTS online_retail_db;
USE online_retail_db;

-- Users Entity
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- Products Catalog Entity
CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    stock_quantity INT NOT NULL,
    CONSTRAINT chk_stock CHECK (stock_quantity >= 0)
) ENGINE=InnoDB;

-- Orders Entity
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    total_amount DECIMAL(10, 2) NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Order Items Association Entity (Resolves Many-to-Many Relation)
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

-- Initial Database Seeding
INSERT INTO users (name, email) VALUES ('Demo Client', 'demo@manipal.edu');

INSERT INTO products (title, category, price, stock_quantity) VALUES
('Premium Mechanical Keyboard', 'Electronics', 85.00, 4),
('Ergonomic Wireless Mouse', 'Electronics', 25.00, 8),
('Ultra-Light Running Shoes', 'Apparel', 120.00, 2),
('Minimalist Leather Wallet', 'Apparel', 45.00, 12),
('Insulated Travel Mug', 'Kitchen', 18.50, 25);

