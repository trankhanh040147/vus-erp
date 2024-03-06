-- declare array of string in plsql
-- example for: add, remove, check exist, find value in array
declare
    type array_t is table of varchar2(100) index by binary_integer;
    array array_t;
    array_size number := 0;
    array_index number := 0;
    array_value varchar2(100);
    array_value_index number := 0;
begin
    -- insert 
    array_size := array_size + 1;
    array(array_size) := 'value1';
    array_size := array_size + 1;
    array(array_size) := 'value2';

    -- check exist
    if array.exists(1) then
        dbms_output.put_line('exist');
    else
        dbms_output.put_line('not exist');
    end if; 

    -- find value in array
    for i in 1..array_size loop
        if array(i) = 'value1' then
            array_value_index := i;
            exit;
        end if;
    end loop;

    -- remove
    if array_value_index > 0 then
        for i in array_value_index..array_size-1 loop
            array(i) := array(i+1);
        end loop;
        array_size := array_size - 1;
    end if;

    -- print
    for i in 1..array_size loop
        dbms_output.put_line(array(i));
    end loop;

end;
-- https://stackoverflow.com/questions/1471212/how-to-declare-array-and-add-remove-elements-in-pl-sql
-- https://stackoverflow.com/questions/1471212/how-to-declare-array-and-add-remove-elements-in-pl-sql/1471245#1471245
