--In order not to create the following tables in the void or in
--already existing 'master' database, we will create new database.
--https://youtu.be/MiuMZkoRtAw
CREATE DATABASE EMP_DEPT;
CREATE DATABASE EMP_DEPT_SALGRADE;
/*The command oposite to creating the database is dropping whole database.
  It deletes everything, meaning the database with all tables it contains.
  --https://youtu.be/MiuMZkoRtAw
*/
DROP DATABASE EMP_DEPT;
/*After I've tried to drop EMP_DEPT database I've got the:
  "Cannot drop database "EMP_DEPT" because it is currently in use." error.
  While EMP_DEPT database is in use, more than one user may be connected.
  We need to see WHO is connected to the database.
*/

EXEC SP_WHO       --ORDER BY 'dbname';

/*Later it's necessary to disconnect all connections on sql server database.
  It's done by right mouse click on database --> choose properties at the bottom -->
  chose options menu and scroll to the very bottom of it.
  In 'STATE' section, choose 'RESTRICT ACCESS' and then change
  'MULTI_USER' to 'SINGLE_USER'.
  Then the connections will be broken and database could be easilly dropped'.
  https://youtu.be/UZjrdXZ8G0E
*/

USE master;
USE NORTHWND;
ALTER DATABASE EMP_DEPT 
SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
DROP DATABASE EMP_DEPT;
--It is a good practice to select select this single statement and run it.
--After it's run I can see, that the active database remained 'master'.
--After it's run I can see, that the active database field changed into EMP_DEPT.

USE EMP_DEPT;
USE NORTHWND;
USE master;

--To perform any action using particular database, first I must use that database.
--    https://youtu.be/MiuMZkoRtAw
--    https://youtu.be/MiuMZkoRtAw   
--If I suspect there already is an object/table called 'EMP' or 'DEPT' in my database,
--I need to drop these existing objects/tables before I create another tables with the same
--name but different contents.         :-)        */


--Delete the table and all of it's contents ***
DROP TABLE EMP;
--Delete the table and all of it's contents
DROP TABLE DEPT;
--Delete the table and all of it's contents
DROP TABLE SALGRADE;

DROP TABLE IF EXISTS EMP;
DROP TABLE IF EXISTS DEPT;
DROP TABLE IF EXISTS SALGRADE;
DROP TABLE IF EXISTS SYSDIAGRAMS;
DROP TABLE IF EXISTS SALES$;
--https://youtu.be/5G4_SbkeRuU

/* This code will create an unfriendly name for 'dbo.EMP primary key.
CREATE TABLE EMP
       (EMPNO INT PRIMARY KEY,       --Nie trzeba dodawaæ 'NOT NULL' je¿eli wczeœniej oznaczyliœmy kolumnê jako PRIMARY KEY.
        ENAME VARCHAR(18) NOT NULL,  --Fakt istnienia constrainta 'NOT NULL' wynika wprost z oznaczenia kolumny jako PRIMARY KEY.
		SEX CHAR(1),
        JOB VARCHAR(18),
        --MGR INT NOT NULL REFERENCES EMP(EMPNO),                     --  REFERENCES CITIZEN,
		--MGR INT NOT NULL FOREIGN KEY REFERENCES EMP(EMPNO),         --  REFERENCES CITIZEN,
		MGR INT,													      --  NOT NULL,
        HIREDATE DATETIME,
        SAL INT,
        COMM INT,
        DEPTNO INT);
*/
CREATE TABLE EMP
       (EMPNO INT NOT NULL,       --Nie trzeba dodawaæ 'NOT NULL' je¿eli wczeœniej oznaczyliœmy kolumnê jako PRIMARY KEY.
        ENAME VARCHAR(18) NOT NULL,  --Fakt istnienia constrainta 'NOT NULL' wynika wprost z oznaczenia kolumny jako PRIMARY KEY.
		SEX CHAR(1),
        JOB VARCHAR(18),
        --MGR INT NOT NULL REFERENCES EMP(EMPNO),                        --  REFERENCES CITIZEN,
		--MGR INT NOT NULL FOREIGN KEY REFERENCES EMP(EMPNO),            --  REFERENCES CITIZEN,
		MGR INT,													     --  NOT NULL,
        HIREDATE DATETIME,
        SAL INT,
        COMM INT,
        DEPTNO INT,

		CONSTRAINT PK_EMP_EMPNO PRIMARY KEY (EMPNO)
		);

--https://youtu.be/uFGlAb3G6ew		
/* When a value other than NULL is entered into the column of a FOREIGN KEY constraint, the value must exist in the referenced column.
   Otherwise, a foreign key violation error message is returned. 
   To make sure that all values of a composite foreign key constraint are verified, specify NOT NULL on all the participating columns.
*/

INSERT INTO EMP VALUES 
		(7047, 'RENO',     'M', 'SRUNDERTAKER',     7839,
		CONVERT(DATETIME,'11-MAY-1988'),  0,   2499,  50);
INSERT INTO EMP VALUES
		(7013, 'PORTMAN',  'F', 'JRUNDERTAKER',     7047,
		CONVERT(DATETIME,'14-SEP-1994'),  0,   1249,  50);
INSERT INTO EMP VALUES
		(7059,  'GECKO',   'M',  'ANALYST',         7566,
		CONVERT(DATETIME,'22-MAY-1982'),  3699, NULL, 20);
INSERT INTO EMP VALUES
		(7023, 'JOHANSON', 'F', 'ASSISTANT',        7839,
		CONVERT(DATETIME,'05-JAN-1981'),  1149, 999,  10);
INSERT INTO EMP VALUES
        (7369, 'SMITH',    'M', 'CLERK',		    7902,
        CONVERT(DATETIME,'17-DEC-1980'),  800, NULL,  20);
INSERT INTO EMP VALUES
		(7370, 'KOWALSKA', 'F', 'ACCOUNTANT',       7782,
		CONVERT(DATETIME,'11-FEB-1983'), 2899, NULL,  10);
INSERT INTO EMP VALUES
        (7499, 'ALLEN',    'M', 'SALESMAN',	      7698,
        CONVERT(DATETIME,'20-FEB-1981'), 1600,  300,  30);
INSERT INTO EMP VALUES 
        (7521, 'WARD',     'F', 'SALESMAN',	      7698,
        CONVERT(DATETIME,'22-FEB-1981'), 1250,  500,   30);
INSERT INTO EMP VALUES
		(7503, 'BROOKS',   'M', 'SALESMAN',       7698,
		CONVERT(DATETIME,'14-MAY-1986'), 1999,  1849,  30);
INSERT INTO EMP VALUES
        (7504, 'BUTLER',   'M', 'SALESMAN',       7698,
		CONVERT(DATETIME, '07-JUL-1983'), 2390,  1750, 30);
INSERT INTO EMP VALUES
		(7505, 'THOMASON', 'F', 'SALESMAN',       7698,
		CONVERT(DATETIME, '29-NOV-1985'), 1649,  1099, 30); 
INSERT INTO EMP VALUES
		(7506, 'DAMON',   'M',  'SALESMAN',       7698,
		CONVERT(DATETIME, '01-MAR-1979'),  2729, 2079, 30);
INSERT INTO EMP VALUES
        (7566, 'JONES',    'M', 'MANAGER',		  7839,
        CONVERT(DATETIME,'02-APR-1981'),  2975, NULL,  20);
INSERT INTO EMP VALUES
		(7569, 'VIKANDER', 'F', 'ASSISTANT',      7566,
		CONVERT(DATETIME,'03-APR-1981'),  2975,  599,  20);
INSERT INTO EMP VALUES
        (7654, 'MARTIN',   'M', 'SALESMAN',	      7698,
        CONVERT(DATETIME,'28-SEP-1981'),  1250, 1400,  30);
INSERT INTO EMP VALUES
        (7698, 'BLAKE',    'M', 'MANAGER',		  7839,
        CONVERT(DATETIME,'01-MAY-1981'),   2850, NULL, 30);
INSERT INTO EMP VALUES
        (7782, 'CLARK',    'M', 'MANAGER',		  7839,
        CONVERT(DATETIME,'09-JUN-1981'),   2450, NULL, 10);
INSERT INTO EMP VALUES
        (7788, 'SCOTT',    'F', 'ANALYST',		  7566,
        CONVERT(DATETIME,'09-DEC-1982'),  3000, NULL, 20);
INSERT INTO EMP VALUES
        (7839, 'KING',     'F', 'PRESIDENT',	   NULL,
        CONVERT(DATETIME,'17-NOV-1981'),  8099, NULL, 10);
INSERT INTO EMP VALUES
        (7844, 'TURNER',   'M', 'SALESMAN',	     7698,
        CONVERT(DATETIME,'08-SEP-1981'),   1500,    0, 30);
INSERT INTO EMP VALUES
		(7846, 'FARMER',   'M', 'BODYGUARD',       7839,
		CONVERT(DATETIME,'23-NOV-1984'),  6500, NULL,  10);
INSERT INTO EMP VALUES
		(7850, 'HATHAWAY', 'M', 'CYBERSECURITY',  7839,
		CONVERT(DATETIME, '04-APR-1980'), 7000, 999,   21);
INSERT INTO EMP VALUES
		(7022, 'HATHAWAY', 'F', 'ASSISTANT',      7698,
		CONVERT(DATETIME, '01-AUG-1981'), 1479,  529,  30);
INSERT INTO EMP VALUES
        (7876, 'ADAMS',    'M', 'CLERK',		  7788,
        CONVERT(DATETIME,'12-JAN-1983'),  1100, NULL,  20);
INSERT INTO EMP VALUES
		(7880, 'WEITANG',  'F', 'NETENGINEER',    7850,
		CONVERT(DATETIME,'30-SEP-1983'),  3799, 1249,  21);
INSERT INTO EMP VALUES
        (7900, 'JAMES',    'F', 'CLERK',		  7698,
        CONVERT(DATETIME,'03-DEC-1981'),   950, NULL, 30);
INSERT INTO EMP VALUES
        (7902, 'FORD',     'M', 'ANALYST',	     7566,
        CONVERT(DATETIME,'03-DEC-1981'),   3000, NULL, 20);
INSERT INTO EMP VALUES
        (7934, 'MILLER',   'F', 'CLERK',		  7782,
        CONVERT(DATETIME,'23-JAN-1982'),   1300, NULL, 10);
INSERT INTO EMP VALUES
		(9901, 'KOWALSKI', 'M', 'SALESMAN',	     7698,
		CONVERT(DATETIME, '23-JAN-1990'),  1270,  930, 30);
INSERT INTO EMP VALUES
		(7899, 'MCQUEEN',  'M', 'DRIVER',        7839,
		CONVERT(DATETIME, '01-JUL-1982'),  NULL, 2199, 10);
INSERT INTO EMP VALUES
		(7948, 'REDFORD',  'M', 'JOURNALIST',    7839,
		CONVERT(DATETIME, '09-MAR-1989'),  7450, 1599, 60);
INSERT INTO EMP VALUES
		(7840, 'BELFORT',  'M',  'SALESMAN',     7698,
		CONVERT(DATETIME, '10-OCT-1986'),  3479, 2319, 30);
INSERT INTO EMP VALUES
		(7848, 'LENKIEWICZ','M', 'COACH',        7839,
		CONVERT(datetime, '09-SEP-1990'),  3250, 1289, 21);
INSERT INTO EMP VALUES
		(7851, 'ARONOVSKY', 'M', 'DATASCIENTIST', NULL,
		CONVERT(datetime, '13-APR-1978'),  6666, 3913, 21);



/*    This code will create an unfriendly name for 'dbo.EMP primary key.
CREATE TABLE DEPT
       (DEPTNO INT PRIMARY KEY,
        DNAME VARCHAR(18) NOT NULL,
        LOC VARCHAR(18) );
*/

CREATE TABLE DEPT
       (DEPTNO INT NOT NULL,
        DNAME VARCHAR(18) NOT NULL,
        LOC VARCHAR(18),

		CONSTRAINT PK_DEPT_DEPTNO PRIMARY KEY (DEPTNO)
		);

--https://youtu.be/uFGlAb3G6ew

INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH',   'DALLAS');
INSERT INTO DEPT VALUES (21, 'IT',         'KUALA LUMPUR');
INSERT INTO DEPT VALUES (30, 'SALES',      'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');
INSERT INTO DEPT VALUES (50, 'COLLECTION', 'DELOCALIZED');
INSERT INTO DEPT VALUES (60, 'PUBLICRELATIONS', 'NEW YORK');

--https://youtu.be/uFGlAb3G6ew

/*   This code will create an unfriendly name for 'dbo.EMP primary key.
CREATE TABLE SALGRADE
        (GRADE INT PRIMARY KEY,
         LOSAL INT NOT NULL,
         HISAL INT NOT NULL);
*/

CREATE TABLE SALGRADE
        (GRADE INT NOT NULL,
         LOSAL INT NOT NULL,
         HISAL INT NOT NULL,
		 
		 CONSTRAINT PK_SALGRADE_GRADE PRIMARY KEY (GRADE)
		 );

INSERT INTO SALGRADE VALUES (1,  700, 2000);
INSERT INTO SALGRADE VALUES (2, 2001, 4000);
INSERT INTO SALGRADE VALUES (3, 4001, 6000);
INSERT INTO SALGRADE VALUES (4, 6001, 8000);
INSERT INTO SALGRADE VALUES (5, 8001, 10000);
INSERT INTO SALGRADE VALUES (6, 10001, 13000);
INSERT INTO SALGRADE VALUES (7, 13001, 16000);
INSERT INTO SALGRADE VALUES (8, 16001, 20000);







/* Add Foreign Key Constraint on Existing EMP Table    */
ALTER TABLE DBO.EMP
ADD CONSTRAINT Fk_sourceEMP_destEMP_columnMGR
FOREIGN KEY(MGR) REFERENCES DBO.EMP(EMPNO);

ALTER TABLE DBO.EMP
ADD CONSTRAINT Fk_sourceDEPT_destEMP_columnDEPTNO
FOREIGN KEY(DEPTNO) REFERENCES DBO.DEPT(DEPTNO);

/*ALTER TABLE EMP
ADD CONSTRAINT Fk_sourceDEPT_destEMP_columnDEPTNO
FOREIGN KEY(DEPTNO) REFERENCES DBO.DEPT(DEPTNO);    */

/* Add Foreign Key Constraint on Existing EMP Table    
ALTER TABLE DBO.DEPT                  */


CREATE TABLE SALES
	(SALESLINEID	INT NOT NULL,
	 EMPNO			INT NOT NULL,
	 CTGRY			VARCHAR(50) NOT NULL,
	 ITEMDESCR		VARCHAR(90),
	 SELLPRC		DECIMAL(18, 2),

	 CONSTRAINT PK_SALES_SALESLINEID PRIMARY KEY (SALESLINEID)
	 );


 
INSERT INTO SALES  VALUES (1, 7840, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (2, 7844, 'computers', 'noname ram memory', CAST(150.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (3, 7844, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (4, 7844, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (5, 7505, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (6, 7844, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (7, 7654, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (8, 7503, 'tools', 'hitachi drill d13vg', CAST(329.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (9, 7503, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (10, 7499, 'computers', 'very fast amd cpu', CAST(1999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (11, 7840, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (12, 7504, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (13, 7504, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (14, 7504, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (15, 7505, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (16, 7840, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (17, 7506, 'computers', 'very fast amd cpu', CAST(1999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (18, 7840, 'computers', 'asus threadripper mainboards', CAST(480.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (19, 7840, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (20, 7840, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (21, 7503, 'computers', 'ncase m1 computer chasis ', CAST(338.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (22, 7503, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (23, 7506, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (24, 7504, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (25, 7840, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (26, 7499, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (27, 7844, 'computers', 'sound blasters', CAST(84.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (28, 7840, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (29, 7499, 'electronics', 'samsung galaxy supertab 10''', CAST(799.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (30, 7840, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (31, 7840, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (32, 7521, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (33, 7840, 'mobile', 'google pixel 4', CAST(529.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (34, 7503, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (35, 7654, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (36, 7521, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (37, 9901, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (38, 7499, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (39, 7840, 'computers', 'gigabyte b550m aorus elite', CAST(119.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (40, 7521, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (41, 7840, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (42, 7504, 'computers', 'asus threadripper mainboards', CAST(480.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (43, 9901, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (44, 7504, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (45, 7499, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (46, 7840, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (47, 7504, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (48, 7506, 'supplies', 'pro duct tape 70m', CAST(33.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (49, 7840, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (50, 7504, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (51, 7844, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (52, 7521, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (53, 7499, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (54, 7840, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (55, 7654, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (56, 7654, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (57, 7521, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (58, 7844, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (59, 7506, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (60, 7499, 'electronics', 'samsung galaxy tab 7''', CAST(541.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (61, 7840, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (62, 7499, 'electronics', 'samsung galaxy tab 7''', CAST(541.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (63, 7840, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (64, 7840, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (65, 9901, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (66, 7840, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (67, 7503, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (68, 7840, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (69, 7505, 'electronics', 'fire android tablet', CAST(419.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (70, 7521, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (71, 9901, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (72, 7654, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (73, 7840, 'computers', 'samsung led display 43''', CAST(750.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (74, 7840, 'tools', 'ifixit mako 64 diver kit', CAST(60.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (75, 7844, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (76, 7844, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (77, 7506, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (78, 7503, 'computers', 'lian li o11 dynamic black case', CAST(179.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (79, 7654, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (80, 7840, 'supplies', 'dark chocolate 200g', CAST(14.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (81, 7840, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (82, 7844, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (83, 7844, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (84, 7505, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (85, 7499, 'computers', 'seasonic powesupply 850v', CAST(309.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (86, 7840, 'supplies', 'dark chocolate 200g', CAST(14.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (87, 9901, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (88, 7654, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (89, 7504, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (90, 7505, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (91, 9901, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (92, 7503, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (93, 7521, 'supplies', 'pro duct tape 70m', CAST(33.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (94, 7505, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (95, 7840, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (96, 7504, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (97, 7844, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (98, 7521, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (99, 7840, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (100, 7505, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (101, 7844, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (102, 7521, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (103, 7505, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (104, 7654, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (105, 7844, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (106, 7521, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (107, 7840, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (108, 7840, 'computers', 'samsung ram memory', CAST(219.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (109, 7844, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (110, 7504, 'computers', 'gigabyte b550m aorus elite', CAST(119.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (111, 9901, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (112, 7521, 'supplies', 'pro duct tape 70m', CAST(33.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (113, 7505, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (114, 7840, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (115, 7521, 'mobile', 'google pixel 4', CAST(529.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (116, 7840, 'mobile', 'google pixel 4', CAST(529.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (117, 7844, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (118, 9901, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (119, 7840, 'electronics', 'fire android tablet', CAST(419.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (120, 9901, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (121, 7654, 'supplies', 'pro duct tape 70m', CAST(33.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (122, 7840, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (123, 7504, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (124, 7654, 'computers', 'ncase m1 computer chasis ', CAST(338.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (125, 7844, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (126, 7840, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (127, 7654, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (128, 7840, 'computers', 'normal speed intel cpu', CAST(889.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (129, 7503, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (130, 7654, 'computers', 'fractal design vector rs comp case', CAST(217.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (131, 7499, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (132, 7505, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (133, 7504, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (134, 7521, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (135, 7840, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (136, 7503, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (137, 7503, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (138, 7840, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (139, 7521, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (140, 7504, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (141, 7499, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (142, 7840, 'tools', 'milwaukee ph30 hammer drill', CAST(229.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (143, 7505, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (144, 7840, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (145, 7505, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (146, 7521, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (147, 7499, 'computers', 'very fast amd cpu', CAST(1999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (148, 7503, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (149, 7844, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (150, 7654, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (151, 7503, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (152, 7521, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (153, 7499, 'electronics', 'samsung galaxy supertab 10''', CAST(799.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (154, 7840, 'computers', 'sunflower power supply 1000v', CAST(289.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (155, 7505, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (156, 7506, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (157, 7499, 'electronics', 'samsung galaxy supertab 10''', CAST(799.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (158, 7505, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (159, 9901, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (160, 7521, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (161, 7521, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (162, 7521, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (163, 7505, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (164, 7504, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (165, 7521, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (166, 7844, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (167, 7506, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (168, 7506, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (169, 9901, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (170, 7521, 'computers', 'noname ram memory', CAST(150.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (171, 7840, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (172, 7840, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (173, 7840, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (174, 7503, 'electronics', 'amazon echo', CAST(134.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (175, 7499, 'mobile', 'google pixel 4', CAST(529.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (176, 7521, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (177, 7504, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (178, 7844, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (179, 9901, 'computers', 'samsung ram memory', CAST(219.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (180, 7840, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (181, 7504, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (182, 7844, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (183, 9901, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (184, 7505, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (185, 7521, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (186, 7840, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (187, 7840, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (188, 9901, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (189, 7503, 'computers', 'noname ram memory', CAST(150.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (190, 7504, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (191, 7499, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (192, 7654, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (193, 7504, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (194, 7521, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (195, 7499, 'computers', 'fast intel cpu', CAST(1549.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (196, 7504, 'computers', 'noname ram memory', CAST(150.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (197, 7503, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (198, 7503, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (199, 7505, 'computers', 'ncase m1 computer chasis ', CAST(338.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (200, 7654, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (201, 7840, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (202, 7844, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (203, 7504, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (204, 7844, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (205, 7503, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (206, 7504, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (207, 7505, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (208, 7504, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (209, 7521, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (210, 7654, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (211, 7844, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (212, 7505, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (213, 7521, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (214, 7840, 'computers', 'lian li o11 dynamic black case', CAST(179.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (215, 7505, 'tools', 'hitachi drill d13vg', CAST(329.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (216, 7521, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (217, 7840, 'tools', 'hitachi drill d13vg', CAST(329.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (218, 7503, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (219, 7840, 'electronics', 'alexa voice remote', CAST(129.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (220, 7521, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (221, 7505, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (222, 7840, 'computers', 'sound blasters', CAST(84.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (223, 7505, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (224, 7840, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (225, 7840, 'computers', 'fractal design vector rs comp case', CAST(217.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (226, 9901, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (227, 7499, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (228, 7503, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (229, 7499, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (230, 9901, 'computers', 'sunflower power supply 1000v', CAST(289.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (231, 9901, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (232, 7654, 'computers', 'seasonic powesupply 850v', CAST(309.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (233, 7521, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (234, 7504, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (235, 7503, 'electronics', 'amazon echo', CAST(134.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (236, 7499, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (237, 7521, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (238, 7504, 'computers', 'sound blasters', CAST(84.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (239, 9901, 'computers', 'very fast amd cpu', CAST(1999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (240, 7654, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (241, 7521, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (242, 7840, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (243, 7504, 'tools', 'hitachi drill d13vg', CAST(329.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (244, 7844, 'computers', 'lian li o11 dynamic black case', CAST(179.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (245, 7654, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (246, 7504, 'computers', 'ncase m1 computer chasis ', CAST(338.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (247, 7840, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (248, 7499, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (249, 7844, 'electronics', 'fire android tablet', CAST(419.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (250, 7504, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (251, 7505, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (252, 7844, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (253, 7503, 'computers', 'normal speed intel cpu', CAST(889.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (254, 7840, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (255, 7654, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (256, 7505, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (257, 7844, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (258, 7499, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (259, 7840, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (260, 7504, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (261, 7505, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (262, 7503, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (263, 7503, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (264, 7505, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (265, 7654, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (266, 7499, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (267, 9901, 'computers', 'seasonic powesupply 850v', CAST(309.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (268, 7521, 'computers', 'ncase m1 computer chasis ', CAST(338.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (269, 7840, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (270, 7503, 'computers', 'sunflower power supply 1000v', CAST(289.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (271, 7654, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (272, 7505, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (273, 7504, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (274, 7844, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (275, 7840, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (276, 7504, 'computers', 'lian li o11 dynamic black case', CAST(179.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (277, 7840, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (278, 7503, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (279, 7654, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (280, 7840, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (281, 7504, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (282, 7840, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (283, 7840, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (284, 7521, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (285, 7844, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (286, 7503, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (287, 7840, 'computers', 'lian li o11 dynamic black case', CAST(179.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (288, 7504, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (289, 7499, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (290, 7504, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (291, 7844, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (292, 7504, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (293, 7504, 'computers', 'fractal design vector rs comp case', CAST(217.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (294, 7840, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (295, 7840, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (296, 7840, 'computers', 'noname ram memory', CAST(150.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (297, 7503, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (298, 7499, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (299, 7503, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (300, 7521, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (301, 7499, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (302, 7521, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (303, 7844, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (304, 7499, 'computers', 'fast intel cpu', CAST(1549.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (305, 7504, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (306, 9901, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (307, 7840, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (308, 7654, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (309, 7521, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (310, 7499, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (311, 7844, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (312, 7840, 'tools', 'ifixit mako 64 diver kit', CAST(60.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (313, 9901, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (314, 7504, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (315, 9901, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (316, 7840, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (317, 7503, 'electronics', 'alexa voice remote', CAST(129.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (318, 7499, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (319, 7499, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (320, 7499, 'electronics', 'samsung galaxy tab 7''', CAST(541.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (321, 7844, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (322, 7840, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (323, 7654, 'tools', 'hitachi drill d13vg', CAST(329.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (324, 7505, 'tools', 'ifixit mako 64 diver kit', CAST(60.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (325, 7505, 'computers', 'sunflower power supply 1000v', CAST(289.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (326, 7505, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (327, 7521, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (328, 7505, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (329, 7840, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (330, 7504, 'supplies', 'pro duct tape 70m', CAST(33.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (331, 7505, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (332, 7840, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (333, 7840, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (334, 7654, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (335, 7840, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (336, 7654, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (337, 7844, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (338, 7503, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (339, 7840, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (340, 7844, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (341, 7654, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (342, 7504, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (343, 7504, 'computers', 'asus threadripper mainboards', CAST(480.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (344, 9901, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (345, 7840, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (346, 7505, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (347, 7506, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (348, 7505, 'computers', 'sound blasters', CAST(84.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (349, 7844, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (350, 7654, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (351, 7840, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (352, 7844, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (353, 7503, 'computers', 'very fast intel cpu', CAST(2699.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (354, 7503, 'computers', 'seasonic powesupply 850v', CAST(309.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (355, 7844, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (356, 7504, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (357, 7840, 'supplies', 'dark chocolate 200g', CAST(14.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (358, 7504, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (359, 7499, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (360, 7844, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (361, 7840, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (362, 7499, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (363, 7499, 'electronics', 'samsung galaxy supertab 10''', CAST(799.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (364, 7840, 'computers', 'fractal design vector rs comp case', CAST(217.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (365, 7521, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (366, 9901, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (367, 7521, 'tools', 'milwaukee ph30 hammer drill', CAST(229.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (368, 7840, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (369, 7521, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (370, 7505, 'computers', 'seasonic powesupply 850v', CAST(309.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (371, 7521, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (372, 7505, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (373, 7499, 'computers', 'very fast amd cpu', CAST(1999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (374, 9901, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (375, 7504, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (376, 7521, 'tools', 'hitachi drill d13vg', CAST(329.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (377, 7844, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (378, 7840, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (379, 7840, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (380, 7521, 'computers', 'noname ram memory', CAST(150.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (381, 7499, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (382, 7499, 'computers', 'fast intel cpu', CAST(1549.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (383, 7503, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (384, 7840, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (385, 7503, 'electronics', 'alexa voice remote', CAST(129.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (386, 7504, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (387, 7844, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (388, 9901, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (389, 7840, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (390, 7844, 'tools', 'milwaukee ph30 hammer drill', CAST(229.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (391, 7840, 'computers', 'asus threadripper mainboards', CAST(480.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (392, 7521, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (393, 7506, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (394, 7521, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (395, 7840, 'tools', 'ifixit mako 64 diver kit', CAST(60.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (396, 9901, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (397, 7503, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (398, 7505, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (399, 7521, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (400, 7499, 'electronics', 'samsung galaxy tab 7''', CAST(541.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (401, 7503, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (402, 7504, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (403, 7840, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (404, 7654, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (405, 7499, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (406, 7503, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (407, 9901, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (408, 7504, 'computers', 'samsung ram memory', CAST(219.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (409, 7840, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (410, 7840, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (411, 7504, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (412, 7840, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (413, 7840, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (414, 7844, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (415, 7654, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (416, 7503, 'computers', 'noname ram memory', CAST(150.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (417, 7504, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (418, 7844, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (419, 7844, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (420, 9901, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (421, 7499, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (422, 7840, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (423, 7504, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (424, 7504, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (425, 7505, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (426, 7505, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (427, 7654, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (428, 7505, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (429, 7844, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (430, 7499, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (431, 7840, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (432, 7840, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (433, 7840, 'tools', 'ifixit mako 64 diver kit', CAST(60.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (434, 7840, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (435, 7844, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (436, 7504, 'mobile', 'google pixel 4', CAST(529.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (437, 7844, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (438, 7654, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (439, 7505, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (440, 7840, 'computers', 'sunflower power supply 1000v', CAST(289.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (441, 7840, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (442, 7840, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (443, 7654, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (444, 7840, 'computers', 'seasonic powesupply 850v', CAST(309.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (445, 7505, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (446, 7840, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (447, 7840, 'computers', 'gigabyte b550m aorus elite', CAST(119.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (448, 7840, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (449, 9901, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (450, 7505, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (451, 7506, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (452, 7521, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (453, 7504, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (454, 7840, 'computers', 'sunflower power supply 1000v', CAST(289.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (455, 7504, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (456, 7654, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (457, 7654, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (458, 7654, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (459, 7844, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (460, 7840, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (461, 7840, 'computers', 'very fast amd cpu', CAST(1999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (462, 7654, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (463, 7505, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (464, 7499, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (465, 7503, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (466, 7521, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (467, 7505, 'computers', 'normal speed intel cpu', CAST(889.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (468, 7844, 'electronics', 'amazon echo', CAST(134.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (469, 7503, 'computers', 'very fast intel cpu', CAST(2699.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (470, 7521, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (471, 7499, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (472, 7840, 'tools', 'milwaukee ph30 hammer drill', CAST(229.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (473, 7840, 'supplies', 'dark chocolate 200g', CAST(14.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (474, 7844, 'tools', 'milwaukee ph30 hammer drill', CAST(229.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (475, 7521, 'tools', 'hitachi drill d13vg', CAST(329.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (476, 7504, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (477, 7499, 'electronics', 'samsung galaxy tab 7''', CAST(541.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (478, 7840, 'computers', 'sunflower power supply 1000v', CAST(289.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (479, 7521, 'tools', 'milwaukee ph30 hammer drill', CAST(229.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (480, 7844, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (481, 7840, 'electronics', 'amazon echo', CAST(134.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (482, 7654, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (483, 7521, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (484, 7504, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (485, 7840, 'computers', 'gigabyte b550m aorus elite', CAST(119.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (486, 7840, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (487, 7505, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (488, 7521, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (489, 7503, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (490, 7503, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (491, 7505, 'computers', 'samsung led display 43''', CAST(750.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (492, 7844, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (493, 9901, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (494, 7840, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (495, 7506, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (496, 7654, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (497, 7840, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (498, 7499, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (499, 7521, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (500, 7521, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (501, 7840, 'tools', 'ifixit mako 64 diver kit', CAST(60.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (502, 7504, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (503, 9901, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (504, 7505, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (505, 7505, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (506, 7654, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (507, 9901, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (508, 7504, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (509, 7521, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (510, 7506, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (511, 7503, 'computers', 'ncase m1 computer chasis ', CAST(338.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (512, 7840, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (513, 7521, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (514, 7505, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (515, 7506, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (516, 7654, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (517, 7504, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (518, 7499, 'computers', 'fast intel cpu', CAST(1549.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (519, 7844, 'computers', 'normal speed intel cpu', CAST(889.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (520, 7505, 'computers', 'samsung led display 43''', CAST(750.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (521, 7521, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (522, 7844, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (523, 7505, 'computers', 'fractal design vector rs comp case', CAST(217.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (524, 9901, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (525, 7840, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (526, 7521, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (527, 7503, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (528, 7499, 'computers', 'seasonic powesupply 850v', CAST(309.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (529, 7844, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (530, 7499, 'electronics', 'samsung galaxy tab 7''', CAST(541.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (531, 7654, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (532, 7503, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (533, 7503, 'computers', 'fast intel cpu', CAST(1549.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (534, 7503, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (535, 9901, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (536, 7504, 'computers', 'very fast amd cpu', CAST(1999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (537, 7499, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (538, 7840, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (539, 7654, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (540, 7505, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (541, 7506, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (542, 7840, 'computers', 'lian li o11 dynamic black case', CAST(179.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (543, 7521, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (544, 7840, 'computers', 'samsung led display 43''', CAST(750.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (545, 9901, 'computers', 'very fast amd cpu', CAST(1999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (546, 7504, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (547, 7504, 'computers', 'sound blasters', CAST(84.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (548, 7840, 'electronics', 'samsung galaxy tab 7''', CAST(541.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (549, 7499, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (550, 7840, 'computers', 'samsung led display 43''', CAST(750.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (551, 7840, 'electronics', 'samsung galaxy tab 7''', CAST(541.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (552, 7506, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (553, 7521, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (554, 7840, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (555, 7505, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (556, 7840, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (557, 7521, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (558, 7504, 'computers', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (559, 9901, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (560, 7506, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (561, 7840, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (562, 7503, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (563, 7840, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (564, 7840, 'computers', 'fractal design vector rs comp case', CAST(217.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (565, 7840, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (566, 7840, 'computers', 'ncase m1 computer chasis ', CAST(338.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (567, 7840, 'tools', 'hitachi drill d13vg', CAST(329.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (568, 7840, 'computers', 'fractal design vector rs comp case', CAST(217.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (569, 7840, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (570, 9901, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (571, 7840, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (572, 7521, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (573, 7844, 'electronics', 'alexa voice remote', CAST(129.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (574, 7844, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (575, 7844, 'computers', 'noname ram memory', CAST(150.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (576, 9901, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (577, 9901, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (578, 7503, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (579, 7504, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (580, 7499, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (581, 7499, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (582, 7503, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (583, 7840, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (584, 7840, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (585, 7499, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (586, 7503, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (587, 7499, 'computers', 'normal speed intel cpu', CAST(889.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (588, 7499, 'electronics', 'samsung galaxy supertab 10''', CAST(799.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (589, 7840, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (590, 7521, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (591, 7840, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (592, 7521, 'computers', 'sunflower power supply 1000v', CAST(289.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (593, 7504, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (594, 7499, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (595, 9901, 'computers', 'normal speed intel cpu', CAST(889.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (596, 7503, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (597, 7503, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (598, 7504, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (599, 9901, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (600, 7503, 'computers', 'ncase m1 computer chasis ', CAST(338.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (601, 7840, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (602, 9901, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (603, 7840, 'mobile', 'google pixel 4', CAST(529.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (604, 7840, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (605, 7840, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (606, 7840, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (607, 7506, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (608, 7654, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (609, 7840, 'electronics', 'fire android tablet', CAST(419.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (610, 7654, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (611, 7840, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (612, 9901, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (613, 7840, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (614, 7840, 'computers', 'normal speed intel cpu', CAST(889.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (615, 7844, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (616, 7840, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (617, 7840, 'electronics', 'fire android tablet', CAST(419.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (618, 7505, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (619, 7504, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (620, 7505, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (621, 7844, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (622, 7654, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (623, 7505, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (624, 7521, 'computers', 'ncase m1 computer chasis ', CAST(338.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (625, 7521, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (626, 7521, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (627, 7505, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (628, 7840, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (629, 7503, 'electronics', 'fire android tablet', CAST(419.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (630, 7840, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (631, 7844, 'electronics', 'alexa voice remote', CAST(129.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (632, 7844, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (633, 7504, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (634, 7499, 'electronics', 'samsung galaxy supertab 10''', CAST(799.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (635, 7521, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (636, 7503, 'computers', 'very fast intel cpu', CAST(2699.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (637, 7521, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (638, 7521, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (639, 7840, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (640, 7504, 'computers', 'sound blasters', CAST(84.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (641, 7521, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (642, 7840, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (643, 9901, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (644, 7505, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (645, 7499, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (646, 7840, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (647, 7840, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (648, 7840, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (649, 7521, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (650, 7503, 'computers', 'very fast intel cpu', CAST(2699.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (651, 9901, 'computers', 'samsung ram memory', CAST(219.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (652, 7840, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (653, 7506, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (654, 7521, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (655, 7654, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (656, 9901, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (657, 7505, 'supplies', 'pro duct tape 70m', CAST(33.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (658, 7503, 'electronics', 'amazon echo', CAST(134.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (659, 7505, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (660, 7844, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (661, 7521, 'mobile', 'google pixel 4', CAST(529.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (662, 9901, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (663, 7505, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (664, 9901, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (665, 7844, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (666, 7521, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (667, 7521, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (668, 7505, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (669, 7521, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (670, 9901, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (671, 7503, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (672, 7521, 'tools', 'hitachi drill d13vg', CAST(329.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (673, 7840, 'supplies', 'dark chocolate 200g', CAST(14.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (674, 7505, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (675, 7499, 'computers', 'gigabyte b550m aorus elite', CAST(119.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (676, 7503, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (677, 7521, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (678, 7840, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (679, 7504, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (680, 7654, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (681, 7840, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (682, 7840, 'computers', 'fractal design vector rs comp case', CAST(217.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (683, 7654, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (684, 9901, 'supplies', 'pro duct tape 70m', CAST(33.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (685, 7503, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (686, 7503, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (687, 9901, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (688, 7840, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (689, 7505, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (690, 7521, 'computers', 'very fast amd cpu', CAST(1999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (691, 7521, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (692, 7521, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (693, 7840, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (694, 7499, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (695, 7840, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (696, 7499, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (697, 7503, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (698, 7840, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (699, 7499, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (700, 7499, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (701, 7521, 'computers', 'normal speed intel cpu', CAST(889.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (702, 7840, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (703, 7506, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (704, 7654, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (705, 7840, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (706, 7503, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (707, 7506, 'computers', 'samsung ram memory', CAST(219.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (708, 7840, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (709, 7840, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (710, 7503, 'electronics', 'amazon echo', CAST(134.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (711, 7840, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (712, 7503, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (713, 7503, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (714, 7521, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (715, 7840, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (716, 7840, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (717, 7840, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (718, 7840, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (719, 7503, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (720, 9901, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (721, 7840, 'computers', 'sunflower power supply 1000v', CAST(289.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (722, 7503, 'tools', 'ifixit mako 64 diver kit', CAST(60.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (723, 7840, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (724, 7504, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (725, 7840, 'computers', 'asus threadripper mainboards', CAST(480.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (726, 7506, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (727, 7504, 'computers', 'fractal design vector rs comp case', CAST(217.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (728, 7654, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (729, 7654, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (730, 7840, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (731, 7840, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (732, 7521, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (733, 7840, 'supplies', 'dark chocolate 200g', CAST(14.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (734, 7654, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (735, 7840, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (736, 7506, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (737, 7840, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (738, 7521, 'computers', 'seasonic powesupply 850v', CAST(309.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (739, 7503, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (740, 7504, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (741, 7504, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (742, 7504, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (743, 9901, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (744, 7503, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (745, 7499, 'electronics', 'samsung galaxy supertab 10''', CAST(799.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (746, 7840, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (747, 7844, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (748, 7503, 'computers', 'very fast intel cpu', CAST(2699.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (749, 7840, 'supplies', 'dark chocolate 200g', CAST(14.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (750, 7844, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (751, 7506, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (752, 7521, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (753, 7654, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (754, 7844, 'computers', 'samsung ram memory', CAST(219.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (755, 7506, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (756, 7521, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (757, 7840, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (758, 7499, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (759, 7844, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (760, 7503, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (761, 7504, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (762, 7840, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (763, 7503, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (764, 7503, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (765, 7840, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (766, 7503, 'electronics', 'amazon echo', CAST(134.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (767, 7840, 'computers', 'sunflower power supply 1000v', CAST(289.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (768, 7840, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (769, 9901, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (770, 7654, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (771, 7499, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (772, 7840, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (773, 7521, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (774, 7840, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (775, 9901, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (776, 7840, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (777, 9901, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (778, 7503, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (779, 7840, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (780, 7504, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (781, 7840, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (782, 7499, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (783, 7840, 'tools', 'ifixit mako 64 diver kit', CAST(60.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (784, 7505, 'computers', 'ncase m1 computer chasis ', CAST(338.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (785, 7503, 'mobile', 'google pixel 4', CAST(529.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (786, 7840, 'electronics', 'alexa voice remote', CAST(129.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (787, 7505, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (788, 7521, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (789, 7504, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (790, 7505, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (791, 7506, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (792, 7840, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (793, 9901, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (794, 7504, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (795, 7521, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (796, 7505, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (797, 7521, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (798, 9901, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (799, 7844, 'tools', 'ifixit mako 64 diver kit', CAST(60.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (800, 7505, 'computers', 'gigabyte b550m aorus elite', CAST(119.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (801, 7505, 'supplies', 'stndrd phone battery', CAST(76.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (802, 9901, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (803, 7499, 'electronics', 'samsung galaxy supertab 10''', CAST(799.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (804, 9901, 'computers', 'noname ram memory', CAST(150.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (805, 7840, 'computers', 'very fast amd cpu', CAST(1999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (806, 7840, 'computers', 'lian li o11 dynamic black case', CAST(179.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (807, 7506, 'computers', 'aoc led display 34''', CAST(513.70 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (808, 7840, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (809, 7840, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (810, 7840, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (811, 7840, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (812, 7840, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (813, 7506, 'computers', 'samsung ram memory', CAST(219.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (814, 7844, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (815, 7844, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (816, 7844, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (817, 7499, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (818, 9901, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (819, 7506, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (820, 7505, 'computers', 'baracuda hard disk drive', CAST(180.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (821, 7504, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (822, 7503, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (823, 7840, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (824, 7499, 'electronics', 'aa batteries 16x set', CAST(23.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (825, 7840, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (826, 7840, 'supplies', 'dark chocolate 200g', CAST(14.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (827, 7840, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (828, 9901, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (829, 7840, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (830, 7503, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (831, 9901, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (832, 7504, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (833, 7654, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (834, 9901, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (835, 9901, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (836, 7840, 'computers', 'samsung ram memory', CAST(219.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (837, 7499, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (838, 7521, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (839, 7506, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (840, 7840, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (841, 7844, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (842, 7505, 'electronics', 'samsung galaxy tab 7''', CAST(541.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (843, 7504, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (844, 7844, 'computers', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (845, 7504, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (846, 7840, 'computers', 'gigabyte b550m aorus elite', CAST(119.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (847, 7654, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (848, 9901, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (849, 7503, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (850, 7504, 'computers', 'sound blasters', CAST(84.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (851, 7840, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (852, 7840, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (853, 9901, 'computers', 'sound blasters', CAST(84.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (854, 7499, 'computers', 'fast intel cpu', CAST(1549.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (855, 7503, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (856, 7499, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (857, 7503, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (858, 7521, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (859, 7505, 'computers', 'very fast amd cpu', CAST(1999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (860, 7654, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (861, 7840, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (862, 7521, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (863, 7521, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (864, 7499, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (865, 7840, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (866, 7505, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (867, 7840, 'electronics', 'alexa voice remote', CAST(129.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (868, 7840, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (869, 7840, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (870, 7840, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (871, 7840, 'supplies', 'pen', CAST(13.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (872, 7506, 'computers', 'samsung ram memory', CAST(219.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (873, 7844, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (874, 7654, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (875, 7840, 'computers', 'seasonic powesupply 850v', CAST(309.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (876, 7844, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (877, 7844, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (878, 7499, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (879, 7499, 'electronics', 'samsung galaxy tab 7''', CAST(541.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (880, 7499, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (881, 9901, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (882, 7840, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (883, 7503, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (884, 7503, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (885, 7505, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (886, 7521, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (887, 7503, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (888, 7499, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (889, 7499, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (890, 7654, 'supplies', 'pro duct tape 70m', CAST(33.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (891, 7499, 'electronics', 'samsung galaxy tab 7''', CAST(541.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (892, 7503, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (893, 7505, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (894, 7506, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (895, 7840, 'mobile', 'lg g8x cell phone', CAST(899.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (896, 7499, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (897, 7844, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (898, 7521, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (899, 9901, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (900, 7503, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (901, 7840, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (902, 7844, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (903, 7505, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (904, 7499, 'computers', 'fast intel cpu', CAST(1549.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (905, 7521, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (906, 7506, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (907, 7503, 'supplies', 'water', CAST(15.40 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (908, 9901, 'computers', 'lg lcd display 24''', CAST(181.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (909, 7505, 'computers', 'lian li o11 dynamic xl white', CAST(271.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (910, 7521, 'computers', 'asus threadripper mainboards', CAST(480.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (911, 7840, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (912, 7844, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (913, 7499, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (914, 7505, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (915, 7503, 'computers', 'aorus ryzen mainboard', CAST(270.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (916, 7521, 'supplies', 'colorful markers set', CAST(29.30 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (917, 7840, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (918, 7840, 'tools', 'ifixit mako 64 diver kit', CAST(60.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (919, 7504, 'computers', 'sound blasters', CAST(84.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (920, 7840, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (921, 7844, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (922, 7499, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (923, 7503, 'computers', 'saphire graphics card', CAST(244.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (924, 7840, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (925, 7503, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (926, 7503, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (927, 9901, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (928, 7506, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (929, 7840, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (930, 9901, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (931, 9901, 'mobile', 'apple iphone 5', CAST(819.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (932, 7503, 'electronics', 'fire android tablet', CAST(419.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (933, 7503, 'computers', 'thermaltake pacific cl360', CAST(162.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (934, 9901, 'tools', 'milwaukee ph30 hammer drill', CAST(229.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (935, 7844, 'mobile', 'google pixel 5', CAST(999.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (936, 7654, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (937, 7840, 'mobile', 'apple iphone 6', CAST(1279.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (938, 7499, 'supplies', 'pencil', CAST(6.79 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (939, 7506, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (940, 7499, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (941, 7840, 'electronics', 'ipad 11''', CAST(1199.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (942, 7844, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (943, 7503, 'supplies', 'self-adhesive office tape', CAST(9.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (944, 7503, 'electronics', 'alexa voice remote', CAST(129.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (945, 7654, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (946, 7503, 'computers', 'fast intel cpu', CAST(1549.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (947, 7503, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (948, 7505, 'computers', 'logitech touchpad', CAST(57.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (949, 7654, 'computers', 'normal speed amd cpu', CAST(779.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (950, 7505, 'computers', 'lian li o11 dynamic black case', CAST(179.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (951, 7840, 'supplies', 'dark chocolate 200g', CAST(14.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (952, 9901, 'computers', 'samsung led display 43''', CAST(750.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (953, 7840, 'computers', 'iiyama lcd display 27''', CAST(275.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (954, 7654, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (955, 7844, 'supplies', 'pro duct tape 70m', CAST(33.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (956, 7844, 'electronics', 'sony play station', CAST(1069.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (957, 7654, 'supplies', 'printing paper', CAST(17.77 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (958, 7654, 'computers', 'samsung ram memory', CAST(219.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (959, 7503, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (960, 7499, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (961, 7499, 'electronics', 'samsung galaxy supertab 10''', CAST(799.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (962, 7654, 'computers', 'samsung led display 43''', CAST(750.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (963, 7504, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (964, 7844, 'tools', 'ifixit mako 64 diver kit', CAST(60.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (965, 7844, 'electronics', 'amazon echo', CAST(134.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (966, 7499, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (967, 7506, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (968, 7840, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (969, 7840, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (970, 9901, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (971, 9901, 'computers', 'keyboard', CAST(69.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (972, 7499, 'electronics', 'samsung galaxy supertab 10''', CAST(799.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (973, 7506, 'supplies', 'cordless hoover', CAST(589.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (974, 7840, 'computers', 'sunflower power supply 1000v', CAST(289.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (975, 7499, 'computers', 'fast amd cpu', CAST(1399.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (976, 7844, 'computers', 'fractal design vector rs comp case', CAST(217.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (977, 7844, 'supplies', 'brother printer toner', CAST(39.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (978, 7503, 'computers', 'very fast intel cpu', CAST(2699.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (979, 9901, 'supplies', 'de luxe printing paper', CAST(25.90 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (980, 7844, 'mobile', 'google pixel 4', CAST(529.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (981, 7499, 'computers', 'computer mice', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (982, 7504, 'supplies', 'battery hair clippers', CAST(68.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (983, 7503, 'computers', 'very fast intel cpu', CAST(2699.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (984, 7504, 'computers', 'gigabyte b550m aorus elite', CAST(119.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (985, 7844, 'supplies', 'hp printer toner', CAST(32.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (986, 7840, 'supplies', 'apple wireless charger', CAST(43.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (987, 7844, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (988, 7505, 'computers', 'quallcom apu 8th gen', CAST(276.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (989, 7840, 'computers', 'zen OLED display 59'' ', CAST(1049.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (990, 7521, 'supplies', 'konica/minolta color toner', CAST(52.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (991, 7840, 'electronics', 'speakers', CAST(209.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (992, 7840, 'computers', 'fractal design vector rs comp case', CAST(217.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (993, 7840, 'mobile', 'google pixel 4', CAST(529.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (994, 7521, 'computers', 'noname ram memory', CAST(150.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (995, 9901, 'tools', 'soldering iron', CAST(235.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (996, 7840, 'computers', 'gigabyte b550m aorus elite', CAST(119.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (997, 7840, 'computers', 'lian li o11 dynamic black case', CAST(179.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (998, 7521, 'electronics', 'amplifiers', CAST(299.00 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (999, 7505, 'supplies', 'milk chocolate 150g', CAST(7.50 AS Decimal(18, 2)));
 
INSERT INTO SALES  VALUES (1000, 7840, 'computers', 'trident ram memory', CAST(300.00 AS Decimal(18, 2)));
 

 /* Add Foreign Key Constraint on Existing EMP Table    */
ALTER TABLE DBO.SALES
ADD CONSTRAINT Fk_sourceSALES_destEMP_columnEMPNO
FOREIGN KEY(EMPNO) REFERENCES DBO.EMP(EMPNO);

--END

