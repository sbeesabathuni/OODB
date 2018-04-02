/****************************************************************************
CSE532 -- Project 2
File name: ObjectOrientedDBDesign.sql
Author(s): Sravya Beesabathuni (111327265)
Pooja R Dalaya (111323959 )
Brief description: This file the query 2
****************************************************************************/

/*We pledge our honor that all parts
of this project were done by us alone and without collaboration with
anybody else.*/


\c woco


select p.name, sum(complist.shares_owned*c.share_price) as networth from person p, company c, unnest(p.company_owned_list) as complist where complist.id = c.id and  complist.shares_owned >0 group by p.name order by p.name;

