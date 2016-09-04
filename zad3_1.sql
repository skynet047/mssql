SET TRANSACTION ISOLATION LEVEL READ COMMITTED;
SET IMPLICIT_TRANSACTIONS ON;
DBCC USEROPTIONS;


insert into b values(1);
select * from b;

select * from b;
commit;
select * from b;