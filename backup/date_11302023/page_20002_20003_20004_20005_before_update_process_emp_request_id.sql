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
--   Date and Time:   18:43 Wednesday November 29, 2023
--   Exported By:     ERP
--   Flashback:       0
--   Export Type:     Component Export
--   Manifest
--     PAGE: 20002
--     PAGE: 20004
--     PAGE: 20005
--     PAGE: 20003
--   Manifest End
--   Version:         23.1.5
--   Instance ID:     7949320442804181
--

begin
  -- replace components
  wwv_flow_imp.g_mode := 'REPLACE';
end;
/
prompt --application/pages/delete_20002
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>20002);
end;
/
prompt --application/pages/page_20002
begin
wwv_flow_imp_page.create_page(
 p_id=>20002
,p_name=>'new_scholarship_request'
,p_alias=>'NEW-SCHOLARSHIP-REQUEST'
,p_step_title=>'Scholarship Request'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#P20002_REASON_REQUEST, #P20002_NOTE{',
'    height: 80px !important;',
'}',
'.btn-delete{',
'    color: white;font-size: 12px;cursor: pointer;background: red !important;display: block;width: 20px;height:20px;text-align: center;border-radius: 50%;',
'}',
'.file-item{',
'    display:flex; gap:10px;margin:15px;',
'    z-index: 100;',
'}',
'.apex-item-filedrop-filename {',
'    display: none;',
'}',
'.apex-item-group.apex-item-group--file.apex-item-group--file-browse {',
'    margin-top: 0 !important;',
'    height: max-content !important;',
'}',
'#btn_submit {',
'    color: #000000 !important;',
'}',
'/* #btn_submit_process {',
'    display: none;',
'} */',
'#P20002_ATTACHMENT_inline_help',
'{',
'    font-style: italic;',
'    color: #0784f9;',
'    opacity: 0.8;',
'    font-weight: bold;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20231129182121'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(22026153205485913)
,p_plug_name=>'Breadcrumb'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18712759415889069)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(18597660344888957)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(18774898137889124)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(33692524022872527)
,p_plug_name=>'ADD NEW'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(18710165183889068)
,p_plug_display_sequence=>20
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(34168569592087178)
,p_plug_name=>'Scholarship information'
,p_parent_plug_id=>wwv_flow_imp.id(33692524022872527)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(34169195617087184)
,p_plug_name=>'Request/ Department Request Information'
,p_parent_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(34169845502087191)
,p_plug_name=>'Partner Information'
,p_parent_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>30
,p_plug_grid_row_css_classes=>'region_partner'
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(34169968023087192)
,p_plug_name=>'Scholarship Information'
,p_parent_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>50
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(34256032275617202)
,p_plug_name=>'Information Of Recipient'
,p_parent_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>40
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- Loading spinner container -->',
'<div class="loader-container" id="loader-container">',
'    <div class="loader"></div>',
'</div>',
'',
'<script>',
'    // GLOBAL FUNCTION',
'',
'    // Get current date formatted as dd-mm-yyyy',
'    function getCurrentDateFormatted() {',
'        const currentDate = new Date();',
'',
'        const day = String(currentDate.getDate()).padStart(2, ''0'');',
'        const month = String(currentDate.getMonth() + 1).padStart(2, ''0''); // Months are zero-based, so add 1',
'        const year = currentDate.getFullYear();',
'',
'        return `${day}-${month}-${year}`;',
'    }',
'',
'    // Delete a value from a FormData object',
'    function deleteValue(formData, key, value) {',
'        const values = formData.getAll(key);',
'        const updatedValues = values.filter(v => v !== value);',
'',
'        // Remove all values associated with the key',
'        formData.delete(key);',
'',
'        // Append the updated values back to the FormData object',
'        updatedValues.forEach(updatedValue => {',
'            formData.append(key, updatedValue);',
'        });',
'    }',
'',
'    function handleDeleteClick_PP(event) {',
'        if (event.target.classList.contains("delete-item")) {',
'            const itemToRemove = event.target.closest("div");',
'            const name = event.target.dataset.name;',
'            const url = itemToRemove.querySelector("a").getAttribute("href");',
'            const files = formData_PP.getAll("files");',
'            const updatedFiles = files.filter((file) => file.name !== name);',
'            formData_PP.delete("files");',
'            fileArrayNames_PP = fileArrayNames_PP.filter((item) => item !== name);',
'            fileArrayUrls_PP = fileArrayNames_PP.filter((item) => item !== url);',
'            updatedFiles.forEach((file) => formData_PP.append("files", file));',
'            if (itemToRemove) {',
'                itemToRemove.remove();',
'                document.getElementById("loader-container").style.display = "none";',
'            }',
'        }',
'    }',
'</script>',
'',
'<script>',
'    let formData_PP = new FormData();',
'    let fileNames_PP;',
'    let fileUrls_PP;',
'    let fileArrayNames_PP = [];',
'    let fileArrayUrls_PP = [];',
'',
'    //  Get default values from hidden items',
'    window.addEventListener("load", function () {',
'        var imageUrlsID = apex.item("P20002_DEFAULT_IMAGES_URL").getValue();',
'        var imageNamesID = apex.item("P20002_DEFAULT_IMAGES_NAME").getValue();',
'        var imageContainer = document.getElementById("P20002_ATTACHMENT_GROUP");',
'        const urlArray = imageUrlsID.split(";");',
'        const nameArray = imageNamesID.split(";");',
'        apex.item("P20002_URL_FILES").setValue(imageUrlsID);',
'        apex.item("P20002_NAME_FILES").setValue(imageNamesID);',
'',
'        // Create hidden input elements for each default image',
'        for (let i = 0; i < urlArray.length; i++) {',
'            const imageUrl = urlArray[i];',
'            const imageName = nameArray[i];',
'            fileArrayNames_PP.push(imageName);',
'            fileArrayUrls_PP.push(imageUrl);',
'            let hiddenInputHTML;',
'            if (imageUrl != "" || imageName != "") {',
'                hiddenInputHTML = `',
'        <div class="file-item ">',
'            <span  id="deleteItem${imageName}" data-name="${imageName}" class="delete-item btn-delete vng-true"> X </span>',
'            <a name="${imageName}" href="${imageUrl}" target="_blank" class="dynamic-value-page">',
'                ${imageName}',
'            </a>',
'        </div>',
'    `;',
'            } else {',
'                hiddenInputHTML = ``;',
'            }',
'            imageContainer.insertAdjacentHTML("beforeend", hiddenInputHTML);',
'        }',
'',
'        var deleteButtons = document.querySelectorAll(".btn-delete");',
'        deleteButtons.forEach(function (button) {',
'            button.addEventListener("click", handleDeleteClick_PP);',
'        });',
'',
'        // Hide delete buttons when STATUS is not DRAFT',
'        if($v("P20002_STATUS") != 1) {',
'            $(''.delete-item.btn-delete'').hide();',
'            $(''#P20002_ATTACHMENT_inline_help'').hide();',
'        }',
'',
'        var userName = apex.item("P20002_USER_FULLNAME").getValue();',
'        var userCode = apex.item("P20002_USER_EMPLOYEE_CODE").getValue();',
'',
'        formData_PP.append("name", userName);',
'        formData_PP.append("msnv", userCode);',
'        document',
'            .getElementById("P20002_ATTACHMENT")',
'            .addEventListener("change", function (event) {',
'                const imageFiles = event.target.files;',
'                const hiddenInputContainer = document.getElementById(',
'                    "P20002_ATTACHMENT_GROUP"',
'                );',
'                const maxFileSize = 1 * 1024 * 1024; // 1MB in bytes',
'',
'                formData_PP.append("date", getCurrentDateFormatted());',
'                console.log(getCurrentDateFormatted());',
'',
'                for (const imageFile of imageFiles) {',
'                    const fileName = imageFile.name;',
'                    const fileURL = URL.createObjectURL(imageFile);',
'                    if (imageFile.size > maxFileSize) {',
'                        // Show an error message or take appropriate action',
'                        alert(',
'                            `File ${fileName} is larger than 1MB. Please choose a smaller file.`',
'                        );',
'                        continue; // Skip this file',
'                    }',
'',
'                    formData_PP.append("files", imageFile);',
'',
'                    const hiddenInputHTML = `',
'        <div class="file-item id-numb-file">',
'            <a href="${fileURL}" target="_blank">',
'                ${fileName}',
'            </a>',
'            <span id="deleteItem${fileName}" data-name="${fileName}" class="delete-item btn-delete"> X </span>',
'        </div>',
'      `;',
'                    hiddenInputContainer.insertAdjacentHTML("beforeend", hiddenInputHTML);',
'                }',
'                hiddenInputContainer.addEventListener("click", handleDeleteClick_PP);',
'            });',
'    });',
'',
'    //UPLOAD FILE',
'    //SUBMIT FORM',
'',
'    document.addEventListener(''DOMContentLoaded'', function () {',
'        // Select all buttons by their IDs',
'        const buttons = document.querySelectorAll(''#save_submit_button, #submit_button, #save_button, #update_button'');',
'',
'        // Iterate through the buttons and add click event listeners to each',
'        buttons.forEach(function (button) {',
'            button.addEventListener(''click'', async function (event) {',
'                // Print btn id',
'                let apex_id_btn = '''';',
'                // set apex_id_btn = case save_submit_button -> T1_SAVE_SUBMIT, submit_button -> T1_SUBMIT, save_button -> T1_SAVE, update_button -> T1_UPDATE',
'                switch (this.id) {',
'                    case ''save_submit_button'':',
'                        apex_id_btn = ''T1_SAVE_SUBMIT'';',
'                        break;',
'                    case ''submit_button'':',
'                        apex_id_btn = ''T1_SUBMIT'';',
'                        break;',
'                    case ''save_button'':',
'                        apex_id_btn = ''T1_SAVE'';',
'                        break;',
'                    case ''update_button'':',
'                        apex_id_btn = ''T1_UPDATE'';',
'                        break;',
'                    default:',
'                        break;',
'                }',
'                console.log(apex_id_btn);',
'',
'                let nullFormData = false;',
'                const elements = document.querySelectorAll(".dynamic-value-page");',
'                const names = [];',
'                const hrefs = [];',
'                var imageNamesID = apex.item("P20002_DEFAULT_IMAGES_NAME").getValue();',
'                const nameArray = imageNamesID.split(";");',
'',
'                // document.getElementById(''loader-container'').style.display = ''block'';',
'                for (const value of formData_PP.values()) {',
'                    if (value.name != null) {',
'                        nullFormData = true;',
'                    }',
'                }',
'',
'                if (nullFormData) {',
'                    try {',
'                        const response = await fetch("https://graphapi.vus.edu.vn/upload", {',
'                            method: "POST",',
'                            body: formData_PP,',
'                        });',
'',
'                        if (response.status === 200) {',
'                            const responseBody = await response.json();',
'                            fileNames_PP = responseBody.data.map((item) => item.name).join(";");',
'                            fileUrls_PP = responseBody.data.map((item) => item.path).join(";");',
'                            const newfileUrls_PP = fileArrayUrls_PP.join(";") + ";" + fileUrls_PP;',
'                            const newfileNames_PP = fileArrayNames_PP.join(";") + ";" + fileNames_PP;',
'                            await apex.item("P20002_URL_FILES").setValue(newfileUrls_PP);',
'                            await apex.item("P20002_NAME_FILES").setValue(newfileNames_PP);',
'                        } else {',
'                            console.log("Upload failed");',
'                        }',
'                    } catch (error) {',
'                        console.error("An error occurred:", error);',
'                    } finally {',
'                        document.getElementById("loader-container").style.display = "none";',
'',
'                        setTimeout(function () {',
'                            apex.submit(apex_id_btn);',
'                        }, 500);',
'                        // apex.submit("btn_submit");',
'                    }',
'                } else {',
'                    await elements.forEach((element) => {',
'                        const name = element.getAttribute("name");',
'                        const href = element.getAttribute("href");',
'',
'                        if (name && href) {',
'                            names.push(name);',
'                            hrefs.push(href);',
'                        }',
'                    });',
'                    namesString = names.join(";");',
'                    urlString = hrefs.join(";");',
'                    const missingValuesNameId = await nameArray.filter(',
'                        (value) => !names.includes(value)',
'                    );',
'                    const urlDelete =',
'                        "https://graphapi.vus.edu.vn/delete-multiple-objects-vng-cloud";',
'',
'                    const data = {',
'                        fileNames: missingValuesNameId,',
'                    };',
'',
'                    console.log(missingValuesNameId);',
'                    const requestOptions = {',
'                        method: "POST",',
'                        headers: {',
'                            "Content-Type": "application/json",',
'                        },',
'                        body: JSON.stringify(data),',
'                    };',
'                    try {',
'                        await fetch(urlDelete, requestOptions)',
'                            .then((response) => {',
'                                if (!response.ok) {',
'                                    throw new Error("Network response was not ok");',
'                                }',
'                                return response.json();',
'                            })',
'                            .then((data) => {',
'                                console.log(data);',
'                            });',
'                    } catch (error) {',
'                        console.error("Error:", error);',
'                    } finally {',
'                        document.getElementById("loader-container").style.display = "none";',
'                    }',
'',
'                    await apex.item("P20002_URL_FILES").setValue(urlString);',
'                    await apex.item("P20002_NAME_FILES").setValue(namesString);',
'',
'                    setTimeout(function () {',
'                        apex.submit(apex_id_btn);',
'                    }, 500);',
'                }',
'                document.getElementById("loader-container").style.display = "none";',
'            });',
'        });',
'    });',
'',
'    //END SUBMIT FORM',
'',
'</script>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(62320224995033757)
,p_plug_name=>'View workflow details'
,p_parent_plug_id=>wwv_flow_imp.id(33692524022872527)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P20002_REQUEST_ID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(62323558752033790)
,p_plug_name=>'WORKFLOW_DETAILS'
,p_parent_plug_id=>wwv_flow_imp.id(62320224995033757)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select wd.ID,',
'       wd.WD_MODIFIED_DATE,',
'       wd.WD_MODIFIED_CODE,',
'       e.FULL_NAME,',
'       wd.WD_COMMENT,',
'       wd.STATUS',
'  from WORKFLOW_DETAIL wd',
'  join EMPLOYEES e on wd.WD_MODIFIED_CODE = e.EMPLOYEE_CODE',
'  where REQUEST_ID = :P20002_REQUEST_ID;'))
,p_plug_source_type=>'NATIVE_IG'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'WORKFLOW_DETAILS'
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
 p_id=>wwv_flow_imp.id(22027154816485923)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(25896101346579947)
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
 p_id=>wwv_flow_imp.id(49768033984949527)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>10
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
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(49768147071949528)
,p_name=>'WD_MODIFIED_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WD_MODIFIED_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Modified date'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_imp.id(49768318237949530)
,p_name=>'WD_COMMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WD_COMMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Comment'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
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
 p_id=>wwv_flow_imp.id(49770559888949552)
,p_name=>'WD_MODIFIED_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WD_MODIFIED_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(49770651171949553)
,p_name=>'FULL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FULL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Modified by'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_imp.id(62324157266033796)
,p_internal_uid=>62324157266033796
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>false
,p_toolbar_buttons=>null
,p_enable_save_public_report=>true
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(62398649820494379)
,p_interactive_grid_id=>wwv_flow_imp.id(62324157266033796)
,p_static_id=>'129652'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(62398869921494380)
,p_report_id=>wwv_flow_imp.id(62398649820494379)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(22699805536073070)
,p_view_id=>wwv_flow_imp.id(62398869921494380)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(22027154816485923)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(49773991105951344)
,p_view_id=>wwv_flow_imp.id(62398869921494380)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(49768033984949527)
,p_is_visible=>false
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(49774903393951348)
,p_view_id=>wwv_flow_imp.id(62398869921494380)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(49768147071949528)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>316
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(49776689636951354)
,p_view_id=>wwv_flow_imp.id(62398869921494380)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(49768318237949530)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>315
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(49973088741083865)
,p_view_id=>wwv_flow_imp.id(62398869921494380)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(49770559888949552)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(49973937295083869)
,p_view_id=>wwv_flow_imp.id(62398869921494380)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(49770651171949553)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>328
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(62324537756061964)
,p_plug_name=>'Attachment history'
,p_parent_plug_id=>wwv_flow_imp.id(33692524022872527)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'ITEM_IS_NOT_NULL'
,p_plug_display_when_condition=>'P20002_REQUEST_ID'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(62328996362062008)
,p_plug_name=>'ATTACHMENT_HISTORY'
,p_parent_plug_id=>wwv_flow_imp.id(62324537756061964)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ah.ID,',
'        ah.ATTACHMENT_DATE,',
'       e.FULL_NAME,',
'       TO_HREF_HTML_ATTACHMENT(ah.ATTACHMENT_URL, ah.ATTACHMENT_NAME) as attachment',
'from ATTACHMENT_HISTORY ah',
'join EMPLOYEES e on e.EMPLOYEE_CODE = ah.EMPLOYEE_CODE',
'where  ah.REQUEST_ID = (select ID from EMP_REQUESTS er where er.REQUEST_DETAIL_ID = :P20002_REQUEST_ID and rownum = 1)'))
,p_plug_source_type=>'NATIVE_IG'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'ATTACHMENT_HISTORY'
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
 p_id=>wwv_flow_imp.id(25096308487455620)
,p_name=>'ATTACHMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATTACHMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Attachment'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'LEFT'
,p_attribute_05=>'HTML'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_exact_match=>true
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(25096483810455621)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Id'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>10
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>true
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
 p_id=>wwv_flow_imp.id(49775790205977768)
,p_name=>'ATTACHMENT_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATTACHMENT_DATE'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Attachment date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_imp.id(49776088753977771)
,p_name=>'FULL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FULL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Attachment by'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_imp.id(62329122800062009)
,p_internal_uid=>62329122800062009
,p_is_editable=>false
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
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
end;
/
begin
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(62415465347602950)
,p_interactive_grid_id=>wwv_flow_imp.id(62329122800062009)
,p_static_id=>'129778'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(62415679158602950)
,p_report_id=>wwv_flow_imp.id(62415465347602950)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(25700451944094831)
,p_view_id=>wwv_flow_imp.id(62415679158602950)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(25096308487455620)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(25705411863181037)
,p_view_id=>wwv_flow_imp.id(62415679158602950)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(25096483810455621)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>55
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(50114978641259279)
,p_view_id=>wwv_flow_imp.id(62415679158602950)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(49775790205977768)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>145
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(50116780222259286)
,p_view_id=>wwv_flow_imp.id(62415679158602950)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(49776088753977771)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>198
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21284965111734530)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_button_name=>'T1_SAVE_SUBMIT'
,p_button_static_id=>'save_submit_button'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save & Submit'
,p_button_position=>'CHANGE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P20002_STATUS'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21299590730734551)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(62320224995033757)
,p_button_name=>'T2_CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:20003:&SESSION.::&DEBUG.:20002::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21303816230734566)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(62324537756061964)
,p_button_name=>'T3_CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:20003:&SESSION.::&DEBUG.:20002::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(22025932692485911)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_button_name=>'T1_SUBMIT'
,p_button_static_id=>'submit_button'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_position=>'CHANGE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P20002_STATUS'
,p_button_condition2=>'1'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21285326290734531)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_button_name=>'T1_SAVE'
,p_button_static_id=>'save_button'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save'
,p_button_position=>'CHANGE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P20002_STATUS'
,p_button_condition_type=>'ITEM_IS_NULL'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21751104994265950)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_button_name=>'T1_UPDATE'
,p_button_static_id=>'update_button'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Update'
,p_button_position=>'CHANGE'
,p_warn_on_unsaved_changes=>null
,p_button_condition=>'P20002_STATUS'
,p_button_condition2=>'1'
,p_button_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(25262947810676331)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_button_name=>'T1_DELETE'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Delete'
,p_button_position=>'CHANGE'
,p_warn_on_unsaved_changes=>null
,p_confirm_message=>'Confirm agreement to delete this request?'
,p_confirm_style=>'warning'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    if :P20002_STATUS is null then',
'        return false;',
'    else',
'        if :P20002_STATUS = 1 or :P20002_STATUS = 2 then',
'            return true;',
'        else',
'            return false;',
'        end if;',
'    end if;',
'end;'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'FUNCTION_BODY'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21285737517734532)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_button_name=>'T1_CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:20003:&SESSION.::&DEBUG.:20002::'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(21344203060734609)
,p_branch_name=>'redirect to page 25_save_submit'
,p_branch_action=>'f?p=&APP_ID.:20003:&SESSION.::&DEBUG.:20002::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(21284965111734530)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(22026019664485912)
,p_branch_name=>'redirect to page 25_submit'
,p_branch_action=>'f?p=&APP_ID.:20003:&SESSION.::&DEBUG.:20002::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(22025932692485911)
,p_branch_sequence=>20
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(21344674316734610)
,p_branch_name=>'redirect to page 25_save'
,p_branch_action=>'f?p=&APP_ID.:20003:&SESSION.::&DEBUG.:20002::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(21285326290734531)
,p_branch_sequence=>30
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(25263107273676333)
,p_branch_name=>'redirect to page 25_update'
,p_branch_action=>'f?p=&APP_ID.:20003:&SESSION.::&DEBUG.:20002::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(21751104994265950)
,p_branch_sequence=>40
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(25263208703676334)
,p_branch_name=>'redirect to page 25_delete'
,p_branch_action=>'f?p=&APP_ID.:20003:&SESSION.::&DEBUG.:20002::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(25262947810676331)
,p_branch_sequence=>50
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(22025734655485909)
,p_branch_name=>'redirect to page 25_cancel'
,p_branch_action=>'f?p=&APP_ID.:20003:&SESSION.::&DEBUG.:20002::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(21285737517734532)
,p_branch_sequence=>60
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(23031407175956650)
,p_name=>'P20002_IS_HR_ADMIN'
,p_item_sequence=>70
,p_item_default=>'SELECT IS_HR_ADMIN FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
,p_item_comment=>unistr('bi\1EBFn ki\1EC3m tra c\00F3 ph\1EA3i l\00E0 role HR_ADMIN hay kh\00F4ng')
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25095239917455609)
,p_name=>'P20002_ATTACHMENT'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_pre_element_text=>'Upload File'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_grid_column_css_classes=>'P20002_ATTACHMENT'
,p_read_only_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'not(:P20002_REQUEST_ID is null or :P20002_STATUS = 1)',
''))
,p_read_only_when2=>'PLSQL'
,p_read_only_when_type=>'EXPRESSION'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_icon_css_classes=>'fa-arrow-up-alt'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'Y'
,p_attribute_12=>'INLINE'
,p_attribute_13=>'Upload File'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25095301637455610)
,p_name=>'P20002_DEFAULT_IMAGES_NAME'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select ATTACH_NAME into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25095474952455611)
,p_name=>'P20002_DEFAULT_IMAGES_URL'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select ATTACH_FILE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25095527683455612)
,p_name=>'P20002_USER_FULLNAME'
,p_item_sequence=>40
,p_item_default=>'SELECT FULL_NAME FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25095669179455613)
,p_name=>'P20002_USER_EMPLOYEE_CODE'
,p_item_sequence=>50
,p_item_default=>'APP_EMP_CODE'
,p_item_default_type=>'ITEM'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25262812778676330)
,p_name=>'P20002_STATUS'
,p_item_sequence=>60
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
,p_item_comment=>unistr('d\00F9ng \0111\1EC3 l\01B0u ''status'' c\1EE7a request v\00E0 s\1EED d\1EE5ng n\00F3 l\00E0m \0111i\1EC1u ki\1EC7n')
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25264128196676343)
,p_name=>'P20002_LEVEL_ID'
,p_item_sequence=>80
,p_item_default=>'SELECT LEVEL_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
,p_item_comment=>unistr('bi\1EBFn ki\1EC3m tra c\00F3 ph\1EA3i l\00E0 role HR_ADMIN hay kh\00F4ng')
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34173099540087238)
,p_name=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    temp nvarchar2(1000);',
'begin',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_TYPE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       return temp;',
'    ELSE',
'      RETURN 0;',
'    END IF;',
'end;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Scholarship recipient'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov_language=>'PLSQL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    temp nvarchar2(1000);',
'    -- p_level nvarchar2(5);',
'begin',
'    -- select nvl(LEVEL_ID, ''null'') ',
'    -- into p_level ',
'    -- from EMPLOYEES ',
'    -- where :APP_EMP_CODE = EMPLOYEE_CODE;',
'',
'    if:P20002_IS_HR_ADMIN = 1 or lower(:P20002_LEVEL_ID) = ''c'' then',
'    -- if to_number(:P20002_IS_HR_ADMIN) = ''1'' then',
'        temp := ''',
unistr('                select ''''Nh\00E2n vi\00EAn'''' as d, ''''A'''' as r from dual '),
'                union all',
unistr('                select ''''Ng\01B0\1EDDi th\00E2n nh\00E2n vi\00EAn'''' as d, ''''B'''' as r from dual '),
'                union all',
unistr('                select ''''\0110\1ED1i t\00E1c'''' as d, ''''C'''' as r from dual '),
'                union all',
unistr('                select ''''\0110\1ED1i t\00E1c c\1EE7a gi\00E1m \0111\1ED1c'''' as d, ''''D'''' as r from dual'),
'                '';',
'    else',
'        temp := ''',
unistr('                select ''''Nh\00E2n vi\00EAn'''' as d, ''''A'''' as r from dual '),
'                union all',
unistr('                select ''''Ng\01B0\1EDDi th\00E2n nh\00E2n vi\00EAn'''' as d, ''''B'''' as r from dual '),
'                union all',
unistr('                select ''''\0110\1ED1i t\00E1c'''' as d, ''''C'''' as r from dual'),
'                '';',
'    end if;',
'    return temp;',
'end;'))
,p_lov_cascade_parent_items=>'P20002_IS_HR_ADMIN,P20002_LEVEL_ID'
,p_ajax_items_to_submit=>'P20002_IS_HR_ADMIN,P20002_LEVEL_ID'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_colspan=>5
,p_grid_column_css_classes=>'P20002_SCHOLARSHIP_RECIPIENT'
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
 p_id=>wwv_flow_imp.id(34173239861087239)
,p_name=>'P20002_PROGRAM'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(34168569592087178)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    temp nvarchar2(1000);',
'begin',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select PROGRAM into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       return temp;',
'    ELSE',
'       RETURN null;',
'    END IF;',
'end;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Program'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'COREEDU_PROGRAM'
,p_lov=>'.'||wwv_flow_imp.id(13812202134933262)||'.'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_grid_column_css_classes=>'P20002_PROGRAM'
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
 p_id=>wwv_flow_imp.id(34174417345087243)
,p_name=>'P20002_REQUEST_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(34169195617087184)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select emp.EMPLOYEE_CODE into temp ',
'       from EMPLOYEES emp ',
'       join SCHOLARSHIP_REQUEST sr ',
'       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE ',
'       where sr.ID = :P20002_REQUEST_ID;',
'       ',
'       --select EMPLOYEE_CODE into temp from EMPLOYEES where USER_NAME = :APP_USER_NAME;',
'       RETURN temp;',
'    ELSE',
'       RETURN NULL;',
'    END IF;',
'END;',
'',
''))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Requester name'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'select FULL_NAME || '' - '' || EMPLOYEE_CODE as DISPLAY_VALUE, EMPLOYEE_CODE as RETURN_VALUE from EMPLOYEES'
,p_cSize=>30
,p_colspan=>4
,p_grid_column=>1
,p_grid_column_css_classes=>'P20002_REQUEST_NAME'
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
 p_id=>wwv_flow_imp.id(34174571702087244)
,p_name=>'P20002_EMPLOYEE_CODE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(34169195617087184)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select REQUESTER_CODE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'    --    select :APP_EMP_CODE into temp from DUAL;',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Employee code'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_column=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34174610586087245)
,p_name=>'P20002_DEPARTMENT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(34169195617087184)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select REQUESTER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'    --    SELECT DEPARTMENT_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Department'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'select DISTINCT DEPARTMENT_NAME from EMPLOYEES;'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_column=>9
,p_grid_column_css_classes=>'P20002_DEPARTMENT'
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
 p_id=>wwv_flow_imp.id(34174777247087246)
,p_name=>'P20002_LEVEL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(34169195617087184)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select LEVEL_DESCRIPTION from EMPLOYEES where USER_NAME = :APP_USER_NAME;',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'    --    SELECT LEVEL_DESCRIPTION INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Level'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34174874366087247)
,p_name=>'P20002_START_DATE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(34169195617087184)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select START_DATE from EMPLOYEES where USER_NAME = :APP_USER_NAME;',
'',
'DECLARE',
'    temp DATE;',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       select emp.START_DATE into temp ',
'       from EMPLOYEES emp ',
'       join SCHOLARSHIP_REQUEST sr ',
'       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE ',
'       where sr.ID = :P20002_REQUEST_ID;',
'',
'       RETURN temp;',
'    ELSE',
'    --    SELECT START_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'       ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;',
'',
''))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Start date'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(34174947056087248)
,p_name=>'P20002_TERMINATION_DATE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(34169195617087184)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select TERMINATE_DATE from employees where USER_NAME = :APP_USER_NAME;',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       select emp.TERMINATE_DATE into temp ',
'       from EMPLOYEES emp ',
'       join SCHOLARSHIP_REQUEST sr ',
'       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE ',
'       where sr.ID = :P20002_REQUEST_ID;',
'',
'       RETURN temp;',
'    ELSE',
'    --    SELECT TERMINATE_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'       ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;',
'',
''))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Termination date'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(34178006715087254)
,p_name=>'P20002_PARTNER_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(34169845502087191)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_NAME into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Partner name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34178071626087255)
,p_name=>'P20002_TITLE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(34169845502087191)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_TITLE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Title'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34178165940087256)
,p_name=>'P20002_PARTNER_PHONE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(34169845502087191)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_PHONE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Phone'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEL'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34178240842087257)
,p_name=>'P20002_PARTNER_DEPARTMENT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(34169845502087191)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Department'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'SHOLARSHIP_PARTNER_DEPARTMENT'
,p_lov=>'.'||wwv_flow_imp.id(14998911392347814)||'.'
,p_cSize=>30
,p_colspan=>4
,p_grid_column_css_classes=>'P20002_PARTNER_DEPARTMENT'
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
 p_id=>wwv_flow_imp.id(34178336919087258)
,p_name=>'P20002_FIELD'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(34169845502087191)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_FIELD into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Field'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'SCHOLARSHIP_PARTNER_FIELD'
,p_lov=>'.'||wwv_flow_imp.id(15001826986365695)||'.'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_column_css_classes=>'P20002_FIELD'
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
 p_id=>wwv_flow_imp.id(34180691841087262)
,p_name=>'P20002_DISCOUNT_RATE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(34169968023087192)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp number;',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select DISCOUNT_RATE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Discount rate'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov_language=>'PLSQL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_sql nvarchar2(1000);',
'begin',
'    v_sql := ''SELECT',
'                ''''voucher '''' || DISCOUNT_RATE || ''''%'''' as DISPLAY_VALUE, ',
'                DISCOUNT_RATE as RETURN_VALUE',
'              FROM ',
'                COREEDU_PROMOTION ',
'              WHERE ',
'                PROGRAM = :P20002_PROGRAM',
'              ORDER BY DISCOUNT_RATE DESC'';',
'    RETURN v_sql;',
'end;'))
,p_lov_cascade_parent_items=>'P20002_PROGRAM'
,p_ajax_items_to_submit=>'P20002_PROGRAM'
,p_ajax_optimize_refresh=>'N'
,p_cSize=>30
,p_colspan=>4
,p_grid_column_css_classes=>'P20002_DISCOUNT_RATE'
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
 p_id=>wwv_flow_imp.id(34180770566087263)
,p_name=>'P20002_VOUCHER_CODE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(34169968023087192)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select VOUCHER_CODE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Voucher code'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34180853017087264)
,p_name=>'P20002_NUMBER_OF_COURSES'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(34169968023087192)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp NVARCHAR2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select NUMBER_OF_COURSES into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Number of courses'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34180961260087265)
,p_name=>'P20002_EFFECTIVE_DATE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(34169968023087192)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp DATE;',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select EFFECTIVE_DATE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Effective date'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
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
end;
/
begin
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34181071617087266)
,p_name=>'P20002_EXPIRATION_DATE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(34169968023087192)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp DATE;',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select EXPIRATION_DATE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Expiration date'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'ITEM'
,p_attribute_05=>'P20002_EFFECTIVE_DATE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34181141073087267)
,p_name=>'P20002_APPROVED_DATE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(34169968023087192)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp DATE;',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select APPROVED_DATE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Approved date'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(34260271606617250)
,p_name=>'P20002_DEPARTMENT_CODE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(34169195617087184)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select REQUESTER_DEPARTMENT_CODE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'    --    SELECT DEPARTMENT_ID INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Department code'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_column=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34264557413617269)
,p_name=>'P20002_WORKPLACE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(34169845502087191)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_WORKPLACE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Work Place ',
'(State Agencies)'))
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34269455970617271)
,p_name=>'P20002_RECIPIENT_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select RECIPIENT_NAME from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = id;',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_NAME into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Full name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34269523187617272)
,p_name=>'P20002_RECIPIENT_DOB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp DATE;',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_DOB into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'DOB'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(34269610285617273)
,p_name=>'P20002_RECIPIENT_PHONE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_PHONE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Phone'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEL'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34269685506617274)
,p_name=>'P20002_RELATIONSHIP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_RELATIONSHIP into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Relationship with requester'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'SCHOLARSHIP_RELATIONSHIP'
,p_lov=>'.'||wwv_flow_imp.id(14989626799293948)||'.'
,p_cSize=>30
,p_colspan=>4
,p_grid_column_css_classes=>'P20002_RELATIONSHIP'
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
 p_id=>wwv_flow_imp.id(34269790605617275)
,p_name=>'P20002_CAMPUS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select RECIPIENT_CAMPUS from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = id;',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_CAMPUS into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Campus'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT UNIT_NAME FROM DEPARTMENT_CAMPUS WHERE UNIT_TYPE LIKE ''Business unit'' AND UNIT_NUMBER <> ''00000401'';',
''))
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_column_css_classes=>'P20002_CAMPUS'
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
 p_id=>wwv_flow_imp.id(34270140532617278)
,p_name=>'P20002_REASON_REQUEST'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_REASON_REQUEST into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Reason request'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>20000
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34270626525617283)
,p_name=>'P20002_NOTE'
,p_item_sequence=>190
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_NOTE into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Note'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>20000
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34270718492617284)
,p_name=>'P20002_REPLACEMENT'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- SELECT sr.RECIPIENT_NAME || '' - '' || sr.RECIPIENT_DOB, sr.VOUCHER_CODE as ID',
'-- FROM SCHOLARSHIP_REQUEST sr',
'-- WHERE sr.REQUESTER_CODE = :P20002_EMPLOYEE_CODE AND sr.RECIPIENT_RELATIONSHIP != 1;',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Replacement for',
'(if any)'))
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT RECIPIENT_NAME || '' - '' || RECIPIENT_DOB as DISPLAY_VALUE, VOUCHER_CODE as RETURN_VALUE',
'FROM SCHOLARSHIP_REQUEST',
'WHERE REQUESTER_CODE = :APP_EMP_CODE ',
'AND RECIPIENT_TYPE = ''B''',
'AND RECIPIENT_RELATIONSHIP != 1',
'AND STATUS != 7',
'AND ID != :P20002_REQUEST_ID;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'------------'
,p_lov_cascade_parent_items=>'P20002_REQUEST_ID'
,p_ajax_items_to_submit=>'P20002_REQUEST_ID'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_grid_column_css_classes=>'P20002_REPLACEMENT'
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
 p_id=>wwv_flow_imp.id(34270835255617285)
,p_name=>'P20002_VOUCHER_CODE_REPLACEMENT'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_VOUCHER_CODE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Voucher code',
'(replacement)'))
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34270916463617286)
,p_name=>'P20002_EXPIRATION_DATE_REPLACEMENT'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp date;',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_EXPIRATION_DATE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Expiration date',
'(replacement)'))
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(36334283201932774)
,p_name=>'P20002_URL_FILES'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(36334466033932775)
,p_name=>'P20002_NAME_FILES'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(34256032275617202)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(36653840634537876)
,p_name=>'P20002_REQUEST_NAME_AB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(34169195617087184)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select FULL_NAME from EMPLOYEES where USER_NAME = :APP_USER_NAME',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       select emp.FULL_NAME into temp ',
'       from EMPLOYEES emp ',
'       join SCHOLARSHIP_REQUEST sr ',
'       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE ',
'       where sr.ID = :P20002_REQUEST_ID;',
'',
'       RETURN temp;',
'    ELSE',
'    --    SELECT FULL_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'       ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;',
'',
''))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Requester name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_column=>1
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(36852969279991070)
,p_name=>'P20002_FEATURE_APPLY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(33692524022872527)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(39545121902339755)
,p_name=>'P20002_REQUEST_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(33692524022872527)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40856584023434055)
,p_name=>'P20002_LINE_MANAGER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(33692524022872527)
,p_item_default=>'SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(40856680804434056)
,p_name=>'P20002_SCHOLARSHIP_DETAIL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(33692524022872527)
,p_item_default=>'select SCHOLARSHIP_DETAIL_ID.nextval from dual'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(41987032504027024)
,p_name=>'P20002_FEATURE'
,p_item_sequence=>30
,p_item_default=>'Scholarship'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21307827313734577)
,p_validation_name=>'btn_save_submit_check_P20002_SCHOLARSHIP_RECIPIENT'
,p_validation_sequence=>10
,p_validation=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please select a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(34173099540087238)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21746486058265903)
,p_validation_name=>'btn_save_submit_check_P20002_PROGRAM'
,p_validation_sequence=>20
,p_validation=>'P20002_PROGRAM'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please select a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(34173239861087239)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21747601409265915)
,p_validation_name=>'btn_save_submit_check_P20002_RECIPIENT_NAME'
,p_validation_sequence=>30
,p_validation=>'P20002_RECIPIENT_NAME'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(34269455970617271)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21747749364265916)
,p_validation_name=>'btn_save_submit_check_P20002_RECIPIENT_DOB'
,p_validation_sequence=>40
,p_validation=>'P20002_RECIPIENT_DOB'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(34269523187617272)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21746819748265907)
,p_validation_name=>'btn_save_submit_check_P20002_RECIPIENT_PHONE'
,p_validation_sequence=>50
,p_validation=>'P20002_RECIPIENT_PHONE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(34269610285617273)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21750921717265948)
,p_validation_name=>'btn_save_submit_check_P20002_RELATIONSHIP'
,p_validation_sequence=>60
,p_validation=>'P20002_RELATIONSHIP'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(34269685506617274)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21747908028265918)
,p_validation_name=>'btn_save_submit_check_P20002_PARTNER_NAME'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20002_SCHOLARSHIP_RECIPIENT = ''C'' or :P20002_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20002_PARTNER_NAME IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''PARTNER_NAME'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''PARTNER_NAME'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(34178006715087254)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21748269771265921)
,p_validation_name=>'btn_save_submit_check_P20002_PARTNER_PHONE'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20002_SCHOLARSHIP_RECIPIENT = ''C'' or :P20002_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20002_PARTNER_PHONE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''PARTNER_PHONE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''PARTNER_PHONE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(34178165940087256)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21748308255265922)
,p_validation_name=>'btn_save_submit_check_P20002_WORKPLACE'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20002_SCHOLARSHIP_RECIPIENT = ''C'' or :P20002_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20002_WORKPLACE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''WORKPLACE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''WORKPLACE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(34264557413617269)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21748400423265923)
,p_validation_name=>'btn_save_submit_check_P20002_DISCOUNT_RATE'
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20002_SCHOLARSHIP_RECIPIENT = ''C'' or :P20002_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20002_DISCOUNT_RATE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''DISCOUNT_RATE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''DISCOUNT_RATE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(34180691841087262)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21748523121265924)
,p_validation_name=>'btn_save_submit_check_P20002_EXPIRATION_DATE'
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20002_SCHOLARSHIP_RECIPIENT = ''C'' or :P20002_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20002_EXPIRATION_DATE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''EXPIRATION_DATE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''EXPIRATION_DATE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(34181071617087266)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(25096907364455626)
,p_validation_name=>'btn_save_submit_check_P20002_ATTACHMENT'
,p_validation_sequence=>120
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN',
'    IF :P20002_ATTACHMENT IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''EXPIRATION_DATE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''EXPIRATION_DATE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please attach a file to verify the relationship.'
,p_always_execute=>'Y'
,p_validation_condition=>'T1_UPDATE, T1_SAVE, T1_SUBMIT, T1_SAVE_SUBMIT'
,p_validation_condition_type=>'REQUEST_IN_CONDITION'
,p_associated_item=>wwv_flow_imp.id(25095239917455609)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_validation_comment=>unistr('B\1EAFt bu\1ED9c \0111\00EDnh k\00E8m file ch\1EE9ng minh quan h\1EC7.')
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21425563950215922)
,p_name=>'Set Read Only pk'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_REQUEST_ID'
,p_condition_element=>'P20002_REQUEST_ID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
,p_display_when_type=>'REQUEST_EQUALS_CONDITION'
,p_display_when_cond=>'disable'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21425608627215923)
,p_event_id=>wwv_flow_imp.id(21425563950215922)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'',
'$(''.P20002_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20002_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'$(''#P20002_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').addClass(''apex_disabled'');',
'',
'$(''.P20002_DISCOUNT_RATE'').addClass(''apex_disabled'');           ',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE'').addClass(''apex_disabled'');',
'',
'// remove',
'$(''#P20002_PARTNER_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_PARTNER_PHONE'').removeClass(''apex_disabled'');',
'$(''#P20002_TITLE'').removeClass(''apex_disabled'');',
'$(''.P20002_PARTNER_DEPARTMENT'').removeClass(''apex_disabled'');',
'$(''.P20002_FIELD'').removeClass(''apex_disabled'');',
'$(''#P20002_WORKPLACE'').removeClass(''apex_disabled'');',
'',
'$(''#P20002_RECIPIENT_PHONE'').removeClass(''apex_disabled'');      ',
'$(''.P20002_CAMPUS'').removeClass(''apex_disabled'');                     ',
'$(''#P20002_UPLOAD_FILE'').removeClass(''apex_disabled'');',
'$(''#P20002_URL_FILES'').removeClass(''apex_disabled'');',
'$(''#P20002_NAME_FILES'').removeClass(''apex_disabled'');',
'$(''.P20002_REPLACEMENT'').removeClass(''apex_disabled'');                ',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').removeClass(''apex_disabled'');',
'',
'$(''#P20002_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'$(''#P20002_NOTE'').removeClass(''apex_disabled'');                ',
'',
'',
'',
'',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_SCHOLARSHIP_RECIPIENT") === "A" ',
'// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")'))
);
end;
/
begin
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21428305596215950)
,p_event_id=>wwv_flow_imp.id(21425563950215922)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20002_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20002_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_RECIPIENT_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_PHONE'').removeClass(''apex_disabled'');      ',
'$(''.P20002_RELATIONSHIP'').removeClass(''apex_disabled'');',
'$(''.P20002_CAMPUS'').removeClass(''apex_disabled'');                     ',
'$(''#P20002_UPLOAD_FILE'').removeClass(''apex_disabled'');',
'$(''#P20002_URL_FILES'').removeClass(''apex_disabled'');',
'$(''#P20002_NAME_FILES'').removeClass(''apex_disabled'');',
'',
'',
'$(''.P20002_REPLACEMENT'').removeClass(''apex_disabled'');                ',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20002_NOTE'').removeClass(''apex_disabled'');  ',
'$(''#P20002_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'',
'',
'$(''.P20002_DISCOUNT_RATE'').addClass(''apex_disabled'');           ',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_PARTNER_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_PARTNER_PHONE'').removeClass(''apex_disabled'');',
'$(''#P20002_TITLE'').removeClass(''apex_disabled'');',
'$(''.P20002_PARTNER_DEPARTMENT'').removeClass(''apex_disabled'');',
'$(''.P20002_FIELD'').removeClass(''apex_disabled'');',
'$(''#P20002_WORKPLACE'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_SCHOLARSHIP_RECIPIENT") === "B" ',
'// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21746211360265901)
,p_event_id=>wwv_flow_imp.id(21425563950215922)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''.P20002_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20002_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_RECIPIENT_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_PHONE'').removeClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').removeClass(''apex_disabled'');            ',
'$(''.P20002_CAMPUS'').removeClass(''apex_disabled'');                     ',
'$(''#P20002_UPLOAD_FILE'').removeClass(''apex_disabled'');',
'$(''#P20002_URL_FILES'').removeClass(''apex_disabled'');',
'$(''#P20002_NAME_FILES'').removeClass(''apex_disabled'');',
'',
'',
'$(''.P20002_REPLACEMENT'').removeClass(''apex_disabled'');                ',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_NOTE'').removeClass(''apex_disabled'');  ',
'$(''#P20002_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'',
'',
'$(''.P20002_DISCOUNT_RATE'').addClass(''apex_disabled'');           ',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_PARTNER_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_PARTNER_PHONE'').removeClass(''apex_disabled'');',
'$(''#P20002_TITLE'').removeClass(''apex_disabled'');',
'$(''.P20002_PARTNER_DEPARTMENT'').removeClass(''apex_disabled'');',
'$(''.P20002_FIELD'').removeClass(''apex_disabled'');',
'$(''#P20002_WORKPLACE'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_SCHOLARSHIP_RECIPIENT") === "C" ',
'// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21746379336265902)
,p_event_id=>wwv_flow_imp.id(21425563950215922)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''.P20002_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20002_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_RECIPIENT_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_PHONE'').removeClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').removeClass(''apex_disabled'');            ',
'$(''.P20002_CAMPUS'').removeClass(''apex_disabled'');                     ',
'$(''#P20002_UPLOAD_FILE'').removeClass(''apex_disabled'');',
'$(''#P20002_URL_FILES'').removeClass(''apex_disabled'');',
'$(''#P20002_NAME_FILES'').removeClass(''apex_disabled'');',
'',
'',
'$(''.P20002_REPLACEMENT'').removeClass(''apex_disabled'');                ',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_NOTE'').removeClass(''apex_disabled'');  ',
'$(''#P20002_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'',
'',
'$(''.P20002_DISCOUNT_RATE'').addClass(''apex_disabled'');           ',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_PARTNER_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_PARTNER_PHONE'').removeClass(''apex_disabled'');',
'$(''#P20002_TITLE'').removeClass(''apex_disabled'');',
'$(''.P20002_PARTNER_DEPARTMENT'').removeClass(''apex_disabled'');',
'$(''.P20002_FIELD'').removeClass(''apex_disabled'');',
'$(''#P20002_WORKPLACE'').removeClass(''apex_disabled'');',
'',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_SCHOLARSHIP_RECIPIENT") === "D" ',
'// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25264283689676344)
,p_event_id=>wwv_flow_imp.id(21425563950215922)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''.P20002_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20002_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_PHONE'').addClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').addClass(''apex_disabled'');            ',
'$(''.P20002_CAMPUS'').addClass(''apex_disabled'');                     ',
'$(''#P20002_UPLOAD_FILE'').addClass(''apex_disabled'');',
'$(''#P20002_URL_FILES'').addClass(''apex_disabled'');',
'$(''#P20002_NAME_FILES'').addClass(''apex_disabled'');',
'',
'',
'$(''.P20002_REPLACEMENT'').addClass(''apex_disabled'');                ',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20002_NOTE'').addClass(''apex_disabled'');  ',
'$(''#P20002_REASON_REQUEST'').addClass(''apex_disabled'');             ',
'',
'',
'$(''.P20002_DISCOUNT_RATE'').addClass(''apex_disabled'');           ',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_PARTNER_NAME'').addClass(''apex_disabled'');',
'$(''#P20002_PARTNER_PHONE'').addClass(''apex_disabled'');',
'$(''#P20002_TITLE'').addClass(''apex_disabled'');',
'$(''.P20002_PARTNER_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''.P20002_FIELD'').addClass(''apex_disabled'');',
'$(''#P20002_WORKPLACE'').addClass(''apex_disabled'');',
'',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_STATUS") === 3 || $v("P20002_STATUS") === 4 || $v("P20002_STATUS") === 6 || $v("P20002_STATUS") === 7;  ',
'// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(25264345884676345)
,p_name=>'Set Read Only for status'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_STATUS'
,p_condition_element=>'P20002_STATUS'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25264440971676346)
,p_event_id=>wwv_flow_imp.id(25264345884676345)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'',
'$(''.P20002_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20002_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'$(''#P20002_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').addClass(''apex_disabled'');',
'',
'$(''.P20002_DISCOUNT_RATE'').addClass(''apex_disabled'');           ',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'',
'// remove',
'$(''#P20002_PARTNER_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_PARTNER_PHONE'').removeClass(''apex_disabled'');',
'$(''#P20002_TITLE'').removeClass(''apex_disabled'');',
'$(''.P20002_PARTNER_DEPARTMENT'').removeClass(''apex_disabled'');',
'$(''.P20002_FIELD'').removeClass(''apex_disabled'');',
'$(''#P20002_WORKPLACE'').removeClass(''apex_disabled'');',
'',
'$(''#P20002_RECIPIENT_PHONE'').removeClass(''apex_disabled'');      ',
'$(''.P20002_CAMPUS'').removeClass(''apex_disabled'');                     ',
'$(''#P20002_UPLOAD_FILE'').removeClass(''apex_disabled'');',
'$(''#P20002_URL_FILES'').removeClass(''apex_disabled'');',
'$(''#P20002_NAME_FILES'').removeClass(''apex_disabled'');',
'$(''.P20002_REPLACEMENT'').removeClass(''apex_disabled'');                ',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').removeClass(''apex_disabled'');',
'',
'$(''#P20002_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'$(''#P20002_NOTE'').removeClass(''apex_disabled'');  ',
'$(''#P20002_EXPIRATION_DATE'').removeClass(''apex_disabled'');',
'',
'',
'',
'',
'',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_STATUS") == 1 && $v("P20002_SCHOLARSHIP_RECIPIENT") === "A"',
'// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25264569315676347)
,p_event_id=>wwv_flow_imp.id(25264345884676345)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20002_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20002_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_RECIPIENT_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_PHONE'').removeClass(''apex_disabled'');      ',
'$(''.P20002_RELATIONSHIP'').removeClass(''apex_disabled'');',
'$(''.P20002_CAMPUS'').removeClass(''apex_disabled'');                     ',
'// $(''#P20002_UPLOAD_FILE'').removeClass(''apex_disabled'');',
'// $(''.P20002_ATTACHMENT'').addClass(''apex_disabled'');',
'$(''#P20002_NAME_FILES'').removeClass(''apex_disabled'');',
'',
'',
'$(''.P20002_REPLACEMENT'').removeClass(''apex_disabled'');                ',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20002_NOTE'').removeClass(''apex_disabled'');  ',
'$(''#P20002_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'',
'',
'$(''.P20002_DISCOUNT_RATE'').addClass(''apex_disabled'');           ',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE'').removeClass(''apex_disabled'');',
'',
'',
'$(''#P20002_PARTNER_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_PARTNER_PHONE'').removeClass(''apex_disabled'');',
'$(''#P20002_TITLE'').removeClass(''apex_disabled'');',
'$(''.P20002_PARTNER_DEPARTMENT'').removeClass(''apex_disabled'');',
'$(''.P20002_FIELD'').removeClass(''apex_disabled'');',
'$(''#P20002_WORKPLACE'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_STATUS") == 1 && $v("P20002_SCHOLARSHIP_RECIPIENT") === "B"',
'// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25264686889676348)
,p_event_id=>wwv_flow_imp.id(25264345884676345)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''.P20002_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20002_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_RECIPIENT_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_PHONE'').removeClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').removeClass(''apex_disabled'');            ',
'$(''.P20002_CAMPUS'').removeClass(''apex_disabled'');                     ',
'$(''#P20002_UPLOAD_FILE'').removeClass(''apex_disabled'');',
'$(''#P20002_URL_FILES'').removeClass(''apex_disabled'');',
'$(''#P20002_NAME_FILES'').removeClass(''apex_disabled'');',
'',
'',
'$(''.P20002_REPLACEMENT'').removeClass(''apex_disabled'');                ',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_NOTE'').removeClass(''apex_disabled'');  ',
'$(''#P20002_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'',
'',
'$(''.P20002_DISCOUNT_RATE'').removeClass(''apex_disabled'');           ',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE'').removeClass(''apex_disabled'');',
'',
'',
'$(''#P20002_PARTNER_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_PARTNER_PHONE'').removeClass(''apex_disabled'');',
'$(''#P20002_TITLE'').removeClass(''apex_disabled'');',
'$(''.P20002_PARTNER_DEPARTMENT'').removeClass(''apex_disabled'');',
'$(''.P20002_FIELD'').removeClass(''apex_disabled'');',
'$(''#P20002_WORKPLACE'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_STATUS") == 1 && $v("P20002_SCHOLARSHIP_RECIPIENT") === "C"',
'// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25264759109676349)
,p_event_id=>wwv_flow_imp.id(25264345884676345)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''.P20002_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20002_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_RECIPIENT_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_PHONE'').removeClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').removeClass(''apex_disabled'');            ',
'$(''.P20002_CAMPUS'').removeClass(''apex_disabled'');                     ',
'$(''#P20002_UPLOAD_FILE'').removeClass(''apex_disabled'');',
'$(''#P20002_URL_FILES'').removeClass(''apex_disabled'');',
'$(''#P20002_NAME_FILES'').removeClass(''apex_disabled'');',
'',
'',
'$(''.P20002_REPLACEMENT'').removeClass(''apex_disabled'');                ',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_NOTE'').removeClass(''apex_disabled'');  ',
'$(''#P20002_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'',
'',
'$(''.P20002_DISCOUNT_RATE'').removeClass(''apex_disabled'');           ',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE'').removeClass(''apex_disabled'');',
'',
'',
'$(''#P20002_PARTNER_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_PARTNER_PHONE'').removeClass(''apex_disabled'');',
'$(''#P20002_TITLE'').removeClass(''apex_disabled'');',
'$(''.P20002_PARTNER_DEPARTMENT'').removeClass(''apex_disabled'');',
'$(''.P20002_FIELD'').removeClass(''apex_disabled'');',
'$(''#P20002_WORKPLACE'').removeClass(''apex_disabled'');',
'',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_STATUS") == 1 && $v("P20002_SCHOLARSHIP_RECIPIENT") === "D"',
'// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25264879786676350)
,p_event_id=>wwv_flow_imp.id(25264345884676345)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''.P20002_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20002_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_PHONE'').addClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').addClass(''apex_disabled'');            ',
'$(''.P20002_CAMPUS'').addClass(''apex_disabled'');                     ',
'$(''#P20002_UPLOAD_FILE'').addClass(''apex_disabled'');',
'$(''#P20002_URL_FILES'').addClass(''apex_disabled'');',
'$(''#P20002_NAME_FILES'').addClass(''apex_disabled'');',
'',
'',
'$(''.P20002_REPLACEMENT'').addClass(''apex_disabled'');                ',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20002_NOTE'').addClass(''apex_disabled'');  ',
'$(''#P20002_REASON_REQUEST'').addClass(''apex_disabled'');             ',
'',
'',
'$(''.P20002_DISCOUNT_RATE'').addClass(''apex_disabled'');           ',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE'').addClass(''apex_disabled'');',
'',
'',
'$(''#P20002_PARTNER_NAME'').addClass(''apex_disabled'');',
'$(''#P20002_PARTNER_PHONE'').addClass(''apex_disabled'');',
'$(''#P20002_TITLE'').addClass(''apex_disabled'');',
'$(''.P20002_PARTNER_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''.P20002_FIELD'').addClass(''apex_disabled'');',
'$(''#P20002_WORKPLACE'').addClass(''apex_disabled'');',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_STATUS") != 1',
'// && ($v("P20002_REQUEST_ID") !== null || $v("P20002_REQUEST_ID") !== "")'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21324418569734593)
,p_name=>'Change_0'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_condition_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'0'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21324902974734594)
,p_event_id=>wwv_flow_imp.id(21324418569734593)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'show_hide_0'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// show',
'$(''#P20002_REQUEST_NAME_AB_CONTAINER'').show();',
'$(''#P20002_EMPLOYEE_CODE_CONTAINER'').show();',
'$(''#P20002_LEVEL_CONTAINER'').show();',
'$(''#P20002_START_DATE_CONTAINER'').show();',
'$(''#P20002_TERMINATION_DATE_CONTAINER'').show();',
'$(''#P20002_NOTE_CONTAINER'').show();',
'',
'// hide',
'$(''#P20002_REQUEST_NAME_CONTAINER'').hide();',
'$(''#P20002_DEPARTMENT_CODE_CONTAINER'').hide();',
'$(''.region_partner'').hide();',
'$(''#P20002_ATTACHMENT_CONTAINER'').hide();',
'$(''#P20002_UPLOAD_FILE_CONTAINER'').hide();',
'$(''#P20002_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_REASON_REQUEST_CONTAINER'').hide();'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21325485540734594)
,p_event_id=>wwv_flow_imp.id(21324418569734593)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only '
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
unistr('//$(''.P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');      // c\1EA3 3 item employee code, requester code, department code c\00F9ng column class'),
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
unistr('// c\00E2u l\1EC7nh d\01B0\1EDBi, sau khi disable, item v\1EABn c\00F3 th\1EC3 select'),
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');',
unistr('// c\00E2u l\1EC7nh d\01B0\1EDBi, sau khi disable, item KH\00D4NG select'),
'//apex.item(''P20002_DEPARTMENT'').disable();',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'$(''.P20002_DISCOUNT_RATE'').addClass(''apex_disabled'');',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').addClass(''apex_disabled'');',
'',
'// remove',
'$(''#P20002_DEPARTMENT_CODE'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').removeClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').removeClass(''apex_disabled'');',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').removeClass(''apex_disabled'');',
'//$(''.P20002_DISCOUNT_RATE'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21317569548734589)
,p_name=>'Change_A'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_condition_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'A'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21319524583734590)
,p_event_id=>wwv_flow_imp.id(21317569548734589)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'show_hide_A'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// show',
'$(''#P20002_REQUEST_NAME_AB_CONTAINER'').show();',
'$(''#P20002_EMPLOYEE_CODE_CONTAINER'').show();',
'$(''#P20002_LEVEL_CONTAINER'').show();',
'$(''#P20002_START_DATE_CONTAINER'').show();',
'$(''#P20002_TERMINATION_DATE_CONTAINER'').show();',
'$(''#P20002_NOTE_CONTAINER'').show();',
'',
'// hide',
'$(''#P20002_REQUEST_NAME_CONTAINER'').hide();',
'$(''#P20002_DEPARTMENT_CODE_CONTAINER'').hide();',
'$(''.region_partner'').hide();',
'$(''#P20002_ATTACHMENT_CONTAINER'').hide();',
'$(''#P20002_UPLOAD_FILE_CONTAINER'').hide();',
'$(''#P20002_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_REASON_REQUEST_CONTAINER'').hide();'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21320047182734591)
,p_event_id=>wwv_flow_imp.id(21317569548734589)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_name=>'Set Read Only '
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
unistr('// $(''.P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');      // c\1EA3 3 item (employee code, requester code, department code) c\00F9ng column class'),
'$(''#P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').addClass(''apex_disabled'');',
'$(''.P20002_DISCOUNT_RATE'').addClass(''apex_disabled'');',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'',
'// remove',
'$(''#P20002_DEPARTMENT_CODE'').removeClass(''apex_disabled'');',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//$v("P20002_REQUEST_ID") === ""',
'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'))
);
end;
/
begin
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21325806309734594)
,p_name=>'Change_B'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_condition_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'B'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21326304980734595)
,p_event_id=>wwv_flow_imp.id(21325806309734594)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'show_hide_B'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// show',
'$(''#P20002_REQUEST_NAME_AB_CONTAINER'').show();',
'//$(''#P20002_REQUESTER_CODE_CONTAINER'').show();',
'$(''#P20002_EMPLOYEE_CODE_CONTAINER'').show();',
'$(''#P20002_LEVEL_CONTAINER'').show();',
'$(''#P20002_START_DATE_CONTAINER'').show();',
'$(''#P20002_TERMINATION_DATE_CONTAINER'').show();',
'$(''#P20002_UPLOAD_FILE_CONTAINER'').show();',
'$(''#P20002_REPLACEMENT_CONTAINER'').show();',
'$(''#P20002_ATTACHMENT_CONTAINER'').show();',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT_CONTAINER'').show();',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT_CONTAINER'').show();',
'$(''#P20002_NOTE_CONTAINER'').show();',
'',
'// hide',
'$(''#P20002_REQUEST_NAME_CONTAINER'').hide();',
'$(''#P20002_DEPARTMENT_CODE_CONTAINER'').hide();',
'$(''.region_partner'').hide();',
'$(''#P20002_REASON_REQUEST_CONTAINER'').hide();'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21326800678734595)
,p_event_id=>wwv_flow_imp.id(21325806309734594)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'Set Read Only '
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
unistr('$(''.P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');      // c\1EA3 3 item (employee code, requester code, department code) c\00F9ng column class'),
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''#P20002_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').addClass(''apex_disabled'');',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''.P20002_DISCOUNT_RATE'').addClass(''apex_disabled'');',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'',
'// remove',
'$(''#P20002_DEPARTMENT_CODE'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').removeClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').removeClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21314107157734587)
,p_name=>'Change_C'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_condition_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'C'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21317127419734589)
,p_event_id=>wwv_flow_imp.id(21314107157734587)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'show_hide_C'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// show',
'$(''#P20002_REQUEST_NAME_CONTAINER'').show();',
'$(''#P20002_DEPARTMENT_CODE_CONTAINER'').show();',
'$(''.region_partner'').show();',
'$(''#P20002_ATTACHMENT_CONTAINER'').show();',
'$(''#P20002_UPLOAD_FILE_CONTAINER'').show();',
'$(''#P20002_REASON_REQUEST_CONTAINER'').show();',
'',
'// hide',
'$(''#P20002_REQUEST_NAME_AB_CONTAINER'').hide();',
'$(''#P20002_EMPLOYEE_CODE_CONTAINER'').hide();',
'$(''#P20002_LEVEL_CONTAINER'').hide();',
'$(''#P20002_START_DATE_CONTAINER'').hide();',
'//$(''#P20002_START_DATE_CONTAINER'').show();',
'$(''#P20002_TERMINATION_DATE_CONTAINER'').hide();',
'$(''#P20002_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_NOTE_CONTAINER'').hide();',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21315695503734588)
,p_event_id=>wwv_flow_imp.id(21314107157734587)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_name=>'Set Read Only '
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'// $(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');',
'if (apex.item(''P20002_IS_HR_ADMIN'').getValue() == 1){',
'    $(''.P20002_REQUEST_NAME'').removeClass(''apex_disabled'');',
'} else{',
'    $(''.P20002_REQUEST_NAME'').addClass(''apex_disabled'');',
'}',
'$(''#P20002_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
unistr('$(''.P20002_EMPLOYEE_CODE'').addClass(''apex_disabled'');      // c\1EA3 3 item (employee code, requester code, department code) c\00F9ng column class'),
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'',
'// remove',
'$(''#P20002_EMPLOYEE_CODE'').removeClass(''apex_disabled'');',
'$(''#P20002_LEVEL'').removeClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').removeClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').removeClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').removeClass(''apex_disabled'');',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''.P20002_DISCOUNT_RATE'').removeClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21311230564734583)
,p_name=>'Change_D'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_condition_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'D'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21312705143734586)
,p_event_id=>wwv_flow_imp.id(21311230564734583)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'show_hide_D'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// show',
'$(''#P20002_REQUEST_NAME_CONTAINER'').show();',
'$(''#P20002_DEPARTMENT_CODE_CONTAINER'').show();',
'$(''.region_partner'').show();',
'$(''#P20002_ATTACHMENT_CONTAINER'').show();',
'$(''#P20002_UPLOAD_FILE_CONTAINER'').show();',
'$(''#P20002_REASON_REQUEST_CONTAINER'').show();',
'',
'// hide',
'$(''#P20002_REQUEST_NAME_AB_CONTAINER'').hide();',
'$(''#P20002_EMPLOYEE_CODE_CONTAINER'').hide();',
'$(''#P20002_LEVEL_CONTAINER'').hide();',
'$(''#P20002_START_DATE_CONTAINER'').hide();',
'$(''#P20002_TERMINATION_DATE_CONTAINER'').hide();',
'$(''#P20002_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20002_NOTE_CONTAINER'').hide();',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21311725548734585)
,p_event_id=>wwv_flow_imp.id(21311230564734583)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_name=>'Set Read Only '
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''#P20002_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20002_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''#P20002_VOUCHER_CODE'').addClass(''apex_disabled'');',
'$(''#P20002_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20002_APPROVED_DATE'').addClass(''apex_disabled'');',
'',
'// remove',
'$(''.P20002_REQUEST_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_REQUEST_NAME_AB'').removeClass(''apex_disabled'');',
'$(''#P20002_EMPLOYEE_CODE'').removeClass(''apex_disabled'');',
'$(''#P20002_LEVEL'').removeClass(''apex_disabled'');',
'$(''#P20002_START_DATE'').removeClass(''apex_disabled'');',
'$(''#P20002_TERMINATION_DATE'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_NAME'').removeClass(''apex_disabled'');',
'$(''#P20002_RECIPIENT_DOB'').removeClass(''apex_disabled'');',
'$(''.P20002_RELATIONSHIP'').removeClass(''apex_disabled'');',
'$(''#P20002_VOUCHER_CODE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''#P20002_EXPIRATION_DATE_REPLACEMENT'').removeClass(''apex_disabled'');',
'$(''.P20002_DISCOUNT_RATE'').removeClass(''apex_disabled'');',
'$(''#P20002_EFFECTIVE_DATE'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21343266650734608)
,p_name=>'Change P20002_PROGRAM'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21343708918734608)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_PROGRAM'
,p_attribute_01=>'PLSQL_EXPRESSION'
,p_attribute_04=>wwv_flow_string.join(wwv_flow_t_varchar2(
'CASE :P20002_SCHOLARSHIP_RECIPIENT',
'  WHEN ''A'' THEN ''ELT''',
'  WHEN ''C'' THEN ''ELT''',
'  WHEN ''D'' THEN ''ELT''',
'END',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(20143431614893610)
,p_name=>'Change P20002_REQUEST_NAME_AB'
,p_event_sequence=>90
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20143510287893611)
,p_event_id=>wwv_flow_imp.id(20143431614893610)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_REQUEST_NAME_AB'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(100);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' ',
'    THEN',
'        SELECT FULL_NAME INTO temp FROM EMPLOYEES WHERE USER_NAME = :APP_USER_NAME;',
'        RETURN temp;',
'    ELSE',
'        RETURN null;',
'    END IF;',
'END;',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_USER_NAME'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21425316533215920)
,p_name=>'Change P20002_REQUEST_NAME'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21425440973215921)
,p_event_id=>wwv_flow_imp.id(21425316533215920)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_REQUEST_NAME'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(100);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''C'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''D'' ',
'    THEN',
'        select EMPLOYEE_CODE into temp from EMPLOYEES where USER_NAME = :APP_USER_NAME;',
'        RETURN temp;',
'    ELSE',
'        RETURN null;',
'    END IF;',
'END;'))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_USER_NAME'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(20143615734893612)
,p_name=>'Change P20002_EMPLOYEE_CODE'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20143773181893613)
,p_event_id=>wwv_flow_imp.id(20143615734893612)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_EMPLOYEE_CODE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(100);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' or :P20002_SCHOLARSHIP_RECIPIENT = ''C''',
'    THEN',
'        select :APP_EMP_CODE into temp from DUAL;',
'        RETURN temp;',
'    ELSE',
'        RETURN null;',
'    END IF;',
'END;',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_EMP_CODE'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(20144084556893616)
,p_name=>'Change P20002_DEPARTMENT_CODE'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20144104869893617)
,p_event_id=>wwv_flow_imp.id(20144084556893616)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_DEPARTMENT_CODE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(100);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''C'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''D'' ',
'    THEN',
'        select DEPARTMENT_ID into temp from employees where :APP_USER_NAME = USER_NAME;',
'        RETURN temp;',
'    ELSE',
'        RETURN null;',
'    END IF;',
'    ',
'END;',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_USER_NAME'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21428139318215948)
,p_name=>'Change P20002_DEPARTMENT'
,p_event_sequence=>130
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21428288207215949)
,p_event_id=>wwv_flow_imp.id(21428139318215948)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_DEPARTMENT'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(100);',
'BEGIN',
'    -- IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' ',
'    -- THEN',
'        select DEPARTMENT_NAME into temp from employees where :APP_USER_NAME = USER_NAME;',
'        RETURN temp;',
'    -- ELSE',
'    --     RETURN null;',
'    -- END IF;',
'    ',
'END;',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_USER_NAME'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(20143858875893614)
,p_name=>'Change P20002_LEVEL'
,p_event_sequence=>140
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20143944352893615)
,p_event_id=>wwv_flow_imp.id(20143858875893614)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_LEVEL'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(100);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' ',
'    THEN',
'        select LEVEL_DESCRIPTION into temp from employees where :APP_USER_NAME = USER_NAME; ',
'        RETURN temp;',
'    ELSE',
'        return null;',
'    END IF;',
'END;',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_USER_NAME'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(20146580132893641)
,p_name=>'Change P20002_START_DATE'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20146698394893642)
,p_event_id=>wwv_flow_imp.id(20146580132893641)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_START_DATE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(100);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' ',
'    THEN',
'        select START_DATE into temp from EMPLOYEES where :APP_USER_NAME = USER_NAME;',
'        return temp;',
'    ELSE',
'        return null;',
'    END IF;',
'END;',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_USER_NAME'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21423682060215903)
,p_name=>'Change P20002_TERMINATION_DATE'
,p_event_sequence=>160
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21423792025215904)
,p_event_id=>wwv_flow_imp.id(21423682060215903)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_TERMINATION_DATE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(100);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' ',
'    THEN',
'        select TERMINATE_DATE into temp from EMPLOYEES where :APP_USER_NAME = USER_NAME;',
'        return temp;',
'    ELSE',
'        return null;',
'    END IF;',
'END;',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_USER_NAME'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21423829618215905)
,p_name=>'Change P20002_RECIPIENT_NAME'
,p_event_sequence=>170
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21423967636215906)
,p_event_id=>wwv_flow_imp.id(21423829618215905)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_RECIPIENT_NAME'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(100);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' ',
'    THEN',
'        select FULL_NAME into temp from employees where USER_NAME = :APP_USER_NAME; ',
'        RETURN temp;',
'    ELSE',
'        return null;',
'    END IF;',
'END;',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_USER_NAME'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21424427803215911)
,p_name=>'Change P20002_RECIPIENT_DOB'
,p_event_sequence=>180
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21424524020215912)
,p_event_id=>wwv_flow_imp.id(21424427803215911)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_RECIPIENT_DOB'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(100);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' ',
'    THEN',
'        select DOB into temp from EMPLOYEES where USER_NAME = :APP_USER_NAME; ',
'        RETURN temp;',
'    ELSE',
'        return null;',
'    END IF;',
'END;',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_USER_NAME'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21425710308215924)
,p_name=>'Change P20002_RECIPIENT_PHONE'
,p_event_sequence=>190
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21425849718215925)
,p_event_id=>wwv_flow_imp.id(21425710308215924)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_RECIPIENT_PHONE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21424602585215913)
,p_name=>'Change P20002_RELATIONSHIP'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21424767256215914)
,p_event_id=>wwv_flow_imp.id(21424602585215913)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_RELATIONSHIP'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(100);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' ',
'    THEN',
'        temp := 1;',
'        RETURN temp;',
'    ELSIF',
'        :P20002_SCHOLARSHIP_RECIPIENT = ''C'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''D''',
'    THEN',
'        temp := 8;',
'        RETURN temp;',
'    ELSE',
'        RETURN null;',
'    END IF;',
'END;',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21425949455215926)
,p_name=>'Change P20002_CAMPUS'
,p_event_sequence=>210
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21426088389215927)
,p_event_id=>wwv_flow_imp.id(21425949455215926)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_CAMPUS'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21426119922215928)
,p_name=>'Change P20002_REPLACEMENT'
,p_event_sequence=>220
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21426207134215929)
,p_event_id=>wwv_flow_imp.id(21426119922215928)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_REPLACEMENT'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21426355491215930)
,p_name=>'Change P20002_NOTE'
,p_event_sequence=>230
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21426452648215931)
,p_event_id=>wwv_flow_imp.id(21426355491215930)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_NOTE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21426549201215932)
,p_name=>'Change P20002_REASON_REQUEST'
,p_event_sequence=>240
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21426639134215933)
,p_event_id=>wwv_flow_imp.id(21426549201215932)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_REASON_REQUEST'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(22026603696485918)
,p_name=>'Change P20002_DISCOUNT_RATE'
,p_event_sequence=>250
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_PROGRAM'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")',
'&& ($v("P20002_SCHOLARSHIP_RECIPIENT") === ''A'' || $v("P20002_SCHOLARSHIP_RECIPIENT") === ''B'')'))
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22026794282485919)
,p_event_id=>wwv_flow_imp.id(22026603696485918)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_DISCOUNT_RATE'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select DISCOUNT_RATE',
'from COREEDU_PROMOTION',
'where PROGRAM = :P20002_PROGRAM',
'and DISCOUNT_RATE >= 100;'))
,p_attribute_07=>'P20002_PROGRAM'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21424837864215915)
,p_name=>'Change P20002_EFFECTIVE_DATE'
,p_event_sequence=>260
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
end;
/
begin
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21424911163215916)
,p_event_id=>wwv_flow_imp.id(21424837864215915)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_EFFECTIVE_DATE'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select SYSDATE from DUAL'
,p_attribute_07=>'P20002_REQUEST_ID'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21426719974215934)
,p_name=>'Change P20002_EXPIRATION_DATE'
,p_event_sequence=>270
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21426870382215935)
,p_event_id=>wwv_flow_imp.id(21426719974215934)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_EXPIRATION_DATE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21426941025215936)
,p_name=>'Change P20002_PARTNER_NAME'
,p_event_sequence=>280
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21427041188215937)
,p_event_id=>wwv_flow_imp.id(21426941025215936)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_PARTNER_NAME'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21427109662215938)
,p_name=>'Change P20002_PARTNER_PHONE'
,p_event_sequence=>290
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21427208598215939)
,p_event_id=>wwv_flow_imp.id(21427109662215938)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_PARTNER_PHONE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21427365365215940)
,p_name=>'Change P20002_TITLE'
,p_event_sequence=>300
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21427451594215941)
,p_event_id=>wwv_flow_imp.id(21427365365215940)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_TITLE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21427512711215942)
,p_name=>'Change P20002_PARTNER_DEPARTMENT'
,p_event_sequence=>310
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21427654375215943)
,p_event_id=>wwv_flow_imp.id(21427512711215942)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_PARTNER_DEPARTMENT'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21427768949215944)
,p_name=>'Change P20002_FIELD'
,p_event_sequence=>320
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21427871061215945)
,p_event_id=>wwv_flow_imp.id(21427768949215944)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_FIELD'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21427905892215946)
,p_name=>'Change P20002_WORKPLACE'
,p_event_sequence=>330
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21428043467215947)
,p_event_id=>wwv_flow_imp.id(21427905892215946)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_WORKPLACE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21336256037734603)
,p_name=>'change_value_of_request_name'
,p_event_sequence=>340
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_REQUEST_NAME'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")',
'',
'($v("P20002_SCHOLARSHIP_RECIPIENT") === "C" || $v("P20002_SCHOLARSHIP_RECIPIENT") === "D")  && ',
'($v("P20002_REQUEST_ID") === "" || $v("P20002_REQUEST_ID") === null) && ',
'$v("P20002_REQUEST_NAME") !== null'))
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21336753109734603)
,p_event_id=>wwv_flow_imp.id(21336256037734603)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'set_value_department_code'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_DEPARTMENT_CODE'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select emp.DEPARTMENT_ID from EMPLOYEES emp where :P20002_REQUEST_NAME = emp.EMPLOYEE_CODE;'
,p_attribute_07=>'P20002_REQUEST_NAME,P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21337255240734604)
,p_event_id=>wwv_flow_imp.id(21336256037734603)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'set_value_department'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_DEPARTMENT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select emp.DEPARTMENT_NAME from EMPLOYEES emp where :P20002_REQUEST_NAME = emp.EMPLOYEE_CODE;'
,p_attribute_07=>'P20002_REQUEST_NAME,P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21341866644734606)
,p_name=>'change_value_of_replacement'
,p_event_sequence=>350
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_REPLACEMENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v("P20002_REPLACEMENT") !== null'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21342862353734607)
,p_event_id=>wwv_flow_imp.id(21341866644734606)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'set_value_for_voucher_code_replacement'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_VOUCHER_CODE_REPLACEMENT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select VOUCHER_CODE',
'from SCHOLARSHIP_REQUEST',
'where VOUCHER_CODE = :P20002_REPLACEMENT;'))
,p_attribute_07=>'P20002_REPLACEMENT'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21342372596734607)
,p_event_id=>wwv_flow_imp.id(21341866644734606)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'set_value_for_expiration_date_replacement'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_EXPIRATION_DATE_REPLACEMENT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select EXPIRATION_DATE',
'from SCHOLARSHIP_REQUEST',
'where VOUCHER_CODE = :P20002_REPLACEMENT;'))
,p_attribute_07=>'P20002_REPLACEMENT'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21750343925265942)
,p_name=>'set_value_of_voucher_code'
,p_event_sequence=>360
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_EFFECTIVE_DATE,P20002_EXPIRATION_DATE,P20002_SCHOLARSHIP_RECIPIENT,P20002_DISCOUNT_RATE,P20002_PROGRAM,P20002_DEPARTMENT_CODE'
,p_condition_element=>'P20002_REQUEST_ID'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21750440772265943)
,p_event_id=>wwv_flow_imp.id(21750343925265942)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_VOUCHER_CODE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    x1 nvarchar2(100);',
'    x2 nvarchar2(100);',
'    x3 nvarchar2(100);',
'    x4 nvarchar2(100);',
'    x5 nvarchar2(100);',
'begin',
'    -- if :P20002_EFFECTIVE_DATE is null',
'    -- then',
'    --     x1 := null;',
'    -- else',
'    --     select to_char(to_date(:P20002_EFFECTIVE_DATE, ''MM/DD/YYYY''),''YY'') || ',
'    --         case',
'    --             when :P20002_EFFECTIVE_DATE is null then ''00''',
'    --             when :P20002_EFFECTIVE_DATE is not null then to_char(to_date(:P20002_EXPIRATION_DATE, ''MM/DD/YYYY''),''MM'')',
'    --         end',
'    --     into x1 ',
'    --     from dual;',
'    -- end if;',
'    -- if :P20002_EFFECTIVE_DATE is not null then',
'        select to_char(to_date(:P20002_EFFECTIVE_DATE, ''MM/DD/YYYY''), ''YY'') ||',
'            coalesce(to_char(to_date(:P20002_EXPIRATION_DATE, ''MM/DD/YYYY''), ''MM''), ''00'')',
'        into x1',
'        from dual;',
'    -- end if;',
'',
'    if :P20002_DISCOUNT_RATE < 100 then',
'        select to_char(:P20002_DISCOUNT_RATE, ''000'') ',
'        into x2 ',
'        from dual;',
'    else',
'        select :P20002_DISCOUNT_RATE ',
'        into x2 ',
'        from dual;',
'    end if;',
'',
'    if :P20002_SCHOLARSHIP_RECIPIENT is not null then',
'        select replace(:P20002_SCHOLARSHIP_RECIPIENT || x2, '' '', '''')',
'        into x2',
'        from dual;',
'    end if;',
'',
'    if :P20002_PROGRAM is not null then',
'        select :P20002_PROGRAM',
'        into x3',
'        from dual;',
'    end if;',
'',
'    if :P20002_SCHOLARSHIP_RECIPIENT like ''A'' or :P20002_SCHOLARSHIP_RECIPIENT like ''B'' then',
'        select :P20002_EMPLOYEE_CODE',
'        into x4',
'        from dual;',
'        -- select LTRIM(TO_CHAR(COUNT(REQUESTER_CODE) + 1, ''000'')) ',
'        select TO_CHAR(COUNT(REQUESTER_CODE) + 1) ',
'        into x5',
'        from SCHOLARSHIP_REQUEST ',
'        where REQUESTER_CODE = :P20002_EMPLOYEE_CODE;',
'    else',
'        if :P20002_SCHOLARSHIP_RECIPIENT like ''C'' or :P20002_SCHOLARSHIP_RECIPIENT like ''D'' then',
'            select :P20002_DEPARTMENT_CODE',
'            into x4',
'            from dual;',
'            -- select  LTRIM(TO_CHAR(COUNT(REQUESTER_DEPARTMENT_CODE) + 1,''000''))',
'            select TO_CHAR(COUNT(REQUESTER_DEPARTMENT_CODE) + 1)',
'            into x5 ',
'            from SCHOLARSHIP_REQUEST ',
'            where REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE;',
'        end if;',
'    end if;',
'',
'    -- if :P20002_SCHOLARSHIP_RECIPIENT like ''A'' or :P20002_SCHOLARSHIP_RECIPIENT like ''B'' then',
'    --     select LTRIM(TO_CHAR(COUNT(REQUESTER_CODE) + 1, ''000'')) ',
'    --     into x5',
'    --     from SCHOLARSHIP_REQUEST ',
'    --     where REQUESTER_CODE = :P20002_EMPLOYEE_CODE;',
'    -- else',
'    --     if :P20002_SCHOLARSHIP_RECIPIENT like ''C'' or :P20002_SCHOLARSHIP_RECIPIENT like ''D'' then',
'    --         select  LTRIM(TO_CHAR(COUNT(REQUESTER_DEPARTMENT_CODE) + 1,''000''))',
'    --         into x5 ',
'    --         from SCHOLARSHIP_REQUEST ',
'    --         where REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE;',
'    --     end if;',
'    -- end if;',
'',
'    return x1 || ''-'' || x2 || ''-'' || x3 || ''-'' || x4 || ''-'' || x5;',
'end;'))
,p_attribute_07=>'P20002_REQUEST_ID,P20002_EFFECTIVE_DATE,P20002_EXPIRATION_DATE,P20002_SCHOLARSHIP_RECIPIENT,P20002_DISCOUNT_RATE,P20002_PROGRAM,P20002_EMPLOYEE_CODE,P20002_DEPARTMENT_CODE'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(25838302556867501)
,p_name=>'set_value_of_voucher_code_1'
,p_event_sequence=>370
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_EFFECTIVE_DATE,P20002_EXPIRATION_DATE,P20002_SCHOLARSHIP_RECIPIENT,P20002_DISCOUNT_RATE,P20002_PROGRAM,P20002_DEPARTMENT_CODE'
,p_condition_element=>'P20002_REQUEST_ID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25838434363867502)
,p_event_id=>wwv_flow_imp.id(25838302556867501)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_VOUCHER_CODE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    x1 nvarchar2(100);',
'    x2 nvarchar2(100);',
'    x3 nvarchar2(100);',
'begin',
'    select to_char(to_date(:P20002_EFFECTIVE_DATE, ''MM/DD/YYYY''), ''YY'') ||',
'        coalesce(to_char(to_date(:P20002_EXPIRATION_DATE, ''MM/DD/YYYY''), ''MM''), ''00'')',
'    into x1',
'    from dual;',
'',
'    if :P20002_DISCOUNT_RATE < 100 then',
'        select to_char(:P20002_DISCOUNT_RATE, ''000'') ',
'        into x2 ',
'        from dual;',
'    else',
'        select :P20002_DISCOUNT_RATE ',
'        into x2 ',
'        from dual;',
'    end if;',
'',
'    if :P20002_SCHOLARSHIP_RECIPIENT is not null then',
'        select replace(:P20002_SCHOLARSHIP_RECIPIENT || x2, '' '', '''')',
'        into x2',
'        from dual;',
'    end if;',
'',
'    -- if :P20002_PROGRAM is not null then',
'    --     select :P20002_PROGRAM',
'    --     into x3',
'    --     from dual;',
'    -- end if;',
'',
'    -- if :P20002_SCHOLARSHIP_RECIPIENT like ''A'' or :P20002_SCHOLARSHIP_RECIPIENT like ''B'' then',
'    --     select :P20002_EMPLOYEE_CODE',
'    --     into x4',
'    --     from dual;',
'    --     -- select LTRIM(TO_CHAR(COUNT(REQUESTER_CODE) + 1, ''000'')) ',
'    --     select TO_CHAR(COUNT(REQUESTER_CODE) + 1) ',
'    --     into x5',
'    --     from SCHOLARSHIP_REQUEST ',
'    --     where REQUESTER_CODE = :P20002_EMPLOYEE_CODE;',
'    -- else',
'    --     if :P20002_SCHOLARSHIP_RECIPIENT like ''C'' or :P20002_SCHOLARSHIP_RECIPIENT like ''D'' then',
'    --         select :P20002_DEPARTMENT_CODE',
'    --         into x4',
'    --         from dual;',
'    --         -- select  LTRIM(TO_CHAR(COUNT(REQUESTER_DEPARTMENT_CODE) + 1,''000''))',
'    --         select TO_CHAR(COUNT(REQUESTER_DEPARTMENT_CODE) + 1)',
'    --         into x5 ',
'    --         from SCHOLARSHIP_REQUEST ',
'    --         where REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE;',
'    --     end if;',
'    -- end if;',
'',
'    SELECT SUBSTR(your_string, ',
'              CASE ',
'                WHEN INSTR(your_string, ''ELT'') > 0 THEN INSTR(your_string, ''ELT'')',
'                WHEN INSTR(your_string, ''EP'') > 0 THEN INSTR(your_string, ''EP'')',
'                --ELSE 0 ',
'              END',
'             )',
'    INTO  x3',
'    FROM (SELECT :P20002_VOUCHER_CODE AS your_string FROM dual);',
'',
'    return x1 || ''-'' || x2 || ''-'' || x3;',
'end;'))
,p_attribute_07=>'P20002_REQUEST_ID,P20002_EFFECTIVE_DATE,P20002_EXPIRATION_DATE,P20002_SCHOLARSHIP_RECIPIENT,P20002_DISCOUNT_RATE,P20002_VOUCHER_CODE'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21310415858734579)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'save when submit'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'c_date date := to_char(sysdate,''MM/DD/YYYY'');',
'SCHOLARSHIP_REQUEST_ID NUMBER;',
'line_manager_code nvarchar2(50);',
'pro_code nvarchar2(50);',
'',
'begin',
'    SELECT MANAGER_ID INTO line_manager_code ',
'    FROM EMPLOYEES ',
'    WHERE EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
'    -- select PROMOTION_CODE into pro_code',
'    -- from COREEDU_PROMOTION',
'    -- where PROGRAM = :P20002_PROGRAM and DISCOUNT_RATE = :P20002_DISCOUNT_RATE;',
'    ',
'    -- if :P20002_REQUEST_ID is null then',
'--         for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = ''scholarship'' and WF_EXPIRATION_DATE >= sysdate)loop',
'--     insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER)',
'--     values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P20002_NOTE, sysdate,',
'--     :P20002_SCHOLARSHIP_DETAIL,',
'--     rec.WF_PROCESS_ID,:P20002_LINE_MANAGER);',
'-- end loop;',
'',
'        INSERT INTO',
'            SCHOLARSHIP_REQUEST(',
'                STATUS,',
'                RECIPIENT_TYPE,',
'                PROGRAM,',
'                REQUESTER_CODE,',
'                REQUESTER_DEPARTMENT,',
'                REQUESTER_DEPARTMENT_CODE,',
'                REQUESTER_LEVEL,',
'                PARTNER_NAME,',
'                PARTNER_PHONE,',
'                PARTNER_TITLE,',
'                PARTNER_DEPARTMENT,',
'                PARTNER_FIELD,',
'                PARTNER_WORKPLACE,',
'                RECIPIENT_NAME,',
'                RECIPIENT_DOB,',
'                RECIPIENT_PHONE,',
'                RECIPIENT_RELATIONSHIP,',
'                RECIPIENT_CAMPUS,',
'                ATTACH_NAME,',
'                ATTACH_FILE,',
'                RECIPIENT_REPLACEMENT,',
'                RECIPIENT_VOUCHER_CODE_REPLACEMENT,',
'                RECIPIENT_EXPIRATION_DATE_REPLACEMENT,',
'                RECIPIENT_NOTE,',
'                RECIPIENT_REASON_REQUEST,',
'                DISCOUNT_RATE,',
'                VOUCHER_CODE,',
'                NUMBER_OF_COURSES,',
'                EFFECTIVE_DATE,',
'                EXPIRATION_DATE,',
'                APPROVED_DATE,',
'                CREATED_DATE,',
'                DETAIL_ID,',
'                PROMOTION_CODE',
'            )',
'        VALUES',
'        (',
'                2,',
'                :P20002_SCHOLARSHIP_RECIPIENT,',
'                :P20002_PROGRAM,',
'                -- case',
'                --     when :P20002_SCHOLARSHIP_RECIPIENT = ''D'' then :P20002_REQUEST_NAME',
'                -- else',
'                --     :P20002_EMPLOYEE_CODE',
'                -- end,',
'                case',
'                    when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = ''C'' then :P20002_REQUEST_NAME',
'                    when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = ''D'' then :P20002_REQUEST_NAME',
'                else',
'                    :P20002_EMPLOYEE_CODE',
'                end,',
'                :P20002_DEPARTMENT,',
'                :P20002_DEPARTMENT_CODE,',
'                :P20002_LEVEL,',
'                :P20002_PARTNER_NAME,',
'                :P20002_PARTNER_PHONE,',
'                :P20002_TITLE,',
'                :P20002_PARTNER_DEPARTMENT,',
'                :P20002_FIELD,',
'                :P20002_WORKPLACE,',
'                :P20002_RECIPIENT_NAME,',
'                :P20002_RECIPIENT_DOB,',
'                :P20002_RECIPIENT_PHONE,',
'                :P20002_RELATIONSHIP,',
'                :P20002_CAMPUS,',
'                :P20002_NAME_FILES,',
'                :P20002_URL_FILES,',
'                :P20002_REPLACEMENT,',
'                :P20002_VOUCHER_CODE_REPLACEMENT,',
'                :P20002_EXPIRATION_DATE_REPLACEMENT,',
'                :P20002_NOTE,',
'                :P20002_REASON_REQUEST,',
'                :P20002_DISCOUNT_RATE,',
'                :P20002_VOUCHER_CODE,',
'                :P20002_NUMBER_OF_COURSES,',
'                :P20002_EFFECTIVE_DATE,',
'                :P20002_EXPIRATION_DATE,',
'                :P20002_APPROVED_DATE,',
'                c_date,',
'                :P20002_SCHOLARSHIP_DETAIL,',
'                pro_code',
'            )',
'            returning ID into SCHOLARSHIP_REQUEST_ID;',
'    -- else',
'    --     UPDATE SCHOLARSHIP_REQUEST sr',
'    --     SET STATUS = 2,',
'    --         RECIPIENT_TYPE = :P20002_SCHOLARSHIP_RECIPIENT,',
'    --         PROGRAM = :P20002_PROGRAM,',
'    --         REQUESTER_CODE = ',
'    --             CASE ',
'    --                 WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''D'' THEN :P20002_REQUEST_NAME',
'    --                 ELSE :P20002_EMPLOYEE_CODE',
'    --             END,',
'    --         REQUESTER_DEPARTMENT = :P20002_DEPARTMENT,',
'    --         REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE,',
'    --         REQUESTER_LEVEL = :P20002_LEVEL,',
'    --         PARTNER_NAME = :P20002_PARTNER_NAME,',
'    --         PARTNER_PHONE = :P20002_PARTNER_PHONE,',
'    --         PARTNER_TITLE = :P20002_TITLE,',
'    --         PARTNER_DEPARTMENT = :P20002_PARTNER_DEPARTMENT,',
'    --         PARTNER_FIELD = :P20002_FIELD,',
'    --         PARTNER_WORKPLACE = :P20002_WORKPLACE,',
'    --         RECIPIENT_NAME = :P20002_RECIPIENT_NAME,',
'    --         RECIPIENT_DOB = :P20002_RECIPIENT_DOB,',
'    --         RECIPIENT_PHONE = :P20002_RECIPIENT_PHONE,',
'    --         RECIPIENT_RELATIONSHIP = :P20002_RELATIONSHIP,',
'    --         RECIPIENT_CAMPUS = :P20002_CAMPUS,',
'    --         ATTACH_NAME = :P20002_NAME_FILES,',
'    --         ATTACH_FILE = :P20002_URL_FILES,',
'    --         RECIPIENT_REPLACEMENT = :P20002_REPLACEMENT,',
'    --         RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20002_VOUCHER_CODE_REPLACEMENT,',
'    --         RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20002_EXPIRATION_DATE_REPLACEMENT,',
'    --         RECIPIENT_NOTE = :P20002_NOTE,',
'    --         RECIPIENT_REASON_REQUEST = :P20002_REASON_REQUEST,',
'    --         DISCOUNT_RATE = :P20002_DISCOUNT_RATE,',
'    --         VOUCHER_CODE = :P20002_VOUCHER_CODE,',
'    --         NUMBER_OF_COURSES = :P20002_NUMBER_OF_COURSES,',
'    --         EFFECTIVE_DATE = :P20002_EFFECTIVE_DATE,',
'    --         EXPIRATION_DATE = :P20002_EXPIRATION_DATE,',
'    --         APPROVED_DATE = :P20002_APPROVED_DATE,',
'    --         CREATED_DATE = c_date',
'    --     WHERE :P20002_REQUEST_ID = sr.ID;',
'    -- end if;',
'',
'    -- Insert into EMP_REQUEST',
'',
'    FOR REC IN (',
'        SELECT',
'            WF_FEATURE_APPLY,',
'            WF_PROCESS_ID',
'        FROM',
'            WORKFLOW',
'        WHERE',
'            -- WF_FEATURE_APPLY = :P20002_FEATURE',
'            lower(WF_FEATURE_APPLY) = lower(:P20002_FEATURE) ',
'            AND WF_EXPIRATION_DATE >= SYSDATE',
'    )LOOP',
'        INSERT INTO EMP_REQUESTS(',
'            REQUEST_TYPE,',
'            SUBMIT_DATE,',
'            EMPLOYEE_CODE,',
'            STATUS,',
'            NOTE,',
'            CREATE_DATE,',
'            REQUEST_DETAIL_ID,',
'            WF_PROCESS_ID,',
'            LINE_MANAGER',
'        ) VALUES(',
'            REC.WF_FEATURE_APPLY,',
'            SYSDATE,',
'            :APP_EMP_CODE,',
'            2,',
'            -- :P20002_NOTE,',
'            CASE ',
'                WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN :P20002_NOTE',
'                ELSE :P20002_REASON_REQUEST',
'            END,',
'            SYSDATE,',
'            SCHOLARSHIP_REQUEST_ID,',
'            REC.WF_PROCESS_ID,',
'            line_manager_code',
'        );',
'    END LOOP;',
'',
'    -- Insert ATTACHMENT_HISTORY',
'    IF(:P20002_DEFAULT_IMAGES_URL != :P20002_URL_FILES or',
'       ( :P20002_REQUEST_ID is null and :P20002_URL_FILES is not null )) ',
'    THEN',
'        INSERT INTO ATTACHMENT_HISTORY (ATTACHMENT_DATE, EMPLOYEE_CODE, ATTACHMENT_URL, ATTACHMENT_NAME, REQUEST_ID)',
'        VALUES(sysdate, :APP_EMP_CODE, :P20002_URL_FILES, :P20002_NAME_FILES, (select ID from EMP_REQUESTS er where scholarship_request_id = er.REQUEST_DETAIL_ID));',
'    END IF;',
'',
'    -- Write log attachments',
'    -- INSERT INTO OUTPUT_LOGS(NUMBER1, STR1, STR2, STR3)',
'    -- VALUES ((select ID from EMP_REQUESTS er where scholarship_request_id = er.REQUEST_DETAIL_ID), ''savedraft_scho'', :P20002_DEFAULT_IMAGES_URL, :P20002_URL_FILES);',
'    ',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(21284965111734530)
,p_process_success_message=>'Success!'
,p_internal_uid=>21310415858734579
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22025840905485910)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'submit'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'c_date date := to_char(sysdate,''MM/DD/YYYY'');',
'-- SCHOLARSHIP_REQUEST_ID NUMBER;',
'-- line_manager_code nvarchar2(50);',
'',
'begin',
'    -- SELECT MANAGER_ID INTO line_manager_code ',
'    -- FROM EMPLOYEES ',
'    -- WHERE EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
'    --if :P20002_REQUEST_ID is null then',
'--         for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = ''scholarship'' and WF_EXPIRATION_DATE >= sysdate)loop',
'--     insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER)',
'--     values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P20002_NOTE, sysdate,',
'--     :P20002_SCHOLARSHIP_DETAIL,',
'--     rec.WF_PROCESS_ID,:P20002_LINE_MANAGER);',
'-- end loop;',
'    UPDATE SCHOLARSHIP_REQUEST sr',
'    SET STATUS = 2,',
'        -- REQUESTER_CODE = ',
'        --     CASE ',
'        --         WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''D'' THEN :P20002_REQUEST_NAME',
'        --         ELSE :P20002_EMPLOYEE_CODE',
'        --     END,',
'        -- REQUESTER_DEPARTMENT = :P20002_DEPARTMENT,',
'        -- REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE,',
'        -- REQUESTER_LEVEL = :P20002_LEVEL,',
'        PARTNER_NAME = :P20002_PARTNER_NAME,',
'        PARTNER_PHONE = :P20002_PARTNER_PHONE,',
'        PARTNER_TITLE = :P20002_TITLE,',
'        PARTNER_DEPARTMENT = :P20002_PARTNER_DEPARTMENT,',
'        PARTNER_FIELD = :P20002_FIELD,',
'        PARTNER_WORKPLACE = :P20002_WORKPLACE,',
'        RECIPIENT_NAME = :P20002_RECIPIENT_NAME,',
'        RECIPIENT_DOB = :P20002_RECIPIENT_DOB,',
'        RECIPIENT_PHONE = :P20002_RECIPIENT_PHONE,',
'        RECIPIENT_RELATIONSHIP = :P20002_RELATIONSHIP,',
'        RECIPIENT_CAMPUS = :P20002_CAMPUS,',
'        ATTACH_NAME = :P20002_NAME_FILES,',
'        ATTACH_FILE = :P20002_URL_FILES,',
'        RECIPIENT_REPLACEMENT = :P20002_REPLACEMENT,',
'        RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20002_VOUCHER_CODE_REPLACEMENT,',
'        RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20002_EXPIRATION_DATE_REPLACEMENT,',
'        RECIPIENT_NOTE = :P20002_NOTE,',
'        RECIPIENT_REASON_REQUEST = :P20002_REASON_REQUEST',
'        -- DISCOUNT_RATE = :P20002_DISCOUNT_RATE,',
'        -- VOUCHER_CODE = :P20002_VOUCHER_CODE,',
'        -- NUMBER_OF_COURSES = :P20002_NUMBER_OF_COURSES,',
'        -- EFFECTIVE_DATE = :P20002_EFFECTIVE_DATE,',
'        -- EXPIRATION_DATE = :P20002_EXPIRATION_DATE,',
'        -- APPROVED_DATE = :P20002_APPROVED_DATE,',
'        -- CREATED_DATE = c_date',
'',
'    WHERE :P20002_REQUEST_ID = sr.ID;',
'',
'    -- Insert into EMP_REQUEST',
'        ',
'   UPDATE EMP_REQUESTS emp',
'   SET',
'        STATUS = 2,',
'        NOTE = ',
'            CASE ',
'                WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN :P20002_NOTE',
'                ELSE :P20002_REASON_REQUEST',
'            END',
'    WHERE :P20002_REQUEST_ID = emp.REQUEST_DETAIL_ID;',
'',
'    -- Insert ATTACHMENT_HISTORY',
'    IF(:P20002_DEFAULT_IMAGES_URL != :P20002_URL_FILES) THEN',
'        INSERT INTO ATTACHMENT_HISTORY (ATTACHMENT_DATE, EMPLOYEE_CODE, ATTACHMENT_URL, ATTACHMENT_NAME, REQUEST_ID)',
'        VALUES(sysdate, :APP_EMP_CODE, :P20002_URL_FILES, :P20002_NAME_FILES, (select ID from EMP_REQUESTS er where :P20002_REQUEST_ID = er.REQUEST_DETAIL_ID));',
'    END IF;',
'',
'    -- Write log attachments',
'    INSERT INTO OUTPUT_LOGS(NUMBER1, STR1, STR2, STR3)',
'    VALUES ((select ID from EMP_REQUESTS er where :P20002_REQUEST_ID = er.REQUEST_DETAIL_ID), ''submit_scho'', :P20002_DEFAULT_IMAGES_URL, :P20002_URL_FILES);',
'    ',
'    ',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(22025932692485911)
,p_process_success_message=>'Success!'
,p_internal_uid=>22025840905485910
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(21310827227734581)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'save'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'c_date date := to_char(sysdate,''MM/DD/YYYY'');',
'scholarship_request_id number;',
'pro_code nvarchar2(50);',
'begin',
'',
'    --if :P20002_REQUEST_ID is null then',
'    -- select PROMOTION_CODE into pro_code',
'    -- from COREEDU_PROMOTION',
'    -- where PROGRAM = :P20002_PROGRAM and DISCOUNT_RATE = :P20002_DISCOUNT_RATE;',
'    ',
'        INSERT INTO',
'            SCHOLARSHIP_REQUEST(',
'                STATUS,',
'                RECIPIENT_TYPE,',
'                PROGRAM,',
'                REQUESTER_CODE,',
'                REQUESTER_DEPARTMENT,',
'                REQUESTER_DEPARTMENT_CODE,',
'                REQUESTER_LEVEL,',
'                PARTNER_NAME,',
'                PARTNER_PHONE,',
'                PARTNER_TITLE,',
'                PARTNER_DEPARTMENT,',
'                PARTNER_FIELD,',
'                PARTNER_WORKPLACE,',
'                RECIPIENT_NAME,',
'                RECIPIENT_DOB,',
'                RECIPIENT_PHONE,',
'                RECIPIENT_RELATIONSHIP,',
'                RECIPIENT_CAMPUS,',
'                ATTACH_NAME,',
'                ATTACH_FILE,',
'                RECIPIENT_REPLACEMENT,',
'                RECIPIENT_VOUCHER_CODE_REPLACEMENT,',
'                RECIPIENT_EXPIRATION_DATE_REPLACEMENT,',
'                RECIPIENT_NOTE,',
'                RECIPIENT_REASON_REQUEST,',
'                DISCOUNT_RATE,',
'                VOUCHER_CODE,',
'                NUMBER_OF_COURSES,',
'                EFFECTIVE_DATE,',
'                EXPIRATION_DATE,',
'                APPROVED_DATE,',
'                CREATED_DATE,',
'                DETAIL_ID,',
'                PROMOTION_CODE',
'            )',
'        VALUES',
'        (',
'                1,',
'                :P20002_SCHOLARSHIP_RECIPIENT,',
'                :P20002_PROGRAM,',
'                case',
'                    when :P20002_SCHOLARSHIP_RECIPIENT = ''D'' then :P20002_REQUEST_NAME',
'                else',
'                    :P20002_EMPLOYEE_CODE',
'                end,',
'                :P20002_DEPARTMENT,',
'                :P20002_DEPARTMENT_CODE,',
'                :P20002_LEVEL,',
'                :P20002_PARTNER_NAME,',
'                :P20002_PARTNER_PHONE,',
'                :P20002_TITLE,',
'                :P20002_PARTNER_DEPARTMENT,',
'                :P20002_FIELD,',
'                :P20002_WORKPLACE,',
'                :P20002_RECIPIENT_NAME,',
'                :P20002_RECIPIENT_DOB,',
'                :P20002_RECIPIENT_PHONE,',
'                :P20002_RELATIONSHIP,',
'                :P20002_CAMPUS,',
'                :P20002_NAME_FILES,',
'                :P20002_URL_FILES,',
'                :P20002_REPLACEMENT,',
'                :P20002_VOUCHER_CODE_REPLACEMENT,',
'                :P20002_EXPIRATION_DATE_REPLACEMENT,',
'                :P20002_NOTE,',
'                :P20002_REASON_REQUEST,',
'                :P20002_DISCOUNT_RATE,',
'                :P20002_VOUCHER_CODE,',
'                :P20002_NUMBER_OF_COURSES,',
'                :P20002_EFFECTIVE_DATE,',
'                :P20002_EXPIRATION_DATE,',
'                :P20002_APPROVED_DATE,',
'                c_date,',
'                :P20002_SCHOLARSHIP_DETAIL,',
'                pro_code',
'            ) returning ID into scholarship_request_id;',
'',
'        for rec in (',
'            select ',
'                WF_FEATURE_APPLY,',
'                WF_PROCESS_ID ',
'            from ',
'                WORKFLOW ',
'            where ',
'                -- lower(WF_FEATURE_APPLY) = ''scholarship'' ',
'                lower(WF_FEATURE_APPLY) = lower(:P20002_FEATURE) ',
'                and WF_EXPIRATION_DATE >= sysdate)',
'        loop',
'            insert into EMP_REQUESTS(',
'                REQUEST_TYPE,',
'                SUBMIT_DATE,',
'                EMPLOYEE_CODE,',
'                STATUS,',
'                NOTE,',
'                CREATE_DATE,',
'                REQUEST_DETAIL_ID,',
'                WF_PROCESS_ID,',
'                LINE_MANAGER',
'                )',
'            values(',
'                rec.WF_FEATURE_APPLY,',
'                sysdate,',
'                :APP_EMP_CODE,',
'                1,',
'                -- :P20002_NOTE,',
'                CASE ',
'                    WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN :P20002_NOTE',
'                    ELSE :P20002_REASON_REQUEST',
'                END,',
'                sysdate,',
'                scholarship_request_id,',
'                rec.WF_PROCESS_ID,',
'                :P20002_LINE_MANAGER',
'                );',
'        end loop;',
'',
'    ',
'    -- Insert ATTACHMENT_HISTORY',
'    IF(:P20002_DEFAULT_IMAGES_URL != :P20002_URL_FILES or',
'       ( :P20002_REQUEST_ID is null and :P20002_URL_FILES is not null )) ',
'    THEN',
'        INSERT INTO ATTACHMENT_HISTORY (ATTACHMENT_DATE, EMPLOYEE_CODE, ATTACHMENT_URL, ATTACHMENT_NAME, REQUEST_ID)',
'        VALUES(sysdate, :APP_EMP_CODE, :P20002_URL_FILES, :P20002_NAME_FILES, (select ID from EMP_REQUESTS er where scholarship_request_id = er.REQUEST_DETAIL_ID));',
'    END IF;',
'',
'    -- Write log attachments',
'    -- INSERT INTO OUTPUT_LOGS(NUMBER1, STR1, STR2, STR3)',
'    -- VALUES ((select ID from EMP_REQUESTS er where scholarship_request_id = er.REQUEST_DETAIL_ID), ''savedraft_scho'', :P20002_DEFAULT_IMAGES_URL, :P20002_URL_FILES);',
'    ',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(21285326290734531)
,p_process_success_message=>'Success!'
,p_internal_uid=>21310827227734581
);
end;
/
begin
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22025683135485908)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'c_date date := to_char(sysdate,''MM/DD/YYYY'');',
'scholarship_request_id number;',
'begin',
'',
'    UPDATE SCHOLARSHIP_REQUEST sr',
'    SET ',
'        -- STATUS = 1,',
'        -- RECIPIENT_TYPE = :P20002_SCHOLARSHIP_RECIPIENT,',
'        -- PROGRAM = :P20002_PROGRAM,',
'        -- REQUESTER_CODE = ',
'        --     CASE ',
'        --         WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''D'' THEN :P20002_REQUEST_NAME',
'        --         ELSE :P20002_EMPLOYEE_CODE',
'        --     END,',
'        -- REQUESTER_DEPARTMENT = :P20002_DEPARTMENT,',
'        -- REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE,',
'        -- REQUESTER_LEVEL = :P20002_LEVEL,',
'        PARTNER_NAME = :P20002_PARTNER_NAME,',
'        PARTNER_PHONE = :P20002_PARTNER_PHONE,',
'        PARTNER_TITLE = :P20002_TITLE,',
'        PARTNER_DEPARTMENT = :P20002_PARTNER_DEPARTMENT,',
'        PARTNER_FIELD = :P20002_FIELD,',
'        PARTNER_WORKPLACE = :P20002_WORKPLACE,',
'        RECIPIENT_NAME = :P20002_RECIPIENT_NAME,',
'        RECIPIENT_DOB = :P20002_RECIPIENT_DOB,',
'        RECIPIENT_PHONE = :P20002_RECIPIENT_PHONE,',
'        RECIPIENT_RELATIONSHIP = :P20002_RELATIONSHIP,',
'        RECIPIENT_CAMPUS = :P20002_CAMPUS,',
'        ATTACH_NAME = :P20002_NAME_FILES,',
'        ATTACH_FILE = :P20002_URL_FILES,',
'        RECIPIENT_REPLACEMENT = :P20002_REPLACEMENT,',
'        RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20002_VOUCHER_CODE_REPLACEMENT,',
'        RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20002_EXPIRATION_DATE_REPLACEMENT,',
'        RECIPIENT_NOTE = :P20002_NOTE,',
'        RECIPIENT_REASON_REQUEST = :P20002_REASON_REQUEST,',
'        DISCOUNT_RATE = :P20002_DISCOUNT_RATE,',
'        VOUCHER_CODE = :P20002_VOUCHER_CODE,',
'        NUMBER_OF_COURSES = :P20002_NUMBER_OF_COURSES,',
'        EFFECTIVE_DATE = :P20002_EFFECTIVE_DATE,',
'        EXPIRATION_DATE = :P20002_EXPIRATION_DATE,',
'        APPROVED_DATE = :P20002_APPROVED_DATE,',
'        CREATED_DATE = c_date',
'    WHERE :P20002_REQUEST_ID = sr.ID;',
'',
'    UPDATE EMP_REQUESTS emp',
'    SET',
'        NOTE = ',
'            CASE ',
'                WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN :P20002_NOTE',
'                ELSE :P20002_REASON_REQUEST',
'            END',
'    WHERE :P20002_REQUEST_ID = emp.REQUEST_DETAIL_ID;',
'',
'',
'    -- Insert ATTACHMENT_HISTORY',
'    IF(:P20002_DEFAULT_IMAGES_URL != :P20002_URL_FILES) THEN',
'        INSERT INTO ATTACHMENT_HISTORY (ATTACHMENT_DATE, EMPLOYEE_CODE, ATTACHMENT_URL, ATTACHMENT_NAME, REQUEST_ID)',
'        VALUES(sysdate, :APP_EMP_CODE, :P20002_URL_FILES, :P20002_NAME_FILES, (select ID from EMP_REQUESTS er where :P20002_REQUEST_ID = er.REQUEST_DETAIL_ID));',
'    END IF;',
'',
'    -- Write log attachments',
'    -- INSERT INTO OUTPUT_LOGS(NUMBER1, STR1, STR2, STR3)',
'    -- VALUES ((select ID from EMP_REQUESTS er where :P20002_REQUEST_ID = er.REQUEST_DETAIL_ID), ''upload_scho'', :P20002_DEFAULT_IMAGES_URL, :P20002_URL_FILES);',
'    ',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(21751104994265950)
,p_process_success_message=>'Success!'
,p_internal_uid=>22025683135485908
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(25263056677676332)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'delete'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'    DELETE FROM SCHOLARSHIP_REQUEST sr',
'    WHERE :P20002_REQUEST_ID = sr.ID;',
'',
'    DELETE FROM EMP_REQUESTS emp',
'    WHERE :P20002_REQUEST_ID = emp.REQUEST_DETAIL_ID;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(25262947810676331)
,p_process_success_message=>'Success!'
,p_internal_uid=>25263056677676332
);
end;
/
prompt --application/pages/delete_20003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>20003);
end;
/
prompt --application/pages/page_20003
begin
wwv_flow_imp_page.create_page(
 p_id=>20003
,p_name=>'scholarchip_request'
,p_alias=>'SCHOLARCHIP-REQUEST'
,p_step_title=>'Scholarship Request'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const setDefaultReport = function(){',
'',
'    $(''.igrid_p25_1'').each(element => {',
'        ',
'        let igActions = apex.region($(''.igrid_p25_1'')[element].id).call("getActions");',
'',
'        let choices =  igActions.lookup("change-report").choices;',
'',
'',
'        if(choices.length > 0){',
'            ',
'            let primary = choices.filter(obj => {',
'',
'                return obj.group === "Default_History";',
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
'}'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* auto wrap cho header */',
'.a-GV-header .a-GV-headerLabel {',
'    white-space: normal;',
'    text-align: center;',
'}',
'',
'/* auto wrap cho cell */',
'.a-GV-cell {',
'    white-space: normal !important;',
'    text-align: center !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'Y'
,p_navigation_list_position=>'SIDE'
,p_navigation_list_id=>wwv_flow_imp.id(18598165733888960)
,p_navigation_list_template_id=>wwv_flow_imp.id(18761008355889106)
,p_nav_list_template_options=>'#DEFAULT#:t-TreeNav--styleA:js-navCollapsed--hidden'
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20231129173708'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(22026262804485914)
,p_plug_name=>'Scholarship Request'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18712759415889069)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(18597660344888957)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(18774898137889124)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(34475133385529952)
,p_plug_name=>'Filter fields'
,p_region_css_classes=>'igrid_p25_1'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>30
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(36264271518840582)
,p_plug_name=>'SCHOLARSHIP REQUEST I-GRID'
,p_region_css_classes=>'igrid_p25_1'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>40
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sr.ID,',
'       er.STATUS,',
'       sr.RECIPIENT_TYPE,',
'       sr.PROGRAM,',
'       sr.PARTNER_NAME,',
'       sr.PARTNER_PHONE,',
'       sr.PARTNER_TITLE,',
'       sr.PARTNER_DEPARTMENT,',
'       sr.PARTNER_FIELD,',
'       sr.PARTNER_WORKPLACE,',
'       sr.RECIPIENT_NAME,',
'       sr.RECIPIENT_DOB,',
'       sr.RECIPIENT_PHONE,',
'       sr.RECIPIENT_RELATIONSHIP,',
'       sr.RECIPIENT_CAMPUS,',
'       sr.ATTACH_NAME,',
'       sr.ATTACH_FILE,',
'       sr.RECIPIENT_REPLACEMENT,',
'       sr.RECIPIENT_VOUCHER_CODE_REPLACEMENT,',
'       sr.RECIPIENT_EXPIRATION_DATE_REPLACEMENT,',
'       sr.RECIPIENT_NOTE,',
'       sr.RECIPIENT_REASON_REQUEST,',
'       sr.DISCOUNT_RATE,',
'       sr.VOUCHER_CODE,',
'       sr.NUMBER_OF_COURSES,',
'       sr.EFFECTIVE_DATE,',
'       sr.EXPIRATION_DATE,',
'       sr.APPROVED_DATE,',
'       sr.CREATED_DATE,',
'       emp.FULL_NAME,',
'       emp.LEVEL_DESCRIPTION,',
'       emp.EMPLOYEE_CODE,',
'       emp.START_DATE,',
'       emp.TERMINATE_DATE,',
'       emp.DEPARTMENT_ID,',
'       emp.DEPARTMENT_NAME',
'  from SCHOLARSHIP_REQUEST sr',
'  join EMP_REQUESTS er on er.REQUEST_DETAIL_ID = sr.ID',
'  join EMPLOYEES emp on sr.REQUESTER_CODE = emp.EMPLOYEE_CODE',
'  Where sr.REQUESTER_CODE = :APP_EMP_CODE',
'  AND sr.EFFECTIVE_DATE between to_date(:P20003_DATE_FROM,''MM/DD/YYYY'') and to_date(:P20003_DATE_TO,''MM/DD/YYYY'')',
'  AND ( TRIM(:P20003_STATUS) = ''0''  OR er.STATUS = TRIM(:P20003_STATUS))',
'  AND ( TRIM(:P20003_SCHOLARSHIP_RECIPIENT) = ''0''  OR sr.RECIPIENT_TYPE = :P20003_SCHOLARSHIP_RECIPIENT);'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P20003_DATE_FROM,P20003_DATE_TO,P20003_SCHOLARSHIP_RECIPIENT,P20003_STATUS'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'SCHOLARSHIP REQUEST I-GRID'
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
 p_id=>wwv_flow_imp.id(36384236612938867)
,p_heading=>'Scholarship Information'
,p_label=>'SI'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(36384328358938868)
,p_heading=>'Information Of Recipient'
,p_label=>'IOR'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(36384404454938869)
,p_heading=>'Requester/ Department Request Information'
,p_label=>'RDRI'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(36384522459938870)
,p_heading=>'Partner Information'
,p_label=>'PI'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36264518067840584)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36264580437840585)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Status'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(36384236612938867)
,p_use_group_for=>'BOTH'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(13153015369193856)
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
,p_duplicate_value=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36264730785840586)
,p_name=>'RECIPIENT_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_TYPE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Scholarship Recipient'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>50
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(36384236612938867)
,p_use_group_for=>'BOTH'
,p_is_required=>true
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(13149840134168038)
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
 p_id=>wwv_flow_imp.id(36264822358840587)
,p_name=>'PROGRAM'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROGRAM'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Program'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384236612938867)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>true
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36265276838840592)
,p_name=>'PARTNER_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Name'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384522459938870)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36265451586840593)
,p_name=>'PARTNER_PHONE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_PHONE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Phone'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384522459938870)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
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
 p_id=>wwv_flow_imp.id(36265548644840594)
,p_name=>'PARTNER_TITLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_TITLE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Title'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384522459938870)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36382052354938845)
,p_name=>'PARTNER_DEPARTMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_DEPARTMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Department'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384522459938870)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36382164412938846)
,p_name=>'PARTNER_FIELD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_FIELD'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Field'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384522459938870)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36382245170938847)
,p_name=>'PARTNER_WORKPLACE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_WORKPLACE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Workplace'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384522459938870)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36382303054938848)
,p_name=>'RECIPIENT_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Full name'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36382389195938849)
,p_name=>'RECIPIENT_DOB'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_DOB'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'DOB'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(36382514129938850)
,p_name=>'RECIPIENT_PHONE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_PHONE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Phone'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>190
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36382663967938851)
,p_name=>'RECIPIENT_RELATIONSHIP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_RELATIONSHIP'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Relationship'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>200
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(14989626799293948)
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
 p_id=>wwv_flow_imp.id(36382711864938852)
,p_name=>'RECIPIENT_CAMPUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_CAMPUS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Campus'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>210
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36382798046938853)
,p_name=>'ATTACH_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATTACH_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Attach Name'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>220
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>8000
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36382913775938854)
,p_name=>'ATTACH_FILE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATTACH_FILE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Attach File'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>230
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>8000
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36383061318938855)
,p_name=>'RECIPIENT_REPLACEMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_REPLACEMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Replacement for (if any)'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>240
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(36383084136938856)
,p_name=>'RECIPIENT_VOUCHER_CODE_REPLACEMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_VOUCHER_CODE_REPLACEMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Voucher code (replacement)'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>250
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36383243222938857)
,p_name=>'RECIPIENT_EXPIRATION_DATE_REPLACEMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_EXPIRATION_DATE_REPLACEMENT'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Expiration date (replacement)'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>260
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
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
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36383272805938858)
,p_name=>'RECIPIENT_NOTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_NOTE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Note'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>270
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36383424617938859)
,p_name=>'RECIPIENT_REASON_REQUEST'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_REASON_REQUEST'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Reason request'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>280
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
,p_use_group_for=>'BOTH'
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36383567265938860)
,p_name=>'DISCOUNT_RATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DISCOUNT_RATE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Discount rate'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>290
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(36384328358938868)
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
 p_id=>wwv_flow_imp.id(36383619895938861)
,p_name=>'VOUCHER_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VOUCHER_CODE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Voucher code'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>300
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384236612938867)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36383673945938862)
,p_name=>'NUMBER_OF_COURSES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NUMBER_OF_COURSES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Number Of Courses'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>310
,p_value_alignment=>'RIGHT'
,p_group_id=>wwv_flow_imp.id(36384236612938867)
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36383865624938863)
,p_name=>'EFFECTIVE_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EFFECTIVE_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Effective date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>320
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384236612938867)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(36383920529938864)
,p_name=>'EXPIRATION_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EXPIRATION_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Expiration date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>330
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384236612938867)
,p_use_group_for=>'BOTH'
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
end;
/
begin
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36383977213938865)
,p_name=>'APPROVED_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APPROVED_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Approved date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>340
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384236612938867)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(36384155704938866)
,p_name=>'CREATED_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Created date'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>350
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384236612938867)
,p_use_group_for=>'BOTH'
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
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36384689972938872)
,p_name=>'ACTIONS$MENU'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
,p_link_target=>'f?p=&APP_ID.:20002:&SESSION.::&DEBUG.:20002:P20002_REQUEST_ID,P20002_STATUS:&ID.,&STATUS.'
,p_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_escape_on_http_output=>true
,p_column_comment=>'code cu da ve page 22'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(36720907085789545)
,p_name=>'REQUESTER_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FULL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Requester'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>360
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384404454938869)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(36721022317789546)
,p_name=>'TERMINATE_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TERMINATE_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Terminate date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>370
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384404454938869)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(36721147980789547)
,p_name=>'DEPARTMENT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DEPARTMENT_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Department code'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>380
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384404454938869)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
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
 p_id=>wwv_flow_imp.id(36721257548789548)
,p_name=>'LEVEL_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LEVEL_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Level'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>390
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384404454938869)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
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
 p_id=>wwv_flow_imp.id(36721314028789549)
,p_name=>'EMPLOYEE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Employee code'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>400
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384404454938869)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(36721432158789550)
,p_name=>'START_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'START_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Start date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>410
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384404454938869)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(36721536398789551)
,p_name=>'DEPARTMENT_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DEPARTMENT_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Department'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>420
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(36384404454938869)
,p_use_group_for=>'BOTH'
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
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(36264420791840583)
,p_internal_uid=>36264420791840583
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SET'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>false
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(36387597508939657)
,p_interactive_grid_id=>wwv_flow_imp.id(36264420791840583)
,p_static_id=>'150419'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(36387814928939657)
,p_report_id=>wwv_flow_imp.id(36387597508939657)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(21347864306762785)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>32
,p_column_id=>wwv_flow_imp.id(36721022317789546)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>85
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(21348852277762789)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>33
,p_column_id=>wwv_flow_imp.id(36721147980789547)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>94
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36388332882939659)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(36264518067840584)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>77
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36389214592939664)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(36264580437840585)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>75
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36390150475939668)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(36264730785840586)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>92.078
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36391060153939671)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(36264822358840587)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>69.05000000000001
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36395531198939688)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>35
,p_column_id=>wwv_flow_imp.id(36265276838840592)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>156.188
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36396463279939691)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>36
,p_column_id=>wwv_flow_imp.id(36265451586840593)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>126.4000244140625
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36397274671939694)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>28
,p_column_id=>wwv_flow_imp.id(36265548644840594)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>86
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36398182004939697)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>30
,p_column_id=>wwv_flow_imp.id(36382052354938845)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>138.8000244140625
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36399140372939701)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>29
,p_column_id=>wwv_flow_imp.id(36382164412938846)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>85.0375
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36400064256939704)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>37
,p_column_id=>wwv_flow_imp.id(36382245170938847)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>129.2120732421875
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36400955790939707)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(36382303054938848)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>123
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36401845450939709)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(36382389195938849)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>83
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36402698130939712)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>19
,p_column_id=>wwv_flow_imp.id(36382514129938850)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>93.0375
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36403634940939716)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>15
,p_column_id=>wwv_flow_imp.id(36382663967938851)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>88.025
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36404479087939719)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>20
,p_column_id=>wwv_flow_imp.id(36382711864938852)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>84.025
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36405412572939722)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>23
,p_column_id=>wwv_flow_imp.id(36382798046938853)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>91
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36406277091939726)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>24
,p_column_id=>wwv_flow_imp.id(36382913775938854)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>91.05
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36407181743939729)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>16
,p_column_id=>wwv_flow_imp.id(36383061318938855)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>170
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36408067534939734)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>17
,p_column_id=>wwv_flow_imp.id(36383084136938856)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>187
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36408892410939738)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>18
,p_column_id=>wwv_flow_imp.id(36383243222938857)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>187.0375
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36409813414939741)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>21
,p_column_id=>wwv_flow_imp.id(36383272805938858)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>106.075
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36410703293939745)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>22
,p_column_id=>wwv_flow_imp.id(36383424617938859)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>113.0625
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36411639584939748)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>14
,p_column_id=>wwv_flow_imp.id(36383567265938860)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>75
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36412562557939752)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(36383619895938861)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>188
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36413430152939755)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(36383673945938862)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>140.0625
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36414273302939758)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(36383865624938863)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>87
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36415200216939762)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(36383920529938864)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>90
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36416140795939765)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(36383977213938865)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>88
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36417049505939768)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(36384155704938866)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>92
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36465294762023581)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(36384689972938872)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36726936366790506)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>25
,p_column_id=>wwv_flow_imp.id(36720907085789545)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>132
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36733081871879547)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>26
,p_column_id=>wwv_flow_imp.id(36721257548789548)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>101
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36733985579879550)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>27
,p_column_id=>wwv_flow_imp.id(36721314028789549)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>113
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36734902493879552)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>31
,p_column_id=>wwv_flow_imp.id(36721432158789550)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>87
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(36735845234879555)
,p_view_id=>wwv_flow_imp.id(36387814928939657)
,p_display_seq=>34
,p_column_id=>wwv_flow_imp.id(36721536398789551)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>126.26599999999999
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21364227823740667)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(34475133385529952)
,p_button_name=>'Search'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Search'
,p_warn_on_unsaved_changes=>null
,p_grid_column_css_classes=>'search-btn'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(21366235633740669)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(22026262804485914)
,p_button_name=>'new_scholarship_request'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'Add New'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:20002:&SESSION.::&DEBUG.:20002::'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34494109936529977)
,p_name=>'P20003_SCHOLARSHIP_RECIPIENT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(34475133385529952)
,p_item_default=>'0'
,p_pre_element_text=>'Scholarship Recipient'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SCHOLARSHIP_RECIPIENT'
,p_lov=>'.'||wwv_flow_imp.id(13149840134168038)||'.'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'All'
,p_lov_null_value=>'0'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34494229514529978)
,p_name=>'P20003_STATUS'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(34475133385529952)
,p_item_default=>'0'
,p_pre_element_text=>'Status'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'STATUS_SCHOLARSHIP'
,p_lov=>'.'||wwv_flow_imp.id(13153015369193856)||'.'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'All'
,p_lov_null_value=>'0'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34494445711529980)
,p_name=>'P20003_DATE_FROM'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(34475133385529952)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TRUNC(SYSDATE, ''YEAR'') AS first_day_of_current_year FROM DUAL;',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Created date: From'
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
 p_id=>wwv_flow_imp.id(34494557224529981)
,p_name=>'P20003_DATE_TO'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(34475133385529952)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_CHAR(SYSDATE, ''MM/DD/YYYY'') AS formatted_date FROM DUAL;',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'To'
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
 p_id=>wwv_flow_imp.id(25095727073455614)
,p_name=>'Search click'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(21364227823740667)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25095899093455615)
,p_event_id=>wwv_flow_imp.id(25095727073455614)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Refressh'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(36264271518840582)
);
end;
/
prompt --application/pages/delete_20004
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>20004);
end;
/
prompt --application/pages/page_20004
begin
wwv_flow_imp_page.create_page(
 p_id=>20004
,p_name=>'confirm_scholarship_request'
,p_alias=>'CONFIRM-SCHOLARSHIP-REQUEST'
,p_step_title=>'Scholarship Request'
,p_autocomplete_on_off=>'OFF'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#P20004_REASON_REQUEST, #P20004_NOTE{',
'    height: 80px !important;',
'}',
'.btn-delete{',
'    color: white;font-size: 12px;cursor: pointer;background: red !important;display: block;width: 20px;height:20px;text-align: center;border-radius: 50%;',
'    display: none !important;',
'}',
'.file-item{',
'    display:flex; gap:10px;margin:15px;',
'    z-index: 100;',
'}',
'.apex-item-filedrop-filename {',
'    display: none;',
'}',
'.apex-item-group.apex-item-group--file.apex-item-group--file-browse {',
'    margin-top: 0 !important;',
'    height: max-content !important;',
'}',
'#btn_submit {',
'    color: #000000 !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20231129181514'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(55899866389408264)
,p_plug_name=>'ADD NEW'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(18710165183889068)
,p_plug_display_sequence=>10
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56375911958622915)
,p_plug_name=>'Scholarship information'
,p_parent_plug_id=>wwv_flow_imp.id(55899866389408264)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56376537983622921)
,p_plug_name=>'Request/ Department Request Information'
,p_parent_plug_id=>wwv_flow_imp.id(56375911958622915)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56377187868622928)
,p_plug_name=>'Partner Information'
,p_parent_plug_id=>wwv_flow_imp.id(56375911958622915)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>30
,p_plug_grid_row_css_classes=>'region_partner'
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56377310389622929)
,p_plug_name=>'Scholarship Information'
,p_parent_plug_id=>wwv_flow_imp.id(56375911958622915)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>50
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(56463374642152939)
,p_plug_name=>'Information Of Recipient'
,p_parent_plug_id=>wwv_flow_imp.id(56375911958622915)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>40
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- Loading spinner container -->',
'<div class="loader-container" id="loader-container">',
'    <div class="loader"></div>',
'</div>',
'',
'<script>',
'    // GLOBAL FUNCTION',
'',
'    // Get current date formatted as dd-mm-yyyy',
'    function getCurrentDateFormatted() {',
'        const currentDate = new Date();',
'',
'        const day = String(currentDate.getDate()).padStart(2, ''0'');',
'        const month = String(currentDate.getMonth() + 1).padStart(2, ''0''); // Months are zero-based, so add 1',
'        const year = currentDate.getFullYear();',
'',
'        return `${day}-${month}-${year}`;',
'    }',
'',
'    // Delete a value from a FormData object',
'    function deleteValue(formData, key, value) {',
'        const values = formData.getAll(key);',
'        const updatedValues = values.filter(v => v !== value);',
'',
'        // Remove all values associated with the key',
'        formData.delete(key);',
'',
'        // Append the updated values back to the FormData object',
'        updatedValues.forEach(updatedValue => {',
'            formData.append(key, updatedValue);',
'        });',
'    }',
'',
'    function handleDeleteClick_PP(event) {',
'        if (event.target.classList.contains("delete-item")) {',
'            const itemToRemove = event.target.closest("div");',
'            const name = event.target.dataset.name;',
'            const url = itemToRemove.querySelector("a").getAttribute("href");',
'            const files = formData_PP.getAll("files");',
'            const updatedFiles = files.filter((file) => file.name !== name);',
'            formData_PP.delete("files");',
'            fileArrayNames_PP = fileArrayNames_PP.filter((item) => item !== name);',
'            fileArrayUrls_PP = fileArrayNames_PP.filter((item) => item !== url);',
'            updatedFiles.forEach((file) => formData_PP.append("files", file));',
'            if (itemToRemove) {',
'                itemToRemove.remove();',
'                document.getElementById("loader-container").style.display = "none";',
'            }',
'        }',
'    }',
'</script>',
'',
'<script>',
'    let formData_PP = new FormData();',
'    let fileNames_PP;',
'    let fileUrls_PP;',
'    let fileArrayNames_PP = [];',
'    let fileArrayUrls_PP = [];',
'',
'    //  Get default values from hidden items',
'    window.addEventListener("load", function () {',
'        var imageUrlsID = apex.item("P20004_DEFAULT_IMAGES_URL").getValue();',
'        var imageNamesID = apex.item("P20004_DEFAULT_IMAGES_NAME").getValue();',
'        var imageContainer = document.getElementById("P20004_ATTACHMENT_GROUP");',
'        const urlArray = imageUrlsID.split(";");',
'        const nameArray = imageNamesID.split(";");',
'        apex.item("P20004_URL_FILES").setValue(imageUrlsID);',
'        apex.item("P20004_NAME_FILES").setValue(imageNamesID);',
'',
'        // Create hidden input elements for each default image',
'        for (let i = 0; i < urlArray.length; i++) {',
'            const imageUrl = urlArray[i];',
'            const imageName = nameArray[i];',
'            fileArrayNames_PP.push(imageName);',
'            fileArrayUrls_PP.push(imageUrl);',
'            let hiddenInputHTML;',
'            if (imageUrl != "" || imageName != "") {',
'                hiddenInputHTML = `',
'        <div class="file-item ">',
'            <span  id="deleteItem${imageName}" data-name="${imageName}" class="delete-item btn-delete vng-true"> X </span>',
'            <a name="${imageName}" href="${imageUrl}" target="_blank" class="dynamic-value-page">',
'                ${imageName}',
'            </a>',
'        </div>',
'    `;',
'            } else {',
'                hiddenInputHTML = ``;',
'            }',
'            imageContainer.insertAdjacentHTML("beforeend", hiddenInputHTML);',
'        }',
'',
'        var deleteButtons = document.querySelectorAll(".btn-delete");',
'        deleteButtons.forEach(function (button) {',
'            button.addEventListener("click", handleDeleteClick_PP);',
'        });',
'',
'        var userName = apex.item("P20004_USER_FULLNAME").getValue();',
'        var userCode = apex.item("P20004_USER_EMPLOYEE_CODE").getValue();',
'',
'        formData_PP.append("name", userName);',
'        formData_PP.append("msnv", userCode);',
'        document',
'            .getElementById("P20004_ATTACHMENT")',
'            .addEventListener("change", function (event) {',
'                const imageFiles = event.target.files;',
'                const hiddenInputContainer = document.getElementById(',
'                    "P20004_ATTACHMENT_GROUP"',
'                );',
'                const maxFileSize = 1 * 1024 * 1024; // 1MB in bytes',
'',
'                formData_PP.append("date", getCurrentDateFormatted());',
'                console.log(getCurrentDateFormatted());',
'',
'                for (const imageFile of imageFiles) {',
'                    const fileName = imageFile.name;',
'                    const fileURL = URL.createObjectURL(imageFile);',
'                    if (imageFile.size > maxFileSize) {',
'                        // Show an error message or take appropriate action',
'                        alert(',
'                            `File ${fileName} is larger than 1MB. Please choose a smaller file.`',
'                        );',
'                        continue; // Skip this file',
'                    }',
'',
'                    formData_PP.append("files", imageFile);',
'',
'                    const hiddenInputHTML = `',
'        <div class="file-item id-numb-file">',
'            <a href="${fileURL}" target="_blank">',
'                ${fileName}',
'            </a>',
'            <span id="deleteItem${fileName}" data-name="${fileName}" class="delete-item btn-delete"> X </span>',
'        </div>',
'      `;',
'                    hiddenInputContainer.insertAdjacentHTML("beforeend", hiddenInputHTML);',
'                }',
'                hiddenInputContainer.addEventListener("click", handleDeleteClick_PP);',
'            });',
'    });',
'',
'    //UPLOAD FILE',
'    //SUBMIT FORM',
'',
'    //END SUBMIT FORM',
'',
'</script>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(84527567361569494)
,p_plug_name=>'View workflow details'
,p_parent_plug_id=>wwv_flow_imp.id(55899866389408264)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(84530901118569527)
,p_plug_name=>'WORKFLOW_DETAILS'
,p_parent_plug_id=>wwv_flow_imp.id(84527567361569494)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select wd.ID,',
'       wd.WD_MODIFIED_DATE,',
'       wd.WD_MODIFIED_CODE,',
'       e.FULL_NAME,',
'       wd.WD_COMMENT,',
'       wd.STATUS',
'  from WORKFLOW_DETAIL wd',
'  join EMPLOYEES e on wd.WD_MODIFIED_CODE = e.EMPLOYEE_CODE',
'  where wd.REQUEST_ID = :P20004_REQUEST_ID;'))
,p_plug_source_type=>'NATIVE_IG'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'WORKFLOW_DETAILS'
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
 p_id=>wwv_flow_imp.id(22027095745485922)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Status'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(25896101346579947)
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
 p_id=>wwv_flow_imp.id(71975376351485264)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>10
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
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(71975489438485265)
,p_name=>'WD_MODIFIED_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WD_MODIFIED_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Modified date'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_imp.id(71975660604485267)
,p_name=>'WD_COMMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WD_COMMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Comment'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>40
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
 p_id=>wwv_flow_imp.id(71977902255485289)
,p_name=>'WD_MODIFIED_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WD_MODIFIED_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(71977993538485290)
,p_name=>'FULL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FULL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Modified by'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>30
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_imp.id(84531499632569533)
,p_internal_uid=>84531499632569533
,p_is_editable=>false
,p_lazy_loading=>false
,p_requires_filter=>false
,p_select_first_row=>true
,p_fixed_row_height=>true
,p_pagination_type=>'SCROLL'
,p_show_total_row_count=>true
,p_show_toolbar=>true
,p_enable_save_public_report=>true
,p_enable_subscriptions=>true
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(84605992187030116)
,p_interactive_grid_id=>wwv_flow_imp.id(84531499632569533)
,p_static_id=>'129652'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(84606212288030117)
,p_report_id=>wwv_flow_imp.id(84605992187030116)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(22697266423066939)
,p_view_id=>wwv_flow_imp.id(84606212288030117)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(22027095745485922)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(71981333472487081)
,p_view_id=>wwv_flow_imp.id(84606212288030117)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(71975376351485264)
,p_is_visible=>false
,p_is_frozen=>false
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(71982245760487085)
,p_view_id=>wwv_flow_imp.id(84606212288030117)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(71975489438485265)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>316
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(71984032003487091)
,p_view_id=>wwv_flow_imp.id(84606212288030117)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(71975660604485267)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>315
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(72180431107619602)
,p_view_id=>wwv_flow_imp.id(84606212288030117)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(71977902255485289)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(72181279661619606)
,p_view_id=>wwv_flow_imp.id(84606212288030117)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(71977993538485290)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>328
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(84531880122597701)
,p_plug_name=>'Attachment history'
,p_parent_plug_id=>wwv_flow_imp.id(55899866389408264)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(84536338728597745)
,p_plug_name=>'ATTACHMENT_HISTORY'
,p_parent_plug_id=>wwv_flow_imp.id(84531880122597701)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ah.ID,',
'        ah.ATTACHMENT_DATE,',
'       e.FULL_NAME,',
'       TO_HREF_HTML_ATTACHMENT(ah.ATTACHMENT_URL, ah.ATTACHMENT_NAME) as attachment',
'from ATTACHMENT_HISTORY ah',
'join EMPLOYEES e on e.EMPLOYEE_CODE = ah.EMPLOYEE_CODE',
'where  ah.REQUEST_ID = (select ID from EMP_REQUESTS er where er.REQUEST_DETAIL_ID = :P20002_REQUEST_ID and rownum = 1)'))
,p_plug_source_type=>'NATIVE_IG'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'ATTACHMENT_HISTORY'
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
 p_id=>wwv_flow_imp.id(25096574933455622)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Id'
,p_heading_alignment=>'RIGHT'
,p_display_sequence=>60
,p_value_alignment=>'RIGHT'
,p_attribute_03=>'left'
,p_attribute_04=>'decimal'
,p_is_required=>true
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
 p_id=>wwv_flow_imp.id(25096663292455623)
,p_name=>'ATTACHMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATTACHMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Attachment'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>70
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_imp.id(71983132572513505)
,p_name=>'ATTACHMENT_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATTACHMENT_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Attachment date'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>20
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_imp.id(71983431120513508)
,p_name=>'FULL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FULL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Attachment by'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
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
 p_id=>wwv_flow_imp.id(84536465166597746)
,p_internal_uid=>84536465166597746
,p_is_editable=>false
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
,p_enable_flashback=>true
,p_define_chart_view=>true
,p_enable_download=>true
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(84622807714138687)
,p_interactive_grid_id=>wwv_flow_imp.id(84536465166597746)
,p_static_id=>'129778'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(84623021525138687)
,p_report_id=>wwv_flow_imp.id(84622807714138687)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(25713028244413685)
,p_view_id=>wwv_flow_imp.id(84623021525138687)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(25096574933455622)
,p_is_visible=>false
,p_is_frozen=>false
,p_width=>75
,p_sort_order=>1
,p_sort_direction=>'ASC'
,p_sort_nulls=>'LAST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(25713908215413690)
,p_view_id=>wwv_flow_imp.id(84623021525138687)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(25096663292455623)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(72322321007795016)
,p_view_id=>wwv_flow_imp.id(84623021525138687)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(71983132572513505)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>165
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(72324122588795023)
,p_view_id=>wwv_flow_imp.id(84623021525138687)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(71983431120513508)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>184
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(22210773679535753)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(56375911958622915)
,p_button_name=>'Approve'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Approve'
,p_button_position=>'CHANGE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
unistr('    n_check number;     -- bi\1EBFn ki\1EBFm tra \1EA9n/hi\1EC7n n\00FAt'),
unistr('    n_check_seq number; -- bi\1EBFn ki\1EC3m tra sequence trong emp_requests, \0111\00E2y l\00E0 tr\01B0\1EDDng h\1EE3p m\1EDBi t\1EA1o requests, ch\01B0a duy\1EC7t l\1EA7n n\00E0o'),
'    n_check_line_man number;',
'begin',
unistr('    -- t\00ECm xem d\00F2ng request_id c\00F3 next_step b\1EB1ng m\1EA5y? = 1 th\00EC n_check_seq = count(id) = 1 ti\1EBFp t\1EE5c v\00E0o if d\01B0\1EDBi'),
unistr('    --                                                > 1 th\00EC  n_check_seq = count(id) = 0 ti\1EBFp t\1EE5c v\00E0o else d\01B0\1EDBi'),
'    select count(id) ',
'    into n_check_seq ',
'    from EMP_REQUESTS er ',
'    where next_step = 1 and er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID;',
'    ',
unistr('    -- tr\01B0\1EDDng h\1EE3p = 1 th\00EC ki\1EC3m tra user hi\1EC7n t\1EA1i c\00F3 ph\1EA3i l\00E0 line_manager c\1EE7a nv t\1EA1o request'),
'    if n_check_seq > 0 then',
'        select count(id) ',
'        into n_check_line_man ',
'        from EMP_REQUESTS er ',
unistr('        where next_step = 1 and er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID and er.line_manager = :APP_EMP_CODE ; --so s\00E1nh line_manager trong request v\1EDBi emp_code c\1EE7a user'),
'        ',
'        if n_check_line_man > 0 then',
unistr('            return true;    -- \0111\00FAng th\00EC hi\1EC7n n\00FAt'),
'            else',
unistr('            return false;   -- sai th\00EC kh\00F4ng hi\1EC7n'),
'        end if;',
'    else',
'        select count(er.id) ',
'        into n_check ',
'        from EMP_REQUESTS er',
unistr('            join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID    -- join b\1EB1ng c\00F9ng process_id'),
unistr('            join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP      -- join b\1EB1ng c\00F9ng nh\00F3m duy\1EC7t'),
unistr('        where er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID -- \0111ang x\00E9t request_id hi\1EC7n t\1EA1i'),
unistr('            and er.NEXT_STEP = wa.WA_SEQUENCE_NUMBER    -- ki\1EC3m tra xem next_step \0111ang t\1EDBi b\01B0\1EDBc n\00E0o'),
unistr('            and emp.EMPLOYEE_CODE = :APP_EMP_CODE       -- ki\1EC3m tra nv hi\1EC7n t\1EA1i c\00F3 ph\1EA3i thu\1ED9c v\00E0o approval group kh\00F4ng'),
unistr('            and er.STATUS not in (3,4)          -- status kh\00F4ng ph\1EA3i l\00E0 approved v\00E0 rejected'),
unistr('            and er.next_step > 1            -- \0111\1EC3 lo\1EA1i tr\01B0\1EDDng h\1EE3p m\1EDBi t\1EA1o v\00E0 next_step = 1'),
unistr('            and :APP_EMP_CODE <> (select line_manager from EMP_REQUESTS where REQUEST_DETAIL_ID = :P20004_REQUEST_ID); -- v\00E0 user kh\00F4ng ph\1EA3i l\00E0 line manager'),
'',
'            if n_check > 0 then',
'                return true;',
'                else',
'                return false;',
'            end if;',
'    end if;',
'',
'end;'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'FUNCTION_BODY'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(22224074332535773)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(84527567361569494)
,p_button_name=>'T2_CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:20005:&SESSION.::&DEBUG.:20004::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(22228327133535789)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(84531880122597701)
,p_button_name=>'T3_CANCEL'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:20005:&SESSION.::&DEBUG.:20004::'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(22209958772535752)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(56375911958622915)
,p_button_name=>'Reject'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reject'
,p_button_position=>'CHANGE'
,p_button_condition=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    n_check number;',
'    n_check_seq number;',
'    n_check_line_man number;',
'begin',
'    select count(id) ',
'    into n_check_seq ',
'    from EMP_REQUESTS er ',
'    where next_step = 1 ',
'        and er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID;',
'',
'    if n_check_seq > 0 then',
'        select count(id) ',
'        into n_check_line_man ',
'        from EMP_REQUESTS er ',
'        where next_step = 1 ',
'            and er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID ',
'            and er.line_manager = :APP_EMP_CODE ;',
'    ',
'        if n_check_line_man > 0 then',
'            return true;',
'        else',
'            return false;',
'        end if;',
'    else',
'        select count(er.id) ',
'        into n_check ',
'        from EMP_REQUESTS er',
'            join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'            join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP',
'        where er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID ',
'            and er.NEXT_STEP = wa.WA_SEQUENCE_NUMBER',
'            and emp.EMPLOYEE_CODE = :APP_EMP_CODE ',
'            and er.STATUS not in (3,4) ',
'            and er.next_step > 1 ',
'            and :APP_EMP_CODE <> (select line_manager from EMP_REQUESTS where REQUEST_DETAIL_ID = :P20004_REQUEST_ID);',
'',
'        if n_check > 0 then',
'            return true;',
'        else',
'            return false;',
'        end if;',
'    end if;',
'',
'end;'))
,p_button_condition2=>'PLSQL'
,p_button_condition_type=>'FUNCTION_BODY'
);
end;
/
begin
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(22210349676535752)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(56375911958622915)
,p_button_name=>'Cancel'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_image_alt=>'Cancel'
,p_button_position=>'CHANGE'
,p_button_redirect_url=>'f?p=&APP_ID.:20005:&SESSION.::&DEBUG.:20004::'
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(22281001185535858)
,p_branch_name=>'redirect to page 25_approve'
,p_branch_action=>'f?p=&APP_ID.:20005:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(22210773679535753)
,p_branch_sequence=>10
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(22282674147535859)
,p_branch_name=>'redirect to page 25_reject'
,p_branch_action=>'f?p=&APP_ID.:20005:&SESSION.::&DEBUG.:::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(22209958772535752)
,p_branch_sequence=>20
);
wwv_flow_imp_page.create_page_branch(
 p_id=>wwv_flow_imp.id(22282275938535859)
,p_branch_name=>'redirect to page 25_cancel'
,p_branch_action=>'f?p=&APP_ID.:20005:&SESSION.::&DEBUG.:20004::&success_msg=#SUCCESS_MSG#'
,p_branch_point=>'AFTER_PROCESSING'
,p_branch_type=>'REDIRECT_URL'
,p_branch_when_button_id=>wwv_flow_imp.id(22210349676535752)
,p_branch_sequence=>50
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25096164021455618)
,p_name=>'P20004_DEFAULT_IMAGES_NAME'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select ATTACH_NAME into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25096227561455619)
,p_name=>'P20004_DEFAULT_IMAGES_URL'
,p_item_sequence=>160
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select ATTACH_FILE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25680597557522668)
,p_name=>'P20004_ATTACHMENT'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_pre_element_text=>'Attachment'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_tag_css_classes=>'apex_disabled'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_icon_css_classes=>'fa-arrow-up-alt'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'Y'
,p_attribute_12=>'INLINE'
,p_attribute_13=>'Upload File'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25839076369867508)
,p_name=>'P20004_STATUS'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'Y'
,p_item_comment=>unistr('d\00F9ng \0111\1EC3 l\01B0u ''status'' c\1EE7a request v\00E0 s\1EED d\1EE5ng n\00F3 l\00E0m \0111i\1EC1u ki\1EC7n')
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56384625296622992)
,p_name=>'P20004_SCHOLARSHIP_RECIPIENT'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56375911958622915)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    temp nvarchar2(1000);',
'begin',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_TYPE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       return temp;',
'    ELSE',
'      RETURN null;',
'    END IF;',
'end;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Scholarship recipient'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'SCHOLARSHIP_RECIPIENT'
,p_lov=>'.'||wwv_flow_imp.id(13149840134168038)||'.'
,p_cSize=>30
,p_colspan=>5
,p_grid_column_css_classes=>'P20004_SCHOLARSHIP_RECIPIENT'
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
 p_id=>wwv_flow_imp.id(56384765617622993)
,p_name=>'P20004_PROGRAM'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(56375911958622915)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    temp nvarchar2(1000);',
'begin',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select PROGRAM into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       return temp;',
'    ELSE',
'       RETURN null;',
'    END IF;',
'end;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Program'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'COREEDU_PROGRAM'
,p_lov=>'.'||wwv_flow_imp.id(13812202134933262)||'.'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_grid_column_css_classes=>'P20004_PROGRAM'
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
 p_id=>wwv_flow_imp.id(56386932321622999)
,p_name=>'P20004_REQUEST_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56376537983622921)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select emp.EMPLOYEE_CODE into temp ',
'       from EMPLOYEES emp ',
'       join SCHOLARSHIP_REQUEST sr ',
'       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE ',
'       where sr.ID = :P20004_REQUEST_ID;',
'       ',
'       --select EMPLOYEE_CODE into temp from EMPLOYEES where USER_NAME = :APP_USER_NAME;',
'       RETURN temp;',
'    ELSE',
'       RETURN NULL;',
'    END IF;',
'END;',
'',
''))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Requester name'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'select FULL_NAME || '' - '' || EMPLOYEE_CODE, EMPLOYEE_CODE as ID from EMPLOYEES'
,p_cSize=>30
,p_colspan=>4
,p_grid_column=>1
,p_grid_column_css_classes=>'P20004_REQUEST_NAME'
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
 p_id=>wwv_flow_imp.id(56387086678623000)
,p_name=>'P20004_EMPLOYEE_CODE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(56376537983622921)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select REQUESTER_CODE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'    --    select :APP_EMP_CODE into temp from DUAL;',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Employee code'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_column=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56387125562623001)
,p_name=>'P20004_DEPARTMENT'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(56376537983622921)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select REQUESTER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'    --    SELECT DEPARTMENT_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Department'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'select DISTINCT DEPARTMENT_NAME from EMPLOYEES;'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_column=>9
,p_grid_column_css_classes=>'P20004_DEPARTMENT'
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
 p_id=>wwv_flow_imp.id(56387292223623002)
,p_name=>'P20004_LEVEL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(56376537983622921)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select LEVEL_DESCRIPTION from EMPLOYEES where USER_NAME = :APP_USER_NAME;',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'    --    SELECT LEVEL_DESCRIPTION INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Level'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56387389342623003)
,p_name=>'P20004_START_DATE'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(56376537983622921)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select START_DATE from EMPLOYEES where USER_NAME = :APP_USER_NAME;',
'',
'DECLARE',
'    temp DATE;',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       select emp.START_DATE into temp ',
'       from EMPLOYEES emp ',
'       join SCHOLARSHIP_REQUEST sr ',
'       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE ',
'       where sr.ID = :P20004_REQUEST_ID;',
'',
'       RETURN temp;',
'    ELSE',
'    --    SELECT START_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'       ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;',
'',
''))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Start date'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(56387462032623004)
,p_name=>'P20004_TERMINATION_DATE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(56376537983622921)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select TERMINATE_DATE from employees where USER_NAME = :APP_USER_NAME;',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       select emp.TERMINATE_DATE into temp ',
'       from EMPLOYEES emp ',
'       join SCHOLARSHIP_REQUEST sr ',
'       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE ',
'       where sr.ID = :P20004_REQUEST_ID;',
'',
'       RETURN temp;',
'    ELSE',
'    --    SELECT TERMINATE_DATE INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'       ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;',
'',
''))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Termination date'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(56393395386623014)
,p_name=>'P20004_PARTNER_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56377187868622928)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_NAME into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Partner name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56393460297623015)
,p_name=>'P20004_TITLE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(56377187868622928)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_TITLE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Title'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56393554611623016)
,p_name=>'P20004_PARTNER_PHONE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56377187868622928)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_PHONE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Phone'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEL'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56393629513623017)
,p_name=>'P20004_PARTNER_DEPARTMENT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(56377187868622928)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_DEPARTMENT into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Department'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'SHOLARSHIP_PARTNER_DEPARTMENT'
,p_lov=>'.'||wwv_flow_imp.id(14998911392347814)||'.'
,p_cSize=>30
,p_colspan=>4
,p_grid_column_css_classes=>'P20004_PARTNER_DEPARTMENT'
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
 p_id=>wwv_flow_imp.id(56393725590623018)
,p_name=>'P20004_FIELD'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(56377187868622928)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_FIELD into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Field'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'SCHOLARSHIP_PARTNER_FIELD'
,p_lov=>'.'||wwv_flow_imp.id(15001826986365695)||'.'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_grid_column_css_classes=>'P20004_FIELD'
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
 p_id=>wwv_flow_imp.id(56398289259623025)
,p_name=>'P20004_DISCOUNT_RATE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56377310389622929)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp number;',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select DISCOUNT_RATE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Discount rate'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov_language=>'PLSQL'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    t_sql nvarchar2(10000);',
'begin',
'    t_sql := ''SELECT',
'                ''''voucher '''' || DISCOUNT_RATE || ''''%'''' AS DISPLAY_VALUE,',
'                DISCOUNT_RATE AS RETURN_VALUE',
'              FROM',
'                COREEDU_PROMOTION',
'              WHERE',
'                PROGRAM = :P20004_PROGRAM',
'              ORDER BY',
'                DISCOUNT_RATE DESC'';',
'    return t_sql;',
'end;'))
,p_lov_cascade_parent_items=>'P20004_PROGRAM'
,p_ajax_items_to_submit=>'P20004_PROGRAM'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_colspan=>4
,p_grid_column_css_classes=>'P20004_DISCOUNT_RATE'
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
 p_id=>wwv_flow_imp.id(56398367984623026)
,p_name=>'P20004_VOUCHER_CODE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(56377310389622929)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select VOUCHER_CODE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Voucher code'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56398450435623027)
,p_name=>'P20004_NUMBER_OF_COURSES'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(56377310389622929)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp NVARCHAR2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select NUMBER_OF_COURSES into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Number of courses'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56398558678623028)
,p_name=>'P20004_EFFECTIVE_DATE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(56377310389622929)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp DATE;',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select EFFECTIVE_DATE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Effective date'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
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
 p_id=>wwv_flow_imp.id(56398669035623029)
,p_name=>'P20004_EXPIRATION_DATE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(56377310389622929)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp DATE;',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select EXPIRATION_DATE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Expiration date'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'ITEM'
,p_attribute_05=>'P20004_EFFECTIVE_DATE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56398738491623030)
,p_name=>'P20004_APPROVED_DATE'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(56377310389622929)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp DATE;',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select APPROVED_DATE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Approved date'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(56472786583153006)
,p_name=>'P20004_DEPARTMENT_CODE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(56376537983622921)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select REQUESTER_DEPARTMENT_CODE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'    --    SELECT DEPARTMENT_ID INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Department code'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_column=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56479946085153029)
,p_name=>'P20004_WORKPLACE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(56377187868622928)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select PARTNER_WORKPLACE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Work Place ',
'(State Agencies)'))
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56489205100153037)
,p_name=>'P20004_RECIPIENT_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select RECIPIENT_NAME from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = id;',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_NAME into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Full name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56489272317153038)
,p_name=>'P20004_RECIPIENT_DOB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp DATE;',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_DOB into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'DOB'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(56489359415153039)
,p_name=>'P20004_RECIPIENT_PHONE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_PHONE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Phone'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEL'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56489434636153040)
,p_name=>'P20004_RELATIONSHIP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_RELATIONSHIP into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Relationship with requester'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_named_lov=>'SCHOLARSHIP_RELATIONSHIP'
,p_lov=>'.'||wwv_flow_imp.id(14989626799293948)||'.'
,p_cSize=>30
,p_colspan=>4
,p_grid_column_css_classes=>'P20004_RELATIONSHIP'
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
 p_id=>wwv_flow_imp.id(56489539735153041)
,p_name=>'P20004_CAMPUS'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select RECIPIENT_CAMPUS from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = id;',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_CAMPUS into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Campus'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DISTINCT UNIT_NAME FROM DEPARTMENT_CAMPUS WHERE UNIT_TYPE LIKE ''Business unit'' AND UNIT_NUMBER <> ''00000401'';',
''))
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_column_css_classes=>'P20004_CAMPUS'
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
 p_id=>wwv_flow_imp.id(56489889662153044)
,p_name=>'P20004_REASON_REQUEST'
,p_item_sequence=>170
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_REASON_REQUEST into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Reason request'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>20000
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
end;
/
begin
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56490375655153049)
,p_name=>'P20004_NOTE'
,p_item_sequence=>180
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_NOTE into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Note'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>20000
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56490467622153050)
,p_name=>'P20004_REPLACEMENT'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- SELECT sr.RECIPIENT_NAME || '' - '' || sr.RECIPIENT_DOB, sr.VOUCHER_CODE as ID',
'-- FROM SCHOLARSHIP_REQUEST sr',
'-- WHERE sr.REQUESTER_CODE = :P20004_EMPLOYEE_CODE AND sr.RECIPIENT_RELATIONSHIP != 1;',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Replacement for',
'(if any)'))
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT RECIPIENT_NAME || '' - '' || RECIPIENT_DOB as DISPLAY_VALUE, VOUCHER_CODE as RETURN_VALUE',
'FROM SCHOLARSHIP_REQUEST',
'WHERE REQUESTER_CODE = :P20004_EMPLOYEE_CODE ',
'AND RECIPIENT_TYPE = ''B''',
'AND RECIPIENT_RELATIONSHIP != 1',
'AND STATUS != 7',
'AND ID != :P20004_REQUEST_ID;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'---------------'
,p_lov_cascade_parent_items=>'P20004_REQUEST_ID,P20004_EMPLOYEE_CODE'
,p_ajax_items_to_submit=>'P20004_REQUEST_ID,P20004_EMPLOYEE_CODE'
,p_ajax_optimize_refresh=>'Y'
,p_cSize=>30
,p_grid_column_css_classes=>'P20004_REPLACEMENT'
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
 p_id=>wwv_flow_imp.id(56490584385153051)
,p_name=>'P20004_VOUCHER_CODE_REPLACEMENT'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_VOUCHER_CODE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Voucher code',
'(replacement)'))
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(56490665593153052)
,p_name=>'P20004_EXPIRATION_DATE_REPLACEMENT'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp date;',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'       select RECIPIENT_EXPIRATION_DATE_REPLACEMENT into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Expiration date',
'(replacement)'))
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(58554032331468540)
,p_name=>'P20004_URL_FILES'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(58554215163468541)
,p_name=>'P20004_NAME_FILES'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(56463374642152939)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(58866355611073632)
,p_name=>'P20004_REQUEST_NAME_AB'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(56376537983622921)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'--select FULL_NAME from EMPLOYEES where USER_NAME = :APP_USER_NAME',
'',
'DECLARE',
'    temp nvarchar2(1000);',
'BEGIN',
'    IF :P20004_REQUEST_ID IS NOT NULL THEN',
'    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20004_REQUEST_ID = ID;',
'       select emp.FULL_NAME into temp ',
'       from EMPLOYEES emp ',
'       join SCHOLARSHIP_REQUEST sr ',
'       on emp.EMPLOYEE_CODE = sr.REQUESTER_CODE ',
'       where sr.ID = :P20004_REQUEST_ID;',
'',
'       RETURN temp;',
'    ELSE',
'    --    SELECT FULL_NAME INTO temp FROM EMPLOYEES WHERE :APP_USER_NAME = USER_NAME; ',
'       ',
'    --    RETURN temp;',
'       RETURN NULL;',
'    END IF;',
'END;',
'',
''))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Requester name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_grid_column=>1
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(59060940730526818)
,p_name=>'P20004_FEATURE_APPLY'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(55899866389408264)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(61753093352875503)
,p_name=>'P20004_REQUEST_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(55899866389408264)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(63064555473969803)
,p_name=>'P20004_LINE_MANAGER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(55899866389408264)
,p_item_default=>'SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE '
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(63064652254969804)
,p_name=>'P20004_SCHOLARSHIP_DETAIL'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(55899866389408264)
,p_item_default=>'select SCHOLARSHIP_DETAIL_ID.nextval from dual'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(64218224100562817)
,p_name=>'P20004_FEATURE'
,p_item_sequence=>10
,p_item_default=>'Scholarship'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22231601787535794)
,p_validation_name=>'btn_save_submit_check_P20004_SCHOLARSHIP_RECIPIENT'
,p_validation_sequence=>10
,p_validation=>'P20004_SCHOLARSHIP_RECIPIENT'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please select a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22210773679535753)
,p_associated_item=>wwv_flow_imp.id(56384625296622992)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22232004785535795)
,p_validation_name=>'btn_save_submit_check_P20004_PROGRAM'
,p_validation_sequence=>20
,p_validation=>'P20004_PROGRAM'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please select a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22210773679535753)
,p_associated_item=>wwv_flow_imp.id(56384765617622993)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22232838223535795)
,p_validation_name=>'btn_save_submit_check_P20004_RECIPIENT_NAME'
,p_validation_sequence=>30
,p_validation=>'P20004_RECIPIENT_NAME'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22210773679535753)
,p_associated_item=>wwv_flow_imp.id(56489205100153037)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22233259139535796)
,p_validation_name=>'btn_save_submit_check_P20004_RECIPIENT_DOB'
,p_validation_sequence=>40
,p_validation=>'P20004_RECIPIENT_DOB'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22210773679535753)
,p_associated_item=>wwv_flow_imp.id(56489272317153038)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22232406923535795)
,p_validation_name=>'btn_save_submit_check_P20004_RECIPIENT_PHONE'
,p_validation_sequence=>50
,p_validation=>'P20004_RECIPIENT_PHONE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22210773679535753)
,p_associated_item=>wwv_flow_imp.id(56489359415153039)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22239686425535801)
,p_validation_name=>'btn_save_submit_check_P20004_RELATIONSHIP'
,p_validation_sequence=>60
,p_validation=>'P20004_RELATIONSHIP'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22210773679535753)
,p_associated_item=>wwv_flow_imp.id(56489434636153040)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22233677563535796)
,p_validation_name=>'btn_save_submit_check_P20004_PARTNER_NAME'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20004_SCHOLARSHIP_RECIPIENT = ''C'' or :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20004_PARTNER_NAME IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''PARTNER_NAME'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''PARTNER_NAME'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22210773679535753)
,p_associated_item=>wwv_flow_imp.id(56393395386623014)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22234074063535797)
,p_validation_name=>'btn_save_submit_check_P20004_PARTNER_PHONE'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20004_SCHOLARSHIP_RECIPIENT = ''C'' or :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20004_PARTNER_PHONE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''PARTNER_PHONE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''PARTNER_PHONE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22210773679535753)
,p_associated_item=>wwv_flow_imp.id(56393554611623016)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22234418393535797)
,p_validation_name=>'btn_save_submit_check_P20004_WORKPLACE'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20004_SCHOLARSHIP_RECIPIENT = ''C'' or :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20004_WORKPLACE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''WORKPLACE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''WORKPLACE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22210773679535753)
,p_associated_item=>wwv_flow_imp.id(56479946085153029)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22234890937535797)
,p_validation_name=>'btn_save_submit_check_P20004_DISCOUNT_RATE'
,p_validation_sequence=>100
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20004_SCHOLARSHIP_RECIPIENT = ''C'' or :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20004_DISCOUNT_RATE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''DISCOUNT_RATE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''DISCOUNT_RATE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22210773679535753)
,p_associated_item=>wwv_flow_imp.id(56398289259623025)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22235233989535798)
,p_validation_name=>'btn_save_submit_check_P20004_EXPIRATION_DATE'
,p_validation_sequence=>110
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20004_SCHOLARSHIP_RECIPIENT = ''C'' or :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20004_EXPIRATION_DATE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''EXPIRATION_DATE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''EXPIRATION_DATE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22210773679535753)
,p_associated_item=>wwv_flow_imp.id(56398669035623029)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22235634839535798)
,p_validation_name=>'btn_save_check_P20004_SCHOLARSHIP_RECIPIENT'
,p_validation_sequence=>120
,p_validation=>'P20004_SCHOLARSHIP_RECIPIENT'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please select a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22209958772535752)
,p_associated_item=>wwv_flow_imp.id(56384625296622992)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22236042324535798)
,p_validation_name=>'btn_save_check_P20004_PROGRAM'
,p_validation_sequence=>130
,p_validation=>'P20004_PROGRAM'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please select a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22209958772535752)
,p_associated_item=>wwv_flow_imp.id(56384765617622993)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22236450469535799)
,p_validation_name=>'btn_save_check_P20004_RECIPIENT_NAME'
,p_validation_sequence=>140
,p_validation=>'P20004_RECIPIENT_NAME'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22209958772535752)
,p_associated_item=>wwv_flow_imp.id(56489205100153037)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22236822572535799)
,p_validation_name=>'btn_save_check_P20004_RECIPIENT_DOB'
,p_validation_sequence=>150
,p_validation=>'P20004_RECIPIENT_DOB'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22209958772535752)
,p_associated_item=>wwv_flow_imp.id(56489272317153038)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22237216408535799)
,p_validation_name=>'btn_save_check_P20004_RECIPIENT_PHONE'
,p_validation_sequence=>160
,p_validation=>'P20004_RECIPIENT_PHONE'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22209958772535752)
,p_associated_item=>wwv_flow_imp.id(56489359415153039)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22240068322535801)
,p_validation_name=>'btn_save_check_P20004_RELATIONSHIP'
,p_validation_sequence=>170
,p_validation=>'P20004_RELATIONSHIP'
,p_validation_type=>'ITEM_NOT_NULL'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22209958772535752)
,p_associated_item=>wwv_flow_imp.id(56489434636153040)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22237647042535799)
,p_validation_name=>'btn_save_check_P20004_PARTNER_NAME'
,p_validation_sequence=>180
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20004_SCHOLARSHIP_RECIPIENT = ''C'' or :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20004_PARTNER_NAME IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''PARTNER_NAME'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''PARTNER_NAME'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22209958772535752)
,p_associated_item=>wwv_flow_imp.id(56393395386623014)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22238035901535800)
,p_validation_name=>'btn_save_check_P20004_PARTNER_PHONE'
,p_validation_sequence=>190
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20004_SCHOLARSHIP_RECIPIENT = ''C'' or :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20004_PARTNER_PHONE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''PARTNER_PHONE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''PARTNER_PHONE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22209958772535752)
,p_associated_item=>wwv_flow_imp.id(56393554611623016)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22238405359535800)
,p_validation_name=>'btn_save_check_P20004_WORKPLACE'
,p_validation_sequence=>200
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20004_SCHOLARSHIP_RECIPIENT = ''C'' or :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20004_WORKPLACE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''WORKPLACE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''WORKPLACE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22209958772535752)
,p_associated_item=>wwv_flow_imp.id(56479946085153029)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22238867226535800)
,p_validation_name=>'btn_save_check_P20004_DISCOUNT_RATE'
,p_validation_sequence=>210
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20004_SCHOLARSHIP_RECIPIENT = ''C'' or :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20004_DISCOUNT_RATE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''DISCOUNT_RATE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''DISCOUNT_RATE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22209958772535752)
,p_associated_item=>wwv_flow_imp.id(56398289259623025)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22239281658535801)
,p_validation_name=>'btn_save_check_P20004_EXPIRATION_DATE'
,p_validation_sequence=>220
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20004_SCHOLARSHIP_RECIPIENT = ''C'' or :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20004_EXPIRATION_DATE IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''EXPIRATION_DATE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''EXPIRATION_DATE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please fill a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>'disabled'
,p_validation_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_when_button_pressed=>wwv_flow_imp.id(22209958772535752)
,p_associated_item=>wwv_flow_imp.id(56398669035623029)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(22272634087535850)
,p_name=>'Set Read Only pk'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20004_REQUEST_ID'
,p_condition_element=>'P20004_REQUEST_ID'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
,p_display_when_type=>'REQUEST_EQUALS_CONDITION'
,p_display_when_cond=>'disable'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22274617898535852)
,p_event_id=>wwv_flow_imp.id(22272634087535850)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20004_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20004_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20004_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20004_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20004_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20004_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20004_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20004_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20004_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''.P20004_RELATIONSHIP'').addClass(''apex_disabled'');',
'$(''#P20004_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_VOUCHER_CODE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_PARTNER_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_PARTNER_PHONE'').addClass(''apex_disabled'');',
'$(''#P20004_TITLE'').addClass(''apex_disabled'');',
'$(''.P20004_PARTNER_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''.P20004_FIELD'').addClass(''apex_disabled'');',
'$(''#P20004_WORKPLACE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_RECIPIENT_PHONE'').addClass(''apex_disabled'');      ',
'$(''.P20004_CAMPUS'').addClass(''apex_disabled'');                     ',
'$(''#P20004_UPLOAD_FILE'').addClass(''apex_disabled'');',
'$(''#P20004_URL_FILES'').addClass(''apex_disabled'');',
'$(''#P20004_NAME_FILES'').addClass(''apex_disabled'');',
'$(''.P20004_REPLACEMENT'').addClass(''apex_disabled'');                ',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_REASON_REQUEST'').addClass(''apex_disabled'');             ',
'',
'// remove',
'$(''#P20004_NOTE'').removeClass(''apex_disabled'');                ',
'$(''.P20004_DISCOUNT_RATE'').removeClass(''apex_disabled'');           ',
'$(''#P20004_NUMBER_OF_COURSES'').removeClass(''apex_disabled'');',
'$(''#P20004_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE'').removeClass(''apex_disabled'');',
'',
'',
'',
'',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$v("P20004_SCHOLARSHIP_RECIPIENT") === "A"'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22273120365535851)
,p_event_id=>wwv_flow_imp.id(22272634087535850)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20004_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20004_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20004_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20004_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20004_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20004_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20004_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20004_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20004_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_PHONE'').addClass(''apex_disabled'');      ',
'$(''.P20004_RELATIONSHIP'').addClass(''apex_disabled'');             ',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_UPLOAD_FILE'').addClass(''apex_disabled'');',
'$(''#P20004_URL_FILES'').addClass(''apex_disabled'');',
'$(''#P20004_NAME_FILES'').addClass(''apex_disabled'');',
'$(''#P20004_REASON_REQUEST'').addClass(''apex_disabled'');             ',
'',
'$(''#P20004_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_VOUCHER_CODE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_PARTNER_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_PARTNER_PHONE'').addClass(''apex_disabled'');',
'$(''#P20004_TITLE'').addClass(''apex_disabled'');',
'$(''.P20004_PARTNER_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''.P20004_FIELD'').addClass(''apex_disabled'');',
'$(''#P20004_WORKPLACE'').addClass(''apex_disabled'');',
'',
'',
'// remove',
'$(''.P20004_CAMPUS'').removeClass(''apex_disabled'');',
'$(''.P20004_REPLACEMENT'').removeClass(''apex_disabled'');                ',
'$(''#P20004_NOTE'').removeClass(''apex_disabled'');                        ',
'$(''.P20004_DISCOUNT_RATE'').removeClass(''apex_disabled'');           ',
'$(''#P20004_NUMBER_OF_COURSES'').removeClass(''apex_disabled'');',
'$(''#P20004_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE'').removeClass(''apex_disabled'');',
'',
'',
'',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$v("P20004_SCHOLARSHIP_RECIPIENT") === "B"'
);
end;
/
begin
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22273603635535851)
,p_event_id=>wwv_flow_imp.id(22272634087535850)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20004_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20004_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20004_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20004_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20004_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20004_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20004_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20004_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20004_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_PHONE'').addClass(''apex_disabled'');      ',
'$(''.P20004_RELATIONSHIP'').addClass(''apex_disabled'');',
'$(''.P20004_REPLACEMENT'').addClass(''apex_disabled'');                ',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_NOTE'').addClass(''apex_disabled'');                ',
'$(''#P20004_UPLOAD_FILE'').addClass(''apex_disabled'');',
'$(''#P20004_URL_FILES'').addClass(''apex_disabled'');',
'$(''#P20004_NAME_FILES'').addClass(''apex_disabled'');',
'',
'$(''#P20004_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_VOUCHER_CODE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_PARTNER_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_PARTNER_PHONE'').addClass(''apex_disabled'');',
'$(''#P20004_TITLE'').addClass(''apex_disabled'');',
'$(''.P20004_PARTNER_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''.P20004_FIELD'').addClass(''apex_disabled'');',
'$(''#P20004_WORKPLACE'').addClass(''apex_disabled'');',
'',
'',
'// remove',
'$(''.P20004_CAMPUS'').removeClass(''apex_disabled'');                     ',
'$(''#P20004_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'$(''.P20004_DISCOUNT_RATE'').removeClass(''apex_disabled'');           ',
'$(''#P20004_NUMBER_OF_COURSES'').removeClass(''apex_disabled'');',
'$(''#P20004_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$v("P20004_SCHOLARSHIP_RECIPIENT") === "C"'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22274172782535852)
,p_event_id=>wwv_flow_imp.id(22272634087535850)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20004_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20004_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20004_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20004_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20004_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20004_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20004_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20004_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20004_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_PHONE'').addClass(''apex_disabled'');      ',
'$(''.P20004_RELATIONSHIP'').addClass(''apex_disabled'');',
'$(''.P20004_REPLACEMENT'').addClass(''apex_disabled'');                ',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_NOTE'').addClass(''apex_disabled'');                ',
'$(''#P20004_UPLOAD_FILE'').addClass(''apex_disabled'');',
'$(''#P20004_URL_FILES'').addClass(''apex_disabled'');',
'$(''#P20004_NAME_FILES'').addClass(''apex_disabled'');',
'',
'$(''#P20004_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_VOUCHER_CODE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_PARTNER_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_PARTNER_PHONE'').addClass(''apex_disabled'');',
'$(''#P20004_TITLE'').addClass(''apex_disabled'');',
'$(''.P20004_PARTNER_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''.P20004_FIELD'').addClass(''apex_disabled'');',
'$(''#P20004_WORKPLACE'').addClass(''apex_disabled'');',
'',
'',
'// remove',
'$(''.P20004_CAMPUS'').removeClass(''apex_disabled'');                     ',
'$(''#P20004_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'$(''.P20004_DISCOUNT_RATE'').removeClass(''apex_disabled'');           ',
'$(''#P20004_NUMBER_OF_COURSES'').removeClass(''apex_disabled'');',
'$(''#P20004_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$v("P20004_SCHOLARSHIP_RECIPIENT") === "D"'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(25838579254867503)
,p_name=>'Set Read Only for status'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20004_STATUS'
,p_condition_element=>'P20004_STATUS'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25838618986867504)
,p_event_id=>wwv_flow_imp.id(25838579254867503)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20004_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20004_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20004_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20004_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20004_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20004_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20004_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20004_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20004_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''.P20004_RELATIONSHIP'').addClass(''apex_disabled'');',
'$(''#P20004_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_VOUCHER_CODE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_PARTNER_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_PARTNER_PHONE'').addClass(''apex_disabled'');',
'$(''#P20004_TITLE'').addClass(''apex_disabled'');',
'$(''.P20004_PARTNER_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''.P20004_FIELD'').addClass(''apex_disabled'');',
'$(''#P20004_WORKPLACE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_RECIPIENT_PHONE'').addClass(''apex_disabled'');      ',
'$(''.P20004_CAMPUS'').addClass(''apex_disabled'');                     ',
'$(''#P20004_UPLOAD_FILE'').addClass(''apex_disabled'');',
'$(''#P20004_URL_FILES'').addClass(''apex_disabled'');',
'$(''#P20004_NAME_FILES'').addClass(''apex_disabled'');',
'$(''.P20004_REPLACEMENT'').addClass(''apex_disabled'');                ',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_REASON_REQUEST'').addClass(''apex_disabled'');             ',
'',
'// remove',
'$(''#P20004_NOTE'').removeClass(''apex_disabled'');                ',
'$(''.P20004_DISCOUNT_RATE'').removeClass(''apex_disabled'');           ',
'$(''#P20004_NUMBER_OF_COURSES'').removeClass(''apex_disabled'');',
'$(''#P20004_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE'').removeClass(''apex_disabled'');',
'',
'',
'',
'',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'($v("P20004_STATUS") == 2 || $v("P20004_STATUS") == 6) && $v("P20004_SCHOLARSHIP_RECIPIENT") === "A"',
'// && ($v("P20004_REQUEST_ID") !== null || $v("P20004_REQUEST_ID") !== "")'))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25838700972867505)
,p_event_id=>wwv_flow_imp.id(25838579254867503)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20004_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20004_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20004_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20004_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20004_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20004_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20004_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20004_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20004_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_PHONE'').addClass(''apex_disabled'');      ',
'$(''.P20004_RELATIONSHIP'').addClass(''apex_disabled'');             ',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_UPLOAD_FILE'').addClass(''apex_disabled'');',
'$(''#P20004_URL_FILES'').addClass(''apex_disabled'');',
'$(''#P20004_NAME_FILES'').addClass(''apex_disabled'');',
'$(''#P20004_REASON_REQUEST'').addClass(''apex_disabled'');             ',
'',
'$(''#P20004_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_VOUCHER_CODE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_PARTNER_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_PARTNER_PHONE'').addClass(''apex_disabled'');',
'$(''#P20004_TITLE'').addClass(''apex_disabled'');',
'$(''.P20004_PARTNER_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''.P20004_FIELD'').addClass(''apex_disabled'');',
'$(''#P20004_WORKPLACE'').addClass(''apex_disabled'');',
'',
'',
'// remove',
'$(''.P20004_CAMPUS'').removeClass(''apex_disabled'');',
'$(''.P20004_REPLACEMENT'').removeClass(''apex_disabled'');                ',
'$(''#P20004_NOTE'').removeClass(''apex_disabled'');                        ',
'$(''.P20004_DISCOUNT_RATE'').removeClass(''apex_disabled'');           ',
'$(''#P20004_NUMBER_OF_COURSES'').removeClass(''apex_disabled'');',
'$(''#P20004_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE'').removeClass(''apex_disabled'');',
'',
'',
'',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'($v("P20004_STATUS") == 2 || $v("P20004_STATUS") == 6) && $v("P20004_SCHOLARSHIP_RECIPIENT") === "B"',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25838808089867506)
,p_event_id=>wwv_flow_imp.id(25838579254867503)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20004_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20004_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20004_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20004_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20004_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20004_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20004_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20004_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20004_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_PHONE'').addClass(''apex_disabled'');      ',
'$(''.P20004_RELATIONSHIP'').addClass(''apex_disabled'');',
'$(''.P20004_REPLACEMENT'').addClass(''apex_disabled'');                ',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_NOTE'').addClass(''apex_disabled'');                ',
'$(''#P20004_UPLOAD_FILE'').addClass(''apex_disabled'');',
'$(''#P20004_URL_FILES'').addClass(''apex_disabled'');',
'$(''#P20004_NAME_FILES'').addClass(''apex_disabled'');',
'',
'$(''#P20004_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_VOUCHER_CODE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_PARTNER_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_PARTNER_PHONE'').addClass(''apex_disabled'');',
'$(''#P20004_TITLE'').addClass(''apex_disabled'');',
'$(''.P20004_PARTNER_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''.P20004_FIELD'').addClass(''apex_disabled'');',
'$(''#P20004_WORKPLACE'').addClass(''apex_disabled'');',
'',
'',
'// remove',
'$(''.P20004_CAMPUS'').removeClass(''apex_disabled'');                     ',
'$(''#P20004_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'$(''.P20004_DISCOUNT_RATE'').removeClass(''apex_disabled'');           ',
'$(''#P20004_NUMBER_OF_COURSES'').removeClass(''apex_disabled'');',
'$(''#P20004_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'($v("P20004_STATUS") == 2 || $v("P20004_STATUS") == 6) && $v("P20004_SCHOLARSHIP_RECIPIENT") === "C"',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25838964232867507)
,p_event_id=>wwv_flow_imp.id(25838579254867503)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20004_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20004_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20004_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20004_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20004_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20004_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20004_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20004_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20004_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_PHONE'').addClass(''apex_disabled'');      ',
'$(''.P20004_RELATIONSHIP'').addClass(''apex_disabled'');',
'$(''.P20004_REPLACEMENT'').addClass(''apex_disabled'');                ',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_NOTE'').addClass(''apex_disabled'');                ',
'$(''#P20004_UPLOAD_FILE'').addClass(''apex_disabled'');',
'$(''#P20004_URL_FILES'').addClass(''apex_disabled'');',
'$(''#P20004_NAME_FILES'').addClass(''apex_disabled'');',
'',
'$(''#P20004_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_VOUCHER_CODE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_PARTNER_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_PARTNER_PHONE'').addClass(''apex_disabled'');',
'$(''#P20004_TITLE'').addClass(''apex_disabled'');',
'$(''.P20004_PARTNER_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''.P20004_FIELD'').addClass(''apex_disabled'');',
'$(''#P20004_WORKPLACE'').addClass(''apex_disabled'');',
'',
'',
'// remove',
'$(''.P20004_CAMPUS'').removeClass(''apex_disabled'');                     ',
'$(''#P20004_REASON_REQUEST'').removeClass(''apex_disabled'');             ',
'$(''.P20004_DISCOUNT_RATE'').removeClass(''apex_disabled'');           ',
'$(''#P20004_NUMBER_OF_COURSES'').removeClass(''apex_disabled'');',
'$(''#P20004_EFFECTIVE_DATE'').removeClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE'').removeClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'($v("P20004_STATUS") == 2 || $v("P20004_STATUS") == 6) && $v("P20004_SCHOLARSHIP_RECIPIENT") === "D"',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25839172323867509)
,p_event_id=>wwv_flow_imp.id(25838579254867503)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_name=>'Set Read Only'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// add',
'$(''.P20004_SCHOLARSHIP_RECIPIENT'').addClass(''apex_disabled'');      ',
'$(''.P20004_PROGRAM'').addClass(''apex_disabled'');                    ',
'',
'$(''.P20004_REQUEST_NAME'').addClass(''apex_disabled'');            ',
'$(''#P20004_REQUEST_NAME_AB'').addClass(''apex_disabled'');',
'$(''#P20004_EMPLOYEE_CODE'').addClass(''apex_disabled'');',
'$(''#P20004_DEPARTMENT_CODE'').addClass(''apex_disabled'');',
'$(''.P20004_DEPARTMENT'').addClass(''apex_disabled'');              ',
'$(''#P20004_LEVEL'').addClass(''apex_disabled'');',
'$(''#P20004_START_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_TERMINATION_DATE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_RECIPIENT_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_DOB'').addClass(''apex_disabled'');',
'$(''#P20004_RECIPIENT_PHONE'').addClass(''apex_disabled'');      ',
'$(''.P20004_RELATIONSHIP'').addClass(''apex_disabled'');',
'$(''.P20004_REPLACEMENT'').addClass(''apex_disabled'');                ',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT'').addClass(''apex_disabled'');',
'$(''#P20004_NOTE'').addClass(''apex_disabled'');                ',
'$(''#P20004_UPLOAD_FILE'').addClass(''apex_disabled'');',
'$(''#P20004_URL_FILES'').addClass(''apex_disabled'');',
'$(''#P20004_NAME_FILES'').addClass(''apex_disabled'');',
'',
'$(''#P20004_APPROVED_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_VOUCHER_CODE'').addClass(''apex_disabled'');',
'',
'$(''#P20004_PARTNER_NAME'').addClass(''apex_disabled'');',
'$(''#P20004_PARTNER_PHONE'').addClass(''apex_disabled'');',
'$(''#P20004_TITLE'').addClass(''apex_disabled'');',
'$(''.P20004_PARTNER_DEPARTMENT'').addClass(''apex_disabled'');',
'$(''.P20004_FIELD'').addClass(''apex_disabled'');',
'$(''#P20004_WORKPLACE'').addClass(''apex_disabled'');',
'',
'',
'$(''.P20004_CAMPUS'').addClass(''apex_disabled'');                     ',
'$(''#P20004_REASON_REQUEST'').addClass(''apex_disabled'');             ',
'$(''.P20004_DISCOUNT_RATE'').addClass(''apex_disabled'');           ',
'$(''#P20004_NUMBER_OF_COURSES'').addClass(''apex_disabled'');',
'$(''#P20004_EFFECTIVE_DATE'').addClass(''apex_disabled'');',
'$(''#P20004_EXPIRATION_DATE'').addClass(''apex_disabled'');'))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'($v("P20004_STATUS") != 2 && $v("P20004_STATUS") != 6)',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(22254620295535835)
,p_name=>'Change_A'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20004_SCHOLARSHIP_RECIPIENT'
,p_condition_element=>'P20004_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'A'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22255150939535835)
,p_event_id=>wwv_flow_imp.id(22254620295535835)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'show_hide_A'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// show',
'$(''#P20004_REQUEST_NAME_AB_CONTAINER'').show();',
'$(''#P20004_EMPLOYEE_CODE_CONTAINER'').show();',
'$(''#P20004_LEVEL_CONTAINER'').show();',
'$(''#P20004_START_DATE_CONTAINER'').show();',
'$(''#P20004_TERMINATION_DATE_CONTAINER'').show();',
'$(''#P20004_NOTE_CONTAINER'').show();',
'',
'// hide',
'$(''#P20004_REQUEST_NAME_CONTAINER'').hide();',
'$(''#P20004_DEPARTMENT_CODE_CONTAINER'').hide();',
'$(''.region_partner'').hide();',
'$(''#P20004_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20004_REASON_REQUEST_CONTAINER'').hide();',
'$(''#P20004_ATTACHMENT_CONTAINER'').hide();',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(22257950632535837)
,p_name=>'Change_B'
,p_event_sequence=>40
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20004_SCHOLARSHIP_RECIPIENT'
,p_condition_element=>'P20004_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'B'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22258426140535838)
,p_event_id=>wwv_flow_imp.id(22257950632535837)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'show_hide_B'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// show',
'$(''#P20004_REQUEST_NAME_AB_CONTAINER'').show();',
'//$(''#P20004_REQUESTER_CODE_CONTAINER'').show();',
'$(''#P20004_EMPLOYEE_CODE_CONTAINER'').show();',
'$(''#P20004_LEVEL_CONTAINER'').show();',
'$(''#P20004_START_DATE_CONTAINER'').show();',
'$(''#P20004_TERMINATION_DATE_CONTAINER'').show();',
'$(''#P20004_ATTACHMENT_CONTAINER'').show();',
'$(''#P20004_REPLACEMENT_CONTAINER'').show();',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT_CONTAINER'').show();',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT_CONTAINER'').show();',
'$(''#P20004_NOTE_CONTAINER'').show();',
'',
'// hide',
'$(''#P20004_REQUEST_NAME_CONTAINER'').hide();',
'$(''#P20004_DEPARTMENT_CODE_CONTAINER'').hide();',
'$(''.region_partner'').hide();',
'$(''#P20004_REASON_REQUEST_CONTAINER'').hide();'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(22253256088535833)
,p_name=>'Change_C'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20004_SCHOLARSHIP_RECIPIENT'
,p_condition_element=>'P20004_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'C'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22254203985535834)
,p_event_id=>wwv_flow_imp.id(22253256088535833)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'show_hide_C'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// show',
'$(''#P20004_REQUEST_NAME_CONTAINER'').show();',
'$(''#P20004_DEPARTMENT_CODE_CONTAINER'').show();',
'$(''.region_partner'').show();',
'$(''#P20004_ATTACHMENT_CONTAINER'').show();',
'$(''#P20004_REASON_REQUEST_CONTAINER'').show();',
'',
'// hide',
'$(''#P20004_REQUEST_NAME_AB_CONTAINER'').hide();',
'$(''#P20004_EMPLOYEE_CODE_CONTAINER'').hide();',
'$(''#P20004_LEVEL_CONTAINER'').hide();',
'$(''#P20004_START_DATE_CONTAINER'').hide();',
'//$(''#P20004_START_DATE_CONTAINER'').show();',
'$(''#P20004_TERMINATION_DATE_CONTAINER'').hide();',
'$(''#P20004_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20004_NOTE_CONTAINER'').hide();',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(22251844064535832)
,p_name=>'Change_D'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20004_SCHOLARSHIP_RECIPIENT'
,p_condition_element=>'P20004_SCHOLARSHIP_RECIPIENT'
,p_triggering_condition_type=>'EQUALS'
,p_triggering_expression=>'D'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22252818414535833)
,p_event_id=>wwv_flow_imp.id(22251844064535832)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'show_hide_D'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// show',
'$(''#P20004_REQUEST_NAME_CONTAINER'').show();',
'$(''#P20004_DEPARTMENT_CODE_CONTAINER'').show();',
'$(''.region_partner'').show();',
'$(''#P20004_ATTACHMENT_CONTAINER'').show();',
'$(''#P20004_REASON_REQUEST_CONTAINER'').show();',
'',
'// hide',
'$(''#P20004_REQUEST_NAME_AB_CONTAINER'').hide();',
'$(''#P20004_EMPLOYEE_CODE_CONTAINER'').hide();',
'$(''#P20004_LEVEL_CONTAINER'').hide();',
'$(''#P20004_START_DATE_CONTAINER'').hide();',
'$(''#P20004_TERMINATION_DATE_CONTAINER'').hide();',
'$(''#P20004_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20004_VOUCHER_CODE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20004_EXPIRATION_DATE_REPLACEMENT_CONTAINER'').hide();',
'$(''#P20004_NOTE_CONTAINER'').hide();',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(22262182907535841)
,p_name=>'change_value_of_replacement'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20004_REPLACEMENT'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'$v("P20004_REPLACEMENT") !== null'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22263215023535843)
,p_event_id=>wwv_flow_imp.id(22262182907535841)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'set_value_for_voucher_code_replacement'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20004_VOUCHER_CODE_REPLACEMENT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select VOUCHER_CODE',
'from SCHOLARSHIP_REQUEST',
'where VOUCHER_CODE = :P20004_REPLACEMENT;'))
,p_attribute_07=>'P20004_REPLACEMENT'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22262709004535842)
,p_event_id=>wwv_flow_imp.id(22262182907535841)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'set_value_for_expiration_date_replacement'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20004_EXPIRATION_DATE_REPLACEMENT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select EXPIRATION_DATE',
'from SCHOLARSHIP_REQUEST',
'where VOUCHER_CODE = :P20004_REPLACEMENT;'))
,p_attribute_07=>'P20004_REPLACEMENT'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(22279149375535855)
,p_name=>'set_value_of_voucher_code'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20004_EFFECTIVE_DATE,P20004_EXPIRATION_DATE,P20004_DISCOUNT_RATE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22279684440535857)
,p_event_id=>wwv_flow_imp.id(22279149375535855)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20004_VOUCHER_CODE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    x1 nvarchar2(100);',
'    x2 nvarchar2(100);',
'    x3 nvarchar2(100);',
'begin',
'    if :P20004_EFFECTIVE_DATE is not null then',
'        select to_char(to_date(:P20004_EFFECTIVE_DATE, ''MM/DD/YYYY''), ''YY'') ||',
'            coalesce(to_char(to_date(:P20004_EXPIRATION_DATE, ''MM/DD/YYYY''), ''MM''), ''00'')',
'        into x1',
'        from dual;',
'    end if;',
'',
'    -- if :P20004_SCHOLARSHIP_RECIPIENT is not null then',
'    --     select :P20004_SCHOLARSHIP_RECIPIENT || :P20004_DISCOUNT_RATE',
'    --     into x2',
'    --     from dual;',
'    -- end if;',
'',
'    if :P20004_DISCOUNT_RATE < 100 then',
'        select to_char(:P20004_DISCOUNT_RATE, ''000'') ',
'        into x2 ',
'        from dual;',
'    else',
'        select :P20004_DISCOUNT_RATE ',
'        into x2 ',
'        from dual;',
'    end if;',
'',
'    if :P20004_SCHOLARSHIP_RECIPIENT is not null then',
'        select replace(:P20004_SCHOLARSHIP_RECIPIENT || x2, '' '', '''')',
'        into x2',
'        from dual;',
'    end if;',
'',
'    -- if :P20004_PROGRAM is not null then',
'    --     select :P20004_PROGRAM',
'    --     into x3',
'    --     from dual;',
'    -- end if;',
'',
'    -- if :P20004_SCHOLARSHIP_RECIPIENT like ''A'' or :P20004_SCHOLARSHIP_RECIPIENT like ''B'' then',
'    --     select :P20004_EMPLOYEE_CODE',
'    --     into x4',
'    --     from dual;',
'    -- else',
'    --     if :P20004_SCHOLARSHIP_RECIPIENT like ''C'' or :P20004_SCHOLARSHIP_RECIPIENT like ''D'' then',
'    --         select :P20004_DEPARTMENT_CODE',
'    --         into x4',
'    --         from dual;',
'    --     end if;',
'    -- end if;',
'',
'    -- if :P20004_SCHOLARSHIP_RECIPIENT like ''A'' or :P20004_SCHOLARSHIP_RECIPIENT like ''B'' then',
'    --     select LTRIM(TO_CHAR(COUNT(REQUESTER_CODE) + 1, ''000'')) ',
'    --     into x5',
'    --     from SCHOLARSHIP_REQUEST ',
'    --     where REQUESTER_CODE = :P20004_EMPLOYEE_CODE;',
'    -- else',
'    --     if :P20004_SCHOLARSHIP_RECIPIENT like ''C'' or :P20004_SCHOLARSHIP_RECIPIENT like ''D'' then',
'    --         select  LTRIM(TO_CHAR(COUNT(REQUESTER_DEPARTMENT_CODE) + 1,''000''))',
'    --         into x5 ',
'    --         from SCHOLARSHIP_REQUEST ',
'    --         where REQUESTER_DEPARTMENT_CODE = :P20004_DEPARTMENT_CODE;',
'    --     end if;',
'    -- end if;',
'',
'    SELECT SUBSTR(your_string, ',
'              CASE ',
'                WHEN INSTR(your_string, ''ELT'') > 0 THEN INSTR(your_string, ''ELT'')',
'                WHEN INSTR(your_string, ''EP'') > 0 THEN INSTR(your_string, ''EP'')',
'                --ELSE 0 ',
'              END',
'             )',
'    INTO  x3',
'    FROM (SELECT :P20004_VOUCHER_CODE AS your_string FROM dual);',
'',
'    return x1 || ''-'' || x2 || ''-'' || x3;',
'end;'))
,p_attribute_07=>'P20004_EFFECTIVE_DATE,P20004_EXPIRATION_DATE,P20004_SCHOLARSHIP_RECIPIENT,P20004_DISCOUNT_RATE,P20004_VOUCHER_CODE'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22240342939535801)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'save when submit'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'c_date date := to_char(sysdate,''MM/DD/YYYY'');',
'SCHOLARSHIP_REQUEST_ID NUMBER;',
'line_manager_code nvarchar2(50);',
'',
'begin',
'    SELECT MANAGER_ID INTO line_manager_code ',
'    FROM EMPLOYEES ',
'    WHERE EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
'    -- if :P20004_REQUEST_ID is null then',
'--         for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = ''scholarship'' and WF_EXPIRATION_DATE >= sysdate)loop',
'--     insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER)',
'--     values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P20004_NOTE, sysdate,',
'--     :P20004_SCHOLARSHIP_DETAIL,',
'--     rec.WF_PROCESS_ID,:P20004_LINE_MANAGER);',
'-- end loop;',
'',
'        INSERT INTO',
'            SCHOLARSHIP_REQUEST(',
'                STATUS,',
'                RECIPIENT_TYPE,',
'                PROGRAM,',
'                REQUESTER_CODE,',
'                REQUESTER_DEPARTMENT,',
'                REQUESTER_DEPARTMENT_CODE,',
'                REQUESTER_LEVEL,',
'                PARTNER_NAME,',
'                PARTNER_PHONE,',
'                PARTNER_TITLE,',
'                PARTNER_DEPARTMENT,',
'                PARTNER_FIELD,',
'                PARTNER_WORKPLACE,',
'                RECIPIENT_NAME,',
'                RECIPIENT_DOB,',
'                RECIPIENT_PHONE,',
'                RECIPIENT_RELATIONSHIP,',
'                RECIPIENT_CAMPUS,',
'                ATTACH_NAME,',
'                ATTACH_FILE,',
'                RECIPIENT_REPLACEMENT,',
'                RECIPIENT_VOUCHER_CODE_REPLACEMENT,',
'                RECIPIENT_EXPIRATION_DATE_REPLACEMENT,',
'                RECIPIENT_NOTE,',
'                RECIPIENT_REASON_REQUEST,',
'                DISCOUNT_RATE,',
'                VOUCHER_CODE,',
'                NUMBER_OF_COURSES,',
'                EFFECTIVE_DATE,',
'                EXPIRATION_DATE,',
'                APPROVED_DATE,',
'                CREATED_DATE,',
'                DETAIL_ID',
'            )',
'        VALUES',
'        (',
'                2,',
'                :P20004_SCHOLARSHIP_RECIPIENT,',
'                :P20004_PROGRAM,',
'                case',
'                    when :P20004_SCHOLARSHIP_RECIPIENT = ''D'' then :P20004_REQUEST_NAME',
'                else',
'                    :P20004_EMPLOYEE_CODE',
'                end,',
'                :P20004_DEPARTMENT,',
'                :P20004_DEPARTMENT_CODE,',
'                :P20004_LEVEL,',
'                :P20004_PARTNER_NAME,',
'                :P20004_PARTNER_PHONE,',
'                :P20004_TITLE,',
'                :P20004_PARTNER_DEPARTMENT,',
'                :P20004_FIELD,',
'                :P20004_WORKPLACE,',
'                :P20004_RECIPIENT_NAME,',
'                :P20004_RECIPIENT_DOB,',
'                :P20004_RECIPIENT_PHONE,',
'                :P20004_RELATIONSHIP,',
'                :P20004_CAMPUS,',
'                :P20004_NAME_FILES,',
'                :P20004_URL_FILES,',
'                :P20004_REPLACEMENT,',
'                :P20004_VOUCHER_CODE_REPLACEMENT,',
'                :P20004_EXPIRATION_DATE_REPLACEMENT,',
'                :P20004_NOTE,',
'                :P20004_REASON_REQUEST,',
'                :P20004_DISCOUNT_RATE,',
'                :P20004_VOUCHER_CODE,',
'                :P20004_NUMBER_OF_COURSES,',
'                :P20004_EFFECTIVE_DATE,',
'                :P20004_EXPIRATION_DATE,',
'                :P20004_APPROVED_DATE,',
'                c_date,',
'                :P20004_SCHOLARSHIP_DETAIL',
'            )',
'            returning ID into SCHOLARSHIP_REQUEST_ID;',
'    -- else',
'    --     UPDATE SCHOLARSHIP_REQUEST sr',
'    --     SET STATUS = 2,',
'    --         RECIPIENT_TYPE = :P20004_SCHOLARSHIP_RECIPIENT,',
'    --         PROGRAM = :P20004_PROGRAM,',
'    --         REQUESTER_CODE = ',
'    --             CASE ',
'    --                 WHEN :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN :P20004_REQUEST_NAME',
'    --                 ELSE :P20004_EMPLOYEE_CODE',
'    --             END,',
'    --         REQUESTER_DEPARTMENT = :P20004_DEPARTMENT,',
'    --         REQUESTER_DEPARTMENT_CODE = :P20004_DEPARTMENT_CODE,',
'    --         REQUESTER_LEVEL = :P20004_LEVEL,',
'    --         PARTNER_NAME = :P20004_PARTNER_NAME,',
'    --         PARTNER_PHONE = :P20004_PARTNER_PHONE,',
'    --         PARTNER_TITLE = :P20004_TITLE,',
'    --         PARTNER_DEPARTMENT = :P20004_PARTNER_DEPARTMENT,',
'    --         PARTNER_FIELD = :P20004_FIELD,',
'    --         PARTNER_WORKPLACE = :P20004_WORKPLACE,',
'    --         RECIPIENT_NAME = :P20004_RECIPIENT_NAME,',
'    --         RECIPIENT_DOB = :P20004_RECIPIENT_DOB,',
'    --         RECIPIENT_PHONE = :P20004_RECIPIENT_PHONE,',
'    --         RECIPIENT_RELATIONSHIP = :P20004_RELATIONSHIP,',
'    --         RECIPIENT_CAMPUS = :P20004_CAMPUS,',
'    --         ATTACH_NAME = :P20004_NAME_FILES,',
'    --         ATTACH_FILE = :P20004_URL_FILES,',
'    --         RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,',
'    --         RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,',
'    --         RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,',
'    --         RECIPIENT_NOTE = :P20004_NOTE,',
'    --         RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,',
'    --         DISCOUNT_RATE = :P20004_DISCOUNT_RATE,',
'    --         VOUCHER_CODE = :P20004_VOUCHER_CODE,',
'    --         NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,',
'    --         EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,',
'    --         EXPIRATION_DATE = :P20004_EXPIRATION_DATE,',
'    --         APPROVED_DATE = :P20004_APPROVED_DATE,',
'    --         CREATED_DATE = c_date',
'    --     WHERE :P20004_REQUEST_ID = sr.ID;',
'    -- end if;',
'',
'    -- Insert into EMP_REQUEST',
'    FOR REC IN (',
'        SELECT',
'            WF_FEATURE_APPLY,',
'            WF_PROCESS_ID',
'        FROM',
'            WORKFLOW',
'        WHERE',
'            WF_FEATURE_APPLY = :P20004_FEATURE',
'            AND WF_EXPIRATION_DATE >= SYSDATE',
'    )LOOP',
'        INSERT INTO EMP_REQUESTS(',
'            REQUEST_TYPE,',
'            SUBMIT_DATE,',
'            EMPLOYEE_CODE,',
'            STATUS,',
'            NOTE,',
'            CREATE_DATE,',
'            REQUEST_DETAIL_ID,',
'            WF_PROCESS_ID,',
'            LINE_MANAGER',
'        ) VALUES(',
'            REC.WF_FEATURE_APPLY,',
'            SYSDATE,',
'            :APP_EMP_CODE,',
'            2,',
'            :P20004_NOTE,',
'            SYSDATE,',
'            SCHOLARSHIP_REQUEST_ID,',
'            REC.WF_PROCESS_ID,',
'            line_manager_code',
'        );',
'    END LOOP;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P20004_PROGRAM'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'12345'
,p_process_success_message=>'Success!'
,p_internal_uid=>22240342939535801
);
end;
/
begin
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22241581208535806)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'submit'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'c_date date := to_char(sysdate,''MM/DD/YYYY'');',
'-- SCHOLARSHIP_REQUEST_ID NUMBER;',
'-- line_manager_code nvarchar2(50);',
'',
'begin',
'    -- SELECT MANAGER_ID INTO line_manager_code ',
'    -- FROM EMPLOYEES ',
'    -- WHERE EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
'    --if :P20004_REQUEST_ID is null then',
'--         for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = ''scholarship'' and WF_EXPIRATION_DATE >= sysdate)loop',
'--     insert into EMP_REQUESTS(REQUEST_TYPE,SUBMIT_DATE,EMPLOYEE_CODE,STATUS,NOTE,CREATE_DATE,REQUEST_DETAIL_ID,WF_PROCESS_ID,LINE_MANAGER)',
'--     values(rec.WF_FEATURE_APPLY,sysdate,:APP_EMP_CODE,2,:P20004_NOTE, sysdate,',
'--     :P20004_SCHOLARSHIP_DETAIL,',
'--     rec.WF_PROCESS_ID,:P20004_LINE_MANAGER);',
'-- end loop;',
'    UPDATE SCHOLARSHIP_REQUEST sr',
'    SET STATUS = 2,',
'        RECIPIENT_TYPE = :P20004_SCHOLARSHIP_RECIPIENT,',
'        PROGRAM = :P20004_PROGRAM,',
'        REQUESTER_CODE = ',
'            CASE ',
'                WHEN :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN :P20004_REQUEST_NAME',
'                ELSE :P20004_EMPLOYEE_CODE',
'            END,',
'        REQUESTER_DEPARTMENT = :P20004_DEPARTMENT,',
'        REQUESTER_DEPARTMENT_CODE = :P20004_DEPARTMENT_CODE,',
'        REQUESTER_LEVEL = :P20004_LEVEL,',
'        PARTNER_NAME = :P20004_PARTNER_NAME,',
'        PARTNER_PHONE = :P20004_PARTNER_PHONE,',
'        PARTNER_TITLE = :P20004_TITLE,',
'        PARTNER_DEPARTMENT = :P20004_PARTNER_DEPARTMENT,',
'        PARTNER_FIELD = :P20004_FIELD,',
'        PARTNER_WORKPLACE = :P20004_WORKPLACE,',
'        RECIPIENT_NAME = :P20004_RECIPIENT_NAME,',
'        RECIPIENT_DOB = :P20004_RECIPIENT_DOB,',
'        RECIPIENT_PHONE = :P20004_RECIPIENT_PHONE,',
'        RECIPIENT_RELATIONSHIP = :P20004_RELATIONSHIP,',
'        RECIPIENT_CAMPUS = :P20004_CAMPUS,',
'        ATTACH_NAME = :P20004_NAME_FILES,',
'        ATTACH_FILE = :P20004_URL_FILES,',
'        RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,',
'        RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,',
'        RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,',
'        RECIPIENT_NOTE = :P20004_NOTE,',
'        RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,',
'        DISCOUNT_RATE = :P20004_DISCOUNT_RATE,',
'        VOUCHER_CODE = :P20004_VOUCHER_CODE,',
'        NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,',
'        EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,',
'        EXPIRATION_DATE = :P20004_EXPIRATION_DATE,',
'        APPROVED_DATE = :P20004_APPROVED_DATE,',
'        CREATED_DATE = c_date',
'    WHERE :P20004_REQUEST_ID = sr.ID;',
'',
'    -- Insert into EMP_REQUEST',
'        ',
'       UPDATE EMP_REQUESTS emp',
'       SET',
'            STATUS = 2,',
'            NOTE = :P20004_NOTE',
'        WHERE :P20004_REQUEST_ID = emp.REQUEST_DETAIL_ID;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P20004_PROGRAM'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'12345'
,p_process_success_message=>'Success!'
,p_internal_uid=>22241581208535806
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22240756624535803)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'save'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'c_date date := to_char(sysdate,''MM/DD/YYYY'');',
'scholarship_request_id number;',
'begin',
'    --if :P20004_REQUEST_ID is null then',
'        INSERT INTO',
'            SCHOLARSHIP_REQUEST(',
'                STATUS,',
'                RECIPIENT_TYPE,',
'                PROGRAM,',
'                REQUESTER_CODE,',
'                REQUESTER_DEPARTMENT,',
'                REQUESTER_DEPARTMENT_CODE,',
'                REQUESTER_LEVEL,',
'                PARTNER_NAME,',
'                PARTNER_PHONE,',
'                PARTNER_TITLE,',
'                PARTNER_DEPARTMENT,',
'                PARTNER_FIELD,',
'                PARTNER_WORKPLACE,',
'                RECIPIENT_NAME,',
'                RECIPIENT_DOB,',
'                RECIPIENT_PHONE,',
'                RECIPIENT_RELATIONSHIP,',
'                RECIPIENT_CAMPUS,',
'                ATTACH_NAME,',
'                ATTACH_FILE,',
'                RECIPIENT_REPLACEMENT,',
'                RECIPIENT_VOUCHER_CODE_REPLACEMENT,',
'                RECIPIENT_EXPIRATION_DATE_REPLACEMENT,',
'                RECIPIENT_NOTE,',
'                RECIPIENT_REASON_REQUEST,',
'                DISCOUNT_RATE,',
'                VOUCHER_CODE,',
'                NUMBER_OF_COURSES,',
'                EFFECTIVE_DATE,',
'                EXPIRATION_DATE,',
'                APPROVED_DATE,',
'                CREATED_DATE,',
'                DETAIL_ID',
'            )',
'        VALUES',
'        (',
'                1,',
'                :P20004_SCHOLARSHIP_RECIPIENT,',
'                :P20004_PROGRAM,',
'                case',
'                    when :P20004_SCHOLARSHIP_RECIPIENT = ''D'' then :P20004_REQUEST_NAME',
'                else',
'                    :P20004_EMPLOYEE_CODE',
'                end,',
'                :P20004_DEPARTMENT,',
'                :P20004_DEPARTMENT_CODE,',
'                :P20004_LEVEL,',
'                :P20004_PARTNER_NAME,',
'                :P20004_PARTNER_PHONE,',
'                :P20004_TITLE,',
'                :P20004_PARTNER_DEPARTMENT,',
'                :P20004_FIELD,',
'                :P20004_WORKPLACE,',
'                :P20004_RECIPIENT_NAME,',
'                :P20004_RECIPIENT_DOB,',
'                :P20004_RECIPIENT_PHONE,',
'                :P20004_RELATIONSHIP,',
'                :P20004_CAMPUS,',
'                :P20004_NAME_FILES,',
'                :P20004_URL_FILES,',
'                :P20004_REPLACEMENT,',
'                :P20004_VOUCHER_CODE_REPLACEMENT,',
'                :P20004_EXPIRATION_DATE_REPLACEMENT,',
'                :P20004_NOTE,',
'                :P20004_REASON_REQUEST,',
'                :P20004_DISCOUNT_RATE,',
'                :P20004_VOUCHER_CODE,',
'                :P20004_NUMBER_OF_COURSES,',
'                :P20004_EFFECTIVE_DATE,',
'                :P20004_EXPIRATION_DATE,',
'                :P20004_APPROVED_DATE,',
'                c_date,',
'                :P20004_SCHOLARSHIP_DETAIL',
'            ) returning ID into scholarship_request_id;',
'',
'        for rec in (select WF_FEATURE_APPLY,WF_PROCESS_ID from WORKFLOW where lower(WF_FEATURE_APPLY) = ''scholarship'' and WF_EXPIRATION_DATE >= sysdate)',
'        loop',
'            insert into EMP_REQUESTS(',
'                REQUEST_TYPE,',
'                SUBMIT_DATE,',
'                EMPLOYEE_CODE,',
'                STATUS,',
'                NOTE,',
'                CREATE_DATE,',
'                REQUEST_DETAIL_ID,',
'                WF_PROCESS_ID,',
'                LINE_MANAGER)',
'            values(',
'                rec.WF_FEATURE_APPLY,',
'                sysdate,',
'                :APP_EMP_CODE,',
'                1,',
'                :P20004_NOTE,',
'                sysdate,',
'                scholarship_request_id,',
'                rec.WF_PROCESS_ID,',
'                :P20004_LINE_MANAGER);',
'        end loop;',
'',
'    -- else',
'    --     UPDATE SCHOLARSHIP_REQUEST sr',
'    --     SET STATUS = 1,',
'    --         RECIPIENT_TYPE = :P20004_SCHOLARSHIP_RECIPIENT,',
'    --         PROGRAM = :P20004_PROGRAM,',
'    --         REQUESTER_CODE = ',
'    --             CASE ',
'    --                 WHEN :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN :P20004_REQUEST_NAME',
'    --                 ELSE :P20004_EMPLOYEE_CODE',
'    --             END,',
'    --         REQUESTER_DEPARTMENT = :P20004_DEPARTMENT,',
'    --         REQUESTER_DEPARTMENT_CODE = :P20004_DEPARTMENT_CODE,',
'    --         REQUESTER_LEVEL = :P20004_LEVEL,',
'    --         PARTNER_NAME = :P20004_PARTNER_NAME,',
'    --         PARTNER_PHONE = :P20004_PARTNER_PHONE,',
'    --         PARTNER_TITLE = :P20004_TITLE,',
'    --         PARTNER_DEPARTMENT = :P20004_PARTNER_DEPARTMENT,',
'    --         PARTNER_FIELD = :P20004_FIELD,',
'    --         PARTNER_WORKPLACE = :P20004_WORKPLACE,',
'    --         RECIPIENT_NAME = :P20004_RECIPIENT_NAME,',
'    --         RECIPIENT_DOB = :P20004_RECIPIENT_DOB,',
'    --         RECIPIENT_PHONE = :P20004_RECIPIENT_PHONE,',
'    --         RECIPIENT_RELATIONSHIP = :P20004_RELATIONSHIP,',
'    --         RECIPIENT_CAMPUS = :P20004_CAMPUS,',
'    --         ATTACH_NAME = :P20004_NAME_FILES,',
'    --         ATTACH_FILE = :P20004_URL_FILES,',
'    --         RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,',
'    --         RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,',
'    --         RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,',
'    --         RECIPIENT_NOTE = :P20004_NOTE,',
'    --         RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,',
'    --         DISCOUNT_RATE = :P20004_DISCOUNT_RATE,',
'    --         VOUCHER_CODE = :P20004_VOUCHER_CODE,',
'    --         NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,',
'    --         EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,',
'    --         EXPIRATION_DATE = :P20004_EXPIRATION_DATE,',
'    --         APPROVED_DATE = :P20004_APPROVED_DATE,',
'    --         CREATED_DATE = c_date',
'    --     WHERE :P20004_REQUEST_ID = sr.ID;',
'    --end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P20004_PROGRAM'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'12345'
,p_process_success_message=>'Success!'
,p_internal_uid=>22240756624535803
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22241102108535805)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'c_date date := to_char(sysdate,''MM/DD/YYYY'');',
'scholarship_request_id number;',
'begin',
'    --if :P20004_REQUEST_ID is null then',
'    -- else',
'        UPDATE SCHOLARSHIP_REQUEST sr',
'        SET STATUS = 1,',
'            -- RECIPIENT_TYPE = :P20004_SCHOLARSHIP_RECIPIENT,',
'            -- PROGRAM = :P20004_PROGRAM,',
'            -- REQUESTER_CODE = ',
'            --     CASE ',
'            --         WHEN :P20004_SCHOLARSHIP_RECIPIENT = ''D'' THEN :P20004_REQUEST_NAME',
'            --         ELSE :P20004_EMPLOYEE_CODE',
'            --     END,',
'            -- REQUESTER_DEPARTMENT = :P20004_DEPARTMENT,',
'            -- REQUESTER_DEPARTMENT_CODE = :P20004_DEPARTMENT_CODE,',
'            -- REQUESTER_LEVEL = :P20004_LEVEL,',
'            PARTNER_NAME = :P20004_PARTNER_NAME,',
'            PARTNER_PHONE = :P20004_PARTNER_PHONE,',
'            PARTNER_TITLE = :P20004_TITLE,',
'            PARTNER_DEPARTMENT = :P20004_PARTNER_DEPARTMENT,',
'            PARTNER_FIELD = :P20004_FIELD,',
'            PARTNER_WORKPLACE = :P20004_WORKPLACE,',
'            RECIPIENT_NAME = :P20004_RECIPIENT_NAME,',
'            RECIPIENT_DOB = :P20004_RECIPIENT_DOB,',
'            RECIPIENT_PHONE = :P20004_RECIPIENT_PHONE,',
'            RECIPIENT_RELATIONSHIP = :P20004_RELATIONSHIP,',
'            RECIPIENT_CAMPUS = :P20004_CAMPUS,',
'            ATTACH_NAME = :P20004_NAME_FILES,',
'            ATTACH_FILE = :P20004_URL_FILES,',
'            RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,',
'            RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,',
'            RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,',
'            RECIPIENT_NOTE = :P20004_NOTE,',
'            RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,',
'            -- DISCOUNT_RATE = :P20004_DISCOUNT_RATE,',
'            -- VOUCHER_CODE = :P20004_VOUCHER_CODE,',
'            -- NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,',
'            -- EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,',
'            -- EXPIRATION_DATE = :P20004_EXPIRATION_DATE,',
'            -- APPROVED_DATE = :P20004_APPROVED_DATE,',
'            CREATED_DATE = c_date',
'        WHERE :P20004_REQUEST_ID = sr.ID;',
'    --end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when=>'P20004_PROGRAM'
,p_process_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_process_when2=>'12345'
,p_process_success_message=>'Success!'
,p_internal_uid=>22241102108535805
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22026453014485916)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Approve'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    pro_code nvarchar2(100);',
unistr('    id_replace number;      -- id c\1EE7a voucher code b\1ECB replace'),
'    emp_manager nvarchar2(200);',
'    emp_email nvarchar2(200);',
'',
'begin',
'',
unistr('    -- l\1EA5y promotion_code m\1EDBi'),
'    select cp.PROMOTION_CODE',
'    into pro_code',
'    from COREEDU_PROMOTION cp',
'    where cp.PROGRAM = :P20004_PROGRAM and cp.DISCOUNT_RATE = :P20004_DISCOUNT_RATE;',
'',
'    for rec in (',
'    --     with temp as (',
'    --     select wa.WA_GROUP from EMP_REQUESTS er',
'    --         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'    --         join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP',
'    --         where emp.EMPLOYEE_CODE = :APP_EMP_CODE',
'    --         group by wa.WA_GROUP',
'    -- )',
'        select er.CURRENT_STEP,er.NEXT_STEP,',
'            count(wa.WA_SEQUENCE_NUMBER) as SEQ ',
'        from EMP_REQUESTS er',
'        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'            -- join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP',
'        where er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID ',
'            and er.STATUS <> 3 ',
'        group by er.CURRENT_STEP,er.NEXT_STEP',
'    )',
'        loop',
'            if rec.NEXT_STEP < rec.SEQ then',
'                --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;',
'                ',
unistr('                -- c\1EADp nh\1EADt b\1EA3ng EMP_REQUESTS v\1EC1 tr\1EA1ng th\00E1i ''in-review'''),
'                update EMP_REQUESTS ',
'                set MODIFIED_DATE = sysdate,',
'                    CURRENT_STEP = rec.NEXT_STEP,',
'                    MODIFIED_BY_CODE = :APP_EMP_CODE,',
'                    NEXT_STEP = rec.NEXT_STEP + 1,',
'                    STATUS = 6 ',
'                where REQUEST_DETAIL_ID = :P20004_REQUEST_ID;',
'',
unistr('                -- c\1EADp nh\1EADt b\1EA3ng SCHOLARSHIP_REQUEST v\1EC1 tr\1EA1ng th\00E1i ''in-review'''),
'                update SCHOLARSHIP_REQUEST ',
'                set STATUS = 6,',
'                    RECIPIENT_CAMPUS = :P20004_CAMPUS,',
'                    RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,',
'                    RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,',
'                    RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,',
'                    RECIPIENT_NOTE = :P20004_NOTE,',
'                    RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,',
'                    DISCOUNT_RATE = :P20004_DISCOUNT_RATE,',
'                    VOUCHER_CODE = :P20004_VOUCHER_CODE,',
'                    NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,',
'                    EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,',
'                    EXPIRATION_DATE = :P20004_EXPIRATION_DATE,',
'                    PROMOTION_CODE = pro_code',
'                where id = :P20004_REQUEST_ID;',
'',
unistr('                -- th\00EAm d\00F2ng m\1EDBi v\00E0o b\1EA3ng ''WORKFLOW_DETAIL'' khi c\00F3 thao t\00E1c ''approve'''),
'                insert into WORKFLOW_DETAIL(',
'                    WD_MODIFIED_DATE,',
'                    WD_MODIFIED_CODE,',
'                    STATUS,',
'                    REQUEST_ID,',
'                    SEQUENCE,',
'                    WD_COMMENT',
'                ) ',
'                values(',
'                    sysdate,',
'                    :APP_EMP_CODE,',
'                    6,',
'                    :P20004_REQUEST_ID,',
'                    rec.NEXT_STEP,',
'                    :P20004_NOTE',
'                    );',
'            else',
unistr('                -- c\1EADp nh\1EADt b\1EA3ng EMP_REQUESTS v\1EC1 tr\1EA1ng th\00E1i ''active''                '),
'                update EMP_REQUESTS ',
'                set MODIFIED_DATE = sysdate,',
'                    CURRENT_STEP = rec.NEXT_STEP,',
'                    MODIFIED_BY_CODE = :APP_EMP_CODE,',
'                    STATUS = 3 ',
'                where REQUEST_DETAIL_ID = :P20004_REQUEST_ID;',
'',
unistr('                -- c\1EADp nh\1EADt b\1EA3ng SCHOLARSHIP_REQUEST v\1EC1 tr\1EA1ng th\00E1i ''active'''),
'                update SCHOLARSHIP_REQUEST ',
'                set STATUS = 3,',
'                    RECIPIENT_CAMPUS = :P20004_CAMPUS,',
'                    RECIPIENT_REPLACEMENT = :P20004_REPLACEMENT,',
'                    RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20004_VOUCHER_CODE_REPLACEMENT,',
'                    RECIPIENT_EXPIRATION_DATE_REPLACEMENT = :P20004_EXPIRATION_DATE_REPLACEMENT,',
'                    RECIPIENT_NOTE = :P20004_NOTE,',
'                    RECIPIENT_REASON_REQUEST = :P20004_REASON_REQUEST,',
'                    DISCOUNT_RATE = :P20004_DISCOUNT_RATE,',
'                    VOUCHER_CODE = :P20004_VOUCHER_CODE,',
'                    NUMBER_OF_COURSES = :P20004_NUMBER_OF_COURSES,',
'                    EFFECTIVE_DATE = :P20004_EFFECTIVE_DATE,',
'                    EXPIRATION_DATE = :P20004_EXPIRATION_DATE,',
'                    PROMOTION_CODE = pro_code',
'                where id = :P20004_REQUEST_ID;',
'',
unistr('                -- th\00EAm d\00F2ng m\1EDBi v\00E0o b\1EA3ng ''WORKFLOW_DETAIL'' khi ''active'''),
'                insert into WORKFLOW_DETAIL(',
'                    WD_MODIFIED_DATE,',
'                    WD_MODIFIED_CODE,',
'                    STATUS,',
'                    REQUEST_ID,',
'                    SEQUENCE,',
'                    WD_COMMENT',
'                ) ',
'                values(',
'                    sysdate,',
'                    :APP_EMP_CODE,',
'                    3,',
'                    :P20004_REQUEST_ID,',
'                    rec.NEXT_STEP,',
'                    :P20004_NOTE',
'                    );',
'',
unistr('                -- tr\01B0\1EDDng h\1EE3p replacement \0111\01B0\1EE3c ch\1EA5p nh\1EADn, \0111\1ED5i status c\1EE7a voucher b\1ECB replace th\00E0nh in-active (7)'),
'                if :P20004_REPLACEMENT is not null then',
'                    select id into id_replace from SCHOLARSHIP_REQUEST where VOUCHER_CODE = :P20004_REPLACEMENT;',
'                    ',
'                    update SCHOLARSHIP_REQUEST',
'                    set STATUS = 7',
'                    where id = id_replace;',
'',
'                    update EMP_REQUESTS ',
'                    set STATUS = 7 ',
'                    where REQUEST_DETAIL_ID = id_replace;',
'                    ',
unistr('                    -- th\00EAm tr\1EA1ng th\00E1i in-active v\00E0o workflow_detail'),
'                    insert into WORKFLOW_DETAIL(',
'                        WD_MODIFIED_DATE,',
'                        WD_MODIFIED_CODE,',
'                        STATUS,',
'                        REQUEST_ID,',
'                        WD_COMMENT',
'                    ) ',
'                    values(',
'                        sysdate,',
'                        :APP_EMP_CODE,',
'                        7,',
'                        id_replace,',
'                        :P20004_NOTE',
'                        );',
'                end if;',
'            end if;',
'            ',
'            -- insert into WORKFLOW_DETAIL(',
'            --     WD_MODIFIED_DATE,',
'            --     WD_MODIFIED_CODE,',
'            --     STATUS,',
'            --     REQUEST_ID,',
'            --     SEQUENCE,',
'            --     WD_COMMENT',
'            --     ) ',
'            -- values(',
'            --     sysdate,',
'            --     :APP_EMP_CODE,',
'            --     3,',
'            --     :P20004_REQUEST_ID,',
'            --     rec.NEXT_STEP,',
'            --     :P20004_NOTE',
'            --     );',
'        end loop;',
'',
'',
'-- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet613@gmail.com'', ''Scholarship Request Submitted Successfully'', ''<p> Dear ''|| :APP_USER_NAME ||'', </p>'' ||',
'-- ''<p> Your Scholarship Request has been submitted successfully. Here are the details: </p>'' ||',
'',
'-- ''<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>'' ||',
'-- ''<br>'' || ',
'-- ''<p> Thank you, </p>'' ||',
'-- ''<p> VUS </p>'');',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(22210773679535753)
,p_process_when=>'P20004_REQUEST_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_success_message=>'Approved!'
,p_internal_uid=>22026453014485916
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22026567611485917)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Reject'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    n_check number;',
'    n_step number;',
'begin',
'for rec in (',
'--     with temp as (',
'--     select wa.WA_GROUP from EMP_REQUESTS er',
'--         join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'--         join employees emp on emp.APPROVAL_GROUP = wa.WA_GROUP',
'--         where emp.EMPLOYEE_CODE = :APP_EMP_CODE',
'--         group by wa.WA_GROUP',
'-- )',
'    select er.CURRENT_STEP,er.NEXT_STEP,count(wa.WA_SEQUENCE_NUMBER) as SEQ from EMP_REQUESTS er',
'        join WORKFLOW_APPROVAL wa on wa.WF_PROCESS_ID = er.WF_PROCESS_ID',
'        -- join WORKFLOW_APPROVAL tmp on tmp.WA_GROUP = wa.WA_GROUP',
'        where er.REQUEST_DETAIL_ID = :P20004_REQUEST_ID and er.STATUS <> 3 group by er.CURRENT_STEP,er.NEXT_STEP) ',
'        loop',
'            if rec.NEXT_STEP < rec.SEQ then',
'                --select wa.WA_SEQUENCE_NUMBER into n_step from EMPLOYEES emp join WORKFLOW_APPROVAL wa on wa.WA_GROUP = emp.APPROVAL_GROUP and employee_code = :APP_EMP_CODE;',
'                update EMP_REQUESTS ',
'                set MODIFIED_DATE = sysdate,',
'                    CURRENT_STEP = rec.NEXT_STEP,',
'                    MODIFIED_BY_CODE = :APP_EMP_CODE,',
'                    STATUS = 4',
'                where REQUEST_DETAIL_ID = :P20004_REQUEST_ID;',
'                            ',
'                insert into WORKFLOW_DETAIL(',
'                    WD_MODIFIED_DATE,',
'                    WD_MODIFIED_CODE,',
'                    STATUS,',
'                    REQUEST_ID,',
'                    SEQUENCE',
'                    ) ',
'                values(',
'                    sysdate,',
'                    :APP_EMP_CODE,',
'                    4,',
'                    :P20004_REQUEST_ID,',
'                    rec.NEXT_STEP',
'                    );',
'            ',
'            update SCHOLARSHIP_REQUEST ',
'            set STATUS = 4 ',
'            where id = :P20004_REQUEST_ID;',
'                --else',
'                --update EMP_REQUESTS set MODIFIED_DATE = sysdate,CURRENT_STEP=rec.NEXT_STEP,MODIFIED_BY_CODE = :APP_EMP_CODE,STATUS=3 where id = :P20004_REQUEST_ID;',
'            end if;',
'        end loop;',
'',
'/*',
'SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''dieptran@vus-etsc.edu.vn'', ''OT Request Submitted Successfully'', ''<p> Dear ''|| :APP_USER_NAME ||'', </p>'' ||',
'''<p> Your OT request has been submitted successfully. Here are the details: </p>'' ||',
'',
'''<p> If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>'' ||',
'''<br>'' || ',
'''<p> Thank you, </p>'' ||',
'''<p> VUS </p>'');',
'*/',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(22209958772535752)
,p_process_when=>'P20004_REQUEST_ID'
,p_process_when_type=>'ITEM_IS_NOT_NULL'
,p_process_success_message=>'Rejected!'
,p_internal_uid=>22026567611485917
);
end;
/
prompt --application/pages/delete_20005
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>20005);
end;
/
prompt --application/pages/page_20005
begin
wwv_flow_imp_page.create_page(
 p_id=>20005
,p_name=>'approve_scholarship_request'
,p_alias=>'APPROVE-SCHOLARSHIP-REQUEST'
,p_step_title=>'Scholarship Request'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const setDefaultReport = function(){',
'',
'    $(''.igrid_p25_1'').each(element => {',
'        ',
'        let igActions = apex.region($(''.igrid_p25_1'')[element].id).call("getActions");',
'',
'        let choices =  igActions.lookup("change-report").choices;',
'',
'',
'        if(choices.length > 0){',
'            ',
'            let primary = choices.filter(obj => {',
'',
'                return obj.group === "Default_History";',
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
'}'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'/* auto wrap cho header */',
'.a-GV-header .a-GV-headerLabel {',
'    white-space: normal;',
'    text-align: center;',
'}',
'',
'/* auto wrap cho cell */',
'.a-GV-cell {',
'    white-space: normal !important;',
'    text-align: center !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_overwrite_navigation_list=>'Y'
,p_navigation_list_position=>'SIDE'
,p_navigation_list_id=>wwv_flow_imp.id(18598165733888960)
,p_navigation_list_template_id=>wwv_flow_imp.id(18761008355889106)
,p_nav_list_template_options=>'#DEFAULT#:t-TreeNav--styleA:js-navCollapsed--hidden'
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20231129173726'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(22026307893485915)
,p_plug_name=>'Scholarship List'
,p_region_template_options=>'#DEFAULT#:t-BreadcrumbRegion--useBreadcrumbTitle'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18712759415889069)
,p_plug_display_sequence=>10
,p_plug_display_point=>'REGION_POSITION_01'
,p_menu_id=>wwv_flow_imp.id(18597660344888957)
,p_plug_source_type=>'NATIVE_BREADCRUMB'
,p_menu_template_id=>wwv_flow_imp.id(18774898137889124)
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(48743304305033316)
,p_plug_name=>'Filter fields'
,p_region_css_classes=>'igrid_p25_1'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>40
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(52610098335132028)
,p_plug_name=>'SCHOLARSHIP REQUEST I-GRID'
,p_region_css_classes=>'igrid_p25_1'
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>50
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select sr.ID,',
'       er.STATUS,',
'       sr.RECIPIENT_TYPE,',
'       sr.PROGRAM,',
'       --sr.REQUESTER_CODE,',
'       --sr.REQUESTER_DEPARTMENT,',
'       --sr.REQUESTER_LEVEL,',
'       sr.PARTNER_NAME,',
'       sr.PARTNER_PHONE,',
'       sr.PARTNER_TITLE,',
'       sr.PARTNER_DEPARTMENT,',
'       sr.PARTNER_FIELD,',
'       sr.PARTNER_WORKPLACE,',
'       sr.RECIPIENT_NAME,',
'       sr.RECIPIENT_DOB,',
'       sr.RECIPIENT_PHONE,',
'       sr.RECIPIENT_RELATIONSHIP,',
'       sr.RECIPIENT_CAMPUS,',
'       sr.ATTACH_NAME,',
'       sr.ATTACH_FILE,',
'       sr.RECIPIENT_REPLACEMENT,',
'       sr.RECIPIENT_VOUCHER_CODE_REPLACEMENT,',
'       sr.RECIPIENT_EXPIRATION_DATE_REPLACEMENT,',
'       sr.RECIPIENT_NOTE,',
'       sr.RECIPIENT_REASON_REQUEST,',
'       sr.DISCOUNT_RATE,',
'       sr.VOUCHER_CODE,',
'       sr.NUMBER_OF_COURSES,',
'       sr.EFFECTIVE_DATE,',
'       sr.EXPIRATION_DATE,',
'       sr.APPROVED_DATE,',
'       sr.CREATED_DATE,',
'       emp.FULL_NAME,',
'       emp.LEVEL_DESCRIPTION,',
'       emp.EMPLOYEE_CODE,',
'       emp.START_DATE,',
'       emp.TERMINATE_DATE,',
'       emp.DEPARTMENT_ID,',
'       emp.DEPARTMENT_NAME',
'  from SCHOLARSHIP_REQUEST sr',
'  join EMPLOYEES emp on sr.REQUESTER_CODE = emp.EMPLOYEE_CODE',
'  join EMP_REQUESTS er on er.REQUEST_DETAIL_ID = sr.ID and er.STATUS != 1',
'  where sr.EFFECTIVE_DATE between to_date(:P20005_DATE_FROM,''MM/DD/YYYY'') and to_date(:P20005_DATE_TO,''MM/DD/YYYY'')',
'  AND ( TRIM(:P20005_STATUS) = ''0''  OR er.STATUS = TRIM(:P20005_STATUS))',
'  AND ( TRIM(:P20005_SCHOLARSHIP_RECIPIENT) = ''0''  OR sr.RECIPIENT_TYPE = :P20005_SCHOLARSHIP_RECIPIENT)',
'  AND  lower(trim(emp.EMPLOYEE_CODE))  like ''%'' || lower(trim(:P20005_EMPLOYEE_CODE)) || ''%'' ',
'  AND  lower(trim(emp.FULL_NAME))  like ''%'' || lower(trim(:P20005_EMPLOYEE)) || ''%'' ',
''))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'P20005_SCHOLARSHIP_RECIPIENT,P20005_STATUS,P20005_DATE_FROM,P20005_DATE_TO,P20005_EMPLOYEE_CODE,P20005_EMPLOYEE'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'SCHOLARSHIP REQUEST I-GRID'
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
 p_id=>wwv_flow_imp.id(52730063429230313)
,p_heading=>'Scholarship Information'
,p_label=>'SI'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(52730155175230314)
,p_heading=>'Information Of Recipient'
,p_label=>'IOR'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(52730231271230315)
,p_heading=>'Requester/ Department Request Information'
,p_label=>'RDRI'
);
wwv_flow_imp_page.create_region_column_group(
 p_id=>wwv_flow_imp.id(52730349276230316)
,p_heading=>'Partner Information'
,p_label=>'PI'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52610344884132030)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_is_query_only=>true
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
,p_value_alignment=>'CENTER'
,p_attribute_05=>'BOTH'
,p_is_required=>true
,p_enable_filter=>true
,p_filter_is_required=>false
,p_filter_lov_type=>'DISTINCT'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52610407254132031)
,p_name=>'STATUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'STATUS'
,p_data_type=>'NUMBER'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Status'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>40
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(13153015369193856)
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
 p_id=>wwv_flow_imp.id(52610557602132032)
,p_name=>'RECIPIENT_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_TYPE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Scholarship Recipient'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(52730063429230313)
,p_use_group_for=>'BOTH'
,p_is_required=>true
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(13149840134168038)
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
 p_id=>wwv_flow_imp.id(52610649175132033)
,p_name=>'PROGRAM'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PROGRAM'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Program'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730063429230313)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>true
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52611103655132038)
,p_name=>'PARTNER_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Name'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730349276230316)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52611278403132039)
,p_name=>'PARTNER_PHONE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_PHONE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Phone'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>120
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730349276230316)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
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
 p_id=>wwv_flow_imp.id(52611375461132040)
,p_name=>'PARTNER_TITLE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_TITLE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Title'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730349276230316)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52727879171230291)
,p_name=>'PARTNER_DEPARTMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_DEPARTMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Department'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730349276230316)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52727991229230292)
,p_name=>'PARTNER_FIELD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_FIELD'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Field'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730349276230316)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52728071987230293)
,p_name=>'PARTNER_WORKPLACE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PARTNER_WORKPLACE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Workplace'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>160
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730349276230316)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52728129871230294)
,p_name=>'RECIPIENT_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Full name'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>170
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52728216012230295)
,p_name=>'RECIPIENT_DOB'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_DOB'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'DOB'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>180
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(52728340946230296)
,p_name=>'RECIPIENT_PHONE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_PHONE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Phone'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>190
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52728490784230297)
,p_name=>'RECIPIENT_RELATIONSHIP'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_RELATIONSHIP'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Relationship'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>200
,p_value_alignment=>'LEFT'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
,p_is_required=>false
,p_lov_type=>'SHARED'
,p_lov_id=>wwv_flow_imp.id(14989626799293948)
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
 p_id=>wwv_flow_imp.id(52728538681230298)
,p_name=>'RECIPIENT_CAMPUS'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_CAMPUS'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Campus'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>210
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52728624863230299)
,p_name=>'ATTACH_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATTACH_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Attach Name'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>220
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>8000
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52728740592230300)
,p_name=>'ATTACH_FILE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATTACH_FILE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Attach File'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>230
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
,p_is_required=>false
,p_max_length=>8000
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52728888135230301)
,p_name=>'RECIPIENT_REPLACEMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_REPLACEMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Replacement for (if any)'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>240
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(52728910953230302)
,p_name=>'RECIPIENT_VOUCHER_CODE_REPLACEMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_VOUCHER_CODE_REPLACEMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Voucher code (replacement)'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>250
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52729070039230303)
,p_name=>'RECIPIENT_EXPIRATION_DATE_REPLACEMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_EXPIRATION_DATE_REPLACEMENT'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Expiration date (replacement)'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>260
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
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
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52729099622230304)
,p_name=>'RECIPIENT_NOTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_NOTE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Note'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>270
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52729251434230305)
,p_name=>'RECIPIENT_REASON_REQUEST'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'RECIPIENT_REASON_REQUEST'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Reason request'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>280
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
,p_use_group_for=>'BOTH'
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52729394082230306)
,p_name=>'DISCOUNT_RATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DISCOUNT_RATE'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Discount rate'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>290
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730155175230314)
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
 p_id=>wwv_flow_imp.id(52729446712230307)
,p_name=>'VOUCHER_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'VOUCHER_CODE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Voucher code'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>300
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730063429230313)
,p_use_group_for=>'BOTH'
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
,p_duplicate_value=>true
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52729500762230308)
,p_name=>'NUMBER_OF_COURSES'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'NUMBER_OF_COURSES'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading=>'Number Of Courses'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>310
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730063429230313)
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
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52729692441230309)
,p_name=>'EFFECTIVE_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EFFECTIVE_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Effective date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>320
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730063429230313)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(52729747346230310)
,p_name=>'EXPIRATION_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EXPIRATION_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Expiration date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>330
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730063429230313)
,p_use_group_for=>'BOTH'
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
end;
/
begin
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52729804030230311)
,p_name=>'APPROVED_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'APPROVED_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Approved date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>340
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730063429230313)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(52729982521230312)
,p_name=>'CREATED_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CREATED_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Created date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>350
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730063429230313)
,p_use_group_for=>'BOTH'
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
,p_display_condition=>'false'
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52730435883230317)
,p_name=>'ROW$SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'Y'
,p_attribute_02=>'Y'
,p_attribute_03=>'N'
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(52730516789230318)
,p_name=>'ACTIONS$MENU'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_LINK'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>20
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:20004:&SESSION.::&DEBUG.:20004:P20004_REQUEST_ID,P20004_STATUS:&ID.,&STATUS.'
,p_link_text=>'<img src="#IMAGE_PREFIX#app_ui/img/icons/apex-edit-pencil.png" class="apex-edit-pencil" alt="">'
,p_use_as_row_header=>false
,p_enable_hide=>true
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(53066733902080991)
,p_name=>'REQUESTER_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FULL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Requester'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>360
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730231271230315)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(53066849134080992)
,p_name=>'TERMINATE_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TERMINATE_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Terminate date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>370
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730231271230315)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(53066974797080993)
,p_name=>'DEPARTMENT_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DEPARTMENT_ID'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Department code'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>380
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730231271230315)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
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
 p_id=>wwv_flow_imp.id(53067084365080994)
,p_name=>'LEVEL_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LEVEL_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Level'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>390
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730231271230315)
,p_use_group_for=>'BOTH'
,p_attribute_05=>'BOTH'
,p_is_required=>false
,p_max_length=>20
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
 p_id=>wwv_flow_imp.id(53067140845080995)
,p_name=>'EMPLOYEE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Employee code'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>400
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730231271230315)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(53067258975080996)
,p_name=>'START_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'START_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Start date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>410
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730231271230315)
,p_use_group_for=>'BOTH'
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
 p_id=>wwv_flow_imp.id(53067363215080997)
,p_name=>'DEPARTMENT_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'DEPARTMENT_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Department'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>420
,p_value_alignment=>'CENTER'
,p_group_id=>wwv_flow_imp.id(52730231271230315)
,p_use_group_for=>'BOTH'
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
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(52610247608132029)
,p_internal_uid=>52610247608132029
,p_is_editable=>false
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
,p_download_formats=>'CSV:HTML:XLSX:PDF'
,p_enable_mail_download=>true
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(52733424325231103)
,p_interactive_grid_id=>wwv_flow_imp.id(52610247608132029)
,p_static_id=>'150419'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(52733641745231103)
,p_report_id=>wwv_flow_imp.id(52733424325231103)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(37693691123054231)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>32
,p_column_id=>wwv_flow_imp.id(53066849134080992)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>136
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(37694679094054235)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>33
,p_column_id=>wwv_flow_imp.id(53066974797080993)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>156
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52734159699231105)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(52610344884132030)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>50
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52735041409231110)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(52610407254132031)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>83
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52735977292231114)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(52610557602132032)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>97.06200000000001
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52736886970231117)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(52610649175132033)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>87.05000000000001
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52741358015231134)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>35
,p_column_id=>wwv_flow_imp.id(52611103655132038)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>175
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52742290096231137)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>36
,p_column_id=>wwv_flow_imp.id(52611278403132039)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>145
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52743101488231140)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>28
,p_column_id=>wwv_flow_imp.id(52611375461132040)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>86
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52744008821231143)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>30
,p_column_id=>wwv_flow_imp.id(52727879171230291)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>138.8000244140625
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52744967189231147)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>29
,p_column_id=>wwv_flow_imp.id(52727991229230292)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>85.0375
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52745891073231150)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>37
,p_column_id=>wwv_flow_imp.id(52728071987230293)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>139
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52746782607231153)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(52728129871230294)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>157
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52747672267231155)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(52728216012230295)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>91
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52748524947231158)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>19
,p_column_id=>wwv_flow_imp.id(52728340946230296)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>93.0375
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52749461757231162)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>15
,p_column_id=>wwv_flow_imp.id(52728490784230297)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>92.025
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52750305904231165)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>20
,p_column_id=>wwv_flow_imp.id(52728538681230298)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>84.025
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52751239389231168)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>23
,p_column_id=>wwv_flow_imp.id(52728624863230299)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>91
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52752103908231172)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>24
,p_column_id=>wwv_flow_imp.id(52728740592230300)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>91.05
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52753008560231175)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>16
,p_column_id=>wwv_flow_imp.id(52728888135230301)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>163
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52753894351231180)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>17
,p_column_id=>wwv_flow_imp.id(52728910953230302)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>187
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52754719227231184)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>18
,p_column_id=>wwv_flow_imp.id(52729070039230303)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>187.0375
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52755640231231187)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>21
,p_column_id=>wwv_flow_imp.id(52729099622230304)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>106.075
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52756530110231191)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>22
,p_column_id=>wwv_flow_imp.id(52729251434230305)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>113.0625
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52757466401231194)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>14
,p_column_id=>wwv_flow_imp.id(52729394082230306)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>67
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52758389374231198)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(52729446712230307)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>199
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52759256969231201)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(52729500762230308)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>140.0625
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52760100119231204)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(52729692441230309)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>88
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52761027033231208)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(52729747346230310)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>88
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52761967612231211)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(52729804030230311)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>91
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52762876322231214)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(52729982521230312)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>92
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(52811121578315027)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(52730516789230318)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>40
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(53072763183081952)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>25
,p_column_id=>wwv_flow_imp.id(53066733902080991)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>153
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(53078908688170993)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>26
,p_column_id=>wwv_flow_imp.id(53067084365080994)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>124
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(53079812396170996)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>27
,p_column_id=>wwv_flow_imp.id(53067140845080995)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>143
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(53080729310170998)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>31
,p_column_id=>wwv_flow_imp.id(53067258975080996)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>131
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(53081672051171001)
,p_view_id=>wwv_flow_imp.id(52733641745231103)
,p_display_seq=>34
,p_column_id=>wwv_flow_imp.id(53067363215080997)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>124.0312
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(22298276066852343)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(48743304305033316)
,p_button_name=>'Search'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Search'
,p_warn_on_unsaved_changes=>null
,p_grid_column_css_classes=>'search-btn'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(22298632198852344)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_imp.id(48743304305033316)
,p_button_name=>'Export_Excel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Export Excel'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(22319594158852373)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(22026307893485915)
,p_button_name=>'Approve'
,p_button_action=>'REDIRECT_PAGE'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Approve'
,p_button_position=>'PREVIOUS'
,p_button_redirect_url=>'f?p=&APP_ID.:20004:&SESSION.::&DEBUG.:::'
,p_button_css_classes=>'btn-approve'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(22319179621852372)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(22026307893485915)
,p_button_name=>'Reject'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reject'
,p_button_position=>'PREVIOUS'
,p_warn_on_unsaved_changes=>null
,p_button_css_classes=>'btn-reject'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(35431772221641686)
,p_name=>'P20005_EMPLOYEE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(48743304305033316)
,p_pre_element_text=>'Employee'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(35431952050641687)
,p_name=>'P20005_EMPLOYEE_CODE'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(48743304305033316)
,p_pre_element_text=>'Employee Code'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48757295547033335)
,p_name=>'P20005_SCHOLARSHIP_RECIPIENT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(48743304305033316)
,p_item_default=>'0'
,p_pre_element_text=>'Scholarship Recipient'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'SCHOLARSHIP_RECIPIENT'
,p_lov=>'.'||wwv_flow_imp.id(13149840134168038)||'.'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'All'
,p_lov_null_value=>'0'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48757415125033336)
,p_name=>'P20005_STATUS'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(48743304305033316)
,p_item_default=>'0'
,p_pre_element_text=>'Status'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'STATUS_SCHOLARSHIP'
,p_lov=>'.'||wwv_flow_imp.id(13153015369193856)||'.'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'All'
,p_lov_null_value=>'0'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_colspan=>4
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(48757631322033338)
,p_name=>'P20005_DATE_FROM'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(48743304305033316)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TRUNC(SYSDATE, ''YEAR'') AS first_day_of_current_year FROM DUAL;',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Created Date From'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
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
 p_id=>wwv_flow_imp.id(48757742835033339)
,p_name=>'P20005_DATE_TO'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(48743304305033316)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_CHAR(SYSDATE, ''MM/DD/YYYY'') AS formatted_date FROM DUAL;',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'To'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>4
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
 p_id=>wwv_flow_imp.id(25095911225455616)
,p_name=>'Click search'
,p_event_sequence=>10
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(22298276066852343)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(25096045445455617)
,p_event_id=>wwv_flow_imp.id(25095911225455616)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Refresh'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(52610098335132028)
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
