-- apex oracle 23.1.5
declare
str varchar2(1000);
begin
    str := ';abcd';
    -- remove ';' from the the head if exists
    if instr(str, ';') = 1 then
        str := substr(str, 2);
    end if;
    dbms_output.put_line(str);
end;

-- function remove first ;
create or replace function remove_first_semicolon(str varchar2) return varchar2 is
    l_str varchar2(4000); -- Declare a local variable
begin
    l_str := str; -- Assign the parameter value to the local variable
    if instr(l_str, ';') = 1 then
        l_str := substr(l_str, 2);
    end if;
    return l_str;
end;

-- test function
declare
    str varchar2(1000);
begin
    str := ';abcd';
    dbms_output.put_line(remove_first_semicolon(str));
end;
```
