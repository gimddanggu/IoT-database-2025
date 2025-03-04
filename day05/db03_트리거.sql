-- 트리거
-- 시작 전 설정 변경
-- 다음 버전MySQL에서는 사라질 예정 (Deprecated)
SET GLOBAL log_bin_trust_function_creators=ON;

-- Book_log 테이블 생성
CREATE TABLE Book_log (
	bookid_l		INTEGER,
    bookname_l		VARCHAR(40),
    publisher_l		VARCHAR(40),
    price_l			INTEGER
);

-- 트리거 생성
-- UPDATE, DELETEㄴ 시는 old. 라고 사용 AFTER UPDATE ON 테이블명..ALTER
-- BEFORE INSERT, UPDATE, DELETE ... 
DELIMITER //
CREATE TRIGGER AfterInsertBook
	AFTER INSERT ON Book FOR EACH ROW /*트리거가 Book테이블에 데이터가 새로 추가되며 바로 발동*/
BEGIN
	DECLARE average INTEGER;
    INSERT INTO Book_log
    VALUES (new.bookid, new.bookname, new.publisher, new.price);
END;
// 
DELIMITER ;
-- Book테이블에 INSET 실행 트리거는 Book 테이블에 새로운 데이터가 들어오면 자동으로 실행됨
INSERT INTO Book VALUES (40, '안드로이드는 전기양의 꿈을 꾸는가', '이상미디어', 25000);