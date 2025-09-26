-- ======================
-- 1. Customers
-- ======================
CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100),
    phone VARCHAR(20),
    segment_id INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON COLUMN customers.customer_id IS 'Unique identifier for each customer';
COMMENT ON COLUMN customers.first_name IS 'Customer first name';
COMMENT ON COLUMN customers.last_name IS 'Customer last name';
COMMENT ON COLUMN customers.date_of_birth IS 'Date of birth of the customer';
COMMENT ON COLUMN customers.email IS 'Email address of the customer';
COMMENT ON COLUMN customers.phone IS 'Contact phone number of the customer';
COMMENT ON COLUMN customers.segment_id IS 'Foreign key referencing customer_segments';
COMMENT ON COLUMN customers.created_at IS 'Timestamp when the customer record was created';

-- ======================
-- 2. Accounts
-- ======================
CREATE TABLE accounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id),
    account_type_id INT,
    balance NUMERIC(18,2) DEFAULT 0,
    currency_code CHAR(3) NOT NULL,
    opened_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON COLUMN accounts.account_id IS 'Unique identifier for each account';
COMMENT ON COLUMN accounts.customer_id IS 'Foreign key referencing customers table';
COMMENT ON COLUMN accounts.account_type_id IS 'Foreign key referencing account_types table';
COMMENT ON COLUMN accounts.balance IS 'Current balance of the account';
COMMENT ON COLUMN accounts.currency_code IS 'ISO currency code of the account';
COMMENT ON COLUMN accounts.opened_at IS 'Timestamp when the account was opened';

-- ======================
-- 3. Branches
-- ======================
CREATE TABLE branches (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(100) NOT NULL,
    region_id INT,
    manager_id INT,
    address VARCHAR(200)
);

COMMENT ON COLUMN branches.branch_id IS 'Unique identifier for each branch';
COMMENT ON COLUMN branches.branch_name IS 'Name of the bank branch';
COMMENT ON COLUMN branches.region_id IS 'Foreign key referencing regions table';
COMMENT ON COLUMN branches.manager_id IS 'Employee ID of branch manager';
COMMENT ON COLUMN branches.address IS 'Physical address of the branch';

-- ======================
-- 4. Currencies
-- ======================
CREATE TABLE currencies (
    currency_code CHAR(3) PRIMARY KEY,
    currency_name VARCHAR(50),
    symbol VARCHAR(10)
);

COMMENT ON COLUMN currencies.currency_code IS 'ISO 4217 currency code (e.g., INR, USD)';
COMMENT ON COLUMN currencies.currency_name IS 'Full name of the currency';
COMMENT ON COLUMN currencies.symbol IS 'Currency symbol';

-- ======================
-- 5. Products
-- ======================
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    product_type VARCHAR(50),
    interest_rate NUMERIC(5,2),
    fee_id INT
);

COMMENT ON COLUMN products.product_id IS 'Unique identifier for each financial product';
COMMENT ON COLUMN products.product_name IS 'Name of the financial product';
COMMENT ON COLUMN products.product_type IS 'Category of product (Deposit, Loan, Insurance)';
COMMENT ON COLUMN products.interest_rate IS 'Interest rate associated with product';
COMMENT ON COLUMN products.fee_id IS 'Foreign key referencing fees table';

-- ======================
-- 6. Employees
-- ======================
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role VARCHAR(50),
    branch_id INT REFERENCES branches(branch_id),
    hire_date DATE
);

COMMENT ON COLUMN employees.employee_id IS 'Unique identifier for each employee';
COMMENT ON COLUMN employees.first_name IS 'First name of the employee';
COMMENT ON COLUMN employees.last_name IS 'Last name of the employee';
COMMENT ON COLUMN employees.role IS 'Job role or designation of the employee';
COMMENT ON COLUMN employees.branch_id IS 'Branch where employee works';
COMMENT ON COLUMN employees.hire_date IS 'Date the employee was hired';

-- ======================
-- 7. Merchants
-- ======================
CREATE TABLE merchants (
    merchant_id SERIAL PRIMARY KEY,
    merchant_name VARCHAR(100),
    category VARCHAR(50),
    country_code CHAR(2)
);

COMMENT ON COLUMN merchants.merchant_id IS 'Unique identifier for each merchant';
COMMENT ON COLUMN merchants.merchant_name IS 'Name of the merchant';
COMMENT ON COLUMN merchants.category IS 'Business category of the merchant (e.g., Retail, E-commerce)';
COMMENT ON COLUMN merchants.country_code IS 'Foreign key referencing countries table';

-- ======================
-- 8. Payment Methods
-- ======================
CREATE TABLE payment_methods (
    method_id SERIAL PRIMARY KEY,
    method_name VARCHAR(50)
);

COMMENT ON COLUMN payment_methods.method_id IS 'Unique identifier for each payment method';
COMMENT ON COLUMN payment_methods.method_name IS 'Name of payment method (Card, UPI, NetBanking)';

-- ======================
-- 9. Loan Types
-- ======================
CREATE TABLE loan_types (
    loan_type_id SERIAL PRIMARY KEY,
    loan_type_name VARCHAR(50),
    max_tenure_months INT,
    base_interest_rate NUMERIC(5,2)
);

COMMENT ON COLUMN loan_types.loan_type_id IS 'Unique identifier for loan type';
COMMENT ON COLUMN loan_types.loan_type_name IS 'Name of the loan type (Home Loan, Car Loan)';
COMMENT ON COLUMN loan_types.max_tenure_months IS 'Maximum tenure allowed in months';
COMMENT ON COLUMN loan_types.base_interest_rate IS 'Base interest rate for this loan type';

-- ======================
-- 10. Cards
-- ======================
CREATE TABLE cards (
    card_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    card_number VARCHAR(16) UNIQUE,
    card_type VARCHAR(50),
    expiry_date DATE
);

COMMENT ON COLUMN cards.card_id IS 'Unique identifier for each card';
COMMENT ON COLUMN cards.account_id IS 'Foreign key referencing accounts table';
COMMENT ON COLUMN cards.card_number IS 'Unique card number';
COMMENT ON COLUMN cards.card_type IS 'Type of card (Credit, Debit)';
COMMENT ON COLUMN cards.expiry_date IS 'Expiration date of the card';

-- ======================
-- 11. Transaction Channels
-- ======================
CREATE TABLE transaction_channels (
    channel_id SERIAL PRIMARY KEY,
    channel_name VARCHAR(50)
);

COMMENT ON COLUMN transaction_channels.channel_id IS 'Unique identifier for transaction channel';
COMMENT ON COLUMN transaction_channels.channel_name IS 'Name of transaction channel (ATM, Mobile, POS)';

-- ======================
-- 12. Regions
-- ======================
CREATE TABLE regions (
    region_id SERIAL PRIMARY KEY,
    region_name VARCHAR(50),
    country_code CHAR(2)
);

COMMENT ON COLUMN regions.region_id IS 'Unique identifier for region';
COMMENT ON COLUMN regions.region_name IS 'Name of the region (e.g., West India)';
COMMENT ON COLUMN regions.country_code IS 'Foreign key referencing countries table';

-- ======================
-- 13. Countries
-- ======================
CREATE TABLE countries (
    country_code CHAR(2) PRIMARY KEY,
    country_name VARCHAR(100)
);

COMMENT ON COLUMN countries.country_code IS 'ISO 3166-1 alpha-2 country code';
COMMENT ON COLUMN countries.country_name IS 'Full country name';

-- ======================
-- 14. Account Types
-- ======================
CREATE TABLE account_types (
    account_type_id SERIAL PRIMARY KEY,
    type_name VARCHAR(50),
    description VARCHAR(200)
);

COMMENT ON COLUMN account_types.account_type_id IS 'Unique identifier for account type';
COMMENT ON COLUMN account_types.type_name IS 'Name of account type (Savings, Current)';
COMMENT ON COLUMN account_types.description IS 'Description of the account type';

-- ======================
-- 15. Customer Segments
-- ======================
CREATE TABLE customer_segments (
    segment_id SERIAL PRIMARY KEY,
    segment_name VARCHAR(50),
    description VARCHAR(200)
);

COMMENT ON COLUMN customer_segments.segment_id IS 'Unique identifier for customer segment';
COMMENT ON COLUMN customer_segments.segment_name IS 'Name of the customer segment (Retail, Corporate)';
COMMENT ON COLUMN customer_segments.description IS 'Description of the segment';

-- ======================
-- 16. Risk Categories
-- ======================
CREATE TABLE risk_categories (
    risk_id SERIAL PRIMARY KEY,
    risk_level VARCHAR(50),
    description VARCHAR(200)
);

COMMENT ON COLUMN risk_categories.risk_id IS 'Unique identifier for risk category';
COMMENT ON COLUMN risk_categories.risk_level IS 'Risk level (Low, Medium, High)';
COMMENT ON COLUMN risk_categories.description IS 'Description of the risk category';

-- ======================
-- 17. Regulatory Codes
-- ======================
CREATE TABLE regulatory_codes (
    code_id SERIAL PRIMARY KEY,
    code_name VARCHAR(50),
    description VARCHAR(200)
);

COMMENT ON COLUMN regulatory_codes.code_id IS 'Unique identifier for regulatory code';
COMMENT ON COLUMN regulatory_codes.code_name IS 'Short name/code of regulation';
COMMENT ON COLUMN regulatory_codes.description IS 'Description of the regulatory requirement';

-- ======================
-- 18. Transaction Statuses
-- ======================
CREATE TABLE transaction_statuses (
    status_id SERIAL PRIMARY KEY,
    status_name VARCHAR(50)
);

COMMENT ON COLUMN transaction_statuses.status_id IS 'Unique identifier for transaction status';
COMMENT ON COLUMN transaction_statuses.status_name IS 'Name of the status (Pending, Completed, Failed)';

-- ======================
-- 19. Devices
-- ======================
CREATE TABLE devices (
    device_id SERIAL PRIMARY KEY,
    device_type VARCHAR(50),
    os VARCHAR(50)
);

COMMENT ON COLUMN devices.device_id IS 'Unique identifier for device';
COMMENT ON COLUMN devices.device_type IS 'Type of device (Mobile, Laptop, ATM)';
COMMENT ON COLUMN devices.os IS 'Operating system running on the device';

-- ======================
-- 20. Fees
-- ======================
CREATE TABLE fees (
    fee_id SERIAL PRIMARY KEY,
    fee_name VARCHAR(50),
    amount NUMERIC(10,2)
);

COMMENT ON COLUMN fees.fee_id IS 'Unique identifier for fee type';
COMMENT ON COLUMN fees.fee_name IS 'Name of the fee (Processing Fee, Annual Fee)';
COMMENT ON COLUMN fees.amount IS 'Fee amount in base currency';

-- ======================
-- Transaction Fact Table
-- ======================
CREATE TABLE transactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES accounts(account_id),
    branch_id INT REFERENCES branches(branch_id),
    product_id INT REFERENCES products(product_id),
    merchant_id INT REFERENCES merchants(merchant_id),
    method_id INT REFERENCES payment_methods(method_id),
    channel_id INT REFERENCES transaction_channels(channel_id),
    employee_id INT REFERENCES employees(employee_id),
    device_id INT REFERENCES devices(device_id),
    status_id INT REFERENCES transaction_statuses(status_id),
    amount NUMERIC(18,2) NOT NULL,
    currency_code CHAR(3) REFERENCES currencies(currency_code),
    transaction_type VARCHAR(50),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description VARCHAR(200)
);

COMMENT ON COLUMN transactions.transaction_id IS 'Unique identifier for each transaction';
COMMENT ON COLUMN transactions.account_id IS 'Foreign key referencing accounts table';
COMMENT ON COLUMN transactions.branch_id IS 'Foreign key referencing branches table';
COMMENT ON COLUMN transactions.product_id IS 'Foreign key referencing products table';
COMMENT ON COLUMN transactions.merchant_id IS 'Foreign key referencing merchants table';
COMMENT ON COLUMN transactions.method_id IS 'Foreign key referencing payment_methods table';
COMMENT ON COLUMN transactions.channel_id IS 'Foreign key referencing transaction_channels table';
COMMENT ON COLUMN transactions.employee_id IS 'Foreign key referencing employees table';
COMMENT ON COLUMN transactions.device_id IS 'Foreign key referencing devices table';
COMMENT ON COLUMN transactions.status_id IS 'Foreign key referencing transaction_statuses table';
COMMENT ON COLUMN transactions.amount IS 'Transaction amount';
COMMENT ON COLUMN transactions.currency_code IS 'Currency of the transaction';
COMMENT ON COLUMN transactions.transaction_type IS 'Type of transaction (Debit, Credit, Transfer)';
COMMENT ON COLUMN transactions.transaction_date IS 'Date and time of transaction';
COMMENT ON COLUMN transactions.description IS 'Additional transaction details';


-- DMLs

-- ======================
-- Countries
-- ======================
INSERT INTO countries (country_code, country_name) VALUES
('IN', 'India'),
('US', 'United States'),
('UK', 'United Kingdom');

-- ======================
-- Regions
-- ======================
INSERT INTO regions (region_name, country_code) VALUES
('West India', 'IN'),
('East Coast', 'US'),
('London Metro', 'UK');

-- ======================
-- Branches
-- ======================
INSERT INTO branches (branch_name, region_id, manager_id, address) VALUES
('Mumbai Central', 1, NULL, '123 MG Road, Mumbai'),
('New York Downtown', 2, NULL, '45 Wall Street, NY'),
('London City', 3, NULL, '10 Downing St, London');

-- ======================
-- Customer Segments
-- ======================
INSERT INTO customer_segments (segment_name, description) VALUES
('Retail', 'Individual banking customers'),
('Corporate', 'Business and corporate clients'),
('Premium', 'High net-worth individuals');

-- ======================
-- Customers
-- ======================
INSERT INTO customers (first_name, last_name, date_of_birth, email, phone, segment_id) VALUES
('Rahul', 'Sharma', '1985-06-15', 'rahul@example.com', '+91-9876543210', 1),
('Anita', 'Verma', '1990-09-22', 'anita@example.com', '+91-9123456780', 2),
('James', 'Smith', '1975-12-10', 'james@example.com', '+1-202-555-0198', 3);

-- ======================
-- Account Types
-- ======================
INSERT INTO account_types (type_name, description) VALUES
('Savings', 'Standard savings account'),
('Current', 'Business account for corporates'),
('Fixed Deposit', 'Term-based fixed deposit account');

-- ======================
-- Currencies
-- ======================
INSERT INTO currencies (currency_code, currency_name, symbol) VALUES
('INR', 'Indian Rupee', '₹'),
('USD', 'US Dollar', '$'),
('GBP', 'Pound Sterling', '£');

-- ======================
-- Accounts
-- ======================
INSERT INTO accounts (customer_id, account_type_id, balance, currency_code) VALUES
(1, 1, 75000.50, 'INR'),
(2, 2, 350000.00, 'INR'),
(3, 1, 12000.00, 'USD');

-- ======================
-- Fees
-- ======================
INSERT INTO fees (fee_name, amount) VALUES
('Processing Fee', 500.00),
('Annual Fee', 1200.00),
('Late Payment Fee', 250.00);

-- ======================
-- Products
-- ======================
INSERT INTO products (product_name, product_type, interest_rate, fee_id) VALUES
('Savings Account', 'Deposit', 3.50, 2),
('Home Loan', 'Loan', 8.20, 1),
('Credit Card', 'Card', 14.50, 3);

-- ======================
-- Employees
-- ======================
INSERT INTO employees (first_name, last_name, role, branch_id, hire_date) VALUES
('Suresh', 'Patil', 'Branch Manager', 1, '2010-05-10'),
('Emily', 'Brown', 'Teller', 2, '2015-08-01'),
('George', 'Taylor', 'Loan Officer', 3, '2018-03-20');

-- ======================
-- Merchants
-- ======================
INSERT INTO merchants (merchant_name, category, country_code) VALUES
('Amazon', 'E-commerce', 'US'),
('Flipkart', 'E-commerce', 'IN'),
('Tesco', 'Retail', 'UK');

-- ======================
-- Payment Methods
-- ======================
INSERT INTO payment_methods (method_name) VALUES
('Card'),
('UPI'),
('NetBanking');

-- ======================
-- Loan Types
-- ======================
INSERT INTO loan_types (loan_type_name, max_tenure_months, base_interest_rate) VALUES
('Home Loan', 240, 7.5),
('Car Loan', 84, 9.0),
('Personal Loan', 60, 12.5);

-- ======================
-- Cards
-- ======================
INSERT INTO cards (account_id, card_number, card_type, expiry_date) VALUES
(1, '4111111111111111', 'Debit', '2028-12-31'),
(2, '5500000000000004', 'Credit', '2027-06-30'),
(3, '340000000000009', 'Credit', '2026-09-30');

-- ======================
-- Transaction Channels
-- ======================
INSERT INTO transaction_channels (channel_name) VALUES
('ATM'),
('Mobile App'),
('POS Terminal');

-- ======================
-- Risk Categories
-- ======================
INSERT INTO risk_categories (risk_level, description) VALUES
('Low', 'Minimal financial risk'),
('Medium', 'Moderate financial risk'),
('High', 'High default risk');

-- ======================
-- Regulatory Codes
-- ======================
INSERT INTO regulatory_codes (code_name, description) VALUES
('KYC', 'Know Your Customer compliance'),
('AML', 'Anti-Money Laundering compliance'),
('CRR', 'Cash Reserve Ratio requirement');

-- ======================
-- Transaction Statuses
-- ======================
INSERT INTO transaction_statuses (status_name) VALUES
('Pending'),
('Completed'),
('Failed');

-- ======================
-- Devices
-- ======================
INSERT INTO devices (device_type, os) VALUES
('Mobile', 'Android'),
('Mobile', 'iOS'),
('ATM', 'Linux');

-- ======================
-- Transactions (Fact Table)
-- ======================
INSERT INTO transactions (account_id, branch_id, product_id, merchant_id, method_id, channel_id, employee_id, device_id, status_id, amount, currency_code, transaction_type, description)
VALUES
(1, 1, 1, 2, 2, 2, 1, 1, 2, 2000.00, 'INR', 'Debit', 'UPI transfer to Flipkart'),
(2, 2, 2, 1, 1, 1, 2, 2, 2, 500000.00, 'INR', 'Credit', 'Home Loan disbursement to Amazon purchase'),
(3, 3, 3, 3, 1, 3, 3, 3, 3, 150.00, 'USD', 'Debit', 'POS swipe at Tesco');

