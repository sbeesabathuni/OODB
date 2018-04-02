/****************************************************************************
CSE532 -- Project 2
File name: ObjectOrientedDBDesign.sql
Author(s): Sravya Beesabathuni (111327265)
Pooja R Dalaya (111323959 )
Brief description: This file the query 1
****************************************************************************/

/*We pledge our honor that all parts
of this project were done by us alone and without collaboration with
anybody else.*/

\c woco

select distinct(c.name) as cname from person p, company c, unnest(p.company_owned_list) as personowns, unnest(c.board_members) as bm where bm=p.id and c.id=personowns.id and personowns.shares_owned>0 order by c.name;