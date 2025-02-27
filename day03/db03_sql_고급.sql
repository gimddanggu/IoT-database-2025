-- 내장함수
-- 4-1 -78과 78의 절대값을 구하시오
-- TABLE을 가져오지 않으면 FROM 은 필요없음
-- 그치만 그럴 일이 거의 없음
SELECT ABS(-78), ABS(78);

-- 4-2 4.875를 소수점 첫번째 자리까지 반올림 하시오.
SELECT ROUND(4.875, 1) AS 결과; 

-- 4-3 고객별 평균 주문 금액을 100원 단위로 반올림한 값을 구하시오.ALTER
SELECT custid, round(sum(saleprice) / count(*), -2) AS 평균금액
  FROM Orders
GROUP BY custid;

-- 문자열 내장함수
-- 4-4 도서 제목에서 야구가 포함된 도서명을 농구로 변경한 후 출력하시오.
-- SELECT 는 검색 결과를 나타내는 거지 DB 값 자체를 변경하는 것이 아님
-- 값 변경은 UPDATE문 사용해야 한다.
SELECT Bookid
	 , REPLACE(bookname, '야구', '농구') AS bookname
     , publisher
     , price
  FROM Book;
  
-- 추가
SELECT 'Hello', 'MySQL';

SELECT CONCAT('Hello', 'MySQL', 'wow') AS CONCAT결과;

-- 4-5 굿스포츠에서 출판한 도서의 제목과 제목의 문자수, 바이트수를 구하시오
SELECT bookname as '제목'
	 , char_length(bookname) as '제목 문자수' 	-- 글자 길이를 구할 때
     , length(bookname) as '제목 바이트수'		-- 글자 바이트수 구할 때
												-- utf8에서 한글 한 글자의 바이트 수는 3bytes
  FROM Book
 WHERE publisher = '굿스포츠';
 
-- 4-6 고객 중 성이 같은 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
-- SUBSTR(자를 원본 문자열, 시작 인덱스, 길이)
-- DB는 인덱스를 1부터 시작!!! (프로그래밍 언어와 차이점)

select substr('김다현',1, 1);
 
SELECT SUBSTR(name, 1, 1) as '성씨 구분'
	 , count(*) as '인원 수'
FROM Customer
GROUP BY SUBSTR(name, 1, 1);


-- 추가 trim()
SELECT CONCAT('--', TRIM('     hELLO           '), '--');
SELECT CONCAT('--', LTRIM('     hELLO          '), '--');
SELECT CONCAT('--', RTRIM('     hELLO          '), '--');


-- 새롭게 추가된 trim() 함수
SELECT TRIM('=' FROM '=== -HELLO- ===');


-- 날짜시간 함수
SELECT SYSDATE(); -- Docker 서버시간을 따라서 GMT(그리니치 표준시)를 따름 +9hour

SELECT ADDDATE(SYSDATE(), INTERVAL 9 HOUR);

-- 4-7 마당서점은 주문일부터 10일 후에 매출을 확정한다. 각 주문의 확정일자를 구하시오
SELECT orderid AS '주문번호'
	 , orderdate AS '주문일자'
     , ADDDATE(orderdate, INTERVAL 10 DAY) AS '확정일자'
  FROM Orders;
  
-- 추가, 나라별 날짜, 시간응ㄹ 표현하는 포맷이 다름
SELECT SYSDATE() AS '기본날짜/시간'
	 , DATE_FORMAT(SYSDATE(), '%M/%d/%Y %H:%m:%s');
     
-- 4-8 2014년 7월 7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 나타내시오.
-- 단, 주문일은 %Y-%m-%d 형태로 표시한다.
-- %Y = 년도전체 ,%y = 년도 뒤2자리, %M = July(월이름), %b = Jul(월약어) %m = 07(월숫자)
-- %d = 일, %H = 24시간(16) %h = 12시간 기준 (04) %W = Monday, %w = 1(일요일 0)
-- %p = AM/PM

SELECT orderid AS '주문번호'
	 , DATE_FORMAT(orderdate, '%Y-%m-%d') AS '주문일'
     , custid AS '고객번호'
     , bookid AS '도서번호'
  FROM Orders;
  
-- DATEDIFF: D-day
SELECT DATEDIFF(SYSDATE(), '2025-02-03');

-- Formatting, 1000단위마다 , 넣기
SELECT bookid
	 , FORMAT(price, 0) AS price
  FROM MyBook;


-- NULL = Python None 동일. 모든 다른 프로그래밍 언어에서는 전부 NULL 또는 NUL
-- 추가. 금액이 NULL일때 발생되는 현상

SELECT price - 5000
  FROM MyBook
 WHERE bookId = 3;
 
 
 -- 핵심. 집계함수가 다 꼬임
 SELECT SUM(price) AS '합산은 그닥 문제없음'
	  , AVG(price) AS '평균은 NULL이 빠져서 꼬임'
      , COUNT(*) AS '모든 행의 갯수는 일치'
      , COUNT(price) AS 'NULL값은 갯수에서 빠짐'
   FROM MyBook;
   
-- NULL값 확인. NULL은 비교연산자 (=, >, <, <>, ..) 사용불가
-- IS 키워드 사용
SELECT *
  FROM MyBook
 WHERE price IS NULL;	-- 반대는 IS NOT NULL
 -- 공백이랑 NULL 은 다른거임!!
 
 -- IFNULL 함수
 -- 검색 결과 0으로 나타나게 한 것이지 실제 DB상에 NULL이 변경된 것이 아님
SELECT bookid
	 , bookname
     , IFNULL(price, 0) AS price
  FROM MyBook