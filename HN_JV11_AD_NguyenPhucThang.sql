use hkathon_thuchanh;
-- ============================= Classes ===================================
create table Classes (
	ClassId int unique primary key auto_increment not null,
    Classname Varchar (50)
);
insert into Classes values 
(null, "C0706L"), (null, "C0708G");

-- ============================= Students ===================================
create table Students (
	StudentId int unique primary key auto_increment not null,
    StudetnName varchar(50),
    Age int ,
    Email varchar (50)
);
insert into Students values 
(null, "Nguyen Quang An ",18,"an@yahoo.com"),
(null, "Nguyen Cong Vinh ",20,"vinh@gmail.com"),
(null, "Nguyen Van Quyet ",19,"quyen"),
(null, "Pham Thanh Binh  ",25,"binh@ygmail.com"),
(null, "Nguyen Van Tai Em  ",30,"taiem@sport.vn");

-- ============================= ClassStudent ===================================
create table ClassStudent (
	StudentId int ,
    foreign key (StudentId) references Students(StudentId),
    ClassId  int,
    foreign key (ClassId) references Classes(ClassId)
);
insert into ClassStudent values 
(1,1),(2,1),(3,2),(4,2),(5,2);

-- ============================= Subjects ===================================
create table Subjects (
	SubjectsId int unique primary key auto_increment not null,
    SubjectsName varchar(50)
);
insert into Subjects values 
(1,"SQL"),(2,"JAVA"),(3,"C"),(4,"Visual Basic");

-- ============================= Mark ===================================
create table Marks (
	Mark int ,
    SubjectsId int ,
    foreign key (SubjectsId) references Subjects (SubjectsId),
    StudentId int ,
    foreign key (StudentId) references Students (StudentId)
);
INSERT INTO Marks VALUES 
    (1, 1, 1),
    (3, 1, 4),
    (7, 1, 3),
    (8, 1, 1),
    (9, 1, 1),
    (3, 2, 4),
    (4, 2, 1),
    (8, 3, 3),
    (5, 2, 5);
    
-- =============================== Thuc hanh ======================================
-- 1 Hiển thị tất cả danh sách các học viên 
	select * from students;
-- 2. Hien thi danh sach tat ca cac mon hoc
	select * from Subjects;
-- 3. Tinh diem trung binh
	select m.StudentId, AVG(Mark) AS AverageMark
	from Marks m
	group by  StudentId;
-- 4. Hien thi mon hoc nao co hoc sinh thi duoc diem cao nhat
	SELECT Subjects.SubjectsName, MAX(Marks.Mark) AS DiemCaoNhat
	FROM Marks
	JOIN Subjects ON Marks.SubjectsId = Subjects.SubjectsId
	WHERE Marks.Mark = (SELECT MAX(Mark) FROM Marks)
	GROUP BY Subjects.SubjectsName;
-- 5. Danh so thu tu cua diem theo chieu giam
	select * from marks order by mark desc;
-- 6. Thay doi kieu du lieu cua cot SubjectName trong bang Subjects thanh nvarchar(max)
	alter table Subjects modify subjectsName nvarchar(255);
--  7. Cap nhat them dong chu « Day la mon hoc « vao truoc cac ban ghi tren cotSubjectName trong bang Subjects    
    update Subjects
	set subjectsName = concat("Day la mon hoc ",subjectsName); 
-- 8. Viet Check Constraint de kiem tra do tuoi nhap vao trong bang Student yeu cau Age >15 va Age < 50
	alter table Students modify Age  int check (Age > 15 and Age < 50 );
-- 9. Loai bo tat ca quan he giua cac bang  
	alter table ClassStudent
	drop foreign key classstudent_ibfk_1,
    drop foreign key classstudent_ibfk_2;
     alter table Marks
     drop foreign key marks_ibfk_1,
     drop foreign key marks_ibfk_2;
-- 10.Xoa hoc vien co StudentID la 1     
	delete from Students where StudentId = 1;
-- 11.Trong bang Student them mot column Status co kieu du lieu la Bit va co giatri Default la 1
 alter table students 
 add column Status bit default(1);
 -- 12.Cap nhap gia tri Status trong bang Student thanh 0

 update Students
set `status`= 0;
	
