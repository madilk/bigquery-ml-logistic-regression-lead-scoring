-- Step 3: evaluate (ROC AUC, precision, recall).
-- Verbatim from the blog post:
-- https://www.scalolabs.com/blog/big-query/big-query-predictive-analytics-logistic-regression
-- Post results: model 1 (day as a numeric field) precision 0.76, recall 0.12, ROC AUC 0.75.
-- Model 2 (day cast to a category via day_str, as in 01_create_view.sql) reached 0.90 ROC AUC.

SELECT * FROM ML.EVALUATE(MODEL `bank-predictive-lead-scoring.bank_data_full.lead_scoring_model2`);
