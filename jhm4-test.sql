CREATE DATABASE jhm4_test; -- 建立資料庫
USE jhm4_test; -- 使用該資料庫

-- 首先創建班級表，因為學生表會引用它
CREATE TABLE Class ( -- 創建班級表
    class_id INT PRIMARY KEY, -- 班級編號（主鍵）
    class_name VARCHAR(50) NOT NULL, -- 班級名稱（不可為空）
    grade INT NOT NULL -- 年級（不可為空）
);

CREATE TABLE Student ( -- 創建學生表
    student_id INT PRIMARY KEY, -- 學生編號（主鍵）
    name VARCHAR(50) NOT NULL, -- 學生姓名（不可為空）
    gender VARCHAR(10), -- 性別
    birthday DATE, -- 出生日期
    class_id INT, -- 班級編號（外鍵）
    FOREIGN KEY (class_id) REFERENCES Class(class_id) -- 外鍵參照班級表的班級編號
);

CREATE TABLE Teacher ( -- 創建教師表
    teacher_id INT PRIMARY KEY, -- 教師編號（主鍵）
    name VARCHAR(50) NOT NULL, -- 教師姓名（不可為空）
    gender VARCHAR(10), -- 性別
    department VARCHAR(50) -- 所屬部門
);

CREATE TABLE Course ( -- 創建課程表
    course_id INT PRIMARY KEY, -- 課程編號（主鍵）
    course_name VARCHAR(100) NOT NULL, -- 課程名稱（不可為空）
    credit INT, -- 學分數
    department VARCHAR(50), -- 所屬部門
    teacher_id INT, -- 授課教師編號（外鍵）
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id) -- 外鍵參照教師表的教師編號
);

-- 學生與課程的多對多關係（選課）
CREATE TABLE Student_Course ( -- 創建學生選課關聯表
    student_id INT, -- 學生編號
    course_id INT, -- 課程編號
    enrollment_date DATE DEFAULT (CURRENT_DATE), -- 選課日期，預設為當前日期
    PRIMARY KEY (student_id, course_id), -- 複合主鍵
    FOREIGN KEY (student_id) REFERENCES Student(student_id), -- 外鍵參照學生表的學生編號
    FOREIGN KEY (course_id) REFERENCES Course(course_id) -- 外鍵參照課程表的課程編號
);

-- 班級與教師的多對多關係（班導師）
CREATE TABLE Class_Teacher ( -- 創建班級導師關聯表
    class_id INT, -- 班級編號
    teacher_id INT, -- 教師編號
    PRIMARY KEY (class_id, teacher_id), -- 複合主鍵
    FOREIGN KEY (class_id) REFERENCES Class(class_id), -- 外鍵參照班級表的班級編號
    FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id) -- 外鍵參照教師表的教師編號
);

-- 範例資料插入
INSERT INTO Class (class_id, class_name, grade) VALUES -- 插入班級資料
(1, '4A', 4), -- 班級1：4A，4年級
(2, '4B', 4); -- 班級2：4B，4年級

INSERT INTO Student (student_id, name, gender, birthday, class_id) VALUES -- 插入學生資料
(1, '陳大文', 'M', '2006-02-15', 1), -- 學生1：陳大文，男，生日2006-02-15，屬於班級1
(2, '李小明', 'M', '2005-11-23', 2), -- 學生2：李小明，男，生日2005-11-23，屬於班級2
(3, '王美麗', 'F', '2006-05-30', 1); -- 學生3：王美麗，女，生日2006-05-30，屬於班級1
INSERT INTO Teacher (teacher_id, name, gender, department) VALUES -- 插入教師資料
(1, '張志明', 'M', '數學系'), -- 教師1：張志明，男，數學系
(2, '林美華', 'F', '自然科學系'), -- 教師2：林美華，女，自然科學系
(3, '李國強', 'M', '語言系'); -- 教師3：李國強，男，語言系

INSERT INTO Course (course_id, course_name, credit, department, teacher_id) VALUES -- 插入課程資料
(101, '數學', 4, '數學系', 1), -- 課程101：數學，4學分，數學系，由教師1任教
(102, '物理', 3, '自然科學系', 2), -- 課程102：物理，3學分，自然科學系，由教師2任教
(103, '英文', 3, '語言系', 3); -- 課程103：英文，3學分，語言系，由教師3任教

-- 範例選課資料
INSERT INTO Student_Course (student_id, course_id) VALUES -- 插入學生選課關係
(1, 101), -- 學生1選了課程101
(1, 102), -- 學生1選了課程102
(2, 101), -- 學生2選了課程101
(2, 103), -- 學生2選了課程103
(3, 102); -- 學生3選了課程102

-- 範例班導師關係
INSERT INTO Class_Teacher (class_id, teacher_id) VALUES -- 插入班級導師關係
(1, 2), -- 班級1的導師是教師2
(2, 1); -- 班級2的導師是教師1