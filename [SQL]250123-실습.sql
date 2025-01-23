
-- 1. 지점별 승인된 대출의 총 금액을 계산한 뒤, 해당 금액이 전체 지점에서 승인된 대출 금액의
-- 평균보다 낮은 지점의 지점명과 승인된 대출의 총 금액, 전체 지점에서 승인된 대출 금액의 평균을 출력하세요.
-- 평균값은 반올림하여 소수점 아래 둘째자리까지 표현합니다.


SELECT 
    B.NAME, 
    S.SUM, 
    ROUND(S.TOTAL_AVG_SUM, 2) AS TOTAL_AVG_SUM
FROM 
(
    SELECT 
        DISTINCT BRANCH_ID,
        SUM(AMOUNT) OVER(PARTITION BY BRANCH_ID) AS SUM,
        AVG(AMOUNT) OVER() AS TOTAL_AVG_SUM
    FROM LOANS
    WHERE STATUS = 'APPROVED'
) S
LEFT JOIN BRANCHES B
ON B.BRANCH_ID = S.BRANCH_ID
WHERE S.SUM < S.TOTAL_AVG_SUM;
