-- scott 권한 부여
GRANT CONNECT, resource TO scott;
GRANT CREATE VIEW TO scott;

--데이터를 저장할 수 있는 저장공간 할당
ALTER USER SCOTT DEFAULT TABLESPACE USERS;
ALTER USER SCOTT TEMPORARY TABLESPACE TEMP;
ALTER USER SCOTT QUOTA 10M ON USERS;

alter session set "_oracle_script"=true;


-- 6일차(1/30)
-- DBA 권한을 가진 사용자만 사용자를 생성하고 권한을 부여
-- SYSTEM, sys as sysdba

-- CREATE USER  아이디 IDENTIFIED BY 비밀번호;

-- test user 생성
-- 공통 사용자 또는 롤 이름이 부적합합니다
-- 21c XE 버전 요구사항 아이디 앞에 c##접두어 붙이기
CREATE USER c##test IDENTIFIED BY test ;

-- CREATE SESSION 권한을 가지고있지 않음 : 로그온 거절
-- => 권한 부여 필요
-- SESSION 권한, CREATE 권한, USER or TABLE or SEQUENCE or VIEW ...의 권한
-- 권한 그룹 => 롤
-- CONNECT, RESOURCE
-- CONNECT(SESSION, CREATE TABLE, CREATE VIEW, ......)
-- RESOURCE(SEQUENCE, 프로시저, 테이블생성......)

-- GRANT 권한이름.... TO 아이디
-- GRANT 롤 이름..... TO 아이디
GRANT CONNECT , RESOURCE TO c##test ;

-- 사용할 공간 부여
CREATE USER c##test2 IDENTIFIED BY test
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP
QUOTA 10M ON USERS ;

GRANT CONNECT , RESOURCE TO c##test2 ;

--REVOKE 취소할 권한 이름, .... FROM 아이디

-- 비밀번호 변경
-- ALTER USER c##test2 IDENTIFIED BY 새로운 비밀번호












































































