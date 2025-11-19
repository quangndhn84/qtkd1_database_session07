/*
	1. Tạo bảng categories gồm các trường sau:
		- catalog_id: int, PK, auto_increment
        - catalog_name: varchar(150), not null, unique
        - catalog_descriptions: text
        - catalog_status bit default(1)
	2. Tạo bảng product gồm các trường sau:
		- product_id: char(5), PK
        - product_name: varchar(200), not null, unique
        - product_price: float, not null check(product_price>0)
        - product_title: text
        - catalog_id: FK
        - catalog_status: bit default(1)
	3. Thêm mỗi bảng từ 5-10 dữ liệu
    4. Cập nhật tất cả các sản phẩm có giá dưới 2000 thành giá 2000
    5. Xóa các sản phẩm thuộc về danh mục có mã là 5
    6. Lấy các sản phẩm có giá trong khoảng từ 10000 - 100000
    7. Lấy các sản phẩm có mã danh mục là 1, 3 hoặc 5
    8. Lấy các sản phẩm có tên sản phẩm bắt đầu là "Sản"
    9. In ra giá trị lớn nhất, nhỏ nhất, trung bình của các sản phẩm
    10. Tính số lượng sản phẩm trong bảng product
    11. Lấy 3 sản phẩm có giá trị lớn nhất
*/

/*
	1. Tạo bảng? bảng đó trong cơ sở dữ liệu nào (Shema)
    2. Cú pháp tạo bảng:
		CREATE TABLE [table_name](
			[column_name] datatype constraints
        )
        constraints:
			- primary key = not null + unique: khóa chính, mỗi bảng phải có 1 khóa chính
            - not null: Không chứa giá trị null (bắt buộc phải có giá trị)
            - unique: duy nhất, không được trùng lặp
            - check(condition of columnName): điều kiện để nhập dữ liệu
            - default (value): giá trị mặc định, khi không đưa dữ liệu vào thì sẽ nhận giá trị value là giá trị mặc định của nó
			- auto_increment (int): tăng tực động
            - foreign key: khóa ngoại - thể hiện liên kết (1-N, 1-1) --> phải tham chiếu tới khóa chính của bảng nào
		script:
			- Statement 1;
            - Statement 2; -> error -> dừng tại câu lệnh 2
            - Statement 3;
            ....
            - Statement N;
*/
-- 1. Tạo cơ sở dữ liệu để chứa các bảng
create database session07_db;
-- 2. Tham chiếu tới CSDL session07_db để làm việc
use session07_db;
-- 3. Tạo bảng categories trên CSDL session07_db
create table categories(
	catalog_id int primary key auto_increment,
    catalog_names varchar(150) not null unique,
    catalog_descriptions text,
    catalog_status bit default(1)
);
-- 4. Tạo bảng product trên CSDL sesion07_db
create table product(
	product_id char(5) primary key,
    product_name varchar(200) not null unique,
    product_price float check(product_price>0),
    product_title text,
    catalog_id int,
    foreign key(catalog_id) references categories(catalog_id),
    product_status bit default(1)
);
-- 5. Thêm 5 dữ liệu cho bảng categories
insert into categories(catalog_names,catalog_descriptions)
values('Quần áo','Mô tả quần áo'),
('Trang sức', 'Mô tả trang sức'),
('Điện thoại','Mô tả điện thoại'),
('Giầy dép','Mô tả giầy dép'),
('Điện tử','Mô tả điện tử');
select * from categories;
-- 6. Thêm 5 dữ liệu vào bảng product
insert into product
values('P0001','Áo sơ mi nam',50,'Áo sơ mi nam',1,1),
('P0002','Váy nữ',80,'Váy nữ',1,0),
('P0003','Dép tổ ong',10,'Dép tổ ong',4,1),
('P0004','vòng cổ kim cương',100000,'Vòng cổ kim cương',2,1),
('P0005','Tivi',15000,'Tivi',5,1);
select * from product;

/*
	SELECT: lấy các dữ liệu gì (bắt buộc sử dụng select)
    FROM: Lấy dữ liệu từ bảng nào
    WHERE: điều kiện để lấy dữ liệu
    GROUP BY: Nhóm dữ liệu theo các tiêu chí
    HAVING: Điều kiện lọc nhóm
    ORDER BY: sắp xêp ASC | DESC
    LIMIT OFFSET: Lấy bao nhiêu dữ liệu và lấy từ đâu
*/
-- 7. Lấy các sản phẩm có giá trong khoảng từ 10000 - 100000
/*
	--> Sử dụng câu lệnh select để lấy dữ liệu từ bảng
		SELECT: lấy tất cả dữ liệu
        FROM: product
        WHERE: price trong khoảng 10000-100000
*/
select *
from product p
where p.product_price between 10000 and 100000;
-- 8. Lấy các sản phẩm có mã danh mục là 1, 3 hoặc 5
/*
	--> Câu lệnh select:
		SELECT: tất cả thông tin
        FROM: product
        WHERE: catalog_id in (1,3,5)
*/
select *
from product p
where p.catalog_id in (1,3,5);
-- 9. Lấy các sản phẩm có tên sản phẩm bắt đầu là "váy" gồm: mã sản phẩm, tên, giá
/*
	select: product_id, product_name, product_price
    from: product
    where: product_name bắt đầu là'váy'
*/
select p.product_id, p.product_name, p.product_price
from product p
where p.product_name like 'váy%';
-- 10.In ra giá trị lớn nhất, nhỏ nhất, trung bình của các sản phẩm
select min(p.product_price) as 'Min_Price', max(p.product_price) as 'Max_price', avg(p.product_price) as 'Avg_price'
from product p;
-- 11. Tính số lượng sản phẩm trong bảng product
select count(p.product_id) as 'Count_product'
from product p;
-- 12. Lấy 3 sản phẩm có giá trị lớn nhất
select *
from product p
order by p.product_price DESC
limit 3;




