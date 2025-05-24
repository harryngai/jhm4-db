-- 1. 基本查詢：列出所有學生及其班級 (Basic query: List all students with their classes)
SELECT 
    s.student_id, 
    s.name AS student_name, 
    s.gender, 
    c.class_name, 
    c.grade
FROM 
    Student s
JOIN 
    Class c ON s.class_id = c.class_id
ORDER BY 
    c.class_name, s.name;
-- 此查詢顯示所有學生及其所屬班級的基本資訊

-- 2. 查詢學生選課情況 (Query student course enrollment)
SELECT 
    s.student_id, 
    s.name AS student_name, 
    c.course_id, 
    c.course_name, 
    c.credit,
    t.name AS teacher_name
FROM 
    Student s
JOIN 
    Student_Course sc ON s.student_id = sc.student_id
JOIN 
    Course c ON sc.course_id = c.course_id
JOIN
    Teacher t ON c.teacher_id = t.teacher_id
ORDER BY 
    s.name, c.course_name;
-- 此查詢顯示每位學生選修的課程及授課教師

-- 3. 查詢各班級的班導師 (Query class advisors)
SELECT 
    c.class_id, 
    c.class_name, 
    c.grade,
    t.teacher_id, 
    t.name AS advisor_name, 
    t.department
FROM 
    Class c
JOIN 
    Class_Teacher ct ON c.class_id = ct.class_id
JOIN 
    Teacher t ON ct.teacher_id = t.teacher_id
ORDER BY 
    c.class_name;
-- 此查詢顯示各班級的班導師資訊

-- 4. 統計每位學生選修的課程數和總學分 (Count courses and total credits per student)
SELECT 
    s.student_id, 
    s.name,
    COUNT(sc.course_id) AS course_count,
    SUM(c.credit) AS total_credits
FROM 
    Student s
LEFT JOIN 
    Student_Course sc ON s.student_id = sc.student_id
LEFT JOIN 
    Course c ON sc.course_id = c.course_id
GROUP BY 
    s.student_id, s.name
ORDER BY 
    total_credits DESC;
-- 此查詢計算每位學生的選課數量和總學分

-- 5. 查詢特定科系的課程及其選課學生數 (Query courses from specific department with enrollment count)
SELECT 
    c.course_id, 
    c.course_name, 
    c.credit,
    t.name AS teacher_name,
    COUNT(sc.student_id) AS student_count
FROM 
    Course c
JOIN 
    Teacher t ON c.teacher_id = t.teacher_id
LEFT JOIN 
    Student_Course sc ON c.course_id = sc.course_id
WHERE 
    c.department = 'Mathematics'
GROUP BY 
    c.course_id, c.course_name, c.credit, t.name
ORDER BY 
    student_count DESC;
-- 此查詢顯示數學系的所有課程及其選課人數

-- 6. 複雜查詢：找出至少選修兩門課的學生及其班級和班導師 (Complex query: Find students enrolled in at least 2 courses with their class and advisor)
SELECT 
    s.student_id, 
    s.name AS student_name,
    cl.class_name,
    t.name AS advisor_name,
    COUNT(sc.course_id) AS course_count
FROM 
    Student s
JOIN 
    Class cl ON s.class_id = cl.class_id
JOIN 
    Class_Teacher ct ON cl.class_id = ct.class_id
JOIN 
    Teacher t ON ct.teacher_id = t.teacher_id
JOIN 
    Student_Course sc ON s.student_id = sc.student_id
GROUP BY 
    s.student_id, s.name, cl.class_name, t.name
HAVING 
    COUNT(sc.course_id) >= 2
ORDER BY 
    course_count DESC;
-- 此查詢找出選修至少兩門課的學生，並顯示其班級和班導師資訊