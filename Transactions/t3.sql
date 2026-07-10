select * from public.accounts;
-- where account_id = 3;

begin;
	update accounts set balance = balance - 400.00
	where account_id = 1;

	select * from accounts
	where account_id = 1;

commit;