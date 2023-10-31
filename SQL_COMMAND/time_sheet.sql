begin SP_GET_TIME_SHEET('V01', '10/1/2023', '10/30/2023', '1'); end;

begin INSERT_UPDATE_P_TIME_SHEET(); end;

begin INSERT_UPDATE_P_TIME_SHEET_DETAIL(); end;

delete from EMP_TIME_SHEET;
delete from EMP_TIME_SHEET_LINE
delete from P_TIME_SHEET
delete from P_TIME_SHEET_DETAIL