-- testPullNull

truncate table emp

insert into emp values
(10,'A', 'B', null,3,-3,4,7,-4);

-- q1
SELECT * 
FROM EMP AS EMP 
WHERE 
EMP.DEPTNO = 7 AND 
EMP.EMPNO = 10 AND 
EMP.MGR IS NULL AND
EMP.EMPNO = 10;
-- q2
SELECT 10 AS EMPNO, EMP0.ENAME, EMP0.JOB, CAST(NULL AS INT) AS MGR, EMP0.HIREDATE, EMP0.SAL, EMP0.COMM, 7 AS DEPTNO, EMP0.SLACKER 
FROM EMP AS EMP0 
WHERE 
EMP0.DEPTNO = 7 AND 
EMP0.MGR IS NULL AND 
EMP0.EMPNO = 10;

--The two queries are actually equivalent if we consider the column names. 
-- Sal and Comm are swapped. 