CREATE TABLE EMP(
	EMPNO NUMBER
) ;

INSERT INTO EMP
VALUES(1);

-- booktbl 생성
-- code, title, writer, price 컬럼
-- 숫자4자리(PK), 문자, 문자, 숫자
-- 전부 not null

CREATE TABLE BOOKTBL(
CODE NUMBER(4) PRIMARY KEY, 
TITLE NVARCHAR2(50) NOT NULL, 
WRITER NVARCHAR2(10) NOT NULL, 
PRICE NUMBER(8) NOT NULL);

INSERT INTO BOOKTBL b(code, title, writer, price)
VALUES(1001,'파이썬프로그래밍입문','김은종',33500);

INSERT INTO BOOKTBL b(code, title, writer, price)
VALUES(1002,'데이터베이스입문','이은종',22500);

INSERT INTO BOOKTBL b(code, title, writer, price)
VALUES(1003,'C프로그래밍입문','윤은종',29500);

INSERT INTO BOOKTBL b(code, title, writer, price)
VALUES(1004,'C#프로그래밍입문','강은종',40500);

INSERT INTO BOOKTBL b(code, title, writer, price)
VALUES(1005,'Oracle입문','성은종',30500);

-- 전체조회
SELECT *
FROM BOOKTBL b ;

-- 특정조회
SELECT *
FROM BOOKTBL b 
WHERE CODE = 1000;

SELECT *
FROM BOOKTBL b 
WHERE WRITER = '이은종';

SELECT *
FROM BOOKTBL b
WHERE TITLE LIKE '자바%';

-- 데이터수정
UPDATE BOOKTBL SET PRICE  = 35000 WHERE CODE = 1000;

-- 데이터삭제
DELETE FROM BOOKTBL WHERE CODE = 1004;

-- 회원정보 저장 테이블 memberTBL
-- userid(숫자,문자,특수문자), password(숫자,문자,특수문자), name(문자), email

CREATE TABLE MEMBERTBL(USERID NVARCHAR2(20) PRIMARY KEY, 
PASSWORD NVARCHAR2(20) NOT NULL, 
NAME NVARCHAR2(10) NOT NULL ,
EMAIL NVARCHAR2(50) NOT NULL);

INSERT INTO MEMBERTBL(USERID, PASSWORD, NAME, EMAIL)
VALUES('hong123','hong123@','홍길동','hong123@gmail.com');

SELECT * FROM MEMBERTBL WHERE USERID = 'hong123' AND PASSWORD = 'hong123@';

INSERT INTO MEMBERTBL(USERID, PASSWORD, NAME, EMAIL) VALUES('kong123','kong123@','공길동','kong123@gmail.com');
INSERT INTO MEMBERTBL VALUES('uj05273','brian981103','Brian','brian110326@gmail.com');

UPDATE MEMBERTBL SET PASSWORD = 'hong456' WHERE USERID = 'hong123';


DELETE FROM MEMBERTBL WHERE USERID = 'uj';


CREATE TABLE todotbl(
NO NUMBER(8) PRIMARY KEY,
title nvarchar2(100) NOT NULL,
created_at DATE DEFAULT sysdate,
completed char(1) DEFAULT '0',
description nvarchar2(1000));

CREATE SEQUENCE todo_seq;

SELECT *
FROM todotbl;

INSERT INTO todotbl(NO, TITLE, DESCRIPTION)
VALUES(todo_seq.nextval, 'Java 환경설정','java 환경설정 및 정리');

SELECT *
FROM todotbl
WHERE NO = 1;

UPDATE TODOTBL  
SET COMPLETED = 1
WHERE NO = 1;

UPDATE TODOTBL 
SET COMPLETED = '1', DESCRIPTION ='변경'
WHERE NO = 1;

DELETE FROM TODOTBL t WHERE NO = 5;


SELECT *
FROM BOOKTBL b
ORDER BY CODE ;

ALTER TABLE booktbl ADD description nvarchar2(1000);

INSERT INTO BOOKTBL b 
VALUES(1004,'JSP입문','장은종',35000,NULL);


SELECT *
FROM BOOKTBL b ;

SELECT *
FROM MEMBERTBL m ;

-- bno, name, password, title, content, attatch, re_ref, re_lev, re_seq, read_count, regdate
-- bno(글번호) : pk, number, sequence로 
-- name : nvarchar2(10) 작성자 not null
-- password : 비밀번호 nvarchar2(20) not null
-- title : 제목 nvarchar2(20) not null
-- content : 내용 nvarchar2(1000) not null
-- attatch : nvarchar2(100) 업로드 파일명
-- re_ref, re_lev, re_seq : number(8) not null, 페이지 나누기용
-- read_count : number, default = 0, 조회수
-- regdate : date, default = sysdate (작성일자)
-- seq 생성 : board_seq

CREATE TABLE BOARD(
bno NUMBER(8) PRIMARY KEY,
name NVARCHAR2(10) NOT NULL,
password NVARCHAR2(20) NOT NULL,
title NVARCHAR2(20) NOT NULL,
content NVARCHAR2(1000) NOT NULL,
attatch NVARCHAR2(100),
re_ref NUMBER(8) NOT NULL,
re_lev NUMBER(8) NOT NULL,
re_seq NUMBER(8) NOT NULL,
read_count NUMBER DEFAULT 0,
regdate DATE DEFAULT sysdate);

CREATE SEQUENCE board_seq;

SELECT *
FROM BOARD;

INSERT INTO board(bno,name,password,title,content,attatch,re_ref,re_lev,re_seq)
VALUES(board_seq.nextval,'홍길동','12345','게시판 작성','게시판 작성',NULL,board_seq.currval,0,0);


-- 더미 데이터 삽입
-- 서브쿼리
INSERT INTO BOARD(bno,name,password,title,content,re_ref,re_lev,re_seq)
(SELECT board_seq.nextval,name,password,title,content,board_seq.currval,re_lev,re_seq FROM BOARD);

SELECT COUNT(*) FROM BOARD b ; 

-- 댓글
SELECT * FROM BOARD b ORDER BY BNO DESC;

-- 마지막 게시물에 댓글 삽입

-- 첫번째 댓글 달기
-- re_ref : 원본 글 re_ref 번호그대로
-- re_lev : 원본 글 re_lev + 1 (댓글인지, 대댓글인지, 대대대대대대댓글인지 판별)
-- re_seq : 원본 글 re_seq + 1
INSERT INTO board(bno,name,password,title,content,attatch,re_ref,re_lev,re_seq)
VALUES(board_seq.nextval,'홍길동','12345','re:댓글 작성','re:댓글 작성',NULL,2316,1,1);

-- 두번째 댓글 달기
-- 댓글도 최신 댓글로 정렬이 필요함

-- ★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★★
-- re_seq : 댓글 정렬 시 값이 낮을수록 최신글(re_seq가 1이면 2로 바꾸고 새로운 댓글을 1로 설정)
-- 먼저 기존 댓글의 re_seq 값을 + 1 한 후 insert작업을 진행한다.
-- re_seq > 0 ==> 0은 원본글의 re_seq값, 0의 자리에 원본의 re_seq값을 넣으면 된다
UPDATE BOARD SET RE_SEQ = RE_SEQ + 1 WHERE RE_REF = 2316 AND RE_SEQ > 0;

INSERT INTO board(bno,name,password,title,content,attatch,re_ref,re_lev,re_seq)
VALUES(board_seq.nextval,'홍길동','12345','re:댓글2 작성','re:댓글2 작성',NULL,2316,1,1);

INSERT INTO BOARD(bno,name,password,title,content,attatch,re_ref,re_lev,re_seq)
VALUES(board_seq.nextval,'aa','a123','댓글1','댓글1내용',NULL,2315,1,1);

SELECT * FROM BOARD b WHERE RE_REF =2315 ORDER BY RE_SEQ ;

UPDATE BOARD SET RE_SEQ = RE_SEQ + 1 WHERE RE_REF = 2315 AND RE_SEQ > 0;

INSERT INTO BOARD(bno,name,password,title,content,attatch,re_ref,re_lev,re_seq)
VALUES(board_seq.nextval,'bb','b123','댓글2','댓글2내용',NULL,2315,1,1);




SELECT * FROM BOARD b WHERE RE_REF = 2316 ORDER BY RE_REF DESC, RE_SEQ  ;

SELECT BNO ,TITLE ,NAME ,REGDATE ,READ_COUNT ,RE_LEV  FROM BOARD b ORDER BY RE_REF DESC, RE_SEQ  ;

UPDATE BOARD SET READ_COUNT = READ_COUNT + 1 WHERE BNO = 2316;

--검색
SELECT * 
FROM BOARD b 
WHERE NAME = '홍길동' 
ORDER BY RE_REF DESC, RE_SEQ  ;

SELECT * 
FROM BOARD b 
WHERE TITLE  = '홍길동' 
ORDER BY RE_REF DESC, RE_SEQ  ;

SELECT * 
FROM BOARD b 
WHERE CONTENT  = '홍길동' 
ORDER BY RE_REF DESC, RE_SEQ  ;

-- 페이지 나누기
-- rownum : 가상컬럼 => 조회된 결과값에 번호를 부여

SELECT rownum, bno, title FROM BOARD ORDER BY bno DESC ;

SELECT rownum, bno, title FROM BOARD WHERE rownum > 1 ;

SELECT rownum, bno, title FROM BOARD WHERE rownum <= 10 ORDER BY BNO  DESC  ;

-- rownum이 먼저 부여가 되기 때문에 (정렬된후 행에 번호가 붙는게 아님)
SELECT rownum, bno, title, name, REGDATE ,READ_COUNT ,RE_LEV  
FROM BOARD b 
WHERE rownum <= 10
ORDER BY RE_REF DESC, RE_SEQ  ;


-- 1.
SELECT rownum, bno, title, name, REGDATE ,READ_COUNT ,RE_LEV  
FROM BOARD b WHERE bno > 0
ORDER BY RE_REF DESC, RE_SEQ;

-- 2.
-- 위의 테이블에서 다시 새로 rownum이 부여
SELECT rownum AS rnum, A.*
FROM (SELECT rownum, bno, title, name, REGDATE ,READ_COUNT ,RE_LEV  
FROM BOARD b WHERE bno > 0
ORDER BY RE_REF DESC, RE_SEQ) A
WHERE rownum <= 60

-- 3.
SELECT bno, title, name, REGDATE ,READ_COUNT ,RE_LEV
FROM
(SELECT rownum AS rnum, A.*
FROM (SELECT rownum, bno, title, name, REGDATE ,READ_COUNT ,RE_LEV  
FROM BOARD b WHERE bno > 0
ORDER BY RE_REF DESC, RE_SEQ) A
WHERE rownum <= ?) 
WHERE rnum > ? ;

-- 페이지 당 30개씩
-- 1 page => 1 ~ 30
-- 2 page => 31 ~ 60

-- 1 * 30 = 30
-- (1-1) * 30 = 0

-- start 계산 : 페이지번호 * 한 페이지당 게시물 수
-- end 계산 : (페이지번호-1) * 한 페이지당 게시물 수

-- 검색시에도 페이지 나누기가 있어야함
-- 추가되는 부분 : ex) AND title LIKE '%File%'
SELECT bno, title, name, REGDATE ,READ_COUNT ,RE_LEV
FROM
(SELECT rownum AS rnum, A.*
FROM (SELECT rownum, bno, title, name, REGDATE ,READ_COUNT ,RE_LEV  
FROM BOARD b WHERE bno > 0 AND title LIKE '%File%'
ORDER BY RE_REF DESC, RE_SEQ) A
WHERE rownum <= 30) 
WHERE rnum > 0 ;

-- 전체 게시물 수
SELECT COUNT(*)  FROM BOARD b ;

-- 검색한 게시물 전체 개수
SELECT COUNT(*)  FROM BOARD b WHERE TITLE LIKE '%File%';


















































































