CREATE DATABASE jhm4_test;
USE jhm4_test;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    birthday DATE
);

INSERT INTO Student (student_id, name, gender, birthday) VALUES
(1, '陳大文', 'M', '2006-02-15'),
(2, '李小明', 'M', '2005-11-23'),
(3, '王美麗', 'F', '2006-05-30');
