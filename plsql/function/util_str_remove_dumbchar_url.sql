-- apex oracle 23.2.3
-- write a function to remove any: space, ;
-- from a string

create or replace function remove_space_semicolon(p_string in varchar2) return varchar2
is
  v_string varchar2(32767);
begin

    -- if null, return ''
    if p_string is null then
        return '';
    end if;

    v_string := replace(replace(p_string, ' ', ''), ';', '');
    return v_string;
    end remove_space_semicolon;
/

----------------------------------------------------------------------
----------------------------------------------------------------------
----------------------------------------------------------------------

-- unit testing
declare
  v_string varchar2(32767);
begin
    v_string := 'this is a test; of the function';
    dbms_output.put_line(remove_space_semicolon(v_string));

    -- test null
    v_string := null;
    dbms_output.put_line(remove_space_semicolon(v_string));
end;