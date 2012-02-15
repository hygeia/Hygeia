create database hygeia2;
use hygeia2;
create table users (uid integer primary key auto_increment, username text, hpwd text, email text, height real, weight real);
create table inventory (iid integer primary key auto_increment, uid integer, fid integer, count integer);
create table foods (fid integer primary key auto_increment, uid integer, name text, weight integer, factor integer, calories integer, carbohydrates integer, protein integer, fat integer);
create table components (cid integer primary key auto_increment, mid integer, fid integer, count integer);
create table history (hid integer primary key auto_increment, mid integer, uid integer, occurence timestamp);
create table favorites (fid integer primary key auto_increment, mid integer, uid integer);
create table meals (mid integer primary key auto_increment, uid integer, calories integer, carbohydrates integer, protein integer, fat integer);
