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
--   Date and Time:   01:02 Thursday January 25, 2024
--   Exported By:     ERP
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 19
--   Manifest End
--   Version:         23.2.1
--   Instance ID:     7949320442804181
--

begin
null;
end;
/
prompt --application/pages/delete_00019
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>19);
end;
/
prompt --application/pages/page_00019
begin
wwv_flow_imp_page.create_page(
 p_id=>19
,p_name=>'Setup Workflow'
,p_alias=>'SETUP-WORKFLOW'
,p_step_title=>'Setup Workflow'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
''))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const setDefaultReport = function(){',
'',
'    $(''.interactive-grid'').each(element => {',
'        ',
'        let igActions = apex.region($(''.approve-list-grid'')[element].id).call("getActions");',
'',
'        let choices =  igActions.lookup("change-report").choices;',
'',
'',
'        if(choices.length > 0){',
'            ',
'            let primary = choices.filter(obj => {',
'',
'                return obj.group === "Default";',
'',
'            })[0].value;',
'             ',
'            let publicStandard = choices.filter(obj => {',
'                return obj.label.indexOf(''[STD>= 0 && obj.group === "Public"'');',
'',
'            })[1];',
'          ',
'            if(publicStandard){',
'               ',
'                publicStandard = publicStandard.value;',
'',
'            }',
'',
'            let current = igActions.get("change-report");',
'',
'            if ( publicStandard && current !== publicStandard && current === primary ) {',
'',
'                igActions.set("change-report", publicStandard);',
'             ',
'            }',
'',
'        }',
'',
'    });',
'',
'}',
'',
'$( document ).ready(function() {',
'    setDefaultReport();',
'});'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* Auto Wrap | Heading Column | Interative Grid */',
'.a-GV-header .a-GV-headerLabel {',
'  white-space: normal;',
'  text-align: center;',
'}',
'',
'/* .__page_setup_workflow */',
'',
'.apex-item-datepicker {',
'padding-left:  7px !important;',
'}',
'',
'/* .__btn_crud */',
'.__region_top .t-Region-header {',
'    position: relative;',
'}',
'',
'.__btn_crud {',
'    position: absolute;',
'    top: 0;',
'    margin-right: 5px;',
'    margin-top: 9px;',
'}',
'',
'.__btn_new {',
'    right: 192px;',
'}',
'',
'.__btn_edit {',
'    right: 115px;',
'}',
'/* .__btn_crud */',
''))
,p_page_css_classes=>'__page_setup_workflow'
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20231220095405'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(19517606071627730)
,p_plug_name=>'Setup Workflow'
,p_region_css_classes=>'__region_top'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>30
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- <script>',
'window.addEventListener(''load'', function () {',
'    setTimeout(function() {',
'    var rows = document.querySelectorAll("table.a-GV-table tbody .a-GV-row");',
'    rows.forEach(function(row) {',
'        var statusCell = row.cells[6];',
'        ',
'        var status = statusCell.textContent.trim().toLowerCase();',
'        ',
'        if (status == "waiting") {',
'             var tds = row.querySelectorAll("td");',
'                tds.forEach(function(td) {',
'                    td.style.color = "#d0aa2b";',
'                });',
'        }',
'        if (status == "approve") {',
'            console.log("ok");',
'             var tds = row.querySelectorAll("td");',
'                tds.forEach(function(td) {',
'                    td.style.color = "green";',
'                });',
'        }',
'        if(status == "cancle"){',
'             var tds = row.querySelectorAll("td");',
'                tds.forEach(function(td) {',
'                    td.style.color = "red";',
'                });',
'        }',
'    });',
'}, 1500);',
'',
'})',
'</script> -->',
'',
'<script>',
'function applyStylesToRows() {',
'    var rows = document.querySelectorAll("table.a-GV-table tbody .a-GV-row");',
'    rows.forEach(function(row) {',
'        var statusCell = row.cells[7];',
'        var status = statusCell.textContent.trim().toLowerCase();',
'        ',
'        if (status === "waiting") {',
'            var tds = row.querySelectorAll("td");',
'            if (tds.length >= 8) {',
'                var sixthTd = tds[7]; // Get the 6th <td> (index 5)',
'                sixthTd.style.color = "#d0aa2b";',
'            }',
'        }',
'',
'        if (status === "approved") {',
'            var tds = row.querySelectorAll("td");',
'            if (tds.length >= 8) {',
'                var sixthTd = tds[7]; // Get the 6th <td> (index 5)',
'                sixthTd.style.color = "green";',
'            }',
'        }',
'        if (status === "cancel") {',
'            var tds = row.querySelectorAll("td");',
'            if (tds.length >= 8) {',
'                var sixthTd = tds[7]; // Get the 6th <td> (index 5)',
'                sixthTd.style.color = "red";',
'            }',
'        }',
'    });',
'}',
'',
'function observeTableChanges() {',
'    var targetNode = document.querySelector("table.a-GV-table tbody");',
'    ',
'    var observer = new MutationObserver(function(mutationsList) {',
'        for (var mutation of mutationsList) {',
'            if (mutation.type === "childList") {',
'                applyStylesToRows();',
'            }',
'        }',
'    });',
'',
'    var config = { childList: true };',
'',
'    observer.observe(targetNode, config);',
'}',
'',
'window.addEventListener(''load'', function () {',
'    setTimeout(observeTableChanges, 1500);',
'});',
'</script>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(19518251932627736)
,p_plug_name=>'Content'
,p_region_css_classes=>'approve-list-grid'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>40
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ROW_NUMBER() OVER (ORDER BY WF.ID) AS No,',
'       WF.ID,',
'       WF_PROCESS_ID,',
'       WF_NAME,',
'       WF_DESCRIPTION,',
'       WF_FEATURE_APPLY,',
'       WF_CONDITIONAL_ID,',
'       WF_EFFECTIVE_DATE,',
'       WF_EXPIRATION_DATE,',
'       e.FULL_NAME,',
'       WF_MODIFIER_CODE,',
'       WF_MODIFIED_DATE',
'from "WORKFLOW" WF',
'left join EMPLOYEES e on e.EMPLOYEE_CODE = WF_MODIFIER_CODE',
'where WF_EFFECTIVE_DATE between to_date(:P19_FROM_DATE,''MM/DD/YYYY'') and to_date(:P19_TO_DATE,''MM/DD/YYYY'')',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P19_FROM_DATE,P19_TO_DATE'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Content'
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
,p_landmark_type=>'exclude_landmark'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(11557471108621531)
,p_name=>'WF_PROCESS_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WF_PROCESS_ID'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'ProcessID'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>true
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(11557545365621532)
,p_name=>'WF_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WF_NAME'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Workflow Name'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'LEFT'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(11557618722621533)
,p_name=>'WF_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WF_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Description'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_imp.id(11557758953621534)
,p_name=>'WF_FEATURE_APPLY'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WF_FEATURE_APPLY'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>110
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(11557821288621535)
,p_name=>'WF_CONDITIONAL_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WF_CONDITIONAL_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>120
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(11557984571621536)
,p_name=>'WF_EFFECTIVE_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WF_EFFECTIVE_DATE'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Effective Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
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
 p_id=>wwv_flow_imp.id(11558023500621537)
,p_name=>'WF_EXPIRATION_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WF_EXPIRATION_DATE'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Expiration Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
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
 p_id=>wwv_flow_imp.id(11558257481621539)
,p_name=>'WF_MODIFIER_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WF_MODIFIER_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>160
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(11558329561621540)
,p_name=>'WF_MODIFIED_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WF_MODIFIED_DATE'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Modified Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
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
 p_id=>wwv_flow_imp.id(18490129152148001)
,p_name=>'APEX$ROW_ACTION'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:18:&SESSION.::&DEBUG.:18:P18_WF_PROCESS_ID,P18_ID:&WF_PROCESS_ID.,&ID.'
,p_link_text=>'<span><i class="fa fa-pencil"></span>'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(19518420604627738)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(27181314537440504)
,p_name=>'NO'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NO'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'No.'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
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
 p_id=>wwv_flow_imp.id(27182124924440512)
,p_name=>'FULL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FULL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Modifier By'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
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
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(19518325952627737)
,p_internal_uid=>19518325952627737
,p_is_editable=>false
,p_lazy_loading=>true
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>false
,p_toolbar_buttons=>null
,p_enable_save_public_report=>true
,p_enable_subscriptions=>true
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>false
,p_download_formats=>null
,p_fixed_header=>'NONE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(19557070498746383)
,p_interactive_grid_id=>wwv_flow_imp.id(19518325952627737)
,p_static_id=>'81391'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(19557328616746383)
,p_report_id=>wwv_flow_imp.id(19557070498746383)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12156811765901046)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(11557471108621531)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>149.266
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12157710903901054)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(11557545365621532)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>316.297
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12158655114901058)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(11557618722621533)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>420.312
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12159552994901061)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(11557758953621534)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12160426075901064)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(11557821288621535)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12161371296901067)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(11557984571621536)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>124.2812
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12162250512901070)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(11558023500621537)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>114.2812
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12164005549901076)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(11558257481621539)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12164947760901079)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(11558329561621540)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>115.01525
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(18495453844163284)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(18490129152148001)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>43.31200000000001
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(19557817014746385)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(19518420604627738)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>51.2656
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(27236429969485845)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(27181314537440504)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(28067017737804580)
,p_view_id=>wwv_flow_imp.id(19557328616746383)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(27182124924440512)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>138
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(11419062896359108)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(19517606071627730)
,p_button_name=>'Search'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Search'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(9518504805313748)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(19517606071627730)
,p_button_name=>'NEW'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#:t-Button--simple'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Add new'
,p_button_position=>'RIGHT_OF_TITLE'
,p_button_redirect_url=>'f?p=&APP_ID.:18:&SESSION.::&DEBUG.:::'
,p_button_css_classes=>'__btn_crud __btn_new'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(19519311916627739)
,p_name=>'P19_FROM_DATE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(19517606071627730)
,p_item_default=>'select trunc(sysdate,''YYYY'') from dual;'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Created Date From'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_colspan=>5
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
 p_id=>wwv_flow_imp.id(19519393539627740)
,p_name=>'P19_TO_DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(19517606071627730)
,p_item_default=>'select sysdate from dual;'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'To'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'ITEM'
,p_attribute_05=>'P19_FROM_DATE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(11428650004359125)
,p_name=>'New'
,p_event_sequence=>10
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'window'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(11429155010359126)
,p_event_id=>wwv_flow_imp.id(11428650004359125)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'location.reload();'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(27181120871440502)
,p_name=>'Search_click'
,p_event_sequence=>20
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(11419062896359108)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(27181289613440503)
,p_event_id=>wwv_flow_imp.id(27181120871440502)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'refresh'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(19518251932627736)
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
