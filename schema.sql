CREATE TABLE IF NOT EXISTS public.dept
(
    deptno bigint,
    name character varying COLLATE pg_catalog."default"
);


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
);

CREATE TABLE IF NOT EXISTS public.t
(
    k0 character varying(20) COLLATE pg_catalog."default" NOT NULL,
    c1 character varying(20) COLLATE pg_catalog."default",
    f1_a0 integer NOT NULL,
    f2_a0 integer NOT NULL,
    f0_c0 integer NOT NULL,
    f1_c0 integer,
    f0_c1 integer NOT NULL,
    f1_c2 integer NOT NULL,
    f2_c3 integer NOT NULL
);

CREATE TABLE IF NOT EXISTS public.anon
(
    c integer
);
CREATE TABLE IF NOT EXISTS public.account
(
    acctno bigint,
    type character varying COLLATE pg_catalog."default",
    balance character varying COLLATE pg_catalog."default"
);