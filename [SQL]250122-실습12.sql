-- SQL 작성 12
-- 1. 사원 테이블에서 부서별로 급여의 합계를 계산하고 전체 합계를 함께 출력하시오(단 부서데이터가 NULL인 사원은 제외)
SELECT 
    NVL(TO_CHAR(DEPARTMENT_ID), '총합') AS DEPARTMENT_ID,
    SUM(SALARY) AS SUM_SALARY FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY ROLLUP(DEPARTMENT_ID)
ORDER BY DEPARTMENT_ID;

-- 2. 같은 날짜에 입사한 사원이 2명 이상인 날짜와 입사한 사원수, 마지막 행은 총 직원수를 함께 출력하시오.
SELECT 
    NVL(TO_CHAR(HIRE_DATE), '총합') AS HIRE_DATE,
    COUNT(EMPLOYEE_ID) AS EMPLOYEMENT_CNT
FROM EMPLOYEES
GROUP BY ROLLUP(HIRE_DATE)
ORDER BY HIRE_DATE ASC;

-- 3. 각 지점별 대출 금액 합계와 모든 지점의 총합계를 출력하시오.
-- 출력 컬럼은 지점명, 대출금액 합계이며, 
-- 지점 총합계는 'All Branch` 로 출력하고 지점명으로 정렬하되 총합계는 맨 아랫줄에 나타내시오

SELECT 
    NVL(B.NAME, 'ALL Branch') as BRANCH_NAME,
    S.SUM_AMOUNT
FROM BRANCHES B
RIGHT JOIN (

    SELECT 
        BRANCH_ID,
        SUM(AMOUNT) SUM_AMOUNT 
    FROM LOANS
    WHERE BRANCH_ID IS NOT NULL
    GROUP BY ROLLUP(BRANCH_ID)
    
    ) S
ON B.BRANCH_ID = S.BRANCH_ID
ORDER BY B.NAME;
