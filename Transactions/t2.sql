select version();

SELECT * FROM public.accounts;


-- Transaction 101
begin;
	insert into accounts (account_id, customer_name, balance)
	values (3, 'Adam', 200.00);
commit;

select xmin, xmax, account_id, customer_name, balance from public.accounts;

begin;
	update accounts set balance = balance + 100.00
	where account_id = 3;

	select * from accounts
	where account_id = 3;

	delete from accounts
	where account_id = 3;

commit;


begin;
	update accounts set balance = balance - 50.00
	where account_id = 1;

	select * from accounts
	where account_id = 1;

commit;








	