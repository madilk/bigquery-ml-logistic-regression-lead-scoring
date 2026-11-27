-- Step 2: train the model.
-- Verbatim from the blog post:
-- https://www.scalolabs.com/blog/big-query/big-query-predictive-analytics-logistic-regression
-- auto_class_weights=TRUE forces the model to find the rare "yes" responses
-- in a sea of "no" data.

CREATE OR REPLACE MODEL `bank-predictive-lead-scoring.bank_data_full.lead_scoring_model2`
OPTIONS(
  model_type='logistic_reg',
  input_label_cols=['y'],
  auto_class_weights=TRUE
) AS
SELECT * EXCEPT(customer_id)
FROM `bank-predictive-lead-scoring.bank_data_full.v_bank_marketing_transformed2`
WHERE y IS NOT NULL;
