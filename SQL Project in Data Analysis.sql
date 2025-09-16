CREATE DATABASE SQL_Project
USE SQL_Project 
go

--What are the top 10 products by total sales (Order_Details x Products).
--هات أعلى 10 منتجات من حيث إجمالي المبيعات (Order_Details × Products).
select
   top 10 P.ProductName ,
   p.ProductID,
   sum(od.Subtotal) AS TotalSales
from dbo.Order_Details$ od
join dbo.Products$ p
on p.ProductID = od.ProductID
group by  P.ProductName ,p.ProductID
order by TotalSales desc;

--Extract the total sales for each year (Orders × Calendar).
--استخرج إجمالي المبيعات لكل سنة (Orders × Calendar).
select
   c.Year ,
   sum(o.OrderTotal) as TotalSales 
from dbo.Orders$ o
join dbo.Calendar$ c
on c.Date =o.OrderDate
group by c.Year
order by c.Year;

--Show the names of customers who have spent more than 100,000 in total since the beginning of 2020.
--اعرض أسماء العملاء اللي صرفوا أكتر من 100,000 إجمالي من بداية 2020.
select 
  c.CustomerID ,
  c.FirstName ,
  c.LastName ,
  sum(o.OrderTotal) as TotalSpent 
from dbo.Customers$ c
join dbo.Orders$ o
on o.CustomerID =c.CustomerID
where o.OrderDate >='2020-01-01'
group by c.CustomerID ,c.FirstName ,c.LastName 
having sum(o.OrderTotal) > 100000
order by TotalSpent desc;

--Find the average salaries of the employees, and determine which employee sold more than the average.
--هات متوسط المرتبات للموظفين، وحدد مين الموظف اللي باع أكتر من المتوسط.
select 
  e.EmployeeID ,
  e.FirstName ,
  e.LastName ,
  e.Salary,
   sum(o.OrderTotal) as TotalSales 
from dbo.Employees$ e
join dbo.Orders$ o
on e.EmployeeID = e.EmployeeID 
group by e.EmployeeID , e.FirstName ,e.LastName , e.Salary 
having e.Salary > (select avg(e.Salary) from dbo.Employees$ e )
order by TotalSales desc;

--Show each country the most sold product category.
--اعرض لكل دولة (Country) أكثر فئة منتجات (Category) تم بيعها.
select 
    c.Country,
	p.Category ,
	sum(od.Subtotal) as TotalSales 
from dbo.Order_Details$ od 
join dbo.Orders$ o
on od.OrderID =o.OrderID
join dbo.Customers$ c
on c.CustomerID = o.CustomerID
join dbo.Products$ p
on p.ProductID = od.ProductID 
group by c.Country , p.Category
order by c.Country, TotalSales desc;

































