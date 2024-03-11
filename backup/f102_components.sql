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
,p_release=>'23.2.3'
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
--   Date and Time:   08:13 Sunday March 10, 2024
--   Exported By:     ERP
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PAGE: 10102
--     PAGE: 10101
--   Manifest End
--   Version:         23.2.3
--   Instance ID:     7949320442804181
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/pages/delete_10101
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10101);
end;
/
prompt --application/pages/page_10101
begin
wwv_flow_imp_page.create_page(
 p_id=>10101
,p_name=>'EMP_UDUCATION_UPLOAD_FILE'
,p_alias=>'DEMO-UPLOAD-FILE-EDUCATION'
,p_page_mode=>'MODAL'
,p_step_title=>'Attachments'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/js/custom-file-upload-modal-dialog.js'))
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const is_modal_page = true',
'function _closeDialog() {',
'    parent.document.querySelector(''.ui-dialog-titlebar-close'').click();',
'}'))
,p_css_file_urls=>'https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/css/custom-file-upload.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.ATTACH_GROUP .file-item:first-child {',
'    margin-top: 5px;',
'}',
'#btn_submit {',
'    color: #000000 !important;',
'}',
'div#t_Alert_Notification, .t-Alert--success#t_Alert_Success {',
'    top: unset !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_rejoin_existing_sessions=>'Y'
,p_page_component_map=>'17'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20240310081018'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(45694693667491589)
,p_plug_name=>'Attachments'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>10
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- Loading spinner container -->',
'<div class="loader-container" id="loader-container">',
'    <div class="loader"></div>',
'</div>',
'',
'<script>',
'    // BIND FILE UPLOAD EVENT',
'    // window.addEventListener("load", function () {',
'    // });',
'',
'    // BIND SUBMIT BUTTON EVENT',
'    document.addEventListener(''DOMContentLoaded'', function () {',
'        // Create new object from class CustomFileUpload',
'        const fileUpload = new CustomFileUpload()',
'',
'        // define an object to store all element selector',
'        const eleSelector = {',
'            eleBtnSubmitId: "btn_submit",',
'            eleBtnSubmitApexName: "btn_submit",',
'            eleDefUrl: "P10101_DEFAULT_IMAGES_URL",',
'            eleDefName: "P10101_DEFAULT_IMAGES_NAME",',
'            eleAtt: "P10101_ATTACH",',
'            eleAttCon: "#P10101_ATTACH_CONTAINER",',
'            eleAttUrl: "P10101_ATTACHMENT_URL",',
'            eleAttName: "P10101_ATTACHMENT_NAME",',
'            eleEmpName: "P10101_FULL_NAME",',
'            eleEmpCode: "P10101_EMPLOYEE_CODE",',
'            eleTableId1: "P10101_EMP_EDUCATION_ID",',
'            eleTempId: "P10101_TEMP_ID",',
'            eleDynamicValue: "dynamic-value-page"',
'        }',
'        ',
'        BindFileUploadEvent(fileUpload, eleSelector);',
'        BindEventSubmitBtn(fileUpload, eleSelector);',
'',
'    });',
'</script>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(22952007889327188)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_imp.id(45694693667491589)
,p_button_name=>'btn_submit'
,p_button_static_id=>'btn_submit'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Update'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-arrow-circle-up'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(23666303873578140)
,p_name=>'P10101_TEMP_ID'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(45694693667491589)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45695739482491601)
,p_name=>'P10101_EMP_EDUCATION_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(45694693667491589)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45695907748491602)
,p_name=>'P10101_ATTACH'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(45694693667491589)
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_icon_css_classes=>'fa-arrow-up-alt'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_inline_help_text=>'<strong><em style="color:#0784f9; opacity:0.8;">Please upload files with a maximum size of 1 MB, up to 5 files at a time!</em></strong>'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'Y'
,p_attribute_12=>'INLINE'
,p_attribute_13=>'Upload file'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45695937942491603)
,p_name=>'P10101_ATTACHMENT_URL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(45694693667491589)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45696052361491604)
,p_name=>'P10101_ATTACHMENT_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(45694693667491589)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45696518313491608)
,p_name=>'P10101_DEFAULT_IMAGES_NAME'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(45694693667491589)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CASE',
'    WHEN :P10101_EMP_EDUCATION_ID IS NOT NULL AND not(:P10101_EMP_EDUCATION_ID like ''t%'') THEN',
'        (SELECT ATTACH_NAME FROM EMP_EDUCATION WHERE ID = :P10101_EMP_EDUCATION_ID)',
'    ELSE (SELECT ATTACHMENT_NAME FROM TEMP_UPLOAD WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = ''EMP_EDUCATION'')',
'END AS ATTACHMENT_NAME',
'FROM DUAL'))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45696568817491609)
,p_name=>'P10101_DEFAULT_IMAGES_URL'
,p_data_type=>'CLOB'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(45694693667491589)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CASE',
'    WHEN :P10101_EMP_EDUCATION_ID IS NOT NULL AND not(:P10101_EMP_EDUCATION_ID LIKE ''t%'') THEN',
'        (SELECT ATTACH_URL FROM EMP_EDUCATION WHERE ID = :P10101_EMP_EDUCATION_ID)',
'    ELSE (SELECT ATTACHMENT_URL FROM TEMP_UPLOAD WHERE TEMP_ID = TO_NUMBER(:P10101_TEMP_ID) AND TABLE_NAME = ''EMP_EDUCATION'')',
'END AS ATTACHMENT_URL',
'FROM DUAL',
''))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45696643888491610)
,p_name=>'P10101_FULL_NAME'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(45694693667491589)
,p_item_default=>'select FULL_NAME from EMPLOYEES where EMPLOYEE_CODE = :P10101_EMPLOYEE_CODE'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(45696738692491611)
,p_name=>'P10101_EMPLOYEE_CODE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(45694693667491589)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22955023576327216)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SUBMIT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- *ajax call handle pattern',
'-- DECLARE',
'--     l_json_output CLOB;',
'--     v_parameter_in   VARCHAR2(1000);',
'--     v_result   VARCHAR2(1000);',
'-- BEGIN',
'',
'--     v_parameter_in := :P10101_ATTACHMENT_URL;',
'',
'--     INSERT INTO TABLE_DEMO_1(NAME) ',
'--     VALUES (v_parameter_in);',
'    ',
'--    SELECT v_parameter_in || ''-COMPLETED''',
'',
'--     INTO v_result',
'',
'--     FROM DUAL;',
'',
'--     apex_json.open_object;',
'',
'--     apex_json.write(''success'', true);',
'',
'--     apex_json.write(''result'', v_result);',
'',
'--     apex_json.close_object;',
'',
'    ',
'',
'-- EXCEPTION WHEN OTHERS',
'',
'-- THEN',
'',
'--     apex_json.open_object;',
'',
'--     apex_json.write(''success'', false);',
'',
'--     apex_json.write(''result'', SQLERRM);',
'',
'--     apex_json.close_object;',
'-- END;',
'',
'',
'DECLARE',
'    v_start_time NUMBER;',
'    v_end_time NUMBER;',
'    l_count_temp_id NUMBER;',
'',
'    -- param inputs',
'    v_attachment_url VARCHAR2(1000) := :P10101_ATTACHMENT_URL;',
'    v_attachment_name VARCHAR2(1000) := :P10101_ATTACHMENT_NAME;',
'    v_emp_education_id VARCHAR2(1000) := :P10101_EMP_EDUCATION_ID;',
'    v_temp_id VARCHAR2(1000) := :P10101_TEMP_ID;',
'',
'    -- json outputs and other variables',
'    v_json_output CLOB;',
'    v_result VARCHAR2(1000);',
'    v_error VARCHAR2(1000);',
'',
'BEGIN    ',
'    ',
'    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second',
'    LOOP',
'        v_end_time := DBMS_UTILITY.GET_TIME;',
'        EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds',
'    END LOOP;',
'',
'    if v_emp_education_id IS NOT NULL AND v_emp_education_id != ''t1000'' then',
'        -- Update attachment in EMP_EDUCATION when ID is not null (existing record)',
'        UPDATE',
'            EMP_EDUCATION',
'        SET',
'            ATTACH_URL = v_attachment_url,',
'            ATTACH_NAME = v_attachment_name',
'        WHERE ID = v_emp_education_id;',
'    else',
'        -- Insert/Update TEMP_UPLOAD when ID is null (new record)',
'        SELECT COUNT(*) INTO l_count_temp_id FROM TEMP_UPLOAD WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = ''EMP_EDUCATION'';',
'        if l_count_temp_id > 0 then',
'            UPDATE',
'                TEMP_UPLOAD',
'            SET',
'                ATTACHMENT_URL = v_attachment_url,',
'                ATTACHMENT_NAME = v_attachment_name',
'            WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = ''EMP_EDUCATION'';',
'        else',
'            INSERT INTO TEMP_UPLOAD',
'            (',
'                TABLE_NAME,',
'                TEMP_ID,',
'                ATTACHMENT_URL,',
'                ATTACHMENT_NAME',
'            )',
'            SELECT',
'                ''EMP_EDUCATION'',',
'                :P10101_TEMP_ID,',
'                v_attachment_url,',
'                v_attachment_name',
'            FROM',
'                DUAL;',
'        end if;',
'    end if;',
'',
'    COMMIT;',
'',
'    -- Return result as JSON ',
'    v_result := ''Attachment URL: '' || v_attachment_url || '' - COMPLETED'';',
'    apex_json.open_object;',
'    apex_json.write(''success'', true);',
'    apex_json.write(''result'', v_result);',
'    apex_json.close_object;',
'',
'EXCEPTION',
'    WHEN OTHERS THEN',
'        v_error := SQLERRM;',
'        apex_json.open_object;',
'        apex_json.write(''success'', false);',
'        apex_json.write(''result'', v_error);',
'        apex_json.close_object;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_process_success_message=>'Success!'
,p_internal_uid=>22955023576327216
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(31737031911632342)
,p_process_sequence=>40
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'test_submit_write_json'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_json_output CLOB;',
'    v_parameter_in   VARCHAR2(1000);',
'    v_result   VARCHAR2(1000);',
'BEGIN',
'',
'    v_parameter_in := :P10101_ATTACHMENT_URL;',
'',
'    INSERT INTO TABLE_DEMO_1(NAME) ',
'    VALUES (v_parameter_in);',
'    ',
'   SELECT v_parameter_in || ''-COMPLETED''',
'',
'    INTO v_result',
'',
'    FROM DUAL;',
'',
'    apex_json.open_object;',
'',
'    apex_json.write(''success'', true);',
'',
'    apex_json.write(''result'', v_result);',
'',
'    apex_json.close_object;',
'',
'    ',
'',
'EXCEPTION WHEN OTHERS',
'',
'THEN',
'',
'    apex_json.open_object;',
'',
'    apex_json.write(''success'', false);',
'',
'    apex_json.write(''result'', SQLERRM);',
'',
'    apex_json.close_object;',
'END;',
''))
,p_process_clob_language=>'PLSQL'
,p_process_when=>'unused'
,p_process_when_type=>'REQUEST_EQUALS_CONDITION'
,p_internal_uid=>31737031911632342
);
end;
/
prompt --application/pages/delete_10102
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>10102);
end;
/
prompt --application/pages/page_10102
begin
wwv_flow_imp_page.create_page(
 p_id=>10102
,p_name=>'EMP_CERTIFICATE_UPLOAD_FILE'
,p_alias=>'EMP-CERTIFICATE-UPLOAD-FILE'
,p_page_mode=>'MODAL'
,p_step_title=>'Attachments'
,p_autocomplete_on_off=>'OFF'
,p_javascript_file_urls=>'https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/js/custom-file-upload-modal-dialog.js'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const is_modal_page = true',
'',
'function UPDATE_EMP_CERTIFICATE_ATTACHMENT(item_id, attachment_url, attachment_name)',
'{',
'         apex.server.process( ''UPDATE_EMP_CERTIFICATE_ATTACHMENT'',',
'            {',
'                x01: item_id,',
'                x02: attachment_url,',
'                x03: attachment_name',
'            },  // Parameter to be passed to the server',
'            {',
'                success: function (pData) {             // Success',
'                    console.log(pData);',
'                },',
'                error: function(e){',
'                    console.log("Error: ", e);',
'                },',
'                dataType: "json"                        // Response type',
'            }',
'        );',
'}',
'',
'function _closeDialog() {',
'  parent.document.querySelector(''.ui-dialog-titlebar-close'').click();',
'} ',
'',
''))
,p_css_file_urls=>'https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/css/custom-file-upload.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.ATTACH_GROUP .file-item:first-child {',
'    margin-top: 5px;',
'}',
'#btn_submit {',
'    color: #000000 !important;',
'}',
'div#t_Alert_Notification, .t-Alert--success#t_Alert_Success {',
'    top: unset !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'17'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20240310081132'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(68712773265223601)
,p_plug_name=>'Upload Attachment'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>10
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- Loading spinner container -->',
'<div class="loader-container" id="loader-container">',
'    <div class="loader"></div>',
'</div>',
'',
'<script>',
'    // BIND FILE UPLOAD EVENT',
'    // window.addEventListener("load", function () {',
'    // });',
'',
'    // BIND SUBMIT BUTTON EVENT',
'    document.addEventListener(''DOMContentLoaded'', function () {',
'        // Create new object from class CustomFileUpload',
'        const fileUpload = new CustomFileUpload()',
'',
'        // define an object to store all element selector',
'        const eleSelector = {',
'            eleBtnSubmitId: "btn_submit",',
'            eleBtnSubmitApexName: "btn_submit",',
'            eleDefUrl: "P10102_DEFAULT_IMAGES_URL",',
'            eleDefName: "P10102_DEFAULT_IMAGES_NAME",',
'            eleAtt: "P10102_ATTACH",',
'            eleAttCon: "#P10102_ATTACH_CONTAINER",',
'            eleAttUrl: "P10102_ATTACHMENT_URL",',
'            eleAttName: "P10102_ATTACHMENT_NAME",',
'            eleEmpName: "P10102_FULL_NAME",',
'            eleEmpCode: "P10102_EMPLOYEE_CODE",',
'            eleTableId1: "P10102_EMP_CERTIFICATE_ID",',
'            eleTempId: "P10102_TEMP_ID",',
'            eleDynamicValue: "dynamic-value-page"',
'        }',
'        ',
'        BindFileUploadEvent(fileUpload, eleSelector);',
'        BindEventSubmitBtn(fileUpload, eleSelector);',
'',
'    });',
'</script>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(23018674785732016)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_imp.id(68712773265223601)
,p_button_name=>'btn_submit'
,p_button_static_id=>'btn_submit'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Update'
,p_warn_on_unsaved_changes=>null
,p_icon_css_classes=>'fa-arrow-circle-up'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(24802346605944243)
,p_name=>'P10102_TEMP_ID'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(68712773265223601)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68714778680223618)
,p_name=>'P10102_EMP_CERTIFICATE_ID'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(68712773265223601)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68714946946223619)
,p_name=>'P10102_ATTACH'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(68712773265223601)
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_icon_css_classes=>'fa-arrow-up-alt'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_inline_help_text=>'<strong><em style="color:#0784f9; opacity:0.8;">Please upload files with a maximum size of 1 MB, up to 5 files at a time!</em></strong>'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'Y'
,p_attribute_12=>'INLINE'
,p_attribute_13=>'Upload file'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68714977140223620)
,p_name=>'P10102_ATTACHMENT_URL'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(68712773265223601)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68715091559223621)
,p_name=>'P10102_ATTACHMENT_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(68712773265223601)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68715557511223625)
,p_name=>'P10102_DEFAULT_IMAGES_NAME'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(68712773265223601)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CASE',
'    WHEN :P10102_EMP_CERTIFICATE_ID IS NOT NULL AND not(:P10102_EMP_CERTIFICATE_ID LIKE ''t%'') THEN',
'        (SELECT ATTACHMENT_NAME FROM EMP_CERTIFICATE WHERE ID = :P10102_EMP_CERTIFICATE_ID)',
'    ELSE (SELECT ATTACHMENT_NAME FROM TEMP_UPLOAD WHERE TEMP_ID = to_number(:P10102_TEMP_ID) AND TABLE_NAME = ''EMP_CERTIFICATE'')',
'END AS ATTACHMENT_NAME',
'FROM DUAL'))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68715608015223626)
,p_name=>'P10102_DEFAULT_IMAGES_URL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(68712773265223601)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT CASE',
'    WHEN :P10102_EMP_CERTIFICATE_ID IS NOT NULL AND not(:P10102_EMP_CERTIFICATE_ID like ''t%'') THEN',
'        (SELECT ATTACHMENT_URL FROM EMP_CERTIFICATE WHERE ID = :P10102_EMP_CERTIFICATE_ID)',
'    ELSE (SELECT ATTACHMENT_URL FROM TEMP_UPLOAD WHERE TEMP_ID = to_number(:P10102_TEMP_ID) AND TABLE_NAME = ''EMP_CERTIFICATE'')',
'END AS ATTACHMENT_URL',
'FROM DUAL'))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68715683086223627)
,p_name=>'P10102_FULL_NAME'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(68712773265223601)
,p_item_default=>'select FULL_NAME from EMPLOYEES where EMPLOYEE_CODE = :P10102_EMPLOYEE_CODE'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(68715777890223628)
,p_name=>'P10102_EMPLOYEE_CODE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(68712773265223601)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23021622540732020)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SUBMIT'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- template',
'-- -- *ajax call handle pattern',
'-- -- DECLARE',
'-- --     l_json_output CLOB;',
'-- --     v_parameter_in   VARCHAR2(1000);',
'-- --     v_result   VARCHAR2(1000);',
'-- -- BEGIN',
'',
'-- --     v_parameter_in := :P10101_ATTACHMENT_URL;',
'',
'-- --     INSERT INTO TABLE_DEMO_1(NAME) ',
'-- --     VALUES (v_parameter_in);',
'    ',
'-- --    SELECT v_parameter_in || ''-COMPLETED''',
'',
'-- --     INTO v_result',
'',
'-- --     FROM DUAL;',
'',
'-- --     apex_json.open_object;',
'',
'-- --     apex_json.write(''success'', true);',
'',
'-- --     apex_json.write(''result'', v_result);',
'',
'-- --     apex_json.close_object;',
'',
'    ',
'',
'-- -- EXCEPTION WHEN OTHERS',
'',
'-- -- THEN',
'',
'-- --     apex_json.open_object;',
'',
'-- --     apex_json.write(''success'', false);',
'',
'-- --     apex_json.write(''result'', SQLERRM);',
'',
'-- --     apex_json.close_object;',
'-- -- END;',
'',
'',
'-- DECLARE',
'--     v_start_time NUMBER;',
'--     v_end_time NUMBER;',
'--     l_count_temp_id NUMBER;',
'',
'--     -- param inputs',
'--     v_attachment_url VARCHAR2(1000) := :P10101_ATTACHMENT_URL;',
'--     v_attachment_name VARCHAR2(1000) := :P10101_ATTACHMENT_NAME;',
'--     v_emp_education_id VARCHAR2(1000) := :P10101_EMP_EDUCATION_ID;',
'--     v_temp_id VARCHAR2(1000) := :P10101_TEMP_ID;',
'',
'--     -- json outputs and other variables',
'--     v_json_output CLOB;',
'--     v_result VARCHAR2(1000);',
'--     v_error VARCHAR2(1000);',
'',
'-- BEGIN    ',
'    ',
'--     v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second',
'--     LOOP',
'--         v_end_time := DBMS_UTILITY.GET_TIME;',
'--         EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds',
'--     END LOOP;',
'',
'--     if v_emp_education_id IS NOT NULL AND v_emp_education_id != ''t1000'' then',
'--         -- Update attachment in EMP_EDUCATION when ID is not null (existing record)',
'--         UPDATE',
'--             EMP_EDUCATION',
'--         SET',
'--             ATTACH_URL = v_attachment_url,',
'--             ATTACH_NAME = v_attachment_name',
'--         WHERE ID = v_emp_education_id;',
'--     else',
'--         -- Insert/Update TEMP_UPLOAD when ID is null (new record)',
'--         SELECT COUNT(*) INTO l_count_temp_id FROM TEMP_UPLOAD WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = ''EMP_EDUCATION'';',
'--         if l_count_temp_id > 0 then',
'--             UPDATE',
'--                 TEMP_UPLOAD',
'--             SET',
'--                 ATTACHMENT_URL = v_attachment_url,',
'--                 ATTACHMENT_NAME = v_attachment_name',
'--             WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = ''EMP_EDUCATION'';',
'--         else',
'--             INSERT INTO TEMP_UPLOAD',
'--             (',
'--                 TABLE_NAME,',
'--                 TEMP_ID,',
'--                 ATTACHMENT_URL,',
'--                 ATTACHMENT_NAME',
'--             )',
'--             SELECT',
'--                 ''EMP_EDUCATION'',',
'--                 :P10101_TEMP_ID,',
'--                 v_attachment_url,',
'--                 v_attachment_name',
'--             FROM',
'--                 DUAL;',
'--         end if;',
'--     end if;',
'',
'--     COMMIT;',
'',
'--     -- Return result as JSON ',
'--     v_result := ''Attachment URL: '' || v_attachment_url || '' - COMPLETED'';',
'--     apex_json.open_object;',
'--     apex_json.write(''success'', true);',
'--     apex_json.write(''result'', v_result);',
'--     apex_json.close_object;',
'',
'-- EXCEPTION',
'--     WHEN OTHERS THEN',
'--         v_error := SQLERRM;',
'--         apex_json.open_object;',
'--         apex_json.write(''success'', false);',
'--         apex_json.write(''result'', v_error);',
'--         apex_json.close_object;',
'',
'-- END;',
'-- end of template',
'',
'DECLARE',
'    l_count_temp_id number;',
'',
'    -- param inputs',
'    v_attachment_url VARCHAR2(1000) := :P10102_ATTACHMENT_URL;',
'    v_attachment_name VARCHAR2(1000) := :P10102_ATTACHMENT_NAME;',
'    v_emp_certificate_id VARCHAR2(1000) := :P10102_EMP_CERTIFICATE_ID;',
'    v_temp_id VARCHAR2(1000) := :P10102_TEMP_ID;',
'',
'    -- json outputs and other variables',
'    v_json_output CLOB;',
'    v_result VARCHAR2(1000);',
'    v_error VARCHAR2(1000);',
'BEGIN    ',
'    ',
'    -- v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second',
'    -- LOOP',
'    --     v_end_time := DBMS_UTILITY.GET_TIME;',
'    --     EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds',
'    -- END LOOP;',
'     ',
'    IF v_emp_certificate_id IS NOT NULL AND v_emp_certificate_id != ''t1000'' THEN',
'        -- Update attachment in EMP_CERTIFICATE when ID is not null (existing record)',
'        UPDATE EMP_CERTIFICATE ',
'        SET ATTACHMENT_URL = v_attachment_url, ',
'            ATTACHMENT_NAME = v_attachment_name ',
'        WHERE ID = v_emp_certificate_id;',
'    ELSE',
'        -- Insert/Update TEMP_UPLOAD when ID is null (new record)',
'        SELECT COUNT(*) INTO l_count_temp_id FROM TEMP_UPLOAD WHERE TEMP_ID = v_temp_id AND TABLE_NAME = ''EMP_CERTIFICATE'';',
'        IF l_count_temp_id > 0 THEN',
'            UPDATE TEMP_UPLOAD ',
'            SET ATTACHMENT_URL = v_attachment_url, ',
'                ATTACHMENT_NAME = v_attachment_name ',
'            WHERE TEMP_ID = v_temp_id AND TABLE_NAME = ''EMP_CERTIFICATE'';',
'        ELSE',
'            INSERT INTO TEMP_UPLOAD ',
'            (',
'                TABLE_NAME, ',
'                TEMP_ID, ',
'                ATTACHMENT_URL, ',
'                ATTACHMENT_NAME',
'            ) ',
'            SELECT ',
'                ''EMP_CERTIFICATE'', ',
'                v_temp_id, ',
'                v_attachment_url, ',
'                v_attachment_name ',
'            FROM DUAL;',
'        END IF;',
'    END IF;',
'',
'    COMMIT;',
'',
'    -- Return result as JSON',
'    v_result := ''Attachment URL: '' || v_attachment_url || '' - COMPLETED'';',
'    apex_json.open_object;',
'    apex_json.write(''success'', true);',
'    apex_json.write(''result'', v_result);',
'    apex_json.close_object;',
'',
'EXCEPTION',
'    WHEN OTHERS THEN',
'        v_error := SQLERRM;',
'        apex_json.open_object;',
'        apex_json.write(''success'', false);',
'        apex_json.write(''result'', v_error);',
'        apex_json.close_object;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_process_success_message=>'Success!'
,p_internal_uid=>23021622540732020
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(31737296394632344)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SUBMIT_OLD'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- TEMP_UPLOAD',
'-- ID	NUMBER(10,0)',
'-- TABLE_NAME	NVARCHAR2(30 CHAR)',
'-- TEMP_ID	NUMBER(10,0)',
'-- ATTACHMENT_URL	VARCHAR2(2000 CHAR)',
'-- ATTACHMENT_NAME	VARCHAR2(1000 CHAR)',
'',
'-- LOGS_UPLOAD_FILE',
'-- ID	NUMBER',
'-- ATTACH_URL	CLOB',
'-- ATTACH_NAME	CLOB',
'-- EMPLOYEE_CODE	NVARCHAR2(30 CHAR)',
'-- TABLE_NAME	NVARCHAR2(30 CHAR)',
'-- TIMESTAMP	TIMESTAMP(6)',
'-- NOTE	NVARCHAR2(100 CHAR)',
'-- TABLE_ID	NUMBER(7,0)',
'',
'DECLARE',
'    v_start_time NUMBER;',
'    v_end_time NUMBER;',
'    l_count_temp_id number;',
'BEGIN    ',
'    ',
'    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second',
'    LOOP',
'        v_end_time := DBMS_UTILITY.GET_TIME;',
'        EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds',
'    END LOOP;',
'',
'    -- if :P10101_EMP_EDUCATION_ID IS NOT NULL AND :P10101_EMP_EDUCATION_ID not like ''t%'' then',
'    --     -- Update attachment in EMP_EDUCATION when ID is not null (existing record)',
'    --     UPDATE',
'    --         EMP_EDUCATION',
'    --     SET',
'    --         ATTACH_URL = :P10101_ATTACHMENT_URL,',
'    --         ATTACH_NAME = :P10101_ATTACHMENT_NAME',
'    --     WHERE ID = :P10101_EMP_EDUCATION_ID;',
'    -- else',
'    --     -- Insert/Update TEMP_UPLOAD when ID is null (new record)',
'    --     SELECT COUNT(*) INTO l_count_temp_id FROM TEMP_UPLOAD WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = ''EMP_EDUCATION'';',
'    --     if l_count_temp_id > 0 then',
'    --         UPDATE',
'    --             TEMP_UPLOAD',
'    --         SET',
'    --             ATTACHMENT_URL = :P10101_ATTACHMENT_URL,',
'    --             ATTACHMENT_NAME = :P10101_ATTACHMENT_NAME',
'    --         WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = ''EMP_EDUCATION'';',
'    --     else',
'    --         INSERT INTO TEMP_UPLOAD',
'    --         (',
'    --             TABLE_NAME,',
'    --             TEMP_ID,',
'    --             ATTACHMENT_URL,',
'    --             ATTACHMENT_NAME',
'    --         )',
'    --         SELECT',
'    --             ''EMP_EDUCATION'',',
'    --             :P10101_TEMP_ID,',
'    --             :P10101_ATTACHMENT_URL,',
'    --             :P10101_ATTACHMENT_NAME',
'    --         FROM',
'    --             DUAL;',
'    --     end if;',
'    -- end if;',
'     ',
'    IF :P10102_EMP_CERTIFICATE_ID IS NOT NULL AND :P10102_EMP_CERTIFICATE_ID != ''t1000'' THEN',
'        -- Update attachment in EMP_CERTIFICATE when ID is not null (existing record)',
'        UPDATE EMP_CERTIFICATE ',
'        SET ATTACHMENT_URL = :P10102_ATTACHMENT_URL, ',
'            ATTACHMENT_NAME = :P10102_ATTACHMENT_NAME ',
'        WHERE ID = :P10102_EMP_CERTIFICATE_ID;',
'    ELSE',
'        -- Insert/Update TEMP_UPLOAD when ID is null (new record)',
'        SELECT COUNT(*) INTO l_count_temp_id FROM TEMP_UPLOAD WHERE TEMP_ID = :P10102_TEMP_ID AND TABLE_NAME = ''EMP_CERTIFICATE'';',
'        IF l_count_temp_id > 0 THEN',
'            UPDATE TEMP_UPLOAD ',
'            SET ATTACHMENT_URL = :P10102_ATTACHMENT_URL, ',
'                ATTACHMENT_NAME = :P10102_ATTACHMENT_NAME ',
'            WHERE TEMP_ID = :P10102_TEMP_ID AND TABLE_NAME = ''EMP_CERTIFICATE'';',
'        ELSE',
'            INSERT INTO TEMP_UPLOAD ',
'            (',
'                TABLE_NAME, ',
'                TEMP_ID, ',
'                ATTACHMENT_URL, ',
'                ATTACHMENT_NAME',
'            ) ',
'            SELECT ',
'                ''EMP_CERTIFICATE'', ',
'                :P10102_TEMP_ID, ',
'                :P10102_ATTACHMENT_URL, ',
'                :P10102_ATTACHMENT_NAME ',
'            FROM DUAL;',
'        END IF;',
'    END IF;',
'',
'    -- write logs ',
'    -- INSERT INTO LOGS_UPLOAD_FILE',
'    -- (',
'    --     ATTACH_URL,',
'    --     ATTACH_NAME,',
'    --     EMPLOYEE_CODE,',
'    --     TABLE_NAME,',
'    --     TIMESTAMP,',
'    --     NOTE,',
'    --     TABLE_ID',
'    -- )',
'    -- SELECT',
'    --     :P10102_ATTACHMENT_URL,',
'    --     :P10102_ATTACHMENT_NAME,',
'    --     :P10102_EMPLOYEE_CODE,',
'    --     ''EMP_CERTIFICATE'',',
'    --     SYSDATE,',
'    --     ''page 10102'',',
'    --     :P10102_EMP_CERTIFICATE_ID',
'    -- FROM DUAL;',
'',
'    COMMIT;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_process_success_message=>'Success!'
,p_internal_uid=>31737296394632344
);
end;
/
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
--commit;
end;
/
set verify on feedback on define on
prompt  ...done
