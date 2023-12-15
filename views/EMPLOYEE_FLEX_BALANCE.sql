  CREATE OR REPLACE FORCE EDITIONABLE VIEW "EMPLOYEE_FLEX_BALANCE" ("EFB_EMPLOYEE_CODE", "EFB_DATE", "EFB_FLEX_BALANCE", "EFB_FLEX_ACRUAL", "EFB_FLEX_USED") DEFAULT COLLATION "USING_NLS_COMP"  AS 
  SELECT 
    pts.EMPLOYEE_CODE AS EFB_EMPLOYEE_CODE, 
    pts.DATE_TS AS EFB_DATE, 
    (SELECT NVL(SUM(ptsd_2.WT_FLEX),0) FROM P_TIME_SHEET_DETAIL ptsd_2 JOIN P_TIME_SHEET pts_2 ON ptsd_2.TS_HEADER_ID = pts_2.TS_HEADER_ID WHERE pts_2.DATE_TS <= pts.DATE_TS and pts_2.EMPLOYEE_CODE = pts.EMPLOYEE_CODE) AS EFB_FLEX_BALANCE,
    (SELECT NVL(SUM(ptsd_2.WT_FLEX),0) FROM P_TIME_SHEET_DETAIL ptsd_2 JOIN P_TIME_SHEET pts_2 ON ptsd_2.TS_HEADER_ID = pts_2.TS_HEADER_ID WHERE pts_2.DATE_TS <= pts.DATE_TS AND ptsd_2.WT_FLEX > 0 AND pts_2.EMPLOYEE_CODE = pts.EMPLOYEE_CODE) AS EFB_FLEX_ACRUAL,
    (SELECT NVL(SUM(ptsd_2.WT_FLEX),0) FROM P_TIME_SHEET_DETAIL ptsd_2 JOIN P_TIME_SHEET pts_2 ON ptsd_2.TS_HEADER_ID = pts_2.TS_HEADER_ID WHERE pts_2.DATE_TS <= pts.DATE_TS AND ptsd_2.WT_FLEX < 0 AND pts_2.EMPLOYEE_CODE = pts.EMPLOYEE_CODE) AS EFB_FLEX_USED
  FROM P_TIME_SHEET_DETAIL ptsd
  JOIN P_TIME_SHEET pts ON ptsd.TS_HEADER_ID = pts.TS_HEADER_ID;