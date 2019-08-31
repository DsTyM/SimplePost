# SimplePost

SimplePost is a simple post management system web application.<br />
It is actually a simple CRUD web application implemented in Java EE (now called Jakarta EE) using 
MVC Architecture.<br />
It uses JSP files as the View, it uses Servlets as the Controller and it uses simple Java Classes as the Model.<br />
It uses MySQL as the database and JDBC to connect Java with MySQL.<br />
It also uses HTML and CSS for the View on the JSP Files just to project the content. But it strongly focuses on 
the back-end and not at the front-end.<br />
I tried to use Clean Code and Best Practices as much as I could on the back-end (not on the front-end).<br />

All users that access the website can view the posts.<br />
The already logged in users can also edit and delete the posts that have uploaded themselves
and they can also create new posts.<br />

View (JSP files) functionality is inside web/WEB-INF folder (so that the client has no access to JSP 
files directly).<br />
Controller (Servlets) functionality is inside src/com/dstym/controller folder (com.dstym.controller) 
is the package.<br />
Model (Simple Java Classes) functionality is inside src/com/dstym/model folder (com.dstym.model) is the package.<br />

<!-- here show the image -->

You need to change the database credentials on src/com/dstym/model/DbHelper.java file
dbUrl is where you give the url of connection to the database, dbUsername and dbPassword is the 
username and the password credentials of the database.<br />

Database has been dumped using mysqldump and it should be imported using the file: SimplePostDB_Dump.sql
like this:
create database simplepostdb;
mysql -u username -p simplepostdb < SimplePostDB_Dump.sql

This application has been tested using OpenJDK 12, Apache Tomcat 9 and MySQL 8.<br />

This project created just for learning purposes.<br />
