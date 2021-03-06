--User defined functions have several limitations 
--Basic insert, update, delete test on multiple datanodes using plpgsql function is passing.

--default distributed by HASH(slotname)

create function xl_nodename_from_id1(integer) returns name as $$
declare 
	n name;
BEGIN
	select node_name into n from pgxc_node where node_id = $1;
	RETURN n;
END;$$ language plpgsql;

create table xl_Pline1 (
    slotname	char(20),
    phonenumber	char(20),
    comment	text,
    backlink	char(20)
);

create unique index xl_Pline1_name on xl_Pline1 using btree (slotname bpchar_ops);

--insert Plines
insert into  xl_Pline1 values ('PL.001', '-0', 'Central call', 'PS.base.ta1');
insert into  xl_Pline1 values ('PL.002', '-101', '', 'PS.base.ta2');
insert into  xl_Pline1 values ('PL.003', '-102', '', 'PS.base.ta3');
insert into  xl_Pline1 values ('PL.004', '-103', '', 'PS.base.ta5');
insert into  xl_Pline1 values ('PL.005', '-104', '', 'PS.base.ta6');
insert into  xl_Pline1 values ('PL.006', '-106', '', 'PS.base.tb2');
insert into  xl_Pline1 values ('PL.007', '-108', '', 'PS.base.tb3');
insert into  xl_Pline1 values ('PL.008', '-109', '', 'PS.base.tb4');
insert into  xl_Pline1 values ('PL.009', '-121', '', 'PS.base.tb5');
insert into  xl_Pline1 values ('PL.010', '-122', '', 'PS.base.tb6');
insert into  xl_Pline1 values ('PL.011', '-122', '', 'PS.base.tb6');
insert into  xl_Pline1 values ('PL.012', '-122', '', 'PS.base.tb6');
insert into  xl_Pline1 values ('PL.013', '-122', '', 'PS.base.tb6');
insert into  xl_Pline1 values ('PL.014', '-122', '', 'PS.base.tb6');
insert into  xl_Pline1 values ('PL.015', '-134', '', 'PS.first.ta1');
insert into  xl_Pline1 values ('PL.016', '-137', '', 'PS.first.ta3');
insert into  xl_Pline1 values ('PL.017', '-139', '', 'PS.first.ta4');
insert into  xl_Pline1 values ('PL.018', '-362', '', 'PS.first.tb1');
insert into  xl_Pline1 values ('PL.019', '-363', '', 'PS.first.tb2');
insert into  xl_Pline1 values ('PL.020', '-364', '', 'PS.first.tb3');
insert into  xl_Pline1 values ('PL.021', '-365', '', 'PS.first.tb5');
insert into  xl_Pline1 values ('PL.022', '-367', '', 'PS.first.tb6');
insert into  xl_Pline1 values ('PL.023', '-367', '', 'PS.first.tb6');
insert into  xl_Pline1 values ('PL.024', '-367', '', 'PS.first.tb6');
insert into  xl_Pline1 values ('PL.025', '-367', '', 'PS.first.tb6');
insert into  xl_Pline1 values ('PL.026', '-367', '', 'PS.first.tb6');
insert into  xl_Pline1 values ('PL.027', '-367', '', 'PS.first.tb6');
insert into  xl_Pline1 values ('PL.028', '-501', 'Fax entrance', 'PS.base.ta2');
insert into  xl_Pline1 values ('PL.029', '-502', 'Fax first floor', 'PS.first.ta1');

create function xl_insert_Pline_test(int) returns boolean as $$
BEGIN
	IF $1 < 20 THEN
		insert into  xl_Pline1 values ('PL.030', '-367', '', 'PS.first.tb6');
		insert into  xl_Pline1 values ('PL.031', '-367', '', 'PS.first.tb6');
		insert into  xl_Pline1 values ('PL.032', '-367', '', 'PS.first.tb6');
		insert into  xl_Pline1 values ('PL.033', '-367', '', 'PS.first.tb6');
		insert into  xl_Pline1 values ('PL.034', '-367', '', 'PS.first.tb6');
		insert into  xl_Pline1 values ('PL.035', '-367', '', 'PS.first.tb6');
		insert into  xl_Pline1 values ('PL.036', '-367', '', 'PS.first.tb6');
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;$$ language plpgsql;

select xl_insert_Pline_test(1);

select xl_nodename_from_id1(xc_node_id), * from xl_Pline1 order by slotname;


create function xl_update_Pline_test(int) returns boolean as $$
BEGIN
	IF $1 < 20 THEN
		update xl_Pline1 set phonenumber = '400' where slotname = 'PL.030';
		update xl_Pline1 set phonenumber = '400' where slotname = 'PL.031';
		update xl_Pline1 set phonenumber = '400' where slotname = 'PL.032';
		update xl_Pline1 set phonenumber = '400' where slotname = 'PL.033';
		update xl_Pline1 set phonenumber = '400' where slotname = 'PL.034';
		update xl_Pline1 set phonenumber = '400' where slotname = 'PL.035';
		update xl_Pline1 set phonenumber = '400' where slotname = 'PL.036';
		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;$$ language plpgsql;

select xl_update_Pline_test(1);

select xl_nodename_from_id1(xc_node_id), * from xl_Pline1 order by slotname;

create function xl_delete_Pline_test(int) returns boolean as $$
BEGIN
	IF $1 < 20 THEN
		delete from xl_Pline1 where slotname = 'PL.030';
		delete from xl_Pline1 where slotname = 'PL.031';
		delete from xl_Pline1 where slotname = 'PL.032';
		delete from xl_Pline1 where slotname = 'PL.033';
		delete from xl_Pline1 where slotname = 'PL.034';
		delete from xl_Pline1 where slotname = 'PL.035';
		delete from xl_Pline1 where slotname = 'PL.036';

		RETURN TRUE;
	ELSE
		RETURN FALSE;
	END IF;
END;$$ language plpgsql;

select xl_delete_Pline_test(1);

select xl_nodename_from_id1(xc_node_id), * from xl_Pline1 order by slotname;

drop table xl_Pline1;
drop function xl_nodename_from_id1(integer);

drop function xl_insert_Pline_test(int);
drop function xl_update_Pline_test(int);
drop function xl_delete_Pline_test(int);
