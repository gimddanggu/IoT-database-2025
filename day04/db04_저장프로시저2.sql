-- 5-2 동일도서를 파악 후 있으면 도서가격 변경, 없으면 삽입하는 프로시저
USE madangdb;

delimiter //
CREATE PROCEDURE BookInsertOrUpdate(
	IN mybookid		INTEGER,
    IN mybookname	VARCHAR(40),
    IN mypublisher	VARCHAR(40),
    IN myprice		INTEGER)
BEGIN
	/*변수선언*/
    DECLARE mycount INTEGER;
    -- 1. 데이터가 존재하는 수를 mycount 변수에 할당
    SELECT COUNT(*) INTO mycount
      FROM Book
	 WHERE bookname LIKE CONCAT('%', mybookname, '%');

	-- 2. mycount 0보다 크면 동일 도서 존재
    IF mycount > 0 THEN
		SET SQL_SAFE_UPDATES = 0; /*DELETE, UPDATE시 safe모드 해제*/
		UPDATE Book SET price = myprice
		 WHERE bookname LIKE CONCAT('%', mybookname, '%');
    ELSE
		INSERT INTO Book(bookid, bookname, publisher, price)
			 VALUES (mybookid, mybookname, mypublisher, myprice);
    END IF;
END;
//DELIMITER ;

-- 1번째 실행 
CALL BookInsertOrUpdate(33, '스포츠의 즐거움', '마당과학', 25000);

SELECT * FROM Book;