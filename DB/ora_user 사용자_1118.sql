-- sql query 구문을 사용해서 데이터 검색, 입력, 수정, 삭제
-- 테이블 생성, 삭제, 변경

--: 주석
select * from member;

select *from employees;

-- 테이블의 컬럼 속성을 보여줌
-- NUMBER: 숫자, VARCHAR2: 문자열, DATE: 날짜
desc employees;


----------------------------------

-- Number : 숫자타입(자리수, 소수점)
-- num number(4,2) : 4:전체자리수, 2: 소수점 -> 21.98,
-- (정수부분 2자리만 사용가능)   

--테이블 생성
create table memnum(
bno number(4,2),
bno2 number (3)
);
--데이터 삽입
insert into memnum (bno, bno2) values
(12.12,999);

-- 4.2 였기에 정수부분이 2자리여야함.-> 정수자리 2, 소수점자리2
insert into memnum (bno)values
(1.234);

select * from memnum;

-- 테이블 삭제 / 삭제 후 주석처리!, 테이블 삭제는 복구가 안됨.
--drop table memnum;

--------------------------------------------------------

-- 날짜: date (+,- 가능)

desc employees;

select create_date from employees;
select create_date-100 from employees;

-------------------------------------------

-- char(문자열) / varchar2 (가변문자열)
-- char(20) 는 정해져 있는 자리수는 무조건 비워둠 : 속도가 빠름, 하지만 자리낭비가 있음
-- varchar2(20) 는 20자를 주어도 5글자면 5자리만 사용 : 속도가 느림, 하지만 자리낭비 없음

-----------------------------------------
--!!! 굉장히 중요!! // 커밋(commit)을 안하면 저장이 안됨 // 롤백가능
-- select문 : 검색
-- insert문 : 입력
-- update문 : 수정
-- delete문 : 삭제

select * from employees; -- *:전체
select employee_id, emp_name from employees;

--drop table member; : 복구 불가능

create table member(
id varchar2(20) primary key, -- 중복이 안됨, null값 입력 불가
pw varchar2(100) not null,
name varchar2(50),
phone varchar2(20)
);

select * from member;

insert into member (id, pw, name, phone) values(
'aaa','1111','홍길동','010-1111-1111'
);

insert into member values(
'bbb','1111','유관순','010-2222-2222'
);

insert into member values(
'ccc','1111','이순신','010-3333-3333'
);

delete from member where id='ccc';
commit;

--cmd창에서 sqlplus

--commit;
--insert into member values (
--'ccc','1111','이순신','010-3333-3333'
--);

--insert into member values ('ddd','1111','강감찬','010-4444-4444');

--delete from member where id='ccc';

--update member set pw='2222' where id='ddd';


update member set pw='0000' where id='ddd';

update member set pw='3333' where id='ddd';

update member set pw='4444' where id='ddd';

select * from member;
commit;
rollback;
-- 다른곳에서 커밋으로 저장하기 전에 다른 곳에서 같은 테이블을 커밋할 수 없음
-- exit 로 cmd에서 오라클 데이터 베이스에서 분리할것.


-----------------------------------------------------------

desc employees;

-- 사원번호, 이름, 입사일, 연봉을 출력하시오.
select EMPLOYEE_ID,EMP_NAME,HIRE_DATE,SALARY
from employees;
-------------------------------

desc employees;

select salary+1000 from employees;
select salary-1000 from employees;
select salary*1000 from employees;
select salary/1000 from employees;

-- 사원번호, 이름, 월급, 연봉을 동시에 출력하시오
select EMPLOYEE_ID, EMP_NAME, SALARY, SALARY*12 from employees;

-- 현재 달러인데, 원화금액 월급으로 변경하시오
-- 사원번호, 이름, 월급, 원화월급
select employee_id, emp_name, salary, salary*1330 from employees;

------------------------------------------------------

-- null 값은 산술연산자가 불가능 -> null 값이 나옴,
select emp_name, salary, salary+(salary*commission_pct)from employees;

-- as 이름 : 별칭 / 컬럼명은 되도록 영어로 하는 편이 좋음.
select emp_name, salary,
nvl(commission_pct,0) as nvl,
salary+(salary*nvl(commission_pct,0)) as last_salary
from employees;

-------------------------------
select * from departments;

-- null 값 출력
-- 매니저가 100번인 사원들을 출력하시오.
-- select 컬럼 from 테이블 조건절 where
select * from departments where manager_id<=200;
select * from departments where manager_id = null; -- 안나옴
select manager_id from departments;

select * from departments where manager_id is null;-- manager_id가 null인것만 출력

------------------------------------------

-- 2개의 컬럼을 1개의 컬럼으로 출력하는 방법
select * from employees;
select emp_name, email from employees;
select emp_name || email as total from employees;
select concat(emp_name, email) from employees;

-----------------------------------

-- distinct:중복제거. 정렬-asc: 순차정렬, desc: 역순정렬
--count() : 개수
select  distinct(manager_id) from employees;
select  count(distinct(manager_id)) from employees;
select  distinct(manager_id) from employees
order by manager_id;

-- 총개수 : 107
select count(*) from employees;

--job_id를 중복제거해서 출력하시오.
select distinct(job_id) from employees;
-- department_id를 중복제거해서 출력하시오.
select count(distinct(job_id)) from employees;
-- departments테이블에서 부서가 몇개 있는지 확인하시오.
select * from departments;
select count(distinct(department_name)) from departments;

--------------------------------

select salary from employees
where salary >=5000; 

select count(*) from employees
where salary>=5000;

select emp_name,salary from employees
where salary >=5000 and salary <=9000;

select emp_name,salary from employees
where salary >=5000 or salary <=9000;

-- 3000은 2명 , 아닌사원 105명
select salary from employees
where salary=3000;

select salary from employees
where salary!=3000;

select salary from employees
where salary=3000 or salary=4000 or salary=6000;

select salary from employees
where salary in(3000,4000,6000);

-- 사원번호가 150번부터 200번까지 출력하시오
select * from employees;
select employee_id from employees
where employee_id>=150 and employee_id<=200;

-- 사원번호가 130번 이하, 180번 이상 출력하시오
select employee_id from employees
where employee_id<=130 or employee_id>=180;

-- 사원번호가 110,130,140,150번 출력하시오
select employee_id from employees
where employee_id=110 or employee_id=130 or employee_id=140 or employee_id=150;

select employee_id from employees
where employee_id in(110,130,140,150);

--------------------------------------

select * from employees;

-- 문자검색
select * from employees
where email ='DOCONNEL';

select * from employees
where emp_name = 'donald OConnell'; -- 찾는게 데이터와 다르면 못찾음.

-- 날짜 검색 <,>,= 가능
select * from employees
where hire_date <= '2025/01/01';


-- 사원번호가 110,130,140,150 가 아닌 사원을 출력하시오
select * from employees;
select employee_id from employees
where employee_id not in(110,130,140,150);

-- 급여가 5000~7000 사이 또는 8000~9000 인 사원을 출력하시오. 
select salary from employees
where (salary>=5000 and salary<=7000) or salary in (8000,9000);

-- 직급이 man, 부서번호 50 인 사원을 출력하시오.
select * from employees;
select employee_id, emp_name, job_id,department_id  from employees
where job_id like '%MAN%' and department_id=50;

-- employee_id를 기준으로 정렬 정리 후 10개만 출력
select * from employees
where employee_id>100 and employee_id<=109
order by employee_id; -- 넣게나 빼거나 할 수 있다.

select * from employees
where employee_id between 100 and 109; -- 하지만 between은 포함임(>=,<=)


-- 사원번호가 130번 부터 140번 / 170부터 180번까지 출력하시오 
select * from employees;
select employee_id from employees
where (employee_id between 130 and 140)
or (employee_id between 170 and 180); 

-- 
select * from employees
where employee_id in (110,120,130);

select * from employees
where employee_id=110 or employee_id=120 or employee_id=130;

---------------------

--like : 포함된
-- L% : 첫번째 글자가 L
-- _e% : 두번째 글자가 e (_ 개수만큼 선택되는 글자가 늘어남)
select * from employees
where emp_name like 'L%';

select * from employees
where emp_name like '__e%';

-- H가 포함되어 있는 이름을 출력하시오.
select * from employees
where emp_name like '%H%';
-- 8번째 H가 들어가 있는 이름을 출력하시오.
select * from employees
where emp_name like '________H%';

-----------------------------------
--drop table board; -- 테이블 삭제
-- 로컬 csv 가져오기
-- 1. 테이블 만들기(board)
create table board(
    bno number(4),
    id varchar2(30),
    btitle varchar2(1000),
    bcontent varchar2(2000), --club
    bgroup number(4),
    bstep number(4),
    bindent number(4),
    bhit number(4),
    bdate date,
    bfile varchar2(100)
);

select * from board
order by bno;

-- btitle 사진 글자가 들어가 있는 게시글을 출력하시오.

select * from board
where btitle like '%사진%';
    
-- btitle, bcontent에 사진 글자가 들어가 있는 게시글을 출력하시오.
select * from board
where btitle like '%사진%' or bcontent like '%사진%';

-- 
select * from board
where bno between 11 and 20;

-- 함수
-- id를 소문자로 변경
select lower(id) from board;

select bdate from board;
select bdate,substr(bdate,1,2) from board;

-- 월만 출력하시오 ( 시작, 개수)
select bdate, substr(bdate,4,2) from board;

--  A, a(대소문자) 가 들어가 있는 아이디를 출력하시오
select id from board
where lower(id) like'%a%';4


select job_id from employees;
select job_id from employees
where job_id like '%_%';

-- employees 테이블에 manager_id 컬럼중 값이 null인 것을 모두 출력해줘
select * from employees
where manager_id is null;

--------------------------

--정렬
-- 순차정렬 order by asc, 역순정렬 order by desc
-- 역순정렬 null 제일 위, 순차정렬은 null 제일 아래

select * from board
order by bno asc;       -- 1부터 순차정렬

select department_id, hire_date from employees
order by department_id desc, hire_date asc;     -- department_id를 역순정렬 하다 같은 번호들은 hire_date를 순차정렬


-- 월급으로 역순정렬 출력하시오
select salary from employees
order by salary desc;
-- 사원 명으로 순차정렬 하시오.
select emp_name from employees
order by emp_name asc;

