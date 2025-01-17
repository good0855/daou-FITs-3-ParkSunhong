-- 1번
--  직원의 직무 변경 기록과 상태
직원의 이름과 직원의 직무 변경 기록에서 JOB_ID를 표시하고, 직무 변경이 없는 경우 'No
Change'로 표시하세요.

SELECT E.NAME AS EMPLOYEE_NAME,
 NVL(JH.JOB_ID, 'No Change') AS JOB_HISTORY
FROM EMPLOYEES E
LEFT OUTER JOIN JOB_HISTORY JH
ON E.EMPLOYEE_ID = JH.EMPLOYEE_ID;


-- 2번
-- 최근 6개월 동안 발생한 거래의 계좌 ID와 거래 금액, 거래일, 고객 ID, 고객명을 조회하세
요. (단, 거래일은 년-월-일 시:분:초 형식으로 출력)

SELECT D.DEPARTMENT_NAME, E.NAME, NVL(E.SALARY, 0)
FROM EMPLOYEES E
LEFT OUTER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.NAME LIKE '%Employee 1%'
ORDER BY D.DEPARTMENT_NAME;

-- 3번
  최근 6개월 동안 발생한 거래의 계좌 ID와 거래 금액, 거래일, 고객 ID, 고객명을 조회하세
요. (단, 거래일은 년-월-일 시:분:초 형식으로 출력)

SELECT
    A.ACCOUNT_ID,
    T.AMOUNT,
    TO_CHAR(T.TRANSACTION_DATE, 'YYYY-MM-DD HH:MM:SS') AS TRANSACTION_DATE,
    C.CUSTOMER_ID,
    C.NAME
FROM TRANSACTIONS T, ACCOUNTS A, CUSTOMERS C
WHERE
    T.ACCOUNT_ID = A.ACCOUNT_ID AND
    A.CUSTOMER_ID = C.CUSTOMER_ID AND
    MONTHS_BETWEEN(SYSDATE, T.TRANSACTION_DATE) <= 6;
    

-- 4번
-- "Department 3", “Department 4, “Department 5, “Department 6 부서에 속하는
직원들의 직무별 직원 수를 조회하세요.
SELECT 
    E.JOB_ID,
    COUNT(E.JOB_ID) AS CNT
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.DEPARTMENT_NAME IN('Department 3', 'Department 4', 'Department 5', 'Department 6')
GROUP BY E.JOB_ID;


-- 5번
-- 계좌 유형별 평균 잔액을 조회한 뒤 버림하여 소수점 아래 둘째 자리 까지 출력하세요. (평균
잔액으로 내림차순, 출력 컬럼은 계좌 유형, 평균 잔액)

SELECT ACCOUNT_TYPE, TRUNC(AVG(BALANCE), 2) AS AVG_BALANCE
FROM ACCOUNTS
GROUP BY ACCOUNT_TYPE
ORDER BY AVG_BALANCE DESC;

-- 6번
-- 각 계좌의 거래 횟수를 조회하고 거래 횟수로 오름차순하여 출력하세요.
SELECT A.ACCOUNT_ID, COUNT(T.TRANSACTION_ID) B
FROM ACCOUNTS A
LEFT JOIN TRANSACTIONS T
ON A.ACCOUNT_ID = T.TRANSACTION_ID
GROUP BY A.ACCOUNT_ID
ORDER BY B ASC;


-- 7번
-- 2024년 1월 1일부터 2025년 12월 31일까지 발생한 거래 데이터를 기준으로 고객별 총 거
래 금액을 계산하세요. 결과는 거래 금액이 높은 순으로 정렬하고, 상위 10명의 고객만 조회
하세요.

SELECT S.* FROM
    (
        SELECT
            C.CUSTOMER_ID, SUM(T.AMOUNT) AS TRANS_SUM
        FROM
            CUSTOMERS C,
            ACCOUNTS A,
            TRANSACTIONS T
        WHERE C.CUSTOMER_ID = A.CUSTOMER_ID AND
        A.ACCOUNT_ID = T.ACCOUNT_ID AND
        T.TRANSACTION_DATE >= TO_DATE('20240101') AND T.TRANSACTION_DATE <= TO_DATE('20251231')
        GROUP BY C.CUSTOMER_ID
        ORDER BY TRANS_SUM DESC
        ) S
WHERE ROWNUM <= 10;

-- 8번
-- 급여 정보가 없는 직원의 이름과 부서 이름을 조회하세요.

SELECT E.NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E
LEFT JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.SALARY IS NULL;

-- 9번
-- 각 고객이 받은 대출 중 가장 높은 대출 금액을 조회하세요. 최대 대출 금액이 높은 순으로 정
렬하고, 상위 15명의 데이터를 출력하세요.

SELECT *
FROM (
    SELECT C.CUSTOMER_ID, MAX(L.AMOUNT) MAX_LOAN
    FROM CUSTOMERS C
    INNER JOIN LOANS L
    ON C.CUSTOMER_ID = L.CUSTOMER_ID
    GROUP BY C.CUSTOMER_ID
    ORDER BY MAX_LOAN DESC
    ) S
WHERE ROWNUM <= 15;


-- 10번
-- 급여가 7000 이상 15000 이하인 직원 데이터를 기준으로, 각 부서별 직원 수를 계산하세
요. 직원 수가 5명 이상인 부서만 출력하고, 직원 수가 많은 순으로 정렬하세요.
SELECT D.DEPARTMENT_ID, COUNT(E.EMPLOYEE_ID) C
FROM EMPLOYEES E
INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
WHERE E.SALARY BETWEEN 7000 AND 15000
GROUP BY D.DEPARTMENT_ID
HAVING COUNT(E.EMPLOYEE_ID) >= 5
ORDER BY C DESC;




