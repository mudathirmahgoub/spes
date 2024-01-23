-- testAddRedundantSemiJoinRule
CREATE TABLE IF NOT EXISTS dept
(
    deptno bigint,
    name character varying COLLATE pg_catalog."default"
)

CREATE TABLE IF NOT EXISTS emp
(
    empno bigint,
    ename character varying COLLATE pg_catalog."default",
    job character varying COLLATE pg_catalog."default",
    mgr bigint,
    hiredate bigint,
    comm bigint,
    sal bigint,
    deptno bigint,
    slacker bigint
)

-- table dept							 
insert into dept values
(0, ''),
(0, '');

-- table emp
insert into emp values
(0, '', '', 0, 0, 0, 0, 0, 0);

-- q1
SELECT 1 FROM EMP AS EMP INNER JOIN DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO;
-- q2
SELECT 1 FROM EMP AS EMP0 INNER JOIN DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO 
INNER JOIN DEPT AS DEPT1 ON EMP0.DEPTNO = DEPT1.DEPTNO;
