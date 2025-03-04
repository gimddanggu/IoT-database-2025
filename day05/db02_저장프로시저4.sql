-- 5-4 Order 테이블의 판매 도서에 대한 이익금을 계산하는 프로시저
DELIMITER //
CREATE PROCEDURE GetInterest(
)
BEGIN
	-- 변수선언
    DECLARE myInterest FLOAT DEFAULT 0.0;
    DECLARE price INTEGER;
    DECLARE endOfRow BOOLEAN DEFAULT FALSE;
    DECLARE InterestCursor CURSOR FOR
			SELECT saleprice FROM Orders;
	DECLARE CONTINUE HANDLER
			FOR NOT FOUND SET endOfrow=TRUE;
            
-- 커서오픈
	OPEN InterestCursor;
    cursor_loop: LOOP
		FETCH InterestCursor INTO price;	-- SELECT salprice from Orders의 테이블 한행씩 읽어서 값을 price에 집어넣는다.
	
    
    END LOOP cursor_loop;
END;