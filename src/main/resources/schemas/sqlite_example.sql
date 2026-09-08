-- The same tables as schemas/calcite.sql, written the way sqlite3 .schema writes them.
--   mvn exec:exec -Dschema=schemas/sqlite_example.sql -Ddialect=sqlite ...
--
-- What this file is here to show: SQLite keeps the case you wrote and compares names
-- ignoring it; its type names are its own, and are read for what they mean -- TEXT is a
-- string, INTEGER PRIMARY KEY AUTOINCREMENT is an integer key; and it will accept any of
-- three quoting styles in the same file, "like this", `like this` and [like this], which
-- the reader takes in stride even though a query has to settle on one (double quotes).

CREATE TABLE dept (
    deptno  INTEGER PRIMARY KEY AUTOINCREMENT,
    "name"  TEXT
);

CREATE TABLE emp (
    empno    INTEGER PRIMARY KEY AUTOINCREMENT,
    ename    TEXT,
    job      TEXT,
    mgr      INTEGER REFERENCES emp (empno),
    hiredate INTEGER,
    comm     INTEGER,
    sal      INTEGER,
    deptno   INTEGER REFERENCES dept (deptno),
    slacker  INTEGER CHECK (slacker IN (0, 1))
);

CREATE TABLE bonus (
    ename TEXT NOT NULL,
    [job] TEXT NOT NULL,
    sal   INTEGER,
    comm  INTEGER
);

CREATE TABLE account (
    acctno  INTEGER NOT NULL,
    `type`  TEXT,
    balance TEXT,
    PRIMARY KEY (acctno)
);

CREATE TABLE t (
    k0    TEXT NOT NULL,
    c1    TEXT,
    f1_a0 INTEGER NOT NULL,
    f2_a0 INTEGER NOT NULL,
    f0_c0 INTEGER NOT NULL,
    f1_c0 INTEGER,
    f0_c1 INTEGER NOT NULL,
    f1_c2 INTEGER NOT NULL,
    f2_c3 INTEGER NOT NULL,
    PRIMARY KEY (k0)
) WITHOUT ROWID;

CREATE TABLE anon (
    c INTEGER
);

CREATE UNIQUE INDEX bonus_ename_idx ON bonus (ename);
