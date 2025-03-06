-- 데이터베이스 관리

SHOW DATABASES;

-- information_schema, performance_schema, mysql 등은 시스템 DB라서 개발자, DBA 사용하는 게 아님
USE mysql;
USE madang;
-- 하나의 DB내 존재하는 테이블들 확인
SHOW tables;

-- 테이블의 구조
desc madang.NewBook;

select * from v_orders;

-- 사용자 추가
-- madang DB만 접근할 수 있는 사용자 madang을 생성
-- 내부접속용
CREATE USER madang@localhost IDENTIFIED BY 'madang';
-- 외부접속용
CREATE USER madang@'%' IDENTIFIED BY 'madang';

-- DCL: grant, revoke
-- 데이터 삽입, 조회 수정만 권한을 부여
GRANT SELECT, INSERT, UPDATE ON madang.* TO madang@localhost with grant option;
GRANT SELECT, INSERT, UPDATE ON madang.* TO madang@'%' with grant option;
flush privileges;

-- 사용자 madang에게 madangDB를 사용할 수 있는 모든 권한 부여
GRANT ALL PRIVILEGES ON madang.* TO 'madang'@localhost with grant option;
GRANT ALL PRIVILEGES ON madang.* TO 'madang'@'%' with grant option;
flush privileges;

-- 권한해제
REVOKE INSERT ON madang.* FROM madang@localhost;
REVOKE INSERT ON madang.* FROM madang@'%';
flush privileges;

-- 권한확인
SHOW GRANTS FOR madang@localhost;
SHOW GRANTS FOR madang@'%';
