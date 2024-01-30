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
--   Date and Time:   01:57 Monday January 29, 2024
--   Exported By:     ERP
--   Flashback:       100
--   Export Type:     Page Export
--   Manifest
--     PAGE: 29
--   Manifest End
--   Version:         23.2.1
--   Instance ID:     7949320442804181
--

begin
null;
end;
/
prompt --application/pages/delete_00029
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>29);
end;
/
prompt --application/pages/page_00029
begin
wwv_flow_imp_page.create_page(
 p_id=>29
,p_name=>'Overtime Request for Employee'
,p_alias=>'OVERTIME-REQUEST-FOR-EMPLOYEE'
,p_page_mode=>'MODAL'
,p_step_title=>'Overtime Request'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// $(''#P29_TOTAL_DAY_OFF_CONTAINER'').hide();',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.apex-item-group.apex-item-group--textarea{',
'    padding:0 !important;',
'}',
'textarea{',
'    height:-webkit-fill-available;',
'    padding: 0 !important;',
'    min-height: 0 !important;',
'}',
'._left{',
'    justify-content: flex-end;',
'}',
'.t-Form-labelContainer label{',
'    padding: 8px !important;',
'    font-size: 0.875rem !important;',
'}',
'.apex-item-wrapper--textarea .t-Form-inputContainer{',
'    width: 90%;',
'}',
'button:not(.t-Button--danger) span{',
'    color: #222;',
'}',
'.page-29 body .t-Form-itemWrapper > div.radio_group{',
'    margin-top: 0 !important;',
'    border: none !important;',
'}',
'.page-29 body .t-Form-itemWrapper input[type="radio"]{',
'    position: absolute;',
'}',
'#P29_TOTAL_DAY_OFF_CONTAINER > .t-Form-labelContainer {',
'    width: 160px;',
'}',
'button:not(.t-Button--danger) span {',
'    font-weight: 500;',
'}'))
,p_step_template=>wwv_flow_imp.id(18619045443888994)
,p_page_template_options=>'#DEFAULT#:ui-dialog--stretch'
,p_dialog_width=>'750'
,p_protection_level=>'C'
,p_page_component_map=>'18'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20240103091653'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(14190602475482548)
,p_plug_name=>'Bottom group button'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>50
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(18704424886964704)
,p_plug_name=>'Container'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(18710165183889068)
,p_plug_display_sequence=>20
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(13577174188760718)
,p_plug_name=>'Info'
,p_parent_plug_id=>wwv_flow_imp.id(18704424886964704)
,p_region_template_options=>'#DEFAULT#:t-Form--stretchInputs:t-Form--leftLabels'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(13577754331760724)
,p_plug_name=>'Detail'
,p_parent_plug_id=>wwv_flow_imp.id(13577174188760718)
,p_region_template_options=>'#DEFAULT#:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>30
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(13578108736760728)
,p_plug_name=>'Report'
,p_region_name=>'ontoor'
,p_parent_plug_id=>wwv_flow_imp.id(13577754331760724)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with temp as (',
'    select ',
'    case when CONVERT_TYPE = ''Money''',
'    then 0 else',
'    CONVERT_VALUE end CONVERT_VALUE,',
'    CONVERT_TYPE from EMP_REQUESTS where id = :P29_REQUEST_ID',
')',
'',
'select ',
'    eor.ID,',
'    eor.EMPLOYEE_CODE,',
'    eor.CREATED_DATE,',
'    eor.profile_time,',
'    eor.start_time,',
'    eor.end_time,',
'    eor.TOTAL_HOUR_WK,',
'    eor.TOTAL_HOUR_REST_WK,',
'    eor.TOTAL_HOUR_PUBLIC,',
'    eor.TOTAL_HOUR_WK + TOTAL_HOUR_REST_WK + TOTAL_HOUR_PUBLIC as TOTAL_HOURS,',
'    eor.REASON,',
'    eor.NOTE,',
'    eor.WORKING_PLACE,',
'    eor.status,',
'    eor.DETAIL_ID,',
'    (select CONVERT_TYPE from temp) as CONVERT_TYPE,',
'    (select CONVERT_VALUE from temp) as CONVERT_VALUE',
'from EMP_OVERTIME_REQUESTS eor',
'where eor.EMPLOYEE_CODE = :P29_EMPLOYEE_CODE and :P29_DETAIL_ID = eor.DETAIL_ID',
'',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P29_EMPLOYEE_CODE, P29_DETAIL_ID, P29_REQUEST_ID'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Report'
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
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14188536170482527)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14188953949482531)
,p_name=>'TOTAL_HOUR_WK'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL_HOUR_WK'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Total OT hours of weekdays'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'is-readonly'
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
,p_default_type=>'STATIC'
,p_default_expression=>'0'
,p_duplicate_value=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14189029496482532)
,p_name=>'TOTAL_HOUR_REST_WK'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL_HOUR_REST_WK'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Total OT hours on day-off'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'is-readonly'
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
,p_default_type=>'STATIC'
,p_default_expression=>'0'
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14189165591482533)
,p_name=>'TOTAL_HOUR_PUBLIC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL_HOUR_PUBLIC'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Total OT hours on public holidays'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'is-readonly'
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
,p_default_type=>'STATIC'
,p_default_expression=>'0'
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14189901838482541)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_use_as_row_header=>false
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'n_check number;',
'begin',
'    select count(id) into n_check from EMP_REQUESTS where (:P29_REQUEST_ID is not null and id = :P29_REQUEST_ID and employee_code = :APP_EMP_CODE) or :P29_REQUEST_ID is null;',
'    if n_check > 0 then',
'        return true;',
'        else',
'        return false;',
'    end if;',
'end;'))
,p_display_condition2=>'PLSQL'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14190057764482542)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_use_as_row_header=>false
,p_display_condition_type=>'FUNCTION_BODY'
,p_display_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'n_check number;',
'begin',
'    select count(id) into n_check from EMP_REQUESTS where (:P29_REQUEST_ID is not null and id = :P29_REQUEST_ID and employee_code = :APP_EMP_CODE) or :P29_REQUEST_ID is null;',
'    if n_check > 0 then',
'        return true;',
'        else',
'        return false;',
'    end if;',
'end;'))
,p_display_condition2=>'PLSQL'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14190299247482544)
,p_name=>'PROFILE_TIME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROFILE_TIME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Profile Time'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select REPLACE(TRIM(PROFILE_ID), '' '', ''''), REPLACE(TRIM(PROFILE_ID), '' '', '''') as ID from WORKING_SCHEDULE where EMPLOYEE_CODE = :APP_EMP_CODE and WS_DATE = :CREATED_DATE',
'UNION all',
'SELECT REPLACE(TRIM(e.PROFILE_ID), '' '', ''''), REPLACE(TRIM(e.PROFILE_ID), '' '', '''') AS ID ',
'FROM EMPLOYEES e',
'WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE ',
'AND NOT EXISTS (',
'    SELECT 1 ',
'    FROM WORKING_SCHEDULE ',
'    WHERE EMPLOYEE_CODE = :APP_EMP_CODE AND WS_DATE = :CREATED_DATE',
')',
''))
,p_lov_display_extra=>true
,p_lov_display_null=>false
,p_lov_cascade_parent_items=>'CREATED_DATE'
,p_ajax_items_to_submit=>'CREATED_DATE'
,p_ajax_optimize_refresh=>true
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'SQL_QUERY'
,p_default_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PROFILE_ID as ID from WORKING_SCHEDULE where EMPLOYEE_CODE = :APP_EMP_CODE and WS_DATE = :CREATED_DATE',
'UNION all',
'',
'-- -- Second query, executed only if the first one returns no results',
'SELECT e.PROFILE_ID as ID',
'FROM EMPLOYEES e',
'WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE ',
'AND NOT EXISTS (',
'    SELECT 1 ',
'    FROM WORKING_SCHEDULE ',
'    WHERE EMPLOYEE_CODE = :APP_EMP_CODE AND WS_DATE = :CREATED_DATE',
')',
''))
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14190372312482545)
,p_name=>'START_TIME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'START_TIME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_heading=>'Start Time'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'CENTER'
,p_value_css_classes=>'_start'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
,p_attribute_07=>'0'
,p_attribute_08=>'false'
,p_is_required=>false
,p_max_length=>100
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'07:00'
,p_duplicate_value=>false
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14190431470482546)
,p_name=>'END_TIME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'END_TIME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_heading=>'End Time'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
,p_attribute_07=>'0'
,p_attribute_08=>'false'
,p_is_required=>false
,p_max_length=>100
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'07:00'
,p_duplicate_value=>false
,p_include_in_export=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14190561506482547)
,p_name=>'WORKING_PLACE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WORKING_PLACE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Working Places'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>200
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
 p_id=>wwv_flow_imp.id(14290080067031602)
,p_name=>'EMPLOYEE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>180
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P29_EMPLOYEE_CODE'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14290540957031607)
,p_name=>'CREATED_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Day'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
,p_format_mask=>'MM/DD/YYYY'
,p_is_required=>false
,p_enable_filter=>false
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14290664959031608)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>190
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_default_type=>'STATIC'
,p_default_expression=>'1'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(14292004567031622)
,p_name=>'REASON'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'REASON'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Reason'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>2000
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
 p_id=>wwv_flow_imp.id(14293344289031635)
,p_name=>'DETAIL_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETAIL_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>200
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P29_DETAIL_ID'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(18708426853964744)
,p_name=>'NOTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NOTE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>210
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(19572856170699524)
,p_name=>'CONVERT_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CONVERT_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>220
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_include_in_export=>false
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P29_REQUEST_ID'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(19572998580699525)
,p_name=>'CONVERT_VALUE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CONVERT_VALUE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>230
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_include_in_export=>false
,p_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_display_condition=>'P29_REQUEST_ID'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(26847744901423017)
,p_name=>'TOTAL_HOURS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL_HOURS'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>240
,p_value_alignment=>'CENTER'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>false
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(14188454908482526)
,p_internal_uid=>14188454908482526
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>true
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>false
,p_toolbar_buttons=>null
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>false
,p_fixed_header=>'REGION'
,p_fixed_header_max_height=>500
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(14215671906695523)
,p_interactive_grid_id=>wwv_flow_imp.id(14188454908482526)
,p_static_id=>'142157'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(14215815755695523)
,p_report_id=>wwv_flow_imp.id(14215671906695523)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14216305808695525)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(14188536170482527)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14219931074695539)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(14188953949482531)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>212.438
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14220883302695541)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(14189029496482532)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>203.438
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14221774845695544)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(14189165591482533)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>242
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14233660012712958)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(14189901838482541)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14242707565769526)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(14190299247482544)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>133.438
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14243607265769528)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(14190372312482545)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>124.094
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14244583974769531)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(14190431470482546)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>129.438
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14245452069769534)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(14190561506482547)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>180.781
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14302369084157599)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(14290080067031602)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14313818299294332)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(14290540957031607)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>118.844
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14317906102333005)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>14
,p_column_id=>wwv_flow_imp.id(14290664959031608)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14338316209696367)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(14292004567031622)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>232.766
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14746918492963241)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>15
,p_column_id=>wwv_flow_imp.id(14293344289031635)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(19560943680524880)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(18708426853964744)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>194
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(19629648423324591)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>16
,p_column_id=>wwv_flow_imp.id(19572856170699524)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(19630690005324596)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>17
,p_column_id=>wwv_flow_imp.id(19572998580699525)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(27087629436745830)
,p_view_id=>wwv_flow_imp.id(14215815755695523)
,p_display_seq=>18
,p_column_id=>wwv_flow_imp.id(26847744901423017)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(19570607426699502)
,p_plug_name=>'Group'
,p_parent_plug_id=>wwv_flow_imp.id(13577754331760724)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>30
,p_plug_display_condition_type=>'FUNCTION_BODY'
,p_plug_display_when_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'BEGIN   ',
'    IF WF_IS_IN_WORKFLOW(:APP_EMP_CODE, :P29_REQUEST_ID) = 1 THEN',
'        return true;',
'    else return false;',
'    end if;',
'END;'))
,p_plug_display_when_cond2=>'PLSQL'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(18708675568964746)
,p_plug_name=>'Coverted'
,p_parent_plug_id=>wwv_flow_imp.id(19570607426699502)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>20
,p_landmark_type=>'exclude_landmark'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(14190844140482550)
,p_plug_name=>'Sub_info'
,p_parent_plug_id=>wwv_flow_imp.id(13577174188760718)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>10
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(14289979013031601)
,p_plug_name=>'Sub_info_1'
,p_parent_plug_id=>wwv_flow_imp.id(13577174188760718)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>20
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(15633303525041542)
,p_plug_name=>'Workflow detail history'
,p_parent_plug_id=>wwv_flow_imp.id(18704424886964704)
,p_region_template_options=>'#DEFAULT#:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>40
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(19571928654699515)
,p_plug_name=>'Content'
,p_parent_plug_id=>wwv_flow_imp.id(15633303525041542)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select --ID,',
'       to_char(wd.WD_MODIFIED_DATE,''DD/MM/YYYY HH24:MI'') as MODIFIED_DATE,',
'       emp.FULL_NAME,',
'       --WD_MODIFIED_CODE,',
'       WD_COMMENT,',
'       --WD_INFORMATION,',
'       --WF_PROCESS_ID,',
'       --STATUS,',
'       s.status as status,',
'       --wd.NOTE,',
'       --REQUEST_ID,',
'       SEQUENCE',
'from WORKFLOW_DETAIL wd',
'join EMPLOYEES emp on wd.WD_MODIFIED_CODE = emp.EMPLOYEE_CODE',
'join status s on s.id = wd.status',
'where REQUEST_ID = :P29_REQUEST_ID',
'order by SEQUENCE'))
,p_plug_source_type=>'NATIVE_IR'
,p_ajax_items_to_submit=>'P29_REQUEST_ID'
,p_landmark_type=>'exclude_landmark'
);
wwv_flow_imp_page.create_worksheet(
 p_id=>wwv_flow_imp.id(19572074625699516)
,p_max_row_count=>'1000000'
,p_pagination_type=>'ROWS_X_TO_Y'
,p_pagination_display_pos=>'BOTTOM_RIGHT'
,p_show_search_bar=>'N'
,p_report_list_mode=>'TABS'
,p_fixed_header=>'REGION'
,p_fixed_header_max_height=>500
,p_lazy_loading=>false
,p_show_detail_link=>'N'
,p_enable_mail_download=>'Y'
,p_owner=>'ERP'
,p_internal_uid=>19572074625699516
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19572171472699517)
,p_db_column_name=>'FULL_NAME'
,p_display_order=>10
,p_column_identifier=>'A'
,p_column_label=>'Full Name'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19572269743699518)
,p_db_column_name=>'STATUS'
,p_display_order=>20
,p_column_identifier=>'B'
,p_column_label=>'Status'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19572348321699519)
,p_db_column_name=>'MODIFIED_DATE'
,p_display_order=>30
,p_column_identifier=>'C'
,p_column_label=>'Modified Date'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19572483151699520)
,p_db_column_name=>'SEQUENCE'
,p_display_order=>40
,p_column_identifier=>'D'
,p_column_label=>'Sequence'
,p_column_type=>'NUMBER'
,p_display_text_as=>'HIDDEN_ESCAPE_SC'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_column(
 p_id=>wwv_flow_imp.id(19572505143699521)
,p_db_column_name=>'WD_COMMENT'
,p_display_order=>50
,p_column_identifier=>'E'
,p_column_label=>'Note'
,p_column_type=>'STRING'
,p_heading_alignment=>'LEFT'
,p_use_as_row_header=>'N'
);
wwv_flow_imp_page.create_worksheet_rpt(
 p_id=>wwv_flow_imp.id(19610883196304695)
,p_application_user=>'APXWS_DEFAULT'
,p_report_seq=>10
,p_report_alias=>'196109'
,p_status=>'PUBLIC'
,p_is_default=>'Y'
,p_report_columns=>'FULL_NAME:STATUS:MODIFIED_DATE:SEQUENCE:WD_COMMENT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(13892386026402201)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(14190602475482548)
,p_button_name=>'Cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--danger:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'Cancel'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
,p_grid_row_css_classes=>'_left'
,p_grid_column_span=>1
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15631007488041519)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(14190602475482548)
,p_button_name=>'Update'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'Update'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    n_check number;',
'begin',
'    if :P29_REQUEST_ID is not null then',
'    select count(id) into n_check from EMP_REQUESTS ',
'    where ID = :P29_REQUEST_ID and (STATUS = 1) and employee_code = :APP_EMP_CODE;',
'    -- where ID = :P29_REQUEST_ID and (STATUS = 1 or STATUS = 2) and employee_code = :APP_EMP_CODE;',
'        if n_check > 0 then',
'            return true;',
'            else',
'            return false;',
'        end if;',
'    end if;',
'end;'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'FUNCTION_BODY'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
end;
/
begin
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(13892701493402205)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(14190602475482548)
,p_button_name=>'Submit'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_condition=>'P29_REQUEST_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15633292125041541)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(14190602475482548)
,p_button_name=>'Submit_Draft'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'n_check number;',
'begin',
'if :P29_REQUEST_ID is not null then',
'select count(id) into n_check from EMP_REQUESTS WHERE ID = :P29_REQUEST_ID and status = 1;',
'    if n_check > 0 then',
'        return true;',
'        else',
'        return false;',
'    end if;',
'else',
'    return false;',
'end if;',
'end;'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'FUNCTION_BODY'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15632793173041536)
,p_button_sequence=>80
,p_button_plug_id=>wwv_flow_imp.id(14190602475482548)
,p_button_name=>'Save_Draft'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save Draft'
,p_button_condition=>'P29_REQUEST_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15630324168041512)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_imp.id(14190602475482548)
,p_button_name=>'Approve'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Approve'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- declare',
'--     n_check number;',
'--     n_check_seq number;',
'--     n_check_line_man number;',
'-- begin',
'-- select count(id) into n_check_seq from EMP_REQUESTS er where next_step = 1 and er.ID = :P29_REQUEST_ID;',
'-- if n_check_seq > 0 then',
'--     select count(id) into n_check_line_man from EMP_REQUESTS er where next_step = 1 and er.ID = :P29_REQUEST_ID and er.line_manager = :APP_EMP_CODE ;',
'--     if n_check_line_man > 0 then',
'--         return true;',
'--         else',
'--         return false;',
'--     end if;',
'-- else',
'--     select count(er.id) into n_check from EMP_REQUESTS er',
'--         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'--         join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP',
'--         where er.ID = :P29_REQUEST_ID and er.NEXT_STEP = wa.WA_SEQUENCE_NUMBER',
'--         and emp.EMPLOYEE_CODE = :APP_EMP_CODE and er.STATUS not in (3,4) and er.next_step > 1 and :APP_EMP_CODE <>(select line_manager from EMP_REQUESTS where ID = :P29_REQUEST_ID);',
'',
'--         if n_check > 0 then',
'--             return true;',
'--             else',
'--             return false;',
'--         end if;',
'-- end if;',
'',
'-- end;',
'',
'declare',
'flag number;',
'begin',
'    flag := WF_IS_IN_NEXT_SEQUENCE(:APP_EMP_CODE, :P29_REQUEST_ID);',
'    if flag = 1 then',
'        return true;',
'    else ',
'        return false;',
'    end if;',
'end;'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'FUNCTION_BODY'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15630885514041517)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_imp.id(14190602475482548)
,p_button_name=>'Reject'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reject'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- declare',
'--     n_check number;',
'--     n_check_seq number;',
'--     n_check_line_man number;',
'-- begin',
'-- select count(id) into n_check_seq from EMP_REQUESTS er where next_step = 1 and er.ID = :P29_REQUEST_ID;',
'-- if n_check_seq > 0 then',
'--     select count(id) into n_check_line_man from EMP_REQUESTS er where next_step = 1 and er.ID = :P29_REQUEST_ID and er.line_manager = :APP_EMP_CODE ;',
'--     if n_check_line_man > 0 then',
'--         return true;',
'--         else',
'--         return false;',
'--     end if;',
'-- else',
'--     select count(er.id) into n_check from EMP_REQUESTS er',
'--         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'--         join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP',
'--         where er.ID = :P29_REQUEST_ID and er.NEXT_STEP = wa.WA_SEQUENCE_NUMBER',
'--         and emp.EMPLOYEE_CODE = :APP_EMP_CODE and er.STATUS not in (3,4) and er.next_step > 1 and :APP_EMP_CODE <>(select line_manager from EMP_REQUESTS where ID = :P29_REQUEST_ID);',
'',
'--         if n_check > 0 then',
'--             return true;',
'--             else',
'--             return false;',
'--         end if;',
'-- end if;',
'',
'-- end;',
'',
'',
'',
'declare',
'flag number;',
'begin',
'    flag := WF_IS_IN_NEXT_SEQUENCE(:APP_EMP_CODE, :P29_REQUEST_ID);',
'    if flag = 1 then',
'        return true;',
'    else ',
'        return false;',
'    end if;',
'end;'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'FUNCTION_BODY'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>1
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(14291230473031614)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(13578108736760728)
,p_button_name=>'Addrow'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add row'
,p_button_position=>'PREVIOUS'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    n_check number;',
'begin',
'    if :P29_REQUEST_ID is not null then',
'        select count(id) into n_check from EMP_REQUESTS ',
'        where ID = :P29_REQUEST_ID and (STATUS = 1 or STATUS = 2) and employee_code = :APP_EMP_CODE;',
'            if n_check > 0 then',
'                return true;',
'                else',
'                return false;',
'            end if;',
'            else',
'            return true;',
'    end if;',
'end;'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'FUNCTION_BODY'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(14290866553031610)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(13578108736760728)
,p_button_name=>'Deleterow'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--gapBottom'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Delete row'
,p_button_position=>'PREVIOUS'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    n_check number;',
'begin',
'    if :P29_REQUEST_ID is not null then',
'        select count(id) into n_check from EMP_REQUESTS ',
'        where ID = :P29_REQUEST_ID and (STATUS = 1 or STATUS = 2) and employee_code = :APP_EMP_CODE;',
'            if n_check > 0 then',
'                return true;',
'                else',
'                return false;',
'            end if;',
'        else',
'            return true;',
'    end if;',
'end;'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'FUNCTION_BODY'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(13577234651760719)
,p_name=>'P29_EMPLOYEE_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(14190844140482550)
,p_prompt=>'Employee Name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex_disabled'
,p_grid_column_css_classes=>'col-4'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(13577349765760720)
,p_name=>'P29_EMPLOYEE_CODE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(14190844140482550)
,p_prompt=>'Employee code'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex_disabled'
,p_begin_on_new_line=>'N'
,p_grid_column_css_classes=>'col-4'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(13577487538760721)
,p_name=>'P29_DEPARTMENT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(14190844140482550)
,p_prompt=>'Deparment'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex_disabled'
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(13577588058760722)
,p_name=>'P29_TITLE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(14289979013031601)
,p_prompt=>'Title'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex_disabled'
,p_grid_column_css_classes=>'col-6'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(13577627031760723)
,p_name=>'P29_LEVEL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(14289979013031601)
,p_prompt=>'Level'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex_disabled'
,p_begin_on_new_line=>'N'
,p_grid_column_css_classes=>'col-6'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(14293411978031636)
,p_name=>'P29_DETAIL_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(13577174188760718)
,p_item_default=>'select OT_DETAIL_ID.nextval from dual'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15569744592256544)
,p_name=>'P29_FEATURE'
,p_item_sequence=>80
,p_item_default=>'Request_OT'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15629848045041507)
,p_name=>'P29_LINE_MANAGER'
,p_item_sequence=>70
,p_item_default=>'SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE '
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15630768002041516)
,p_name=>'P29_REQUEST_ID'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(13577174188760718)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18708817494964748)
,p_name=>'P29_COVERTED'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(18708675568964746)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CONVERT_TYPE',
'FROM EMP_REQUESTS',
'WHERE ID = :P29_REQUEST_ID;',
''))
,p_item_default_type=>'SQL_QUERY'
,p_prompt=>'Converted'
,p_display_as=>'NATIVE_RADIOGROUP'
,p_lov=>'STATIC2:Money;Money,Day off;Day_off'
,p_read_only_when=>'wf_is_in_next_sequence(:APP_EMP_CODE, :P29_REQUEST_ID) != 1'
,p_read_only_when2=>'PLSQL'
,p_read_only_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#:t-Form-fieldContainer--stretchInputs:t-Form-fieldContainer--large'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'2'
,p_attribute_02=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18708922038964749)
,p_name=>'P29_TOTAL_DAY_OFF'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(18708675568964746)
,p_prompt=>'Total day-off (days)'
,p_source=>'ot_calculate_total_dayoff(:P29_DETAIL_ID)'
,p_source_type=>'EXPRESSION'
,p_source_language=>'PLSQL'
,p_display_as=>'NATIVE_NUMBER_FIELD'
,p_cSize=>15
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_css_classes=>'is-readonly'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(19683340307649524)
,p_name=>'P29_COMMENT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(19570607426699502)
,p_prompt=>'Comment'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(27181704318440508)
,p_name=>'P29_NOTE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(13577754331760724)
,p_prompt=>'Note'
,p_source=>'SELECT NOTE from EMP_REQUESTS where ID = :P29_REQUEST_ID'
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_display_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    n_check number;',
'BEGIN',
'select count(id) into n_check from EMP_REQUESTS WHERE ID = :P29_REQUEST_ID and status = 1;',
'if :P29_REQUEST_ID is null or n_check > 0 then',
'    return true;',
'else ',
'    return false;',
'end if;',
'',
'END;'))
,p_display_when2=>'PLSQL'
,p_display_when_type=>'FUNCTION_BODY'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(19571235487699508)
,p_validation_name=>'Check valid hours'
,p_validation_sequence=>10
,p_validation=>'((:P29_TOTAL_DAY_OFF)/1.5)*8 > 12'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'Error'
,p_always_execute=>'Y'
,p_validation_condition=>'false'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_when_button_pressed=>wwv_flow_imp.id(13892701493402205)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(26847188692423011)
,p_tabular_form_region_id=>wwv_flow_imp.id(13578108736760728)
,p_validation_name=>'Validate total_hours'
,p_validation_sequence=>20
,p_validation=>'TOTAL_HOURS'
,p_validation2=>'0'
,p_validation_type=>'ITEM_IN_VALIDATION_NOT_EQ_STRING2'
,p_error_message=>unistr('Th\1EDDi gian \0111\00E3 ch\1ECDn kh\00F4ng n\1EB1m trong khung gi\1EDD t\0103ng ca!')
,p_when_button_pressed=>wwv_flow_imp.id(13892701493402205)
,p_associated_column=>'END_TIME'
,p_error_display_location=>'INLINE_WITH_FIELD'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(13892468010402202)
,p_name=>'Close dialog'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(13892386026402201)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(13892599617402203)
,p_event_id=>wwv_flow_imp.id(13892468010402202)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_DIALOG_CLOSE'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(14187168213482513)
,p_name=>'Set value'
,p_event_sequence=>20
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(14187277186482514)
,p_event_id=>wwv_flow_imp.id(14187168213482513)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'for rec in (select * from employees where employee_code = :P29_EMPLOYEE_CODE)loop',
'    :P29_EMPLOYEE_NAME := rec.FULL_NAME;',
'    :P29_TITLE := rec.TITLE;',
'    :P29_DEPARTMENT := rec.DEPARTMENT_ID;',
'    :P29_LEVEL := ''SE'';',
'end loop;',
'    ',
'end;'))
,p_attribute_02=>'P29_EMPLOYEE_CODE'
,p_attribute_03=>'P29_EMPLOYEE_NAME,P29_DEPARTMENT,P29_TITLE,P29_LEVEL'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(14290909439031611)
,p_name=>'Delete row'
,p_event_sequence=>30
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(14290866553031610)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(14291040560031612)
,p_event_id=>wwv_flow_imp.id(14290909439031611)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.region( "ontoor" ).widget().interactiveGrid( "getActions" ).invoke( "selection-delete" );'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(14291346273031615)
,p_name=>'Add row'
,p_event_sequence=>40
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(14291230473031614)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(14291422743031616)
,p_event_id=>wwv_flow_imp.id(14291346273031615)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.region( "ontoor" ).widget().interactiveGrid( "getActions" ).invoke( "selection-add-row" );'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(18709094264964750)
,p_name=>'Set convert'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P29_COVERTED'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(19570512560699501)
,p_event_id=>wwv_flow_imp.id(18709094264964750)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'if(apex.item(''P29_COVERTED'').getValue() != ''Day_off''){',
'    $(''#P29_TOTAL_DAY_OFF_CONTAINER'').hide();',
'}else',
'    $(''#P29_TOTAL_DAY_OFF_CONTAINER'').show();',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(19570760805699503)
,p_name=>'Set value day off'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P29_TOTAL_HOURS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(19570863978699504)
,p_event_id=>wwv_flow_imp.id(19570760805699503)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'apex.item(''P29_TOTAL_DAY_OFF'').setValue(apex.item(''P29_TOTAL_HOURS'').getValue()*1.5);'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(19570934505699505)
,p_name=>'Set value day off'
,p_event_sequence=>80
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_imp.id(13578108736760728)
,p_triggering_element=>'TOTAL_HOUR_WK'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(19571078055699506)
,p_event_id=>wwv_flow_imp.id(19570934505699505)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P29_TOTAL_DAY_OFF'
,p_attribute_01=>'PLSQL_EXPRESSION'
,p_attribute_04=>'floor((:TOTAL_HOUR_WK)*2)/2'
,p_attribute_07=>'TOTAL_HOUR_WK'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(22742213932164401)
,p_name=>'StartTime_EndTime_change'
,p_event_sequence=>90
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_imp.id(13578108736760728)
,p_triggering_element=>'START_TIME,END_TIME'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22742374582164402)
,p_event_id=>wwv_flow_imp.id(22742213932164401)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Calculating Totals'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare ',
'    start_time_1 DATE;',
'    end_time_1 DATE;',
'    loop_flex_time_start DATE;',
'    loop_flex_time_end DATE;',
'    total_flex_time NUMBER(5,2) := 0;',
'    total_public NUMBER(5,2) := 0;',
'    l_count_public_holidays NUMBER;',
'    l_count_day_off NUMBER;',
'    cursor c_flex_times is',
'        SELECT TO_DATE(START_TIME, ''HH24:MI'') as flex_start, ',
'               TO_DATE(END_TIME, ''HH24:MI'') as flex_end',
'        FROM WORKING_PROFILE_LINES wpd',
'        JOIN PROFILE_TYPES pt ON custom_trim_v2(pt.PROFILE_TYPE_ID) = wpd.PROFILE_TYPE_ID',
'        WHERE wpd.PROFILE_ID = :PROFILE_TIME',
'        AND pt.PROFILE_TYPE_GROUP = ''ot'';',
'        -- AND wpd.PROFILE_TYPE_ID LIKE ''%ot%''',
'begin',
'    -- Convert the time strings to DATE data type',
'    start_time_1 := TO_DATE(:START_TIME, ''HH24:MI'');',
'    end_time_1 := TO_DATE(:END_TIME, ''HH24:MI'');',
'',
'    :TOTAL_HOUR_PUBLIC := 0;',
'    :TOTAL_HOUR_REST_WK := 0;',
'    :TOTAL_HOUR_WK := 0;',
'',
'    SELECT COUNT(*) INTO l_count_public_holidays FROM PUBLIC_HOLIDAYS ph WHERE TO_CHAR(ph.PH_DATE, ''DD-MM'')  = TO_CHAR(TO_DATE(:CREATED_DATE, ''MM-DD-YYYY''), ''DD-MM'');',
'    select COUNT(*) INTO l_count_day_off from WORKING_PROFILE wp where wp.PROFILE_ID =  CUSTOM_TRIM_V3(:PROFILE_TIME) and IS_DAY_OFF_PROFILE = 1;',
'',
'    -- Case: PUBLIC_HOLIDAYS',
'    IF l_count_public_holidays > 0 THEN',
'        total_public := custom_round((end_time_1 - start_time_1) * 24);',
'        -- DBMS_OUTPUT.PUT_LINE(''Total Public:'' || total_public);',
'        -- :TOTAL_HOUR_PUBLIC := total_public;',
'        IF total_public > 0 THEN :TOTAL_HOUR_PUBLIC := total_public;  ELSE :TOTAL_HOUR_PUBLIC := 0; END IF;',
'',
'        RETURN;',
'    END IF;',
'',
'    -- Case: WEEKDAYS && DAY_OFF',
'    ',
'    -- Loop through each flex time and calculate the overlap',
'    for flex_record in c_flex_times loop',
'        loop_flex_time_start := flex_record.flex_start;',
'        loop_flex_time_end := flex_record.flex_end;',
'',
'        IF loop_flex_time_start <= end_time_1 AND loop_flex_time_end >= start_time_1 THEN',
'            total_flex_time := total_flex_time + (LEAST(end_time_1, loop_flex_time_end) - GREATEST(start_time_1, loop_flex_time_start)) * 24;',
'        END IF;',
'',
'    end loop;',
'',
'    total_flex_time := custom_round(total_flex_time);',
'',
'    -- Check day_off ',
'    IF l_count_day_off > 0 THEN',
'        :TOTAL_HOUR_REST_WK := total_flex_time;',
'        IF total_flex_time > 0 THEN :TOTAL_HOUR_REST_WK := total_flex_time; ELSE :TOTAL_HOUR_REST_WK := 0; END IF;',
'',
'        -- DBMS_OUTPUT.PUT_LINE(''Total day-off hours:'' || custom_round(total_flex_time));',
'    ELSE',
'        :TOTAL_HOUR_WK := total_flex_time;',
'        IF total_flex_time > 0 THEN :TOTAL_HOUR_WK := total_flex_time; ELSE :TOTAL_HOUR_WK := 0; END IF;',
'        -- DBMS_OUTPUT.PUT_LINE(''Total weekdays hours:'' || custom_round(total_flex_time));',
'    END IF;',
'',
'end;'))
,p_attribute_02=>'START_TIME,END_TIME,PROFILE_TIME, CREATED_DATE'
,p_attribute_03=>'TOTAL_HOUR_WK,TOTAL_HOUR_REST_WK,TOTAL_HOUR_PUBLIC'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(26847343490423013)
,p_event_id=>wwv_flow_imp.id(22742213932164401)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_name=>'Set total_hours'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'TOTAL_HOURS'
,p_attribute_01=>'PLSQL_EXPRESSION'
,p_attribute_04=>':TOTAL_HOUR_WK + :TOTAL_HOUR_REST_WK + :TOTAL_HOUR_PUBLIC'
,p_attribute_07=>'TOTAL_HOUR_WK,TOTAL_HOUR_REST_WK,TOTAL_HOUR_PUBLIC'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(18490594366148005)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'UPDATE - EMP_Request'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    UPDATE EMP_REQUESTS ',
'    SET NOTE = :P29_NOTE,',
'    MODIFIED_DATE = sysdate',
'    WHERE ID = :P29_REQUEST_ID;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15631007488041519)
,p_internal_uid=>18490594366148005
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15630445418041513)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Approve request'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- declare',
'--     n_check number;',
'--     n_step number;',
'-- begin',
'-- for rec in (',
'--     with temp as (',
'--     select wa.WA_GROUP from EMP_REQUESTS er',
'--         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'--         join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP',
'--         where emp.EMPLOYEE_CODE = :APP_EMP_CODE',
'--         group by wa.WA_GROUP',
'-- )',
'--     select er.CURRENT_STEP,er.NEXT_STEP,count(wa.WA_SEQUENCE_NUMBER) as SEQ from EMP_REQUESTS er',
'--         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'--         -- join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP',
'--         where er.ID = :P29_REQUEST_ID and er.STATUS <> 3 group by er.CURRENT_STEP,er.NEXT_STEP)loop',
'--             if rec.NEXT_STEP < rec.SEQ then',
'--                 --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;',
'--                 update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,NEXT_STEP = rec.NEXT_STEP+1,STATUS=6 where id = :P29_REQUEST_ID;',
'--                 else',
'--                 update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=3 where id = :P29_REQUEST_ID;',
'--             end if;',
'--             insert into WORKFLOW_DETAIL(WD_MODIFIED_DATE,WD_MODIFIED_CODE,STATUS,REQUEST_ID,SEQUENCE,WD_COMMENT) ',
'--             values(sysdate,:APP_EMP_CODE,3,:P29_REQUEST_ID,rec.NEXT_STEP,:P29_NOTE);',
'--         end loop;',
'',
'-- /*',
'-- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''dieptran@vus-etsc.edu.vn'', ''OT Request Submitted Successfully'', ''<p> Dear ''|| :APP_USER_NAME ||'', </p>'' ||',
'-- ''<p> Your OT request has been submitted successfully. Here are the details: </p>'' ||',
'',
'-- ''<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>'' ||',
'-- ''<br>'' || ',
'-- ''<p> Thank you, </p>'' ||',
'-- ''<p> VUS </p>'');',
'-- */',
'-- end;',
'',
'declare ',
'    p_request_status_out number;',
'    -- send mail',
'    v_body_emp clob;',
'    v_body_man clob;',
'    manager_email nvarchar2(200);',
'    manager_name nvarchar2(100);',
'    emp_email nvarchar2(200);',
'    emp_name nvarchar2(100);',
'    current_emp_name nvarchar2(100);',
'    n_TOTAL_HOUR_WK number(5,2);',
'    n_TOTAL_HOUR_REST_WK number(5,2);',
'    n_TOTAL_HOUR_PUBLIC number(5,2);',
'    n_min_date date;',
'    n_max_date date;',
'begin',
'    -- call procedure',
'    wf_process_request(:APP_EMP_CODE, :P29_REQUEST_ID, 1, :P29_COMMENT, p_request_status_out);',
'    ',
'    -- Update convert type',
'    update EMP_REQUESTS',
'    set CONVERT_TYPE = :P29_COVERTED',
'    where ID = :P29_REQUEST_ID;',
'',
'    -- get total hours',
'    select sum(TOTAL_HOUR_WK), sum(TOTAL_HOUR_REST_WK), sum(TOTAL_HOUR_PUBLIC)',
'    into n_TOTAL_HOUR_WK, n_TOTAL_HOUR_REST_WK, n_TOTAL_HOUR_PUBLIC',
'    from EMP_OVERTIME_REQUESTS',
'    where DETAIL_ID = :P29_DETAIL_ID;',
'',
'    -- get from_date and to_date',
'    select min(CREATED_DATE), max(CREATED_DATE) ',
'    into n_min_date, n_max_date',
'    from EMP_OVERTIME_REQUESTS',
'    where DETAIL_ID = :P29_DETAIL_ID;',
'',
'    SELECT STATUS INTO p_request_status_out',
'    FROM EMP_REQUESTS where ID = :P29_REQUEST_ID;',
'',
unistr('    -- l\1EA5y email nh\00E2n vi\00EAn t\1EA1o \0111\01A1n'),
'    SELECT USER_NAME ',
'    INTO emp_email ',
'    FROM EMPLOYEES emp ',
'    WHERE emp.EMPLOYEE_CODE = :P29_EMPLOYEE_CODE;',
'',
'    IF p_request_status_out = 6 THEN ',
'        -- Send mail for managers in next sequence',
'        for rec in (',
'            SELECT * FROM EMPLOYEES emp',
'            WHERE wf_is_in_next_sequence(emp.EMPLOYEE_CODE, :P29_REQUEST_ID) = 1',
'        ) loop',
'        ',
unistr('            -- l\1EA5y mail nh\00E2n vi\00EAn duy\1EC7t ti\1EBFp theo'),
'            SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES emp WHERE emp.EMPLOYEE_CODE = rec.EMPLOYEE_CODE;',
'',
'            -- v_body_man := v_body_man || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('            v_body_man := v_body_man || ''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\01A0N XIN T\0102NG CA</h3>'';'),
unistr('            v_body_man := v_body_man || ''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 REQUEST FOR OVERTIME LETTER</h3>'';'),
unistr('            v_body_man := v_body_man || ''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''|| manager_name ||'' th\00E2n m\1EBFn,</p>'';'),
'            v_body_man := v_body_man || ''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''|| manager_name ||'',</p>'';',
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB xin t\0103ng ca c\1EE7a nh\00E2n vi\00EAn nh\01B0 sau:</p>'';'),
'            v_body_man := v_body_man || ''<p style=''''color:black''''>Employee Portal system has received a request for overtime as below:</p>'';',
'            v_body_man := v_body_man || ''<br>'';',
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn nh\00E2n vi\00EAn / Employee Full Name:</strong> ''|| :P29_EMPLOYEE_NAME ||''</p>'';'),
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn / Employee Code:</strong> ''|| :P29_EMPLOYEE_CODE ||''</p>'';'),
'',
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1EEB ng\00E0y / From date:</strong> ''|| n_min_date || ''<strong style=''''color:black''''>- \0111\1EBFn ng\00E0y / to date:</strong>'' || n_max_date ||''</p>''; '),
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng th\1EDDi gian t\0103ng ca trong tu\1EA7n / Total OT hours on weekdays:</strong> ''|| n_TOTAL_HOUR_WK ||''</p>''; '),
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng th\1EDDi gian t\0103ng ca trong ng\00E0y ngh\1EC9 / Total OT hours on day-off:</strong> ''|| n_TOTAL_HOUR_REST_WK ||''</p>'';'),
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng th\1EDDi gian t\0103ng ca trong ng\00E0y l\1EC5 / Total OT hours on public holidays:</strong> ''|| n_TOTAL_HOUR_PUBLIC ||''</p>'';'),
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ghi ch\00FA / Note:</strong> ''|| :P29_NOTE ||''</p>'';'),
'            v_body_man := v_body_man || ''<br>'';',
'',
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''>Vui l\00F2ng \0111\0103ng nh\1EADp v\00E0o H\1EC7 th\1ED1ng Qu\1EA3n l\00FD T\0103ng ca \0111\1EC3 xem x\00E9t v\00E0 ph\1EA3n h\1ED3i y\00EAu c\1EA7u. B\1EA1n c\00F3 th\1EC3 ph\1EA3n h\1ED3i y\00EAu c\1EA7u t\0103ng ca b\1EB1ng c\00E1ch nh\1EA5p v\00E0o li\00EAn k\1EBFt sau:</p>'';'),
'            v_body_man := v_body_man || ''<p style=''''color:black''''>Please log in to The overtime management system to review and respond the overtime request. You can respond the overtime request by clicking on the following link: <a href=\"https://er'
||unistr('p-pilot.vus.edu.vn/ords/r/erp/erp/approve-scholarship-request?request_id='' || ''kh\00E1nh \0111i\1EC1n'' || ''\005C"> link to respond the overtime request \2197.</a></p><br>'';'),
'',
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''>N\1EBFu b\1EA1n c\00F3 b\1EA5t k\1EF3 c\00E2u h\1ECFi n\00E0o ho\1EB7c c\1EA7n th\00EAm s\1EF1 h\1ED7 tr\1EE3, xin \0111\1EEBng ng\1EA7n ng\1EA1i li\00EAn h\1EC7 v\1EDBi ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh.</p>'';'),
'            v_body_man := v_body_man || ''<p style=''''color:black''''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>'';',
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'            v_body_man := v_body_man || ''<p style=''''color:black''''>Best regards,</p>'';',
'            v_body_man := v_body_man || ''<p style=''''color:black''''>HR & Admin Department </p>'';',
'            -- v_body_man := v_body_man || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
unistr('            SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', manager_email, ''Y\00EAu c\1EA7u duy\1EC7t \0111\01A1n xin t\0103ng ca'', v_body_man);'),
unistr('            SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'', ''Y\00EAu c\1EA7u duy\1EC7t \0111\01A1n xin t\0103ng ca'', v_body_man);'),
'',
'        end loop;',
'',
unistr('        -- l\1EA5y th\00F4ng tin c\1EE7a ng\01B0\1EDDi duy\1EC7t hi\1EC7n t\1EA1i'),
'        SELECT FULL_NAME ',
'        INTO current_emp_name ',
'        FROM EMPLOYEES emp ',
'        WHERE emp.EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
unistr('        -- send mail cho ng\01B0\1EDDi t\1EA1o th\00F4ng b\00E1o k\1EBFt qu\1EA3 m\1ED7i l\01B0\1EE3t duy\1EC7t'),
'        v_body_emp := '''';',
'',
'        -- v_body_emp := v_body_emp || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('        v_body_emp := v_body_emp || ''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\01A0N XIN T\0102NG CA</h3>'';'),
unistr('        v_body_emp := v_body_emp || ''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 REQUEST FOR OVERTIME LETTER</h3>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''|| :P29_EMPLOYEE_NAME ||'' th\00E2n m\1EBFn,</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''|| :P29_EMPLOYEE_NAME ||'',</p>'';',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>\0110\01A1n c\1EE7a anh/ch\1ECB \0111\00E3 \0111\01B0\1EE3c duy\1EC7t b\1EDFi nh\00E2n vi\00EAn qu\1EA3n l\00FD c\00F3 th\00F4ng tin sau:</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Your application has been approved by a manager with the following information as below:</p>'';',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn qu\1EA3n l\00FD / Manager Full Name:</strong> ''|| current_emp_name ||''</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 qu\1EA3n l\00FD / Manager Code:</strong> ''|| :APP_EMP_CODE ||''</p>'';'),
'        v_body_emp := v_body_emp || ''<br>'';',
'',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Vui l\00F2ng ti\1EBFp t\1EE5c ch\1EDD \0111\1EE3i l\01B0\1EE3t ph\00EA duy\1EC7t ti\1EBFp theo trong 3 - 5 ng\00E0y!</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Please continue to wait for the next approval in 3 - 5 days!</p><br>'';',
'',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>N\1EBFu b\1EA1n c\00F3 b\1EA5t k\1EF3 c\00E2u h\1ECFi n\00E0o ho\1EB7c c\1EA7n th\00EAm s\1EF1 h\1ED7 tr\1EE3, xin \0111\1EEBng ng\1EA7n ng\1EA1i li\00EAn h\1EC7 v\1EDBi ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh.</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>'';',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Best regards,</p>'';',
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>HR & Admin Department </p>'';',
'        -- v_body_emp := v_body_emp || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', emp_email, ''Th\00F4ng b\00E1o tr\1EA1ng th\00E1i \0111\01A1n xin t\0103ng ca'', v_body_emp);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'', ''Th\00F4ng b\00E1o tr\1EA1ng th\00E1i \0111\01A1n xin t\0103ng ca'', v_body_emp);'),
'',
'    elsif p_request_status_out = 3 THEN',
'',
unistr('        -- send mail cho ng\01B0\1EDDi t\1EA1o th\00F4ng b\00E1o \0111\00E3 duy\1EC7t xong'),
'        v_body_emp := '''';',
'',
'        -- v_body_emp := v_body_emp || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('        v_body_emp := v_body_emp || ''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\01A0N XIN T\0102NG CA</h3>'';'),
unistr('        v_body_emp := v_body_emp || ''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 REQUEST FOR OVERTIME LETTER</h3>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''|| :P29_EMPLOYEE_NAME ||'' th\00E2n m\1EBFn,</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''|| :P29_EMPLOYEE_NAME ||'',</p>'';',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>\0110\01A1n c\1EE7a anh/ch\1ECB \0111\00E3 \0111\01B0\1EE3c duy\1EC7t b\1EDFi nh\00E2n vi\00EAn qu\1EA3n l\00FD c\00F3 th\00F4ng tin sau:</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Your application has been approved by a manager with the following information as below:</p>'';',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn qu\1EA3n l\00FD / Manager Full Name:</strong> ''|| current_emp_name ||''</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 qu\1EA3n l\00FD / Manager Code:</strong> ''|| :APP_EMP_CODE ||''</p>'';'),
'        v_body_emp := v_body_emp || ''<br>'';',
'',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Xin ch\00FAc m\1EEBng b\1EA1n! Y\00EAu c\1EA7u xin t\0103ng ca c\1EE7a b\1EA1n \0111\00E3 \0111\01B0\1EE3c duy\1EC7t th\00E0nh c\00F4ng.</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Congratulations! Your request for overtime has been successfully approved.</p><br>'';',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>D\01B0\1EDBi \0111\00E2y l\00E0 th\00F4ng tin c\1EE7a phi\00EAn l\00E0m t\0103ng ca \0111\00E3 \0111\01B0\1EE3c duy\1EC7t: </p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Below is information about the approved overtime session:</p><br>'';',
'        v_body_emp := v_body_emp || ''<br>'';',
'',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1EEB ng\00E0y / From date:</strong> ''|| n_min_date || ''<strong style=''''color:black''''>- \0111\1EBFn ng\00E0y / to date:</strong>'' || n_max_date ||''</p>''; '),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng th\1EDDi gian t\0103ng ca trong tu\1EA7n / Total OT hours on weekdays:</strong> ''|| n_TOTAL_HOUR_WK ||''</p>''; '),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng th\1EDDi gian t\0103ng ca trong ng\00E0y ngh\1EC9 / Total OT hours on day-off:</strong> ''|| n_TOTAL_HOUR_REST_WK ||''</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng th\1EDDi gian t\0103ng ca trong ng\00E0y l\1EC5 / Total OT hours on public holidays:</strong> ''|| n_TOTAL_HOUR_PUBLIC ||''</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ghi ch\00FA / Note:</strong> ''|| :P29_NOTE ||''</p>'';'),
'        v_body_emp := v_body_emp || ''<br>'';',
'',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>N\1EBFu b\1EA1n c\00F3 b\1EA5t k\1EF3 c\00E2u h\1ECFi n\00E0o ho\1EB7c c\1EA7n th\00EAm s\1EF1 h\1ED7 tr\1EE3, xin \0111\1EEBng ng\1EA7n ng\1EA1i li\00EAn h\1EC7 v\1EDBi ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh.</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>'';',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Best regards,</p>'';',
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>HR & Admin Department </p>'';',
'        -- v_body_emp := v_body_emp || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', emp_email, ''Th\00F4ng b\00E1o tr\1EA1ng th\00E1i \0111\01A1n xin t\0103ng ca'', v_body_emp);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'', ''Th\00F4ng b\00E1o tr\1EA1ng th\00E1i \0111\01A1n xin t\0103ng ca'', v_body_emp);'),
'    END IF;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15630324168041512)
,p_process_when=>'P29_REQUEST_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_success_message=>'Approved!'
,p_internal_uid=>15630445418041513
);
end;
/
begin
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15630992100041518)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Reject request'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- declare',
'--     n_check number;',
'--     n_step number;',
'-- begin',
'-- for rec in (',
'--     with temp as (',
'--     select wa.WA_GROUP from EMP_REQUESTS er',
'--         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'--         join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP',
'--         where emp.EMPLOYEE_CODE = :APP_EMP_CODE',
'--         group by wa.WA_GROUP',
'-- )',
'--     select er.CURRENT_STEP,er.NEXT_STEP,count(wa.WA_SEQUENCE_NUMBER) as SEQ from EMP_REQUESTS er',
'--         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'--         join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP',
'--         where er.ID = :P29_REQUEST_ID and er.STATUS <> 3 group by er.CURRENT_STEP,er.NEXT_STEP)loop',
'--             if rec.NEXT_STEP < rec.SEQ then',
'--                 --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;',
'--                 update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=4 where id = :P29_REQUEST_ID;',
'--                             insert into WORKFLOW_DETAIL(WD_MODIFIED_DATE,WD_MODIFIED_CODE,STATUS,REQUEST_ID,SEQUENCE) ',
'--             values(sysdate,:APP_EMP_CODE,4,:P29_REQUEST_ID,rec.NEXT_STEP);',
'--                 --else',
'--                 --update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=3 where id = :P29_REQUEST_ID;',
'--             end if;',
'--         end loop;',
'',
'',
'-- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''dieptran@vus-etsc.edu.vn'', ''OT Request Submitted Successfully'', ''<p> Dear ''|| :APP_USER_NAME ||'', </p>'' ||',
'-- ''<p> Your OT request has been submitted successfully. Here are the details: </p>'' ||',
'',
'-- ''<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>'' ||',
'-- ''<br>'' || ',
'-- ''<p> Thank you, </p>'' ||',
'-- ''<p> VUS </p>'');',
'-- end;',
'',
'declare ',
'    p_request_status_out number;',
'    emp_email nvarchar2(100);',
'    current_emp_name nvarchar2(100);',
'    v_body_emp clob;',
'begin',
'    -- call procedure',
'    wf_process_request(:APP_EMP_CODE, :P29_REQUEST_ID, 2, :P29_COMMENT, p_request_status_out);',
'',
'    if p_request_status_out = 4 then',
unistr('        -- l\1EA5y email c\1EE7a ng\01B0\1EDDi t\1EA1o'),
'        SELECT USER_NAME ',
'        INTO emp_email ',
'        FROM EMPLOYEES emp ',
'        WHERE emp.EMPLOYEE_CODE = :P29_EMPLOYEE_CODE;',
'',
unistr('        -- l\1EA5y t\00EAn c\1EE7a ng\01B0\1EDDi duy\1EC7t'),
'        SELECT USER_NAME ',
'        INTO current_emp_name',
'        FROM EMPLOYEES emp ',
'        WHERE emp.EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
unistr('        -- g\1EEDi mail cho ng\01B0\1EDDi t\1EA1o th\00F4ng b\00E1o k\1EBFt qu\1EA3 t\1EEB ch\1ED1i'),
'        v_body_emp := '''';',
'',
'        -- v_body_emp := v_body_emp || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('        v_body_emp := v_body_emp || ''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\01A0N XIN T\0102NG CA</h3>'';'),
unistr('        v_body_emp := v_body_emp || ''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 REQUEST FOR OVERTIME LETTER</h3>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''|| :P29_EMPLOYEE_NAME ||'' th\00E2n m\1EBFn,</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''|| :P29_EMPLOYEE_NAME ||'',</p>'';',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>\0110\01A1n c\1EE7a anh/ch\1ECB \0111\00E3 b\1ECB t\1EEB ch\1ED1i b\1EDFi nh\00E2n vi\00EAn qu\1EA3n l\00FD c\00F3 th\00F4ng tin sau:</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Your application has been rejected by a manager with the following information as below:</p>'';',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn qu\1EA3n l\00FD / Manager Full Name:</strong> ''|| current_emp_name ||''</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 qu\1EA3n l\00FD / Manager Code:</strong> ''|| :APP_EMP_CODE ||''</p>'';'),
'        v_body_emp := v_body_emp || ''<br>'';',
'',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>N\1EBFu b\1EA1n c\00F3 b\1EA5t k\1EF3 c\00E2u h\1ECFi n\00E0o ho\1EB7c c\1EA7n th\00EAm s\1EF1 h\1ED7 tr\1EE3, xin \0111\1EEBng ng\1EA7n ng\1EA1i li\00EAn h\1EC7 v\1EDBi ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh.</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>'';',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>Best regards,</p>'';',
'        v_body_emp := v_body_emp || ''<p style=''''color:black''''>HR & Admin Department </p>'';',
'        -- v_body_emp := v_body_emp || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', emp_email, ''Th\00F4ng b\00E1o tr\1EA1ng th\00E1i \0111\01A1n xin t\0103ng ca'', v_body_emp);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'', ''Th\00F4ng b\00E1o tr\1EA1ng th\00E1i \0111\01A1n xin t\0103ng ca'', v_body_emp);'),
'    end if;',
'    ',
'end;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15630885514041517)
,p_process_when=>'P29_REQUEST_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_success_message=>'Rejected!'
,p_internal_uid=>15630992100041518
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(14293597497031637)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Insert row new'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where WF_FEATURE_APPLY = :P29_FEATURE and WF_EXPIRATION_DATE >= sysdate)loop',
'    insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER,CONVERT_TYPE,CONVERT_VALUE, MODIFIED_DATE)',
'    values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P29_NOTE, sysdate,:P29_DETAIL_ID,rec.WF_PROCESS_ID,:P29_LINE_MANAGER,:P29_COVERTED,:P29_TOTAL_DAY_OFF, sysdate) returning ID into :P29_REQUEST_ID;',
'end loop;',
'',
'    -- insert workflow_detail',
'    insert into workflow_detail(wd_modified_date, wd_modified_code, wd_comment, status, request_id, sequence)',
'    values (sysdate, :APP_EMP_CODE, :P29_NOTE, 2, :P29_REQUEST_ID, 0);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Can''t create overtime request, please check your data!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(13892701493402205)
,p_process_when=>'P29_REQUEST_ID'
,p_process_when_type=>'ITEM_IS_NULL'
,p_process_success_message=>'Create overtime request successfully!'
,p_internal_uid=>14293597497031637
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15632874552041537)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Insert row new draft'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where WF_FEATURE_APPLY = :P29_FEATURE and WF_EXPIRATION_DATE >= sysdate)loop',
'    insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER,CONVERT_TYPE,CONVERT_VALUE)',
'    values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,1,:P29_NOTE, sysdate,:P29_DETAIL_ID,rec.WF_PROCESS_ID,:P29_LINE_MANAGER,:P29_COVERTED,:P29_TOTAL_DAY_OFF) returning ID into :P29_REQUEST_ID;',
'end loop;',
'    -- insert workflow_detail',
'    insert into workflow_detail(wd_modified_date, wd_modified_code, wd_comment, status, request_id, sequence)',
'    values (sysdate, :APP_EMP_CODE, :P29_NOTE, 1, :P29_REQUEST_ID, 0);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15632793173041536)
,p_internal_uid=>15632874552041537
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15633042504041539)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update status draft'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    n_check number;',
'BEGIN',
'select count(id) into n_check from EMP_REQUESTS WHERE ID = :P29_REQUEST_ID and status = 1;',
'if n_check > 0 then',
'    UPDATE EMP_REQUESTS ',
'    SET status = 2',
'    WHERE ID = :P29_REQUEST_ID;',
'end if;',
'    insert into workflow_detail(wd_modified_date, wd_modified_code, wd_comment, status, request_id, sequence)',
'    values (sysdate, :APP_EMP_CODE, :P29_NOTE, 2, :P29_REQUEST_ID, 0);',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15633292125041541)
,p_process_when=>'P29_REQUEST_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_success_message=>'Success!'
,p_internal_uid=>15633042504041539
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(14190180218482543)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(13578108736760728)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Report - Save Interactive Grid Data_Create'
,p_attribute_01=>'TABLE'
,p_attribute_03=>'EMP_OVERTIME_REQUESTS'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(13892701493402205)
,p_process_success_message=>'Success!'
,p_internal_uid=>14190180218482543
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15632986744041538)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(13578108736760728)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Report - Save Interactive Grid Data_Create_Draft'
,p_attribute_01=>'TABLE'
,p_attribute_03=>'EMP_OVERTIME_REQUESTS'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15632793173041536)
,p_process_success_message=>'Saved Draft!'
,p_internal_uid=>15632986744041538
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15631197510041520)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(13578108736760728)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Report - Save Interactive Grid Data_Update'
,p_attribute_01=>'TABLE'
,p_attribute_03=>'EMP_OVERTIME_REQUESTS'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15631007488041519)
,p_process_success_message=>'Success!'
,p_internal_uid=>15631197510041520
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(18707976890964739)
,p_process_sequence=>110
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send email'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    manager_email nvarchar2(100);',
'    manager_name nvarchar2(100);',
'    n_TOTAL_HOUR_WK number(5,2);',
'    n_TOTAL_HOUR_REST_WK number(5,2);',
'    n_TOTAL_HOUR_PUBLIC number(5,2);',
'    n_min_date date;',
'    n_max_date date;',
'    v_body_man clob;',
'begin',
'    ',
'    -- get total hours',
'    select sum(TOTAL_HOUR_WK), sum(TOTAL_HOUR_REST_WK), sum(TOTAL_HOUR_PUBLIC)',
'    into n_TOTAL_HOUR_WK, n_TOTAL_HOUR_REST_WK, n_TOTAL_HOUR_PUBLIC',
'    from EMP_OVERTIME_REQUESTS',
'    where DETAIL_ID = :P29_DETAIL_ID;',
'',
'    -- get from_date and to_date',
'    select min(CREATED_DATE), max(CREATED_DATE) ',
'    into n_min_date, n_max_date',
'    from EMP_OVERTIME_REQUESTS',
'    where DETAIL_ID = :P29_DETAIL_ID;',
'',
'    SELECT USER_NAME, FULL_NAME ',
'    INTO manager_email, manager_name ',
'    FROM EMPLOYEES ',
'    WHERE (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE) = EMPLOYEE_CODE;',
'',
'---send mail for manager',
'    v_body_man := '''';',
'    ',
'    -- v_body_man := v_body_man || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('    v_body_man := v_body_man || ''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\01A0N XIN T\0102NG CA</h3>'';'),
unistr('    v_body_man := v_body_man || ''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 REQUEST FOR OVERTIME LETTER</h3>'';'),
unistr('    v_body_man := v_body_man || ''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''|| manager_name ||'' th\00E2n m\1EBFn,</p>'';'),
'    v_body_man := v_body_man || ''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''|| manager_name ||'',</p>'';',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB xin t\0103ng ca c\1EE7a nh\00E2n vi\00EAn nh\01B0 sau:</p>'';'),
'    v_body_man := v_body_man || ''<p style=''''color:black''''>Employee Portal system has received a request for overtime as below:</p>'';',
'    v_body_man := v_body_man || ''<br>'';',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn nh\00E2n vi\00EAn / Employee Full Name:</strong> ''|| :P29_EMPLOYEE_NAME ||''</p>'';'),
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn / Employee Code:</strong> ''|| :P29_EMPLOYEE_CODE ||''</p>'';'),
'',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1EEB ng\00E0y / From date:</strong> ''|| n_min_date || ''<strong style=''''color:black''''>- \0111\1EBFn ng\00E0y / to date:</strong>'' || n_max_date ||''</p>''; '),
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng th\1EDDi gian t\0103ng ca trong tu\1EA7n / Total OT hours on weekdays:</strong> ''|| n_TOTAL_HOUR_WK ||''</p>''; '),
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng th\1EDDi gian t\0103ng ca trong ng\00E0y ngh\1EC9 / Total OT hours on day-off:</strong> ''|| n_TOTAL_HOUR_REST_WK ||''</p>'';'),
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng th\1EDDi gian t\0103ng ca trong ng\00E0y l\1EC5 / Total OT hours on public holidays:</strong> ''|| n_TOTAL_HOUR_PUBLIC ||''</p>'';'),
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ghi ch\00FA / Note:</strong> ''|| :P29_NOTE ||''</p>'';'),
'    v_body_man := v_body_man || ''<br>'';',
'',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''>Vui l\00F2ng \0111\0103ng nh\1EADp v\00E0o H\1EC7 th\1ED1ng Qu\1EA3n l\00FD T\0103ng ca \0111\1EC3 xem x\00E9t v\00E0 ph\1EA3n h\1ED3i y\00EAu c\1EA7u. B\1EA1n c\00F3 th\1EC3 ph\1EA3n h\1ED3i y\00EAu c\1EA7u t\0103ng ca b\1EB1ng c\00E1ch nh\1EA5p v\00E0o li\00EAn k\1EBFt sau:</p>'';'),
'    v_body_man := v_body_man || ''<p style=''''color:black''''>Please log in to The overtime management system to review and respond the overtime request. You can respond the overtime request by clicking on the following link: <a href=\"https://erp-pilot.'
||unistr('vus.edu.vn/ords/r/erp/erp/approve-scholarship-request?request_id='' || ''kh\00E1nh \0111i\1EC1n'' || ''\005C"> link to respond the overtime request \2197.</a></p><br>'';'),
'',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''>N\1EBFu b\1EA1n c\00F3 b\1EA5t k\1EF3 c\00E2u h\1ECFi n\00E0o ho\1EB7c c\1EA7n th\00EAm s\1EF1 h\1ED7 tr\1EE3, xin \0111\1EEBng ng\1EA7n ng\1EA1i li\00EAn h\1EC7 v\1EDBi ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh.</p>'';'),
'    v_body_man := v_body_man || ''<p style=''''color:black''''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>'';',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'    v_body_man := v_body_man || ''<p style=''''color:black''''>Best regards,</p>'';',
'    v_body_man := v_body_man || ''<p style=''''color:black''''>HR & Admin Department </p>'';',
'    -- v_body_man := v_body_man || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
unistr('    SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', manager_email, ''Y\00EAu c\1EA7u duy\1EC7t \0111\01A1n xin t\0103ng ca'', v_body_man);'),
unistr('    SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'', ''Y\00EAu c\1EA7u duy\1EC7t \0111\01A1n xin t\0103ng ca'', v_body_man);'),
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(13892701493402205)
,p_process_when=>'disabled'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>18707976890964739
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(14292183727031623)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_CLOSE_WINDOW'
,p_process_name=>'Close dialog when submit'
,p_attribute_02=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_type=>'NOT_DISPLAYING_INLINE_VALIDATION_ERRORS'
,p_process_success_message=>'Success!'
,p_internal_uid=>14292183727031623
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
