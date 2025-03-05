-- 동시성 제어
-- 자동커밋 해제
SET AUTOCOMMIT = 0;

START TRANSACTION;

SELECT * FROM Book;

INSERT INTO Book VALUES (98, '데이터베이스', 25000);

UPDATE Book SET price = 30000 WHERE bookid = 98;

COMMIT