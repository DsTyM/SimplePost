drop database if exists SimplePostDB;

create database SimplePostDB;

use SimplePostDB;

create table Users
(
	uid int not null auto_increment,
	username varchar(200) not null,
	password varchar(200) not null,
	type varchar(10) not null,
	primary key(uid),
	unique(username)
);

alter table Users auto_increment = 1;

insert into Users(username, password, type) values
('admin', '1234', 'admin');

create table Announcements
(
	aid int not null auto_increment,
	username varchar(200) not null,
	title varchar(200) not null,
	textbox text not null,
	date datetime not null,
	primary key(aid)
);

alter table Announcements auto_increment = 1;

alter table Announcements modify column date datetime default current_timestamp;

insert into Announcements(username, title, textbox) values('admin', '1ος Τίτλος',
'Αυτή είναι μία ανακοίνωση αποθηκευμένη στην βάση δεδομένων για τις Ανακοινώσεις του TeiSteSchedule.'),
('admin', '2ος Τίτλος', 'Αυτή είναι μία δεύτερη ανακοίνωση αποθηκευμένη στην βάση δεδομένων για τις Ανακοινώσεις του TeiSteSchedule.');
