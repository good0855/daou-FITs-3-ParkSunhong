-- 실습과제 8
-- 1. 지점 이름이 "Location 1"에 해당하는 지점에서 대출을 받은 고객의 이름을 출력하시오.
SELECT NAME
FROM CUSTOMERS
WHERE CUSTOMER_ID IN (
    SELECT CUSTOMER_ID
    FROM LOANS
    WHERE BRANCH_ID IN (
        SELECT BRANCH_ID
        FROM BRANCHES
        WHERE LOCATION = 'Location 1'
    )
);
    

-- 2. 특정 고객(Customer_id = 100)이 수요한 모든 계좌에서 발생한 거래를 출력하세요.
SELECT * FROM TRANSACTIONS
WHERE ACCOUNT_ID IN (
    SELECT ACCOUNT_ID
    FROM ACCOUNTS
    WHERE CUSTOMER_ID = 100
);


-- 3. 각 고객이 보유한 계좌 중 가장 높은 잔액을 가진 계좌를 출력하시오.
SELECT * FROM ACCOUNTS A1
WHERE BALANCE = (
    SELECT MAX(BALANCE)
    FROM ACCOUNTS A2
    WHERE A1.CUSTOMER_ID = A2.CUSTOMER_ID
);
