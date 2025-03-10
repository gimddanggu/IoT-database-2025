use madang;		-- madang데이터베이스 선택

drop table if exists students; -- 현재 테이블 삭제

create table students (
	std_id integer primary key auto_increment,      -- auto_increment는  MYSQL 옵션.
	std_name varchar(100) not null,
	std_mobile varchar(20),
	std_regyear int not null
);

insert into students(std_name, std_mobile, std_regyear)
values ('홍길동', '010-9999-8888', 2020);