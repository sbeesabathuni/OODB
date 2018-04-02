/****************************************************************************
CSE532 -- Project 2
File name: ObjectOrientedDBDesign.sql
Author(s): Sravya Beesabathuni (111327265)
Pooja R Dalaya (111323959 )
Brief description: This file the query 3
****************************************************************************/
/*We pledge our honor that all parts
of this project were done by us alone and without collaboration with
anybody else.*/


\c woco

select c.name as companyName, p.name as personName from company c, person p, unnest(c.board_members) as bm, unnest(p.company_owned_list) as complist where p.id = bm and complist.id = c.id and complist.shares_owned in (select max(complist.shares_owned) from person p, company c, unnest(p.company_owned_list) as complist , unnest(c.board_members) as bm where bm=p.id and complist.id = c.id and complist.shares_owned>0 group by c.id)  order by c.name;
