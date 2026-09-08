-- The same tables as schemas/calcite.sql, written the way pg_dump writes them.
--   mvn exec:exec -Dschema=schemas/postgres_example.sql -Ddialect=postgres ...
--
-- What this file is here to show: unquoted names fold to lower case under the postgres
-- accent, so the queries that find EMP under the default accent find emp under this one;
-- `character varying` and `public.` qualification are read; and everything a dump puts
-- between the tables -- SET, CREATE SEQUENCE, ALTER SEQUENCE, GRANT -- is skipped, while
-- ALTER TABLE ... ADD CONSTRAINT ... PRIMARY KEY is not, because that is where a dump keeps
-- its keys.
--
-- Unlike the built-in schema this one declares NOT NULL where a real database would, so a
-- query whose answer turns on whether a column can be null may be decided differently here.

SET statement_timeout = 0;
SET search_path = public, pg_catalog;

CREATE TABLE public.dept (
    deptno integer NOT NULL,
    name   character varying(10)
);

CREATE TABLE public.emp (
    empno    integer NOT NULL,
    ename    character varying(20),
    job      character varying(10),
    mgr      integer,
    hiredate integer,
    comm     integer,
    sal      integer,
    deptno   integer,
    slacker  boolean
);

CREATE SEQUENCE public.emp_empno_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.emp_empno_seq OWNED BY public.emp.empno;

CREATE TABLE public.bonus (
    ename character varying(20),
    job   character varying(10),
    sal   integer,
    comm  integer
);

CREATE TABLE public.account (
    acctno  integer NOT NULL,
    type    character varying,
    balance character varying
);

CREATE TABLE public.t (
    k0    character varying(20) COLLATE pg_catalog."default" NOT NULL,
    c1    character varying(20) COLLATE pg_catalog."default",
    f1_a0 integer NOT NULL,
    f2_a0 integer NOT NULL,
    f0_c0 integer NOT NULL,
    f1_c0 integer,
    f0_c1 integer NOT NULL,
    f1_c2 integer NOT NULL,
    f2_c3 integer NOT NULL
);

CREATE TABLE public.anon (
    c integer
);

ALTER TABLE ONLY public.dept ADD CONSTRAINT dept_pkey PRIMARY KEY (deptno);
ALTER TABLE ONLY public.emp ADD CONSTRAINT emp_pkey PRIMARY KEY (empno);
ALTER TABLE ONLY public.account ADD CONSTRAINT account_pkey PRIMARY KEY (acctno);
ALTER TABLE ONLY public.t ADD CONSTRAINT t_pkey PRIMARY KEY (k0);

ALTER TABLE ONLY public.emp
    ADD CONSTRAINT emp_deptno_fkey FOREIGN KEY (deptno) REFERENCES public.dept(deptno);

CREATE INDEX emp_deptno_idx ON public.emp USING btree (deptno);

GRANT SELECT ON TABLE public.emp TO PUBLIC;
