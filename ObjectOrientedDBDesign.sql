/****************************************************************************
CSE532 -- Project 2
File name: ObjectOrientedDBDesign.sql
Author(s): Sravya Beesabathuni (111327265)
Pooja R Dalaya (111323959 )
Brief description: This file contains database design with different types and tables. All the constraints also mentioned. Also contains the (DML) insert statements to the tables.
****************************************************************************/

/*We pledge our honor that all parts
of this project were done by us alone and without collaboration with
anybody else.*/


\echo 'DATABASE DESIGN'

DROP DATABASE IF EXISTS woco;

CREATE DATABASE WOCO OWNER POSTGRES;

\connect woco

DROP TYPE IF EXISTS company_owned;

CREATE TYPE company_owned AS (ID int, SHARES_OWNED numeric);

DROP TABLE IF EXISTS owner;

CREATE TABLE owner(ID INT PRIMARY KEY NOT NULL, NAME text NOT NULL, company_owned_list company_owned[]);

DROP TABLE IF EXISTS company;
	
CREATE TABLE company (SHARES_ISSUED numeric NOT NULL, SHARE_PRICE REAL NOT NULL, INDUSTRY text[] NOT NULL, BOARD_MEMBERS integer[] NOT NULL) INHERITS (owner);

DROP TABLE IF EXISTS person;

CREATE TABLE person() INHERITS (owner);

INSERT INTO company VALUES(1,'QUE',ARRAY[row(2,10000)::company_owned,row(3,20000)::company_owned,row(4,30000)::company_owned],150000,30,ARRAY['Software','Accounting'],ARRAY[113,111,114]);

INSERT INTO company VALUES(2,'RHC','{}',250000,20,ARRAY['Accounting'],ARRAY[112,111,115]);

INSERT INTO company VALUES(3,'Elgog',ARRAY[row(7,5000)::company_owned],1000000,400,ARRAY['Software','Search'],ARRAY[116,115,117]);

INSERT INTO company VALUES(4,'Elpa',ARRAY[row(6,20000)::company_owned,row(3,20000)::company_owned],9000000,300,ARRAY['Software','Hardware'],ARRAY[112,113,118]);

INSERT INTO company VALUES(5,'Alf',ARRAY[row(9,-100000)::company_owned,row(3,400000)::company_owned,row(4,100000)::company_owned],10000000,700,ARRAY['Software','Automotive'],ARRAY[116,111,117]);

INSERT INTO company VALUES(6,'Tfos',ARRAY[row(7,30000)::company_owned,row(8,50000)::company_owned,row(1,200000)::company_owned],10000000,300,ARRAY['Software','Hardware'],ARRAY[112,115,114]);

INSERT INTO company VALUES(7,'Ohay','{}',180000,50,ARRAY['Search'],ARRAY[112,118,114]);

INSERT INTO company VALUES(8,'Gnow','{}',150000,300,ARRAY['Search'],ARRAY[112,113,114]);

INSERT INTO company VALUES(9,'Ydex','{}',5000000,100,ARRAY['Software','Search'],ARRAY[113,116,118]);

INSERT INTO person VALUES(111,'Bill Doe', ARRAY[ROW(6,30000)::company_owned,ROW(4,100000)::company_owned]);

INSERT INTO person VALUES(112,'Bill Seth', ARRAY[ROW(3,20000)::company_owned,ROW(8,40000)::company_owned]);

INSERT INTO person VALUES(113,'John Smyth', ARRAY[ROW(1,20000)::company_owned,ROW(2,20000)::company_owned,ROW(6,800000)::company_owned]);

INSERT INTO person VALUES(114,'Anne Smyle', ARRAY[ROW(2,30000)::company_owned,ROW(5,500000)::company_owned,ROW(6, 40000)::company_owned]);

INSERT INTO person VALUES(115,'Steve Lamp', ARRAY[ROW(1, 50000)::company_owned,ROW(2, 70000)::company_owned,ROW(7, 50000)::company_owned,ROW(4, 90000)::company_owned]);

INSERT INTO person VALUES(116,'May Serge', ARRAY[ROW(2, 40000)::company_owned,ROW(5, 500000)::company_owned,ROW(4, -10000)::company_owned,ROW(9, -40000)::company_owned]);

INSERT INTO person VALUES(117,'Bill Public', ARRAY[ROW(1, 30000)::company_owned,ROW(3, 30000)::company_owned,ROW(6, 300000)::company_owned,ROW(8, 80000)::company_owned]);

INSERT INTO person VALUES(118,'Muck Lain', ARRAY[ROW(2, 60000)::company_owned,ROW(7, -4000)::company_owned,ROW(4, 30000)::company_owned,ROW(9, -80000)::company_owned]);


\echo 'DONE'