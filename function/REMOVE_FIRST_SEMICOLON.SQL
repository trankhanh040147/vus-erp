create or replace function remove_first_semicolon(str varchar2) return varchar2 is
    l_str varchar2(4000); -- Declare a local variable
begin
    if str is null or length(str)=0 then
        return 'null';
    end if;
    l_str := str; -- Assign the parameter value to the local variable
    if instr(l_str, ';') = 1 then
        l_str := substr(l_str, 2);
    end if;
    return l_str;
end;
/