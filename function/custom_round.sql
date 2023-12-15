create or replace FUNCTION custom_round(x IN NUMBER) RETURN NUMBER IS
    l_fractional_part NUMBER;
BEGIN
    -- < Rule 1: 0.5 or 1 round. 
    --- Ex: x = 0-->0.49, y = 0; x = 0.5 --> 0.99, y = 1 

    -- Get the fractional part
    -- l_fractional_part := x - TRUNC(x);
    
    -- -- If the fractional part is less than 0.5, round down to the nearest whole number (integer)
    -- IF l_fractional_part < 0.5 THEN
    --     RETURN TRUNC(x);
    -- ELSE
    --     -- If the fractional part is greater than or equal to 0.5, round to the nearest 0.5
    --     RETURN TRUNC(x) + 0.5;
    -- END IF;
    -- > Rule 1: 0.5 or 1 round. 

    -- < Rule 2: Round to 2 decimal
    --- Ex: x = 0.001 --> 0.00, y = 0.01; x = 0.005 --> 0.01, y = 0.01; x = 0.006 --> 0.01, y = 0.01; x = 0.009 --> 0.01, y = 0.01
    return round(x, 2);    
    -- > Rule 2: Round to 2 decimal


END custom_round;
/

-- Test
-- declare 
--     x number;
--     y number;
-- begin
--     x := 0.001;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 0.005;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 0.006;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 0.009;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 0.5;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 0.51;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 0.99;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 1;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 1.01;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 1.5;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 1.51;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 1.99;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 2;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 2.01;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);

--     x := 2.5;
--     y := custom_round(x);
--     dbms_output.put_line('x = ' || x || ', y = ' || y);
-- end;
