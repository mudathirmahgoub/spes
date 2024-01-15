CREATE TABLE IF NOT EXISTS public.dept
(
    deptno bigint,
    name character varying COLLATE pg_catalog."default"
)

CREATE TABLE IF NOT EXISTS public.emp
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
insert into dept 
values
(0, ''),
(0, '')

-- table emp
insert into emp
values
(0, '', '', 0, 0, 0, 0, 0, 0)

-- q1
SELECT 1 FROM public.EMP AS EMP INNER JOIN public.DEPT AS DEPT ON EMP.DEPTNO = DEPT.DEPTNO
-- q2
SELECT 1 FROM public.EMP AS EMP0 INNER JOIN public.DEPT AS DEPT0 ON EMP0.DEPTNO = DEPT0.DEPTNO 
INNER JOIN public.DEPT AS DEPT1 ON EMP0.DEPTNO = DEPT1.DEPTNO
