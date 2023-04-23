USE bos_ddmban_sql_analysis;

-- Compare AVG and StdDev of Products with up to 3 Badges vs More than 4 Badges
-- We compared the metrics by Weight (gr, g, lb, oz) and then by Volume (ml, l, fl_oz)

-- Query for Comparing Products with Volume_Measurement of Weight
SELECT category, 	
COUNT(
			CASE WHEN volume_of_measurement = 'g' 	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr'  THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' 	 THEN   (regular_price/(volume*28.3495)) -- To transform Oz to Grams
            WHEN volume_of_measurement = 'ml'  THEN ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb'  THEN  (regular_price/(volume*453.592)) -- To Transform lb to Grams 
            WHEN volume_of_measurement = 'fl _oz'  THEN  (regular_price/(volume*29.574)) -- To transform fl_oz to ml
			WHEN volume_of_measurement = 'fl_oz'  THEN  (regular_price/(volume*29.574)) -- To transform fl_oz to ml
			WHEN volume_of_measurement = 'fl oz'  THEN  (regular_price/(volume*29.574))-- To transform fl_oz to ml
            WHEN volume_of_measurement = 'lt'  THEN (regular_price/(volume*1000)) -- To transform lt to ml
            END) AS `num_pmu_all_product`,
FORMAT(AVG (
			CASE WHEN volume_of_measurement = 'g' 	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr'  THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' 	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml'  THEN ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb'  THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz'  THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz'  THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz'  THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt'  THEN (regular_price/(volume*1000))
            END),2) AS `avg_pmu_all_product`,
FORMAT(STDDEV(
			CASE WHEN volume_of_measurement = 'g' 	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr'  THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' 	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml'  THEN ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb'  THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz'  THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz'  THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz'  THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt'  THEN (regular_price/(volume*1000))
            END),2) AS `stdev_pmu_all_product`, " | ",
-- Count the Number of Items  with Less than 3 Badges
COUNT( DISTINCT
            CASE WHEN volume_of_measurement = 'g' AND sum_badges IN (0,1,2,3)	THEN  `product_name`
			WHEN volume_of_measurement = 'gr' AND sum_badges IN (0,1,2,3) THEN   `product_name`
			WHEN volume_of_measurement = 'oz' AND sum_badges IN (0,1,2,3)  THEN   `product_name`
            WHEN volume_of_measurement = 'ml' AND sum_badges IN (0,1,2,3) THEN  `product_name`
            WHEN volume_of_measurement = 'lb' AND sum_badges IN (0,1,2,3) THEN  `product_name`
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges IN (0,1,2,3) THEN  `product_name`
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges IN (0,1,2,3) THEN `product_name`
			WHEN volume_of_measurement = 'fl oz' AND sum_badges IN (0,1,2,3) THEN  `product_name`
            WHEN volume_of_measurement = 'lt' AND sum_badges IN (0,1,2,3) THEN `product_name`
            END) AS `num_items_0_to_3_badges`,
-- Avg Price per Metric Unit with Less than 3 Badges
		FORMAT(AVG (
			CASE WHEN volume_of_measurement = 'g' AND sum_badges IN (0,1,2,3)	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges IN (0,1,2,3) THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges IN (0,1,2,3)	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges IN (0,1,2,3) THEN ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges IN (0,1,2,3) THEN (regular_price/(volume*1000))
            END),2) AS `avg_pmu_0_to_3_badges`,
-- Std Dev of Priceper Metric Unit with NO Badges
		FORMAT(STDDEV(CASE WHEN volume_of_measurement = 'g' AND sum_badges IN (0,1,2,3)	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges IN (0,1,2,3) THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges IN (0,1,2,3)	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges IN (0,1,2,3) THEN  ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges IN (0,1,2,3) THEN (regular_price/(volume*1000))
            END),2) AS `stddev_pmu_0_to_3_badge`, " | ",
-- Count the Number of Items  with  More than 4 Badges
		COUNT( DISTINCT
			CASE WHEN volume_of_measurement = 'g' AND sum_badges >=4	THEN  `product_name`
			WHEN volume_of_measurement = 'gr' AND sum_badges >=4 THEN   `product_name`
			WHEN volume_of_measurement = 'oz' AND sum_badges >=4	 THEN   `product_name`
            WHEN volume_of_measurement = 'ml' AND sum_badges >=4 THEN  `product_name`
            WHEN volume_of_measurement = 'lb' AND sum_badges >=4 THEN  `product_name`
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges >=4 THEN  `product_name`
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges >=4 THEN `product_name`
			WHEN volume_of_measurement = 'fl oz' AND sum_badges >=4 THEN  `product_name`
            WHEN volume_of_measurement = 'lt' AND sum_badges >=4 THEN `product_name`
            END) AS `num_items_with_more_badges`,
-- Avg of Price per Metric Unit of Items with More than 4 Badges
		FORMAT(AVG (
			CASE WHEN volume_of_measurement = 'g' AND sum_badges >=4	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges >=4 THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges >=4	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges >=4 THEN  ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges >=4 THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges >=4 THEN (regular_price/(volume*1000))
            END),2) AS `avg_pmu_with_more_badges`,
-- Std Dev of Price per Metric Unit of Items with Badges
		FORMAT(STDDEV(
            CASE WHEN volume_of_measurement = 'g' AND sum_badges >=4	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges >=4 THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges >=4	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges >=4 THEN  ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges >=4 THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges >=4 THEN (regular_price/(volume*1000))
            END),2) AS `stddev_pmu_with_more_badges`,
		 " | ",
            FORMAT(AVG (
			CASE WHEN volume_of_measurement = 'g' AND sum_badges IN (0,1,2,3)	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges IN (0,1,2,3) THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges IN (0,1,2,3)	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges IN (0,1,2,3) THEN  ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges IN (0,1,2,3) THEN (regular_price/(volume*1000))
            END) 
            - 
            AVG (
			CASE WHEN volume_of_measurement = 'g' AND sum_badges >=4	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges >=4 THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges >=4	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges >=4 THEN  ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges >=4 THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges >=4 THEN (regular_price/(volume*1000))
            END),2) as `dif_less_badge_vs_more__badge`
FROM bmbandd_data
WHERE `wf_product_id` != 'b07g5dvldd' AND `wf_product_id` != 'b07cfkqw4s' AND `wf_product_id` != 'b00016wrzo' -- Exclude Outliers that had a pmu too high
	AND volume_of_measurement IN('g','gr','oz','lb')
GROUP BY category;



-- Query for Comparing Products with Volume_Measurement of Volume
SELECT category, 		
COUNT(
			CASE WHEN volume_of_measurement = 'g' 	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr'  THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' 	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml'  THEN ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb'  THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz'  THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz'  THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz'  THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt'  THEN (regular_price/(volume*1000))
            END) AS `num_pmu_all_product`,
FORMAT(AVG (
			CASE WHEN volume_of_measurement = 'g' 	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr'  THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' 	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml'  THEN ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb'  THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz'  THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz'  THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz'  THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt'  THEN (regular_price/(volume*1000))
            END),2) AS `avg_pmu_all_product`,
FORMAT(STDDEV(
			CASE WHEN volume_of_measurement = 'g' 	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr'  THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' 	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml'  THEN ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb'  THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz'  THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz'  THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz'  THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt'  THEN (regular_price/(volume*1000))
            END),2) AS `stdev_pmu_all_product`, " | ",
-- Count the Number of Items  with Less than 3 Badges
COUNT( DISTINCT
            CASE WHEN volume_of_measurement = 'g' AND sum_badges IN (0,1,2,3)	THEN  `product_name`
			WHEN volume_of_measurement = 'gr' AND sum_badges IN (0,1,2,3) THEN   `product_name`
			WHEN volume_of_measurement = 'oz' AND sum_badges IN (0,1,2,3)  THEN   `product_name`
            WHEN volume_of_measurement = 'ml' AND sum_badges IN (0,1,2,3) THEN  `product_name`
            WHEN volume_of_measurement = 'lb' AND sum_badges IN (0,1,2,3) THEN  `product_name`
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges IN (0,1,2,3) THEN  `product_name`
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges IN (0,1,2,3) THEN `product_name`
			WHEN volume_of_measurement = 'fl oz' AND sum_badges IN (0,1,2,3) THEN  `product_name`
            WHEN volume_of_measurement = 'lt' AND sum_badges IN (0,1,2,3) THEN `product_name`
            END) AS `num_items_0_to_3_badges`,
-- Avg Price per Metric Unit with Less than 3 Badges
		FORMAT(AVG (
			CASE WHEN volume_of_measurement = 'g' AND sum_badges IN (0,1,2,3)	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges IN (0,1,2,3) THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges IN (0,1,2,3)	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges IN (0,1,2,3) THEN ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges IN (0,1,2,3) THEN (regular_price/(volume*1000))
            END),2) AS `avg_pmu_0_to_3_badges`,
-- Std Dev of Priceper Metric Unit with NO Badges
		FORMAT(STDDEV(CASE WHEN volume_of_measurement = 'g' AND sum_badges IN (0,1,2,3)	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges IN (0,1,2,3) THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges IN (0,1,2,3)	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges IN (0,1,2,3) THEN  ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges IN (0,1,2,3) THEN (regular_price/(volume*1000))
            END),2) AS `stddev_pmu_0_to_3_badge`, " | ",
-- Count the Number of Items  with  More than 4 Badges
		COUNT( DISTINCT
			CASE WHEN volume_of_measurement = 'g' AND sum_badges >=4	THEN  `product_name`
			WHEN volume_of_measurement = 'gr' AND sum_badges >=4 THEN   `product_name`
			WHEN volume_of_measurement = 'oz' AND sum_badges >=4	 THEN   `product_name`
            WHEN volume_of_measurement = 'ml' AND sum_badges >=4 THEN  `product_name`
            WHEN volume_of_measurement = 'lb' AND sum_badges >=4 THEN  `product_name`
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges >=4 THEN  `product_name`
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges >=4 THEN `product_name`
			WHEN volume_of_measurement = 'fl oz' AND sum_badges >=4 THEN  `product_name`
            WHEN volume_of_measurement = 'lt' AND sum_badges >=4 THEN `product_name`
            END) AS `num_items_with_more_badges`,
-- Avg of Price per Metric Unit of Items with More than 4 Badges
		FORMAT(AVG (
			CASE WHEN volume_of_measurement = 'g' AND sum_badges >=4	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges >=4 THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges >=4	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges >=4 THEN  ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges >=4 THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges >=4 THEN (regular_price/(volume*1000))
            END),2) AS `avg_pmu_with_more_badges`,
-- Std Dev of Price per Metric Unit of Items with Badges
		FORMAT(STDDEV(
            CASE WHEN volume_of_measurement = 'g' AND sum_badges >=4	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges >=4 THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges >=4	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges >=4 THEN  ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges >=4 THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges >=4 THEN (regular_price/(volume*1000))
            END),2) AS `stddev_pmu_with_more_badges`,
		 " | ",
            FORMAT(AVG (
			CASE WHEN volume_of_measurement = 'g' AND sum_badges IN (0,1,2,3)	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges IN (0,1,2,3) THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges IN (0,1,2,3)	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges IN (0,1,2,3) THEN  ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges IN (0,1,2,3) THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges IN (0,1,2,3) THEN (regular_price/(volume*1000))
            END) 
            - 
            AVG (
			CASE WHEN volume_of_measurement = 'g' AND sum_badges >=4	THEN  (regular_price/volume)
			WHEN volume_of_measurement = 'gr' AND sum_badges >=4 THEN   ((regular_price/volume)) 
			WHEN volume_of_measurement = 'oz' AND sum_badges >=4	 THEN   (regular_price/(volume*28.3495)) 
            WHEN volume_of_measurement = 'ml' AND sum_badges >=4 THEN  ((regular_price/volume)) 
            WHEN volume_of_measurement = 'lb' AND sum_badges >=4 THEN  (regular_price/(volume*453.592)) 
            WHEN volume_of_measurement = 'fl _oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl_oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
			WHEN volume_of_measurement = 'fl oz' AND sum_badges >=4 THEN  (regular_price/(volume*29.574))
            WHEN volume_of_measurement = 'lt' AND sum_badges >=4 THEN (regular_price/(volume*1000))
            END),2) as `dif_less_badge_vs_more__badge`
FROM bmbandd_data
WHERE `wf_product_id` != 'b07g5dvldd' AND `wf_product_id` != 'b07cfkqw4s' AND `wf_product_id` != 'b00016wrzo'
	AND volume_of_measurement IN('ml','lt','fl_oz','fl oz','fl _oz')
GROUP BY category;


