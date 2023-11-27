declare
    current_day date;
    target_day date;

begin
    -- current_day := to_date('22/1/2023', 'dd/mm/yyyy');
    current_day := to_date(sysdate);

    -- target day is the first 23th day of the month before current day
    -- sol: if the current_day >= 23, if the current < 23 then the target day is the 23th day of the month before current day

    if extract(day from current_day) >= 23 then
        target_day := to_date('23/' || to_char(current_day, 'mm/yyyy'), 'dd/mm/yyyy');
    else
        target_day := to_date('23/' || to_char(add_months(current_day, -1), 'mm/yyyy'), 'dd/mm/yyyy');
    end if;


    -- print
    dbms_output.put_line('Current day: ' || to_char(current_day, 'dd/mm/yyyy'));
    dbms_output.put_line('Target day: ' || to_char(target_day, 'dd/mm/yyyy'));
end;