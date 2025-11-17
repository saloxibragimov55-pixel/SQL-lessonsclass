CREATE TABLE Ограничения_SQL (
    Тип_ограничения VARCHAR(50) PRIMARY KEY,
    Определение TEXT,
    Пример_использования_SQL TEXT,
    Подсказки_и_советы TEXT
);

INSERT INTO Ограничения_SQL (Тип_ограничения, Определение, Пример_использования_SQL, Подсказки_и_советы) VALUES
('PRIMARY KEY (Первичный ключ)', 'Уникально идентифицирует каждую строку в', 'CREATE TABLE Students (', 'Можно задать при создании таблицы или добавить'),
('FOREIGN KEY (Внешний ключ)', 'Обеспечивает связь между двумя таблицами.', 'CREATE TABLE Students (', 'Помогает сохранить целостность данных. Можно'),
('UNIQUE (Уникальное)', 'Гарантирует, что значения в столбце уникальны.', 'Create Table Students (', 'Можно иметь несколько UNIQUE столбцов в одной'),
('NOT NULL (Не NULL)', 'Запрещает хранение пустых значений в столбце.', 'Create Table Employees (Empid INT PRIMARY KEY, Firstname', 'Используйте для ключевых или обязательных'),
('CHECK (Проверка)', 'Проверяет выполнение условия для каждого', 'Create Table Products (ProductID INT PRIMARY KEY, Price', 'Помогает ограничить значения допустимыми'),
('DEFAULT (По умолчанию)', 'Автоматически присваивает значение при отсутствии', 'CREATE TABLE Orders (OrderID INT PRIMARY KEY, Status', 'Используйте для статусов, дат, или счетчиков, чтобы'),
('IDENTITY (Автоинкремент) (SQL)', 'Автоматически увеличивает числовое значение при', 'alter table mentors alter column id int identity (1,1)', 'Удобно для первичных ключей. Можно указать'),
('COMPOSITE KEY (Составной)', 'Первичный ключ, состоящий из нескольких столбцов.', 'CREATE TABLE Enrollments (StudentID INT, CourseID INT, PRIMARY', 'Используется, когда комбинация полей уникальна,'),
('UNIQUE + NOT NULL', 'Комбинация для строгого контроля уникальности и', 'CREATE TABLE Users (UserID INT PRIMARY KEY, Username', 'Хорошо применять для уникальных идентификаторов');

select * from Ограничения_SQL