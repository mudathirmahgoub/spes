-- The default schema: Calcite's EMP/DEPT test tables.
--
-- These are the tables the project used to hold as one Java class each, and the column types
-- here are exactly what those classes declared -- including two oddities worth naming, since
-- a reader who knows Calcite's own test catalog will notice them: BONUS.ename is an integer
-- and BONUS.sal a string, and every column of T is NOT NULL. Both are kept so that results
-- from before schemas were configurable still reproduce. Pass -Dschema=<file> to use anything
-- else, and -Ddialect=<name> to write it in another accent.
--
-- PRIMARY KEY here says only "these columns are unique", which is what the old classes each
-- claimed of their first column; it is not read as implying NOT NULL, so a column stays
-- nullable unless the DDL says otherwise.

CREATE TABLE emp (
    empno    integer PRIMARY KEY,
    ename    varchar,
    job      varchar,
    mgr      integer,
    hiredate integer,
    comm     integer,
    sal      integer,
    deptno   integer,
    slacker  integer
);

CREATE TABLE dept (
    deptno integer PRIMARY KEY,
    name   varchar
);

CREATE TABLE bonus (
    ename integer PRIMARY KEY,
    job   varchar,
    sal   varchar,
    comm  varchar
);

CREATE TABLE account (
    acctno  integer PRIMARY KEY,
    type    varchar,
    balance varchar
);

CREATE TABLE t (
    k0    varchar NOT NULL PRIMARY KEY,
    c1    varchar NOT NULL,
    f1_a0 integer NOT NULL,
    f2_a0 integer NOT NULL,
    f0_c0 integer NOT NULL,
    f1_c0 integer NOT NULL,
    f0_c1 integer NOT NULL,
    f1_c2 integer NOT NULL,
    f2_c3 integer NOT NULL
);

CREATE TABLE anon (
    c integer PRIMARY KEY
);
