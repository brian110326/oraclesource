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

-- 2일차
-- LIKE연산자와 와일드 카드(_,%)
-- 사원 이름이 S로 시작하는 사원조회
SELECT *
FROM EMP e
WHERE ENAME LIKE 'S%';

-- 사원이름의 두번째 글자가 L인 사원조회
-- 언더바 _ : 문자 1개를 의미
-- % : 문자 개수는 무한대
SELECT *
FROM EMP e
WHERE ENAME LIKE '_L%';

-- 사원이름에 AM 문자가 포함된 사원조회
SELECT *
FROM EMP e
WHERE ENAME LIKE '%AM%';

-- 사원이름에 AM 문자가 포함X 사원조회

SELECT *
FROM EMP e
WHERE ENAME NOT LIKE '%AM%';

--NULL : 값이 없는 상태
-- '' : 빈값 null값이랑은 틀림
-- ' ' : 스페이스바도 문자로 포함
-- COMM이 NULL
-- NULL 비교 : IS
SELECT *
FROM EMP e
WHERE COMM IS NULL;

-- MGR이 NULL인 사원조회
SELECT *
FROM EMP e 
WHERE MGR IS NULL;

-- MGR이 NULL이 아닌 사원조회
SELECT *
FROM EMP e 
WHERE MGR IS NOT NULL;

--집합연산자
-- 합집합(UNION / UNION ALL), 교집합(INTERSECT), 차지합(MINUS)
-- 부서번호가 10번 혹은 20번인 사원 조회
SELECT EMPNO , ENAME , SAL , DEPTNO 
FROM EMP e
WHERE DEPTNO = 10
UNION 
SELECT EMPNO , ENAME , SAL , DEPTNO 
FROM EMP e
WHERE DEPTNO = 20;

-- 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다.
-- UNION 사용시 출력 열 개수, 타입 동일
--SELECT EMPNO , ENAME , SAL , DEPTNO 
--FROM EMP e
--WHERE DEPTNO = 10
--UNION 
--SELECT EMPNO , ENAME , SAL 
--FROM EMP e
--WHERE DEPTNO = 20;

-- UNION 사용시 출력 열 개수, 타입 동일
SELECT EMPNO , ENAME , SAL , DEPTNO
FROM EMP e
WHERE DEPTNO = 10
UNION 
SELECT SAL ,JOB ,DEPTNO ,SAL 
FROM EMP e
WHERE DEPTNO = 20;

-- 결과값에 중복을 자동적으로 제거
SELECT EMPNO , ENAME , SAL , DEPTNO
FROM EMP e
WHERE DEPTNO = 10
UNION
SELECT EMPNO , ENAME , SAL , DEPTNO
FROM EMP e
WHERE DEPTNO = 10;

-- UNION ALL : 중복을 제거 안함
SELECT EMPNO , ENAME , SAL , DEPTNO
FROM EMP e
WHERE DEPTNO = 10
UNION ALL 
SELECT EMPNO , ENAME , SAL , DEPTNO
FROM EMP e
WHERE DEPTNO = 10;

-- MINUS 차집합
SELECT EMPNO , ENAME , SAL , DEPTNO
FROM EMP e
MINUS
SELECT EMPNO , ENAME , SAL , DEPTNO
FROM EMP e
WHERE DEPTNO = 10;

-- INTERSECT 교집합
SELECT EMPNO , ENAME , SAL , DEPTNO
FROM EMP e
INTERSECT
SELECT EMPNO , ENAME , SAL , DEPTNO
FROM EMP e
WHERE DEPTNO = 10;

-- 오라클 함수(내장함수)
-- 함수는 사용하는 DBMS에 따라 다르게 제공
-- 1. 문자 함수
-- 대소문자 변경
SELECT *
FROM EMP e
WHERE ENAME = 'clark';

-- UPPER(문자열) : 괄호 안 문자를 모두 대문자로 변환하여 반환
-- LOWER(문자열 ) : 괄호 안 문자를 모두 소문자로 변환하여 반환
-- INITCAP(문자열) : 괄호 안 문자의 첫번째 글자를 대문자로, 나머지는 소문자로 변환하여 반환
SELECT ENAME , UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)  
FROM EMP e;

SELECT *
FROM EMP e
WHERE LOWER(ENAME) = 'clark';

SELECT *
FROM EMP e
WHERE ENAME = UPPER('clark'); 

-- 2. 문자열 길이 : LENGTH, LENGTHB
-- LENGTHB : 문자열에 사용된 바이트 수 반환
SELECT ENAME , LENGTH(ENAME), LENGTHB(ENAME) 
FROM EMP e;

-- 함수결과를 보고싶은데 테이블이 없는 경우 : 임시테이블 DUAL 사용
-- 한글은 문자 하나당 3byte가 할당되어있음, 영어는 1byte 할당
SELECT LENGTH('한글'), LENGTHB('한글') 
FROM DUAL;

-- 직책 이름이 6글자 이상인 사원조회
SELECT *
FROM EMP e
WHERE LENGTH(JOB) >= 6;

-- 3. 문자열 일부 추출 : SUBSTR(문자열데이터, 시작위치, 추출길이)
-- 추출길이는 생략가능
SELECT JOB , SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB ,5)  
FROM EMP e;

-- 시작위치가 음수면 오른쪽 끝
SELECT JOB , SUBSTR(JOB,-1,2), SUBSTR(JOB,-3,2), SUBSTR(JOB ,-5)  
FROM EMP e;

-- 4. INSTR(문자열데이터, 위치를 찾으려는 문자, 시작위치, 시작위치에서 몇번째 위치)
-- 문자열 데이터 안에서 특정 문자위치 찾기
SELECT
	INSTR('HELLO, ORACLE!', 'L') AS INSTR_1 ,
	INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_2,
	INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_3
FROM
	DUAL ;

-- 사원이름에 S가 들어있는 사원 조회
-- LIKE 사용가능
-- 0보다 크면 1부터 찾는것이 시작이니 있다면 찾게됨
SELECT *
FROM EMP e
WHERE INSTR(ENAME,'S') > 0; 

-- 5. REPLACE : 특정 문자를 다른 문자로 변경
-- REPLACE(문자열데이터, 찾는문자, 변경할 문자)
SELECT
	'010-2367-8728' AS REPLACE_BEFORE,
	REPLACE('010-2367-8728', '-', '') AS REPLACE_1,
	REPLACE('010-2367-8728', '-') AS REPLACE_2,
	REPLACE('010-2367-8728', '-',' ') AS REPLACE_3
FROM
	DUAL ;

-- 6. CONCAT : 두 문자열데이터를 합하는 함수
-- CONCAT(문자열데이터1, 문자열데이터2) 2개밖에 올수없다.
-- 여러개를 합할 때 concat보다는 || 기호를 많이 씀
--SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO,ENAME,JOB)  
--FROM EMP e
--WHERE ENAME = 'SCOTT';

-- 7369 : SMITH 만들기
SELECT CONCAT(EMPNO,ENAME), CONCAT(EMPNO,CONCAT(' : ', ENAME))  
FROM EMP e
WHERE ENAME = 'SMITH';

SELECT EMPNO || ' : ' || ENAME  
FROM EMP e
WHERE ENAME = 'SMITH';

-- 7. TRIM : 공백을 제거하는 함수
-- TRIM(삭제옵션(선택), 삭제할문자) FROM 원본문자열
-- 'SMITH' = 'SMITH ' ==> 다른 문자열
-- 요거좀 헷갈림
SELECT
	'[' || '   ___Oracle___   ' || ']' AS trim_before,
	'[' || TRIM('   ___Oracle___   ') || ']' AS trim,
	'[' || LTRIM('   ___Oracle___   ') || ']' AS ltrim,
	'[' || RTRIM('   ___Oracle___   ') || ']' AS rtrim
FROM DUAL ;

SELECT
	'[' || '___Oracle___' || ']' AS trim_before,
	'[' || TRIM(LEADING '_' FROM '___Oracle___') || ']' AS trim_leading,
	'[' || TRIM(TRAILING '_' FROM '___Oracle___') || ']' AS trim_trailing,
	'[' || TRIM(BOTH '_' FROM '___Oracle___') || ']' AS trim_both
FROM
	DUAL ;

-- 숫자함수 : 숫자 데이터에 적용
-- 반올림, 올림, 버림, 나머지값 구하기
-- ROUND, CEIL, FLOOR, TRUNC, MOD
-- ROUND(숫자, 반올림 위치)
SELECT
	ROUND(1234.5678) AS ROUND,
	ROUND(1234.5678, 0) AS ROUND1,
	ROUND(1234.5678, 1) AS ROUND2,
	ROUND(1234.5678, 2) AS ROUND3,
	ROUND(1234.5678, -1) AS ROUND_MINUS1,
	ROUND(1234.5678, -2) AS ROUND_MINUS2
FROM DUAL ;

-- TRUNC(숫자, 버릴위치) : 버림
SELECT
	TRUNC(1234.5678) AS TRUNC,
	TRUNC(1234.5678, 0) AS TRUNC0,
	TRUNC(1234.5678, 1) AS TRUNC1,
	TRUNC(1234.5678, 2) AS TRUNC2,
	TRUNC(1234.5678, -1) AS TRUNC_MINUS1,
	TRUNC(1234.5678, -2) AS TRUNC_MINUS2
FROM
	DUAL ;

-- CEIL, FLOOR : 지정한 숫자와 가까운 정수를 찾기
-- CEIL : 지정한 숫자보다 큰 정수 중 가장 작은 정수
-- FLOOR : 지정한 숫자보다 작은 정수 중 가장 큰 정수
SELECT CEIL(3.14), FLOOR(3.14), CEIL(-3.14), FLOOR(-3.14)
FROM DUAL ;

-- MOD : 나머지 구하는 함수
SELECT 11/5, MOD(11,5)
FROM DUAL ;

-- 날짜 함수
-- 2024-01-24 OR 2024/01/24

-- 오늘 날짜
SELECT SYSDATE, CURRENT_DATE , CURRENT_TIMESTAMP  
FROM DUAL ;

-- 날짜데이터 + 숫자 : 날짜 데이터보다 숫자만큼 이후의 날짜
SELECT SYSDATE, SYSDATE + 1 , SYSDATE - 1 
FROM DUAL ;

-- ADD_MONTHS() : 몇개월 이후의 날짜 구하기
SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) 
FROM DUAL ;

-- 입사 30주년 되는 날짜 구하기
SELECT EMPNO , ENAME , HIREDATE , ADD_MONTHS(HIREDATE, 360) 
FROM EMP e ;

-- MONTH_BETWEEN(날짜1, 날짜2) : 2개의 날짜간 개월수의 차이
--고용일과 오늘날짜 차이를 구하기
SELECT HIREDATE , SYSDATE , FLOOR(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS TOTAL 
FROM EMP e ;

--NEXT_DAY, LAST_DAY
-- NEXT_DAY(날짜, 요일) : 특정날짜를 기준으로 돌아오는 요일의 날짜 출력
-- LAST_DAY(날짜) : 특정날짜가 속한 달의 마지막 날짜
SELECT SYSDATE , NEXT_DAY(SYSDATE,'월요일'), LAST_DAY(SYSDATE)  
FROM DUAL ;

-- 데이터 타입
-- NUMBER : 숫자
-- VARCHAR : 문자
-- DATE : 날짜 / 시간
-- 타입(자료형) 변환 (날짜 => 문자, 문자 => 숫자)

-- NUMBER + 문자숫자 : 자동 형변환으로 계산 처리
SELECT EMPNO , ENAME , EMPNO + '500'
FROM EMP e
WHERE ENAME = 'FORD';

-- 수치가 부적합합니다
--SELECT EMPNO , ENAME , EMPNO + 'ABCD'
--FROM EMP e
--WHERE ENAME = 'FORD';

-- 명시적 형변환
-- TO_CHAR(날짜/숫자 데이터, '출력되기를 원하는 문자 형태') : 숫자, 날짜 데이터를 문자열로 변환
--TO_NUMBER() : 문자 데이터를 숫자로 변환
--TO_DATE() : 문자 데이터를 날짜로 변환

-- Y : 연도 , M : 월, D : 일, HH : 시, MI : 분, SS : 초 HH24 : 시를 24시간으로, AM(PM) : 오전인지 오후인지
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD'), SYSDATE , TO_CHAR(SYSDATE, 'YYYY/MM/DD HH : MI : SS PM') 
FROM DUAL ;

--TO_NUMBER(문자열, 숫자형식) : 문자열 데이터를 지정한 형태의 숫자로 인식하여 숫자 데이터로 변환
SELECT 1300 + '1500', '1300' + '1500'
FROM DUAL ;

-- 9 : 숫자의 한자리를 의미함
SELECT TO_NUMBER('1,300', '9999') + TO_NUMBER('1,500', '9999') 
FROM DUAL ;

-- 어떻게든 0,9 자리를 채워야한다
SELECT
	TO_CHAR(SAL, '999,999.00') AS sal1,
	TO_CHAR(SAL, '000,999,999.00') AS sal2
FROM
	EMP e ;

-- TO_DATE(문자, '인식될 날짜 형태') : 문자 데이터를 날짜 데이터로 변환
SELECT
	TO_DATE('2024-01-24') AS TODATE1,
	TO_DATE('20240124') AS TODATE2
FROM
	DUAL ;

SELECT  TO_DATE('2024-01-24') - TO_DATE('2023-12-31')
FROM DUAL ;

-- NULL 처리 함수
-- NULL * 숫자 => NULL, 어떤 연산자도 NULL값이 나옴
-- NULL => 다른값으로 대체하는 함수
SELECT EMPNO , ENAME , SAL ,COMM , SAL + COMM AS TOTAL
FROM EMP e ;

-- NVL(널인지 검사할 열이름 or 데이터, 대체할 데이터)
SELECT EMPNO , ENAME , SAL ,COMM , SAL + NVL(COMM, 0) AS TOTAL
FROM EMP e ;

-- NVL2(널인지 검사할 열이름 or 데이터, NULL이 아닌경우 반환 데이터(계산식), NULL인 경우 반환 데이터(계산식))
SELECT EMPNO , ENAME , SAL ,COMM , NVL2(COMM, 'O', 'X')
FROM EMP e ;

-- NVL2
-- COMM이 NULL이면 연봉계산 = sal * 12, NULL이 아니라면 연봉은 sal * 12 + comm
SELECT EMPNO , ENAME , SAL , COMM , NVL2(COMM, SAL * 12 + COMM, SAL * 12)  AS 연봉
FROM EMP e ;

-- JOB이 MANAGER라면 sal * 1.1
-- JOB이 SALESMAN이라면 sal * 1.05
-- JOB이 ANALYST라면 sal
-- 나머지 직무는 sal * 1.03

-- DECODE 함수와 CASE 문
-- DECODE(검사대상, 조건1, 결과1, 조건2, 결과2, 조건3, 결과3, ..... , 조건1~n번째 일치하지 않을때 반환할 결과값)
SELECT
	EMPNO ,
	ENAME ,
	JOB ,
	SAL ,
	DECODE(JOB, 'MANAGER' , SAL * 1.1, 'SALESMAN', SAL * 1.05, 'ANALYST', SAL, SAL * 1.03) AS UPSAL
FROM
	EMP e;

-- CASE문
SELECT
	EMPNO ,
	ENAME ,
	JOB ,
	SAL ,
	CASE
		JOB WHEN 'MANAGER' THEN SAL * 1.1
		WHEN 'SALESMAN' THEN SAL * 1.05
		WHEN 'ANALYST' THEN SAL 
		ELSE SAL * 1.03
	END AS UPSAL2
FROM
	EMP e;

-- COMM이 NULL이라면 해당사항없음 출력 
-- COMM이 0이라면 수당없음 출력
-- COMM이 0보다 클 때 실제 COMM출력
SELECT
	EMPNO ,
	ENAME ,
	COMM ,
	CASE
		WHEN COMM IS NULL THEN '해당사항 없음'
		WHEN COMM = 0 THEN '수당없음'
		WHEN COMM > 0 THEN '수당 : ' || COMM
	END AS COMM_TEXT
FROM
	EMP e ;

-- 실습1 : 강의자료
SELECT
	EMPNO,
	ENAME ,
	TRUNC((SAL / 21.5), 2) AS DAY_PAY,
	ROUND(((SAL / 21.5) / 8), 1) AS TIME_PAY
FROM
	EMP e ;

-- 실습2 : 강의자료
SELECT
	EMPNO ,
	ENAME,
	HIREDATE ,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YY/MM/DD') AS R_JOB,
	NVL(TO_CHAR(COMM), 'N/A') AS COMM 
FROM
	EMP e ;































































































































































































































