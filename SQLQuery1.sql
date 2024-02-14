create database ISO




CREATE TABLE Students (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
    Surname NVARCHAR(55) DEFAULT 'XXXXXX',
);


CREATE TABLE Subjects (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(50) NOT NULL,
);


CREATE TABLE Exams (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Date DATE NOT NULL,

);

USE ISO; 

ALTER TABLE Exams
ADD SubjectId INT NOT NULL;


ALTER TABLE Exams
ADD CONSTRAINT FK_Exams_SubjectId FOREIGN KEY (SubjectId) REFERENCES Subjects(Id);


CREATE TABLE StudentExams (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    StudentId INT NOT NULL,
    ExamId INT NOT NULL,
    ExamResult DECIMAL(5, 2), 
    FOREIGN KEY (StudentId) REFERENCES Students(Id),
    FOREIGN KEY (ExamId) REFERENCES Exams(Id),
);

SELECT 
    s.Name AS StudentName,
    COALESCE(s.Surname, 'XXXXXX') AS StudentSurname,
    sub.Name AS SubjectName,
    e.Date AS ExamDate,
    se.ExamResult AS ExamResult
FROM 
    Students s
LEFT JOIN 
    StudentExams se ON s.Id = se.StudentId
LEFT JOIN 
    Exams e ON se.ExamId = e.Id
LEFT JOIN 
    Subjects sub ON e.SubjectId = sub.Id;

