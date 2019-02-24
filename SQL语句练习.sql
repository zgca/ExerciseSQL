 --- 数据库的操作

	-- SQL 语句最后要有分号；；；结尾
	-- 不区分大小写
	-- SQL语句可以分行写

	-- 链接数据库
	mysql -uroot -pmysql
	mysql -uroot -p

	-- 退出数据库
	exit/quit/ctrl+D

	-- 显示数据库版本
	select version();

	-- 显示数据库当前时间
	select now();

	-- 查看当前所有数据库
	show databases;

	-- 创建数据库
	-- create database 数据库名称；
	create database python01;
	create database python02 charset=utf8;

	-- 查看创建数据库细节
	-- show create database 数据库名称；
	show create database python01;

	-- 删除数据库（验证）
	drop database python01;
	drop database `python-04`; --tab 上面那个键

	-- 查看当前使用的数据库
	select database();

	-- 使用数据库
	use python01;

--- 数据表的操作
	
	-- desc 数据表的名字

	-- 查看当前数据库中所有的表
	show tables;

	-- 创建表
	-- auto_increment 表示自动增长
	-- not null 表示不能为空
	-- primary key 表示主键
	-- create table 数据表名字 (字段 类型 约束[, 字段 类型 约束]);
	create table xxxx(id int, name varchar(30));
	create table yyyy(
		id int primary key not null auto_increment,
	 	name varchar(30)
	);

	-- 查询表结构
	desc xxxx;

	-- 如果SQL语句长，应在别的地方写好，拷贝执行

	--  创建students表 (id ,name, age, high, gender, cls_id)
	--  最后一个不能加逗号
	
	create table students(
		id int unsigned not null auto_increment primary key,
		name varchar(30),
		age tinyint unsigned default 0,
		high decimal(5,2),
		gender enum("男", "女"， "中"， "保密") default "男",
		cls_id int unsigned
	);

	-- 创建 classes表
	create table classes(
		id int unsigned not null auto_increment primary key,
		name varchar(30)
	);

	-- 查看创建数据表的流程
	
	
	-- 查看表的创建语句
	show create table students;


	-- 修改表-修改字段：重命名字段
	-- alter table 表名 change 原名 新名 类型及约束
	alter table students add birthday datetime;
	alter table students modify birthday date;
	alter table students change birthday birth date default "1997-01-01";

	-- 修改表-删除字段
	-- alter table 表名 drop 列名;
	alter table students drop high;

	-- 删除表
	drop table xxxx;

--- 增删改查curd
	-- 增加
		-- 全列插入
		-- insert [into] 表名 values(...);
		-- 主键字段 可以用 0 null default 来占位
		-- 向classes表中插入一个班级

		+--------+-----------------------+------+-----+------------+----------------+
		| Field  | Type                  | Null | Key | Default    | Extra          |
		+--------+-----------------------+------+-----+------------+----------------+
		| id     | int(10) unsigned      | NO   | PRI | NULL       | auto_increment |
		| name   | varchar(30)           | YES  |     | NULL       |                |
		| age    | tinyint(3) unsigned   | YES  |     | 0          |                |
		| gender | enum('male','female') | YES  |     | male       |                |
		| cls_id | int(10) unsigned      | YES  |     | NULL       |                |
		| birth  | date                  | YES  |     | 2000-01-01 |                |
		+--------+-----------------------+------+-----+------------+----------------+

		insert into classes values(0, "菜鸟");
		-- 主键可以使用0 ，null ， default
		-- enum可以使用数字从1开始
		insert into students values(0, "小李飞刀", 20, "female", 1, "1992-01-01");
		insert into students values(null, "小李飞刀", 20, "female", 1, "1992-01-01");
		insert into students values(default, "小李飞刀", 20, "female", 1, "1992-01-01");
		insert into students values(default, "小李飞刀", 20, "female", 1, "1992-01-01");

		-- 部分插入
		-- insert into 表名(列...) values(列值....);
		insert into students (name, gender) values("小乔", 2);


		-- 多行插入
		insert into students (name, gender) values("大乔",2), ("貂蝉", 2);
	
	-- 修改
		-- update 表名 set 列1 = 值1, 列2=值2 ,..... where 条件;
		-- 没有条件全部修改
		update students set age=22, gender=2 where id=2;

	-- 查询
		-- 查询所有列
		select * from students;

		-- 指定条件查询
		-- where 条件1 [and, or] 条件2,...
		select * from students where id>3;
		select * from students where name="小李飞刀";

		-- 查询指定列
		-- select name,gender from students;
		select name,gender from students;

		-- 可以使用as为列或表指定别名
		select name as 姓名,gender as 性别 from students;

		-- 字段的顺序
		-- 查询顺序按照自己的顺序
		select gender as 性别,name as 姓名 from students;

	-- 删除数据
		-- 物理删除
		delete from students; -- 整个数据表中的数据全部删除

		delete from students where name="laoli";

		-- 逻辑删除
		-- 用一个字段表示，这条信息已经不能用了
		-- 给students表添加一个is_delete字段bit类型
		alter table students add is_delete bit default 0;
		update students set is_delete=1 where id=5;

-- 重点查询
	-- 查询所有字段
	select * from students;

	-- 可以通过as给表起别名
	select name as 姓名,gender as 性别 from students;
	select students.name, students.gender from students;
	select s.name, s.gender from students as s;

	-- 消除重复行 
	select distinct gender from stuents;

	-- 条件查询，只要是表中的字段就可以用，不用在乎是否筛选出来
		-- 比较运算符
			-- > >= < <= == !=
			select * from students where age>18;

	-- 逻辑运算符
		-- and
		select * from students where age<18 and age<28;
		select * from students where age>18 and gender="female";

		-- or
		select * from students where age>28 or gender="female";

		-- not 解决优先级问题，直接用括号解决
		select * from students where not (age>18 and gender="female");

	-- 模糊查询
		-- like
		-- % 替换1个或者多个
		-- _ 替换1个
		-- 查询姓名中 以lao开始的名字
		select * from students where name like "小%";
		select * from students where name like "%小%";

		-- 查询有2个字的名字
		select * from students where name like "__";

		-- 查询至少有两个字名字
		select * from students where name like "__%";

		-- rlike 正则
		-- 查询以 周开始的姓名
		select * from students where name rlike "^周.*";
		select * from students where name rlike "^周.*伦$";


	-- 范围查询
		-- in（1,3,5）表示在一个非连续的范围内
		-- 查询 年龄为18、34的姓名
		select * from students where age=18 or age=34;
		select * from students where age=18 or age=34 or age=12;
		select * from students where age in (12, 18, 34);

		-- not in 不连续的范围之内
		-- 年龄不是 18、34岁之间的信息
		select name,age from students where age not in (12, 18, 34);

		-- between ... and ... 表示在一个连续范围内
		-- 查询 年龄在18到28岁之间的信息
		select name,age from students where age between 18 and 28;

		-- not between ... and ... 表示不在一个连续范围内
		-- 查询 年龄不在18到28岁之间的信息
		select * from students where age not between 18 and 28;
		select * from students where not age between 18 and 28;

	-- 空判断
		-- 判空 is null
		-- 查询身高为空的信息
		select * from students where high is null;

		-- 判断是否不为空 is not null
		select * from students where high is not null;

	-- 排序
		-- order by 字段
		-- asc从小到大排列，升序
		-- desc从大到小排序，降序
		select * from students where (age between 18 and 28) and gender=1 order by age asc;
		select * from students where (age between 18 and 28) and gender=1 order by age desc;

		-- 查询年龄在18到28岁之间的女性，身高从高到矮排序
		select * from students where (age between 18 and 28) and gender=2 order by high desc;

		-- order by 支持多个字段
		select * from students where (age between 18 and 28) and gender=2 order by high desc, age desc

-- 聚合函数
	-- 总数
	-- count
	select count(*) as 男性人数 from students where gender=1;

	-- 最大值
	-- max
	select max(age) as 年龄最大值 from students;

	-- min
	select min(high) as 身高最小 from students;

	-- sum
	select sum(age) from students;

	-- avg
	select avg(age) from students;

	-- 四舍五入 round(123.23, 1)
	select round(sum(age)/count(*), 2) from students;

-- 分组（和聚合函数一起用）
	-- group by
	-- 按照性别分组，查询所有性别
	select name from students group by gender;
	select * from students group by gender;
	select gender from students group by gender;

	-- 计算男性的人数
	select gender, count(*) from students where gender=1 group by gender;

	-- group_concat(...)
	-- 查询同种性别中的姓名
	select gender, group_concat(name) from students where gender=1 group by gender;
	select gender, group_concat(name, age, id) from students where gender=1 group by gender;
	select gender, group_concat(name, "_", age," ", id) from students where gender=1 group by gender;

	-- having
	-- 查询平均年龄超过30岁的性别的分组，以及显示姓名
	select gender ,group_concat(name) from students group by gender having avg(age)>30;

	-- 查询性别分组中超过2个的分组
	select gender, group_concat(name) from students group by gender having count(*)>2;

-- 分页
	-- limit start（开始）, count（显示个数）
	-- limit count 直接就是显示多少个
	-- 限制查询出来的数据的显示的个数
	select * from students where gender=1 limit 2;
	select * from students limit 5;

	 
	-- 查询前5个数据 京东数据库
	-- 查询id6-10（包含）的顺序
	-- 每页显示2个，第一个页面
	-- 每页显示2个，第二个页面 limit （第几页-1）*每页的个数，每页的个数
	select * from students limit 0, 5;
	select * from students limit 1, 5;

	-- 失败的 select * from students limit 2*(6-1),2;

	-- ***limit永远在最后面


-- 链接查询,多个表的连接查询
	-- 内链接交集，查询多个数据表共有的部分
	-- inner join ... on 条件
	-- 查找所有学生的班级
	select * from students as s inner join classes as c on s.cls_id=c.id;

	-- 按照要求显示姓名、班级
	select students.*, classes.name from students inner join classes on students.cls_id=classes.id;
	select students.name, classes.name from students inner join classes on students.cls_id=classes.id;

	-- 给数据表起名字
	select s.name, c.name from students as s inner join classes as c on s.cls_id=c.id;

	-- 外链接
	-- left join
	-- 以左边的表为基准，找两个表的相同，如果不同则置为null
	select * from students as s left join classes as c on s.cls_id=c.id;

	-- right join 很少使用，只需要将两个表的顺序调换，在使用left join即可


	-- 查询没有对应班级的学生的信息
	-- 注意：要有一个表思想，查询出来的是个新表，还是在原来的基础上做操作呢
	select * from students as s left join classes as c on s.cls_id=c.id where s.cls_id is null;
	select * from students as s left join classes as c on s.cls_id=c.id having s.cls_id is null;

-- 自关联
	-- 一个表里的字段的数据是另一个字段里的值
	-- 全国省市县关系，一张表
	-- 公司人员职务上下级关系表
	select * from areas where pid is null;
	-- 查找山东的aid
	select aid from areas where atitle="山东省";
	-- 查找山东所有的市
	select * from areas where pid=370000;
	-- 查找青岛所有的区
	select * from areas where pid=370200;

	-- 如何要一步搞定
	select * from areas as province inner join areas as city on city.pid=province.aid having province.atitle="山东省"；
	select province.atitle, city.atitle from areas as province inner join areas as city on city.pid=province.aid having province.atitle="山东省"；

-- 子查询,效率比较低，尽量不要用
	-- 标量子查询（select语句中嵌套另一个子select语句，先执行子select语句）
	-- 查询最高的男生的信息
	select * from students where height=(select max(height) from students);

	-- 列级子查询
	-- 查询学生的班级号能够对应的学生信息
	select * from students where cls_id in (select id from classes);























