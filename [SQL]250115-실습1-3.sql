-- 실습과제 1
-- 1. 고객 테이블에서 모든 고객의 이름과 이메일 출력
SELECT NAME, EMAIL FROM CUSTOMERS;

-- 2. 계좌 테이블에서 모든 계좌의 계좌 ID와 잔액 출력
SELECT ACCOUNT_ID, BALANCE FROM ACCOUNTS;

-- 3. 거래 테이블에서 모든 거래의 금액과 거래의 유형 출력
SELECT AMOUNT, TRANSACTION_TYPE FROM TRANSACTIONS;


-- 실습과제 2
-- 1. 고객 테이블에서 특정 주소를 가진 고객의 이름과 전화번호 출력
SELECT NAME, PHONE FROM CUSTOMERS
WHERE ADDRESS = 'Address 100';

-- 2. 계좌 테이블에서 잔액이 50000 이상인 계좌의 계좌 ID와 잔액 출력
SELECT ACCOUNT_ID, BALANCE FROM ACCOUNTS
WHERE BALANCE >= 50000;

-- 3. 거래 테이블에서 거래 금액이 음수인 거래의 ID와 금액 출력
SELECT TRANSACTION_ID, AMOUNT FROM TRANSACTIONS
WHERE AMOUNT < 0;

-- 4. 대출 테이블에서 상태가 "APPROVED"인 대출의 대출 금액과 고객 ID를 출력
SELECT AMOUNT, CUSTOMER_ID FROM LOANS
WHERE STATUS = 'APPROVED';


-- 실습과제 3
-- 1. 고객테이블에서 "555-1000"으로 시작하는 전화번호를 가진 고객의 이름과 이메일 출력
SELECT CUSTOMER_ID, EMAIL FROM CUSTOMERS
WHERE PHONE LIKE '555-1000%';

-- 2. 계좌 테이블에서 계좌 유형이 "SAVINGS"이고 잔액이 10000이상인 계좌의 계좌 ID및 잔앵ㄱ 출력
SELECT ACCOUNT_ID, BALANCE FROM ACCOUNTS
WHERE ACCOUNT_TYPE = 'SAVINGS' AND BALANCE >= 10000;

-- 3. 거래 테이블에서 거래 유형이 "DEPOSIT"이고 거래 금액이 1000이상인 거래의 거래 ID와 금액 출력
SELECT TRANSACTION_ID, AMOUNT FROM TRANSACTIONS
WHERE TRANSACTION_TYPE = 'DEPOSIT' AND AMOUNT >= 1000;

-- 4. 대출 테이블에서 대출 금액이 50000이상이며 대출 상태가 "PENDINGS"인 대출 ID와 금액 출력
SELECT LOAN_ID, AMOUNT FROM LOANS
WHERE AMOUNT >= 50000 AND STATUS = 'PENDING';
