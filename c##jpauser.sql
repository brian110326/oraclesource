-- 회원과 팀(N:1)

CREATE TABLE team(
team_id varchar2(255) PRIMARY KEY,
name varchar2(255));

CREATE TABLE team_member(
member_id varchar2(255) PRIMARY KEY,
username varchar2(255),
					  -- 외래 키 제약조건
team_id varchar2(255) CONSTRAINT fk_member_team REFERENCES team(team_id));


-- 무결성 제약조건(C##JPAUSER.FK_MEMBER_TEAM)이 위배되었습니다- 부모 키가 없습니다
-- 참조되는 데이터 먼저 입력, 그다음 참조하는 데이터 입력(부모 먼저 입력)
INSERT INTO TEAM t VALUES('team1','victory');
INSERT INTO TEAM_MEMBER tm VALUES('member1','홍길동','team1');

-- 무결성 제약조건(C##JPAUSER.FK_MEMBER_TEAM)이 위배되었습니다- 자식 레코드가 발견되었습니다
-- delete : 외래키를 참조하는 데이터 먼저 삭제, 그다음 참조되는 데이터 삭제(자식 먼저 삭제)
DELETE FROM TEAM t WHERE team_id = 'team1';
DELETE FROM TEAM_MEMBER tm WHERE member_id = 'member1';


-- ON DELETE CASCADE : 부모가 삭제될 때 참조하는 데이터도 같이 삭제
-- ON DELETE SET NULL : 부모가 삭제될 때 참조하는 데이터의 외래키를 NULL로 변경
CREATE TABLE team1(
team_id varchar2(255) PRIMARY KEY,
name varchar2(255));

CREATE TABLE team_member1(
member_id varchar2(255) PRIMARY KEY,
username varchar2(255),
					  -- 외래 키 제약조건
team_id varchar2(255) CONSTRAINT fk_member_team1 REFERENCES team1(team_id) ON DELETE CASCADE);

INSERT INTO TEAM1 t VALUES('team1','victory');
DELETE FROM TEAM1 t WHERE team_id = 'team1';

INSERT INTO TEAM_MEMBER1 tm VALUES('member1','홍길동','team1');
DELETE FROM TEAM_MEMBER1 tm WHERE member_id = 'member1';

-- 조회
-- 1. JOIN
-- 1) 내부join : 두 테이블이 서로 일치할 때 가져오기
-- 2) 외부join : 두 테이블이 일치하지 않아도 가져오기
--    (1) left join : 왼쪽 테이블 기준
--    (2) right join : 오른쪽 테이블 기준




-- member1 의 정보와 member1이 속한 팀의 정보 조회
SELECT t1.MEMBER_ID ,t1.USERNAME ,t1.TEAM_ID ,t.NAME 
FROM TEAM_MEMBER1 t1
JOIN TEAM1 t ON t1.team_id = t.TEAM_ID
WHERE t1.MEMBER_ID = 'member1';

-- team1에 속한 회원들의 정보 조회
SELECT t1.MEMBER_ID ,t1.USERNAME ,t1.TEAM_ID ,t.NAME 
FROM TEAM_MEMBER1 t1
JOIN TEAM1 t ON t1.team_id = t.TEAM_ID
WHERE t.TEAM_ID = 'team1';


-- member2 회원 조회 시 나와 같은 팀에 소속된 회원 조회
SELECT *
FROM TEAM_MEMBER tm
WHERE TEAM_TEAM_ID = (SELECT TEAM_TEAM_ID FROM TEAM_MEMBER tm2 WHERE MEMBER_ID='member2');

-- 보다 더 빠른 조회 : WHERE b.BOOK_ID > 0
SELECT * FROM BOOK b WHERE b.BOOK_ID > 0 ORDER BY b.BOOK_ID DESC ;

INSERT INTO BOOK(BOOK_ID,TITLE,WRITER,PRICE,SALE_PRICE,CATEGORY_CATEGORY_ID,PUBLISHER_PUBLISHER_ID,CREATED_DATE,LAST_MODIFIED_DATE)






































































































