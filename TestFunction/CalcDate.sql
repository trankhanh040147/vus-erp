DECLARE
    n_TotalDays FLOAT(10);
    n_FromDate DATE;
    n_ToDate DATE;
BEGIN
    n_TotalDays := 5.5;
    n_FromDate := TO_DATE('11/6/2022', 'MM/DD/YYYY');
    n_ToDate := n_FromDate + INTERVAL '1' DAY * FLOOR(n_TotalDays);
    -- print the ToDate
    DBMS_OUTPUT.PUT_LINE('To Date: ' || TO_CHAR(n_ToDate, 'MM/DD/YYYY'));
END;
/
