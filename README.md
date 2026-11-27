# BigQuery ML Lead Scoring: Predictive Logistic Regression in SQL (No External Pipelines)

> **Full write-up:** [Building Predictive Lead Scoring Via Logistic Regression in Google BigQuery ML](https://www.scalolabs.com/blog/big-query/big-query-predictive-analytics-logistic-regression)

## What this does

Predictive lead scoring with BigQuery ML (BQML): train a logistic regression model on historical customer data and assign each lead a probability of converting, using only SQL inside your data warehouse. The worked example uses the public [Bank Marketing dataset on Kaggle](https://www.kaggle.com/datasets/janiobachmann/bank-marketing-dataset) (will a contact say yes to a bank product).

| Step | File | What it does |
|---|---|---|
| 1 | [`sql/01_create_view.sql`](sql/01_create_view.sql) | A view that fixes data types (day to category, consistent month names) without touching or duplicating the raw table |
| 2 | [`sql/02_train_logistic_reg.sql`](sql/02_train_logistic_reg.sql) | `CREATE MODEL` with `model_type='logistic_reg'` and `auto_class_weights=TRUE` to find the rare "yes" responses |
| 3 | [`sql/03_evaluate.sql`](sql/03_evaluate.sql) | `ML.EVALUATE` for ROC AUC, precision and recall |
| 4 | [`sql/04_predict_hot_leads.sql`](sql/04_predict_hot_leads.sql) | `ML.PREDICT` plus `UNNEST` to get each customer's probability of "yes", sorted high to low |

Results reported in the post: the first model (with `day` as a numeric field) had precision 0.76 but recall 0.12 (it missed 88% of actual buyers) and ROC AUC 0.75. Casting `day` to a string/category in the view (the version in this repo) reached **0.90 ROC AUC**.

## Business use case for marketers

- **Spend efficiency:** know which leads are likely to convert, stop wasting budget on look-alike audiences that do not perform, and bid higher on high-intent leads.
- **No hand-off latency:** the model lives in BigQuery, so a lead is scored the moment it lands in the warehouse and can trigger an email or a salesperson's task.
- **Governance:** the view lets you hide sensitive columns (like phone numbers) from the model while keeping the behavioural data it needs.

## Setup

1. Create a Google Cloud project, a BigQuery dataset and load the raw dataset as a table (the post uses the table name `bank-lead-scoring`).
2. In every file, replace `bank-predictive-lead-scoring.bank_data_full` with your own `project.dataset`.
3. The SQL expects a `customer_id` column and the label column `y`. Check your loaded table has both (the Kaggle CSV may need an id column added at load time).
4. Run the files in order in the BigQuery console or with the `bq` CLI.

## Required keys

No API keys. Needs a Google Cloud project with BigQuery and BigQuery ML enabled (billing applies to model training and queries).

## Files

All SQL is verbatim from the post. Table path is the post's own example project; replace it.

## Author

Built by [Adil Khan](https://www.scalolabs.com) at [Scalo Labs](https://www.scalolabs.com) · [LinkedIn](https://www.linkedin.com/in/madilkhan) · [All write-ups](https://www.scalolabs.com/blog)

Questions or improvements? Open an issue.

## License

MIT. See [LICENSE](LICENSE).
