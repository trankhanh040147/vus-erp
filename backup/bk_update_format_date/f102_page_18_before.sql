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
--   Date and Time:   01:03 Thursday January 25, 2024
--   Exported By:     ERP
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 18
--   Manifest End
--   Version:         23.2.1
--   Instance ID:     7949320442804181
--

begin
null;
end;
/
prompt --application/pages/delete_00018
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>18);
end;
/
prompt --application/pages/page_00018
begin
wwv_flow_imp_page.create_page(
 p_id=>18
,p_name=>'New workflow'
,p_alias=>'SW-NEW-WORKFLOW'
,p_page_mode=>'MODAL'
,p_step_title=>'Workflow '
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''.delete-condition'').click(function(){',
'    $(''.reg_condition.condition_id_''+$(this).attr("condition_id")).remove();',
'})',
'',
'$(function() {',
'    // Listen for view change events to modify the grid when it''s created',
'    $("#iGrid_workflow_conditions").on("interactivegridviewchange", function(event, data) {',
'        if (data.view === "grid" && data.created) {',
'            var view = apex.region("iGrid_workflow_conditions").widget().interactiveGrid("getViews", "grid"),',
'                menu$ = view.rowActionMenu$;',
'',
'            // Check each menu item and remove if not the ''Delete'' action',
'            menu$.menu("option", "items").forEach(function(item, index, object) {',
'                // print action info',
'                // console.log(item.action, item.label, item.icon, item.type); ',
'                // console.log(item.action); ',
'                ',
'                if (item.action && item.action !== ''row-delete'') {',
'                    console.log(item.action); ',
'                    // add class to hide menu item',
'                    menu$.find(''.a-Menu-item:eq('' + index + '')'').addClass(''display-none'');',
'                }',
'            });     ',
'        }',
'    });',
'});',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.a-GV-header .a-GV-headerLabel {',
'  white-space: normal;',
'  text-align: center;',
'}',
'',
'#_add-condition {',
'    background: #003dc6;',
'    margin-bottom: 15px;',
'}',
'',
'#_add-condition>span {',
'    color: #ffffff !important;',
'}',
'',
'.delete-condition {',
'    border-radius: 50% !important;',
'}',
'',
'.t-Form-itemWrapper select.selectlist.apex-item-select {',
'    padding-right: 20px !important;',
'}',
'#P18_WF_PROCESS_ID_DISPLAY {',
'    font-size: 13px !important;',
'}',
'#wf-condition-approval .selectlist.apex-item-select {',
'    font-size: 12px;',
'}',
'#btn-submit, #btn-update {',
'    background: #3135c6 !important;',
'}',
'#btn-cancel {',
'    color: #000!important;',
'}',
'.d-center {',
'    align-items: center;',
'    justify-content: center;',
'    display: flex;',
'}',
'#p18_btn_delete {',
'    background-color: #ac0a0f !important;',
'    cursor: pointer; ',
'}',
'#p18_btn_delete .t-Icon:before, #btn-update .t-Icon:before, #btn-submit .t-Icon:before{',
'    color: #ffffff !important;',
'}',
'/* .apex-icons-fontapex .fa:before {',
'    color: #ffffff !important;',
'} */',
'display-none {',
'    display: none !important;',
'}',
'.a-GV-header-sort {',
'    display: none !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_dialog_width=>'1200'
,p_protection_level=>'C'
,p_browser_cache=>'N'
,p_page_component_map=>'21'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20240111042914'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(11558420122621541)
,p_plug_name=>'Workflow'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_query_type=>'TABLE'
,p_query_table=>'WORKFLOW'
,p_include_rowid_column=>true
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_lost_update_check_type=>'VALUES'
,p_plug_source_type=>'NATIVE_FORM'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12364133427756731)
,p_plug_name=>'Conditions and Approval '
,p_region_name=>'wf-condition-approval'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>20
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12364249052756732)
,p_plug_name=>'Conditions'
,p_parent_plug_id=>wwv_flow_imp.id(12364133427756731)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_plug_display_when_condition=>'disabled'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12364619551756736)
,p_plug_name=>'Condition'
,p_parent_plug_id=>wwv_flow_imp.id(12364249052756732)
,p_region_template_options=>'#DEFAULT#'
,p_region_attributes=>'condition_id=1'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>20
,p_plug_grid_row_css_classes=>'reg_condition condition_id_1'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12443333615222336)
,p_plug_name=>'Condition'
,p_parent_plug_id=>wwv_flow_imp.id(12364249052756732)
,p_region_template_options=>'#DEFAULT#'
,p_region_attributes=>'condition_id=2'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>30
,p_plug_grid_row_css_classes=>'reg_condition condition_id_2'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(12365355847756743)
,p_plug_name=>'Aprroval_Workflow'
,p_region_name=>'__approval-workflow'
,p_parent_plug_id=>wwv_flow_imp.id(12364133427756731)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>30
,p_plug_new_grid_row=>false
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'       WF_PROCESS_ID,',
'       WA_ID,',
'       WA_SEQUENCE_NUMBER,',
'       WA_GROUP,',
'       WA_USER,',
'       WA_TEMPLATE_EMAIL_ID',
'FROM WORKFLOW_APPROVAL',
'WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID;',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P18_WF_PROCESS_ID'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Aprroval_Workflow'
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
 p_id=>wwv_flow_imp.id(12365586788756745)
,p_name=>'WF_PROCESS_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WF_PROCESS_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>50
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P18_WF_PROCESS_ID'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(12365609922756746)
,p_name=>'WA_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WA_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(12365756608756747)
,p_name=>'WA_SEQUENCE_NUMBER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WA_SEQUENCE_NUMBER'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Approval Sequence'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>true
,p_enable_sort_group=>true
,p_enable_control_break=>true
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(12365837325756748)
,p_name=>'WA_GROUP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WA_GROUP'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Approval Group'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(26265630265923660)
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_null_text=>'--Select a group--'
,p_lov_null_value=>'na'
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
,p_default_type=>'STATIC'
,p_default_expression=>'na'
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(12365927680756749)
,p_name=>'WA_USER'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WA_USER'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'User'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>100
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT USER_NAME, e.ID AS ID',
'FROM EMPLOYEES e ',
'where USER_NAME is not NULL;'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
,p_readonly_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_readonly_condition=>'WA_GROUP'
,p_readonly_condition2=>'na'
,p_readonly_for_each_row=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(12366097086756750)
,p_name=>'WA_TEMPLATE_EMAIL_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WA_TEMPLATE_EMAIL_ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Template Email'
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
 p_id=>wwv_flow_imp.id(12439887264222301)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>40
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(12439950990222302)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>20
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(12365450498756744)
,p_internal_uid=>12365450498756744
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
,p_add_authorization_scheme=>wwv_flow_imp.id(11415900258147089)
,p_update_authorization_scheme=>wwv_flow_imp.id(11415900258147089)
,p_delete_authorization_scheme=>wwv_flow_imp.id(11415900258147089)
,p_lost_update_check_type=>'VALUES'
,p_add_row_if_empty=>false
,p_submit_checked_rows=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_toolbar_buttons=>'RESET:SAVE'
,p_enable_save_public_report=>true
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_auth_scheme=>wwv_flow_imp.id(18803182532889190)
,p_download_formats=>'CSV:PDF:XLSX'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(12449046195231687)
,p_interactive_grid_id=>wwv_flow_imp.id(12365450498756744)
,p_static_id=>'124491'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(12449267066231688)
,p_report_id=>wwv_flow_imp.id(12449046195231687)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12449760701231695)
,p_view_id=>wwv_flow_imp.id(12449267066231688)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(12365586788756745)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12450549774231702)
,p_view_id=>wwv_flow_imp.id(12449267066231688)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(12365609922756746)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12451408084231705)
,p_view_id=>wwv_flow_imp.id(12449267066231688)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(12365756608756747)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12452379375231708)
,p_view_id=>wwv_flow_imp.id(12449267066231688)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(12365837325756748)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>139
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12453233343231710)
,p_view_id=>wwv_flow_imp.id(12449267066231688)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(12365927680756749)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>133
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12454184560231713)
,p_view_id=>wwv_flow_imp.id(12449267066231688)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(12366097086756750)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(12455022595231715)
,p_view_id=>wwv_flow_imp.id(12449267066231688)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(12439887264222301)
,p_is_visible=>false
,p_is_frozen=>true
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(13480182027234050)
,p_plug_name=>'iGrid Conditions'
,p_region_name=>'iGrid_workflow_conditions'
,p_parent_plug_id=>wwv_flow_imp.id(12364133427756731)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18635771618889015)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select WC_ID,',
'       WF_PROCESS_ID,',
'       WC_TABLE_NAME,',
'       WCF_COLUMN,',
'       WC_COMPARE_TYPE,',
'       WC_VALUE_1,',
'       WC_VALUE_2',
'from "WORKFLOW_CONDITIONS" WC',
'where WF_PROCESS_ID = :P18_WF_PROCESS_ID'))
,p_plug_source_type=>'NATIVE_IG'
,p_translate_title=>'N'
,p_ajax_items_to_submit=>'P18_WF_PROCESS_ID'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'iGrid Conditions'
,p_prn_page_header_font_color=>'#000000'
,p_prn_page_header_font_family=>'Helvetica'
,p_prn_page_header_font_weight=>'normal'
,p_prn_page_header_font_size=>'12'
,p_prn_page_footer_font_color=>'#000000'
,p_prn_page_footer_font_family=>'Helvetica'
,p_prn_page_footer_font_weight=>'normal'
,p_prn_page_footer_font_size=>'12'
,p_prn_header_bg_color=>'#ffffff'
,p_prn_header_font_color=>'#000000'
,p_prn_header_font_family=>'Helvetica'
,p_prn_header_font_weight=>'bold'
,p_prn_header_font_size=>'10'
,p_prn_body_bg_color=>'#FFFFFF'
,p_prn_body_font_color=>'#000000'
,p_prn_body_font_family=>'Helvetica'
,p_prn_body_font_weight=>'normal'
,p_prn_body_font_size=>'10'
,p_prn_border_width=>0
,p_prn_page_header_alignment=>'CENTER'
,p_prn_page_footer_alignment=>'CENTER'
,p_prn_border_color=>'#fdfdfd'
,p_landmark_type=>'exclude_landmark'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(13611296157717307)
,p_name=>'APEX$ROW_ACTION'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>30
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'disabled'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(13611362126717308)
,p_name=>'APEX$ROW_SELECTOR'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'N'
,p_attribute_03=>'N'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(13611543809717310)
,p_name=>'Delete'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_link_target=>'javascript:void(null);'
,p_link_text=>'<span class="t-Icon fa fa-trash delete-irrow" aria-hidden="true"></span>'
,p_link_attributes=>'data-id="&WC_ID."'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(27185087211440541)
,p_name=>'WC_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WC_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>90
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(27185270555440543)
,p_name=>'WC_TABLE_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WC_TABLE_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>110
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(27185494485440545)
,p_name=>'WC_COMPARE_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WC_COMPARE_TYPE'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Condition Type'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(29242733738399614)
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
 p_id=>wwv_flow_imp.id(27185588295440546)
,p_name=>'WC_VALUE_1'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WC_VALUE_1'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Field Value'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT WCFV_VALUE_DISPLAY, WCFV_ID AS ID',
'FROM WORKFLOW_CONDITION_FIELD_VALUE ',
'WHERE WCF_ID = :WCF_COLUMN'))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_cascade_parent_items=>'WCF_COLUMN'
,p_ajax_items_to_submit=>'WCF_COLUMN'
,p_ajax_optimize_refresh=>true
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(27185617444440547)
,p_name=>'WC_VALUE_2'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WC_VALUE_2'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>150
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(27185791942440548)
,p_name=>'WF_PROCESS_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WF_PROCESS_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>160
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'P18_WF_PROCESS_ID'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(29253362674953402)
,p_name=>'WCF_COLUMN'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WCF_COLUMN'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Condition Field'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT WCF_FIELD_NAME_DISPLAY, WCF_ID AS ID',
'FROM WORKFLOW_CONDITION_FIELD',
'-- where CUSTOM_TRIM_V1(WCC_FEATURE) = CUSTOM_TRIM_V1(:P18_WF_FEATURE_APPLY)',
''))
,p_lov_display_extra=>true
,p_lov_display_null=>true
,p_lov_null_text=>'-- Select a field -- '
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'LOV'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(13610652803717301)
,p_internal_uid=>13610652803717301
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
,p_show_total_row_count=>false
,p_show_toolbar=>true
,p_toolbar_buttons=>null
,p_add_button_label=>'Add Condition'
,p_enable_save_public_report=>true
,p_enable_subscriptions=>true
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function (config) {',
'    var $ = apex.jQuery,',
'        toolbarData = $.apex.interactiveGrid.copyDefaultToolbar(),',
'        // toolbarGroup = toolbarData[toolbarData.length - 1]; // this is the last group with reset button',
'        toolbarGroup = toolbarData[5]; // this is the last group with reset button',
'',
'',
'    // config.initActions = function( actions ) {',
'    //     // can modify state of existing actions or add your own',
'    //     // can also pass in an array of actions to add',
'    //     actions.add( {',
'    //         name: "my-action",',
'    //         label: "Hello",',
'    //         action: function(event, focusElement) {',
'    //             alert("Hello World!");',
'    //         }',
'    //     } );',
'    // }',
'',
'    toolbarGroup.controls.push( {',
'        type: "BUTTON",',
'        action: "selection-delete",',
'        label: "Delete Condition",',
'        icon: null',
'    });',
'    // toolbarGroup.controls.push( {',
'    //     type: "BUTTON",',
'    //     action: "selection-duplicate",',
'    //     iconOnly: true',
'    // });',
'    config.toolbarData = toolbarData;',
'',
'',
'    return config;',
'}'))
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(13618840301770509)
,p_interactive_grid_id=>wwv_flow_imp.id(13610652803717301)
,p_static_id=>'136189'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(13619047375770509)
,p_report_id=>wwv_flow_imp.id(13618840301770509)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(13625096844775822)
,p_view_id=>wwv_flow_imp.id(13619047375770509)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(13611296157717307)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(13643099346057574)
,p_view_id=>wwv_flow_imp.id(13619047375770509)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(13611543809717310)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>63.578100000000006
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(29227121616316995)
,p_view_id=>wwv_flow_imp.id(13619047375770509)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(27185087211440541)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(29228955029317003)
,p_view_id=>wwv_flow_imp.id(13619047375770509)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(27185270555440543)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(29230758553317009)
,p_view_id=>wwv_flow_imp.id(13619047375770509)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(27185494485440545)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>93.64099999999999
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(29231652173317012)
,p_view_id=>wwv_flow_imp.id(13619047375770509)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(27185588295440546)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(29232532173317015)
,p_view_id=>wwv_flow_imp.id(13619047375770509)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(27185617444440547)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(29249794320812903)
,p_view_id=>wwv_flow_imp.id(13619047375770509)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(27185791942440548)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(29266079345797350)
,p_view_id=>wwv_flow_imp.id(13619047375770509)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(29253362674953402)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(12364552605756735)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(12364249052756732)
,p_button_name=>'Add_condition'
,p_button_static_id=>'_add-condition'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'+ Add Condition'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(12365291918756742)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(12364619551756736)
,p_button_name=>'Delete_condition_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'X'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'delete-condition'
,p_button_cattributes=>'condition_id=1'
,p_grid_new_row=>'Y'
,p_grid_column_span=>1
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(12444073356222343)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(12443333615222336)
,p_button_name=>'Delete_condition_2'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'X'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'delete-condition'
,p_button_cattributes=>'condition_id=2'
,p_grid_new_row=>'Y'
,p_grid_column_span=>1
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(18490863387148008)
,p_button_sequence=>30
,p_button_name=>'Hidden_Button'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save'
,p_button_condition=>'P18_ID'
,p_button_condition2=>'naa'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_grid_new_row=>'Y'
,p_grid_column=>10
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15568009320256527)
,p_button_sequence=>40
,p_button_name=>'Save_Submit'
,p_button_static_id=>'btn-submit'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save'
,p_button_condition=>'P18_ID'
,p_button_condition_type=>'ITEM_IS_NULL'
,p_button_css_classes=>'d-center'
,p_icon_css_classes=>'fa-save'
,p_grid_column_css_classes=>'d-center'
,p_grid_new_row=>'Y'
,p_grid_column=>11
,p_database_action=>'INSERT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(18490793784148007)
,p_button_sequence=>50
,p_button_name=>'Update'
,p_button_static_id=>'btn-update'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Update'
,p_button_condition=>'P18_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_button_css_classes=>'d-center'
,p_icon_css_classes=>'fa-save-as'
,p_grid_column_css_classes=>'d-center'
,p_grid_new_row=>'N'
,p_grid_column=>10
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(27182357811440514)
,p_button_sequence=>60
,p_button_name=>'Delete'
,p_button_static_id=>'p18_btn_delete'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Delete'
,p_button_condition=>'P18_ID'
,p_button_condition_type=>'ITEM_IS_NOT_NULL'
,p_button_css_classes=>'d-center'
,p_icon_css_classes=>'fa-trash'
,p_grid_column_css_classes=>'d-center'
,p_grid_new_row=>'N'
,p_grid_column=>11
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(15568112806256528)
,p_button_sequence=>70
,p_button_name=>'Cancel'
,p_button_static_id=>'btn-cancel'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancel'
,p_button_css_classes=>'d-center'
,p_icon_css_classes=>'fa-times-square-o'
,p_grid_column_css_classes=>'d-center'
,p_grid_new_row=>'N'
,p_grid_column=>12
);
end;
/
begin
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(12364099844756730)
,p_branch_name=>'After submit'
,p_branch_action=>'f?p=&APP_ID.:19:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12361780751756707)
,p_name=>'P18_ID'
,p_source_data_type=>'NUMBER'
,p_is_primary_key=>true
,p_is_query_only=>true
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_source=>'ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12361833721756708)
,p_name=>'P18_WF_PROCESS_ID'
,p_source_data_type=>'VARCHAR2'
,p_is_required=>true
,p_is_primary_key=>true
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'   v_new_val VARCHAR2(50);',
'   this_year VARCHAR2(50);',
'BEGIN',
'   SELECT TO_CHAR(EXTRACT(YEAR FROM SYSDATE)) into this_year FROM DUAL;',
'   SELECT ''WORKFLOW'' || this_year || ''-'' || LPAD(MAX(WORKFLOW_NO) + 1, 3, ''0'')',
'   INTO v_new_val',
'   FROM Workflow;',
'   ',
'   IF :P18_WF_PROCESS_ID IS NULL THEN',
'      RETURN v_new_val;',
'   ELSE',
'      RETURN :P18_WF_PROCESS_ID;',
'   END IF;',
'END;',
''))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'ProcessID'
,p_source=>'WF_PROCESS_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
,p_colspan=>4
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'NONE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12361901236756709)
,p_name=>'P18_WF_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT WF_NAME FROM  WORKFLOW ',
'WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID'))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Workflow Name'
,p_source=>'WF_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>100
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12362088138756710)
,p_name=>'P18_WF_DESCRIPTION'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT WF_DESCRIPTION FROM  WORKFLOW ',
'WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID'))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Description'
,p_source=>'WF_DESCRIPTION'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_cMaxlength=>200
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12362188760756711)
,p_name=>'P18_WF_FEATURE_APPLY'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT WF_FEATURE_APPLY FROM  WORKFLOW ',
'WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID'))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Functional Apply'
,p_source=>'WF_FEATURE_APPLY'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'LOV_FEAETURE'
,p_lov=>'.'||wwv_flow_imp.id(12435151142905040)||'.'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'--Choose a feature--'
,p_lov_null_value=>'NA'
,p_cHeight=>1
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12362254054756712)
,p_name=>'P18_WF_CONDITIONAL_ID'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_source=>'WF_CONDITIONAL_ID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12362319657756713)
,p_name=>'P18_WF_EFFECTIVE_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT WF_EFFECTIVE_DATE FROM  WORKFLOW ',
'WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID'))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Effective Date'
,p_source=>'WF_EFFECTIVE_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
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
 p_id=>wwv_flow_imp.id(12362407353756714)
,p_name=>'P18_WF_EXPIRATION_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT WF_EXPIRATION_DATE FROM  WORKFLOW ',
'WHERE WF_PROCESS_ID = :P18_WF_PROCESS_ID'))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Expiration Date'
,p_source=>'WF_EXPIRATION_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
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
 p_id=>wwv_flow_imp.id(12362550284756715)
,p_name=>'P18_WF_MODIFIER_NAME'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_source=>'WF_MODIFIER_NAME'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12362660002756716)
,p_name=>'P18_WF_MODIFIED_DATE'
,p_source_data_type=>'DATE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_source=>'WF_MODIFIED_DATE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12362761824756717)
,p_name=>'P18_WF_MODIFIER_CODE'
,p_source_data_type=>'VARCHAR2'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_source=>'WF_MODIFIER_CODE'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12362850484756718)
,p_name=>'P18_ROWID'
,p_source_data_type=>'ROWID'
,p_is_primary_key=>true
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_source=>'ROWID'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_protection_level=>'S'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12364715115756737)
,p_name=>'CONDITION_DESCRIPTION_NO_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(12364619551756736)
,p_item_default=>'-1'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Employee Code;1,Scholarship Reicipient;2,Program;3,Department;4'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'--Select a type--'
,p_lov_null_value=>'-1'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12364914503756739)
,p_name=>'CONDITION_IS_NOT_NO_1'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(12364619551756736)
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:La\0300;1,Kha\0301c;0')
,p_cHeight=>1
,p_tag_css_classes=>'condition-1'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12365165492756741)
,p_name=>'CONDITION_TARGET_TYPE_NO_1'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(12364619551756736)
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Ba\0309n th\00E2n;1,Ng\01B0\01A1\0300i th\00E2n;2,\0110\00F4\0301i ta\0301c;3,\0110\1ED1i t\00E1c gi\00E1m \0111\1ED1c;4')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12443728637222340)
,p_name=>'CONDITION_DESCRIPTION_NO_2'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(12443333615222336)
,p_item_default=>'-1'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Employee Code;1,Scholarship Reicipient;2,Program;3,Department;4'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'-- Select a type --'
,p_lov_null_value=>'-1'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12443858329222341)
,p_name=>'CONDITION_IS_NOT_NO_2'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(12443333615222336)
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:La\0300;1,Kha\0301c;0')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_tag_css_classes=>'condition-1'
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(12443965064222342)
,p_name=>'CONDITION_TARGET_TYPE_NO_2'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(12443333615222336)
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>unistr('STATIC:Ba\0309n th\00E2n;1,Ng\01B0\01A1\0300i th\00E2n;2,\0110\00F4\0301i ta\0301c;3')
,p_lov_display_null=>'YES'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(13480075328234049)
,p_name=>'P18_TOTAL_CONDITION'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(12364249052756732)
,p_item_default=>'2'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(13611930781717314)
,p_name=>'P18_CONDITION_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(13480182027234050)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15568661900256533)
,p_name=>'P18_WORKFLOW_NO'
,p_source_data_type=>'NUMBER'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_source_plug_id=>wwv_flow_imp.id(11558420122621541)
,p_item_default=>'SELECT MAX(WORKFLOW_NO) + 1 FROM WORKFLOW'
,p_item_default_type=>'SQL_QUERY'
,p_source=>'WORKFLOW_NO'
,p_source_type=>'REGION_SOURCE_COLUMN'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(15568970479256536)
,p_name=>'TOTAL_APPROVAL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(12365355847756743)
,p_item_default=>'0'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(29253244547953401)
,p_name=>'P18_WC_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(13480182027234050)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(27181491763440505)
,p_validation_name=>'P18_WF_EFFECTIVE_DATE'
,p_validation_sequence=>10
,p_validation=>'P18_WF_EFFECTIVE_DATE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please choose a valid date.'
,p_when_button_pressed=>wwv_flow_imp.id(15568009320256527)
,p_associated_item=>wwv_flow_imp.id(12362319657756713)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(27181577370440506)
,p_validation_name=>'P18_WF_NAME'
,p_validation_sequence=>20
,p_validation=>'P18_WF_NAME'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please enter an valid name.'
,p_when_button_pressed=>wwv_flow_imp.id(15568009320256527)
,p_associated_item=>wwv_flow_imp.id(12361901236756709)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(27181666475440507)
,p_validation_name=>'P18_WF_FEATURE_APPLY'
,p_validation_sequence=>30
,p_validation=>'P18_WF_FEATURE_APPLY'
,p_validation2=>'NA'
,p_validation_type=>'ITEM_IN_VALIDATION_NOT_EQ_STRING2'
,p_error_message=>'Please choose a feature to apply.'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_imp.id(15568009320256527)
,p_associated_item=>wwv_flow_imp.id(12362188760756711)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(13611670900717311)
,p_name=>'DA_DELETEROW'
,p_event_sequence=>10
,p_triggering_element_type=>'JQUERY_SELECTOR'
,p_triggering_element=>'.delete-irrow'
,p_bind_type=>'live'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(13611746168717312)
,p_event_id=>wwv_flow_imp.id(13611670900717311)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Confirm'
,p_action=>'NATIVE_CONFIRM'
,p_attribute_01=>unistr('B\1EA1n c\00F3 ch\1EAFc mu\1ED1n xo\00E1 \0111i\1EC1u ki\1EC7n n\00E0y kh\00F4ng?')
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(13611865110717313)
,p_event_id=>wwv_flow_imp.id(13611670900717311)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_name=>'Set Value'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P18_WC_ID'
,p_attribute_01=>'JAVASCRIPT_EXPRESSION'
,p_attribute_05=>'$(this.triggeringElement).parent().data(''id'')'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(13612059849717315)
,p_event_id=>wwv_flow_imp.id(13611670900717311)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_name=>'Execute PLSQL'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>'Delete from WORKFLOW_CONDITIONS where WC_ID = :P18_WC_ID;'
,p_attribute_02=>'P18_WC_ID'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(13612168035717316)
,p_event_id=>wwv_flow_imp.id(13611670900717311)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_name=>'Refresh'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(13480182027234050)
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(15568779106256534)
,p_name=>'Gen Sequence Number'
,p_event_sequence=>20
,p_triggering_element_type=>'COLUMN'
,p_triggering_region_id=>wwv_flow_imp.id(12365355847756743)
,p_triggering_element=>'WA_SEQUENCE_NUMBER'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterrefresh'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(15568858878256535)
,p_event_id=>wwv_flow_imp.id(15568779106256534)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'Gen Sequence Number'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'COLUMN'
,p_affected_elements=>'WA_SEQUENCE_NUMBER'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'SELECT :TOTAL_APPROVAL + 1 FROM DUAL;'
,p_attribute_07=>'TOTAL_APPROVAL'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(15569042400256537)
,p_name=>'Add Approval'
,p_event_sequence=>30
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'$(''#__approval-workflow_ig_toolbar button[data-action="selection-add-row"]'')'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(15569180515256538)
,p_event_id=>wwv_flow_imp.id(15569042400256537)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Increase Total_Approval'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'TOTAL_APPROVAL'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'SELECT :TOTAL_APPROVAL + 1 FROM DUAL'
,p_attribute_07=>'TOTAL_APPROVAL'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(27182205069440513)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Insert WORKFLOW'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'INSERT INTO ',
'WORKFLOW(WF_PROCESS_ID, WF_NAME, WF_DESCRIPTION, WF_FEATURE_APPLY, WF_MODIFIER_CODE, WF_EFFECTIVE_DATE, WF_EXPIRATION_DATE, WORKFLOW_NO)',
'VALUES (:P18_WF_PROCESS_ID, :P18_WF_NAME, :P18_WF_DESCRIPTION, :P18_WF_FEATURE_APPLY, :APP_EMP_CODE, :P18_WF_EFFECTIVE_DATE, :P18_WF_EXPIRATION_DATE, :P18_WORKFLOW_NO);'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15568009320256527)
,p_internal_uid=>27182205069440513
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(18490996616148009)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Update WORKFLOW'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Update WORKFLOW',
'Set',
'    WF_NAME = :P18_WF_NAME,',
'    WF_DESCRIPTION = :P18_WF_DESCRIPTION,',
'    WF_FEATURE_APPLY = :P18_WF_FEATURE_APPLY,',
'    WF_MODIFIER_CODE = :APP_EMP_CODE,',
'    WF_EFFECTIVE_DATE = :P18_WF_EFFECTIVE_DATE,',
'    WF_EXPIRATION_DATE = :P18_WF_EXPIRATION_DATE',
'Where',
'    ID = :P18_ID;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(18490793784148007)
,p_process_success_message=>'Workflow Updated!'
,p_internal_uid=>18490996616148009
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(27182480441440515)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete Workflow'
,p_process_sql_clob=>'Delete from WORKFLOW Where ID = :P18_ID;'
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(27182357811440514)
,p_process_success_message=>'Workflow Updated!'
,p_internal_uid=>27182480441440515
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(27182558509440516)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Delete Workflow_approval'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Delete from WORKFLOW_APPROVAL wa',
'Where wa.WF_PROCESS_ID = :P18_WF_PROCESS_ID;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(27182357811440514)
,p_process_success_message=>'Workflow Updated!'
,p_internal_uid=>27182558509440516
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(15568283611256529)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(12365355847756743)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Save Approval_workflow'
,p_attribute_01=>'TABLE'
,p_attribute_03=>'WORKFLOW_APPROVAL'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15568009320256527)
,p_process_success_message=>'Success!'
,p_internal_uid=>15568283611256529
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(27185810569440549)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(13480182027234050)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Save Approval_Conditions'
,p_attribute_01=>'TABLE'
,p_attribute_03=>'WORKFLOW_CONDITIONS'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15568009320256527)
,p_process_success_message=>'Success!'
,p_internal_uid=>27185810569440549
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(18491067845148010)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(12365355847756743)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Update APPROVAL_WORKFLOW'
,p_attribute_01=>'TABLE'
,p_attribute_03=>'WORKFLOW_APPROVAL'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(18490793784148007)
,p_process_success_message=>'Success!'
,p_internal_uid=>18491067845148010
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(27185922186440550)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(13480182027234050)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Update WORKFLOW_CONDITIONS'
,p_attribute_01=>'TABLE'
,p_attribute_03=>'WORKFLOW_CONDITIONS'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(18490793784148007)
,p_process_success_message=>'Success!'
,p_internal_uid=>27185922186440550
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(13611476794717309)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(13480182027234050)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'iGrid Conditions - Save Interactive Grid Data'
,p_attribute_01=>'REGION_SOURCE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(15568112806256528)
,p_internal_uid=>13611476794717309
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(12361689547756706)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_region_id=>wwv_flow_imp.id(11558420122621541)
,p_process_type=>'NATIVE_FORM_INIT'
,p_process_name=>'Initialize form [SW] New workflow'
,p_internal_uid=>12361689547756706
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
