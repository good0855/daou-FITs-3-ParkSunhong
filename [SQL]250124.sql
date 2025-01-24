
ALTER SESSION SET STATISTICS_LEVEL=ALL;

-- 1. 
SELECT * FROM EMPLOYEES;

SELECT * FROM EMPLOYEES
WHERE EMP_NO LIKE '101%'
    OR EMP_NO LIKE '103%';



SELECT * FROM EMPLOYEES
WHERE EMP_NO BETWEEN 10100 AND 10199
        OR EMP_NO BETWEEN 10300 AND 10399;


-- 2.
SELECT 
    NVL(GENDER, 'NON') AS GENDER,
    COUNT(*)
FROM EMPLOYEES
GROUP BY NVL(GENDER, 'NON');


-- 개선
-- 기존 : HASH GROUP BY
-- 개선 : SORT GROUP BY NOSORT
-- idx_gender라는 인덱스가 있다고 해도, NVL 함수가 적용된 값은 인덱스의 기본 정렬 상태와 무관하기 때문에 정렬된 데이터를 활용할 수 없다고 간주
SELECT
    /*+ index(employees idx_gender) */
    GENDER,
    COUNT(*)
FROM EMPLOYEES
GROUP BY GENDER;


SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));

-- 3.
SELECT *
FROM EMPLOYEES
WHERE GENDER || ' ' || last_name = 'M Radwan';

SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));

 
-----------------------------------------------------------------------------------------
| Id  | Operation         | Name      | Starts | E-Rows | A-Rows |   A-Time   | Buffers |
-----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |      1 |        |      5 |00:00:00.01 |     143 |
|*  1 |  TABLE ACCESS FULL| EMPLOYEES |      1 |      8 |      5 |00:00:00.01 |     143 |
-----------------------------------------------------------------------------------------

-- 개선
-- INDEX COLUMN 가공시키지 말기
SELECT *
FROM EMPLOYEES
WHERE GENDER = 'M' and LAST_NAME= 'Radwan';

SELECT *
FROM EMPLOYEES
WHERE  LAST_NAME= 'Radwan' AND GENDER = 'M';

SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));

-------------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name                 | Starts | E-Rows | A-Rows |   A-Time   | Buffers | Reads  |
-------------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |                      |      1 |        |      5 |00:00:00.01 |       7 |      1 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| EMPLOYEES            |      1 |      8 |      5 |00:00:00.01 |       7 |      1 |
|*  2 |   INDEX RANGE SCAN                  | IDX_GENDER_LAST_NAME |      1 |      8 |      5 |00:00:00.01 |       2 |      1 |
-------------------------------------------------------------------------------------------------------------------------------

-- 4.

SELECT FIRST_NAME, LAST_NAME, EMP_NO
FROM EMPLOYEES
WHERE SUBSTR(EMP_NO, 1, 4) = 1030;


SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));

-----------------------------------------------------------------------------------------
| Id  | Operation         | Name      | Starts | E-Rows | A-Rows |   A-Time   | Buffers |
-----------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT  |           |      1 |        |     10 |00:00:00.01 |     143 |
|*  1 |  TABLE ACCESS FULL| EMPLOYEES |      1 |      3 |     10 |00:00:00.01 |     143 |
-----------------------------------------------------------------------------------------

SELECT FIRST_NAME, LAST_NAME, EMP_NO
FROM EMPLOYEES
WHERE EMP_NO >= 10300 AND EMP_NO < 10310;
SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));

-------------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name        | Starts | E-Rows | A-Rows |   A-Time   | Buffers |
-------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |             |      1 |        |     11 |00:00:00.01 |       3 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| EMPLOYEES   |      1 |     11 |     11 |00:00:00.01 |       3 |
|*  2 |   INDEX RANGE SCAN                  | SYS_C008430 |      1 |     11 |     11 |00:00:00.01 |       2 |
-------------------------------------------------------------------------------------------------------------

SELECT FIRST_NAME, LAST_NAME, EMP_NO
FROM EMPLOYEES
WHERE EMP_NO BETWEEN 10300 AND 10309;
-------------------------------------------------------------------------------------------------------------
| Id  | Operation                           | Name        | Starts | E-Rows | A-Rows |   A-Time   | Buffers |
-------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT                    |             |      1 |        |     11 |00:00:00.01 |       3 |
|   1 |  TABLE ACCESS BY INDEX ROWID BATCHED| EMPLOYEES   |      1 |     11 |     11 |00:00:00.01 |       3 |
|*  2 |   INDEX RANGE SCAN                  | SYS_C008430 |      1 |     11 |     11 |00:00:00.01 |       2 |
-------------------------------------------------------------------------------------------------------------


SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));



-- 5.
SELECT DISTINCT E.EMP_NO, E.FIRST_NAME, E.LAST_NAME, D.DEPT_NO
FROM EMPLOYEES E, DEPT_MANAGER D
WHERE E.EMP_NO = D.EMP_NO;

-------------------------------------------------------------------------------------------------------
| Id  | Operation                     | Name        | Starts | E-Rows | A-Rows |   A-Time   | Buffers |
-------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |             |      1 |        |     24 |00:00:00.01 |      51 |
|   1 |  HASH UNIQUE                  |             |      1 |     24 |     24 |00:00:00.01 |      51 |
|   2 |   NESTED LOOPS                |             |      1 |     24 |     24 |00:00:00.01 |      51 |
|   3 |    NESTED LOOPS               |             |      1 |     24 |     24 |00:00:00.01 |      27 |
|   4 |     INDEX FAST FULL SCAN      | SYS_C008418 |      1 |     24 |     24 |00:00:00.01 |       4 |
|*  5 |     INDEX UNIQUE SCAN         | SYS_C008430 |     24 |      1 |     24 |00:00:00.01 |      23 |
|   6 |    TABLE ACCESS BY INDEX ROWID| EMPLOYEES   |     24 |      1 |     24 |00:00:00.01 |      24 |
-------------------------------------------------------------------------------------------------------
SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));

--
SELECT E.EMP_NO, E.FIRST_NAME, E.LAST_NAME, D.DEPT_NO
FROM EMPLOYEES E, DEPT_MANAGER D
WHERE E.EMP_NO = D.EMP_NO;

SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));


|   0 | SELECT STATEMENT             |             |      1 |        |     24 |00:00:00.01 |      51 |
|   1 |  NESTED LOOPS                |             |      1 |     24 |     24 |00:00:00.01 |      51 |
|   2 |   NESTED LOOPS               |             |      1 |     24 |     24 |00:00:00.01 |      27 |
|   3 |    INDEX FAST FULL SCAN      | SYS_C008418 |      1 |     24 |     24 |00:00:00.01 |       4 |
|*  4 |    INDEX UNIQUE SCAN         | SYS_C008430 |     24 |      1 |     24 |00:00:00.01 |      23 |
|   5 |   TABLE ACCESS BY INDEX ROWID| EMPLOYEES   |     24 |      1 |     24 |00:00:00.01 |      24 |
------------------------------------------------------------------------------------------------------



SELECT E.EMP_NO, E.FIRST_NAME, E.LAST_NAME, D.DEPT_NO
FROM EMPLOYEES E
RIGHT OUTER JOIN DEPT_MANAGER D
ON E.EMP_NO = D.EMP_NO;

SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));

------------------------------------------------------------------------------------------------------
| Id  | Operation                    | Name        | Starts | E-Rows | A-Rows |   A-Time   | Buffers |
------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |             |      1 |        |     24 |00:00:00.01 |      51 |
|   1 |  NESTED LOOPS OUTER          |             |      1 |     24 |     24 |00:00:00.01 |      51 |
|   2 |   INDEX FAST FULL SCAN       | SYS_C008418 |      1 |     24 |     24 |00:00:00.01 |       4 |
|   3 |   TABLE ACCESS BY INDEX ROWID| EMPLOYEES   |     24 |      1 |     24 |00:00:00.01 |      47 |
|*  4 |    INDEX UNIQUE SCAN         | SYS_C008430 |     24 |      1 |     24 |00:00:00.01 |      23 |
------------------------------------------------------------------------------------------------------


SELECT E.EMP_NO, E.FIRST_NAME, E.LAST_NAME, D.DEPT_NO
FROM EMPLOYEES E
RIGHT OUTER JOIN DEPT_MANAGER D
ON E.EMP_NO = D.EMP_NO
WHERE E.EMP_NO IS NOT NULL;
SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));

| Id  | Operation                    | Name        | Starts | E-Rows | A-Rows |   A-Time   | Buffers |
------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |             |      1 |        |     24 |00:00:00.01 |      51 |
|   1 |  NESTED LOOPS                |             |      1 |     24 |     24 |00:00:00.01 |      51 |
|   2 |   NESTED LOOPS               |             |      1 |     24 |     24 |00:00:00.01 |      27 |
|   3 |    INDEX FAST FULL SCAN      | SYS_C008418 |      1 |     24 |     24 |00:00:00.01 |       4 |
|*  4 |    INDEX UNIQUE SCAN         | SYS_C008430 |     24 |      1 |     24 |00:00:00.01 |      23 |
|   5 |   TABLE ACCESS BY INDEX ROWID| EMPLOYEES   |     24 |      1 |     24 |00:00:00.01 |      24 |
------------------------------------------------------------------------------------------------------

-- 6.
SELECT COUNT(DISTINCT E.EMP_NO) AS CNT
FROM EMPLOYEES E,
    (SELECT EMP_NO
    FROM SALARIES
    WHERE SALARY > 50000
    ) S
WHERE E.EMP_NO = S.EMP_NO;

SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));

-----------------------------------------------------------------------------------------------------------------------------
| Id  | Operation                | Name        | Starts | E-Rows | A-Rows |   A-Time   | Buffers |  OMem |  1Mem | Used-Mem |
-----------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT         |             |      1 |        |      1 |00:00:00.01 |     934 |       |       |          |
|   1 |  SORT AGGREGATE          |             |      1 |      1 |      1 |00:00:00.01 |     934 |       |       |          |
|   2 |   VIEW                   | VM_NWVW_1   |      1 |   1392 |  17484 |00:00:00.01 |     934 |       |       |          |
|   3 |    HASH GROUP BY         |             |      1 |   1392 |  17484 |00:00:00.01 |     934 |  2406K|  2406K| 1938K (0)|
|*  4 |     HASH JOIN SEMI       |             |      1 |   1392 |  17484 |00:00:00.01 |     934 |  2801K|  2801K| 2215K (0)|
|   5 |      INDEX FAST FULL SCAN| SYS_C008430 |      1 |  27789 |  20000 |00:00:00.01 |      55 |       |       |          |
|*  6 |      TABLE ACCESS FULL   | SALARIES    |      1 |    132K|    144K|00:00:00.01 |     879 |       |       |          |

-- 개선
SELECT COUNT(E.EMP_NO) AS NT
FROM EMPLOYEES E
WHERE EXISTS (SELECT 1
                FROM SALARIES S
                WHERE S.EMP_NO = E.EMP_NO
                AND S.SALARY > 50000);
SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));
---------------------------------------------------------------------------------------------------------------------------
| Id  | Operation              | Name        | Starts | E-Rows | A-Rows |   A-Time   | Buffers |  OMem |  1Mem | Used-Mem |
---------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT       |             |      1 |        |      1 |00:00:00.03 |     934 |       |       |          |
|   1 |  SORT AGGREGATE        |             |      1 |      1 |      1 |00:00:00.03 |     934 |       |       |          |
|*  2 |   HASH JOIN SEMI       |             |      1 |   1392 |  17484 |00:00:00.03 |     934 |  2801K|  2801K| 1846K (0)|
|   3 |    INDEX FAST FULL SCAN| SYS_C008430 |      1 |  27789 |  20000 |00:00:00.01 |      55 |       |       |          |
|*  4 |    TABLE ACCESS FULL   | SALARIES    |      1 |    132K|    144K|00:00:00.01 |     879 |       |       |          |
---------------------------------------------------------------------------------------------------------------------------

SELECT COUNT(EMP_NO) AS CNT
FROM(
    SELECT EMP_NO
    FROM EMPLOYEES
    INTERSECT
    SELECT DISTINCT EMP_NO
    FROM SALARIES
    WHERE SALARY > 50000
);
----------------------------------------------------------------------------------------------------------------------------
| Id  | Operation               | Name        | Starts | E-Rows | A-Rows |   A-Time   | Buffers |  OMem |  1Mem | Used-Mem |
----------------------------------------------------------------------------------------------------------------------------
|   0 | SELECT STATEMENT        |             |      1 |        |      1 |00:00:00.03 |     934 |       |       |          |
|   1 |  SORT AGGREGATE         |             |      1 |      1 |      1 |00:00:00.03 |     934 |       |       |          |
|   2 |   VIEW                  |             |      1 |  27789 |  17484 |00:00:00.03 |     934 |       |       |          |
|   3 |    INTERSECTION HASH    |             |      1 |        |  17484 |00:00:00.03 |     934 |  2361K|  2361K| 2431K (0)|
|   4 |     INDEX FAST FULL SCAN| SYS_C008430 |      1 |  27789 |  20000 |00:00:00.01 |      55 |       |       |          |
|*  5 |     TABLE ACCESS FULL   | SALARIES    |      1 |    132K|    144K|00:00:00.01 |     879 |       |       |          |
----------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------
SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));


SELECT COU
FROM EMPLOYEES E
LEFT OUTER JOIN SALARIES S
ON E.EMP_NO = S.EMP_NO
WHERE S.SALARY > 50000;

SELECT * FROM TABLE(dbms_xplan.display_cursor(NULL, NULL, 'ALLSTATS LAST'));


