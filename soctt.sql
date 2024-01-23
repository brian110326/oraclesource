--scott
--SELECT(데이터 조회)
-- e => 별칭 : 임의지정 가능 / 없어도 무방
-- * : 전체 필드
SELECT
	*
FROM
	EMP e;
-- 특정 열에 해당하는 내용 보기
--SELECT EMPNO, ENAME, JOB FROM EMP e;
-- EMP 테이블
-- EMPNO(사원번호), ENAME(사원명), JOB(직책), MGR(매니저번호), HIREDATE(고용일)
-- SAL(급여), COMN(보너스), DEPTNO(부서번호)
-- EMP 테이블에서 사원번호, 매니저번호, 부서번호만 조회
SELECT
	EMPNO,
	MGR,
	DEPTNO
FROM
	EMP e;
-- 부서번호만(중복데이터는 제거) 조회
SELECT
	DISTINCT 
	DEPTNO
FROM
	Emp e;

-- 데이터 출력시 필드명 별칭 부여 / 원본은 변화 X, 쌍따옴표 : 별칭에 공백이 있는경우 꼭 사용 / as 생략가능
SELECT
	EMPNO AS "사원번호",
	MGR 매니저번호,
	DEPTNO AS "부서 번호" 
FROM
	EMP e;
	
-- 연봉 계산
-- 월급 * 12 + 수당
--sal * 12 + comn

SELECT
	EMPNO ,
	SAL ,
	SAL * 12 + COMM AS "연봉"
FROM
	EMP e ;
	
-- 정렬 조회
-- order by 정렬기준 desc : 내림차순, asc : 오름차순 asc 안써주면 default값
SELECT
	*
FROM
	EMP e
ORDER BY
	SAL DESC ;

-- empno, ename, salary 조회 단, empno의 내림차순
SELECT
	EMPNO ,
	ENAME ,
	SAL
FROM
	EMP e
ORDER BY
	SAL  ;

-- 전체조회, 부서번호를 오름차순, 부서번호가 동일하다면 sal내림차순
SELECT
	*
FROM
	EMP e
ORDER BY
	DEPTNO,
	SAL DESC;
	
-- 조건을 부여
-- 부서번호가 30인 사원조회
-- salary가 1000 이상인 사원 조회
-- select from where은 순서대로 연달아
SELECT
	*
FROM
	EMP e
WHERE
	DEPTNO = 30
	AND SAL >= 1000
ORDER BY
	SAL DESC ;

-- empno가 7782인 사원조회
-- = : 같다, 산술연산자(<,>,<=,>=)
SELECT
	*
FROM
	EMP e
WHERE
	EMPNO = 7782;

--deptno 30이고 job이 salesman인경우
-- 데이터는 대소문자 구별함
SELECT
	*
FROM
	EMP e
WHERE
	DEPTNO = 30
	AND JOB = 'SALESMAN' ;
	
-- 사원번호가 7499 부서번호가 30인 사원조회
SELECT
	*
FROM
	EMP e
WHERE
	DEPTNO = 30
	AND EMPNO = 7499;

-- 이거나 , 혹은 : OR
-- 부서번호가 30이거나 job이 salesman

SELECT
	*
FROM
	EMP e
WHERE
	DEPTNO = 30
	OR JOB = 'SALESMAN';

-- 연봉이 36000인 사원을 조회
SELECT
	*
FROM
	EMP e
WHERE
	SAL * 12 + COMM = 36000;

-- 문자 비교도 가능 => 산술연산 기호 가능
-- 알파벳 순서로 F다음에 있는
SELECT
	*
FROM
	EMP e
WHERE
	ENAME >= 'F';

-- SAL이 3000이 아닌 사원 조회
-- ~가 아닌 : !=, <>, ^= : sql 표준 언어임
SELECT
	*
FROM
	EMP e
WHERE
	SAL != 3000;

SELECT
	*
FROM
	EMP e
WHERE
	SAL <> 3000;

SELECT
	*
FROM
	EMP e
WHERE
	SAL ^= 3000;

-- job이 manager이거나 salesman이거나 clerk
SELECT
	*
FROM
	EMP e
WHERE
	JOB = 'MANAGER'
	OR JOB = 'SALESMAN'
	OR JOB = 'CLERK';

-- IN
SELECT
	*
FROM
	EMP e
WHERE
	JOB IN ('MANAGER', 'SALESMAN', 'CLERK');

SELECT
	*
FROM
	EMP e
WHERE
	JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');

-- 날짜데이터 비교
-- 1981 10 31 이후에 고용된 사원조회
-- 날짜 데이터 산술 연산 가능, 날짜 데이터는 ''로 처리
SELECT
	*
FROM
	EMP e
WHERE
	HIREDATE >= '1981-10-31';

-- BETWEEN A AND B
-- SAL 2000 이상 3000이하가 아닌 조회
SELECT
	*
FROM
	EMP e
WHERE
	SAL NOT BETWEEN 2000 AND 3000;














