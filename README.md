# Reto SDG – Data Vault 2.0 with dbt + Snowflake + Tableau

This project implements a simplified **Data Vault 2.0 architecture** on top of the Snowflake sample dataset **TPC-H SF1**, using **dbt** as the transformation layer and **Tableau** as the BI layer.

---

## 📐 Architecture

- **Staging** → Cleans and standardizes TPC-H source tables.
- **Raw Vault** → Hub, Link, Satellite layers (with Satellites implemented via dbt snapshots).
- **Business Vault** → Derived business rules, calculated entities.
- **Star Schema** → Dimensional model with fact + dimension tables for analytics.
- **Reporting View** → Flattened view for Tableau (e.g., `vw_sales_flat`).

---

## 📏 Naming Conventions

- Hubs: `hub_<entity>`
- Links: `link_<relationship>`
- Satellites: `sat_<entity>_<attribute_group>`
- Business Vault: `bv_<logic>`
- Fact: `fact_<subject>`
- Dimensions: `dim_<entity>`
- Views: `<table>_view`

---

## ✍️ SQL Style Guide

- Keywords **UPPERCASE**
- Identifiers **snake_case**
- Use `ref('...')` in dbt instead of hardcoded names
- No `SELECT *` — always select explicit columns
- Joins with explicit `ON` clause, each condition on a new line
- Aliases short but descriptive (`c` for `customer`, `o` for `orders`)
- Commit one model per file

---

## ✅ Tests

- **Generic dbt tests**: `not_null`, `unique`, `relationships`
- **dbt_utils**: e.g. `expression_is_true` for numeric ranges
- **Snapshots**: ensure **SCD2 history** (`dbt_valid_from`, `dbt_valid_to`)
- **End-to-end lineage**: visible via `dbt docs`

---

## ▶️ How to Run This Project in dbt Cloud

### 1) Prerequisites
- **Snowflake** account with:
  - Database: `RETO_DB`
  - Warehouse: `RETO_DW`
  - Schemas: `staging`, `raw_vault`, `business_vault`, `star`
- **TPC-H sample data** available in Snowflake.

### 2) Create a dbt Cloud Project
- In **dbt Cloud**, create a new project connected to your Git repo.
- Use **Studio (IDE)** for development.

### 3) Configure Snowflake Connection
- Adapter: **Snowflake**
- Account: e.g. `llfndlk-mq31911`
- Warehouse: `RETO_DW`
- Database: `RETO_DB`
- Schema: staging schema (dbt will override in configs)

### 4) Install packages & parse
```bash
dbt deps
dbt parse --no-partial-parse -v
```

### 5) Build, Snapshot, Test
```bash
# staging
dbt run -s staging

# hubs + links
dbt run -s raw_vault.hub_* raw_vault.link_*

# satellites as snapshots
dbt snapshot

# optional views
dbt run -s raw_vault.sat_*_view

# business vault + star
dbt run -s business_vault star

# reporting view
dbt run -s star.reporting.vw_sales_flat

# run tests
dbt test -s raw_vault star resource_type:snapshot
```

### 6) Generate Docs
```bash
dbt docs generate
```
Open **View Docs** in dbt Cloud to see lineage.

### 7) Connect Tableau Cloud
- Connect to Snowflake:
  - Server: `<account>.snowflakecomputing.com`
  - Warehouse: `RETO_DW`
  - Database: `RETO_DB`
  - Schema: `STAR`
- Use **`VW_SALES_FLAT`** as source.
- Build dashboards:
  - Net Sales by Month
  - Sales by Market Segment
  - Orders vs Lines
  - Top 10 Products
