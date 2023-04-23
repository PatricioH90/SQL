#MBAN DD
#Business Challenge #1
#December 17, 2022
#Team 3 Business Challenge Queries
#Authors: Alvaro Ronquillo , Domonic Grant , Arthur Bayon, Milan Venkatesh, Ryan Daniel, Yash Shah*/


USE invest;
-- this query gives the total number of securities that each customer has
SELECT DISTINCT cd.customer_id, cd.first_name, cd.last_name,
COUNT(hc.ticker) as num_of_securities
FROM customer_details as cd
     INNER JOIN account_dim as ad on cd.customer_id = ad.client_id
     INNER JOIN holdings_current as hc on ad.account_id = hc.account_id
     INNER JOIN security_masterlist as sm on hc.ticker = sm.ticker
GROUP BY cd.customer_id
ORDER BY COUNT(hc.ticker) DESC;
-- randomly selecting our clients and identifying all the accounts that will be analyzed
SELECT cd.customer_id, ad.account_id, cd.first_name, cd.last_name,
COUNT(hc.ticker) as num_of_securities
FROM customer_details as cd
     INNER JOIN account_dim as ad on cd.customer_id = ad.client_id
     INNER JOIN holdings_current as hc on ad.account_id = hc.account_id
     INNER JOIN security_masterlist as sm on hc.ticker = sm.ticker
WHERE ad.client_id IN ('171' , '539', '999')
GROUP BY ad.account_id
ORDER BY COUNT(hc.ticker) DESC;


-- identify the % weight of each asset class in the clents account
SELECT hc.account_id, CasE WHEN sm.major_asset_class = '%fixed%' THEN 
'fixed_income'
WHEN sm.major_asset_class LIKE '%fixed%' THEN 'fixed_income'
WHEN sm.major_asset_class = 'commodities' THEN 'commodities'
WHEN sm.major_asset_class = 'alternatives' THEN 'alternatives'
WHEN sm.major_asset_class LIKE '%eq%' THEN 'equity'
END as assets, CasE WHEN sm.major_asset_class LIKE '%fixed%' THEN sum(hc.quantity)
WHEN sm.major_asset_class = 'commodities' THEN sum(hc.quantity)
WHEN sm.major_asset_class = 'alternatives' THEN sum(hc.quantity)
WHEN sm.major_asset_class LIKE '%eq%' THEN sum(hc.quantity)
END/ sum(CasE WHEN sm.major_asset_class LIKE '%fixed%' THEN sum(hc.quantity)
WHEN sm.major_asset_class = 'commodities' THEN sum(hc.quantity)
WHEN sm.major_asset_class = 'alternatives' THEN sum(hc.quantity)
WHEN sm.major_asset_class LIKE '%eq%' THEN sum(hc.quantity)
END) OVER(PARTITIon BY account_id) as quantity
FROM holdings_current as hc
INNER JOIN security_masterlist as sm on hc.ticker = sm.ticker
WHERE hc.account_id = 770
GROUP BY assets;


-- this query shows weights and the stock value of the portfolio based on asset quantity -- this is what we used
SELECT ad.account_id, hc.ticker, 
hc.value,hc.quantity,(hc.value*hc.quantity) as total_stk_value, hc.quantity/sum(hc.quantity) over(PARTITIon BY hc.account_id ORDER BY hc.account_id) as weights -- sum((hc.value*hc.quantity))
FROM customer_details as cd
INNER JOIN account_dim as ad on cd.customer_id = ad.client_id
INNER JOIN holdings_current as hc on ad.account_id = hc.account_id
INNER JOIN security_masterlist as sm on hc.ticker = sm.ticker
WHERE hc.account_id = 77001
;


-- this query shows the clients of wells fargo that has the highest valued portfolios
SELECT hc.account_id, cd.full_name,
SUM(hc.value * hc.quantity) as total_portfolio_value
FROM customer_details as cd
     INNER JOIN account_dim as ad on cd.customer_id = ad.client_id
     INNER JOIN holdings_current as hc on ad.account_id = hc.account_id
          INNER JOIN security_masterlist as sm on hc.ticker = sm.ticker GROUP BY ad.client_id
ORDER BY total_portfolio_value DESC
LIMIT 15;



-- this query shows weights and the stock value of the portfolio based on stock values
SELECT 	ad.account_id, hc.ticker, sm.sec_type , hc.value, hc.quantity,
(hc.value*hc.quantity) as total_stk_value,
(hc.value*hc.quantity)/sum((hc.value*hc.quantity)) over (PARTITIon 
BY hc.account_id ORDER BY hc.account_id) as weights
FROM customer_details as cd
INNER JOIN account_dim as ad on cd.customer_id = ad.client_id
INNER JOIN holdings_current as hc on ad.account_id = hc.account_id
INNER JOIN security_masterlist as sm on hc.ticker = sm.ticker
WHERE hc.account_id = 770
;



-- drop the view FROM the serve if there is one drop view  if exists aronquillo_returns_v2 ;
-- Creating View for the Lagged Priced FROM 6, 12, 18, 24
CREATE VIEW aronquillo_returns_v2 as
SELECT p.date, p.ticker,
(p.value - p.lagged_price6)/p.lagged_price6 as 
discrete_returns_6M,
          (p.value - p.lagged_price12)/p.lagged_price12 as discrete_returns_12M,
(p.value - p.lagged_price18)/p.lagged_price18 as 
discrete_returns_18M,
          (p.value - p.lagged_price24)/p.lagged_price24 as discrete_returns_24M
FROM
       (SELECT *, LAG(value,125) OVER (PARTITIon BY ticker ORDER BY date) as Lagged_price6,
LAG(value,250) OVER (PARTITIon BY 
ticker ORDER BY date) as Lagged_price12,
                   LAG(value,375) OVER (PARTITIon BY ticker ORDER BY date) as Lagged_price18,
LAG(value,250) OVER (PARTITIon BY ticker ORDER BY date) as 
Lagged_price24
FROM pricing_daily_new
WHERE price_type='Adjusted' AND date > '2019-09-09' ) as p
;



-- this query Show Tickers with Returns, Standard_Dev and Risk_Adj for 6 ,12 , 18, 24 Months which helps in identifying the the top performing assets and underpermoring assets
SELECT aronquillo_returns_v2.ticker, sm.security_name, sm.major_asset_class,
AVG(discrete_returns_6M) as mu_6M,
STDDEV(discrete_returns_6M) as std_6M,
     AVG(discrete_returns_6M) / STDDEV(discrete_returns_6M) as risk_adj_returns_6M,
AVG(discrete_returns_12M) as mu_12M,
STDDEV(discrete_returns_12M) as std_12M,
     AVG(discrete_returns_12M) / STDDEV(discrete_returns_12M) as risk_adj_returns_12M,
AVG(discrete_returns_18M) as mu_18M,
STDDEV(discrete_returns_18M) as std_18M,
     AVG(discrete_returns_18M) / STDDEV(discrete_returns_18M) as risk_adj_returns_18M,
AVG(discrete_returns_24M) as mu_24M,
STDDEV(discrete_returns_24M) as std_24M,
     AVG(discrete_returns_24M) / STDDEV(discrete_returns_24M) as risk_adj_returns_24M
FROM invest.aronquillo_returns_v2
     INNER JOIN security_masterlist as sm on aronquillo_returns_v2.ticker = sm.ticker
     INNER JOIN holdings_current as hc on sm.ticker = hc.ticker
WHERE account_id = 770
GROUP BY aronquillo_returns_v2.ticker;


-- this query brings all the securities weighted returns and weighted standard deviations based on their accounts
-- this is where we found the similar asset class with better returns and lower risk
SELECT aronquillo_returns_v2.ticker, sm.security_name, sm.major_asset_class,
hc.value,hc.quantity,(hc.value*hc.quantity) as total_stk_value, AVG(discrete_returns_12M) as mu_12M, STDDEV(discrete_returns_12M) as std_12M ,  ((hc.value*hc.quantity)/sum((hc.value*hc.quantity)) over(PARTITIon BY hc.account_id ORDER BY hc.account_id))*AVG(discrete_returns_12M) as 
weighted_expected_return,((hc.value*hc.quantity)/sum((hc.value*hc.quantity
)) over (PARTITIon BY hc.account_id ORDER BY 
hc.account_id))*STDDEV(discrete_returns_12M) as weighted_risk
FROM invest.aronquillo_returns_v2
INNER JOIN security_masterlist as sm on aronquillo_returns_v2.ticker = sm.ticker
INNER JOIN holdings_current as hc on sm.ticker = hc.ticker
GROUP BY aronquillo_returns_v2.ticker;


-- Show Tickers with full portfolio details per account with returns and sigma 12M
-- this is how we decide to replace the most volatile and underperforming assets compared to the 6m 12m 18m and 24m risk and returns
SELECT aronquillo_returns_v2.ticker, sm.security_name, sm.major_asset_class,
hc.value,hc.quantity,(hc.value*hc.quantity) as total_stk_value, (hc.value*hc.quantity)/sum((hc.value*hc.quantity)) over (PARTITIon BY hc.account_id ORDER BY hc.account_id) as weights,
AVG(discrete_returns_12M) as mu_12M, STDDEV(discrete_returns_12M) as std_12M ,  ((hc.value*hc.quantity)/sum((hc.value*hc.quantity)) over 
(PARTITIon BY hc.account_id ORDER BY hc.account_id))*AVG(discrete_returns_12M) as 
weighted_expected_return,((hc.value*hc.quantity)/sum((hc.value*hc.quantity
)) over (PARTITIon BY hc.account_id ORDER BY 
hc.account_id))*STDDEV(discrete_returns_12M) as weighted_risk
FROM invest.aronquillo_returns_v2
INNER JOIN security_masterlist as sm on aronquillo_returns_v2.ticker = sm.ticker
INNER JOIN holdings_current as hc on sm.ticker = hc.ticker
WHERE account_id = 77001
GROUP BY aronquillo_returns_v2.ticker;