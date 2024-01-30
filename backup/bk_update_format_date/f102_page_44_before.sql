prompt --application/set_environment
set define off verify off feedback off
whenever sqlerror exit sql.sqlcode rollback
--------------------------------------------------------------------------------
--
-- Oracle APEX export file
--
-- You should run this script using a SQL client connected to the database as
-- the owner (parsing schema) of the application or as a database user with the
-- APEX_ADMINISTRATOR_ROLE role.
--
-- This export file has been automatically generated. Modifying this file is not
-- supported by Oracle and can lead to unexpected application and/or instance
-- behavior now or in the future.
--
-- NOTE: Calls to apex_application_install override the defaults below.
--
--------------------------------------------------------------------------------
begin
wwv_flow_imp.import_begin (
 p_version_yyyy_mm_dd=>'2023.10.31'
,p_release=>'23.2.1'
,p_default_workspace_id=>18590324116797805
,p_default_application_id=>102
,p_default_id_offset=>0
,p_default_owner=>'WKSP_ERP'
);
end;
/
 
prompt APPLICATION 102 - ERP
--
-- Application Export:
--   Application:     102
--   Name:            ERP
--   Date and Time:   02:00 Thursday January 25, 2024
--   Exported By:     ERP
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 44
--   Manifest End
--   Version:         23.2.1
--   Instance ID:     7949320442804181
--

begin
null;
end;
/
prompt --application/pages/delete_00044
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>44);
end;
/
prompt --application/pages/page_00044
begin
wwv_flow_imp_page.create_page(
 p_id=>44
,p_name=>'Time Sheet Approval'
,p_alias=>'TIME-SHEET-APPROVAL'
,p_step_title=>'Management Time Sheet'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var isHrAdmin = $v(''P44_IS_HR_ADMIN'') == 1;',
'',
'console.log(''hr_admin: '', $v(''P44_IS_HR_ADMIN''))',
'console.log(''hr_admin: '', isHrAdmin)',
'',
'styling_grid();',
'filterCheckboxes();',
'',
'',
'// Click on pagination',
'$(document).on(''click'', ''.a-GV-pageButton'', function () {',
'    console.log(''Clicked on pagination.'');',
'    ',
'    setTimeout(function () {',
'        styling_grid();',
'        filterCheckboxes();',
'    }, 300);',
'});',
'',
'// Style interative grid',
'function styling_grid() {',
'    const tdElements = document.querySelectorAll(''.page-44 .a-GV-table--checkbox tbody td:nth-child(29)'');',
'',
'    tdElements.forEach(td => {',
'        const text = td.textContent.toLowerCase();',
'        console.log(text);',
'        if (text === ''check'') {',
'            td.style.color = ''#ff67ff'';',
'        }',
'    });',
'}',
'',
'// Hide checkbox base on status',
'function filterCheckboxes(){',
'    $(''.req-status'').each(function () {',
'        if ($(this).text() == ''Need to confirm'' || $(this).text() == ''Transferred''',
'            || (!isHrAdmin && $(this).text() == ''Submitted to HR'') || $(this).text() == ''Sent to D365''',
'        ) {',
'            console.log($(this).parent());',
'            $(this).parent().addClass(''disabled'');',
'        }',
'    });',
'}',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* COLOR */',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(8) {',
'  background-color: #D0E0DB !important;',
'}',
'',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(9),',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(10),',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(11),',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(12),',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(13) {',
'  background-color: #E5D2D2 !important;',
'}',
'',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(14),',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(15),',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(16),',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(17), ',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(18) {',
'  background-color: #F9DDDD !important;',
'}',
'',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(24),',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(25),',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(26),',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(27) {',
'  background-color: #E2E7EB !important;',
'}',
'',
'.page-44 .a-GV-table--checkbox tbody td:nth-child(6) {',
'  color: #0000fe !important;',
'}',
'/* COLOR */',
'',
'.a-GV-header .a-GV-headerLabel {',
'  white-space: normal;',
'  text-align: center;',
'}',
'',
'#g_timesheet tbody tr.disabled > th{',
'    pointer-events: none;',
'}',
'#g_timesheet tbody tr.disabled > th > span{',
'    border: none;',
'    background-color: #fff;',
'    /* pointer-events: none; */',
'}',
'#g_timesheet tbody tr td{',
'    /* pointer-events: none; */',
'}',
'#g_timesheet tbody tr td:nth-child(2),#g_timesheet tbody tr td:nth-child(3){',
'    pointer-events: unset;',
'}',
'#g_timesheet tbody tr.disabled > th > span::before{',
'    content: "";',
'}',
'._d-none {',
'    display: none;',
'}',
'/* Hover CSS */',
'#g_timesheet.a-GV-row.is-hover,',
'.a-IRR-table tr:hover td {',
'    background-color: greenyellow;',
'}',
'',
'.a-GV-table tr.is-active .a-GV-cell {',
'',
'    background-color: yellow;',
'',
'}',
'/* Hover CSS */',
'',
'',
'.t-BreadcrumbRegion-buttons .t-Button+.t-Button {',
'    margin-left: 0.7rem;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20240118100827'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(20012266339697229)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18712759415889069)
,p_plug_display_sequence=>1
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(18597660344888957)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(18774898137889124)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(39387194747042007)
,p_plug_name=>'P_TIME_SHEET'
,p_region_name=>'g_timesheet'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>160
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ts.ID,',
'       ts.EMPLOYEE_CODE,',
'       emp.FULL_NAME,',
'       ts.WORKER_ID,',
'       DATE_TS,',
'       ts.PROFILE_ID,',
'       REASON_ADJUSTMENT,',
'       IS_OK,',
'       STATUS,',
'       NOTE,',
'       ts.TS_HEADER_ID,',
'       -- From P_TIME_SHEET_DETAIL',
'       WT_IN1,',
'       WT_OUT1,',
'       WT_IN2,',
'       WT_OUT2,',
'       WT_STANDARD_HOURS,',
'       WT_FLEX,',
'       WT_RUSH,',
'       WT_OT,',
'       EFB_FLEX_BALANCE,',
'       AT_IN1,',
'       AT_OUT1,',
'       AT_IN2,',
'       AT_OUT2,',
'       AT_STANDARD_HOURS,',
'       AT_FLEX,',
'       AT_RUSH,',
'       AT_OT,',
'       IN1_TS_LINE_ID,',
'       OUT1_TS_LINE_ID,',
'       IN2_TS_LINE_ID,',
'       OUT2_TS_LINE_ID,',
'       (select MAX(vst.COMBINED_TIME_RANGES) from view_standard_time vst where vst.PROFILE_ID = REPLACE(TRIM(ts.PROFILE_ID), '' '', '''')) as standard_time,',
'',
'    --     (',
'    --     SELECT ',
'    --         (',
'    --             CASE',
'    --                 WHEN ALL_DAY = ''Y'' THEN 24',
'    --                 WHEN START_TIME IS NOT NULL OR END_TIME IS NOT NULL THEN UTIL_CALC_HOURS(NVL(START_TIME,''00:00''), NVL(END_TIME,''00:00''))     ',
'    --                 ELSE 0',
'    --             END',
'    --         )',
'    --     FROM EMPLOYEE_REQUESTS ',
'    --     WHERE EMPLOYEE_CODE_REQ = ts.EMPLOYEE_CODE',
'    --         AND EMP_REQ_STATUS = 3',
'    --         AND TO_DATE(ts.DATE_TS, ''MM/DD/YYYY'') BETWEEN FROM_DATE AND END_DATE',
'    --     FETCH FIRST 1 ROW ONLY',
'    --     )',
'    --     AS TOTAL_LEAVES_APPROVED,',
'        tsd.APPROVED_LEAVES,',
'        (',
'        SELECT TO_NUMBER(NVL(TOTAL_HOUR_WK,0) + NVL(TOTAL_HOUR_REST_WK,0) + NVL(TOTAL_HOUR_PUBLIC,0)) ',
'        FROM EMP_OVERTIME_REQUESTS eor',
'        JOIN EMP_REQUESTS er ON er.REQUEST_DETAIL_ID = eor.DETAIL_ID',
'        WHERE er.EMPLOYEE_CODE = ts.EMPLOYEE_CODE ',
'        AND eor.CREATED_DATE = TS.DATE_TS',
'        AND ROWNUM = 1',
'        )',
'        AS TOTAL_OT_APPROVED',
'    --    case STATUS',
'    --        when 2 then',
'    --        ''Approve'' ',
'    --        else',
'    --        null',
'    --    end as Approve,',
'    --    case STATUS',
'    --        when 2 then',
'    --        ''Reject'' ',
'    --        else',
'    --        null',
'    --    end as Reject,',
'    --     CASE ',
'    --         WHEN STATUS IN (2, 3, 4) THEN ''Submit to HR''',
'    --         ELSE NULL',
'    --     END as Submit_to_hr,',
'    --    case STATUS',
'    --        when 2 then',
'    --        ''Re-confirm'' ',
'    --        else',
'    --        null',
'    --    end as Reconfirm',
'from P_TIME_SHEET ts ',
'join P_TIME_SHEET_DETAIL tsd on ts.ID = tsd.TS_ID',
'join EMPLOYEES emp on emp.EMPLOYEE_CODE = ts.EMPLOYEE_CODE',
'join EMPLOYEE_FLEX_BALANCE on (emp.EMPLOYEE_CODE = EFB_EMPLOYEE_CODE and DATE_TS = EFB_DATE)',
'where DATE_TS between to_date(:P44_FROM_DATE,''MM/DD/YYYY'') and to_date(:P44_TO_DATE,''MM/DD/YYYY'')',
'AND ( TRIM(:P44_STATUS) = 999  OR STATUS = TRIM(:P44_STATUS) )',
'AND ( TRIM(:P44_OK_CHECK) = 999  OR ts.IS_OK = :P44_OK_CHECK)',
'-- and lower(STATUS) like ''%'' || :P44_STATUS || ''%''',
'-- join WORKING_PROFILE_DETAIL wpd on wpd.PROFILE_ID = ts.PROFILE_ID',
'-- WHERE LOWER(REPLACE(TRIM(wpd.PROFILE_TYPE_ID), '' '', '''')) = ''standardtime'' and START_DAY = 2 and END_DAY = 2 and DAY_OF_WEEK =2;',
'',
'-- join WORKING_PROFILE_LINES wpl on wpl.PROFILE_ID = ts.PROFILE_ID',
'-- WHERE wpl.PROFILE_TYPE_ID = ''standardtime'' and START_DAY = 2 and END_DAY = 2 and DAY_OF_WEEK =2;',
'',
'',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P44_FROM_DATE,P44_TO_DATE,P44_OK_CHECK,P44_STATUS'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'P_TIME_SHEET'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#EEEEEE'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>.5
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#666666'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(39666327831133418)
,p_heading=>'Working Time'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(39666370307133419)
,p_heading=>'Adjust Time'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(21885754465509922)
,p_name=>'TOTAL_OT_APPROVED'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL_OT_APPROVED'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Approved OT'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>420
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(39666327831133418)
,p_use_group_for=>'BOTH'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(21886599330509930)
,p_name=>'APPROVED_LEAVES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APPROVED_LEAVES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Approved Leaves'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>430
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(39666327831133418)
,p_use_group_for=>'BOTH'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(22742541619164404)
,p_name=>'EFB_FLEX_BALANCE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EFB_FLEX_BALANCE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Flex Balance'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>440
,p_value_alignment=>'CENTER'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(22742616159164405)
,p_name=>'STANDARD_TIME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STANDARD_TIME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Standard Time'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>450
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>32767
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39387396177042009)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39390455260042039)
,p_name=>'EMPLOYEE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Employee Code'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>50
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39390549666042040)
,p_name=>'FULL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FULL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Full Name'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>1000
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39390559088042041)
,p_name=>'WORKER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WORKER_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39390695853042042)
,p_name=>'DATE_TS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DATE_TS'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_date_ranges=>'ALL'
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39390842848042043)
,p_name=>'REASON_ADJUSTMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'REASON_ADJUSTMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Reason Adjustment'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>100
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39390932767042044)
,p_name=>'IS_OK'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IS_OK'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'OK/Check'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'STATIC'
,p_lov_source=>'STATIC:Check;0,OK;1'
,p_lov_display_extra=>false
,p_lov_display_null=>false
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
,p_readonly_condition_type=>'ALWAYS'
,p_readonly_for_each_row=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39391013625042045)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Status'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'req-status'
,p_attribute_02=>'LOV'
,p_attribute_05=>'PLAIN'
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(21179884895391143)
,p_lov_display_extra=>true
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39391090605042046)
,p_name=>'NOTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NOTE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Note'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>100
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39391206524042047)
,p_name=>'TS_HEADER_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TS_HEADER_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>130
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39391351295042048)
,p_name=>'WT_IN1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WT_IN1'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'In 1'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'apex_disabled'
,p_group_id=>wwv_flow_imp.id(39666327831133418)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>40
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39391445543042049)
,p_name=>'WT_OUT1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WT_OUT1'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Out 1'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'apex_disabled'
,p_group_id=>wwv_flow_imp.id(39666327831133418)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>40
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39391471176042050)
,p_name=>'WT_IN2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WT_IN2'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'In 2'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'apex_disabled'
,p_group_id=>wwv_flow_imp.id(39666327831133418)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>40
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39391574061042051)
,p_name=>'WT_OUT2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WT_OUT2'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Out 2'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'apex_disabled'
,p_group_id=>wwv_flow_imp.id(39666327831133418)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>40
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39391717512042052)
,p_name=>'WT_STANDARD_HOURS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WT_STANDARD_HOURS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Standard Hours'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'apex_disabled'
,p_group_id=>wwv_flow_imp.id(39666327831133418)
,p_use_group_for=>'BOTH'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39664781192133403)
,p_name=>'WT_FLEX'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WT_FLEX'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Flex'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(39666327831133418)
,p_use_group_for=>'BOTH'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39664889480133404)
,p_name=>'WT_RUSH'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WT_RUSH'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Rush'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>200
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(39666327831133418)
,p_use_group_for=>'BOTH'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39665018841133405)
,p_name=>'WT_OT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WT_OT'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'OT'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>210
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(39666327831133418)
,p_use_group_for=>'BOTH'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39665077790133406)
,p_name=>'AT_IN1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AT_IN1'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_heading=>'In 1'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>220
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(39666370307133419)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
,p_attribute_07=>'0'
,p_attribute_08=>'false'
,p_is_required=>false
,p_max_length=>40
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39665215676133407)
,p_name=>'AT_OUT1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AT_OUT1'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_heading=>'Out 1'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>230
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(39666370307133419)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
,p_attribute_07=>'0'
,p_attribute_08=>'false'
,p_is_required=>false
,p_max_length=>40
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39665340618133408)
,p_name=>'AT_IN2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AT_IN2'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_heading=>'In 2'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>240
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(39666370307133419)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
,p_attribute_07=>'0'
,p_attribute_08=>'false'
,p_is_required=>false
,p_max_length=>40
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39665372392133409)
,p_name=>'AT_OUT2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AT_OUT2'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_heading=>'Out 2'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>250
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(39666370307133419)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
,p_attribute_07=>'0'
,p_attribute_08=>'false'
,p_is_required=>false
,p_max_length=>40
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39665469037133410)
,p_name=>'AT_STANDARD_HOURS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AT_STANDARD_HOURS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Standard Hours'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>260
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'apex_disabled'
,p_group_id=>wwv_flow_imp.id(39666370307133419)
,p_use_group_for=>'BOTH'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_item_css_classes=>'apex_disabled'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39665596558133411)
,p_name=>'AT_FLEX'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AT_FLEX'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Flex'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>270
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'apex_disabled'
,p_group_id=>wwv_flow_imp.id(39666370307133419)
,p_use_group_for=>'BOTH'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_item_css_classes=>'apex_disabled'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
end;
/
begin
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39665739045133412)
,p_name=>'AT_RUSH'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AT_RUSH'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Rush'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>280
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'apex_disabled'
,p_group_id=>wwv_flow_imp.id(39666370307133419)
,p_use_group_for=>'BOTH'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_item_css_classes=>'apex_disabled'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39665804597133413)
,p_name=>'AT_OT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'AT_OT'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'OT'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>290
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'apex_disabled'
,p_group_id=>wwv_flow_imp.id(39666370307133419)
,p_use_group_for=>'BOTH'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_item_css_classes=>'apex_disabled'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39665922426133414)
,p_name=>'IN1_TS_LINE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IN1_TS_LINE_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>300
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39665957973133415)
,p_name=>'OUT1_TS_LINE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OUT1_TS_LINE_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>310
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39666151836133416)
,p_name=>'IN2_TS_LINE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'IN2_TS_LINE_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>320
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39666167126133417)
,p_name=>'OUT2_TS_LINE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'OUT2_TS_LINE_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>330
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39666482730133420)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39666603774133421)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(39666781548133423)
,p_name=>'PROFILE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROFILE_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Profile Time'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>30
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(39387312421042008)
,p_internal_uid=>39387312421042008
,p_is_editable=>true
,p_edit_operations=>'u'
,p_lost_update_check_type=>'VALUES'
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>false
,p_toolbar_buttons=>null
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_auth_scheme=>wwv_flow_imp.id(18803182532889190)
,p_download_filename=>'Time_sheet'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(39648407964095077)
,p_interactive_grid_id=>wwv_flow_imp.id(39387312421042008)
,p_static_id=>'196647'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(39648651645095078)
,p_report_id=>wwv_flow_imp.id(39648407964095077)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(19996605341521211)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(39391351295042048)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>62
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(19997520040521214)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(39391445543042049)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>62
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(19998589387521218)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(39391471176042050)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>62
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(19999587263521221)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>14
,p_column_id=>wwv_flow_imp.id(39391574061042051)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>62
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20000528786521224)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>15
,p_column_id=>wwv_flow_imp.id(39391717512042052)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>69
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20001552067521227)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>16
,p_column_id=>wwv_flow_imp.id(39664781192133403)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>69
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20002611999521230)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>17
,p_column_id=>wwv_flow_imp.id(39664889480133404)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>69
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20003563216521233)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>18
,p_column_id=>wwv_flow_imp.id(39665018841133405)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>69
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20004609229521237)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>22
,p_column_id=>wwv_flow_imp.id(39665077790133406)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>62
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20005535096521240)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>23
,p_column_id=>wwv_flow_imp.id(39665215676133407)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>62
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20006607488521243)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>24
,p_column_id=>wwv_flow_imp.id(39665340618133408)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>62
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20007563146521246)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>25
,p_column_id=>wwv_flow_imp.id(39665372392133409)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>62
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20008559966521249)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>26
,p_column_id=>wwv_flow_imp.id(39665469037133410)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>69
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20009581893521252)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>27
,p_column_id=>wwv_flow_imp.id(39665596558133411)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>69
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20010534272521256)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>28
,p_column_id=>wwv_flow_imp.id(39665739045133412)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>69
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20011581751521259)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>29
,p_column_id=>wwv_flow_imp.id(39665804597133413)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>69
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20012545584521262)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>33
,p_column_id=>wwv_flow_imp.id(39665922426133414)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20013555468521265)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>34
,p_column_id=>wwv_flow_imp.id(39665957973133415)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20014597565521268)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>35
,p_column_id=>wwv_flow_imp.id(39666151836133416)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(20015590485521271)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>36
,p_column_id=>wwv_flow_imp.id(39666167126133417)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(21926256600684657)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>19
,p_column_id=>wwv_flow_imp.id(21885754465509922)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>80.12780000000001
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(22294775097843909)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>20
,p_column_id=>wwv_flow_imp.id(21886599330509930)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>81
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(22803422848762152)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>21
,p_column_id=>wwv_flow_imp.id(22742541619164404)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>80
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(22805245816774619)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(22742616159164405)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>158.01420000000002
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39649031662095081)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(39387396177042009)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39649938280095085)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(39390455260042039)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>103
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39650768546095089)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(39390549666042040)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>159
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39651693407095092)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(39390559088042041)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39652623030095095)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(39390695853042042)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>102
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39653470706095098)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>30
,p_column_id=>wwv_flow_imp.id(39390842848042043)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>231
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39654439120095102)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>31
,p_column_id=>wwv_flow_imp.id(39390932767042044)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>74
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39655307371095105)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(39391013625042045)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>118.078
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39656233847095108)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>32
,p_column_id=>wwv_flow_imp.id(39391090605042046)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>196.333251953125
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39657112498095112)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(39391206524042047)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39710244797175692)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(39666482730133420)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>51
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(39725000904366076)
,p_view_id=>wwv_flow_imp.id(39648651645095078)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(39666781548133423)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>80
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(20001873214483949)
,p_button_sequence=>70
,p_button_name=>'SEARCH'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Search'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-search'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(20002292284483950)
,p_button_sequence=>170
,p_button_name=>'Save'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save'
,p_button_execute_validations=>'N'
,p_icon_css_classes=>'fa-save'
,p_grid_new_row=>'Y'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(20003456256483951)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(20012266339697229)
,p_button_name=>'Approve'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Approve'
,p_button_position=>'PREVIOUS'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(20708480026292549)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(20012266339697229)
,p_button_name=>'Reject'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reject'
,p_button_position=>'PREVIOUS'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(20708581582292550)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(20012266339697229)
,p_button_name=>'Re-confirm'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Re-confirm'
,p_button_position=>'PREVIOUS'
,p_button_execute_validations=>'N'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21550349624728601)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(20012266339697229)
,p_button_name=>'SubmitHR'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit to HR'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:34:&SESSION.::&DEBUG.:::'
,p_button_condition=>'APP_EMP_CODE'
,p_button_condition2=>'2681'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21885960943509924)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(20012266339697229)
,p_button_name=>'Send_D365'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Send to D365'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:33:&SESSION.::&DEBUG.:::'
,p_button_condition=>'SELECT * from EMPLOYEES e where EMPLOYEE_CODE = :APP_EMP_CODE and e.ROLE = 4 -- role C&B Team'
,p_button_condition_type=>'EXISTS'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(20708121591292546)
,p_name=>'P44_SELECTED'
,p_item_sequence=>180
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21885860898509923)
,p_name=>'P44_IS_HR_ADMIN'
,p_item_sequence=>190
,p_item_default=>'SELECT IS_HR_ADMIN FROM EMPLOYEES where :APP_EMP_CODE = EMPLOYEE_CODE'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(27181063000440501)
,p_name=>'P44_DEFAULT_DATE'
,p_item_sequence=>200
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    current_day date;',
'    target_day date;',
'begin',
'    -- current_day := to_date(''25/1/2023'', ''dd/mm/yyyy'');',
'    current_day := to_date(sysdate);',
'',
'    -- target day is the first 23th day of the month before current day',
'    -- sol: if the current_day >= 23, if the current < 23 then the target day is the 23th day of the month before current day',
'',
'    if extract(day from current_day) >= 23 then',
'        target_day := to_date(''23/'' || to_char(current_day, ''mm/yyyy''), ''dd/mm/yyyy'');',
'    else',
'        target_day := to_date(''23/'' || to_char(add_months(current_day, -1), ''mm/yyyy''), ''dd/mm/yyyy'');',
'    end if;',
'',
'    return target_day;',
'',
'    -- print',
'    -- dbms_output.put_line(''Current day: '' || to_char(current_day, ''dd/mm/yyyy''));',
'    -- dbms_output.put_line(''Target day: '' || to_char(target_day, ''dd/mm/yyyy''));',
'end;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    current_day date;',
'    target_day date;',
'begin',
'    -- current_day := to_date(''25/1/2023'', ''dd/mm/yyyy'');',
'    current_day := to_date(sysdate);',
'',
'    -- target day is the first 23th day of the month before current day',
'    -- sol: if the current_day >= 23, if the current < 23 then the target day is the 23th day of the month before current day',
'',
'    if extract(day from current_day) >= 23 then',
'        target_day := to_date(''23/'' || to_char(current_day, ''mm/yyyy''), ''dd/mm/yyyy'');',
'    else',
'        target_day := to_date(''23/'' || to_char(add_months(current_day, -1), ''mm/yyyy''), ''dd/mm/yyyy'');',
'    end if;',
'',
'    return target_day;',
'',
'    -- print',
'    -- dbms_output.put_line(''Current day: '' || to_char(current_day, ''dd/mm/yyyy''));',
'    -- dbms_output.put_line(''Target day: '' || to_char(target_day, ''dd/mm/yyyy''));',
'end;'))
,p_source_type=>'FUNCTION_BODY'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33674052783183995)
,p_name=>'P44_FROM_DATE'
,p_item_sequence=>30
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    current_day date;',
'    target_day date;',
'begin',
'    -- current_day := to_date(''25/1/2023'', ''dd/mm/yyyy'');',
'    current_day := to_date(sysdate);',
'',
'    -- target day is the first 23th day of the month before current day',
'    -- sol: if the current_day >= 23, if the current < 23 then the target day is the 23th day of the month before current day',
'',
'    if extract(day from current_day) >= 23 then',
'        target_day := to_date(''23/'' || to_char(current_day, ''mm/yyyy''), ''dd/mm/yyyy'');',
'    else',
'        target_day := to_date(''23/'' || to_char(add_months(current_day, -1), ''mm/yyyy''), ''dd/mm/yyyy'');',
'    end if;',
'',
'    return target_day;',
'',
'    -- print',
'    -- dbms_output.put_line(''Current day: '' || to_char(current_day, ''dd/mm/yyyy''));',
'    -- dbms_output.put_line(''Target day: '' || to_char(target_day, ''dd/mm/yyyy''));',
'end;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Created date from'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33674103783183996)
,p_name=>'P44_TO_DATE'
,p_item_sequence=>40
,p_item_default=>'TO_DATE(:P44_FROM_DATE,''MM/DD/YYYY'') + interval ''1'' month'
,p_item_default_type=>'EXPRESSION'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'To date'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'ITEM'
,p_attribute_05=>'P44_FROM_DATE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33674171337183997)
,p_name=>'P44_OK_CHECK'
,p_item_sequence=>50
,p_item_default=>'999'
,p_pre_element_text=>'Ok/Check'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'STATIC:All;999,Ok;1,Check;0'
,p_cSize=>30
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(33674369036183998)
,p_name=>'P44_STATUS'
,p_item_sequence=>60
,p_item_default=>'999'
,p_pre_element_text=>'Status'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'STATUS_TIMESHEET'
,p_lov=>'.'||wwv_flow_imp.id(21179884895391143)||'.'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'All'
,p_lov_null_value=>'999'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(20008798491483959)
,p_name=>'Change AT_OUT1,AT_IN1,AT_IN2,AT_OUT2'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_imp.id(39387194747042007)
,p_triggering_element=>'AT_OUT1,AT_IN1,AT_IN2,AT_OUT2'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20009299909483960)
,p_event_id=>wwv_flow_imp.id(20008798491483959)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Calculate AT_FLEX'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'AT_FLEX'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'    start_time_1 DATE;',
'    end_time_1 DATE;',
'    start_time_2 DATE;',
'    end_time_2 DATE;',
'    loop_flex_time_start DATE;',
'    loop_flex_time_end DATE;',
'    total_flex_time NUMBER(5,2) := 0;',
'    cursor c_flex_times is',
'        SELECT TO_DATE(START_TIME, ''HH24:MI'') as flex_start, ',
'               TO_DATE(END_TIME, ''HH24:MI'') as flex_end',
'        FROM WORKING_PROFILE_LINES',
'        WHERE PROFILE_ID = :PROFILE_ID',
'        AND PROFILE_TYPE_ID LIKE ''%flex%'';',
'begin',
'    -- Convert the time strings to DATE data type',
'    start_time_1 := TO_DATE(:AT_IN1, ''HH24:MI'');',
'    end_time_1 := TO_DATE(:AT_OUT1, ''HH24:MI'');',
'    start_time_2 := TO_DATE(:AT_IN2, ''HH24:MI'');',
'    end_time_2 := TO_DATE(:AT_OUT2, ''HH24:MI'');',
'',
'    -- Loop through each flex time and calculate the overlap',
'    for flex_record in c_flex_times loop',
'        loop_flex_time_start := flex_record.flex_start;',
'        loop_flex_time_end := flex_record.flex_end;',
'',
'        IF loop_flex_time_start <= end_time_1 AND loop_flex_time_end >= start_time_1 THEN',
'            total_flex_time := total_flex_time + (LEAST(end_time_1, loop_flex_time_end) - GREATEST(start_time_1, loop_flex_time_start)) * 24;',
'        END IF;',
'',
'        IF loop_flex_time_start <= end_time_2 AND loop_flex_time_end >= start_time_2 THEN',
'            total_flex_time := total_flex_time + (LEAST(end_time_2, loop_flex_time_end) - GREATEST(start_time_2, loop_flex_time_start)) * 24;',
'        END IF;',
'    end loop;',
'',
'    :AT_FLEX := total_flex_time;',
'',
'    return total_flex_time;',
'',
'    -- Output the result',
'    -- DBMS_OUTPUT.PUT_LINE(''Total Flex Time:'' || total_flex_time);',
'end;',
''))
,p_attribute_07=>'AT_IN1,AT_OUT2,AT_OUT1,AT_IN2,PROFILE_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20009713221483961)
,p_event_id=>wwv_flow_imp.id(20008798491483959)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'Calculate  AT_OT'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'AT_OT'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'    start_time_1 DATE;',
'    end_time_1 DATE;',
'    start_time_2 DATE;',
'    end_time_2 DATE;',
'    loop_flex_time_start DATE;',
'    loop_flex_time_end DATE;',
'    total_flex_time NUMBER(5,2) := 0;',
'    cursor c_flex_times is',
'        SELECT TO_DATE(START_TIME, ''HH24:MI'') as flex_start, ',
'               TO_DATE(END_TIME, ''HH24:MI'') as flex_end',
'        FROM WORKING_PROFILE_LINES',
'        WHERE PROFILE_ID = :PROFILE_ID',
'        AND PROFILE_TYPE_ID LIKE ''%ot%'';',
'begin',
'    -- Convert the time strings to DATE data type',
'    start_time_1 := TO_DATE(:AT_IN1, ''HH24:MI'');',
'    end_time_1 := TO_DATE(:AT_OUT1, ''HH24:MI'');',
'    start_time_2 := TO_DATE(:AT_IN2, ''HH24:MI'');',
'    end_time_2 := TO_DATE(:AT_OUT2, ''HH24:MI'');',
'',
'    -- Loop through each flex time and calculate the overlap',
'    for flex_record in c_flex_times loop',
'        loop_flex_time_start := flex_record.flex_start;',
'        loop_flex_time_end := flex_record.flex_end;',
'',
'        IF loop_flex_time_start <= end_time_1 AND loop_flex_time_end >= start_time_1 THEN',
'            total_flex_time := total_flex_time + (LEAST(end_time_1, loop_flex_time_end) - GREATEST(start_time_1, loop_flex_time_start)) * 24;',
'        END IF;',
'',
'        IF loop_flex_time_start <= end_time_2 AND loop_flex_time_end >= start_time_2 THEN',
'            total_flex_time := total_flex_time + (LEAST(end_time_2, loop_flex_time_end) - GREATEST(start_time_2, loop_flex_time_start)) * 24;',
'        END IF;',
'    end loop;',
'',
'    :AT_FLEX := total_flex_time;',
'',
'    return total_flex_time;',
'',
'    -- Output the result',
'    -- DBMS_OUTPUT.PUT_LINE(''Total Flex Time:'' || total_flex_time);',
'end;',
''))
,p_attribute_07=>'AT_IN1,AT_OUT2,AT_OUT1,AT_IN2,PROFILE_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20010283461483961)
,p_event_id=>wwv_flow_imp.id(20008798491483959)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_name=>'Calculate  AT_RUSH'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'AT_RUSH'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'    start_time_1 DATE;',
'    end_time_1 DATE;',
'    start_time_2 DATE;',
'    end_time_2 DATE;',
'    loop_flex_time_start DATE;',
'    loop_flex_time_end DATE;',
'    total_flex_time NUMBER(5,2) := 0;',
'    cursor c_flex_times is',
'        SELECT TO_DATE(START_TIME, ''HH24:MI'') as flex_start, ',
'               TO_DATE(END_TIME, ''HH24:MI'') as flex_end',
'        FROM WORKING_PROFILE_LINES',
'        WHERE PROFILE_ID = :PROFILE_ID',
'        AND PROFILE_TYPE_ID LIKE ''%rush%'';',
'begin',
'    -- Convert the time strings to DATE data type',
'    start_time_1 := TO_DATE(:AT_IN1, ''HH24:MI'');',
'    end_time_1 := TO_DATE(:AT_OUT1, ''HH24:MI'');',
'    start_time_2 := TO_DATE(:AT_IN2, ''HH24:MI'');',
'    end_time_2 := TO_DATE(:AT_OUT2, ''HH24:MI'');',
'',
'    -- Loop through each flex time and calculate the overlap',
'    for flex_record in c_flex_times loop',
'        loop_flex_time_start := flex_record.flex_start;',
'        loop_flex_time_end := flex_record.flex_end;',
'',
'        IF loop_flex_time_start <= end_time_1 AND loop_flex_time_end >= start_time_1 THEN',
'            total_flex_time := total_flex_time + (LEAST(end_time_1, loop_flex_time_end) - GREATEST(start_time_1, loop_flex_time_start)) * 24;',
'        END IF;',
'',
'        IF loop_flex_time_start <= end_time_2 AND loop_flex_time_end >= start_time_2 THEN',
'            total_flex_time := total_flex_time + (LEAST(end_time_2, loop_flex_time_end) - GREATEST(start_time_2, loop_flex_time_start)) * 24;',
'        END IF;',
'    end loop;',
'',
'    :AT_FLEX := total_flex_time;',
'',
'    return total_flex_time;',
'',
'    -- Output the result',
'    -- DBMS_OUTPUT.PUT_LINE(''Total Flex Time:'' || total_flex_time);',
'end;',
''))
,p_attribute_07=>'AT_IN1,AT_OUT2,AT_OUT1,AT_IN2,PROFILE_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
end;
/
begin
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20010752312483961)
,p_event_id=>wwv_flow_imp.id(20008798491483959)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_name=>'Calculate  AT_STANDARD'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'AT_STANDARD_HOURS'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    CURSOR c_flex IS',
'        SELECT TO_DATE(START_TIME, ''HH24:MI'') AS flex_start, ',
'               TO_DATE(END_TIME, ''HH24:MI'') AS flex_end',
'        FROM WORKING_PROFILE_LINES',
'        WHERE PROFILE_TYPE_ID LIKE ''%flex%''',
'        AND PROFILE_ID = :PROFILE_ID;',
'',
'    CURSOR c_standard IS',
'        SELECT TO_DATE(START_TIME, ''HH24:MI'') AS standard_start, ',
'               TO_DATE(END_TIME, ''HH24:MI'') AS standard_end',
'        FROM WORKING_PROFILE_LINES',
'        WHERE PROFILE_TYPE_ID LIKE ''%standardtime%''',
'        AND PROFILE_ID = :PROFILE_ID;',
'',
'    in1 DATE;',
'    out1  DATE;',
'    in2  DATE;',
'    out2  DATE;',
'',
'    total_flex NUMBER(5,2) := 0;',
'    overlap_flex NUMBER(5,2) := 0;',
'    total_standard NUMBER(5,2) := 0;',
'',
'BEGIN',
'',
'    in1 := TO_DATE(:AT_IN1, ''HH24:MI'');',
'    out1 := TO_DATE(:AT_OUT1, ''HH24:MI'');',
'    in2 := TO_DATE(:AT_IN2, ''HH24:MI'');',
'    out2 := TO_DATE(:AT_OUT2, ''HH24:MI'');',
'',
'    FOR r_flex IN c_flex LOOP',
'        IF r_flex.flex_start <= out1 AND r_flex.flex_end >= in1 THEN',
'            total_flex := total_flex + (LEAST(out1, r_flex.flex_end) - GREATEST(in1, r_flex.flex_start)) * 24;',
'            DBMS_OUTPUT.PUT_LINE(''Flex overlap in morning: '' || TO_CHAR(GREATEST(in1, r_flex.flex_start), ''HH24:MI'') || '' - '' || TO_CHAR(LEAST(out1, r_flex.flex_end), ''HH24:MI''));',
'        END IF;',
'        IF r_flex.flex_start <= out2 AND r_flex.flex_end >= in2 THEN',
'            total_flex := total_flex + (LEAST(out2, r_flex.flex_end) - GREATEST(in2, r_flex.flex_start)) * 24;',
'            DBMS_OUTPUT.PUT_LINE(''Flex overlap in evening: '' || TO_CHAR(GREATEST(in2, r_flex.flex_start), ''HH24:MI'') || '' - '' || TO_CHAR(LEAST(out2, r_flex.flex_end), ''HH24:MI''));',
'        END IF;',
'    END LOOP;',
'',
'    FOR r_standard IN c_standard LOOP',
'        IF r_standard.standard_start <= out1 AND r_standard.standard_end >= in1 THEN',
'            total_standard := total_standard + (LEAST(out1, r_standard.standard_end) - GREATEST(in1, r_standard.standard_start)) * 24;',
'            DBMS_OUTPUT.PUT_LINE(''Standard overlap in morning: '' || TO_CHAR(GREATEST(in1, r_standard.standard_start), ''HH24:MI'') || '' - '' || TO_CHAR(LEAST(out1, r_standard.standard_end), ''HH24:MI''));',
'        END IF;',
'        IF r_standard.standard_start <= out2 AND r_standard.standard_end >= in2 THEN',
'            total_standard := total_standard + (LEAST(out2, r_standard.standard_end) - GREATEST(in2, r_standard.standard_start)) * 24;',
'            DBMS_OUTPUT.PUT_LINE(''Standard overlap in evening: '' || TO_CHAR(GREATEST(in2, r_standard.standard_start), ''HH24:MI'') || '' - '' || TO_CHAR(LEAST(out2, r_standard.standard_end), ''HH24:MI''));',
'        END IF;',
'    END LOOP;',
'',
'    -- total_standard := total_standard - overlap_flex;',
'',
'    -- DBMS_OUTPUT.PUT_LINE(''Total Flex Time: '' || total_flex);',
'    -- DBMS_OUTPUT.PUT_LINE(''Total Standard Time: '' || total_standard);',
'',
'    return total_standard;',
'',
'END;'))
,p_attribute_07=>'AT_IN1,AT_OUT2,AT_OUT1,AT_IN2,PROFILE_ID,AT_FLEX,AT_RUSH,AT_OT'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(20007890222483959)
,p_name=>'Click_search'
,p_event_sequence=>60
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(20001873214483949)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20008393576483959)
,p_event_id=>wwv_flow_imp.id(20007890222483959)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Refresh'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(39387194747042007)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(20707998843292544)
,p_name=>'Set selected'
,p_event_sequence=>70
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(39387194747042007)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|interactivegridselectionchange'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20708026675292545)
,p_event_id=>wwv_flow_imp.id(20707998843292544)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'var i, selectedIds="",',
'',
'    model = this.data.model;',
'',
'for ( i = 0; i < this.data.selectedRecords.length; i++ ) {',
'',
'//here you fetch the records of the column you want to pass to the ITEM',
'',
'    selectedIds += ":"+ model.getValue( this.data.selectedRecords[i], "ID") ;',
'',
'}',
'',
'//your item to be set on click in the IG',
'selectedIds = selectedIds.substring(1);',
'$s("P44_SELECTED",selectedIds);'))
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(20000719146483941)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(39387194747042007)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'P_TIME_SHEET - Save Interactive Grid Data'
,p_attribute_01=>'TABLE'
,p_attribute_03=>'P_TIME_SHEET_DETAIL'
,p_attribute_05=>'Y'
,p_attribute_06=>'N'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(19683541246649526)
,p_only_for_changed_rows=>'N'
,p_process_success_message=>'Success!'
,p_internal_uid=>20000719146483941
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(20708288074292547)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Approve_selected'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  for rec in (select regexp_substr (',
'           :P44_SELECTED,',
'           ''[^:]+'',',
'           1,',
'           level',
'         ) value',
'  from   dual',
'  connect by level <= ',
'    length ( :P44_SELECTED ) - length ( replace ( :P44_SELECTED, '':'' ) ) + 1)loop',
'        -- Approve',
'        update P_TIME_SHEET set STATUS = 3, IS_OK = 1 where id = rec.value and STATUS in (2,6) ;',
'    end loop;',
'',
'',
'    end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(20003456256483951)
,p_internal_uid=>20708288074292547
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21550516515728603)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Reject_selected'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  for rec in (select regexp_substr (',
'           :P44_SELECTED,',
'           ''[^:]+'',',
'           1,',
'           level',
'         ) value',
'  from   dual',
'  connect by level <= ',
'    length ( :P44_SELECTED ) - length ( replace ( :P44_SELECTED, '':'' ) ) + 1)loop',
'        -- Approve',
'        update P_TIME_SHEET set STATUS = 4, IS_OK = 1 where id = rec.value and STATUS in (2,6) ;',
'    end loop;',
'',
'',
'    end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(20708480026292549)
,p_internal_uid=>21550516515728603
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21550878738728606)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Reconfirm_selected'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  for rec in (select regexp_substr (',
'           :P44_SELECTED,',
'           ''[^:]+'',',
'           1,',
'           level',
'         ) value',
'  from   dual',
'  connect by level <= ',
'    length ( :P44_SELECTED ) - length ( replace ( :P44_SELECTED, '':'' ) ) + 1)loop',
'        -- Approve',
'        update P_TIME_SHEET set STATUS = 10 where id = rec.value and STATUS in (2,6) ;',
'    end loop;',
'',
'',
'    end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(20708581582292550)
,p_internal_uid=>21550878738728606
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21550928261728607)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SubmitHR'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'  for rec in (select regexp_substr (',
'           :P44_SELECTED,',
'           ''[^:]+'',',
'           1,',
'           level',
'         ) value',
'  from   dual',
'  connect by level <= ',
'    length ( :P44_SELECTED ) - length ( replace ( :P44_SELECTED, '':'' ) ) + 1)loop',
'        -- Approve',
'        update P_TIME_SHEET set STATUS = 12 where id = rec.value and STATUS in (3,4) ;',
'    end loop;',
'',
'',
'    end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(21550349624728601)
,p_internal_uid=>21550928261728607
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21886082604509925)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send_D365'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'		-- 1	Need to confirm	10	-	-',
'		-- 2	Confirmed	2	-	-',
'		-- 3	In Review	6	-	-',
'		-- 4	Approved	3	-	-',
'		-- 5	Rejected	4	-	-',
'		-- 6	Submitted to HR	12	-	-',
'		-- 7	Sent to D365	11	-	-',
'		-- 8	Transferred	9	-	-',
'declare',
'   v_start_time NUMBER;',
'   v_end_time NUMBER;',
'   header_id nvarchar2(50);',
'   total_header_id_eligible NUMBER;',
'   o_status NUMBER;',
'begin',
'',
'  for rec in (select regexp_substr (',
'           :P44_SELECTED,',
'           ''[^:]+'',',
'           1,',
'           level',
'         ) value',
'  from   dual',
'  connect by level <= ',
'    length ( :P44_SELECTED ) - length ( replace ( :P44_SELECTED, '':'' ) ) + 1)loop',
'        -- Approve',
'',
'        -- output ',
'        DBMS_OUTPUT.PUT_LINE(''rec.value: '' || rec.value);',
'        -- DBMS_OUTPUT.PUT_LINE(''header_id: '' || header_id);',
'        -- DBMS_OUTPUT.PUT_LINE(''total_header_id_eligible: '' || total_header_id_eligible);',
'        ',
'        SELECT TS_HEADER_ID INTO header_id FROM P_TIME_SHEET where id = to_number(rec.value) and STATUS in (12) and rownum = 1;',
'        SP_UPDATE_TIME_SHEET(header_id, o_status);',
'        -- update P_TIME_SHEET set STATUS = 11 where id = rec.value and STATUS in (12) and rownum = 1;',
'        ',
'        if o_status = 1 then',
'            update P_TIME_SHEET set STATUS = 11 where TS_HEADER_ID = header_id;',
'        else ',
'            -- raise error',
'            raise_application_error(-20001, ''Send time sheet to D365 failed, check log for details'');',
'        end if;',
'',
'        -- SELECT COUNT(*) into total_header_id_eligible FROM P_TIME_SHEET where STATUS in (12) and TS_HEADER_ID = header_id;',
'',
'',
'        -- SP_UPDATE_TIME_SHEET',
'        -- IF total_header_id_eligible > 0 THEN',
'            -- SP_UPDATE_TIME_SHEET(header_id);',
'        -- END IF;',
'',
'        v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second',
'        LOOP',
'            v_end_time := DBMS_UTILITY.GET_TIME;',
'            EXIT WHEN (v_end_time - v_start_time) > (3 * 100);  -- 5 seconds',
'        END LOOP;',
'',
'    end loop;',
'',
'',
'    end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(21885960943509924)
,p_internal_uid=>21886082604509925
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
