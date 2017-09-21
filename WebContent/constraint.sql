select * from all_constraints where owner = 'SWDASHBOARD';
select * from all_cons_columns  where owner = 'SWDASHBOARD' and constraint_name= 'FK_TEST_CHILD';


select * from all_constraints where owner = 'SWDASHBOARD' and constraint_type = 'R';
select * from all_cons_columns  where owner = 'SWDASHBOARD' and constraint_name= 'SYS_C00264265';


select * from all_constraints where owner = 'SOLUTIONPMS' and constraint_type = 'P';
--//pk info
select 	
	con.table_name,
	con.constraint_name,
	col.column_name,
	col.position
from all_constraints con
left outer join all_cons_columns col
	on con.owner = col.owner
	and con.constraint_name = col.constraint_name
where  con.owner = 'SOLUTIONPMS' and con.constraint_type = 'P'
and con.table_name not like  'BIN$%'
order by con.table_name, col.position;

--//column info
select
	t.table_name,
	c.column_name,
	c.data_type,
	c.data_length,
	c.data_precision,
	c.data_scale,
	c.nullable,
	c.column_id
from all_tables  t
left outer join all_tab_cols c
	on t.owner = c.owner 
	and t.table_name = c.table_name
where t.owner = 'SOLUTIONPMS'
and t.table_name not like  'BIN$%'
order by t.table_name, c.column_id


