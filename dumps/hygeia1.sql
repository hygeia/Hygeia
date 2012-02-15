create database hygeia1;
use hygeia1;
create table users (uid integer primary key auto_increment, username text, hpwd text, email text, height real, weight real);
create table inventory (iid integer primary key auto_increment, uid integer, fid integer, count integer, purchase timestamp, ttl integer);
create table foods (fid integer primary key auto_increment, uid integer, name text, ttl integer);
create table components (cid integer primary key auto_increment, mid integer, fid integer, count integer);
create table history (hid integer primary key auto_increment, mid integer, uid integer, occurence timestamp);
create table favorites (fid integer primary key auto_increment, mid integer, uid integer);
create table meals (mid integer primary key auto_increment, uid integer);
