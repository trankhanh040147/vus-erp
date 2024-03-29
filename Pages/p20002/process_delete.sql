begin
    DELETE FROM SCHOLARSHIP_REQUEST sr
    WHERE :P20002_REQUEST_ID = sr.ID;

    DELETE FROM EMP_REQUESTS emp
    WHERE :P20002_REQUEST_ID = emp.REQUEST_DETAIL_ID AND LOWER(:P20002_FEATURE) = LOWER(REQUEST_TYPE);
end;