-- The Bloomberg terminal is the go-to resource for financial professionals, offering convenient access to a wide array of financial datasets. As a Data Analyst at Bloomberg, you have access to historical data on stock performance.

-- Currently, you're analyzing the highest and lowest open prices for each FAANG stock by month over the years.

-- For each FAANG stock, display the ticker symbol, the month and year ('Mon-YYYY') with the corresponding highest and lowest open prices (refer to the Example Output format). Ensure that the results are sorted by ticker symbol.




WITH highest_prices AS(
SELECT
  ticker,
  TO_CHAR(date, 'Mon-YYYY') as date,
  open,
  low,
  ROW_NUMBER() OVER(
    PARTITION BY ticker
    ORDER BY open DESC
    ) as nummer
FROM stock_prices
),
lowest_prices as (
SELECT
  ticker,
  TO_CHAR(date, 'Mon-YYYY') as date,
  open,
  low,
  ROW_NUMBER() OVER(
    PARTITION BY ticker
    ORDER BY open ASC
     ) as nummer
FROM stock_prices
)
SELECT
  high.ticker,
  high.date as highest_mth,
  high.open as highest_open,
  low.date as lowest_mth,
  low.open as lowest_open
FROM highest_prices as high
INNER JOIN lowest_prices as low
ON high.ticker = low.ticker
AND high.nummer = 1 AND low.nummer = 1
