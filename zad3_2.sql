SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SET IMPLICIT_TRANSACTIONS ON;
DBCC USEROPTIONS;

select * from b;

select * from b;
commit;
select * from b;