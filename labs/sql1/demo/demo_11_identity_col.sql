--Execute using teach_a user

CREATE TABLE t1 (c1 NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY, c2 VARCHAR2(10));
INSERT INTO t1 (c1,c2) VALUES (NULL,'john');
INSERT INTO t1(c2) VALUES ('mark');

SELECT * FROM t1;
