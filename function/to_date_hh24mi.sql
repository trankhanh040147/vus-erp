create or replace function to_date_hh24mi(in1 varchar2) return date is
    out1 date;
begin
    if in1 = '24:00' then
        out1 := to_date('23:59', 'HH24:MI');
    else
        out1 := to_date(in1, 'HH24:MI');
    end if;
    return out1;
end;

--testing
select to_char(to_date_hh24mi('23:00'), 'HH24:MI') from dual;
``` 