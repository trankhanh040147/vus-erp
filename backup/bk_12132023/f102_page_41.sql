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
 p_version_yyyy_mm_dd=>'2023.04.28'
,p_release=>'23.1.5'
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
--   Date and Time:   10:49 Wednesday December 13, 2023
--   Exported By:     ERP
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 41
--   Manifest End
--   Version:         23.1.5
--   Instance ID:     7949320442804181
--

begin
null;
end;
/
prompt --application/pages/delete_00041
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>41);
end;
/
prompt --application/pages/page_00041
begin
wwv_flow_imp_page.create_page(
 p_id=>41
,p_name=>'Overtime Request Approval'
,p_alias=>'APPROVE-REQUEST-OVERTIME'
,p_step_title=>'Overtime Request Approval'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'._left{',
'    justify-content: flex-end;',
'}',
'.a-GV-header .a-GV-headerLabel {',
'  white-space: normal;',
'  text-align: center;',
'}',
''))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20231212151841'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(19016205955792374)
,p_plug_name=>'Overtime Request Approval'
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
 p_id=>wwv_flow_imp.id(24349176553240183)
,p_plug_name=>'Search'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>50
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24349588091240187)
,p_plug_name=>'Detail'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>60
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(24350003034240191)
,p_plug_name=>'Report'
,p_parent_plug_id=>wwv_flow_imp.id(24349588091240187)
,p_region_template_options=>'#DEFAULT#:t-IRR-region--noBorders:js-showMaximizeButton:t-Form--stretchInputs'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>30
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'with temp as (',
'    select',
'        wa.WA_GROUP',
'    from',
'        EMP_REQUESTS er',
'        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'        join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP',
'   where',
'        lower(wa.WA_GROUP) not like ''line_manager'' --and emp.employee_code = :APP_EMP_CODE',
'        group by',
'        wa.WA_GROUP',
'',
'),',
'temp_2 as (',
'    select sum(TOTAL_HOUR_WK) as TOTAL_HOUR_WK,',
'        sum(TOTAL_HOUR_REST_WK) as TOTAL_HOUR_REST_WK,',
'        sum(TOTAL_HOUR_PUBLIC) as TOTAL_HOUR_PUBLIC,',
'        DETAIL_ID',
'        from EMP_OVERTIME_REQUESTS',
'        --where employee_code = :APP_EMP_CODE',
'        group by DETAIL_ID',
')',
'select',
'    --eor.ID,',
'    emp.FULL_NAME,',
'    er.SUBMIT_DATE,',
'    eor.EMPLOYEE_CODE,',
'    -- eor.CREATED_DATE,',
'    er.CREATE_DATE,',
'    er.STATUS,',
'    -- eor.STATUS,',
'    er.NOTE,',
'    --(select FULL_NAME from employees where eor.MODIFIED_BY_CODE = emp.employee_code) as MODIFIED_BY,',
'    eor.MODIFIED_DATE,',
'    t2.TOTAL_HOUR_WK,',
'    t2.TOTAL_HOUR_REST_WK,',
'    t2.TOTAL_HOUR_PUBLIC,',
'    --eor.MANAGER_CODE,',
'    eor.DETAIL_ID,',
'    er.ID as REQUEST_ID',
'from',
'    EMP_OVERTIME_REQUESTS eor',
'    join EMP_REQUESTS er on eor.DETAIL_ID = er.REQUEST_DETAIL_ID',
'    and er.STATUS <> 1',
'    join temp_2 t2 on t2.DETAIL_ID = er.REQUEST_DETAIL_ID',
'    join employees emp on emp.employee_code = er.EMPLOYEE_CODE',
'-- where er.next_step = 1 and :APP_EMP_CODE = er.LINE_MANAGER ',
'where er.next_step = 1 and :APP_EMP_CODE = (SELECT MANAGER_ID FROM EMPLOYEES Where EMPLOYEE_CODE = ER.EMPLOYEE_CODE) ',
'and lower(emp.FULL_NAME) like ''%'' || TRIM(lower(:P41_EMPLOYEE)) ||''%'' ',
'and to_date(er.CREATE_DATE,''MM/DD/YYYY'') between to_date(:P41_FROM_DATE,''MM/DD/YYYY'') and to_date(:P41_TO_DATE,''MM/DD/YYYY'')',
'and lower(er.STATUS) like ''%'' || :P41_STATUS || ''%''',
'-- and lower(er.STATUS) like ''%'' || lower(case when :P41_STATUS = ''na'' then '''' else :P41_STATUS end) || ''%''',
'union',
'select',
'    --eor.ID,',
'    emp.FULL_NAME,',
'    er.SUBMIT_DATE,',
'    eor.EMPLOYEE_CODE,',
'    -- eor.CREATED_DATE,',
'    er.CREATE_DATE,',
'    er.STATUS,',
'    -- eor.STATUS,',
'    er.NOTE,',
'    eor.MODIFIED_DATE,',
'    t2.TOTAL_HOUR_WK,',
'    t2.TOTAL_HOUR_REST_WK,',
'    t2.TOTAL_HOUR_PUBLIC,',
'    eor.DETAIL_ID,',
'    er.ID as REQUEST_ID',
'from',
'    EMP_OVERTIME_REQUESTS eor',
'    join EMP_REQUESTS er on eor.DETAIL_ID = er.REQUEST_DETAIL_ID',
'    and er.STATUS <> 1',
'    join temp_2 t2 on t2.DETAIL_ID = er.REQUEST_DETAIL_ID',
'    join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'    join employees emp on emp.employee_code = er.EMPLOYEE_CODE',
'where er.next_step > 1 and (wa.WA_GROUP in (select WA_GROUP from temp) or wf_is_in_next_sequence(:APP_EMP_CODE,er.ID) = 1) ',
'and lower(emp.FULL_NAME) like ''%'' || TRIM(lower(:P41_EMPLOYEE)) ||''%''',
'and to_date(er.CREATE_DATE,''MM/DD/YYYY'') between to_date(:P41_FROM_DATE,''MM/DD/YYYY'') and to_date(:P41_TO_DATE,''MM/DD/YYYY'')',
'and lower(er.STATUS) like ''%'' || :P41_STATUS || ''%''',
''))
,p_plug_source_type=>'NATIVE_IG'
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
 p_id=>wwv_flow_imp.id(14293090026031632)
,p_name=>'TOTAL_HOUR_WK'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL_HOUR_WK'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Total OT hourds on weekdays'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
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
 p_id=>wwv_flow_imp.id(14293118301031633)
,p_name=>'TOTAL_HOUR_REST_WK'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL_HOUR_REST_WK'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Total OT hourds on day-off'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
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
 p_id=>wwv_flow_imp.id(14293251979031634)
,p_name=>'TOTAL_HOUR_PUBLIC'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TOTAL_HOUR_PUBLIC'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Total OT hourds on public holidays'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
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
 p_id=>wwv_flow_imp.id(15629941931041508)
,p_name=>'APEX$ROW_ACTION'
,p_source_type=>'NONE'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:29:&SESSION.::&DEBUG.:29:P29_DETAIL_ID,P29_EMPLOYEE_CODE,P29_REQUEST_ID:&DETAIL_ID.,&EMPLOYEE_CODE.,&REQUEST_ID.'
,p_link_text=>'<span><i class="fa fa-pencil"></span>'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(15630072549041509)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'N'
,p_attribute_03=>'N'
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(15630526911041514)
,p_name=>'REQUEST_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'REQUEST_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>130
,p_value_alignment=>'RIGHT'
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
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(18491333644148013)
,p_name=>'SUBMIT_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SUBMIT_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Submit Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'na'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(18491640220148016)
,p_name=>'CREATE_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATE_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Created Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(18706279047964722)
,p_name=>'FULL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FULL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Full Name'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(18706398969964723)
,p_name=>'DETAIL_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DETAIL_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>200
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(28529189156385859)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Status'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT STATUS, ID AS ID ',
'From STATUS'))
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(28529287351385860)
,p_name=>'NOTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NOTE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Note'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>2000
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
 p_id=>wwv_flow_imp.id(28529422913385861)
,p_name=>'EMPLOYEE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Employee Code'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'CENTER'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>500
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
 p_id=>wwv_flow_imp.id(28529744653385865)
,p_name=>'MODIFIED_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MODIFIED_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Modified Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(28235979999305563)
,p_internal_uid=>28235979999305563
,p_is_editable=>true
,p_edit_operations=>'i:d'
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>false
,p_fixed_row_height=>false
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>false
,p_toolbar_buttons=>null
,p_enable_save_public_report=>true
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
 p_id=>wwv_flow_imp.id(28256912849488609)
,p_interactive_grid_id=>wwv_flow_imp.id(28235979999305563)
,p_static_id=>'139142'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(28257092799488609)
,p_report_id=>wwv_flow_imp.id(28256912849488609)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14396991926632789)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(14293090026031632)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>95
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14397820890632792)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(14293118301031633)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>110
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(14398711852632795)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(14293251979031634)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>130
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(18278741530450018)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(15629941931041508)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(18287465289535182)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(15630526911041514)
,p_is_visible=>false
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'DESC'
,p_sort_nulls=>'FIRST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(18755987348930696)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(18491333644148013)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>96.1
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(18995846284412643)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(18491640220148016)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>107
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(19078858937747738)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(18706279047964722)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>171
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(19097017572989588)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(18706398969964723)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(28538068296468714)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(28529189156385859)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>67
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(28538970213468717)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(28529287351385860)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>165
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(28539906955468720)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(28529422913385861)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>86
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(28543488440468731)
,p_view_id=>wwv_flow_imp.id(28257092799488609)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(28529744653385865)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>118
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(28239812520305601)
,p_plug_name=>'Top group button'
,p_region_template_options=>'#DEFAULT#:margin-bottom-md'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(14346161739903362)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(28239812520305601)
,p_button_name=>'Approve'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Approve'
,p_button_redirect_url=>'f?p=&APP_ID.:29:&SESSION.::&DEBUG.:29:P29_EMPLOYEE_CODE:&APP_EMP_CODE.'
,p_grid_new_row=>'Y'
,p_grid_row_css_classes=>'_left'
,p_grid_column_span=>2
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(14345301124903361)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(28239812520305601)
,p_button_name=>'Reject'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reject'
,p_button_redirect_url=>'f?p=&APP_ID.:29:&SESSION.::&DEBUG.:29:P29_LIST_ID:&P41_LIST_ID_1.'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(14345785233903362)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(28239812520305601)
,p_button_name=>'View'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'View'
,p_button_redirect_url=>'f?p=&APP_ID.:36:&SESSION.::&DEBUG.:36:P36_EMPLOYEE_CODE:&P41_EMPLOYEE.'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(14343310240903357)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(24349176553240183)
,p_button_name=>'Search'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Search'
,p_icon_css_classes=>'fa-search'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(18494793462148047)
,p_button_sequence=>110
,p_button_plug_id=>wwv_flow_imp.id(24349176553240183)
,p_button_name=>'Reset'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reset'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-refresh'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
,p_grid_column_span=>2
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(24349927268240184)
,p_name=>'P41_EMPLOYEE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(24349176553240183)
,p_pre_element_text=>'Employee Name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(24349975406240185)
,p_name=>'P41_STATUS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(24349176553240183)
,p_pre_element_text=>'Status'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'STATUS_OVERTIME_REQUEST'
,p_lov=>'.'||wwv_flow_imp.id(21177530445359046)||'.'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'--All--'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(24350389742240189)
,p_name=>'P41_FROM_DATE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(24349176553240183)
,p_item_default=>'select trunc(sysdate,''MM'') from dual;'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Created date from'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_colspan=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(24350559712240190)
,p_name=>'P41_TO_DATE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(24349176553240183)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_CHAR(SYSDATE, ''MM/DD/YYYY'') AS formatted_date FROM DUAL;',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'to'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(14351447408903373)
,p_name=>'New'
,p_event_sequence=>40
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'window'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(14351982642903375)
,p_event_id=>wwv_flow_imp.id(14351447408903373)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'location.reload()'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(18494825309148048)
,p_name=>'Onclick'
,p_event_sequence=>50
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(18494793462148047)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(18494975092148049)
,p_event_id=>wwv_flow_imp.id(18494825309148048)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Reset page items'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    :P41_EMPLOYEE := null;',
'    :P41_STATUS := null;',
'    SELECT TRUNC(SYSDATE, ''YEAR'') INTO :P41_FROM_DATE FROM DUAL;',
'    SELECT TO_CHAR(SYSDATE, ''MM/DD/YYYY'') INTO :P41_TO_DATE FROM DUAL;',
'end;'))
,p_attribute_03=>'P41_EMPLOYEE, P41_STATUS, P41_FROM_DATE, P41_TO_DATE'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(18495068298148050)
,p_event_id=>wwv_flow_imp.id(18494825309148048)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'Restart page'
,p_action=>'NATIVE_SUBMIT_PAGE'
,p_attribute_02=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15630175381041510)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(24350003034240191)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Report - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_internal_uid=>15630175381041510
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
