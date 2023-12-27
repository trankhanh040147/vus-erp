		-- 1	Need to confirm	10	-	-
		-- 2	Confirmed	2	-	-
		-- 3	In Review	6	-	-
		-- 4	Approved	3	-	-
		-- 5	Rejected	4	-	-
		-- 6	Submitted to HR	12	-	-
		-- 7	Sent to D365	11	-	-
		-- 8	Transferred	9	-	-
declare
    v_start_time NUMBER;
    v_end_time NUMBER;
   header_id nvarchar2(50);
   total_header_id_eligible NUMBER;
begin

  for rec in (select regexp_substr (
           :P44_SELECTED,
           '[^:]+',
           1,
           level
         ) value
  from   dual
  connect by level <= 
    length ( :P44_SELECTED ) - length ( replace ( :P44_SELECTED, ':' ) ) + 1)loop
        -- Approve

        -- output 
        DBMS_OUTPUT.PUT_LINE('rec.value: ' || rec.value);
        DBMS_OUTPUT.PUT_LINE('header_id: ' || header_id);
        DBMS_OUTPUT.PUT_LINE('total_header_id_eligible: ' || total_header_id_eligible);
        
        update P_TIME_SHEET set STATUS = 11 where id = rec.value and STATUS in (12) and rownum = 1;

        SELECT TS_HEADER_ID INTO header_id FROM P_TIME_SHEET where id = rec.value and STATUS in (11) and rownum = 1;
        -- SELECT TS_HEADER_ID INTO header_id FROM P_TIME_SHEET WHERE ID = rec.value;
        -- SELECT COUNT(*) into total_header_id_eligible FROM P_TIME_SHEET where STATUS in (12) and TS_HEADER_ID = header_id;

        -- SP_UPDATE_TIME_SHEET
        -- IF total_header_id_eligible > 0 THEN
            SP_UPDATE_TIME_SHEET(header_id);
        -- END IF;

        v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second
        LOOP
            v_end_time := DBMS_UTILITY.GET_TIME;
            EXIT WHEN (v_end_time - v_start_time) > (3 * 100);  -- 5 seconds
        END LOOP;

    end loop;   

    end;
           
-- SELECT * FROM  P_TIME_SHEET  where id = rec.value and STATUS in (12) and rownum = 1;
