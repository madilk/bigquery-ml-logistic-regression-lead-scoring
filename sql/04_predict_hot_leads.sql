-- Step 4: generate the "hot leads" (inference).
-- Verbatim from the blog post:
-- https://www.scalolabs.com/blog/big-query/big-query-predictive-analytics-logistic-regression
-- UNNEST turns the model's predicted_y_probs into a readable probability per customer.

SELECT
  customer_id,
  round(p.prob, 4) AS probability_score,
  * EXCEPT(customer_id, predicted_y, predicted_y_probs)
FROM
  ML.PREDICT(MODEL `bank-predictive-lead-scoring.bank_data_full.lead_scoring_model2`,
    (SELECT * FROM `bank-predictive-lead-scoring.bank_data_full.v_bank_marketing_transformed2`))
  CROSS JOIN UNNEST(predicted_y_probs) AS p
WHERE CAST(p.label AS STRING) = 'true'
ORDER BY probability_score DESC;
