-- Step 1: create the "showroom" view (data transformation).
-- Verbatim from the blog post:
-- https://www.scalolabs.com/blog/big-query/big-query-predictive-analytics-logistic-regression
-- Dataset: Bank Marketing (Kaggle) https://www.kaggle.com/datasets/janiobachmann/bank-marketing-dataset
-- Replace `bank-predictive-lead-scoring.bank_data_full` with your own project.dataset.
-- The post's table expects a customer_id column and the label column `y`.

CREATE OR REPLACE VIEW `bank-predictive-lead-scoring.bank_data_full.v_bank_marketing_transformed2` AS
SELECT *,
  LOWER(month) AS month_clean,
  CAST(day AS STRING) AS day_str
FROM `bank-predictive-lead-scoring.bank_data_full.bank-lead-scoring`;
