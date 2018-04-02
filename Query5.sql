/****************************************************************************
CSE532 -- Project 2
File name: ObjectOrientedDBDesign.sql
Author(s): Sravya Beesabathuni (111327265)
Pooja R Dalaya (111323959 )
Brief description: This file the query 5
****************************************************************************/
/*We pledge our honor that all parts
of this project were done by us alone and without collaboration with
anybody else.*/


\c woco

WITH RECURSIVE PERSON_INDIRECTLY_OWNS AS (
SELECT P.ID AS PERSONID, COMPLIST.ID as COMPANYID, round((complist.shares_owned/c.shares_issued),6) as val FROM COMPANY C, PERSON P, UNNEST(P.COMPANY_OWNED_LIST) AS COMPLIST WHERE complist.id = c.id and complist.shares_owned > 0
UNION 
Select po.personid as PERSONID, co.COMPANY2 as COMPANYID, round((po.val*co.val),6) as val  from PERSON_INDIRECTLY_OWNS po, COMPANY_INDIRECTLY_OWNS co where po.COMPANYID = co.COMPANY1 and co.val > 0
),
COMPANY_INDIRECTLY_OWNS AS (
SELECT C.ID AS COMPANY1, CLIST.ID AS COMPANY2, round((CLIST.shares_owned/c2.shares_issued), 6) as val FROM COMPANY C, COMPANY C2, UNNEST(C.COMPANY_OWNED_LIST)CLIST WHERE C2.ID = CLIST.ID AND CLIST.SHARES_OWNED > 0
UNION
SELECT C.ID AS COMPANY1, CO.COMPANY2 AS COMPANY2, round((co.val *(CLIST.SHARES_OWNED/C2.SHARES_ISSUED)),6) AS VAL FROM COMPANY C, COMPANY_INDIRECTLY_OWNS CO, COMPANY C2, UNNEST(C.COMPANY_OWNED_LIST) CLIST WHERE CO.COMPANY1 = CLIST.ID AND CLIST.ID = C2.ID AND CLIST.SHARES_OWNED > 0 AND CO.VAL > 0
)
SELECT per.name, c.name, SUM(p.val*100) as percentage  FROM PERSON_INDIRECTLY_OWNS P, person per, company c where per.id = p.personId and c.id = p.companyId group by per.name, c.name having SUM(p.val*100) > 10 order by per.name;