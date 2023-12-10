-- lower(substr(DEPARTMENT_ID, instr(DEPARTMENT_ID, '_')+1))
create or replace function get_departmentname_from_departmentid(p_department_id in varchar2) return NVARCHAR2 is
begin
  return substr(p_department_id, instr(p_department_id, '_')+1);
end;