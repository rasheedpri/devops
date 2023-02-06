#!/bin/bash
mysql_password=P@ssw0rd
# Login to MySQL
mysql -u root  << EOF



ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'P@ssw0rd';

# Create database
CREATE DATABASE socka;


# Use the database
USE socka;

# Create table
CREATE TABLE players (
  id int(5) NOT NULL AUTO_INCREMENT,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  position varchar(255) NOT NULL,
  number int(11) NOT NULL,
  image varchar(255) NOT NULL,
  user_name varchar(20) NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1;

EOF