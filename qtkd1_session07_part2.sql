/*
	1. Tạo bảng Book_type chứa thông tin các loại sách gồm các trường:
		- book_type_id (Mã loại sách): số nguyên, khóa chính, tự tăng
        - book_type_name (Tên loại sách): tối đa 100 ký tự, không null, không trùng lặp
        - book_type_status (trạng thái loại sách): gồm 2 trạng thái hoạt động hoặc không hoạt động, mặc định là hoạt động
	2. Tạo bảng Book chứa các thông tin của sách gồm các trường:
		- book_id (Mã sách): gồm 5 ký tự, khóa chính
        - book_name (Tên sách): tối đa 200 ký tự, không null, không trùng lặp
        - book_title (Tiêu đề sách): tối đa 255 ký tự, không null
        - book_content (Nội dung sách): không giới hạn số ký tự
        - book_pages (số trang sách): số nguyên, có giá trị lớn hơn 0
        - book_price (giá sách): số thực, có giá trị lớn hơn 0
        - book_author (tác giả sách): tối đa 150 ký tự, không null
        - book_stock (số lượng sách còn lại): số nguyên, có giá trị lớn hơn hoặc bằng 0
        - book_status (trạng thái sách): số nguyên (0-không bán, 1-đang bán, 2-hết sách)
	3. Một loại sách chứa nhiều quyển sách
    4. Thêm dữ liệu cho mỗi bảng ít nhất 5 dữ liệu
    5. Cập nhật tất cả sách thuộc loại sách có mã là 2 có giá bằng 100000
    6. Cập nhật các sách có số lượng sách còn lại bằng 0 sang trạng thái 2
    7. Xóa các sách có trạng thái là 0
    8. Lấy thông tin sách gồm: mã sách, tên sách, tiêu đề, giá sách
    9. Lấy tất cả thông tin sách có giá nằm trong khoảng từ 50000 đến 90000
    10. Lấy tất cả tác giả đã xuất bản sách
    11. Lấy thông tin sách có trạng thái là đang bán hoặc hết sách gồm mã sách, tên sách, tác giả, số lượng còn lại, trạng thái 
    12. Lấy tất cả thông tin các sách có tác giả tên là Ánh (Tên tác giả gồm họ và tên)
    13. Lấy tất cả thông tin sách đang có số lượng sách nhiều từ thứ 2 đến thứ 5
*/
-- Tạo cơ sở dữ liệu để chứa 2 bảng
create database book_management;
use book_management;
-- 1. Tạo bảng book_type
create table book_type(
	book_type_id int primary key auto_increment,
    book_type_name varchar(100) not null unique,
    book_type_status bit default(1)
);
-- 2. Tạo bảng books
create table books(
	book_id char(5) primary key,
    book_name varchar(200) not null unique,
    book_title varchar(255) not null,
    book_content text,
    book_pages int check(book_pages>0),
    book_price float check(book_price>0),
    book_author varchar(150) not null,
    book_stock int check(book_stock>=0),
    book_status int,
    -- Khai báo cột làm khóa ngoại
    book_type_id int,
    -- Biến cột đó thành khóa ngoại
    foreign key (book_type_id) references book_type(book_type_id)
);
-- 4. Thêm tối thiểu 5 dữ liệu vào mỗi bảng
insert into book_type(book_type_name)
values ('Truyện tranh'), ('Trinh thám'), ('Khoa học viễn tưởng'),('Xuyên không'),('Tiên hiệp');
select * from book_type;
insert into books
values('B0001','Doremon','Truyện tranh Nhật Bản','Đây là nội dung truyện doremon',1000,25,'Fujimoto',10,1,1),
('B0002','Thám tử lừng danh Conan','Truyện tranh Nhật Bản','Đây là nội dung truyện Connan',900,30,'Azama goso',25,0,1),
('B0003','Xuyên không 1','Truyện xuyên không trung quốc','Đây là nội dung truyện xuyên không',7000,5,'Nguyễn Văn Ánh',0,2,4),
('B0004','Tiên hiệp 1','Truyện tiên hiệp 1','Đây là nội dung truyện tiên hiệp',5000,10,'Trần Thị Bình',8,1,5),
('B0005','Tiên hiệp 2','Truyện tiên hiệp 2','Đây là nội dung truyện tiên hiệp',4000,20,'Nguyễn Văn A',20,1,5);
select * from books;
-- 5. Cập nhật tất cả sách thuộc loại sách có mã là 2 có giá bằng 100000
update books
set book_price = 100000
where book_type_id = 2;
select * from books where book_type_id = 2;
-- 6. Cập nhật các sách có số lượng sách còn lại bằng 0 sang trạng thái 2
set sql_safe_updates = 0;
update books
set book_status = 2
where book_stock = 0;
select * from books where book_stock = 0;
-- 7. Xóa các sách có trạng thái là 0
delete from books where book_status = 0;
select * from books where book_status = 0;
-- 8. Lấy thông tin sách gồm: mã sách, tên sách, tiêu đề, giá sách
select b.book_id, b.book_name, b.book_title, b.book_price
from books b;
-- 9. Lấy tất cả thông tin sách có giá nằm trong khoảng từ 50000 đến 90000
select *
from books b
where b.book_price between 50000 and 90000;
-- 10. Lấy tất cả tác giả đã xuất bản sách
select distinct b.book_author
from books b;
-- 11. Lấy thông tin sách có trạng thái là đang bán hoặc hết sách gồm 
-- mã sách, tên sách, tác giả, số lượng còn lại, trạng thái 
select b.book_id, b.book_name, b.book_author, b.book_stock, b.book_status
from books b
where b.book_status in (1,2);
-- 12. Lấy tất cả thông tin các sách có tác giả tên là Ánh (Tên tác giả gồm họ và tên)
select *
from books b
where b.book_author like '%Ánh';
-- 13. Lấy tất cả thông tin sách đang có số lượng sách nhiều từ thứ 2 đến thứ 5
select *
from books b
order by b.book_stock DESC
limit 4 offset 1;

