create table stuscore(
    no number(4),
    name varchar(50),
    school varchar(100),
    rank number(1),
    height number(4,1),
    kor number(4,1),
    eng number(4,1),
    math number(4,1),
    total number(4,1),
    avg number(5,2),
    specialty varchar(50)
);

--------------------------------------
-- 순차정렬 : order by 컬럼명 / order by컬럼명 asc
select * from stuscore
order by height;

--역순정렬 : order by 컬럼명 desc
-- 키를 역순 -> 동일시 국어점수로 역순 -> 동일시 영어 정렬
select * from stuscore
order by height desc, kor desc, eng asc;


select * from stuscore;

-- 이름 순으로 역순정렬
select * from stuscore
order by name desc;

-- 학교 순으로 순차정렬, rank 역순정렬
select * from stuscore
order by school asc, rank desc;

-- employees 테이블에서 입사일 기준으로 순차정렬, 출력은 사원번호, 사원명, 직급, 입사일 칼럼을 출력하시오
-- 컬럼명보기
desc employees;  
select employee_id, emp_name, job_id, HIRE_DATE from employees
order by HIRE_DATE asc;

-- 사원번호, 부서, 입사일 출력하되, 정렬 부서는 순차, 입사일 역순정렬 하시오.
select * from employees;
select EMPLOYEE_ID,department_id,hire_date from employees
order by department_id asc, hire_date desc;

-----------------------------------------------------

-- dual 임시 테이블/ 가상테이블 : 보기만 할때

select -1 from dual;
select -1*3+100-100 from dual;

-- abs() : 절대값출력
select abs(-123) from dual;

-- round() : 반올림 /  round(값, 자리수)
select round(12.34567,2)from dual;

-- kor+eng+math를 그냥쓰면 컬럼명이 너무 김, 별칭을 써서 줄임.
select kor, eng , math, kor+eng+math total, (kor+eng+math)/3 avg from stuscore;

-- 평균을 소수점 2자리에서 반올림해서 출력하시오
select round((kor+eng+math)/3,2) avg from stuscore;

--floor :버림(자리수 없음)
select floor((kor+eng+math)/3) avg from stuscore;
--ceil :올림(자리수 없음)
select ceil((kor+eng+math)/3) avg from stuscore;

-- trunc: 버림(특정자리수 버림 가능) /  3번째 자리까지 출력 / 버림기준이 없으면 첫번째 자리에서 버림.
select (kor+eng+math)/3, trunc((kor+eng+math)/3,3) from stuscore;

--mod :나머지 / 3을 2로 나누었을 때 나머지
select mod(3,2) from dual;

-- -1로 정수부분에서 반올림, 버림 할 수 있음.
select kor, round(kor,-1),trunc(kor,-1)from stuscore;


-- 1915,1819,1719 를 1900년대 처럼 만드시오. (dual사용)
select round(1915,-2),round(1819,-2),round(1719,-2) from dual;
select trunc(1915,-2),trunc(1819,-2),trunc(1719,-2) from dual;

-- 사원번호가 홀수인 사원을 출력하시오. 역순정렬로 출력하시오
select * from employees;
desc employees;
select mod(employee_id,2) from employees
where mod(employee_id,2)=1
order by employee_id desc;

-- stuscore 평균값이 80점이상인 학생만 출력하시오
select (kor+eng+math)/3 avg from stuscore
where (kor+eng+math)/3>=80
order by avg desc;

-- stuscore에서 no 가 짝수인 학생을 출력하시오
select * from stuscore
where mod(no,2)=0;


-------------------------------------------------------
-------------------------------------------------------

-- 시퀀스 : 번호가 자동으로 증가하는 프로그램

select * from stuscore;
select * from board;

-- 1씩 증가 : 내려가는것 없음, 에러 방지를 위해, 삭제해서 다시 만드는 수 밖에 없음.
select board_seq.nextval from dual;
select board_seq.currval from dual;

-- 테이블 복사
-- 테이블 복사(컬럼)와 데이터 복사를 함께 실행
create table stuscore2 as select * from stuscore;
-- 테이블구조(컬럼)만 복사 (1=2 라는 절대 참이 될 수 없는 조건을 걸어 컬럼만 복사)
create table stuscore3 as select * from stuscore where 1=2;

select * from stuscore2;
select * from stuscore3;

insert into stuscore3 values(
board_seq. nextval, '홍길동', '신림고',1,190,100,100,100,(100+100+99),
(100+100+99)/3,'python');

delete stuscore3; -- stuscore3테이블 데이터 삭제
commit;           -- 저장

-- stuscore2_seq 시퀀스를 101부터 시작
-- stuscore2 홍길동 학생 성적을 입력해보세요.
insert into stuscore2 values(
stuscore2_seq.nextval, '홍길동','신림고',1,190,100,100,99,(100+100+99),
(100+100+99)/3,'python');
commit;

create sequence board2_seq
increment by 1
start with 1
minvalue 1
maxvalue 9999
nocycle
NOCACHE;


--------------------------------------------

-- sql의 기본 select, insert, update, delete
-- 게시판 리스트 : select     select * from stuscore
-- 게시글 입력 : insert      insert into stuscore values (    )
-- 게시글 수정 : update      update stuscore set name = '홍길자' where no=1
-- 게시글 삭제 : delete      delete stuscore where no=1
-- 게시글 저장 : commit

select * from stuscore2;
select stuscore2_seq.currval from dual;
--101
insert into stuscore2 values(
stuscore2_seq.nextval, '유관순','신림고',1,170,90,90,91,271,271/3,'c');

select * from stuscore2;
delete stuscore2 where no=9;

update stuscore2 set name = '유관자' where no=102;


-- board 그래로 구조, 데이터 모두 복사해서 board2
-- 시퀀스 board2 생성해서 시작 101부터
-- 1개의 게시글을 입력해서 출력하시오

create table board2 as select * from board;
select board2_seq.nextval from dual; --101
select * from board2;
insert into board2 values(
board2_seq.nextval, 'aaa','게시글 제목','게시글내용입니다.',
board2_seq.currval,0,0,0,sysdate,'');
-- insert 입력 컬럼을 선택을 안하려면, 모든 컬럼의 값을 입력해야함
insert into board2 (bno,id,btitle,bcontent, bgroup) values(
board2_seq.nextval, 'aaa','게시글 제목','게시글내용입니다.',
board2_seq.currval);

commit;


-------------------------------------------

-- 속성 : default 0 --?????
desc board2;
alter table board2 modify (bstep default 0);

insert into board2(bno,id,btitle,bcontent,bgroup,bfile) values(
board2_seq.nextval,'aaa','제목','내용',
board2_seq.currval,'1.jpg'
);
select * from board2;

-- bno primary key 등록
alter table board2 add primary key (bno);
desc board2;

--drop table board2;
--drop table stuscore2;
--drop table stuscor3;
-- 시퀀스도 전부 삭제 후 board_seq를 생성 1부터 시작,1씩 증가
------------------------------------------------
---------------------------------------------------


create table board2 (
 bno number(4) primary key,
 id varchar2(50) not null,
 btitle varchar2(1000) not null,
 bcontent clob not null,
 bgroup number(4),
 bstep number(4) default 0,
 bindent number(4) default 0,
 bhit number(4) default 0,
 bdate date default sysdate,
 bfile varchar2(100)
 );
 
 -- board, board2 테이블 구조가 같음.
 -- board의 데이터를 board2로 복사
 insert into board2 select * from board;
 select * from board2;
 
 select board2_seq.nextval from dual; --101 에서 시작
 select board2_seq.currval from dual;
 commit;
 
 -- 오라클에는 (숫자타입, 문자타입, 날짜타입)
 --number/ varchar2, char, clob, date
 
delete board2;
commit;
select * from board2;

insert into board2(bno,id,btitle, bcontent, bgroup,bdate) values(
1,'aaa','제목','내용',1,sysdate);

select * from stuscore;

drop table member;

create table member(
id varchar2(50) primary key,
pw varchar2(100) not null,
name varchar2(30) not null,
nickname varchar2(30),
tel char(12),
gender char(6) default '남자',
hobby varchar(50) default '게임',
mdate date default sysdate);

drop table screen;

create table screen(
sno number(3),
rank number(3),
title varchar2(1000),
sdate date,
percent number(10,3),
revenue number(20),
crevenue number(20),
sales number(10),
csales number(10));

select * from screen;
desc screen;

-------------------------------------------
----------------------------------------------

-- 영화목록 테이블 저장
create table movie_list(
movieCd varchar(20),
movieNm varchar(300),
movieNmEn varchar(500),
prdtYear date,
openDt date,
typeNm VARCHAR2(100),
prdtStatNm varchar2(50),
nationAlt varchar2(100),
genreAlt varchar(100),
repNationNm varchar(100),
repGenreNm varchar(50),
directors varchar(300),
companys varchar(300));





------------------------------------------------
-- 선생님이 하신것--------------------------------

create table searchmovie (
mno number(7),
movieCd char(10),
movieNm varchar(200),
movieNmEn varchar(200),
prdtYear number(4), -- varchar2, number 차이
openDt varchar2(20),
typeNm varchar2(20),
prdtStatNm varchar2(20),
nationAlt varchar2(20),
genreAlt varchar2(200),
repNationNm varchar2(50),
repGenreNm varchar2(50),
directors varchar2(1000),
companys varchar2(1000)
);

select * from searchmovie;
