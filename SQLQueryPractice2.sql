-- Удаляем таблицы, если есть
DROP TABLE IF EXISTS Scores;
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Teachers;
DROP TABLE IF EXISTS Students;
DROP TABLE IF EXISTS Courses;

-- Создаём таблицу Students
CREATE TABLE Students (
    student_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    group_name VARCHAR(20) NULL
);

-- Создаём таблицу Courses
CREATE TABLE Courses (
    course_id INT PRIMARY KEY IDENTITY(1,1),
    course_name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NULL
);

-- Таблица Enrollments (записи на курс)
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT NOT NULL FOREIGN KEY REFERENCES Students(student_id),
    course_id INT NOT NULL FOREIGN KEY REFERENCES Courses(course_id),
    enrollment_date DATE NOT NULL
);

-- Таблица Scores (оценки)
CREATE TABLE Scores (
    score_id INT PRIMARY KEY IDENTITY(1,1),
    enrollment_id INT NOT NULL FOREIGN KEY REFERENCES Enrollments(enrollment_id),
    score INT CHECK(score BETWEEN 0 AND 100),
    attempt INT DEFAULT 1
);

-- Таблица Teachers (преподаватели)
CREATE TABLE Teachers (
    teacher_id INT PRIMARY KEY IDENTITY(1,1),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    course_id INT NOT NULL FOREIGN KEY REFERENCES Courses(course_id)
);


-- Добавляем студентов (10 шт)
INSERT INTO Students (first_name, last_name, group_name) VALUES
('Ivan', 'Ivanov', 'A1'),
('Petr', 'Petrov', 'A2'),
('Olga', 'Sidorova', 'B1'),
('Anna', 'Kuznetsova', 'A3'),
('Mikhail', 'Smirnov', 'B2'),
('Elena', 'Popova', 'A1'),
('Dmitry', 'Volkov', 'C1'),
('Svetlana', 'Morozova', 'B1'),
('Alexey', 'Nikolaev', 'A2'),
('Marina', 'Fedorova', 'C2');

-- Добавляем курсы (5 шт)
INSERT INTO Courses (course_name, category) VALUES
('SQL Basics', 'Programming'),
('Advanced SQL', 'Programming'),
('English for IT', 'Language'),
('Project Management', 'Management'),
('Data Analysis', 'Programming');

-- Добавляем преподавателей (5 шт)
INSERT INTO Teachers (first_name, last_name, course_id) VALUES
('Ivan', 'Petrov', 1),
('Elena', 'Smirnova', 2),
('Olga', 'Kovaleva', 3),
('Sergey', 'Sidorov', 4),
('Anna', 'Morozova', 5);

-- Добавляем записи на курсы (Enrollments) — 15 шт
INSERT INTO Enrollments (student_id, course_id, enrollment_date) VALUES
(1, 1, '2024-01-15'),
(2, 1, '2024-01-20'),
(3, 2, '2024-02-01'),
(4, 3, '2024-02-05'),
(5, 4, '2024-02-10'),
(6, 1, '2024-01-25'),
(7, 5, '2024-03-01'),
(8, 2, '2024-03-05'),
(9, 4, '2024-03-10'),
(10, 5, '2024-03-15'),
(1, 3, '2024-04-01'),
(3, 1, '2024-04-05'),
(5, 2, '2024-04-10'),
(7, 4, '2024-04-15'),
(9, 5, '2024-04-20');

-- Добавляем оценки (Scores) — 20 шт
INSERT INTO Scores (enrollment_id, score, attempt) VALUES
(1, 95, 1),
(2, 87, 1),
(3, 78, 1),
(4, 88, 1),
(5, 92, 1),
(6, 84, 1),
(7, 90, 1),
(8, 85, 1),
(9, 75, 1),
(10, 80, 1),
(11, 88, 1),
(12, 91, 1),
(13, 69, 1),
(14, 77, 1),
(15, 85, 1),
(1, 97, 2),  -- второй заход для первого
(4, 90, 2),
(7, 93, 2),
(10, 82, 2),
(12, 94, 2);


SELECT * FROM Students
WHERE group_name LIKE '%A%';


SELECT * FROM Courses
WHERE category = 'Programming'
ORDER BY course_name;

SELECT last_name + ' ' + first_name AS FullName FROM Students;


SELECT * FROM Enrollments
WHERE YEAR(enrollment_date) = 2024;


SELECT last_name FROM Students
UNION
SELECT last_name FROM Teachers;

SELECT score,
    CASE
        WHEN score >= 90 THEN 'Отлично'
        WHEN score >= 70 THEN 'Хорошо'
        WHEN score >= 50 THEN 'Удовлетворительно'
        ELSE 'Неуд.'
    END AS GradeLevel
FROM Scores;


SELECT DISTINCT student_id FROM Enrollments
INTERSECT
SELECT DISTINCT e.student_id
FROM Scores s
JOIN Enrollments e ON s.enrollment_id = e.enrollment_id;

SELECT DISTINCT student_id FROM Enrollments
EXCEPT
SELECT DISTINCT e.student_id
FROM Scores s
JOIN Enrollments e ON s.enrollment_id = e.enrollment_id;


SELECT st.student_id, st.first_name, st.last_name, AVG(s.score) AS avg_score
FROM Scores s
JOIN Enrollments e ON s.enrollment_id = e.enrollment_id
JOIN Students st ON e.student_id = st.student_id
GROUP BY st.student_id, st.first_name, st.last_name
ORDER BY avg_score DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

SELECT c.course_name, COUNT(DISTINCT e.student_id) AS student_count
FROM Courses c
LEFT JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

SELECT st.student_id, st.first_name, st.last_name, AVG(sc.score) AS avg_score
FROM Students st
JOIN Enrollments e ON st.student_id = e.student_id
JOIN Scores sc ON e.enrollment_id = sc.enrollment_id
GROUP BY st.student_id, st.first_name, st.last_name;


SELECT c.course_name, AVG(sc.score) AS avg_score
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Scores sc ON e.enrollment_id = sc.enrollment_id
GROUP BY c.course_name
HAVING AVG(sc.score) > 70;

SELECT c.course_name,
    MAX(sc.score) AS max_score,
    MIN(sc.score) AS min_score
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
JOIN Scores sc ON e.enrollment_id = sc.enrollment_id
GROUP BY c.course_name;

