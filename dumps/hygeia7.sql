create database hygeia7;
grant insert, select, update, delete on hygeia7.* to 'hygeiadb'@'localhost';
use hygeia7;
create table users (
    uid integer primary key auto_increment, 
    username text not null, 
    hpwd text not null, 
    email text not null, 
    height real not null, 
    weight real not null,
    gender char not null,
    leanBodyMass real,
    hips real,
    waist real,
    wrist real,
    activity integer,
    blocks integer);
create table inventory (
    iid integer primary key auto_increment, 
    uid integer not null, 
    fid integer not null, 
    count real not null,
    foreign key (uid) references users(uid) on delete cascade);
create table foods (
    fid integer primary key auto_increment, 
    uid integer not null, 
    name text not null, 
    weight real not null, 
    factor real not null, 
    calories real not null, 
    carbohydrates real not null, 
    protein real not null, 
    fat real not null,
    foreign key (uid) references users(uid) on delete cascade);
create table components (
    cid integer primary key auto_increment, 
    mid integer not null, 
    fid integer not null, 
    count real not null,
    foreign key (fid) references foods(fid) on delete cascade);
create table history (
    hid integer primary key auto_increment, 
    mid integer not null, 
    uid integer not null, 
    occurrence timestamp not null,
    foreign key (uid) references users(uid) on delete cascade);
create table favorites (
    fid integer auto_increment, 
    mid integer not null, 
    uid integer not null,
    primary key (fid, mid, uid),
    foreign key (uid) references users(uid) on delete cascade);
create table meals (
    mid integer primary key auto_increment, 
    uid integer not null, 
    name text not null, 
    calories real not null, 
    carbohydrates real not null, 
    protein real not null, 
    fat real not null,
    foreign key (uid) references users(uid) on delete cascade);
create table admins (
    aid integer primary key auto_increment, 
    email text not null, 
    hpwd text not null);

alter table inventory add foreign key (fid) references foods(fid) on delete cascade;
alter table components add foreign key (mid) references meals(mid) on delete cascade;
alter table history add foreign key (mid) references meals(mid) on delete cascade;
alter table favorites add foreign key (mid) references meals(mid) on delete cascade;

insert into users values(0, "systemwide", "nologon", "bounce@hygeia", 1, 1, 'M',
    1, 1, 1, 1, 1, 1);
update users set uid=0 where uid=1;

set sql_mode = "STRICT_ALL_TABLES";
