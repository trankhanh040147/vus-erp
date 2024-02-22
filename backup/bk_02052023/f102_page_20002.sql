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
--   Date and Time:   19:21 Sunday February 4, 2024
--   Exported By:     ERP
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 20002
--   Manifest End
--   Version:         23.2.3
--   Instance ID:     7949320442804181
--

begin
null;
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
,p_javascript_file_urls=>'https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/js/custom-file-upload.js'
,p_css_file_urls=>'https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/css/custom-file-upload.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'#P20002_REASON_REQUEST, #P20002_NOTE{',
'    height: 80px !important;',
'}',
'/* -------------------------- */',
'/* .btn-delete{',
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
'} */',
'/* -------------------------- */',
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
'}',
'    span.u-Processing, span.u-Processing-spinner{',
'        display: none !important;',
'    }',
'#P20002_ATTACHMENT_input {',
'    display: none !important;',
'}',
'',
'/* auto wrap cho header */',
'.a-GV-header .a-GV-headerLabel {',
'    white-space: normal;',
'    text-align: center;',
'}',
'',
'/* auto wrap cho cell */',
'.a-GV-cell {',
'    white-space: normal !important;',
'    /* text-align: center !important; */',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'21'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20240204192010'
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
'        if($(''.delete-item'').length === 0) {',
'            // set P20002_ATTACHMENT = null',
'            $(''#P20002_ATTACHMENT'').val(null);',
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
'--   where REQUEST_ID = :P20002_REQUEST_ID;',
'  where wd.REQUEST_ID = (select ID from EMP_REQUESTS er where er.REQUEST_DETAIL_ID = :P20002_REQUEST_ID and lower(:P20002_FEATURE) = lower(REQUEST_TYPE))'))
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
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
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
 p_id=>wwv_flow_imp.id(31395734591418125)
,p_name=>'WD_MODIFIED_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WD_MODIFIED_DATE'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Modified Date'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>80
,p_value_alignment=>'LEFT'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
,p_format_mask=>'DD/MM/YYYY'
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
 p_id=>wwv_flow_imp.id(49768033984949527)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_NUMBER_FIELD'
,p_heading_alignment=>'RIGHT'
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
,p_is_primary_key=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(49768318237949530)
,p_name=>'WD_COMMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'WD_COMMENT'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Comment'
,p_heading_alignment=>'CENTER'
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
,p_heading=>'Modified By'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
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
 p_id=>wwv_flow_imp.id(8214563103074944)
,p_view_id=>wwv_flow_imp.id(62398869921494380)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(31395734591418125)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(22699805536073070)
,p_view_id=>wwv_flow_imp.id(62398869921494380)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(22027154816485923)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>181
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(49773991105951344)
,p_view_id=>wwv_flow_imp.id(62398869921494380)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(49768033984949527)
,p_is_visible=>false
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(49776689636951354)
,p_view_id=>wwv_flow_imp.id(62398869921494380)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(49768318237949530)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>306
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
,p_width=>191
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
'       ah.ATTACHMENT_DATE,',
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
,p_session_state_data_type=>'VARCHAR2'
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
 p_id=>wwv_flow_imp.id(31395835888418126)
,p_name=>'ATTACHMENT_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATTACHMENT_DATE'
,p_data_type=>'DATE'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Attachment Date'
,p_heading_alignment=>'LEFT'
,p_display_sequence=>50
,p_value_alignment=>'LEFT'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'NONE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
,p_format_mask=>'DD/MM/YYYY'
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
 p_id=>wwv_flow_imp.id(49776088753977771)
,p_name=>'FULL_NAME'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'FULL_NAME'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXTAREA'
,p_heading=>'Attachment By'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>30
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
 p_id=>wwv_flow_imp.id(8215462416074953)
,p_view_id=>wwv_flow_imp.id(62415679158602950)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(31395835888418126)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(25700451944094831)
,p_view_id=>wwv_flow_imp.id(62415679158602950)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(25096308487455620)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>1029
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
 p_id=>wwv_flow_imp.id(50116780222259286)
,p_view_id=>wwv_flow_imp.id(62415679158602950)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(49776088753977771)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>197
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
,p_cSize=>50
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
,p_cSize=>50
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
'DECLARE',
'    temp NVARCHAR2(20);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       select TO_CHAR(emp.START_DATE, ''DD/MM/YYYY'') into temp ',
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
,p_format_mask=>'DD/MM/YYYY'
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
'DECLARE',
'    temp NVARCHAR2(20);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'    --    select REQUESTER_LEVEL into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       select TO_CHAR(emp.TERMINATE_DATE, ''DD/MM/YYYY'') into temp ',
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
,p_format_mask=>'DD/MM/YYYY'
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
,p_cSize=>50
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
,p_cSize=>50
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
'       select ID_COREEDU_PROMOTION into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    -- ELSE',
'    --   RETURN null;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Discount rate'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ''Voucher '' || cd.DISCOUNT_RATE || ''%'' AS DISPLAY_VALUE, cd.ID AS RETURN_VALUE ',
'FROM COREEDU_PROMOTION cd',
'where :P20002_PROGRAM = cd.PROGRAM ',
'ORDER BY DISCOUNT_RATE'))
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
end;
/
begin
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(34180961260087265)
,p_name=>'P20002_EFFECTIVE_DATE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(34169968023087192)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp NVARCHAR2(20);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select TO_CHAR(EFFECTIVE_DATE, ''DD/MM/YYYY'') into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Effective date'
,p_format_mask=>'DD/MM/YYYY'
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
 p_id=>wwv_flow_imp.id(34181071617087266)
,p_name=>'P20002_EXPIRATION_DATE'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(34169968023087192)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp NVARCHAR2(20);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select TO_CHAR(EXPIRATION_DATE, ''DD/MM/YYYY'') into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Expiration date'
,p_format_mask=>'DD/MM/YYYY'
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
'    temp NVARCHAR2(20);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select TO_CHAR(APPROVED_DATE, ''DD/MM/YYYY'') into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'Approved date'
,p_format_mask=>'DD/MM/YYYY'
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
,p_cSize=>50
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
,p_cSize=>50
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
'    temp NVARCHAR2(20);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'    --    select to_char(RECIPIENT_DOB, ''DD/MM/YYYY'') into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       select TO_CHAR(RECIPIENT_DOB, ''DD/MM/YYYY'') into temp from SCHOLARSHIP_REQUEST where :P20002_REQUEST_ID = ID;',
'       RETURN temp;',
'    ELSE',
'      RETURN NULL;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>'DOB'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'STATIC'
,p_attribute_04=>'1/1/1900'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'N'
,p_attribute_12=>'MONTH-PICKER:YEAR-PICKER:TODAY-BUTTON'
,p_attribute_13=>'VISIBLE'
,p_attribute_15=>'FOCUS'
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
,p_cSize=>1000
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
,p_cSize=>1000
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
'      RETURN null;',
'    END IF;',
'END;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_pre_element_text=>wwv_flow_string.join(wwv_flow_t_varchar2(
'Replacement for',
'(if any)'))
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT sr.RECIPIENT_NAME || '' - '' || sr.RECIPIENT_DOB as display_value, sr.VOUCHER_CODE as return_value',
'FROM SCHOLARSHIP_REQUEST sr',
'WHERE sr.REQUESTER_CODE = :APP_EMP_CODE',
'AND sr.RECIPIENT_TYPE = ''B''',
'AND sr.RECIPIENT_RELATIONSHIP != 1',
'AND sr.STATUS = 3',
'AND sr.IS_REPLACED = 0;'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'No replacement'
,p_cSize=>30
,p_grid_column_css_classes=>'P20002_REPLACEMENT'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
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
'    temp NVARCHAR2(20);',
'BEGIN',
'    IF :P20002_REQUEST_ID IS NOT NULL THEN',
'       select TO_CHAR(RECIPIENT_EXPIRATION_DATE_REPLACEMENT, ''DD/MM/YYYY'')',
'       into temp ',
'       from SCHOLARSHIP_REQUEST ',
'       where :P20002_REQUEST_ID = ID;',
'       ',
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
,p_format_mask=>'DD/MM/YYYY'
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
,p_cSize=>50
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
,p_item_default=>'Scholarship'
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
,p_display_when=>'P20002_REQUEST_NAME'
,p_display_when2=>'disable'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
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
,p_validation_type=>'ITEM_NOT_NULL_OR_ZERO'
,p_error_message=>'Please select a valid value!'
,p_always_execute=>'Y'
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
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
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
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
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
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
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
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
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
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
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
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
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
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
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
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
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_associated_item=>wwv_flow_imp.id(34264557413617269)
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
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
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
'    -- IF :P20002_URL_FILES IS NULL THEN',
'    IF :P20002_ATTACHMENT IS NULL THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''EXPIRATION_DATE'' ch\01B0a \0111\01B0\1EE3c \0111i\1EC1n'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''EXPIRATION_DATE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''D'' v\00E0 ''C'''),
'  END IF;',
'END;',
'',
'-- begin',
'-- return true;',
'-- end;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please attach a file to verify the relationship.'
,p_always_execute=>'Y'
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_associated_item=>wwv_flow_imp.id(25095239917455609)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_validation_comment=>unistr('B\1EAFt bu\1ED9c \0111\00EDnh k\00E8m file ch\1EE9ng minh quan h\1EC7.')
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21748400423265923)
,p_validation_name=>'btn_save_submit_check_P20002_DISCOUNT_RATE_CD'
,p_validation_sequence=>130
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20002_SCHOLARSHIP_RECIPIENT = ''C'' or :P20002_SCHOLARSHIP_RECIPIENT = ''D'' THEN',
'    IF :P20002_DISCOUNT_RATE IS NULL or :P20002_DISCOUNT_RATE = '''' THEN',
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
,p_validation_condition=>':REQUEST IN (''T1_UPDATE'', ''T1_SAVE'', ''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_associated_item=>wwv_flow_imp.id(34180691841087262)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(31394219347418110)
,p_validation_name=>'btn_save_submit_check_P20002_DISCOUNT_RATE_AB'
,p_validation_sequence=>140
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'  IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' or :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN',
'    IF :P20002_DISCOUNT_RATE IS NULL or :P20002_DISCOUNT_RATE = '''' THEN',
unistr('      RETURN FALSE; -- Tr\1EA3 v\1EC1 FALSE n\1EBFu ''DISCOUNT_RATE'' kh\00F4ng c\00F3 config ph\00F9 h\1EE3p'),
'    ELSE',
unistr('      RETURN TRUE; -- Tr\1EA3 v\1EC1 TRUE n\1EBFu ''DISCOUNT_RATE'' \0111\00E3 \0111\01B0\1EE3c \0111i\1EC1n'),
'    END IF;',
'  ELSE',
unistr('    RETURN TRUE; -- B\1ECF qua ki\1EC3m tra n\1EBFu ''SCHOLARSHIP_RECIPIENT'' kh\00F4ng c\00F3 gi\00E1 tr\1ECB ''A'' v\00E0 ''B'''),
'  END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'You cannot create a scholarship. Please contact the HRA department for more information!'
,p_always_execute=>'Y'
,p_validation_condition=>':REQUEST IN (''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_associated_item=>wwv_flow_imp.id(34180691841087262)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(31395165540418119)
,p_validation_name=>'btn_save_submit_check_quantity'
,p_validation_sequence=>150
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    v_quantity NUMBER;',
'    v_count_req NUMBER;',
'    v_start_date DATE;',
'    v_dataarea NVARCHAR2(50);',
'    v_level_id NVARCHAR2(50);',
'    v_level NUMBER;',
'    v_today DATE := SYSDATE;',
'    v_seniority_months NUMBER;',
'BEGIN',
'    IF :P20002_DISCOUNT_RATE IS NULL OR :P20002_DISCOUNT_RATE = '''' THEN',
unistr('        RETURN TRUE; -- tr\01B0\1EDDng h\1EE3p kh\00F4ng th\1EC3 t\1EA1o \0111\01A1n'),
'    ELSIF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN ',
unistr('        -- L\1EA5y th\00F4ng tin t\1EEB b\1EA3ng EMPLOYEES'),
'        SELECT e.START_DATE, e.DATAAREA, e.LEVEL_ID',
'        INTO v_start_date, v_dataarea, v_level_id',
'        FROM EMPLOYEES e',
'        WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
unistr('        -- L\1EA5y c\1EA5p b\1EADc t\1EEB b\1EA3ng LIST_LEVEL'),
'        SELECT l.ID INTO v_level FROM LIST_LEVEL l WHERE l.DATA_AREA = v_dataarea AND l.LEVEL_CODE = v_level_id;',
'',
unistr('        -- T\00EDnh th\00E2m ni\00EAn c\1EE7a nh\00E2n vi\00EAn'),
'        v_seniority_months := (v_today - v_start_date + 1) / 365 * 12;',
'',
unistr('        -- L\1EA5y QUANTITY c\1EE7a ch\00EDnh s\00E1ch \0111\1EA7u ti\00EAn ph\00F9 h\1EE3p v\1EDBi req \0111ang t\1EA1o'),
'        SELECT ds.QUANTITY',
'        INTO v_quantity',
'        FROM SCHOLARSHIP_CONFIG s',
'        JOIN SCHOLARSHIP_CONFIG_DETAIL ds ON s.CONFIG_FK = ds.CONFIG_FK',
'        WHERE s.RECIPIENT_TYPE = :P20002_SCHOLARSHIP_RECIPIENT',
'            AND s.EFFECTIVE_DATE <= v_today',
'            AND (s.EXPIRATION_DATE IS NULL OR s.EXPIRATION_DATE >= v_today)',
'            AND ds.PROGRAM = :P20002_PROGRAM',
'            AND ds.SENIORITY_FROM <= v_seniority_months',
'            AND ds.SENIORITY_TO >= v_seniority_months',
'            AND INSTR('':'' || ds.SD_LEVEL || '':'', '':'' || TO_CHAR(v_level) || '':'') > 0',
'            AND ROWNUM = 1;',
'',
unistr('        -- \0110\1EBFm s\1ED1 scholarship_request ph\00F9 h\1EE3p v\1EDBi ch\00EDnh s\00E1ch l\1EA5y \1EDF ph\00EDa tr\00EAn v\00E0 \1EDF tr\1EA1ng th\00E1i: submitted, in-review, active'),
'        SELECT COUNT(*)',
'        INTO v_count_req',
'        FROM SCHOLARSHIP_REQUEST sr',
'        JOIN EMPLOYEES e ON e.EMPLOYEE_CODE = sr.REQUESTER_CODE',
'        WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE',
'            AND sr.RECIPIENT_TYPE = :P20002_SCHOLARSHIP_RECIPIENT',
'            AND sr.PROGRAM = :P20002_PROGRAM',
'            AND sr.STATUS IN (2, 3, 6);',
'',
'        IF v_count_req < v_quantity THEN',
'            RETURN TRUE;',
'        ELSIF :P20002_SCHOLARSHIP_RECIPIENT = ''B'' AND v_count_req = v_quantity AND :P20002_REPLACEMENT IS NOT NULL THEN',
'            RETURN TRUE;',
'        ELSE',
'            RETURN FALSE;',
'        END IF;',
'    ELSE',
'        RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'You cannot create a scholarship. Please contact the HRA department for more information!'
,p_always_execute=>'Y'
,p_validation_condition=>':REQUEST IN (''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_associated_item=>wwv_flow_imp.id(34180691841087262)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_validation_comment=>unistr('B\1EAFt bu\1ED9c \0111\00EDnh k\00E8m file ch\1EE9ng minh quan h\1EC7.')
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(31395065365418118)
,p_validation_name=>'btn_save_submit_check_replacement_when_B_and_max_quantity'
,p_validation_sequence=>160
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    v_quantity NUMBER;',
'    v_count_req NUMBER;',
'    v_start_date DATE;',
'    v_dataarea NVARCHAR2(50);',
'    v_level_id NVARCHAR2(50);',
'    v_level NUMBER;',
'    v_today DATE := SYSDATE;',
'    v_seniority_months NUMBER;',
'BEGIN',
'    IF :P20002_DISCOUNT_RATE IS NULL OR :P20002_DISCOUNT_RATE = '''' THEN',
unistr('        RETURN TRUE;    -- tr\01B0\1EDDng h\1EE3p kh\00F4ng th\1EC3 t\1EA1o \0111\01A1n => kh\00F4ng c\1EA7n ki\1EC3m tra replacement'),
'    ELSE',
'        IF :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN ',
unistr('            -- L\1EA5y th\00F4ng tin t\1EEB b\1EA3ng EMPLOYEES'),
'            SELECT e.START_DATE, e.DATAAREA, e.LEVEL_ID',
'            INTO v_start_date, v_dataarea, v_level_id',
'            FROM EMPLOYEES e',
'            WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
unistr('            -- L\1EA5y c\1EA5p b\1EADc t\1EEB b\1EA3ng LIST_LEVEL'),
'            SELECT l.ID INTO v_level FROM LIST_LEVEL l WHERE l.DATA_AREA = v_dataarea AND l.LEVEL_CODE = v_level_id;',
'',
unistr('            -- T\00EDnh th\00E2m ni\00EAn c\1EE7a nh\00E2n vi\00EAn'),
'            v_seniority_months := (v_today - v_start_date + 1) / 365 * 12;',
'',
unistr('            -- L\1EA5y QUANTITY c\1EE7a ch\00EDnh s\00E1ch \0111\1EA7u ti\00EAn ph\00F9 h\1EE3p v\1EDBi req \0111ang t\1EA1o'),
'            SELECT ds.QUANTITY',
'            INTO v_quantity',
'            FROM SCHOLARSHIP_CONFIG s',
'            JOIN SCHOLARSHIP_CONFIG_DETAIL ds ON s.CONFIG_FK = ds.CONFIG_FK',
'            WHERE s.RECIPIENT_TYPE = :P20002_SCHOLARSHIP_RECIPIENT',
'                AND s.EFFECTIVE_DATE <= v_today',
'                AND (s.EXPIRATION_DATE IS NULL OR s.EXPIRATION_DATE >= v_today)',
'                AND ds.PROGRAM = :P20002_PROGRAM',
'                AND ds.SENIORITY_FROM <= v_seniority_months',
'                AND ds.SENIORITY_TO >= v_seniority_months',
'                AND INSTR('':'' || ds.SD_LEVEL || '':'', '':'' || TO_CHAR(v_level) || '':'') > 0',
'                AND ROWNUM = 1;',
'',
unistr('            -- \0110\1EBFm s\1ED1 scholarship_request ph\00F9 h\1EE3p v\1EDBi ch\00EDnh s\00E1ch l\1EA5y \1EDF ph\00EDa tr\00EAn v\00E0 \1EDF tr\1EA1ng th\00E1i: submitted, in-review, active'),
'            SELECT COUNT(*)',
'            INTO v_count_req',
'            FROM SCHOLARSHIP_REQUEST sr',
'            JOIN EMPLOYEES e ON e.EMPLOYEE_CODE = sr.REQUESTER_CODE',
'            WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE',
'                AND sr.RECIPIENT_TYPE = :P20002_SCHOLARSHIP_RECIPIENT',
'                AND sr.PROGRAM = :P20002_PROGRAM',
'                AND sr.STATUS IN (2, 3, 6);',
'',
'            IF v_count_req = v_quantity AND (:P20002_REPLACEMENT IS NULL OR :P20002_REPLACEMENT = '''') THEN',
'                RETURN FALSE;',
'            ELSE',
'                RETURN TRUE;',
'            END IF;',
'        ELSE',
'            RETURN TRUE;',
'        END IF;',
'    END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please select replacement!'
,p_always_execute=>'Y'
,p_validation_condition=>':REQUEST IN (''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_associated_item=>wwv_flow_imp.id(34270718492617284)
,p_error_display_location=>'INLINE_WITH_FIELD'
,p_validation_comment=>unistr('B\1EAFt bu\1ED9c \0111\00EDnh k\00E8m file ch\1EE9ng minh quan h\1EC7.')
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(31395204086418120)
,p_validation_name=>'btn_submit_check_voucher_replacement_is replaced?'
,p_validation_sequence=>180
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    v_is_replaced NUMBER;',
'BEGIN',
'    IF :P20002_DISCOUNT_RATE IS NULL OR :P20002_DISCOUNT_RATE = '''' THEN',
unistr('        RETURN TRUE; -- kh\00F4ng t\1EA1o \0111\01B0\1EE3c \0111\01A1n n\00EAn kh\00F4ng c\1EA7n ki\1EC3m tra'),
'    ELSIF :P20002_SCHOLARSHIP_RECIPIENT = ''B'' AND :P20002_REPLACEMENT != '''' THEN',
'        SELECT IS_REPLACED',
'        INTO v_is_replaced',
'        FROM SCHOLARSHIP_REQUEST sr',
'        WHERE :P20002_REPLACEMENT = sr.VOUCHER_CODE;',
'        ',
'        IF (v_is_replaced = 1) THEN',
'            RETURN FALSE;',
'        ELSE',
'            RETURN TRUE;',
'        END IF;',
'    ELSE',
'        RETURN TRUE;',
'    END IF;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'The voucher code you selected to replace is already in use. Please choose another voucher code!'
,p_always_execute=>'Y'
,p_validation_condition=>':REQUEST IN (''T1_SUBMIT'', ''T1_SAVE_SUBMIT'')'
,p_validation_condition2=>'PLSQL'
,p_validation_condition_type=>'EXPRESSION'
,p_associated_item=>wwv_flow_imp.id(34270718492617284)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
,p_validation_comment=>unistr('B\1EAFt bu\1ED9c \0111\00EDnh k\00E8m file ch\1EE9ng minh quan h\1EC7.')
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(7768816486459593)
,p_name=>'auto_close_noti'
,p_event_sequence=>10
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(7769717274459604)
,p_event_id=>wwv_flow_imp.id(7768816486459593)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('// Ch\1EDD cho \0111\1EBFn khi document ho\00E0n t\1EA5t vi\1EC7c t\1EA3i'),
'apex.jQuery(document).ready(function(){',
unistr('  // Ki\1EC3m tra sau m\1ED7i 500ms xem th\00F4ng b\00E1o \0111\00E3 s\1EB5n s\00E0ng ch\01B0a'),
'  var checkExist = setInterval(function() {',
'     if (apex.jQuery(''.t-Alert--success'').length) {',
'        // console.log("Success message exists");',
unistr('        // Khi th\00F4ng b\00E1o xu\1EA5t hi\1EC7n, \0111\1EB7t timeout \0111\1EC3 \1EA9n n\00F3 sau 3-5 gi\00E2y'),
'        setTimeout(function(){',
'            apex.jQuery(''.t-Alert--success'').fadeOut(''slow'');',
unistr('        }, 5000); // \0110\1ED5i 3000 (3 gi\00E2y) th\00E0nh 5000 \0111\1EC3 l\00E0m 5 gi\00E2y n\1EBFu c\1EA7n'),
unistr('        clearInterval(checkExist); // X\00F3a interval sau khi \0111\00E3 t\00ECm th\1EA5y v\00E0 x\1EED l\00FD th\00F4ng b\00E1o'),
'     }',
unistr('  }, 500); // Ki\1EC3m tra m\1ED7i n\1EEDa gi\00E2y'),
'});',
''))
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(7769287362459603)
,p_event_id=>wwv_flow_imp.id(7768816486459593)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
unistr('// Ch\1EDD cho \0111\1EBFn khi document ho\00E0n t\1EA5t vi\1EC7c t\1EA3i'),
'apex.jQuery(document).ready(function(){',
unistr('  // Ki\1EC3m tra sau m\1ED7i 500ms xem th\00F4ng b\00E1o \0111\00E3 s\1EB5n s\00E0ng ch\01B0a'),
'  var checkExist = setInterval(function() {',
'     if (apex.jQuery(''.t-Alert--warning'').length) {',
'        // console.log("Success message exists");',
unistr('        // Khi th\00F4ng b\00E1o xu\1EA5t hi\1EC7n, \0111\1EB7t timeout \0111\1EC3 \1EA9n n\00F3 sau 3-5 gi\00E2y'),
'        setTimeout(function(){',
'            apex.jQuery(''.t-Alert--warning'').fadeOut(''slow'');',
unistr('        }, 3000); // \0110\1ED5i 3000 (3 gi\00E2y) th\00E0nh 5000 \0111\1EC3 l\00E0m 5 gi\00E2y n\1EBFu c\1EA7n'),
unistr('        clearInterval(checkExist); // X\00F3a interval sau khi \0111\00E3 t\00ECm th\1EA5y v\00E0 x\1EED l\00FD th\00F4ng b\00E1o'),
'     }',
unistr('  }, 500); // Ki\1EC3m tra m\1ED7i n\1EEDa gi\00E2y'),
'});',
''))
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
end;
/
begin
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
,p_name=>'Change SCHOLARSHIP_RECIPIENT'
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
,p_name=>'set_null'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_PROGRAM,P20002_RECIPIENT_PHONE,P20002_CAMPUS,P20002_REPLACEMENT,P20002_NOTE,P20002_EXPIRATION_DATE,P20002_PARTNER_NAME,P20002_PARTNER_PHONE,P20002_TITLE,P20002_PARTNER_DEPARTMENT,P20002_FIELD,P20002_REASON_REQUEST,P20002_WORKPLACE,P20002_VOUCH'
||'ER_CODE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'NOT_NULL'
,p_client_condition_element=>'P20002_SCHOLARSHIP_RECIPIENT'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(31393941355418107)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'P20002_REQUEST_NAME_AB'
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
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21425440973215921)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_name=>'P20002_REQUEST_NAME'
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
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20143773181893613)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'N'
,p_name=>'P20002_EMPLOYEE_CODE'
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
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20144104869893617)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'N'
,p_name=>'P20002_DEPARTMENT_CODE'
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
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21428288207215949)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_name=>'P20002_DEPARTMENT'
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
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20143944352893615)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_name=>'P20002_LEVEL'
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
end;
/
begin
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20146698394893642)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_name=>'P20002_START_DATE'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_START_DATE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp NVARCHAR2(10);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' ',
'    THEN',
'        select ',
'            -- e.START_DATE ',
'            CASE',
'                WHEN e.START_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN NULL',
'                ELSE TO_CHAR(e.START_DATE, ''DD/MM/YYYY'')',
'            END',
'        into temp ',
'        from EMPLOYEES e ',
'        where :APP_USER_NAME = e.USER_NAME;',
'        ',
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
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21423792025215904)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'N'
,p_name=>'P20002_TERMINATION_DATE'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_TERMINATION_DATE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp NVARCHAR2(10);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' ',
'    THEN',
'        select ',
'            -- e.TERMINATE_DATE ',
'            CASE',
'                WHEN e.TERMINATE_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN NULL',
'                ELSE TO_CHAR(e.TERMINATE_DATE, ''DD/MM/YYYY'')',
'            END',
'        into temp ',
'        from EMPLOYEES e ',
'        where :APP_USER_NAME = e.USER_NAME;',
'        ',
'        return temp;',
'    ELSE',
'        return null;',
'    END IF;',
'END;',
'',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_USER_NAME'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21423967636215906)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'N'
,p_name=>'P20002_RECIPIENT_NAME'
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
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21424524020215912)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>110
,p_execute_on_page_init=>'N'
,p_name=>'P20002_RECIPIENT_DOB'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_RECIPIENT_DOB'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp NVARCHAR2(10);',
'BEGIN',
'    IF :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' ',
'    THEN',
'        select ',
'            -- e.DOB ',
'            CASE',
'                WHEN e.DOB = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN NULL',
'                ELSE TO_CHAR(e.DOB, ''DD/MM/YYYY'')',
'            END',
'        into temp ',
'        from EMPLOYEES e ',
'        where :APP_USER_NAME = e.USER_NAME;',
'        ',
'        return temp;',
'    ELSE',
'        return null;',
'    END IF;',
'END;',
'',
''))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID,APP_USER_NAME'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21424767256215914)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>120
,p_execute_on_page_init=>'N'
,p_name=>'P20002_RELATIONSHIP'
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
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21424911163215916)
,p_event_id=>wwv_flow_imp.id(21343266650734608)
,p_event_result=>'TRUE'
,p_action_sequence=>130
,p_execute_on_page_init=>'N'
,p_name=>'P20002_EFFECTIVE_DATE'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_EFFECTIVE_DATE'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select to_char(SYSDATE, ''DD/MM/YYYY'') from DUAL'
,p_attribute_07=>'P20002_REQUEST_ID'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21336256037734603)
,p_name=>'set_value_when_request_name_change'
,p_event_sequence=>90
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
,p_execute_on_page_init=>'N'
,p_name=>'P20002_DEPARTMENT_CODE'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_DEPARTMENT_CODE'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select emp.DEPARTMENT_ID from EMPLOYEES emp where :P20002_REQUEST_NAME = emp.EMPLOYEE_CODE;'
,p_attribute_07=>'P20002_REQUEST_NAME,P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21337255240734604)
,p_event_id=>wwv_flow_imp.id(21336256037734603)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_name=>'P20002_DEPARTMENT'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_DEPARTMENT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>'select emp.DEPARTMENT_NAME from EMPLOYEES emp where :P20002_REQUEST_NAME = emp.EMPLOYEE_CODE;'
,p_attribute_07=>'P20002_REQUEST_NAME,P20002_SCHOLARSHIP_RECIPIENT,P20002_REQUEST_ID'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21341866644734606)
,p_name=>'change P20002_REPLACEMENT'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_REPLACEMENT'
,p_condition_element=>'P20002_REPLACEMENT'
,p_triggering_condition_type=>'NOT_NULL'
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
,p_name=>'P20002_VOUCHER_CODE_REPLACEMENT'
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
,p_name=>'P20002_EXPIRATION_DATE_REPLACEMENT'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_EXPIRATION_DATE_REPLACEMENT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- select EXPIRATION_DATE',
'-- from SCHOLARSHIP_REQUEST',
'-- where VOUCHER_CODE = :P20002_REPLACEMENT;',
'SELECT TO_CHAR(TO_DATE(:P20002_EFFECTIVE_DATE, ''DD/MM/YYYY'') - 1, ''DD/MM/YYYY'')',
'FROM DUAL;',
''))
,p_attribute_07=>'P20002_EFFECTIVE_DATE'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(27194885880149401)
,p_name=>'Change P20002_EFFECTIVE_DATE'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_EFFECTIVE_DATE'
,p_condition_element=>'P20002_REPLACEMENT'
,p_triggering_condition_type=>'NOT_NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(27194954024149402)
,p_event_id=>wwv_flow_imp.id(27194885880149401)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'P20002_EXPIRATION_DATE_REPLACEMENT'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_EXPIRATION_DATE_REPLACEMENT'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT TO_CHAR(TO_DATE(:P20002_EFFECTIVE_DATE, ''DD/MM/YYYY'') - 1, ''DD/MM/YYYY'')',
'FROM DUAL;'))
,p_attribute_07=>'P20002_EFFECTIVE_DATE'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(27894836678702546)
,p_name=>'when_value_of_replacement_is_null'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_REPLACEMENT'
,p_condition_element=>'P20002_REPLACEMENT'
,p_triggering_condition_type=>'NULL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(27894951887702547)
,p_event_id=>wwv_flow_imp.id(27894836678702546)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'set_null'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_VOUCHER_CODE_REPLACEMENT,P20002_EXPIRATION_DATE_REPLACEMENT'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(22026603696485918)
,p_name=>'Change P20002_SCHOLARSHIP_RECIPIENT,P20002_PROGRAM'
,p_event_sequence=>150
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_PROGRAM'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(22026794282485919)
,p_event_id=>wwv_flow_imp.id(22026603696485918)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'P20002_DISCOUNT_RATE'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_DISCOUNT_RATE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(20);',
'BEGIN',
'    if (:P20002_SCHOLARSHIP_RECIPIENT like ''D'') then',
'        temp := :P20002_REQUEST_NAME;',
'    else',
'        temp := :APP_EMP_CODE;',
'    end if;',
'',
'    RETURN get_discount_rate(:P20002_SCHOLARSHIP_RECIPIENT, :P20002_PROGRAM, temp);',
'END;'))
,p_attribute_07=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_PROGRAM,APP_EMP_CODE,P20002_REQUEST_NAME'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'NOT_NULL'
,p_client_condition_element=>'P20002_PROGRAM'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(31394608117418114)
,p_event_id=>wwv_flow_imp.id(22026603696485918)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    temp nvarchar2(20);',
'BEGIN',
'    if (:P20002_SCHOLARSHIP_RECIPIENT like ''D'') then',
'        temp := :P20002_REQUEST_NAME;',
'    else',
'        temp := :APP_EMP_CODE;',
'    end if;',
'',
'    -- RETURN get_discount_rate(:P20002_SCHOLARSHIP_RECIPIENT, :P20002_PROGRAM, temp);',
'    :P20002_DISCOUNT_RATE := get_discount_rate(:P20002_SCHOLARSHIP_RECIPIENT, :P20002_PROGRAM, temp);',
'END;'))
,p_attribute_02=>'P20002_SCHOLARSHIP_RECIPIENT,P20002_PROGRAM,APP_EMP_CODE,P20002_REQUEST_NAME'
,p_attribute_03=>'P20002_DISCOUNT_RATE'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_SCHOLARSHIP_RECIPIENT") !== null && $v("P20002_SCHOLARSHIP_RECIPIENT") !== ""',
'&& $v("P20002_PROGRAM") !== null && $v("P20002_PROGRAM") !== ""'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(21750343925265942)
,p_name=>'voucher_code_when_create'
,p_event_sequence=>200
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P20002_EFFECTIVE_DATE,P20002_EXPIRATION_DATE,P20002_SCHOLARSHIP_RECIPIENT,P20002_DISCOUNT_RATE,P20002_PROGRAM,P20002_DEPARTMENT_CODE'
,p_triggering_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_expression=>'($v("P20002_REQUEST_ID") === null || $v("P20002_REQUEST_ID") === "")'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(21750440772265943)
,p_event_id=>wwv_flow_imp.id(21750343925265942)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P20002_VOUCHER_CODE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    x1 NVARCHAR2(100);',
'    x2 NUMBER;',
'    x3 NVARCHAR2(100);',
'    x4 NVARCHAR2(100);',
'    x5 NUMBER;',
'BEGIN',
'',
'    IF :P20002_SCHOLARSHIP_RECIPIENT LIKE ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT LIKE ''B'' THEN',
'        x4 := :P20002_EMPLOYEE_CODE;',
'',
'        SELECT MAX(TO_NUMBER(SUBSTR(sr.VOUCHER_CODE, INSTR(sr.VOUCHER_CODE, sr.REQUESTER_CODE) + LENGTH(sr.REQUESTER_CODE) + 1)))',
'        INTO x5',
'        FROM SCHOLARSHIP_REQUEST sr',
'        WHERE sr.REQUESTER_CODE = :P20002_EMPLOYEE_CODE',
'        AND (sr.RECIPIENT_TYPE LIKE ''A'' OR sr.RECIPIENT_TYPE LIKE ''B'');',
'',
'    ELSIF :P20002_SCHOLARSHIP_RECIPIENT LIKE ''C'' OR :P20002_SCHOLARSHIP_RECIPIENT LIKE ''D'' THEN',
'        x4 := :P20002_DEPARTMENT_CODE;',
'        ',
'        SELECT MAX(TO_NUMBER(SUBSTR(sr.VOUCHER_CODE, INSTR(sr.VOUCHER_CODE, sr.REQUESTER_DEPARTMENT_CODE) + LENGTH(sr.REQUESTER_DEPARTMENT_CODE) + 1)))',
'        INTO x5',
'        FROM SCHOLARSHIP_REQUEST sr',
'        WHERE sr.REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE',
'        AND (sr.RECIPIENT_TYPE LIKE ''C'' OR sr.RECIPIENT_TYPE LIKE ''D'');',
'    END IF;',
'',
'    IF :P20002_PROGRAM IS NOT NULL THEN',
'        x3 := :P20002_PROGRAM;',
'    END IF;',
'',
'    IF :P20002_DISCOUNT_RATE IS NOT NULL THEN',
'        SELECT cp.DISCOUNT_RATE',
'        INTO x2',
'        FROM COREEDU_PROMOTION cp',
'        WHERE cp.ID = :P20002_DISCOUNT_RATE;',
'    END IF;',
'',
'    SELECT TO_CHAR(TO_DATE(:P20002_EFFECTIVE_DATE, ''DD/MM/YYYY''), ''YY'') || ',
'           COALESCE(TO_CHAR(TO_DATE(:P20002_EXPIRATION_DATE, ''DD/MM/YYYY''), ''MM''), ''00'')',
'    INTO x1',
'    FROM DUAL;',
'    -- SELECT TO_CHAR(TO_DATE(:P20002_EFFECTIVE_DATE, ''MM/DD/YYYY''), ''YY'') || ',
'    --        COALESCE(TO_CHAR(TO_DATE(:P20002_EXPIRATION_DATE, ''MM/DD/YYYY''), ''MM''), ''00'')',
'    -- INTO x1',
'    -- FROM DUAL;',
'    ',
'    RETURN x1 || ''-'' || :P20002_SCHOLARSHIP_RECIPIENT || LPAD(TO_CHAR(x2), 3, ''0'') || ''-'' || x3 || ''-'' || x4 || ''-'' || TO_CHAR(COALESCE(x5, 0) + 1);',
'END;',
'-- DECLARE',
'--     temp nvarchar2(20);',
'-- BEGIN',
'--     if (:P20002_SCHOLARSHIP_RECIPIENT like ''D'') then',
'--         temp := :P20002_REQUEST_NAME;',
'--     else',
'--         temp := :P20002_EMPLOYEE_CODE;',
'--     end if;',
'--     DBMS_OUTPUT.PUT_LINE(calculate_scholarship_code(:P20002_SCHOLARSHIP_RECIPIENT, temp, :P20002_PROGRAM, :P20002_DISCOUNT_RATE, :P20002_EFFECTIVE_DATE, :P20002_EXPIRATION_DATE));',
'-- END;'))
,p_attribute_07=>'P20002_REQUEST_ID,P20002_EFFECTIVE_DATE,P20002_EXPIRATION_DATE,P20002_SCHOLARSHIP_RECIPIENT,P20002_DISCOUNT_RATE,P20002_PROGRAM,P20002_EMPLOYEE_CODE,P20002_DEPARTMENT_CODE'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_SCHOLARSHIP_RECIPIENT") !== null && $v("P20002_SCHOLARSHIP_RECIPIENT") !== ""',
'&& $v("P20002_PROGRAM") !== null && $v("P20002_PROGRAM") !== ""',
'&& $v("P20002_EFFECTIVE_DATE") !== null && $v("P20002_EFFECTIVE_DATE") !== ""',
'&& $v("P20002_DISCOUNT_RATE") !== null && $v("P20002_DISCOUNT_RATE") !== ""'))
,p_server_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_server_condition_expr1=>'disable'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(31394536193418113)
,p_event_id=>wwv_flow_imp.id(21750343925265942)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    x1 NVARCHAR2(100);',
'    x2 NUMBER;',
'    x3 NVARCHAR2(100);',
'    x4 NVARCHAR2(100);',
'    x5 NUMBER;',
'BEGIN',
'',
'    IF :P20002_SCHOLARSHIP_RECIPIENT LIKE ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT LIKE ''B'' THEN',
'        x4 := :P20002_EMPLOYEE_CODE;',
'',
'        SELECT MAX(TO_NUMBER(SUBSTR(sr.VOUCHER_CODE, INSTR(sr.VOUCHER_CODE, sr.REQUESTER_CODE) + LENGTH(sr.REQUESTER_CODE) + 1)))',
'        INTO x5',
'        FROM SCHOLARSHIP_REQUEST sr',
'        WHERE sr.REQUESTER_CODE = :P20002_EMPLOYEE_CODE',
'        AND (sr.RECIPIENT_TYPE LIKE ''A'' OR sr.RECIPIENT_TYPE LIKE ''B'');',
'',
'    ELSIF :P20002_SCHOLARSHIP_RECIPIENT LIKE ''C'' OR :P20002_SCHOLARSHIP_RECIPIENT LIKE ''D'' THEN',
'        x4 := :P20002_DEPARTMENT_CODE;',
'        ',
'        SELECT MAX(TO_NUMBER(SUBSTR(sr.VOUCHER_CODE, INSTR(sr.VOUCHER_CODE, sr.REQUESTER_DEPARTMENT_CODE) + LENGTH(sr.REQUESTER_DEPARTMENT_CODE) + 1)))',
'        INTO x5',
'        FROM SCHOLARSHIP_REQUEST sr',
'        WHERE sr.REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE',
'        AND (sr.RECIPIENT_TYPE LIKE ''C'' OR sr.RECIPIENT_TYPE LIKE ''D'');',
'    END IF;',
'',
'    IF :P20002_PROGRAM IS NOT NULL THEN',
'        x3 := :P20002_PROGRAM;',
'    END IF;',
'',
'    IF :P20002_DISCOUNT_RATE IS NOT NULL THEN',
'        SELECT cp.DISCOUNT_RATE',
'        INTO x2',
'        FROM COREEDU_PROMOTION cp',
'        WHERE cp.ID = :P20002_DISCOUNT_RATE;',
'    END IF;',
'',
'    SELECT TO_CHAR(TO_DATE(:P20002_EFFECTIVE_DATE, ''DD/MM/YYYY''), ''YY'') || ',
'           COALESCE(TO_CHAR(TO_DATE(:P20002_EXPIRATION_DATE, ''DD/MM/YYYY''), ''MM''), ''00'')',
'    INTO x1',
'    FROM DUAL;',
'    -- SELECT TO_CHAR(TO_DATE(:P20002_EFFECTIVE_DATE, ''MM/DD/YYYY''), ''YY'') || ',
'    --        COALESCE(TO_CHAR(TO_DATE(:P20002_EXPIRATION_DATE, ''MM/DD/YYYY''), ''MM''), ''00'')',
'    -- INTO x1',
'    -- FROM DUAL;',
'    ',
'    :P20002_VOUCHER_CODE := x1 || ''-'' || :P20002_SCHOLARSHIP_RECIPIENT || LPAD(TO_CHAR(x2), 3, ''0'') || ''-'' || x3 || ''-'' || x4 || ''-'' || TO_CHAR(COALESCE(x5, 0) + 1);',
'    -- RETURN x1 || ''-'' || :P20002_SCHOLARSHIP_RECIPIENT || LPAD(TO_CHAR(x2), 3, ''0'') || ''-'' || x3 || ''-'' || x4 || ''-'' || TO_CHAR(COALESCE(x5, 0) + 1);',
'END;',
'-- DECLARE',
'--     temp nvarchar2(20);',
'-- BEGIN',
'--     if (:P20002_SCHOLARSHIP_RECIPIENT like ''D'') then',
'--         temp := :P20002_REQUEST_NAME;',
'--     else',
'--         temp := :P20002_EMPLOYEE_CODE;',
'--     end if;',
'--     DBMS_OUTPUT.PUT_LINE(calculate_scholarship_code(:P20002_SCHOLARSHIP_RECIPIENT, temp, :P20002_PROGRAM, :P20002_DISCOUNT_RATE, :P20002_EFFECTIVE_DATE, :P20002_EXPIRATION_DATE));',
'-- END;'))
,p_attribute_02=>'P20002_REQUEST_ID,P20002_EFFECTIVE_DATE,P20002_EXPIRATION_DATE,P20002_SCHOLARSHIP_RECIPIENT,P20002_DISCOUNT_RATE,P20002_PROGRAM,P20002_EMPLOYEE_CODE,P20002_DEPARTMENT_CODE'
,p_attribute_03=>'P20002_VOUCHER_CODE'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$v("P20002_SCHOLARSHIP_RECIPIENT") !== null && $v("P20002_SCHOLARSHIP_RECIPIENT") !== ""',
'&& $v("P20002_PROGRAM") !== null && $v("P20002_PROGRAM") !== ""',
'&& $v("P20002_EFFECTIVE_DATE") !== null && $v("P20002_EFFECTIVE_DATE") !== ""',
'&& $v("P20002_DISCOUNT_RATE") !== null && $v("P20002_DISCOUNT_RATE") !== ""'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(25838302556867501)
,p_name=>'voucher_code_when_edit'
,p_event_sequence=>210
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
'    x2 number;',
'    x3 nvarchar2(100);',
'begin',
'    select to_char(to_date(:P20002_EFFECTIVE_DATE, ''DD/MM/YYYY''), ''YY'') ||',
'        coalesce(to_char(to_date(:P20002_EXPIRATION_DATE, ''DD/MM/YYYY''), ''MM''), ''00'')',
'    into x1',
'    from dual;',
'',
'    -- if :P20002_DISCOUNT_RATE < 100 then',
'    --     select to_char(:P20002_DISCOUNT_RATE, ''000'') ',
'    --     into x2 ',
'    --     from dual;',
'    -- else',
'    --     select :P20002_DISCOUNT_RATE ',
'    --     into x2 ',
'    --     from dual;',
'    -- end if;',
'',
'    -- if :P20002_SCHOLARSHIP_RECIPIENT is not null then',
'    --     select replace(:P20002_SCHOLARSHIP_RECIPIENT || x2, '' '', '''')',
'    --     into x2',
'    --     from dual;',
'    -- end if;',
'',
'     IF :P20002_DISCOUNT_RATE IS NOT NULL THEN',
'        SELECT cp.DISCOUNT_RATE',
'        INTO x2',
'        FROM COREEDU_PROMOTION cp',
'        WHERE cp.ID = :P20002_DISCOUNT_RATE;',
'    END IF;',
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
'    return x1 || ''-'' || :P20002_SCHOLARSHIP_RECIPIENT || LPAD(to_char(x2), 3, ''0'') || ''-'' || x3;',
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
'    c_date date := sysdate;',
'    scholarship_request_id NUMBER;',
'    first_manager nvarchar2(50);',
'    requester_code nvarchar2(50);',
'    p_request_status_out number;',
'    pro_code nvarchar2(50);',
'    emp_requests_id number;',
'    emp_wf_process_id nvarchar2(50);',
'    wa_group nvarchar2(50);',
'    response_log nvarchar2(1000); ',
'    response_status nvarchar2(100);',
'    -- send mail',
'    v_body_man clob := '''';',
'    manager_email nvarchar2(100);',
'    manager_name nvarchar2(100);',
'    emp_name nvarchar2(100);',
'    emp_email nvarchar2(100);',
'',
'    discount_rate number;',
'',
'begin',
unistr('-- l\1EA5y gi\00E1 tr\1ECB c\1EE7a discount_rate t\1EEB b\1EA3ng COREEDU_PROMOTION b\1EB1ng id'),
'    SELECT DISCOUNT_RATE INTO discount_rate',
'    FROM COREEDU_PROMOTION',
'    WHERE :P20002_DISCOUNT_RATE = ID;',
'',
unistr('-- th\00EAm v\00E0o b\1EA3ng SCHOLARSHIP_REQUEST'),
'    INSERT INTO',
'        SCHOLARSHIP_REQUEST(',
'            STATUS,',
'            RECIPIENT_TYPE,',
'            PROGRAM,',
'            REQUESTER_CODE,',
'            REQUESTER_DEPARTMENT,',
'            REQUESTER_DEPARTMENT_CODE,',
'            REQUESTER_LEVEL,',
'            PARTNER_NAME,',
'            PARTNER_PHONE,',
'            PARTNER_TITLE,',
'            PARTNER_DEPARTMENT,',
'            PARTNER_FIELD,',
'            PARTNER_WORKPLACE,',
'            RECIPIENT_NAME,',
'            RECIPIENT_DOB,',
'            RECIPIENT_PHONE,',
'            RECIPIENT_RELATIONSHIP,',
'            RECIPIENT_CAMPUS,',
'            ATTACH_NAME,',
'            ATTACH_FILE,',
'            RECIPIENT_REPLACEMENT,',
'            RECIPIENT_VOUCHER_CODE_REPLACEMENT,',
'            RECIPIENT_EXPIRATION_DATE_REPLACEMENT,',
'            RECIPIENT_NOTE,',
'            RECIPIENT_REASON_REQUEST,',
'            DISCOUNT_RATE,',
'            VOUCHER_CODE,',
'            NUMBER_OF_COURSES,',
'            EFFECTIVE_DATE,',
'            EXPIRATION_DATE,',
'            -- APPROVED_DATE,',
'            CREATED_DATE,',
'            DETAIL_ID,',
'            ID_COREEDU_PROMOTION',
'        )',
'    VALUES',
'    (',
'            2,',
'            :P20002_SCHOLARSHIP_RECIPIENT,',
'            :P20002_PROGRAM,',
'            case',
'                when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = ''C'' then :P20002_REQUEST_NAME',
'                when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = ''D'' then :P20002_REQUEST_NAME',
unistr('                when lower(:P20002_LEVEL_ID) = ''c'' and :P20002_SCHOLARSHIP_RECIPIENT = ''D'' then :P20002_REQUEST_NAME    -- tr\01B0\1EDDng h\1EE3p CEO t\1EA1o \0111\01A1n'),
'            else',
'                :P20002_EMPLOYEE_CODE',
'            end,',
'            :P20002_DEPARTMENT,',
'            :P20002_DEPARTMENT_CODE,',
'            :P20002_LEVEL,',
'            :P20002_PARTNER_NAME,',
'            :P20002_PARTNER_PHONE,',
'            :P20002_TITLE,',
'            :P20002_PARTNER_DEPARTMENT,',
'            :P20002_FIELD,',
'            :P20002_WORKPLACE,',
'            :P20002_RECIPIENT_NAME,',
'            TO_DATE(:P20002_RECIPIENT_DOB, ''DD/MM/YYYY''),',
'            :P20002_RECIPIENT_PHONE,',
'            :P20002_RELATIONSHIP,',
'            :P20002_CAMPUS,',
'            :P20002_NAME_FILES,',
'            :P20002_URL_FILES,',
'            :P20002_REPLACEMENT,',
'            :P20002_VOUCHER_CODE_REPLACEMENT,',
'            TO_DATE(:P20002_EXPIRATION_DATE_REPLACEMENT, ''DD/MM/YYYY''),',
'            :P20002_NOTE,',
'            :P20002_REASON_REQUEST,',
'            discount_rate,',
'            :P20002_VOUCHER_CODE,',
'            :P20002_NUMBER_OF_COURSES,',
'            TO_DATE(:P20002_EFFECTIVE_DATE, ''DD/MM/YYYY''),',
'            TO_DATE(:P20002_EXPIRATION_DATE, ''DD/MM/YYYY''),',
'            -- case',
'            --     when :P20002_EXPIRATION_DATE is null then to_date(''12/31/2154'')',
'            --     when :P20002_EXPIRATION_DATE is not null then to_date(:P20002_EXPIRATION_DATE)',
'            -- end,',
'            -- TO_DATE(:P20002_APPROVED_DATE, ''DD/MM/YYYY''),',
'            c_date,',
'            :P20002_SCHOLARSHIP_DETAIL,',
'            :P20002_DISCOUNT_RATE',
'        )',
'        returning ID into scholarship_request_id;',
'',
unistr('    -- ki\1EC3m tra n\1EBFu c\00F3 thay th\1EBF th\00EC c\1EADp nh\1EADt l\1EA1i gi\00E1 tr\1ECB c\1EE7a voucher b\1ECB thay th\1EBF t\1EA1i c\1ED9t IS_REPLACED = 1'),
'        if (:P20002_REPLACEMENT is not null) then',
'            UPDATE SCHOLARSHIP_REQUEST sr',
'            SET IS_REPLACED = 1',
'            WHERE :P20002_REPLACEMENT = sr.VOUCHER_CODE;',
'        end if;',
'',
unistr('    -- th\00EAm v\00E0o b\1EA3ng EMP_REQUEST \0111\1EC3 x\00E9t workflow'),
'    FOR REC IN (',
'        SELECT WF_FEATURE_APPLY, WF_PROCESS_ID',
'        FROM WORKFLOW wf',
'        WHERE lower(WF_FEATURE_APPLY) = lower(:P20002_FEATURE) ',
'            AND WF_EXPIRATION_DATE >= SYSDATE',
unistr('            -- AND ROWNUM = 1      -- do hi\1EC7n t\1EA1i \0111ang c\00F3 2 workflow \00E1p d\1EE5ng m\00E0 ko ph\00E2n bi\1EC7t \0111\01B0\1EE3c (n\1EBFu \0111\00FAng l\00E0 ph\1EA3i ph\00E2n bi\1EC7t b\1EB1ng ''condition'' nh\01B0ng ch\01B0a l\00E0m \0111c)'),
unistr('        ORDER BY (select count(*) from WORKFLOW_CONDITIONS wc where wc.WF_PROCESS_ID = wf.WF_PROCESS_ID) desc   -- s\1EAFp x\1EBFp theo workflow n\00E0o c\00F3 nhi\1EC1u \0111i\1EC1u ki\1EC7n nh\1EA5t, gi\1EA3m d\1EA7n'),
'    )LOOP        ',
'        if WF_CHECK_CONDITIONS(scholarship_request_id, rec.WF_PROCESS_ID) = 1 THEN',
'            INSERT INTO EMP_REQUESTS(',
'                REQUEST_TYPE,',
'                SUBMIT_DATE,',
'                EMPLOYEE_CODE,',
'                STATUS,',
'                NOTE,',
'                CREATE_DATE,',
'                REQUEST_DETAIL_ID,',
'                WF_PROCESS_ID',
'                -- LINE_MANAGER',
'            ) VALUES(',
'                REC.WF_FEATURE_APPLY,',
'                SYSDATE,',
'                :APP_EMP_CODE,',
'                2,',
'                -- :P20002_NOTE,',
'                CASE ',
'                    WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN :P20002_NOTE',
'                    ELSE :P20002_REASON_REQUEST',
'                END,',
'                SYSDATE,',
'                scholarship_request_id,',
'                REC.WF_PROCESS_ID',
'                -- line_manager_code',
'            );',
'            -- get the workflow have most conditions that match with the request',
'            exit;',
'        end if;',
'    END LOOP; ',
'',
unistr('    -- l\1EA5y emp_requests_id'),
'    select er.ID, er.WF_PROCESS_ID',
'    into emp_requests_id, emp_wf_process_id',
'    from EMP_REQUESTS er ',
'    where scholarship_request_id = er.REQUEST_DETAIL_ID and lower(er.REQUEST_TYPE) = lower(:P20002_FEATURE);',
'',
unistr('    -- th\00EAm v\00E0o workflow_detail'),
'    insert into WORKFLOW_DETAIL(',
'        WD_MODIFIED_DATE,',
'        WD_MODIFIED_CODE,',
'        STATUS,',
'        REQUEST_ID,',
'        WD_COMMENT,',
'        WF_PROCESS_ID',
'    ) ',
'    values(',
'        sysdate,',
'        :APP_EMP_CODE,',
'        2,',
'        emp_requests_id,',
'        -- :P20002_NOTE',
'        CASE ',
'            WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN :P20002_NOTE',
'            ELSE :P20002_REASON_REQUEST',
'        END,',
'        emp_wf_process_id',
'        );',
'',
unistr('    -- th\00EAm ATTACHMENT_HISTORY'),
'    IF(remove_first_semicolon(:P20002_DEFAULT_IMAGES_URL) != :P20002_URL_FILES or',
'       ( :P20002_REQUEST_ID is null and :P20002_URL_FILES is not null )) ',
'    THEN',
'        INSERT INTO ATTACHMENT_HISTORY (ATTACHMENT_DATE, EMPLOYEE_CODE, ATTACHMENT_URL, ATTACHMENT_NAME, REQUEST_ID)',
'        VALUES(sysdate, :APP_EMP_CODE, :P20002_URL_FILES, :P20002_NAME_FILES, emp_requests_id);',
'    END IF;',
'',
unistr('-- ki\1EC3m tra tr\01B0\1EDDng h\1EE3p ng\01B0\1EDDi t\1EA1o ch\00EDnh l\00E0 ng\01B0\1EDDi duy\1EC7t \0111\1EA7u ti\00EAn'),
unistr('    -- l\1EA5y m\00E3 nh\00E2n vi\00EAn duy\1EC7t \1EDF b\01B0\1EDBc duy\1EC7t \0111\1EA7u ti\00EAn'),
'    first_manager := GET_MANAGER_NEXT_SEQUENCE(emp_requests_id);',
'',
unistr('    -- l\1EA5y m\00E3 nh\00E2n vi\00EAn t\1EA1o'),
'    select sr.REQUESTER_CODE',
'    into requester_code',
'    from SCHOLARSHIP_REQUEST sr',
'    where scholarship_request_id = sr.ID;',
'',
'    if (requester_code = first_manager) then',
unistr('        -- g\1ECDi duy\1EC7t'),
'        wf_process_request(requester_code, emp_requests_id, 1, ''Approved'', p_request_status_out);',
'    else',
'    -- send mail to mananger',
unistr('        -- l\1EA5y th\00F4ng tin ng\01B0\1EDDi duy\1EC7t \0111\1EA7u ti\00EAn'),
'        SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES emp WHERE first_manager = emp.EMPLOYEE_CODE;',
'',
unistr('        -- l\1EA5y th\00F4ng tin nh\00E2n vi\00EAn t\1EA1o \0111\01A1n'),
'        SELECT USER_NAME, FULL_NAME INTO emp_email, emp_name FROM EMPLOYEES emp WHERE requester_code = emp.EMPLOYEE_CODE;',
'        ',
'         -- v_body_man := v_body_man || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('        v_body_man := v_body_man || ''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\01A0N XIN C\1EA4P H\1ECCC B\1ED4NG</h3>'';'),
unistr('        v_body_man := v_body_man || ''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 REQUEST FOR SCHOLARSHIP LETTER</h3>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''|| manager_name ||'' th\00E2n m\1EBFn,</p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''|| manager_name ||'',</p>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB xin c\1EA5p h\1ECDc b\1ED5ng c\1EE7a nh\00E2n vi\00EAn nh\01B0 sau:</p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''>Employee Portal system has received a request for scholarship as below:</p>'';',
'        v_body_man := v_body_man || ''<br>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>Th\00F4ng tin ng\01B0\1EDDi y\00EAu c\1EA7u/ B\1ED9 ph\1EADn \0111\1EC1 ngh\1ECB</strong></p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''><i>Requester / Department Request</i></p>'';',
'        -- v_body_man := v_body_man || ''<ul>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn nh\00E2n vi\00EAn / Employee Full Name:</strong> ''|| emp_name ||''</p>'';'),
'        ',
'        if :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' then ',
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn / Employee Code:</strong> ''|| requester_code ||''</p>'';'),
'        else',
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ph\00F2ng ban / Department:</strong> ''|| :P20002_DEPARTMENT ||''</p>'';'),
'        end if;',
'        ',
'        v_body_man := v_body_man || ''<br>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>Th\00F4ng tin ng\01B0\1EDDi \0111\01B0\1EE3c c\1EA5p h\1ECDc b\1ED5ng (h\1ECDc vi\00EAn)</strong></p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''><i>Information Of Recipient</i></p>'';',
'        -- v_body_man := v_body_man || ''<ul>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn ng\01B0\1EDDi nh\1EADn / Recipient Full Name:</strong> ''|| :P20002_RECIPIENT_NAME ||''</p>''; '),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ng\00E0y th\00E1ng n\0103m sinh ng\01B0\1EDDi nh\1EADn / Recipient DOB:</strong> ''|| :P20002_RECIPIENT_DOB ||''</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- S\1ED1 \0111i\1EC7n tho\1EA1i ng\01B0\1EDDi nh\1EADn / Recipient Phone:</strong> ''|| :P20002_RECIPIENT_PHONE ||''</p>'';'),
'        v_body_man := v_body_man || ''<br>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>Th\00F4ng tin h\1ECDc b\1ED5ng</strong></p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''><i>Scholarship Information</i></p>'';',
'        -- v_body_man := v_body_man || ''<ul>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ch\01B0\01A1ng tr\00ECnh / Program:</strong> ''|| :P20002_PROGRAM ||''</p>''; '),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- M\1EE9c mi\1EC5n gi\1EA3m / Discount Rate:</strong> ''|| discount_rate ||''%</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ng\00E0y c\00F3 hi\1EC7u l\1EF1c / Effective Date:</strong> ''|| :P20002_EFFECTIVE_DATE ||''</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ng\00E0y h\1EBFt h\1EA1n / Expiration Date:</strong> ''|| :P20002_EXPIRATION_DATE ||''</p>'';'),
'        v_body_man := v_body_man || ''<br>'';',
'',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''>Vui l\00F2ng \0111\0103ng nh\1EADp v\00E0o H\1EC7 th\1ED1ng Qu\1EA3n l\00FD H\1ECDc b\1ED5ng \0111\1EC3 xem x\00E9t v\00E0 ph\1EA3n h\1ED3i y\00EAu c\1EA7u. B\1EA1n c\00F3 th\1EC3 ph\1EA3n h\1ED3i y\00EAu c\1EA7u c\1EA5p h\1ECDc b\1ED5ng b\1EB1ng c\00E1ch nh\1EA5p v\00E0o li\00EAn k\1EBFt sau:</p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''>Please log in to The scholarship management system to review and respond the scholarship request. You can respond the scholarship request by clicking on the following link: <a href=\"https'
||unistr('://erp-uat.vus.edu.vn/ords/r/erp/erp/approve-scholarship-request?P20005_REQUEST_ID='' || to_char(scholarship_request_id) || ''\005C"> link to respond the scholarship request \2197.</a></p><br>'';'),
'',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''>N\1EBFu b\1EA1n c\00F3 b\1EA5t k\1EF3 c\00E2u h\1ECFi n\00E0o ho\1EB7c c\1EA7n th\00EAm s\1EF1 h\1ED7 tr\1EE3, xin \0111\1EEBng ng\1EA7n ng\1EA1i li\00EAn h\1EC7 v\1EDBi ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh.</p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''>Best regards,</p>'';',
'        v_body_man := v_body_man || ''<p style=''''color:black''''>HR & Admin Department </p>'';',
'        -- v_body_man := v_body_man || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', manager_email, ''Y\00EAu c\1EA7u duy\1EC7t \0111\01A1n xin c\1EA5p h\1ECDc b\1ED5ng'', v_body_man);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'', ''Y\00EAu c\1EA7u duy\1EC7t \0111\01A1n xin c\1EA5p h\1ECDc b\1ED5ng'', v_body_man);'),
'    end if;',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(21284965111734530)
,p_process_success_message=>'Success!'
,p_internal_uid=>21310415858734579
);
end;
/
begin
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22025840905485910)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'submit'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'c_date date := sysdate;',
'-- SCHOLARSHIP_REQUEST_ID NUMBER;',
'line_manager_code nvarchar2(50);',
'emp_requests_id number;',
'emp_wf_process_id nvarchar2(50);',
'response_log nvarchar2(1000); ',
'response_status nvarchar2(100);',
'-- for sending mail',
'first_manager nvarchar2(50);',
'requester_code nvarchar2(50);',
'p_request_status_out number;',
'v_body_man clob := '''';',
'manager_email nvarchar2(100);',
'manager_name nvarchar2(100);',
'emp_name nvarchar2(100);',
'emp_email nvarchar2(100);',
'',
'discount_rate number;',
'',
'begin',
'',
'    -- SELECT MANAGER_ID INTO line_manager_code ',
'    -- FROM EMPLOYEES ',
'    -- WHERE EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
unistr('-- l\1EA5y gi\00E1 tr\1ECB c\1EE7a discount_rate b\1EB1ng id'),
'    SELECT DISCOUNT_RATE INTO discount_rate',
'    FROM COREEDU_PROMOTION',
'    WHERE :P20002_DISCOUNT_RATE = ID;',
'',
unistr('-- c\1EADp nh\1EADt b\1EA3ng SCHOLARSHIP_REQUEST '),
'    UPDATE SCHOLARSHIP_REQUEST sr',
'    SET STATUS = 2,',
'        REQUESTER_CODE = ',
'            case',
'                when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = ''C'' then :P20002_REQUEST_NAME',
'                when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = ''D'' then :P20002_REQUEST_NAME',
unistr('                when lower(:P20002_LEVEL_ID) = ''c'' and :P20002_SCHOLARSHIP_RECIPIENT = ''D'' then :P20002_REQUEST_NAME    -- tr\01B0\1EDDng h\1EE3p CEO t\1EA1o \0111\01A1n'),
'            else',
'                :P20002_EMPLOYEE_CODE',
'            end,',
'        REQUESTER_DEPARTMENT = :P20002_DEPARTMENT,',
'        REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE,',
'        REQUESTER_LEVEL = :P20002_LEVEL,',
'        PARTNER_NAME = :P20002_PARTNER_NAME,',
'        PARTNER_PHONE = :P20002_PARTNER_PHONE,',
'        PARTNER_TITLE = :P20002_TITLE,',
'        PARTNER_DEPARTMENT = :P20002_PARTNER_DEPARTMENT,',
'        PARTNER_FIELD = :P20002_FIELD,',
'        PARTNER_WORKPLACE = :P20002_WORKPLACE,',
'        RECIPIENT_NAME = :P20002_RECIPIENT_NAME,',
'        RECIPIENT_DOB = TO_DATE(:P20002_RECIPIENT_DOB, ''DD/MM/YYYY''),',
'        RECIPIENT_PHONE = :P20002_RECIPIENT_PHONE,',
'        RECIPIENT_RELATIONSHIP = :P20002_RELATIONSHIP,',
'        RECIPIENT_CAMPUS = :P20002_CAMPUS,',
'        ATTACH_NAME = :P20002_NAME_FILES,',
'        ATTACH_FILE = :P20002_URL_FILES,',
'        RECIPIENT_REPLACEMENT = :P20002_REPLACEMENT,',
'        RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20002_VOUCHER_CODE_REPLACEMENT,',
'        RECIPIENT_EXPIRATION_DATE_REPLACEMENT = TO_DATE(:P20002_EXPIRATION_DATE_REPLACEMENT, ''DD/MM/YYYY''),',
'        RECIPIENT_NOTE = :P20002_NOTE,',
'        RECIPIENT_REASON_REQUEST = :P20002_REASON_REQUEST,',
'        DISCOUNT_RATE = discount_rate,',
'        VOUCHER_CODE = :P20002_VOUCHER_CODE,',
'        NUMBER_OF_COURSES = :P20002_NUMBER_OF_COURSES,',
'        EFFECTIVE_DATE = TO_DATE(:P20002_EFFECTIVE_DATE, ''DD/MM/YYYY''),',
'        EXPIRATION_DATE = TO_DATE(:P20002_EXPIRATION_DATE, ''DD/MM/YYYY''),',
'        -- APPROVED_DATE = TO_DATE(:P20002_APPROVED_DATE, ''DD/MM/YYYY''),',
'        CREATED_DATE = c_date,',
'        ID_COREEDU_PROMOTION = :P20002_DISCOUNT_RATE',
'    WHERE :P20002_REQUEST_ID = sr.ID;',
'',
unistr('-- ki\1EC3m tra n\1EBFu c\00F3 thay th\1EBF th\00EC c\1EADp nh\1EADt l\1EA1i gi\00E1 tr\1ECB c\1EE7a voucher b\1ECB thay th\1EBF t\1EA1i c\1ED9t IS_REPLACED = 1'),
'    if (:P20002_REPLACEMENT is not null) then',
'        UPDATE SCHOLARSHIP_REQUEST sr',
'        SET IS_REPLACED = 1',
'        WHERE :P20002_REPLACEMENT = sr.VOUCHER_CODE;',
'    end if;',
'',
unistr(' -- L\1EA5y emp_requests_id'),
'    -- select er.ID',
'    -- into emp_requests_id',
'    -- from EMP_REQUESTS er where :P20002_REQUEST_ID = er.REQUEST_DETAIL_ID and lower(er.REQUEST_TYPE) = lower(:P20002_FEATURE);',
'    select er.ID, er.WF_PROCESS_ID',
'    into emp_requests_id, emp_wf_process_id',
'    from EMP_REQUESTS er ',
'    where :P20002_REQUEST_ID = er.REQUEST_DETAIL_ID and lower(er.REQUEST_TYPE) = lower(:P20002_FEATURE);',
'',
'    -- UPDATE EMP_REQUEST',
'   UPDATE EMP_REQUESTS er',
'   SET',
'        er.STATUS = 2,',
'        er.NOTE = ',
'            CASE ',
'                WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN :P20002_NOTE',
'                ELSE :P20002_REASON_REQUEST',
'            END',
'    WHERE emp_requests_id = er.ID and lower(er.REQUEST_TYPE) = lower(:P20002_FEATURE);',
'    ',
'',
'    -- Insert into workflow_detail',
'    insert into WORKFLOW_DETAIL(',
'        WD_MODIFIED_DATE,',
'        WD_MODIFIED_CODE,',
'        STATUS,',
'        REQUEST_ID,',
'        WD_COMMENT,',
'        WF_PROCESS_ID',
'    ) ',
'    values(',
'        sysdate,',
'        :APP_EMP_CODE,',
'        2,',
'        emp_requests_id,',
'        CASE ',
'            WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN :P20002_NOTE',
'            ELSE :P20002_REASON_REQUEST',
'        END,',
'        emp_wf_process_id',
'        );',
'',
'    -- Insert ATTACHMENT_HISTORY',
'    IF(remove_first_semicolon(:P20002_DEFAULT_IMAGES_URL) != :P20002_URL_FILES or',
'       ( :P20002_REQUEST_ID is null and :P20002_URL_FILES is not null )) ',
'    THEN',
'        INSERT INTO ATTACHMENT_HISTORY (ATTACHMENT_DATE, EMPLOYEE_CODE, ATTACHMENT_URL, ATTACHMENT_NAME, REQUEST_ID)',
'        VALUES(sysdate, :APP_EMP_CODE, :P20002_URL_FILES, :P20002_NAME_FILES, emp_requests_id);',
'    END IF;',
'',
'    -- Write log attachments',
'    -- INSERT INTO OUTPUT_LOGS(NUMBER1, STR1, STR2, STR3)',
'    -- VALUES (emp_requests_id, ''submit_scho'', :P20002_DEFAULT_IMAGES_URL, :P20002_URL_FILES);',
'    ',
unistr('-- ki\1EC3m tra tr\01B0\1EDDng h\1EE3p ng\01B0\1EDDi t\1EA1o ch\00EDnh l\00E0 ng\01B0\1EDDi duy\1EC7t \0111\1EA7u ti\00EAn'),
unistr('    -- l\1EA5y m\00E3 nh\00E2n vi\00EAn duy\1EC7t \1EDF b\01B0\1EDBc duy\1EC7t \0111\1EA7u ti\00EAn'),
'    first_manager := GET_MANAGER_NEXT_SEQUENCE(emp_requests_id);',
'',
unistr('    -- l\1EA5y m\00E3 nh\00E2n vi\00EAn t\1EA1o'),
'    select sr.REQUESTER_CODE',
'    into requester_code',
'    from SCHOLARSHIP_REQUEST sr',
'    where :P20002_REQUEST_ID = sr.ID;',
'',
'    if (requester_code = first_manager) then',
unistr('        -- g\1ECDi duy\1EC7t'),
'        wf_process_request(requester_code, emp_requests_id, 1, ''Approved'', p_request_status_out);',
'    else',
'    -- send mail to mananger',
unistr('        -- l\1EA5y th\00F4ng tin ng\01B0\1EDDi duy\1EC7t \0111\1EA7u ti\00EAn'),
'        SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES emp WHERE first_manager = emp.EMPLOYEE_CODE;',
'',
unistr('        -- l\1EA5y th\00F4ng tin nh\00E2n vi\00EAn t\1EA1o \0111\01A1n'),
'        SELECT USER_NAME, FULL_NAME INTO emp_email, emp_name FROM EMPLOYEES emp WHERE requester_code = emp.EMPLOYEE_CODE;',
'',
'        -- v_body_man := v_body_man || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('        v_body_man := v_body_man || ''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\01A0N XIN C\1EA4P H\1ECCC B\1ED4NG</h3>'';'),
unistr('        v_body_man := v_body_man || ''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 REQUEST FOR SCHOLARSHIP LETTER</h3>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''|| manager_name ||'' th\00E2n m\1EBFn,</p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''|| manager_name ||'',</p>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB xin c\1EA5p h\1ECDc b\1ED5ng c\1EE7a nh\00E2n vi\00EAn nh\01B0 sau:</p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''>Employee Portal system has received a request for scholarship as below:</p>'';',
'        v_body_man := v_body_man || ''<br>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>Th\00F4ng tin ng\01B0\1EDDi y\00EAu c\1EA7u/ B\1ED9 ph\1EADn \0111\1EC1 ngh\1ECB</strong></p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''><i>Requester / Department Request</i></p>'';',
'        -- v_body_man := v_body_man || ''<ul>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn nh\00E2n vi\00EAn / Employee Full Name:</strong> ''|| emp_name ||''</p>'';'),
'        ',
'        if :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' then ',
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn / Employee Code:</strong> ''|| requester_code ||''</p>'';'),
'        else',
unistr('            v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ph\00F2ng ban / Department:</strong> ''|| :P20002_DEPARTMENT ||''</p>'';'),
'        end if;',
'',
'        v_body_man := v_body_man || ''<br>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>Th\00F4ng tin ng\01B0\1EDDi nh\1EADn h\1ECDc b\1ED5ng (h\1ECDc vi\00EAn)</strong></p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''><i>Information Of Recipient</i></p>'';',
'        -- v_body_man := v_body_man || ''<ul>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn ng\01B0\1EDDi nh\1EADn / Recipient Full Name:</strong> ''|| :P20002_RECIPIENT_NAME ||''</p>''; '),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ng\00E0y th\00E1ng n\0103m sinh ng\01B0\1EDDi nh\1EADn / Recipient DOB:</strong> ''|| :P20002_RECIPIENT_DOB ||''</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- S\1ED1 \0111i\1EC7n tho\1EA1i ng\01B0\1EDDi nh\1EADn / Recipient Phone:</strong> ''|| :P20002_RECIPIENT_PHONE ||''</p>'';'),
'        v_body_man := v_body_man || ''<br>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>Th\00F4ng tin h\1ECDc b\1ED5ng</strong></p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''><i>Scholarship Information</i></p>'';',
'        -- v_body_man := v_body_man || ''<ul>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ch\01B0\01A1ng tr\00ECnh / Program:</strong> ''|| :P20002_PROGRAM ||''</p>''; '),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- M\1EE9c mi\1EC5n gi\1EA3m / Discount Rate:</strong> ''|| discount_rate ||''%</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ng\00E0y c\00F3 hi\1EC7u l\1EF1c / Effective Date:</strong> ''|| :P20002_EFFECTIVE_DATE ||''</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ng\00E0y h\1EBFt h\1EA1n / Expiration Date:</strong> ''|| :P20002_EXPIRATION_DATE ||''</p>'';'),
'        v_body_man := v_body_man || ''<br>'';',
'',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''>Vui l\00F2ng \0111\0103ng nh\1EADp v\00E0o H\1EC7 th\1ED1ng Qu\1EA3n l\00FD H\1ECDc b\1ED5ng \0111\1EC3 xem x\00E9t v\00E0 ph\1EA3n h\1ED3i y\00EAu c\1EA7u. B\1EA1n c\00F3 th\1EC3 ph\1EA3n h\1ED3i y\00EAu c\1EA7u c\1EA5p h\1ECDc b\1ED5ng b\1EB1ng c\00E1ch nh\1EA5p v\00E0o li\00EAn k\1EBFt sau:</p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''>Please log in to The scholarship management system to review and respond the scholarship request. You can respond the scholarship request by clicking on the following link: <a href=\"https'
||unistr('://erp-uat.vus.edu.vn/ords/r/erp/erp/approve-scholarship-request?P20005_REQUEST_ID='' || to_char(:P20002_REQUEST_ID) || ''\005C"> link to respond the scholarship request \2197.</a></p><br>'';'),
'',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''>N\1EBFu b\1EA1n c\00F3 b\1EA5t k\1EF3 c\00E2u h\1ECFi n\00E0o ho\1EB7c c\1EA7n th\00EAm s\1EF1 h\1ED7 tr\1EE3, xin \0111\1EEBng ng\1EA7n ng\1EA1i li\00EAn h\1EC7 v\1EDBi ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh.</p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>'';',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'        v_body_man := v_body_man || ''<p style=''''color:black''''>Best regards,</p>'';',
'        v_body_man := v_body_man || ''<p style=''''color:black''''>HR & Admin Department </p>'';',
'        -- v_body_man := v_body_man || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', manager_email, ''Y\00EAu c\1EA7u duy\1EC7t \0111\01A1n xin c\1EA5p h\1ECDc b\1ED5ng'', v_body_man);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'', ''Y\00EAu c\1EA7u duy\1EC7t \0111\01A1n xin c\1EA5p h\1ECDc b\1ED5ng'', v_body_man);'),
'    end if;',
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
'c_date date := sysdate;',
'scholarship_request_id number;',
'pro_code nvarchar2(50);',
'emp_requests_id number;',
'emp_wf_process_id nvarchar2(50);',
'v_start_time NUMBER;',
'v_end_time NUMBER;',
'',
'discount_rate number;',
'',
'begin',
'',
'    -- --if :P20002_REQUEST_ID is null then',
'    -- select PROMOTION_CODE into pro_code',
'    -- from COREEDU_PROMOTION',
'    -- where PROGRAM = :P20002_PROGRAM and DISCOUNT_RATE = nvl(:P20002_DISCOUNT_RATE, 50);',
'',
unistr(' -- l\1EA5y gi\00E1 tr\1ECB c\1EE7a discount_rate b\1EB1ng id'),
'    SELECT DISCOUNT_RATE INTO discount_rate',
'    FROM COREEDU_PROMOTION',
'    WHERE :P20002_DISCOUNT_RATE = ID;',
'    ',
unistr('-- th\00EAm v\00E0o b\1EA3ng SCHOLARSHIP_REQUEST'),
'    INSERT INTO',
'        SCHOLARSHIP_REQUEST(',
'            STATUS,',
'            RECIPIENT_TYPE,',
'            PROGRAM,',
'            REQUESTER_CODE,',
'            REQUESTER_DEPARTMENT,',
'            REQUESTER_DEPARTMENT_CODE,',
'            REQUESTER_LEVEL,',
'            PARTNER_NAME,',
'            PARTNER_PHONE,',
'            PARTNER_TITLE, ',
'            PARTNER_DEPARTMENT,',
'            PARTNER_FIELD,',
'            PARTNER_WORKPLACE,',
'            RECIPIENT_NAME,',
'            RECIPIENT_DOB,',
'            RECIPIENT_PHONE,',
'            RECIPIENT_RELATIONSHIP,',
'            RECIPIENT_CAMPUS,',
'            ATTACH_NAME,',
'            ATTACH_FILE,',
'            RECIPIENT_REPLACEMENT,',
'            RECIPIENT_VOUCHER_CODE_REPLACEMENT,',
'            RECIPIENT_EXPIRATION_DATE_REPLACEMENT,',
'            RECIPIENT_NOTE,',
'            RECIPIENT_REASON_REQUEST,',
'            DISCOUNT_RATE,',
'            VOUCHER_CODE,',
'            NUMBER_OF_COURSES,',
'            EFFECTIVE_DATE,',
'            EXPIRATION_DATE,',
'            -- APPROVED_DATE,',
'            CREATED_DATE,',
'            DETAIL_ID,',
'            ID_COREEDU_PROMOTION',
'        )',
'    VALUES',
'    (',
'            1,',
'            :P20002_SCHOLARSHIP_RECIPIENT,',
'            :P20002_PROGRAM,',
'            case',
'                when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = ''C'' then :P20002_REQUEST_NAME',
'                when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = ''D'' then :P20002_REQUEST_NAME',
unistr('                when lower(:P20002_LEVEL_ID) = ''c'' and :P20002_SCHOLARSHIP_RECIPIENT = ''D'' then :P20002_REQUEST_NAME    -- tr\01B0\1EDDng h\1EE3p CEO t\1EA1o \0111\01A1n'),
'            else',
'                :P20002_EMPLOYEE_CODE',
'            end,',
'            :P20002_DEPARTMENT,',
'            :P20002_DEPARTMENT_CODE,',
'            :P20002_LEVEL,',
'            :P20002_PARTNER_NAME,',
'            :P20002_PARTNER_PHONE,',
'            :P20002_TITLE,',
'            :P20002_PARTNER_DEPARTMENT,',
'            :P20002_FIELD,',
'            :P20002_WORKPLACE,',
'            :P20002_RECIPIENT_NAME,',
'            TO_DATE(:P20002_RECIPIENT_DOB, ''DD/MM/YYYY''),',
'            :P20002_RECIPIENT_PHONE,',
'            :P20002_RELATIONSHIP,',
'            :P20002_CAMPUS,',
'            :P20002_NAME_FILES,',
'            :P20002_URL_FILES,',
'            :P20002_REPLACEMENT,',
'            :P20002_VOUCHER_CODE_REPLACEMENT,',
'            TO_DATE(:P20002_EXPIRATION_DATE_REPLACEMENT, ''DD/MM/YYYY''),',
'            :P20002_NOTE,',
'            :P20002_REASON_REQUEST,',
'            discount_rate,',
'            :P20002_VOUCHER_CODE,',
'            :P20002_NUMBER_OF_COURSES,',
'            TO_DATE(:P20002_EFFECTIVE_DATE, ''DD/MM/YYYY''),',
'            TO_DATE(:P20002_EXPIRATION_DATE, ''DD/MM/YYYY''),',
'            -- :P20002_APPROVED_DATE,',
'            c_date,',
'            :P20002_SCHOLARSHIP_DETAIL,',
'            :P20002_DISCOUNT_RATE',
'        ) returning ID into scholarship_request_id;',
'',
'    for rec in (',
'        SELECT WF_FEATURE_APPLY, WF_PROCESS_ID',
'        FROM WORKFLOW wf',
'        WHERE lower(WF_FEATURE_APPLY) = lower(:P20002_FEATURE) ',
'            AND WF_EXPIRATION_DATE >= SYSDATE',
unistr('            -- AND ROWNUM = 1      -- do hi\1EC7n t\1EA1i \0111ang c\00F3 2 workflow \00E1p d\1EE5ng m\00E0 ko ph\00E2n bi\1EC7t \0111\01B0\1EE3c (n\1EBFu \0111\00FAng l\00E0 ph\1EA3i ph\00E2n bi\1EC7t b\1EB1ng ''condition'' nh\01B0ng ch\01B0a l\00E0m \0111c)'),
unistr('        ORDER BY (select count(*) from WORKFLOW_CONDITIONS wc where wc.WF_PROCESS_ID = wf.WF_PROCESS_ID) desc   -- s\1EAFp x\1EBFp theo workflow n\00E0o c\00F3 nhi\1EC1u \0111i\1EC1u ki\1EC7n nh\1EA5t, gi\1EA3m d\1EA7n'),
'    )loop',
'        if WF_CHECK_CONDITIONS(scholarship_request_id, rec.WF_PROCESS_ID) = 1 THEN',
'            INSERT INTO EMP_REQUESTS(',
'                REQUEST_TYPE,',
'                SUBMIT_DATE,',
'                EMPLOYEE_CODE,',
'                STATUS,',
'                NOTE,',
'                CREATE_DATE,',
'                REQUEST_DETAIL_ID,',
'                WF_PROCESS_ID',
'                -- LINE_MANAGER',
'            ) VALUES(',
'                REC.WF_FEATURE_APPLY,',
'                SYSDATE,',
'                :APP_EMP_CODE,',
'                1,',
'                CASE ',
'                    WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN :P20002_NOTE',
'                    ELSE :P20002_REASON_REQUEST',
'                END,',
'                SYSDATE,',
'                scholarship_request_id,',
'                REC.WF_PROCESS_ID',
'                -- :P20002_LINE_MANAGER',
'            );',
'            -- get the workflow have most conditions that match with the request',
'            exit;',
'        end if;',
'    end loop;',
'',
'',
unistr('-- L\1EA5y emp_requests_id'),
'    select er.ID, er.WF_PROCESS_ID',
'    into emp_requests_id, emp_wf_process_id',
'    from EMP_REQUESTS er ',
'    where scholarship_request_id = er.REQUEST_DETAIL_ID and lower(er.REQUEST_TYPE) = lower(:P20002_FEATURE);',
'',
unistr('-- th\00EAm tr\1EA1ng th\00E1i Draft v\00E0o workflow_detail'),
'    insert into WORKFLOW_DETAIL(',
'        WD_MODIFIED_DATE,',
'        WD_MODIFIED_CODE,',
'        STATUS,',
'        REQUEST_ID,',
'        WD_COMMENT,',
'        WF_PROCESS_ID',
'    ) ',
'    values(',
'        sysdate,',
'        :APP_EMP_CODE,',
'        1,',
'        emp_requests_id,',
'        CASE ',
'            WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN :P20002_NOTE',
'            ELSE :P20002_REASON_REQUEST',
'        END,',
'        emp_wf_process_id',
'        );',
'    ',
'    ',
'   -- Insert ATTACHMENT_HISTORY',
'    IF(remove_first_semicolon(:P20002_DEFAULT_IMAGES_URL) != :P20002_URL_FILES or',
'       ( :P20002_REQUEST_ID is null and :P20002_URL_FILES is not null )) ',
'    THEN',
'        INSERT INTO ATTACHMENT_HISTORY (ATTACHMENT_DATE, EMPLOYEE_CODE, ATTACHMENT_URL, ATTACHMENT_NAME, REQUEST_ID)',
'        VALUES(sysdate, :APP_EMP_CODE, :P20002_URL_FILES, :P20002_NAME_FILES, emp_requests_id);',
'    END IF;',
'',
'    -- Write log attachments',
'    -- INSERT INTO OUTPUT_LOGS(NUMBER1, STR1, STR2, STR3)',
'    -- VALUES ((select ID from EMP_REQUESTS er where scholarship_request_id = er.REQUEST_DETAIL_ID), ''savedraft_scho'', :P20002_DEFAULT_IMAGES_URL, :P20002_URL_FILES);',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(21285326290734531)
,p_process_success_message=>'Success!'
,p_internal_uid=>21310827227734581
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(22025683135485908)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'update'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'c_date date := sysdate;',
'scholarship_request_id number;',
'',
'discount_rate number;',
'',
'begin',
'',
unistr('-- l\1EA5y gi\00E1 tr\1ECB c\1EE7a discount_rate b\1EB1ng id'),
'    SELECT DISCOUNT_RATE INTO discount_rate',
'    FROM COREEDU_PROMOTION',
'    WHERE :P20002_DISCOUNT_RATE = ID;',
'',
unistr('-- c\1EADp nh\1EADt b\1EA3ng SCHOLARSHIP_REQUEST '),
'    UPDATE SCHOLARSHIP_REQUEST sr',
'    SET ',
'        -- STATUS = 1,',
'        -- RECIPIENT_TYPE = :P20002_SCHOLARSHIP_RECIPIENT,',
'        -- PROGRAM = :P20002_PROGRAM,',
'        REQUESTER_CODE = ',
'            case',
'                when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = ''C'' then :P20002_REQUEST_NAME',
'                when :P20002_IS_HR_ADMIN = 1 and :P20002_SCHOLARSHIP_RECIPIENT = ''D'' then :P20002_REQUEST_NAME',
unistr('                when lower(:P20002_LEVEL_ID) = ''c'' and :P20002_SCHOLARSHIP_RECIPIENT = ''D'' then :P20002_REQUEST_NAME    -- tr\01B0\1EDDng h\1EE3p CEO t\1EA1o \0111\01A1n'),
'            else',
'                :P20002_EMPLOYEE_CODE',
'            end,',
'        REQUESTER_DEPARTMENT = :P20002_DEPARTMENT,',
'        REQUESTER_DEPARTMENT_CODE = :P20002_DEPARTMENT_CODE,',
'        REQUESTER_LEVEL = :P20002_LEVEL,',
'        PARTNER_NAME = :P20002_PARTNER_NAME,',
'        PARTNER_PHONE = :P20002_PARTNER_PHONE,',
'        PARTNER_TITLE = :P20002_TITLE,',
'        PARTNER_DEPARTMENT = :P20002_PARTNER_DEPARTMENT,',
'        PARTNER_FIELD = :P20002_FIELD,',
'        PARTNER_WORKPLACE = :P20002_WORKPLACE,',
'        RECIPIENT_NAME = :P20002_RECIPIENT_NAME,',
'        RECIPIENT_DOB = TO_DATE(:P20002_RECIPIENT_DOB, ''DD/MM/YYYY''),',
'        RECIPIENT_PHONE = :P20002_RECIPIENT_PHONE,',
'        RECIPIENT_RELATIONSHIP = :P20002_RELATIONSHIP,',
'        RECIPIENT_CAMPUS = :P20002_CAMPUS,',
'        ATTACH_NAME = :P20002_NAME_FILES,',
'        ATTACH_FILE = :P20002_URL_FILES,',
'        RECIPIENT_REPLACEMENT = :P20002_REPLACEMENT,',
'        RECIPIENT_VOUCHER_CODE_REPLACEMENT = :P20002_VOUCHER_CODE_REPLACEMENT,',
'        RECIPIENT_EXPIRATION_DATE_REPLACEMENT = TO_DATE(:P20002_EXPIRATION_DATE_REPLACEMENT, ''DD/MM/YYYY''),',
'        RECIPIENT_NOTE = :P20002_NOTE,',
'        RECIPIENT_REASON_REQUEST = :P20002_REASON_REQUEST,',
'        DISCOUNT_RATE = discount_rate,',
'        VOUCHER_CODE = :P20002_VOUCHER_CODE,',
'        NUMBER_OF_COURSES = :P20002_NUMBER_OF_COURSES,',
'        EFFECTIVE_DATE = TO_DATE(:P20002_EFFECTIVE_DATE, ''DD/MM/YYYY''),',
'        EXPIRATION_DATE = TO_DATE(:P20002_EXPIRATION_DATE, ''DD/MM/YYYY''),',
'        -- APPROVED_DATE = :P20002_APPROVED_DATE,',
'        CREATED_DATE = c_date,',
'        ID_COREEDU_PROMOTION = :P20002_DISCOUNT_RATE',
'    WHERE :P20002_REQUEST_ID = sr.ID;',
'',
'    UPDATE EMP_REQUESTS emp',
'    SET',
'        NOTE = ',
'            CASE ',
'                WHEN :P20002_SCHOLARSHIP_RECIPIENT = ''A'' OR :P20002_SCHOLARSHIP_RECIPIENT = ''B'' THEN :P20002_NOTE',
'                ELSE :P20002_REASON_REQUEST',
'            END',
'    WHERE :P20002_REQUEST_ID = emp.REQUEST_DETAIL_ID AND LOWER(:P20002_FEATURE) = LOWER(emp.REQUEST_TYPE);',
'',
'',
'    -- Insert ATTACHMENT_HISTORY',
'    -- IF(:P20002_DEFAULT_IMAGES_URL != :P20002_URL_FILES) THEN',
'    -- Insert ATTACHMENT_HISTORY',
'    IF(remove_first_semicolon(:P20002_DEFAULT_IMAGES_URL) != :P20002_URL_FILES or',
'       ( :P20002_REQUEST_ID is null and :P20002_URL_FILES is not null )) ',
'    THEN',
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
'    DELETE FROM WORKFLOW_DETAIL wd',
'    WHERE REQUEST_ID = (select emp.ID from EMP_REQUESTS emp where :P20002_REQUEST_ID = emp.REQUEST_DETAIL_ID and LOWER(:P20002_FEATURE) = LOWER(REQUEST_TYPE));',
'',
'    DELETE FROM EMP_REQUESTS emp',
'    WHERE :P20002_REQUEST_ID = emp.REQUEST_DETAIL_ID AND LOWER(:P20002_FEATURE) = LOWER(REQUEST_TYPE);',
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
prompt --application/end_environment
begin
wwv_flow_imp.import_end(p_auto_install_sup_obj => nvl(wwv_flow_application_install.get_auto_install_sup_obj, false));
commit;
end;
/
set verify on feedback on define on
prompt  ...done
