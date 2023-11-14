    declare 
    from_date date;
    -- end_date date;
    total_month number;
    total_day number;
    begin 

        from_date := to_date('1/1/2023', 'MM/DD/YYYY');
        total_month := 6;
        -- calculate without end_date
        total_day := from_date + interval '1' month * total_month - from_date;
        dbms_output.put_line(total_day);

    end;
    /
