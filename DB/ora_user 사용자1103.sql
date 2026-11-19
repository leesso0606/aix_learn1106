-- 테이블 확인
select * from tab;

--select: 검색, insert:입력, updata:수정, delete:삭제
--commit:적용, rollback:되돌리기
-- row 데이터 검색
select * from employees;
select * from member;

--table에 있는 컬럼 유형 확인
desc member;

-- select : * :전체, 부분적컬럼을 가지고 검색
select * from employees;
select employee_id,emp_name, department_id from employees;
-- 컬럼명과 타입을 알수있음.
desc employees;

-- number, cahr, carchar2, date 타입
-- number : +,-,*,/ 가능
--  date: +,- 가능
--varchar2 : 사칙연산 안됨.
select '가' || '나' from dual; --문자열타입
select emp_name+email from employees; -- 안됨
select emp_name || email from employees; -- 가능


-- 컬럼명 변경가능, as 붙여서 컬럼변경가능.
select emp_name, salary , salary*1342 as k_salary from employees;
select sysdate-100, sysdate, sysdate+100 from member;
select salary*10 from employees;
desc employees;

-------------------------------------------------------
--연산자
--salary, 원화로 월급, 원화로 연봉을 출력하시오
--k_sal : 별칭
select salary, salary*1342 as k_sal , salary*1342*12 k_a_sal from employees;

-- null의 사칙연산 불가능
-- 판매부서에서만 COMMISSION:salary*commission_pct
-- nvi (컬럼, 0) : null 값, 없을때는 0으로 변경
select salary, commission_pct, salary+nvl(salary*commission_pct,0) from employees;
-- ""안에서는 특수문자, 한글, 띄어쓰기 등 사용할수있음. 다만 띄어쓰기는 자제
select salary, commission_pct, salary+nvl(salary*commission_pct,0)"실제월급" from employees;

-- 부서테이블을 모든 컬럼을 출력하시오
select * from departments;
select department_id, department_name from departments;
select department_id || '부서는' || department_name from departments;

--distinct : 중복제거
select distinct(department_id) from employees;

-- job_id 중복제거 후 출력하시오
select distinct(job_id) from employees;
select * from jobs;

select department_id ,department_name from employees;
select department_id, department_name from departments;

select employees.department_id, department_name from employees,departments
where employees.department_id = departments.department_id;


--where 조건절 : 비교, <,<=,>,>=
--두개 이상일때는 and 가능
select salary from employees
select emp_name,salary from employees
where salary>5000;
select salary from employees
where salary=6000;
select employee_id, salary from employees
where salary >= 6000 and department_id=50;

--급여가 4000 이하의 사원번호 사원이름, 급여를 출력하시오
select employee_id, emp_name, salary from employees
where salary<=4000;

select hire_date from employees;
--날짜비교
select hire_date from employees
where hire_date>'07/01/01';
select hire_date from employees
where hire_date>'2007/01/01';
select hire_date from employees
where hire_date>='2007-01-01' and hire_date<='07/12/31';

--부서번호가 50번이면서, 월급이 8000이상
select department_id, salary from employees
where department_id=50 and salary>=8000;

--부서번호가 10이거나 30이거나 100인 사원을 출력하시오
select * from employees
where department_id=10 or department_id=30 or department_id=100;





-----------------------------------------------------------


--number : 숫자 데이터 들어감(정수, 실수) -> number(4,2):99.99, number(4):9999
--char : 고정길이 문자 데이터 저장. -> char(20)이면 5글자만 저장되어도 20자리무조건 확보, 데이터 낭비대신 빠름
--varchar2 : 가변적인 길이 문자열-> varchar2(20)이면 5글자만 저장있으면 들어가있는 자리만 읽음, 공간낭비없는 대신 느림
--date : 날짜



