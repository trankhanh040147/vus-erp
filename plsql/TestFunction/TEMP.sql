DECLARE
    n_AllDay NVARCHAR2(100);

BEGIN
    DBMS_OUTPUT.PUT_LINE('To Date: ' || TO_CHAR(n_ToDate, 'MM/DD/YYYY'));
END;
/
