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

-- 2일차(1/24)
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
SELECT JOB , SUBSTR(JOB,1,1), SUBSTR(JOB,3,2), SUBSTR(JOB ,5)  
FROM EMP e;

SELECT ENAME , JOB , SUBSTR(JOB, -2,2)  
FROM EMP e ;

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

SELECT INSTR('BRIAN', 'A', 2, 2) 
FROM DUAL ;

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

SELECT HIREDATE , SYSDATE , TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE) / 12, 2) AS 년차차이 
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

SELECT SYSDATE , TO_CHAR(SYSDATE, 'YYYY/MM/DD HH : MI : SS PM') 
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

-- then 뒤에 오는 타입이 동일해야한다
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

-- 3일차(1/25)
-- 실습3
-- DECODE, SUBSTR로도 해보기
SELECT
	EMPNO,
	ENAME,
	MGR,
	CASE
		WHEN MGR IS NULL THEN '0000'
		WHEN TO_CHAR(MGR) LIKE '75%' THEN '5555'
		WHEN TO_CHAR(MGR) LIKE '76%' THEN '6666'
		WHEN TO_CHAR(MGR) LIKE '76%' THEN '7777'
		WHEN TO_CHAR(MGR) LIKE '78%' THEN '8888'
		ELSE TO_CHAR(MGR)
	END AS CHG_MGR
FROM
		EMP e ;
	

SELECT
	EMPNO,
	ENAME,
	MGR,
	CASE SUBSTR(TO_CHAR(NVL(MGR,0)), 1, 2)
		WHEN '0' THEN '0000'
		WHEN '75%' THEN '5555'
		WHEN '76%' THEN '6666'
		WHEN '76%' THEN '7777'
		WHEN '78%' THEN '8888'
		ELSE TO_CHAR(MGR)
	END AS CHG_MGR
FROM
		EMP e ;	

-- 다중행 함수
-- sum(), avg(), count(), max(), min()
	
-- 단일 그룹의 그룹 함수가 아닙니다(여러 행이 나올수 있는 컬럼을 추가한 경우)	
-- 형태가 다르기 때문에	
SELECT SUM(SAL), AVG(SAL), MAX(SAL), MIN(SAL), COUNT(SAL) , ENAME  
FROM EMP e ;

-- 동일한 급여를 제외
SELECT SUM(DISTINCT SAL)
FROM EMP e ;

SELECT COUNT(*) 
FROM EMP e ;

-- 부서번호가 30인 사원수
SELECT COUNT(*) 
FROM EMP e
WHERE DEPTNO = 30;

-- 부서번호가 30인 사원 중 급여의 최대 최소 값
SELECT MAX(SAL), MIN(SAL)  
FROM EMP e
WHERE DEPTNO = 30;

-- 부서번호가 20인 사원중 입사일 중에서 제일 최근 입사일 조회
SELECT MAX(HIREDATE) 
FROM EMP e 
WHERE DEPTNO = 20;
	
-- 부서번호가 20인 사람의 입사일 중에서 제일 오래돈 입사일 조회
SELECT MIN(HIREDATE) 
FROM EMP e 
WHERE DEPTNO = 20;
	
-- 부서번호가 30인 사원 중에서 sal 중복값 제거한 후 평균
SELECT AVG(DISTINCT SAL) 
FROM EMP e
WHERE DEPTNO = 30;
	
-- 부서별 급여 합계 구하기
-- 결과값을 원하는 열로 묶기 : GROUP BY
-- GROUP BY : 그룹화할 열 이름 , HAVING : GROUP BY랑 같이 쓰는 조건

-- 순서
-- SELECT : 5번
-- FROM : 1번
-- WHERE : 2번
-- GROUP BY : 3번
-- HAVING : 4번
-- ORDER BY : 6번
-- FROM => WHERE => GROUP BY => HAVING => SELECT => ORDER BY

SELECT DEPTNO , SUM(SAL) AS SUM 
FROM EMP e
GROUP BY DEPTNO 
ORDER BY DEPTNO ;

-- 부서별 평균 급여
SELECT DEPTNO , FLOOR(AVG(SAL)) AS AVERAGE  
FROM EMP e 
GROUP BY DEPTNO
ORDER BY DEPTNO ;
	
-- 부서번호, 직무별 급여 평균
SELECT DEPTNO , JOB , AVG(SAL) 
FROM EMP e
GROUP BY DEPTNO , JOB
ORDER BY DEPTNO ;

-- HAVING : GROUP BY 절에 조건을 사용할 때 (필수는 아님)
-- 부서번호, 직무별 급여 평균 + 평균 급여가 2000 이상인 부서번호, 직책, 부서별 직책 평균 급여
SELECT DEPTNO , JOB , AVG(SAL) AS AVERAGE 
FROM EMP e
GROUP BY DEPTNO , JOB 
HAVING AVG(SAL) >= 2000
ORDER BY AVERAGE;

SELECT DEPTNO , JOB , AVG(SAL) AS AVERAGE 
FROM EMP e
WHERE SAL <= 3000
GROUP BY DEPTNO , JOB 
HAVING AVG(SAL) >= 2000
ORDER BY AVERAGE;
	
-- 같은 직무에 종사하는 사원이 3명 이상인 직무와 인원수를 출력
SELECT JOB , COUNT(EMPNO) AS 사원수 
FROM EMP e
GROUP BY JOB 
HAVING COUNT(EMPNO) >= 3
ORDER BY 사원수;
	
-- 사원들의 입사연도를 기준으로 부서별 몇명있는지
SELECT  TO_CHAR(HIREDATE, 'YYYY') AS YEAR, DEPTNO , COUNT(EMPNO) AS 사원수
FROM EMP e
GROUP BY TO_CHAR(HIREDATE, 'YYYY') , DEPTNO
ORDER BY YEAR, DEPTNO ;

-- JOIN : 여러 테이블을 하나의 테이블처럼 사용
-- EMP 테이블과 DEPT JOIN
-- JOIN시 테이블에 동일한 컬럼명 존재 시 명확히 표시
SELECT e.ENAME , e.SAL , e.DEPTNO , d.DNAME , d.LOC 
FROM EMP e , DEPT d
WHERE e.DEPTNO = d.DEPTNO ;

-- JOIN 조건을 무조건 명시해야한다. 안그러면 가능한 모든 조합을 명시해줌
SELECT e.ENAME , e.SAL , e.DEPTNO , d.DNAME , d.LOC 
FROM EMP e , DEPT d;	

-- 1) 내부 JOIN : 일치하는 값이 있는 경우
-- ~~join on 같이 JOIN 할 조건
SELECT e.ENAME , e.SAL , e.DEPTNO , d.DNAME , d.LOC 
FROM EMP e INNER JOIN DEPT d ON e.DEPTNO = d.DEPTNO
WHERE e.SAL >= 3000;	
	
-- EMP, SALGRADE
-- 1번경우
SELECT e.SAL ,s.GRADE , s.LOSAL , s.HISAL 
FROM EMP e JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL ;

-- 2번경우
SELECT *
FROM EMP e , SALGRADE s 
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL ;
	
-- EMP, EMP JOIN(self JOIN)
SELECT e.EMPNO, e.ENAME, e.MGR , e2.ENAME AS MANAGER_NAME
FROM EMP e, EMP e2
WHERE e.MGR = e2.EMPNO ;
	
-- 2) 외부 JOIN
-- 왼쪽 외부 JOIN : LEFT OUTER JOIN
-- 오른쪽 외부 JOIN	: RIGHT OUTER JOIN

-- 기준이 EMP e가 기준
SELECT e.EMPNO, e.ENAME, e.MGR , e2.ENAME AS MANAGER_NAME
FROM EMP e LEFT OUTER JOIN EMP e2 ON e.MGR = e2.EMPNO;

-- 기준이 EMP e2가 기준 : e2가 기준이므로 e2의 행개수만큼 나와야한다
SELECT e.EMPNO, e.ENAME, e.MGR , e2.ENAME AS MANAGER_NAME
FROM EMP e RIGHT OUTER JOIN EMP e2 ON e.MGR = e2.EMPNO;
	
-- 각 부서별 평균 급여, 최대급여, 최소급여, 사원수
-- 부서번호, 부서명, 평균 급여, 최대급여, 최소급여, 사원수 순으로
-- GROUP BY 표현식이 아닙니다 : GROUP BY 옆에 오는 칼럼만 SELECT 절에 사용 가능
SELECT e.DEPTNO, d.DNAME , AVG(e.SAL), MIN(e.SAL), MAX(e.SAL) , COUNT(*)  
FROM EMP e INNER JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
GROUP BY e.DEPTNO, d.DNAME 
ORDER BY e.DEPTNO ;
	
-- EMP 테이블 3개 JOIN
SELECT
	*
FROM
	EMP e1
JOIN EMP e2 ON
	e1.EMPNO = e2.EMPNO
JOIN EMP e3 ON
	e2.EMPNO = e3.EMPNO ;
	
-- 모든 부서 정보와 사원 정보를 출력
-- 부서번호, 사원 이름순으로 정렬하여 출력
-- 부서번호, 부서명, 사원번호, 사원명, 직무명, 급여
-- DEPT 테이블을 기준으로 출력
SELECT d.DEPTNO , d.DNAME , e.EMPNO , e.ENAME , e.JOB , e.SAL 
FROM DEPT d LEFT JOIN EMP e ON d.DEPTNO = e.DEPTNO
ORDER BY d.DEPTNO , e.ENAME ;

SELECT d.DEPTNO , d.DNAME , e.EMPNO , e.ENAME , e.JOB , e.SAL 
FROM  EMP e RIGHT JOIN DEPT d ON d.DEPTNO = e.DEPTNO
ORDER BY d.DEPTNO , e.ENAME ;
	
-- 모든 부서 정보와 사원 정보를 출력
-- 부서번호, 사원 이름순으로 정렬하여 출력
-- 부서번호, 부서명, 사원번호, 사원명, 직무명, 급여, LOSAL, HISAL, GRADE
-- DEPT 테이블을 기준으로 출력
SELECT
	d.DEPTNO ,
	d.DNAME ,
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	s.LOSAL ,
	s.HISAL ,
	s.GRADE
FROM
	DEPT d
LEFT JOIN EMP e ON
	d.DEPTNO = e.DEPTNO
LEFT JOIN SALGRADE s ON
	e.SAL BETWEEN s.LOSAL AND s.HISAL
ORDER BY
	d.DEPTNO ,
	e.ENAME ;	
	
-- 4일차(1/26)
-- 서브쿼리
-- SQL문 내부에서 새로운 SELECT문을 사용
-- 괄호로 묶어서 사용
-- 메인 쿼리의 비교대상과 일치한 자료형과 같은 개수로 지정해야한다

-- EMP 테이블에 JONES 사원의 급여보다 높은급여를 받는 사원 조회
-- JONES 급여 알아내기 => 비교
SELECT SAL 
FROM EMP e 
WHERE ENAME = 'JONES';

SELECT *
FROM EMP e
WHERE SAL > 2975;

-- 2개를 합친 결과
SELECT
	*
FROM
	EMP e
WHERE
	SAL > (
	SELECT
		SAL
	FROM
		EMP e
	WHERE
		ENAME = 'JONES');

-- ALLEN 이 받는 COMM 보다 많은 추가수당을 받는 사원을 조회
SELECT
	*
FROM
	EMP e
WHERE
	COMM > (
	SELECT
		COMM
	FROM
		EMP e
	WHERE
		ENAME = 'ALLEN');

-- WARD 사원의 입사일보다 빠른 입사자를 조회
SELECT
	*
FROM
	EMP e
WHERE
	HIREDATE < (
	SELECT
		HIREDATE
	FROM
		EMP e
	WHERE
		ENAME = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균 급여보다 높은 급여를 받는 사원 조회
-- 사원번호, 사원명, 직무, 급여, 부서번호, 부서명, 지역
SELECT
	e.EMPNO,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	d.DEPTNO ,
	d.DNAME ,
	d.LOC
FROM
	EMP e
JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO
WHERE
	e.DEPTNO = 20
	AND e.SAL > (
	SELECT
		AVG(SAL)
	FROM
		EMP e);

-- 단일행 서브쿼리 : 서브쿼리 실행 결과가 단 하나의 행으로 나오는 서브쿼리
-- 단일행 사용가능한 연산자 : >, <, >=, <=, !=, <>, ^=	
	
-- 다중행 서브쿼리 : 서브쿼리 실행 결과가 여러개의  행으로 나오는 서브쿼리
-- 다중행 사용가능한 연사자 : IN, ANY(SOME), ALL, EXISTS

-- 단일 행 하위 질의에 2개 이상의 행이 리턴되었습니다
-- 서브쿼리가 여러 개의 결과값을 리턴하는데 단일행 서브쿼리에 사용하는 연산자가 사용된 경우	
-- SELECT MAX(SAL) FROM EMP e GROUP BY DEPTNO 이 부분이 3행이 나오기 때문
SELECT *
FROM EMP e 
WHERE SAL >= (SELECT MAX(SAL) FROM EMP e GROUP BY DEPTNO);

-- 각 부서별 최대치 연봉에 해당하는 사람들 나타내기
SELECT *
FROM EMP e 
WHERE SAL IN (SELECT MAX(SAL) FROM EMP e GROUP BY DEPTNO);

-- = ANY : IN이랑 비슷, 메인 쿼리의 조건식을 만족하는 서브쿼리가 1개이상
SELECT *
FROM EMP e 
WHERE SAL = ANY (SELECT MAX(SAL) FROM EMP e GROUP BY DEPTNO);

-- ALL(메인쿼리의 조건식을 서브쿼리의 결과 모두가 만족)

-- EXISTS(서브쿼리의 결과가 존재하면)

-- 30번부서 사원들의 최대급여보다 적은 급여를 받는 사원조회
-- 'ANY니까' 최대보다 작으면 다 적용되니까 1600, 1250, 2850, 1500, 950 이거중 작기만 하면됨
-- 2850보다만 작아도 TRUE
SELECT *
FROM EMP e 
WHERE SAL < ANY (SELECT SAL FROM EMP e WHERE DEPTNO = 30);

-- 1600, 1250, 2850, 1500, 950보다 다 적용해서 작아야함 => 최소인 950보다 작아야한다 : 모두 만족
SELECT *
FROM EMP e 
WHERE SAL < ALL (SELECT SAL FROM EMP e WHERE DEPTNO = 30);

-- 서브쿼리에 뭐 하나라도 나온다면,존재한다면 메인쿼리가 실행되게 하는 것
SELECT *
FROM EMP e 
WHERE EXISTS (SELECT DNAME FROM DEPT d WHERE DEPTNO = 20);

-- 실습1 전체 사원중 ALLEN과 같은 직책인 사원들의 사원정보, 부서정보 출력
SELECT *
FROM EMP e
WHERE JOB = (SELECT JOB FROM EMP e WHERE ENAME = 'ALLEN');

-- 실습2 전체 사원의 평균 급여보다 높은 급여를 받는 사원들의 사원정보, 부서정보, 급여 등급 정보를 출력
SELECT e.EMPNO , e.ENAME , d.DNAME , TO_CHAR(e.HIREDATE, 'YY/MM/DD') AS HIRE_DATE, d.LOC , e.SAL , s.GRADE 
FROM EMP e JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL JOIN DEPT d ON e.DEPTNO = d.DEPTNO 
WHERE e.SAL > (SELECT AVG(SAL) FROM EMP e)
ORDER BY e.SAL DESC , e.EMPNO ;


-- 다중열 서브쿼리
-- 부서별 급여 최대값
SELECT
	ENAME , SAL 
FROM
	EMP e
WHERE
	(DEPTNO,
	SAL) IN (
	SELECT
		DEPTNO ,
		MAX(SAL)
	FROM
		EMP e
	GROUP BY
		DEPTNO) ;

-- FROM 절에 사용하는 서브쿼리(인라인 뷰)
SELECT
	E10.EMPNO,
	E10.ENAME,
	E10.DEPTNO,
	d.DNAME,
	d.LOC
FROM
	(
	SELECT
		*
	FROM
		EMP e
	WHERE
		DEPTNO = 10) E10,
	(
	SELECT
		*
	FROM
		DEPT) d
WHERE
	E10.DEPTNO = d.DEPTNO;

-- SELECT 절에 사용하는 서브쿼리(스칼라 서브쿼리)
SELECT
	EMPNO ,
	ENAME ,
	JOB ,
	SAL ,
	(
	SELECT
		GRADE
	FROM
		SALGRADE s
	WHERE
		e.SAL BETWEEN s.LOSAL AND s.HISAL) AS SALGRADE
FROM
	EMP e ;

-- DML(Data Manipulation Language) : 데이터 조작 언어
-- SELECT(조회), INSERT(삽입), UPDATE(수정), DELETE(삭제)

-- 기존 테이블을 복제해서 새로운 테이블 생성
CREATE TABLE DEPT_TEMP AS SELECT * FROM DEPT;

-- 새로운 부서 추가
-- DB에 직접 추가 가능
-- INSERT INTO 테이블명(열 이름1, 열 이름2, ...)
-- VALUES(데이터, 데이터,....)

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(60, 'DATABASE', 'BUSAN');

-- 테이블 이름 옆 열이름 안써도 무방 : but 실수를 줄이기 위해 쓰기를 권장
INSERT INTO DEPT_TEMP
VALUES(70, 'DATABASE', 'BUSAN');

-- 값의 수가 충분하지 않습니다
INSERT INTO DEPT_TEMP
VALUES(80, 'DATABASE');

INSERT INTO DEPT_TEMP(DEPTNO, DNAME)
VALUES(80, 'DATABASE');

-- 이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다
INSERT INTO DEPT_TEMP(DEPTNO, DNAME)
VALUES(800, 'DATABASE');

INSERT INTO DEPT_TEMP(DEPTNO, DNAME, LOC)
VALUES(90, 'DATABASE', NULL);

CREATE TABLE EMP_TEMP AS SELECT * FROM EMP ;

INSERT INTO EMP_TEMP(EMPNO, ENAME,JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(8000, 'BRIAN', 'MANAGER', 7902, '2015-03-15', 1000, NULL, 50);

INSERT INTO EMP_TEMP(EMPNO, ENAME,JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(9000, 'EMILY', 'MANAGER', 7782, SYSDATE, 1200, 800, 50);

-- 테이블의 구조만 복사 , 데이터는 복사하지 X
CREATE TABLE EMP_TEMP2 AS SELECT * FROM EMP WHERE 1<>1;

-- 수정 : UPDATE
-- UPDATE 테이블명 SET 수정할 내용들, ..... ;
-- UPDATE 테이블명 SET 수정할 내용들, ..... WHERE 조건 ;

UPDATE DEPT_TEMP
SET LOC = 'BUSAN';

UPDATE DEPT_TEMP
SET LOC = 'SEOUL'
WHERE DEPTNO = 50;

UPDATE DEPT_TEMP
SET LOC = 'SEOUL', DNAME = 'NETWORK'
WHERE DEPTNO = 40;

-- 삭제(행단위 삭제)
-- DELETE 테이블명 WHERE 조건
-- DELETE FROM 테이블명 WHERE 조건

DELETE DEPT_TEMP
WHERE DEPTNO = 20;

DELETE FROM DEPT_TEMP
WHERE DEPTNO = 30;
	
-- 서브쿼리 + DELETE
-- 급여등급이 3등급이고 30번 부서에 사원 삭제

DELETE
FROM
	EMP_TEMP
WHERE
	EMPNO IN (
	SELECT
		EMPNO
	FROM
		EMP_TEMP e
	JOIN SALGRADE s ON
		e.SAL BETWEEN s.LOSAL AND s.HISAL
		AND s.GRADE = 3
		AND DEPTNO = 30);

-- 서브쿼리 + UPDATE
UPDATE DEPT_TEMP 
SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT d WHERE DEPTNO = 40)
WHERE DEPTNO = 40;

-- 서브쿼리 + INSERT
INSERT INTO EMP_TEMP(EMPNO, ENAME,JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT e.EMPNO , e.ENAME , e.JOB , e.MGR , e.HIREDATE , e.SAL , e.COMM , e.DEPTNO 
FROM EMP e JOIN SALGRADE s ON e.SAL BETWEEN s.LOSAL AND s.HISAL AND s.GRADE = 1;

-- 연습문제1
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP e ;
CREATE TABLE EXAM_DEPT AS SELECT * FROM DEPT d ;
CREATE TABLE EXAM_SALGRADE AS SELECT * FROM SALGRADE s ;

--연습문제2
-- INSERT, VALUES는 각각 다 써야한다
INSERT INTO EXAM_EMP(EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO);
VALUES(7201, 'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL, 50);

-- !!연습문제3
-- EXAM_EMP에 속한 사원 중 50번 부서에서 근무하는 사원들의 평균 급여보다 많은
-- 급여를 받고 있는 사원들을 70번 부서로 옮기기	 
UPDATE EXAM_EMP 
SET DEPTNO = 70
WHERE SAL > (SELECT AVG(SAL) FROM EXAM_EMP WHERE DEPTNO = 50);

-- 연습문제4
-- EXAM_EMP에 속한 사원 중 60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 늦게 입사한
-- 사원의 급여를 10% 인상하고 80번 부서로 옮기기

UPDATE  EXAM_EMP 
SET SAL = SAL* 1.1, DEPTNO = 80
WHERE HIREDATE > (SELECT MIN(HIREDATE)  
FROM EXAM_EMP ee
WHERE DEPTNO = 60) ;

-- 연습문제5
-- EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문 작성
DELETE FROM EXAM_EMP
WHERE EMPNO IN (SELECT EMPNO FROM EXAM_EMP ee, SALGRADE s WHERE SAL BETWEEN s.LOSAL AND s. HISAL AND GRADE = 5);

--5일차
-- Transaction
-- 하나의 작업 또는 밀접하게 연관되어 있는 작업 수행을 위해 나눌 수 없는 최소 작업 단위
-- 최종 반영(commit) / 모두 취소(rollback)
-- DBeaver 설정에서 commit 모드 변경 가능
-- 기본은 auto commit 상태임

INSERT INTO DEPT_TEMP
VALUES(55, 'NETWORK', 'SEOUL');

UPDATE DEPT_TEMP 
SET LOC = 'BUSAN'
WHERE DEPTNO = 55;

COMMIT; 
ROLLBACK; -- COMMIT 하기 전 해야 함

SELECT *
FROM DEPT_TEMP dt ;

DELETE FROM DEPT_TEMP dt 
WHERE DEPTNO = 55;
UPDATE DEPT_TEMP 
SET DNAME = 'WEB' WHERE DEPTNO = 10;

COMMIT;

-- LOCK => 한 세션에서 transaction 작업이 완료되지 않으면 
-- 다른 세션에서 작업을 처리할 수 없는 상태(DML - insert, update, delete)


-- SQL => 1. DDL(정의)  2. DML - select, insert, update, delete   3. DCL (권한부여)
-- 데이터 정의어(DDL)
-- TALBE 정의, 사용자 정의, 권한 부여(취소)
-- CREATE

-- 1. 테이블 생성
-- CREATE TABLE 테이블명(
-- 필드명, 필드타입(크기), 제약조건
--)

-- 열 이름 규칙 : 문자로 시작 / 30byte 이하로 작성 / 한 테이블 안 열 이름 중복 X
-- 열 이름은 문자, 0 - 9, 특수문자($, # , _), 사용 가능
-- SQL 키워드는 열 이름으로 사용불가(order, group, select ...)

-- 문자 : CHAR, VARCHAR2, NCHAR, NVARCHAR, CLOB, NCLOB, LONG
-- char or varchar : 열의 너비가 고정값인지 가변인지
-- char(10) : 'hong' : 10자리 다 사용
-- varchar2(10) : 'hong' : 입력된 글자에 따라 가변적

-- varchar2, char가 한글, 영문 입력 시 사용하는 바이트 수가 다름
-- nchar, nvarchar 사용하는 바이트 수 통리해서 사용
-- nchar(10) : 'hong' : 유니코드 문자열 타입이고, 고정
-- nvarchar2(10) : 유니코드 문자열 타입이고, 가변
-- CLOB : 문자열 데이터를 외부 파일로 저장
--		  엄청 많은 텍스트 데이터 입력 시 사용(4GB)
--LONG : 2GB저장

-- 숫자
-- NUMBER(전체자릿수, 소수점자릿수)
-- BINARY_FLOAT, BINARY_DOUBLE

-- 날짜
-- DATE, TMESTAMP

CREATE TABLE EMP_DDL(
	EMPNO NUMBER(4),
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2)
);

SELECT *
FROM EMP_DDL ;

-- 기본 테이블 열 구조와 데이터 복사해서 새 테이블 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP ;

-- 기본 테이블 열 구조만 복사해서 새 테이블 생성
CREATE TABLE EXAM_EMP AS SELECT * FROM EMP WHERE 1<>1 ;

-- DDL : CREATE, ALTER
-- 2. 테이블 변경

-- 1) 열 추가(ADD)
-- ALTER TABLE 테이블명 ADD 추가할 열 이름 데이터타입(크기)
-- EMP_DDL 테이블에 HP Column을 추가
ALTER TABLE EMP_DDL ADD HP VARCHAR2(15);

SELECT *
FROM EMP_DDL ed ;

-- 2) 열 이름 변경(RENAME)
-- ALTER TABLE 테이블명 RENAME COLUMN 기존이름 TO 변경이름
-- HP -> MOBILE
ALTER TABLE EMP_DDL RENAME COLUMN HP TO MOBILE;

SELECT *
FROM EMP_DDL ed ;

-- 3) 열 자료형 변경(MODIFY)
-- ALTER TABLE 테이블명 MODIFY 열이름 데이터타입(크기)
-- EMPNO 데이터타입을 NUMBER(5)로 변경
ALTER TABLE EMP_DDL MODIFY EMPNO NUMBER(5);

SELECT *
FROM EMP_DDL ed ;

-- 4) 열 제거
-- ALTER TABLE 테이블명 DROP COLUMN 열이름
ALTER TABLE EMP_DDL DROP COLUMN MOBILE;

SELECT *
FROM EMP_DDL ed ;

-- 5) 테이블 이름 변경
-- RENAME 변경전테이블명 TO 변경할 테이블명
-- EMP_DDL => EMP_ALTER
RENAME EMP_DDL TO EMP_ALTER;

SELECT *
FROM EMP_ALTER;

-- CREATE, ALTER, DROP
-- 3. 삭제 : DROP
-- DROP TABLE 테이블명
DROP TABLE EMP_ALTER;

-- VIEW : 가상테이블
-- CREATE VIEW 뷰이름 AS (SELECT * FROM 원본 테이블명)
-- VIEW를 통해 원본 수정이 가능
-- 편리성, 보안성

-- 권한이 불충분
-- view는 권한을 가진 사용자만 생성 가능
CREATE VIEW VM_EMP20 AS (SELECT * FROM EMP WHERE DEPTNO = 20);

SELECT *
FROM VM_EMP20 ve ;

-- 가상 테이블에 데이터 삽입 시 원본에도 영향을 미침
INSERT INTO VM_EMP20 ve
VALUES(7878,'BRIAN','PRESIDENT',8989, SYSDATE, 5000, NULL, 20);

SELECT *
FROM VM_EMP20 ve ;

SELECT *
FROM EMP e ;

SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'VM_EMP20';

-- CREATE VIEW 뷰이름 AS (SELECT * FROM 원본 테이블명)
-- VIEW를 통해 읽기만 가능
CREATE VIEW VM_EMP30 AS (SELECT * FROM EMP WHERE DEPTNO = 30) WITH READ ONLY ;

SELECT *
FROM USER_UPDATABLE_COLUMNS
WHERE TABLE_NAME = 'VM_EMP30';

-- VIEW 삭제
DROP VIEW VM_EMP20 ;

-- INDEX 생성, 삭제
-- INDEX(색인, 목차)
-- 인덱스 : 기본키, 고유키일 때 자동으로 생성됨

-- CREATE INDEX 인덱스명 ON 테이블명(인덱스로 사용할 필드명)
CREATE INDEX idx_EMP_SAL ON EMP(SAL);

SELECT *
FROM USER_IND_COLUMNS ;

DROP INDEX idx_EMP_SAL;

-- 시퀀스 생성 / 삭제
-- oracle 객체, 하나씩 증감하는 값이 필요할 때 주로 사용
-- 다른 DB의 auto_increment과 동일
--CREATE SEQUENCE 시퀀스명 
--INCREMENT BY 증감값 START WITH 시작값 MAXVALUE 최대값 MINVALUE 최소값
--nocycle cache 숫자 ;

-- 1에서 시작 ~ 9999999999999999
-- 1씩 증가하면서 숫자 생성
CREATE SEQUENCE dept_seq ;  -- 기본
DROP SEQUENCE dept_seq ;

SELECT *
FROM USER_SEQUENCES ;

CREATE TABLE dept_sequence AS SELECT * FROM DEPT d WHERE 1<>1;

CREATE SEQUENCE dept_seq
INCREMENT BY 10 START WITH 10 MAXVALUE 90 MINVALUE 0
NOCYCLE CACHE 2;

-- 시퀀스 dept_seq.nextval, exceeds maxvalue는 사례
INSERT INTO dept_sequence(DEPTNO, DNAME, LOC)
VALUES(dept_seq.NEXTVAL, 'DATABASE', 'SEOUL');

SELECT *
FROM dept_sequence ;

ALTER SEQUENCE dept_seq
INCREMENT BY 3 MAXVALUE 99
CYCLE ;

SELECT *
FROM dept_sequence ;

-- 마지막으로 생성된 시퀀스 확인
SELECT dept_seq.CURRVAL
FROM DUAL;















