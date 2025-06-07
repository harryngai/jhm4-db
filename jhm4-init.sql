DROP DATABASE IF EXISTS jhm4_test; -- 如果存在則刪除資料庫
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
