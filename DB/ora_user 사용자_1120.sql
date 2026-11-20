drop table board;

drop table board2;

drop table stuscore;



create table board(
bno number(4) primary key,
id varchar2(50) not null,
btitle varchar2(1000),
bcontent clob,
bgroup number(4),
bstep number(4) default 0,
bindent number(4) default 0,
bhit number(4) default 0,
bdate date default sysdate,
bfile varchar2(100)
);

select * from employees;

-- select board_seq.nextval from employees;
-- nextval 1씩 증가
-- currval 현재 시퀀스 번호가 몇번인지 알려줌.
select board_seq.nextval from dual;
select board_seq.currval from dual;

select * from board;
insert into board values(
board_seq.nextval,'aaa','게시글제목','게시글내용',
board_seq.currval,0,0,0,sysdate,'1.jpg'
);

insert into board (bno,id,btitle,bcontent,bgroup,bfile) values(
board_seq.nextval,'aaa','게시글제목2','게시글내용2',
board_seq.currval,'2.jpg'
);

-- select, insert, update, delete / commit,rollback

rollback;
select * from board;

-- 테이블구성, 테이블데이터 모두 복사
create table board2 as select * from board;

-- 테이블구성만 복사
create table board3 as select * from board where 1=2;

drop table board;
drop table board2;
drop table board3;

-----------------------------------------------------

-- board테이블 생성후 board.csv파일을 import하시오.
create table board(
bno number(4) primary key,
id varchar2(50) not null,
btitle varchar2(1000),
bcontent clob,
bgroup number(4),
bstep number(4) default 0,
bindent number(4) default 0,
bhit number(4) default 0,
bdate date default sysdate,
bfile varchar2(100)
);

-- board2-데이터까지 복사해서 생성,board3-구조만 복사 생성하시오.
create table board2 as select * from board;
create table board3 as select * from board where 1=2;

-- stu2.xlsx 관련된 stuscore테이블을 생성하고 파일을 import하시오.
create table stuscore(
no number(3) primary key,
name varchar2(1000),
school varchar2(500),
rank number(3),
height number(3),
kor number(3),
eng number(3),
math number(3),
total number(3),
avg number(5,2),
specialty varchar2(100)
);
-- students.xlsx 파일을 students테이블을 생성해서 import하시오.
create table students(
no number(3) primary key,
name varchar2(1000),
school varchar2(500),
rank number(3),
height number(3),
kor number(3),
eng number(3),
math number(3),
total number(3),
avg number(5,2),
specialty varchar2(100)
);
-- member테이블 생성하시오.

create table member (
id varchar2(50) primary key,
pw varchar2(100) not null,
name varchar2(30) not null,
nickname varchar2(30),
tel char(12),
gender char(6) default '남자',
hobby varchar2(50) default '게임',
mdate date default sysdate
);

--searchmovie 테이블을 만드시오

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

--------------------------------------------------

create table gallerylist (
    gno number(12) primary key,
    galContentId varchar2(8) not null,
    galContentTypeId varchar2(10),
    galTitle varchar2(100),
    galWebImageUrl varchar2(100),
    galCreatedtime varchar2(100),
    galModifiedtime varchar2(100),
    galPhotographyMonth varchar2(30),
    galPhotographyLocation varchar2(100),
    galPhotographer varchar2(100),
    galSearchKeyword varchar2(1000)
);


-------------------------------------

select * from stuscore;

-- order by asc, desc
select * from stuscore
order by rank, height asc, kor desc;


-- 숫자함수
-- abs: 절댓값
select abs(-1) from dual;

-- round: 반올림, ceil: 올림, floor:버림,trunc:자르기
select 100/6 from dual; --16.66666...
-- 소수점 자리수 지정가능
select round(100/6) from dual; --17
select round(100/6,2) from dual; --16.17
select round(100/6,-1) from dual; --20, 1의 자리수에서 반올림
-- 무조건 소수점 첫번째 자리에서 실행
select floor(100/6) from dual; --16
select ceil(100/6) from dual; --17
-- 무조건 자름
select trunc(100/6) from dual; --16
select trunc(100/6,-1) from dual; --10, 1의 자리수부터 자름

-- mod( , ): 나머지를 구할 수 있음
select mod(22,2) from dual;
-- rank가 홀수인 학생을 출력하시오
select * from stuscore
where mod(no,2)=1;

select * from stuscore
where rank in (1,3);

select * from stuscore
where rank=1 or rank=3;

-------------------------------------------------------
---------------------------------------------------------

--형변환 :number, varchar2, clob, date
-- sysdate : 현재 날짜 출력
select sysdate-1, sysdate, sysdate+1 from dual;
-- last_day
select sysdate-365, sysdate, last_day(sysdate+365) from dual;

-- 명령어를 조합해서 사용가능
select * from member;
select mdate as 가입일, round(sysdate-mdate,2) from member;

-- to_char : 문자열로 변경
select mdate,to_char(mdate,'yyyy-mm-dd') from member;

-- round(): 반올림
select mdate, round(mdate,'month') from member;
select mdate, round(mdate,'year') from member;

-- 날짜형태
select mdate, to_char(mdate, 'yyyy-mm-dd hh:mi:ss') from member;

select * from board3;
select bdate,to_char(bdate,'yyyy-mm-dd hh:mi:ss') from board3; -- 게시글 저장(생성)시간. date가 없어도 확인가능
insert into board3 values(
1,'aaa','게시글 제목','게시글 내용',1,0,0,0,sysdate, '1.jpg');


-- 날짜 : 숫자함수 --round, trunc
-- 월 :month, mon, mm
-- 년: year,yyyy
-- 월까지만, 기준으로 진행됨
select mdate ,
last_day(mdate) as 마지막날짜, 
trunc(mdate,'mm') as 버림날짜,
round(mdate,'mm') as 반올림날짜
from member;


select * from board3;
select bdate,to_char(bdate,'yyyy-mm-dd hh:mi:ss') from board3;
select bdate,to_char(bdate,'yyyy-mm-dd hh24:mi:ss') from board3; -- 24시간 표시

-- 요일 기준 : trunc: 해당기간 일요일 날짜로 변경, round: 수요일 기준으로 반올림
-- hh(시),mi(분),ss(초) 기준으로 trunc, round 사용가능
select mdate, trunc(mdate,'day') from member;
select sysdate, trunc(sysdate, 'day'), round(sysdate, 'day') from dual;


--months_between(): 몇개월이 지났는지 알수있음
-- 몇달이 지났는지 알수있음
select mdate, sysdate,months_between(sysdate, mdate) from member;

select mdate, sysdate,trunc(months_between(sysdate, mdate)) from member
where months_between(sysdate,mdate)<=6;

-- add_months : 개월 추가
--1년 후 첫째일, 마지막 일을 출력하시오
select mdate, add_months(mdate,12) , 
trunc(add_months(mdate,12),'month'),
last_day(add_months(mdate,12))
from member;


-- 오늘 금요일이면 이전 일요일날짜로 이동
select trunc(sysdate,'day'),round(sysdate,'day') from dual;

-- 다가오는 요일의 날짜를 리턴(알려줌)
select next_day(sysdate,'수요일') from dual;

-- 일요일마다 행사가 있음. 다음번 일요일은 언제인가?
select next_day(sysdate,'일요일') from dual;
-- 다다음주는?
select next_day(next_day(sysdate,'일요일'),'일요일') from dual;


-- 날짜와 날짜의 사이 계산
select (sysdate-(sysdate-1)) from dual;

select sysdate-mdate from member;

--trunc(): 1일자를 알려줌
--round(): 15일 기준으로 이전은 1일, 이후는 다음달 1일
--last_day: 마지막 일을 알려줌


-------------------------------------------------
-------------------------------------------------
-- varchar2타입 -> to_date():날짜타입으로 변경

-- 에러: select '2026-11-20' +1 from dual;
select to_date('2026-11-20')+1 from dual;
select to_date('20261120')+1 from dual;
select galCreatedtime from gallerylist;


-- substr함수
--'abcdef'{1:2}
select to_date(substr(galCreatedtime,1,8)) from gallerylist;

-- 1부터 시작, 첫번째부터 5개를 검색하겠다.
select substr('abcdefg',1,5) from dual;


select galCreatedtime from gallerylist;


--2026-11-20 12:34:12 로 출력하려면? /  dy-> day 요일 붙여서 출력
select bdate from board;
select to_char(bdate,'yyyy-mm-dd hh:mi:ss dy') from board;


select * from board3;

insert into board3 values(
2,'aaa','222게시글','222내용',2,0,0,0,sysdate,'2.jpg'
);

commit;

--yyyy-mm-dd hh24:mi:ss day -> 24시간 표시
select to_char(bdate,'yyyy-mm-dd hh24:mi:ss day') from board3;


-- 가입일이 7월인 사람만 출력하시오
select * from member;
select to_char(mdate,'mm') from member;
select * from member
where to_char(mdate,'mm')='07';



select hire_date from employees;
--1900년대 입사한 사람을 출력하시오
select * from employees
where substr(to_char(hire_date,'yyyy'),0,2)='19';

--2000년대 입사한 사람을 출력하시오
select * from employees
where substr(to_char(hire_date,'yyyy'),0,2)='20';



-- kor 40점대. 60점대, 90점대에 있는 학생을 출력하시오.
-- 3개 다 같은 말
select * from stuscore;
select trunc(kor,-1) from stuscore;

select * from stuscore
where trunc(kor,-1)=40 or trunc(kor,-1)=60 or trunc(kor,-1)=90;

select * from stuscore
where (kor>=40 and kor<50)
or (kor>=60 and kor<70)
or (kor>=90 and kor<100);

select * from stuscore
where trunc(kor,-1) in (40,60,90);


-- 시간
select bdate, to_char(bdate,'yyyy-mm-dd hh:mi:ss day') from board3;
select bdate, to_char(bdate,'yyyy-mm-dd pm hh') from board3;

-- 날짜 타입--> 문자타입 / 날짜형태를 변경해서 출력
-- 숫자타입--> 문자타입
-- 자리수 :'999,999,999,999' -> 자리가 있으면 자리 출력, 없으면 빈공백으로 출력
--          '000,000,000,000' -> 있으면 자리출력, 없으면 0으로 출력
-- L : 원화표시, 영문버전 $, 일본버전은 엔화표시
--.00: 소수점 표시
select * from kor_loan_status;
select salary*1425*12 as ysalary from employees;
select to_char(salary*1425*12*10,'L999,999,999,999') as ysalary from employees;


-- loan_jan_amt*10000000 천만단위임
-- 천만원을 곱해서 자리수를 표시하시오.
select * from kor_loan_status;
select to_char(loan_jan_amt*10000000,'L999,999,999,999,999') from kor_loan_status;


-- 날짜, 문자로 변환 : 형태를 변경
-- 숫자, 문자로 변환 : 천단위, 원화등 표시
-- 숫자, 날짜로 변환
select to_date(20261120,'yyyymmdd') from dual;
select to_date('20261120','yyyymmdd') from dual;

SELECT * FROM gallerylist;
--galPhotographyMonth 날짜 타입으로 변경하시오
select to_date(galPhotographyMonth,'yyyy-mm') from gallerylist;

update gallerylist set galPhotographyMonth=to_date(galPhotographyMonth,'yyyy-mm');

commit;

desc gallerylist; -->  이경우에는 변경된 데이터만 저장, 타입은 변경되지 않음.
-----------------------------------

alter table gallerylist
add(galPhotographyMonth2 date);

desc gallerylist;

update gallerylist set galPhotographyMonth2 = to_date(galPhotographyMonth);

select galPhotographyMonth2 from gallerylist;

commit;

-- 컬럼 삭제
alter table gallerylist
drop column galPhotographyMonth;

-- 컬럼 이름 변경
alter table gallerylist
rename column galPhotographyMonth2 to galPhotographyMonth;

-- 컬럼 순서 변경
-- 컬럼 숨겨서 앞으로 보내기
alter table gallerylist modify GALPHOTOGRAPHER invisible;
alter table gallerylist modify GALSEARCHKEYWORD invisible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION invisible;
-- 드러내서 다시 보이게 변경
alter table gallerylist modify GALPHOTOGRAPHER visible;
alter table gallerylist modify GALSEARCHKEYWORD visible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION visible;
-- 확인
desc gallerylist;


-- galPhotographyMonth : varchar 타입-> 날짜타입으로 변경하려니 데이터가 변경하려는 타입과 형태가 맞지 않음.
-- drop table gallerylist;
 
 create table gallerylist (
    gno number(12) primary key,
    galContentId varchar2(8) not null,
    galContentTypeId varchar2(10),
    galTitle varchar2(100),
    galWebImageUrl varchar2(100),
    galCreatedtime varchar2(100),
    galModifiedtime varchar2(100),
    galPhotographyMonth varchar2(10),
    galPhotographyLocation varchar2(100),
    galPhotographer varchar2(100),
    galSearchKeyword varchar2(1000)
);

select to_date(galPhotographyMonth,'yyyy-mm') from gallerylist;
-- 날짜 타입처럼 변경하기
update gallerylist 
set galPhotographyMonth=to_date(galPhotographyMonth,'yyyy-mm');

commit;

select to_date(galPhotographyMonth) from gallerylist; -- 아직 varchar타입

-- 타입 변경하기
--1. 컬럼추가(맨뒤에)
alter table gallerylist
add (galPhotographyMonth2 date);

--2. 새로만든 컬럼에 데이터 복사.
update gallerylist set galPhotographyMonth2= to_date(galPhotographyMonth);

--3. 데이터 확인 
select galPhotographyMonth2 from gallerylist;

--4. 이전 데이터 삭제
alter table gallerylist
drop column galPhotographyMonth;

--5. 컬럼이름 변경
alter table gallerylist
rename column galPhotographyMonth2 to galPhotographyMonth;

--6. 컬럼 순서 원복, 변경
-- 컬럼 숨겨서 앞으로 보내기
alter table gallerylist modify GALPHOTOGRAPHER invisible;
alter table gallerylist modify GALSEARCHKEYWORD invisible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION invisible;
-- 드러내서 다시 보이게 변경
alter table gallerylist modify GALPHOTOGRAPHER visible;
alter table gallerylist modify GALSEARCHKEYWORD visible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION visible;
-- 확인
desc gallerylist;


----------------------------------------------------

select * from gallerylist;

-- 컬럼galCreatedtime 을 날짜 타입으로 변경하시오.
select to_date(galCreatedtime,'yyyymmddhh24miss') from gallerylist;

-- 날짜 타입처럼 변경하기
update gallerylist 
set galCreatedtime=to_date(galCreatedtime,'yyyymmddhh24miss');

commit;

select to_date(galCreatedtime) from gallerylist;

-- 타입 변경하기
--1. 컬럼추가(맨뒤에)
alter table gallerylist
add galCreatedtime2 date;

--2. 새로만든 컬럼에 데이터 복사.
update gallerylist set galCreatedtime2= to_date(galCreatedtime);

--3. 데이터 확인 
select galCreatedtime2 from gallerylist;

--4. 이전 데이터 삭제
alter table gallerylist
drop column galCreatedtime;

--5. 컬럼이름 변경
alter table gallerylist
rename column galCreatedtime2 to galCreatedtime;

--6. 컬럼 순서 원복, 변경
-- 컬럼 숨겨서 앞으로 보내기
alter table gallerylist modify galModifiedtime invisible;
alter table gallerylist modify GALPHOTOGRAPHYMONTH invisible;
alter table gallerylist modify GALPHOTOGRAPHER invisible;
alter table gallerylist modify GALSEARCHKEYWORD invisible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION invisible;

-- 드러내서 다시 보이게 변경
alter table gallerylist modify galModifiedtime visible;
alter table gallerylist modify GALPHOTOGRAPHYMONTH visible;
alter table gallerylist modify GALPHOTOGRAPHYLOCATION visible;
alter table gallerylist modify GALPHOTOGRAPHER visible;
alter table gallerylist modify GALSEARCHKEYWORD visible;
-- 확인
desc gallerylist;