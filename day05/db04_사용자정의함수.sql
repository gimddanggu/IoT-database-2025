-- 사용자 정의함수. 내장함수 반대. 개발자가 직접 만드는 함수
-- 저장프로시저와 유사. RETURNS, RETURN 키워드가 차이남
-- 1418에러 발생 시 옵션 실행 
-- 맨 첫줄에서 실행해야되나봄
SET GLOBAL log_bin_trust_function_creators=ON;

-- 내장함수
SELECT char_length('HELLO WORLD')

-- 사용자 정의함수
DELIMITER //
CREATE FUNCTION fnc_Interest(
	price INTEGER
) RETURNS INTEGER
BEGIN
	DECLARE myInterest INTEGER;
    -- 가격이 3만원 이상이면 10% 이하면 5%
    IF price >= 30000 THEN SET myInterest = price * 0.1;
    ELSE SET myInterest = price * 0.05;
    END IF;
    RETURN myInterest;
END;
//
DELIMITER ;
-- 실행
SELECT custid, orderid, saleprice, fnc_Interest(saleprice) as '이익금'
  FROM Orders;
