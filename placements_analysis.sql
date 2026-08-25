SELECT * FROM placement_data LIMIT 10;
+-----------------------+---------+-------------+---------+
| company_name          | selects | salary(lpa) | batch   |
+-----------------------+---------+-------------+---------+
| WIRPO                 |       6 |         3.5 | 2019-20 |
| MINDTREE              |       2 |         3.5 | 2019-20 |
| JARO EDUCATION        |       1 |          12 | 2019-20 |
| Gallagher             |      36 |         2.4 | 2019-20 |
| Grant Thornton        |       3 |         4.5 | 2019-20 |
| TECHTREE IT SOLUTIONS |       4 |           3 | 2019-20 |
| YOUNGMAN INDIA        |      20 |         2.7 | 2019-20 |
| VERZEO                |      36 |           3 | 2019-20 |
| TEAM LEASE            |      29 |         2.6 | 2019-20 |
| NTT DATA              |       8 |         3.2 | 2019-20 |
+-----------------------+---------+-------------+---------+


SELECT
    COUNT(*) AS total_records,
    SUM(selects) AS total_students_selected,
    ROUND(AVG(`salary(lpa)`), 2) AS average_salary,
    MAX(`salary(lpa)`) AS highest_salary,
    MIN(`salary(lpa)`) AS lowest_salary
FROM placement_data;
+---------------+-------------------------+----------------+----------------+---------------+
| total_records | total_students_selected | average_salary | highest_salary | lowest_salary |
+---------------+-------------------------+----------------+----------------+---------------+
|           207 |                    2406 |           4.33 |          12.75 |           1.8 |
+---------------+-------------------------+----------------+----------------+---------------+

SELECT
    batch,
    SUM(selects) AS total_students_selected
FROM placement_data
GROUP BY batch
ORDER BY batch;
+---------+-------------------------+
| batch   | total_students_selected |
+---------+-------------------------+
| 2019-20 |                     454 |
| 2020-21 |                     421 |
| 2021-22 |                     419 |
| 2022-23 |                     407 |
| 2023-24 |                     276 |
| 2025-26 |                     429 |
+---------+-------------------------+

SELECT
    batch,
    ROUND(AVG(`salary(lpa)`), 2) AS average_salary
FROM placement_data
GROUP BY batch
ORDER BY batch;
+---------+----------------+
| batch   | average_salary |
+---------+----------------+
| 2019-20 |           3.83 |
| 2020-21 |           4.09 |
| 2021-22 |           4.37 |
| 2022-23 |           4.74 |
| 2023-24 |            5.5 |
| 2025-26 |           3.74 |
+---------+----------------+

SELECT
    company_name,
    SUM(selects) AS total_selected
FROM placement_data
GROUP BY company_name
ORDER BY total_selected DESC
LIMIT 10;

+-----------------------------+----------------+
| company_name                | total_selected |
+-----------------------------+----------------+
| SEDEMAC                     |            164 |
| COGNIZANT                   |            110 |
| TCS                         |             91 |
| HEALTHPLIX TECHNOLOGIES     |             88 |
| QSPIDERS                    |             78 |
| JUST DIAL                   |             73 |
| TEAM LEASE                  |             67 |
| Leit Motif Solutions        |             67 |
| Infipre Goa                 |             66 |
| Ronch Polymers Pvt Ltd Pune |             60 |
+-----------------------------+----------------+


SELECT
    company_name,
    MAX(`salary(lpa)`) AS highest_salary
FROM placement_data
GROUP BY company_name
ORDER BY highest_salary DESC
LIMIT 10;

+----------------+----------------+
| company_name   | highest_salary |
+----------------+----------------+
| AMADEUS        |          12.75 |
| ORACLE         |           12.5 |
| EXTRAMARKS     |           12.5 |
| Federal Bank   |             12 |
| JARO EDUCATION |             12 |
| Brillio        |          11.25 |
| MCAFEE         |             10 |
| BYJUS          |             10 |
| GE APPLIANCES  |              9 |
| Hashedin       |            8.1 |
+----------------+----------------+


SELECT
    CASE
        WHEN `salary(lpa)` < 3 THEN 'Below 3 LPA'
        WHEN `salary(lpa)` BETWEEN 3 AND 5 THEN '3-5 LPA'
        WHEN `salary(lpa)` > 5 AND `salary(lpa)` <= 8 THEN '5-8 LPA'
        ELSE 'Above 8 LPA'
    END AS salary_range,
    COUNT(*) AS number_of_companies
FROM placement_data
GROUP BY salary_range
ORDER BY number_of_companies DESC;

+--------------+---------------------+
| salary_range | number_of_companies |
+--------------+---------------------+
| 3-5 LPA      |                 135 |
| 5-8 LPA      |                  37 |
| Below 3 LPA  |                  25 |
| Above 8 LPA  |                  10 |
+--------------+---------------------+

SELECT
    company_name,
    SUM(selects) AS total_selected,
    ROUND(AVG(`salary(lpa)`), 2) AS average_salary
FROM placement_data
GROUP BY company_name
HAVING SUM(selects) >= 20
ORDER BY average_salary DESC, total_selected DESC
LIMIT 10;

+---------------------------+----------------+----------------+
| company_name              | total_selected | average_salary |
+---------------------------+----------------+----------------+
| EXTRAMARKS                |             49 |           9.25 |
| TALENT SERVE TECHNOLOGIES |             42 |            6.5 |
| Musigma                   |             39 |           6.25 |
| TEACHNOOK                 |             38 |              6 |
| Doshaheen                 |             21 |            5.5 |
| K12 Techno Services       |             20 |            5.5 |
| L&T                       |             59 |           4.53 |
| Minfy                     |             54 |            4.5 |
| MEHTA HITECH INDUSTRIES   |             21 |            4.5 |
| COGNIZANT                 |            110 |           4.14 |
+---------------------------+----------------+----------------+
