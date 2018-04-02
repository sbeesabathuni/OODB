/****************************************************************************
CSE532 -- Project 2
File name: ObjectOrientedDBDesign.sql
Author(s): Sravya Beesabathuni (111327265)
Pooja R Dalaya (111323959 )
Brief description: This file the query 4
****************************************************************************/
/*We pledge our honor that all parts
of this project were done by us alone and without collaboration with
anybody else.*/


select c1.name as c1name,c2.name as c2name from company c1, company c2 where c1.industry && c2.industry and c1.id<>c2.id and not exists(select c.id from unnest(c2.board_members) as bm2, company c, person p, unnest(p.company_owned_list) as colist2 where colist2.id=c.id and p.id=bm2 except select co.id from company co,unnest(c1.board_members) as b1,unnest(c2.board_members) as b2, person p1,person p2, unnest(p1.company_owned_list) as co1,unnest(p2.company_owned_list) as co2 where p1.id=b1 and p2.id=b2 and co.id=co1.id and co.id=co2.id group by co.id,co1.shares_owned having co1.shares_owned>=max(co2.shares_owned));