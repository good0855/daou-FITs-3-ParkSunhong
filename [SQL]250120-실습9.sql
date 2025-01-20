-- 실습과제 9

-- 1. 직원과 부서 정보를 조합하여 직무와 급여 통계
-- 모든 부서에서 직무별 평균 급여와 해당 직무에서 가장 높은 급여를 계산하세요.
-- 결과는 부서 이름, 직무 ID, 평균 급여, 최대 급여로 출력되며, 평균 급여가 8000 이상인 결과만 조회하세요.
-- 결과는 평균 급여 기준으로 내림차순 정렬하고 평균 급여는 반올림하여 소수점 아래 둘째자리까지 표현합니다. (스칼라 서브 쿼리 사용)
SELECT
    (
        SELECT D.DEPARTMENT_NAME
        FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
    ) DEPARTMENT,
    E.JOB_ID AS JOB_ID,
    ROUND(AVG(E.SALARY), 2) AS AVG_SALARY,
    MAX(E.SALARY) AS MAX_SALARY
FROM EMPLOYEES E
GROUP BY E.DEPARTMENT_ID, E.JOB_ID
HAVING AVG(E.SALARY) >= 8000
ORDER BY AVG_SALARY DESC;


-- 2.5년 이내에 입사한 직원들의 급여와 전체 직원 급여 비교
-- 최근 5년 이내에 입사한 직원들의 부서별 평균 급여와 전직원들의 평균 급여를 비교하여,
-- 최근 5년 내에 입사한 직원들의 급여가 더 높은 경우에 해당하는 부서 이름과 해당 부서 평균 급여를 조회하세요. 
-- (단, 부서 평균 급여는 올림하여 정수로 나타냅니다.)

SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
-- 최근 5년 구하기


SELECT
    D.DEPARTMENT_NAME,
    CEIL(EE.AVG_SALARY)
FROM DEPARTMENTS D,
    -- 5년 내에 입사한 부서별 직원들의 평균 급여 
    (SELECT
        DEPARTMENT_ID,
        AVG(SALARY) AS AVG_SALARY
    FROM EMPLOYEES
    WHERE ADD_MONTHS(SYSDATE,-60) - HIRE_DATE <= 5
    GROUP BY DEPARTMENT_ID
    ) EE
WHERE
    D.DEPARTMENT_ID = EE.DEPARTMENT_ID AND -- INNER JOIN
    EE.AVG_SALARY >= (SELECT AVG(SALARY) FROM EMPLOYEES) ;


-- 3. 특정 지역의 지점에서 대출을 받은 고객 조회
-- 위치(Location)가 'Location 4'인 지점에서 대출을 받은 고객 중 대출 금액이 50,000 이상인 고객의 이름, 대출 금액, 대출 상태를 조회하세요.

SELECT C.NAME, L.AMOUNT, L.STATUS
FROM CUSTOMERS C, LOANS L
WHERE C.CUSTOMER_ID IN (
    SELECT CUSTOMER_ID FROM LOANS
    WHERE BRANCH_ID IN (
        SELECT BRANCH_ID FROM BRANCHES
        WHERE LOCATION = 'Location 4'
    )
)
AND C.CUSTOMER_ID = L.CUSTOMER_ID
AND L.AMOUNT >= 50000;


-- 4. 대출 상태가 'PENDING'인 고객과 'REJECTED'인 고객의 교집합
-- 대출 상태가 'REJECTED'인 고객과 'PENDING'인 고객 중 두 상태 모두 해당되는 고객의 이름과 이메일, 전화번호를 조회하세요
SELECT
    NVL(NAME, 'N/A')AS NAME,
    NVL(EMAIL, 'N/A') AS EMAIL,
    NVL(PHONE, 'N/A') AS PHONE
FROM CUSTOMERS
WHERE CUSTOMER_ID IN (
    SELECT CUSTOMER_ID FROM LOANS
    WHERE STATUS = 'PENDING'
    UNION
    SELECT CUSTOMER_ID FROM LOANS
    WHERE STATUS = 'REJECTED'
);


-- 5. 대출 상태와 계좌 잔액 통계 병합
-- 계좌 잔액이 50,000 이상인 고객과 대출 상태가 'PENDING'인 고객을 병합하여 결과를 조회하세요.
-- 출력 데이터는 [고객 이름], [계좌 잔액 및 대출 금액 = 동일 컬럼] 이며 헤더명은 “고객 이름”, “금액” 으로 표시하고 고객 이름으로 오른차순 정렬합니다.
--SELECT 
--    NAME AS '고객이름',
--    BA
--FROM CUSTOMERS
--WHERE CUSTOMER_ID IN (

SELECT
    NAME AS "고객 이름",
    BALANCE AS "금액"
FROM 
CUSTOMERS C
INNER JOIN (
    SELECT CUSTOMER_ID, BALANCE FROM ACCOUNTS
    WHERE BALANCE >= 50000
    UNION ALL
    SELECT CUSTOMER_ID, AMOUNT AS BALANCE FROM LOANS
    WHERE STATUS = 'PENDING'
    ) D
ON C.CUSTOMER_ID = D.CUSTOMER_ID
ORDER BY "고객 이름" ASC;
