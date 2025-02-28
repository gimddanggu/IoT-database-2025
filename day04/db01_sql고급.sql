-- 행번호
-- 4-11 고객목록에서 고객번호, 이름, 전번을 앞의 2명만 출력하시오.
SET @seq :=0;	-- 변수선언 SET시작하고 @를 붙임. 값할당이 =이 아니고 :=

SELECT (@seq := @seq + 1) AS 행번호
	 , custid
	 , name
     , phone
  FROM Customer
 WHERE @seq < 2;


SELECT custid
	 , name
     , phone
  FROM Customer LIMIT 2;	 -- 순차적인 일부데이터 추출에는 훨씬 탁월
  
  -- 특정범위 추출
SELECT custid
	 , name
	 , phone
  FROM Customer LIMIT 2 OFFSET 3;
