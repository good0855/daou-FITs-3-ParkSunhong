-- 실습 4
-- 1. 고객 테치블에서 고객 이름을 오름차순 정렬하여 출력하시오
SELECT NAME
FROM CUSTOMERS
ORDER BY NAME ASC;

-- 2. 계좌 테이블에서 잔액이 높은 순으로 계좌 ID와 잔액을 출력하시오
SELECT ACCOUNT_ID, BALANCE
FROM ACCOUNTS
ORDER BY BALANCE DESC;

-- 3. 거래 테이블에서 거래 금액이 낮은 순으로 거래 ID와 금액을 출력하시오.
SELECT TRANSACTION_ID, AMOUNT
FROM TRANSACTIONS
ORDER BY AMOUNT ASC;

-- 4. 대출 테이블에서 대출 금액이 높은 순으로 대출 ID와 고객 ID를 출력하시오.
SELECT LOAN_ID, CUSTOMER_ID
FROM LOANS
ORDER BY AMOUNT DESC;


-- 실습 5
-- 1. 고객 테이블에서 이름을 오름차순, 이메일을 내림차순 정렬
SELECT NAME, EMAIL
FROM CUSTOMERS
ORDER BY NAME ASC, EMAIL DESC;

-- 2. 계좌 테이블에서 잔액을 내림차순, 동일 잔액일 경우 계좌 ID를 오름차순으로 정렬
SELECT BALANCE
FROM ACCOUNTS
ORDER BY BALANCE DESC, ACCOUNT_ID ASC;

-- 3. 거래 테이블에서 거래 유형을 기준으로 오름차순, 거래 금액을 기준으로 내림차순 정렬하여 출력
SELECT TRANSACTION_TYPE, AMOUNT
FROM TRANSACTIONS
ORDER BY TRANSACTION_TYPE ASC, AMOUNT DESC;

-- 4. 대출 테이블에서 대출 상태를 기준으로 오름차순, 대출 금액을 기준으로 내림차순 하여 정렬
SELECT STATUS, AMOUNT
FROM LOANS
ORDER BY STATUS ASC, AMOUNT DESC;


-- 실습 6
-- 1. 승인된 대출의 총 대출 금액과 해당 대출 건수 출력
SELECT SUM(AMOUNT) AS AMOUNT_SUM, COUNT(AMOUNT) AS LOAN_COUNT
FROM LOANS;

--2. 각 월별 총 거래 금액을 계산하고, 거래 금액이 10000 이상인 달만 출력
SELECT TO_CHAR(TRANSACTION_DATE, 'YYYY-MM') AS MONTH, SUM(AMOUNT) AS AMOUNT_BY_MONTH
FROM TRANSACTIONS
GROUP BY TO_CHAR(TRANSACTION_DATE, 'YYYY-MM')
HAVING SUM(AMOUNT) >= 10000;

-- 3. 각 지점에서 승인된 대출의 평균 대출 금액과 총 대출 금액을 계산하시오.
SELECT BRANCH_ID, AVG(AMOUNT) AS MEAN, SUM(AMOUNT) AS SUM FROM LOANS
WHERE STATUS = 'APPROVED'
GROUP BY BRANCH_ID;


