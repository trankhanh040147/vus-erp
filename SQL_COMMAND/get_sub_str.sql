-- APEX ORACLE 23.1.5
-- str = 'header_id=5637212836worker=5637182863 profile=Test TS-R profile_date=12-23-2023 status=1'
-- get header_id value from str

declare 
    str varchar2(1000) := 'header_id=5637212836worker=5637182863 profile=Test TS-R profile_date=12-23-2023 status=1';
    header_id varchar2(100);
begin
    header_id := regexp_substr(str, 'header_id=(\d+)', 1, 1, 'i', 1);
    dbms_output.put_line(header_id);
end;
```