DECLARE
    column_value NVARCHAR2(255);  -- Variable for column value
    table_name NVARCHAR2(30) := 'EMPLOYEES';  -- Table name
    column_name NVARCHAR2(30);  -- Column name
    n_column_value NVARCHAR2(200); -- value to search for
    query_str VARCHAR2(1000);  -- String for dynamic SQL
BEGIN
    -- Assuming :column_name_entered is a bind variable that holds the user-entered column name
    column_name := :column_name_entered;
    n_column_value := :column_value_entered;

    -- Prepare dynamic SQL query
    query_str := 'SELECT ' || column_name || 
                 ' FROM ' || table_name || 
                --  ' WHERE ' || column_name || ' = ''1617'' AND ROWNUM = 1';
                 ' WHERE ' || column_name || ' = ' || n_column_value || ' AND ROWNUM = 1';

    -- Execute dynamic SQL query
    EXECUTE IMMEDIATE query_str INTO column_value;

    -- Output the result
    DBMS_OUTPUT.PUT_LINE(column_value);

    -- -- Select column name information
    -- FOR col_rec IN (SELECT column_name
    --                 FROM all_tab_columns
    --                 WHERE table_name = UPPER(table_name)
    --                   AND column_name = UPPER(column_name)) LOOP
    --     column_value := col_rec.column_name;
    --     DBMS_OUTPUT.PUT_LINE(column_value);  -- Example output
    -- END LOOP;

    -- The commented-out loop for column name information is not needed for this specific query
END;