-- board, member email 조회
SELECT b.BNO ,b.CONTENT , b.TITLE ,b.WRITER_EMAIL , m.NAME ,m.PASSWORD, COUNT(r.TEXT) AS 댓글수
FROM BOARD b
JOIN MEMBER m ON b.WRITER_EMAIL  = m.email
JOIN REPLY r ON b.BNO = r.BOARD_BNO
GROUP BY b.BNO ,b.CONTENT ,b.TITLE ,b.WRITER_EMAIL ,m.NAME ,m.PASSWORD ;

-- 게시글 + 댓글 조회
SELECT b.BNO ,b.CONTENT ,b.TITLE ,r.RNO ,r.TEXT 
FROM BOARD b
JOIN REPLY r ON b.bno = r.BOARD_BNO ;


-- movie, movie_image, review

-- 영화별 리뷰 개수와 평균 평점 조회

SELECT r.MOVIE_MNO , COUNT(*) AS 리뷰개수, AVG(r.GRADE) AS 평균평점 
FROM REVIEW r 
GROUP BY r.MOVIE_MNO ;

-- 영화별 리뷰 개수와 평균 평점 조회 + 영화정보
-- 리뷰가 없을 수도 있으니 left join
SELECT *
FROM MOVIE m 
LEFT JOIN (SELECT r.MOVIE_MNO , COUNT(*) AS 리뷰개수, AVG(r.GRADE) AS 평균평점
FROM REVIEW r 
GROUP BY r.MOVIE_MNO) r1 ON m.MNO = r1.movie_mno;

SELECT m.*, (SELECT COUNT(DISTINCT r.review_no)  FROM REVIEW r WHERE r.movie_mno = m.MNO) AS review_cnt,
(SELECT AVG(r.GRADE)  FROM REVIEW r WHERE r.movie_mno = m.MNO) AS grade_avg
FROM MOVIE m ;

-- 영화별 리뷰 개수와 평균 평점 조회 + 영화정보 + 영화별 이미지(1개의 영화에 여러개의 이미지가 존재)
-- 여러개가 있다면 제일 낮은번호의 이미지 가져오기
SELECT *
FROM MOVIE m 
LEFT JOIN (SELECT r.MOVIE_MNO , COUNT(*) AS 리뷰개수, AVG(r.GRADE) AS 평균평점
FROM REVIEW r 
GROUP BY r.MOVIE_MNO) r1 ON m.MNO = r1.movie_mno;

-- 집계함수, 일반 필드는 같이 조회 X
SELECT mi.MOVIE_MNO , MIN(mi.INUM)
FROM MOVIE_IMAGE mi
GROUP BY mi.MOVIE_MNO;

-- movie_image의 다른 필드 조회하기
SELECT *
FROM MOVIE_IMAGE m
WHERE m.INUM IN (SELECT MIN(mi.INUM)
FROM MOVIE_IMAGE mi
GROUP BY mi.MOVIE_MNO);

-- 최종 : movie LIst에 필요한 컬럼
-- 영화번호, 대표이미지(path/uuid_imgName), 영화명, 리뷰개수, 평균별점, 등록일

SELECT m1.movie_mno, m2.title, m1.PATH, m1.uuid, m1.img_name, m2.리뷰개수, m2.평균평점, m2.created_date
FROM (SELECT *
FROM MOVIE_IMAGE m
WHERE m.INUM IN (SELECT MIN(mi.INUM)
FROM MOVIE_IMAGE mi
GROUP BY mi.MOVIE_MNO)) m1
LEFT JOIN (SELECT *
FROM MOVIE m 
LEFT JOIN (SELECT r.MOVIE_MNO , COUNT(*) AS 리뷰개수, AVG(r.GRADE) AS 평균평점
FROM REVIEW r 
GROUP BY r.MOVIE_MNO) r1 ON m.MNO = r1.movie_mno) m2 ON m1.movie_mno = m2.movie_mno;

--querydsl 이걸로함
SELECT m.MNO ,m.CREATED_DATE ,m.TITLE , mi2.IMG_NAME , mi2."PATH" ,mi2.UUID, 
(SELECT COUNT(DISTINCT r.review_no)  FROM REVIEW r WHERE r.movie_mno = m.MNO) AS review_cnt,
(SELECT AVG(r.GRADE)  FROM REVIEW r WHERE r.movie_mno = m.MNO) AS grade_avg
FROM MOVIE_IMAGE mi2 LEFT JOIN MOVIE m ON mi2.MOVIE_MNO = m.MNO 
WHERE mi2.INUM IN (SELECT MIN(mi.INUM)
FROM MOVIE_IMAGE mi
GROUP BY mi.MOVIE_MNO);

SELECT m1.inum, m1.movie_mno, m1.img_name, m1.PATH, m1.uuid, m2.mno, m2.created_date, m2.title, m2.review_cnt, m2.grade_avg
FROM (SELECT *
FROM MOVIE_IMAGE m
WHERE m.INUM IN (SELECT MIN(mi.INUM)
FROM MOVIE_IMAGE mi
GROUP BY mi.MOVIE_MNO)) m1
LEFT JOIN (SELECT m.MNO ,m.CREATED_DATE ,m.TITLE , mi2.IMG_NAME , mi2."PATH" ,mi2.UUID, (SELECT COUNT(DISTINCT r.review_no)  FROM REVIEW r WHERE r.movie_mno = m.MNO) AS review_cnt,
(SELECT AVG(r.GRADE)  FROM REVIEW r WHERE r.movie_mno = m.MNO) AS grade_avg
FROM MOVIE_IMAGE mi2 LEFT JOIN MOVIE m ON mi2.MOVIE_MNO = m.MNO 
WHERE mi2.INUM IN (SELECT MIN(mi.INUM)
FROM MOVIE_IMAGE mi
GROUP BY mi.MOVIE_MNO)) m2 ON  m1.movie_mno = m2.mno;

SELECT *
FROM MOVIE m LEFT JOIN (SELECT r.MOVIE_MNO , COUNT(*) , AVG(r.GRADE) 
FROM REVIEW r 
GROUP BY r.MOVIE_MNO) r1 ON m.MNO = r1.movie_mno
LEFT JOIN (SELECT mi2.* FROM MOVIE_IMAGE mi2 WHERE mi2.inum
IN (SELECT MIN(mi.inum) FROM MOVIE_IMAGE mi GROUP BY mi.movie_mno)) A ON m.MNO = A.movie_mno
ORDER BY MNO DESC ;


-- 특정 영화의 정보 + 평균평점 + 리뷰 수 + 이미지(정보전체)
SELECT m.MNO ,m.CREATED_DATE ,m.TITLE , mi2.IMG_NAME , mi2."PATH" ,mi2.UUID, 
(SELECT COUNT(DISTINCT r.review_no)  FROM REVIEW r WHERE r.movie_mno = m.MNO) AS review_cnt,
(SELECT AVG(r.GRADE)  FROM REVIEW r WHERE r.movie_mno = m.MNO) AS grade_avg
FROM MOVIE_IMAGE mi2 LEFT JOIN MOVIE m ON mi2.MOVIE_MNO = m.MNO
WHERE mi2.MOVIE_MNO = 3;


-- 영화삭제 => 영화이미지, 리뷰가 먼저 삭제되어야함
-- 이미지 삭제
DELETE  FROM MOVIE_IMAGE mi WHERE mi.movie_mno=1;
DELETE  FROM REVIEW r WHERE r.movie_mno=1;
DELETE FROM MOVIE m WHERE m.mno=1;






























































































































































































