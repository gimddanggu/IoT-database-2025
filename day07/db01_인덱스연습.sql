-- 기존테이블 삭제
DROP TABLE IF EXISTS NewBook;

-- 테이블 생성
CREATE TABLE NewBook (
	bookid INTEGER AUTO_INCREMENT PRIMARY KEY,
    bookname VARCHAR(100),
    publisher VARCHAR(100),
    price INTEGER
);

-- 500만 건 더미데이터 생성 설정
SET SESSION cte_max_recursion_depth = 5000000;

-- 더미데이터 생성
INSERT INTO NewBook (bookname, publisher, price)
WITH RECURSIVE cte(n) AS
(
	SELECT 1
    UNION ALL
    SELECT n+1 FROM cte WHERE n < 5000000
)
SELECT CONCAT('Book', LPAD(n, 7, '0')) -- Book0000101
	 , CONCAT('Comp', LPAD(n, 7, '0'))
     , FLOOR(3000 + RAND() * 30000) AS price -- 책 가격 3000 ~ 30000
  FROM cte;
  
-- 데이터 확인
SELECT COUNT(*) FROM NewBook;

SELECT * FROM NewBook
  WHERE price between 20000 and 250000;
  
-- 가격을 7개 정도 검색할 수 있는 쿼리 작성
SELECT * FROM NewBook
 WHERE price in (6000, 28000, 19300, 28000, 5600, 17000); 
-- 884 row(s) returned	0.656 sec / 0.656 sec

-- 인덱스 생성
CREATE INDEX idx_book ON NewBook(price);

-- 인덱스 생성 후 시간 변화 확인
SELECT * FROM NewBook
 WHERE price in (6000, 28000, 19300, 28000, 5600, 17000); 
-- 884 row(s) returned	0.078 sec / 0.062 sec
