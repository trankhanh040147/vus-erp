SELECT
  n_start_date := CASE WHEN apex_json.get_varchar2('[%d].StartDate', i) LIKE '%1900-01-01%' THEN NULL ELSE TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].StartDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY') END;

FROM EMPLOYEES
WHERE USER_NAME = :APP_USER_NAME;

