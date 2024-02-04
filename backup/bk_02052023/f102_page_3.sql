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
--   Date and Time:   21:07 Sunday February 4, 2024
--   Exported By:     ERP
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 3
--   Manifest End
--   Version:         23.2.3
--   Instance ID:     7949320442804181
--

begin
null;
end;
/
prompt --application/pages/delete_00003
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>3);
end;
/
prompt --application/pages/page_00003
begin
wwv_flow_imp_page.create_page(
 p_id=>3
,p_name=>'Leave Request for Employee'
,p_alias=>'LEAVE-REQUEST'
,p_step_title=>'New Leave Request'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_css_file_urls=>'https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/css/erp-style.css'
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'span.apex-item-display-only {',
'  background-color: #e4e4e4 !important;',
'  background: #e4e4e4 !important;',
'  color: black !important;',
'  cursor: var(--a-button-disabled-cursor, default);',
'  opacity: var(--a-button-disabled-opacity, 0.5);',
'  pointer-events: none;',
'}',
'',
'/* Center the loader container */',
'.loader-container {',
'  position: fixed;',
'  top: 0;',
'  left: 0;',
'  width: 100%;',
'  height: 100%;',
'  background-color: rgba(0, 0, 0, 0.7);',
'  display: flex;',
'  justify-content: center;',
'  align-items: center;',
'  z-index: 9999;',
'  /* Ensure it''s above other elements */',
'}',
'',
'/* Define the loader animation */',
'.loader {',
'  border: 4px solid rgba(255, 255, 255, 0.3);',
'  border-top: 4px solid #2196f3;',
'  border-radius: 50%;',
'  width: 50px;',
'  height: 50px;',
'  animation: spin 2s linear infinite;',
'  position: absolute;',
'  left: 0;',
'  top: 0;',
'  bottom: 0;',
'  right: 0;',
'  margin: auto;',
'}',
'',
'@keyframes spin {',
'  0% {',
'    transform: rotate(0deg);',
'  }',
'',
'  100% {',
'    transform: rotate(360deg);',
'  }',
'}',
'',
'/* Hide the loader initially */',
'.loader-container {',
'  display: none;',
'}',
'.btn-delete {',
'  color: white;',
'  font-size: 12px;',
'  cursor: pointer;',
'  background: red !important;',
'  display: flex;',
'  width: 20px;',
'  height: 20px;',
'  text-align: center;',
'  border-radius: 50%;',
'  align-items: center;',
'  justify-content: center;',
'}',
'.file-item {',
'  display: flex;',
'  gap: 10px;',
'  margin: 15px 0;',
'}',
'.u-Processing {',
'   display:none !important;',
'}',
'',
'#P3_URL_FILES {',
'    display: none;',
'}',
'#btnSubmitLeave {',
'    display: none !important;',
'}',
'',
'',
'/* #loader-container {',
'    display: none !important;',
'} */',
'',
'.apex-item-group.apex-item-group--textarea {',
'    margin-top: 20px;',
'}',
'',
'.__standard_schedule .apex-item-group.apex-item-group--popup-lov {',
'    padding-left: 0 !important;',
'}',
'',
'#pre_submit {',
'    background-color: #056ac8 !important;',
'}',
'#pre_submit .t-Button-label {',
'    color: #ffffff !important;',
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
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_page_component_map=>'16'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20231213042605'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(7871668432886705)
,p_plug_name=>'Bottom content'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>30
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
'        var imageUrlsID = apex.item("P3_DEFAULT_IMAGES_URL").getValue();',
'        var imageNamesID = apex.item("P3_DEFAULT_IMAGES_NAME").getValue();',
'        var imageContainer = document.getElementById("P3_UPLOAD_FILE_GROUP");',
'        const urlArray = imageUrlsID.split(";");',
'        const nameArray = imageNamesID.split(";");',
'        apex.item("P3_URL_FILES").setValue(imageUrlsID);',
'        apex.item("P3_NAME_FILES").setValue(imageNamesID);',
'',
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
'        var userName = apex.item("P3_EMPLOYEE").getValue();',
'        var userCode = apex.item("P3_EMPLOYEE_CODE").getValue();',
'',
'        formData_PP.append("name", userName);',
'        formData_PP.append("msnv", userCode);',
'        document',
'            .getElementById("P3_UPLOAD_FILE")',
'            .addEventListener("change", function (event) {',
'                const imageFiles = event.target.files;',
'                const hiddenInputContainer = document.getElementById(',
'                    "P3_UPLOAD_FILE_GROUP"',
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
'    document.addEventListener(''DOMContentLoaded'', function() {',
'    document',
'        .getElementById("pre_submit")',
'        .addEventListener("click", async function (event) {',
'            console.log("click pre_submit");',
'            let nullFormData = false;',
'            const elements = document.querySelectorAll(".dynamic-value-page");',
'            const names = [];',
'            const hrefs = [];',
'            var imageNamesID = apex.item("P3_DEFAULT_IMAGES_NAME").getValue();',
'            const nameArray = imageNamesID.split(";");',
'',
'            // document.getElementById(''loader-container'').style.display = ''block'';',
'            for (const value of formData_PP.values()) {',
'                if (value.name != null) {',
'                    nullFormData = true;',
'                }',
'            }',
'',
'            if (nullFormData) {',
'                try {',
'                    const response = await fetch("https://graphapi.vus.edu.vn/upload", {',
'                        method: "POST",',
'                        body: formData_PP,',
'                    });',
'',
'                    if (response.status === 200) {',
'                        const responseBody = await response.json();',
'                        fileNames_PP = responseBody.data.map((item) => item.name).join(";");',
'                        fileUrls_PP = responseBody.data.map((item) => item.path).join(";");',
'                        const newfileUrls_PP = fileArrayUrls_PP.join(";") + ";" + fileUrls_PP;',
'                        const newfileNames_PP = fileArrayNames_PP.join(";") + ";" + fileNames_PP;',
'                        await apex.item("P3_URL_FILES").setValue(newfileUrls_PP);',
'                        await apex.item("P3_NAME_FILES").setValue(newfileNames_PP);',
'                    } else {',
'                        console.log("Upload failed");',
'                    }',
'                } catch (error) {',
'                    console.error("An error occurred:", error);',
'                } finally {',
'                    document.getElementById("loader-container").style.display = "none";',
'',
'                    setTimeout(function () {',
'                        apex.submit("Submit");',
'                    }, 500);',
'                    // apex.submit("btn_submit");',
'',
'                }',
'            } else {',
'                await elements.forEach((element) => {',
'                    const name = element.getAttribute("name");',
'                    const href = element.getAttribute("href");',
'',
'                    if (name && href) {',
'                        names.push(name);',
'                        hrefs.push(href);',
'                    }',
'                });',
'                namesString = names.join(";");',
'                urlString = hrefs.join(";");',
'                const missingValuesNameId = await nameArray.filter(',
'                    (value) => !names.includes(value)',
'                );',
'                const urlDelete =',
'                    "https://graphapi.vus.edu.vn/delete-multiple-objects-vng-cloud";',
'',
'                const data = {',
'                    fileNames: missingValuesNameId,',
'                };',
'',
'                console.log(missingValuesNameId);',
'                const requestOptions = {',
'                    method: "POST",',
'                    headers: {',
'                        "Content-Type": "application/json",',
'                    },',
'                    body: JSON.stringify(data),',
'                };',
'                try {',
'                    await fetch(urlDelete, requestOptions)',
'                        .then((response) => {',
'                            if (!response.ok) {',
'                                throw new Error("Network response was not ok");',
'                            }',
'                            return response.json();',
'                        })',
'                        .then((data) => {',
'                            console.log(data);',
'                        });',
'                } catch (error) {',
'                    console.error("Error:", error);',
'                } finally {',
'                    document.getElementById("loader-container").style.display = "none";',
'                }',
'',
'                await apex.item("P3_URL_FILES").setValue(urlString);',
'                await apex.item("P3_NAME_FILES").setValue(namesString);',
'',
'                setTimeout(function () {',
'                    apex.submit("Submit");',
'                }, 500);',
'                // apex.submit("btn_submit");',
'',
'            }',
'            document.getElementById("loader-container").style.display = "none";',
'        });',
'    });',
'',
'</script>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(7872038544886709)
,p_plug_name=>'Button'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>40
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10203651573745946)
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
 p_id=>wwv_flow_imp.id(18570758181190639)
,p_plug_name=>'Left content'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>10
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(18571673124190648)
,p_plug_name=>'Right content'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>20
,p_plug_new_grid_row=>false
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(7872298095886711)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(7872038544886709)
,p_button_name=>'Submit'
,p_button_static_id=>'btnSubmitLeave'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_position=>'NEXT'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(12440838517222311)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(7872038544886709)
,p_button_name=>'Pre_Submit'
,p_button_static_id=>'pre_submit'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_position=>'NEXT'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(7872181374886710)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(7872038544886709)
,p_button_name=>'Cancel'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancel'
,p_button_position=>'NEXT'
,p_warn_on_unsaved_changes=>null
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(7871293790886701)
,p_name=>'P3_LEAVE_TYPE_DEPT'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(18571673124190648)
,p_item_default=>'SELECT SCHEDULE FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Standard Schedule'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex_disabled'
,p_grid_row_css_classes=>'__standard_schedule'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(7871300903886702)
,p_name=>'P3_START_TIME'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(18571673124190648)
,p_item_default=>'00:00'
,p_pre_element_text=>'Start Time'
,p_display_as=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_cSize=>30
,p_display_when=>'P3_LEAVE_TYPE_DEPT'
,p_display_when2=>'HO'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
,p_attribute_07=>'0'
,p_attribute_08=>'false'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(7871400676886703)
,p_name=>'P3_END_TIME'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(18571673124190648)
,p_item_default=>'00:00'
,p_pre_element_text=>'End Time'
,p_format_mask=>'90:99'
,p_display_as=>'PLUGIN_DE.DANIELH.CLOCKPICKER'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_css_classes=>'apex_disabled'
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'bottom'
,p_attribute_02=>'left'
,p_attribute_03=>'true'
,p_attribute_04=>'Done'
,p_attribute_05=>'false'
,p_attribute_06=>'0'
,p_attribute_07=>'0'
,p_attribute_08=>'false'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(7871515852886704)
,p_name=>'P3_ANNUAL_LEAVE_BALANCE'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(18571673124190648)
,p_item_default=>'0'
,p_pre_element_text=>'Current leave balance (days)'
,p_format_mask=>'99.9'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex_disabled'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(7871778753886706)
,p_name=>'P3_APPROVED_MANAGER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(7871668432886705)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT EMPLOYEE_ID as ID FROM EMPLOYEES WHERE POSITION_ID = (',
'select MANAGER_POSITION_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE )'))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Approved Manager'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT FULL_NAME,EMPLOYEE_ID as ID FROM EMPLOYEES WHERE POSITION_ID = (',
'select MANAGER_POSITION_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE )'))
,p_cHeight=>1
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(7871897843886707)
,p_name=>'P3_NOTE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(7871668432886705)
,p_pre_element_text=>'Note'
,p_display_as=>'NATIVE_TEXTAREA'
,p_cSize=>30
,p_cHeight=>5
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
,p_attribute_02=>'N'
,p_attribute_03=>'N'
,p_attribute_04=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(7871955118886708)
,p_name=>'P3_UPLOAD_FILE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(7871668432886705)
,p_item_default=>'#'
,p_pre_element_text=>'Attach file'
,p_display_as=>'NATIVE_FILE'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_icon_css_classes=>'fa-arrow-up-alt'
,p_item_template_options=>'#DEFAULT#'
,p_inline_help_text=>'<strong><em style="color:#0784f9; opacity:0.8;">Please upload files with a maximum size of 1 MB, up to 5 files at a time!</em></strong>'
,p_attribute_01=>'APEX_APPLICATION_TEMP_FILES'
,p_attribute_09=>'SESSION'
,p_attribute_10=>'Y'
,p_attribute_12=>'INLINE'
,p_attribute_13=>'Upload File'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8276663681603817)
,p_name=>'P3_MANAGER_CODE'
,p_item_sequence=>50
,p_item_default=>'select MANAGER_POSITION_ID FROM EMPLOYEES e WHERE e.USER_NAME = :APP_USER_NAME'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(9261833181015825)
,p_name=>'P3_LEAVE_DETAIL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(18571673124190648)
,p_item_default=>'-- Leave Detail --'
,p_pre_element_text=>'Leave Detail'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ACL_DESCRIPTION, ACL_ABSENCECODE_ID as ID ',
'FROM ABSENCE_CODE_LIST',
'WHERE ABSENCE_GROUP = :P3_ANNUAL_LEAVE',
'ORDER BY ACL_DESCRIPTION;'))
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10578539296987833)
,p_name=>'P3_URL_FILES'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(7871668432886705)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_encrypt_session_state_yn=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10578663388987834)
,p_name=>'P3_NAME_FILES'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(7871668432886705)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18570865103190640)
,p_name=>'P3_EMPLOYEE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(18570758181190639)
,p_item_default=>'select full_name from employees where EMPLOYEE_CODE = :APP_EMP_CODE'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Employee'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex-disabled'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18570916984190641)
,p_name=>'P3_ANNUAL_LEAVE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(18570758181190639)
,p_item_default=>'-- Leave Type --'
,p_pre_element_text=>'Leave Type'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ACGL_DESCRIPTION,ACGL_ABSENCE_GROUP_ID as ID ',
'FROM ABSENCE_CODE_GROUP_LIST ',
'order by ACGL_DESCRIPTION'))
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'Y'
,p_attribute_06=>'0'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18571037509190642)
,p_name=>'P3_ALL_DAY'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(18570758181190639)
,p_item_default=>'Y'
,p_pre_element_text=>'All Day'
,p_display_as=>'NATIVE_YES_NO'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18571162536190643)
,p_name=>'P3_FROM_DATE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(18570758181190639)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- select TO_DATE(sysdate, ''MM/DD/YYYY'') from dual',
'select TO_CHAR(TO_DATE(sysdate, ''MM/DD/YYYY''),''DD/MM/YYYY'') from dual'))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'From Date'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(18571287848190644)
,p_name=>'P3_END_DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(18570758181190639)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- select TO_DATE(sysdate, ''MM/DD/YYYY'') from dual',
'select TO_CHAR(TO_DATE(sysdate, ''MM/DD/YYYY''),''DD/MM/YYYY'') from dual'))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'End Date'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'POPUP'
,p_attribute_03=>'ITEM'
,p_attribute_05=>'P3_FROM_DATE'
,p_attribute_06=>'NONE'
,p_attribute_09=>'N'
,p_attribute_11=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18571387630190645)
,p_name=>'P3_TOTAL_DAYS'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(18570758181190639)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'--case :P3_ALL_DAY',
'--when ''Y'' then',
'--TO_DATE(:P3_END_DATE) - TO_DATE(:P3_FROM_DATE)',
'--else',
'--TO_DATE(:P3_END_DATE,''MM/DD/YYY'')-TO_DATE(:P3_FROM_DATE,''MM/DD/YYY'')+0.5',
'--null',
'--end ',
'--as total_days',
'0',
'FROM DUAL;'))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Total days'
,p_format_mask=>'99.9'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex_disabled'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18571720699190649)
,p_name=>'P3_EMPLOYEE_CODE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(18571673124190648)
,p_item_default=>'APP_EMP_CODE'
,p_item_default_type=>'ITEM'
,p_pre_element_text=>'Employee Code'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex-disabled'
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18571898296190650)
,p_name=>'P3_CURRENT_TIME_PROFILE'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(18571673124190648)
,p_item_default=>'SELECT PROFILE_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :APP_EMP_CODE'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Current Time Profile'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex_disabled'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(20705947843292524)
,p_name=>'P3_START_TIME_HO'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(18571673124190648)
,p_item_default=>'08:00'
,p_pre_element_text=>'Start Time'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_named_lov=>'START_TIME_FOR_HO'
,p_lov=>'.'||wwv_flow_imp.id(20982961957329300)||'.'
,p_cHeight=>1
,p_display_when=>'P3_LEAVE_TYPE_DEPT'
,p_display_when2=>'HO'
,p_display_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'NO'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(21551066235728608)
,p_name=>'P3_REQUEST_ID_IMPORTED'
,p_item_sequence=>60
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25094660915455603)
,p_name=>'P3_DEFAULT_IMAGES_URL'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(7871668432886705)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25094796352455604)
,p_name=>'P3_DEFAULT_IMAGES_NAME'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(7871668432886705)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(12441890204222321)
,p_validation_name=>'Check Leave_Type'
,p_validation_sequence=>20
,p_validation=>'P3_ANNUAL_LEAVE'
,p_validation2=>'-- Leave Type --'
,p_validation_type=>'ITEM_IN_VALIDATION_NOT_EQ_STRING2'
,p_error_message=>'Please choose a valid leave type!'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_imp.id(7872298095886711)
,p_associated_item=>wwv_flow_imp.id(18570916984190641)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(11557228748621529)
,p_validation_name=>'Check Leave_Detail'
,p_validation_sequence=>30
,p_validation=>'P3_LEAVE_DETAIL'
,p_validation2=>'--Leave Detail--'
,p_validation_type=>'ITEM_IN_VALIDATION_NOT_EQ_STRING2'
,p_error_message=>'Please choose a valid leave detail!'
,p_always_execute=>'Y'
,p_validation_condition=>'P3_ANNUAL_LEAVE'
,p_validation_condition2=>'APL'
,p_validation_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_when_button_pressed=>wwv_flow_imp.id(7872298095886711)
,p_associated_item=>wwv_flow_imp.id(9261833181015825)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(8548096260038911)
,p_validation_name=>'Check total'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    v_maximum_days NUMBER;',
'    v_total_of_year NUMBER;',
'    v_max_per_year NUMBER;',
'    v_total_month NUMBER;',
'    flag boolean;',
'',
'    n_total_days NUMBER;',
'    n_balance_days NUMBER;',
'BEGIN',
'    flag := TRUE; ',
'    v_total_of_year := 0;',
'',
'    IF :P3_ANNUAL_LEAVE_BALANCE = ''0.5'' THEN',
'        n_balance_days := 0.5;',
'    ELSE',
'        n_balance_days := to_number(:P3_ANNUAL_LEAVE_BALANCE);',
'    END IF;',
'',
'    -- Calculate maximum total month for other leave types',
'    IF trim(:P3_ANNUAL_LEAVE) != ''APL'' THEN',
'        SELECT MAXIMUM_MONTHS_LIMIT_PER_TIME into v_total_month FROM ABSENCE_CODE_LIST ',
'        WHERE lower(ACL_ABSENCECODE_ID) = lower(:P3_LEAVE_DETAIL) AND ROWNUM=1;',
'    END IF;',
'',
'    IF trim(:P3_ANNUAL_LEAVE) = ''APL'' THEN',
'        SELECT TO_NUMBER(n_balance_days)',
'        INTO v_maximum_days',
'        FROM DUAL;',
'    ELSIF v_total_month != 99999 THEN',
'        v_maximum_days := TO_DATE(:P3_FROM_DATE, ''DD/MM/YYYY'') + interval ''1'' month * v_total_month - TO_DATE(:P3_FROM_DATE, ''DD/MM/YYYY'');',
'    ELSE',
'        -- Check MAXIMUM_LIMIT_PER_TIME of other types',
'        SELECT MAXIMUM_LIMIT_PER_TIME',
'        INTO v_maximum_days',
'        FROM ABSENCE_CODE_LIST',
'        WHERE TRIM(LOWER(ACL_ABSENCECODE_ID)) = TRIM(LOWER(:P3_LEAVE_DETAIL));',
'',
'        -- Check MAXIMUM_LIMIT_PER_YEAR of other types',
'        SELECT NVL(SUM(er.TOTAL_DAYS),0) INTO v_total_of_year FROM EMPLOYEE_REQUESTS er',
'        WHERE EMPLOYEE_CODE_REQ = :P3_EMPLOYEE_CODE ',
'        AND EMP_REQ_STATUS in (2,3) ',
'        AND LOWER(er.BENEFIT_CODE) = TRIM(LOWER(:P3_LEAVE_DETAIL))',
'        AND EXTRACT(YEAR FROM er.FROM_DATE) = EXTRACT(YEAR FROM TO_DATE(:P3_FROM_DATE, ''DD/MM/YYYY''));',
'',
'        SELECT MAXIMUM_LIMIT_PER_YEAR INTO v_max_per_year FROM ABSENCE_CODE_LIST  ',
'        WHERE TRIM(LOWER(ACL_ABSENCECODE_ID)) = TRIM(LOWER(:P3_LEAVE_DETAIL));',
'',
'    END IF;',
'',
'    -- There will be a case :P3_TOTAL_DAYS = ''0.5'', so we need to convert it to number',
'',
'    IF :P3_TOTAL_DAYS = ''0.5'' THEN',
'        n_total_days := 0.5;',
'    ELSE',
'        n_total_days := to_number(:P3_TOTAL_DAYS);',
'    END IF;',
'',
'    -- Validate total days APL & total days per time',
'    IF (n_total_days <= v_maximum_days) THEN',
'        flag := TRUE;',
'    ELSE',
'        flag := FALSE;',
'    END IF;',
'',
'    -- Validate total days per year of other types',
'    IF (trim(:P3_ANNUAL_LEAVE) != ''APL'') AND (n_total_days + v_total_of_year > v_max_per_year) THEN ',
'        flag := FALSE;',
'    END IF;',
'',
'',
'    return flag;',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Requested leave days exceeds the maximum limit!'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_imp.id(7872298095886711)
,p_associated_item=>wwv_flow_imp.id(18571387630190645)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
end;
/
begin
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(11557132374621528)
,p_validation_name=>'Check End Date'
,p_validation_sequence=>50
,p_validation=>'to_date(:P3_END_DATE,''DD/MM/YYYY'') >= to_date(:P3_FROM_DATE,''DD/MM/YYYY'')'
,p_validation2=>'PLSQL'
,p_validation_type=>'EXPRESSION'
,p_error_message=>'The end date must be later than the from date.'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_imp.id(7872298095886711)
,p_associated_item=>wwv_flow_imp.id(18571287848190644)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(20705488461292519)
,p_validation_name=>'Check overlapping leaves'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    TOTAL_OVERLAP_DAYS NUMBER := 0;',
'    V_TOTAL_DAYS       NUMBER;',
'    V_EMP_REQ_STATUS   NUMBER;',
'    flag BOOLEAN := true;',
'    p3_total_days NUMBER;',
'BEGIN',
'    -- There will be case :P3_TOTAL_DAYS = ''0.5''',
'    p3_total_days := case when :P3_TOTAL_DAYS = ''0.5'' then 0.5 else TO_NUMBER(:P3_TOTAL_DAYS) end;',
'    -- p3_total_days := TO_NUMBER(:P3_TOTAL_DAYS);',
'',
'    IF(:P3_ALL_DAY = ''N'') THEN',
'        :P3_END_DATE := :P3_FROM_DATE;',
'        p3_total_days := 0.5;',
'    END IF;',
'',
'    FOR REC IN (',
'        SELECT',
'            ER.TOTAL_DAYS,',
'            ER.EMP_REQ_STATUS,',
'            ER.FROM_DATE,',
'            ER.END_DATE',
'        FROM',
'            EMPLOYEE_REQUESTS ER',
'        WHERE',
'            ER.EMPLOYEE_CODE_REQ = :APP_EMP_CODE ',
'            AND (TO_DATE(:P3_END_DATE, ''DD/MM/YYYY'') >= TO_DATE(ER.FROM_DATE, ''MM/DD/YYYY'') ',
'            AND TO_DATE(:P3_FROM_DATE, ''DD/MM/YYYY'') <= TO_DATE(ER.END_DATE, ''MM/DD/YYYY''))',
'    ) LOOP',
'        -- INSERT INTO OUTPUT_LOGS(STR1) VALUES (rec.FROM_DATE || ''->'' || rec.END_DATE || '':'' || rec.EMP_REQ_STATUS);',
'        DBMS_OUTPUT.put_line(rec.FROM_DATE || '' -> '' || rec.END_DATE || '' : '' || rec.EMP_REQ_STATUS);',
'',
'        IF REC.EMP_REQ_STATUS = 5 THEN',
'            -- V_TOTAL_DAYS := -REC.TOTAL_DAYS;',
'            V_TOTAL_DAYS := 0;',
'        ELSIF REC.EMP_REQ_STATUS = 2 OR REC.EMP_REQ_STATUS = 3 THEN',
'            V_TOTAL_DAYS := TO_NUMBER(REC.TOTAL_DAYS);',
'        ELSE',
'            V_TOTAL_DAYS := 0;',
'        END IF;',
'        TOTAL_OVERLAP_DAYS := TOTAL_OVERLAP_DAYS + V_TOTAL_DAYS;',
'    END LOOP;',
'        ',
'    DBMS_OUTPUT.put_line(''TOTAL_OVERLAP_DAYS = '' || TOTAL_OVERLAP_DAYS);',
'',
'    IF TOTAL_OVERLAP_DAYS >= 1 ',
'        OR (TO_NUMBER(p3_total_days) = 0.5 AND TOTAL_OVERLAP_DAYS > 0.5)',
'        OR (TOTAL_OVERLAP_DAYS = 0.5 AND TO_NUMBER(p3_total_days) >= 1 ) THEN',
'        flag := FALSE;',
'    ELSE',
'        flag := TRUE;',
'    END IF;',
'    ',
'    -- IF flag THEN DBMS_OUTPUT.put_line(''TRUE''); ELSE DBMS_OUTPUT.put_line(''FALSE''); END IF;',
'',
'    return flag;',
'    ',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'A leave already exists within the time period you submitted. Please review your leave history and adjust the dates accordingly.'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_imp.id(7872298095886711)
,p_associated_item=>wwv_flow_imp.id(18571287848190644)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(21887641647509941)
,p_validation_name=>'Check overlapping time'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE ',
'    IS_NOT_OVERLAPPED BOOLEAN := TRUE;',
'    INP_START_TIME NVARCHAR2(10);',
'    INP_END_TIME NVARCHAR2(10);',
'    rec_start NVARCHAR2(10);',
'    rec_end NVARCHAR2(10);',
'BEGIN',
'    INP_START_TIME := TRIM(:P3_START_TIME);',
'    INP_END_TIME := TRIM(:P3_END_TIME);',
'    ',
'    FOR rec IN (SELECT start_time, end_time ',
'                FROM EMPLOYEE_REQUESTS ',
'                WHERE EMPLOYEE_CODE_REQ = :P3_EMPLOYEE_CODE ',
'                AND EMP_REQ_STATUS in (2,3)',
'                AND :P3_ALL_DAY = ''N'' ',
'                AND TO_DATE(:P3_FROM_DATE, ''DD/MM/YYYY'') = FROM_DATE)',
'    LOOP',
'        rec_start := rec.start_time;',
'        rec_end := rec.end_time;',
'        DBMS_OUTPUT.put_line(rec_start || ''-'' || rec_end);',
'        ',
'        -- Check if overlap with INP_START_TIME, INP_END_TIME',
'        IF (INP_START_TIME < rec_end) AND (INP_END_TIME > rec_start) THEN',
'            -- IS_NOT_OVERLAPPED := TRUE;',
'            IS_NOT_OVERLAPPED := FALSE;',
'            EXIT;  -- No need to check further if we found an overlap',
'        END IF;',
'    END LOOP;',
'    ',
'',
'    -- Print IS_NOT_OVERLAPPED ',
'    -- IF IS_NOT_OVERLAPPED THEN',
'    --     DBMS_OUTPUT.put_line(''The time intervals overlap.'');',
'    -- ELSE',
'    --     DBMS_OUTPUT.put_line(''The time intervals do not overlap.'');',
'    -- END IF;',
'',
'    RETURN IS_NOT_OVERLAPPED;',
'',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'A leave already exists within the timeline period you submitted. Please review your leave history and adjust the dates accordingly.'
,p_validation_condition=>'P3_ALL_DAY'
,p_validation_condition2=>'N'
,p_validation_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_when_button_pressed=>wwv_flow_imp.id(7872298095886711)
,p_associated_item=>wwv_flow_imp.id(7871300903886702)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(22746701151164446)
,p_validation_name=>'Check 23rd day'
,p_validation_sequence=>80
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- declare ',
'-- date_23_last_month DATE;',
'-- BEGIN',
'--     select to_date(''23/''||to_char(add_months(sysdate, -1), ''MM'')||''/''||to_char(add_months(sysdate, -1), ''YYYY''), ''DD/MM/YYYY'') into date_23_last_month from dual;',
'--     IF(to_date(:P3_FROM_DATE,''DD/MM/YYYY'') >= date_23_last_month) THEN',
'--         RETURN TRUE;',
'--     ELSE RETURN FALSE;',
'--     END IF;',
'-- END;',
'',
'declare',
'    current_day date;',
'    target_day date;',
'begin',
'    -- current_day := to_date(''22/1/2023'', ''dd/mm/yyyy'');',
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
'    IF(to_date(:P3_FROM_DATE,''DD/MM/YYYY'') >= target_day) THEN',
'        RETURN TRUE;',
'    ELSE RETURN FALSE;',
'    END IF;',
'',
'    -- print',
'    -- dbms_output.put_line(''Current day: '' || to_char(current_day, ''dd/mm/yyyy''));',
'    -- dbms_output.put_line(''Target day: '' || to_char(target_day, ''dd/mm/yyyy''));',
'end;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'The selected day is within a payroll period.'
,p_always_execute=>'Y'
,p_when_button_pressed=>wwv_flow_imp.id(7872298095886711)
,p_associated_item=>wwv_flow_imp.id(18571162536190643)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(23662906575578106)
,p_validation_name=>'Check unvalid benefit acrual plan'
,p_validation_sequence=>90
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_count_is_exist_benefit NUMBER;',
'    flag BOOLEAN := true;',
'BEGIN',
'',
'    select count(*) into l_count_is_exist_benefit from ABSENCE_GROUP_EMPLOYEE',
'    where EMPLOYEE_CODE = :APP_EMP_CODE and :P3_LEAVE_DETAIL = HRM_ABSENCE_CODE_ID;',
'    -- where EMPLOYEE_CODE = :APP_EMP_CODE and :P3_LEAVE_DETAIL = HRM_ABSENCE_CODE_ID and EXPIRATION_DATE > sysdate;',
'    ',
'    if l_count_is_exist_benefit > 0 then return true;',
'        else return false;',
'    end if;',
'    ',
'END;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Your selected leave type is either not included or has expired in your benefit accrual plan.'
,p_always_execute=>'Y'
,p_validation_condition=>'P3_ANNUAL_LEAVE'
,p_validation_condition2=>'APL'
,p_validation_condition_type=>'VAL_OF_ITEM_IN_COND_NOT_EQ_COND2'
,p_when_button_pressed=>wwv_flow_imp.id(7872298095886711)
,p_associated_item=>wwv_flow_imp.id(18570916984190641)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(7872455252886713)
,p_name=>'Set display time'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_ALL_DAY'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(7873661155886725)
,p_event_id=>wwv_flow_imp.id(7872455252886713)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''#P3_START_TIME_CONTAINER'').hide();',
'$(''#P3_START_TIME_HO_CONTAINER'').hide();',
'$(''#P3_END_TIME_CONTAINER'').hide();'))
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P3_ALL_DAY'
,p_client_condition_expression=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(7873779861886726)
,p_event_id=>wwv_flow_imp.id(7872455252886713)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''#P3_START_TIME_CONTAINER'').show();',
'$(''#P3_START_TIME_HO_CONTAINER'').show();',
'$(''#P3_END_TIME_CONTAINER'').show();'))
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P3_ALL_DAY'
,p_client_condition_expression=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9260873154015815)
,p_event_id=>wwv_flow_imp.id(7872455252886713)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'Y'
,p_name=>'Disable_end_date'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#P3_END_DATE'').attr(''disabled'',true);'
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P3_ALL_DAY'
,p_client_condition_expression=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9260935296015816)
,p_event_id=>wwv_flow_imp.id(7872455252886713)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_name=>'Enable_end_date'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>'$(''#P3_END_DATE'').attr(''disabled'',false);'
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P3_ALL_DAY'
,p_client_condition_expression=>'Y'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(7872994967886718)
,p_event_id=>wwv_flow_imp.id(7872455252886713)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_name=>'Calculate Total Days'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- begin',
'-- if :P3_ALL_DAY = ''Y'' then',
'-- select ROUND(TO_DATE(:P3_END_DATE)-TO_DATE(:P3_FROM_DATE))+1 into :P3_TOTAL_DAYS FROM DUAL;',
'-- end if;',
'-- if :P3_ALL_DAY = ''N'' then',
'-- select (TO_DATE(:P3_END_DATE)-TO_DATE(:P3_FROM_DATE))+0.5 into :P3_TOTAL_DAYS FROM DUAL;',
'-- end if;',
'-- end;',
'',
'begin',
'if :P3_ALL_DAY = ''Y'' then',
'select ROUND(TO_DATE(:P3_END_DATE,''DD/MM/YYYY'')-TO_DATE(:P3_FROM_DATE,''DD/MM/YYYY''))+1 into :P3_TOTAL_DAYS FROM DUAL;',
'end if;',
'if :P3_ALL_DAY = ''N'' then',
'select (TO_DATE(:P3_END_DATE,''DD/MM/YYYY'')-TO_DATE(:P3_FROM_DATE,''DD/MM/YYYY''))+0.5 into :P3_TOTAL_DAYS FROM DUAL;',
'end if;',
'end;'))
,p_attribute_02=>'P3_FROM_DATE,P3_END_DATE,P3_ALL_DAY'
,p_attribute_03=>'P3_TOTAL_DAYS'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(8279436145603845)
,p_name=>'Change from date'
,p_event_sequence=>30
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_FROM_DATE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9261079132015817)
,p_event_id=>wwv_flow_imp.id(8279436145603845)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Change End_Date when it disabled'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''#P3_END_DATE'').attr(''value'',$(''#P3_FROM_DATE'').val());',
''))
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$(''#P3_END_DATE'').attr(''disabled'') === ''disabled'';'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9263168499015838)
,p_event_id=>wwv_flow_imp.id(8279436145603845)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'Change End_Date when it disabled'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    :P3_END_DATE := :P3_START_DATE;',
'END;',
''))
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'JAVASCRIPT_EXPRESSION'
,p_client_condition_expression=>'$(''#P3_END_DATE'').attr(''disabled'') === ''disabled'';'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(8279592050603846)
,p_event_id=>wwv_flow_imp.id(8279436145603845)
,p_event_result=>'TRUE'
,p_action_sequence=>30
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'if :P3_ALL_DAY = ''Y'' then',
'select ROUND(TO_DATE(:P3_END_DATE, ''DD/MM/YYYY'')-TO_DATE(:P3_FROM_DATE, ''DD/MM/YYYY''))+1 into :P3_TOTAL_DAYS FROM DUAL;',
'end if;',
'if :P3_ALL_DAY = ''N'' then',
'select (TO_DATE(:P3_END_DATE, ''DD/MM/YYYY'')-TO_DATE(:P3_FROM_DATE, ''DD/MM/YYYY''))+0.5 into :P3_TOTAL_DAYS FROM DUAL;',
'end if;',
'end;'))
,p_attribute_02=>'P3_FROM_DATE,P3_END_DATE,P3_ALL_DAY'
,p_attribute_03=>'P3_TOTAL_DAYS'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(8549171840038922)
,p_name=>'Change Type_1'
,p_event_sequence=>50
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_ANNUAL_LEAVE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9262633728015833)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Update Leave Detail list'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_LEAVE_DETAIL'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ACL_DESCRIPTION, ACL_ABSENCECODE_ID as ID ',
'FROM ABSENCE_CODE_LIST',
'WHERE ABSENCE_GROUP = :P3_ANNUAL_LEAVE',
'ORDER BY ACL_DESCRIPTION;'))
,p_attribute_07=>'P3_ANNUAL_LEAVE'
,p_attribute_08=>'Y'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'NOT_EQUALS'
,p_client_condition_element=>'P3_ANNUAL_LEAVE'
,p_client_condition_expression=>'APL'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9516039223313723)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'Update static Leave Detail '
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_LEAVE_DETAIL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'--Leave Detail--'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'NOT_EQUALS'
,p_client_condition_element=>'P3_ANNUAL_LEAVE'
,p_client_condition_expression=>'APL'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9262949342015836)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>40
,p_execute_on_page_init=>'Y'
,p_name=>'Show Leave_Detail'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''#P3_LEAVE_DETAIL_CONTAINER'').show();',
'$(''#P3_UPLOAD_FILE_inline_help'').show();',
''))
,p_client_condition_type=>'NOT_IN_LIST'
,p_client_condition_element=>'P3_ANNUAL_LEAVE'
,p_client_condition_expression=>'APL, -- Leave Type --'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9263093204015837)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>50
,p_execute_on_page_init=>'Y'
,p_name=>'Hide Leave_Detail'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''#P3_LEAVE_DETAIL_CONTAINER'').hide();',
'$(''#P3_UPLOAD_FILE_inline_help'').hide();',
''))
,p_client_condition_type=>'IN_LIST'
,p_client_condition_element=>'P3_ANNUAL_LEAVE'
,p_client_condition_expression=>'APL, -- Leave Type --'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(8549406802038925)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>60
,p_execute_on_page_init=>'N'
,p_name=>'Calc Balance'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'for rec in (select * from ABSENCE_GROUP_EMPLOYEE ',
'emp_al',
'right JOIN EMPLOYEES e ON emp_al.EMPLOYEE_CODE = e.EMPLOYEE_CODE',
'where USER_NAME = :APP_USER_NAME and EXPIRATION_DATE >= to_char(sysdate,''MM/DD/YYYY'') ',
' and HRM_ABSENCE_CODE_GROUP_ID = :P3_ANNUAL_LEAVE)loop',
'    if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,''MM/DD/YYYY'')  then',
'        :P3_ANNUAL_LEAVE_BALANCE := rec.AVAILABLE + rec.CARRY_FORWARD_AVALABLE;',
'    else',
'        :P3_ANNUAL_LEAVE_BALANCE := rec.AVAILABLE;',
'    end if;',
'end loop;',
'/*',
'select nvl(AVAILABLE+CARRY_FORWARD_AVALABLE,0) into :P3_ANNUAL_LEAVE_BALANCE',
'from ABSENCE_GROUP_EMPLOYEE emp_al',
'right JOIN EMPLOYEES e ON emp_al.EMPLOYEE_CODE = e.EMPLOYEE_CODE',
'where e.USER_NAME = :APP_USER_NAME and HRM_ABSENCE_CODE_GROUP_ID = :P3_ANNUAL_LEAVE and EXPIRATION_DATE >= to_char(sysdate,''MM/DD/YYYY'');',
'*/',
'end;'))
,p_attribute_02=>'P3_ANNUAL_LEAVE'
,p_attribute_03=>'P3_ANNUAL_LEAVE_BALANCE'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P3_ANNUAL_LEAVE'
,p_client_condition_expression=>'APL'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(8924587892040330)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>70
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''#P3_ANNUAL_LEAVE_BALANCE_CONTAINER'').show();',
''))
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P3_ANNUAL_LEAVE'
,p_client_condition_expression=>'APL'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(8924464885040329)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>80
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'$(''#P3_ANNUAL_LEAVE_BALANCE_CONTAINER'').hide();',
''))
,p_client_condition_type=>'NOT_EQUALS'
,p_client_condition_element=>'P3_ANNUAL_LEAVE'
,p_client_condition_expression=>'APL'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9261624951015823)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>90
,p_execute_on_page_init=>'Y'
,p_name=>'Block submit onload'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'JAVASCRIPT_EXPRESSION'
,p_affected_elements=>'$(''#btnSubmitLeave'').attr(''disabled'',true);'
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P3_ANNUAL_LEAVE'
,p_client_condition_expression=>'-- Leave Type --'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9261787487015824)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>100
,p_execute_on_page_init=>'Y'
,p_name=>'Unblock submit onload'
,p_action=>'NATIVE_SHOW'
,p_affected_elements_type=>'JAVASCRIPT_EXPRESSION'
,p_affected_elements=>'$(''#btnSubmitLeave'').attr(''disabled'',false);'
,p_client_condition_type=>'NOT_EQUALS'
,p_client_condition_element=>'P3_ANNUAL_LEAVE'
,p_client_condition_expression=>'-- Leave Type --'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9518752197313750)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>250
,p_execute_on_page_init=>'N'
,p_name=>'Update static Leave Detail '
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_LEAVE_DETAIL'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'--Leave Detail--'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'NOT_EQUALS'
,p_client_condition_element=>'P3_ANNUAL_LEAVE'
,p_client_condition_expression=>'APL'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(24801445876944234)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>260
,p_execute_on_page_init=>'Y'
,p_name=>'Change balance number format'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_ANNUAL_LEAVE_BALANCE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'0.5'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P3_ANNUAL_LEAVE_BALANCE'
,p_client_condition_expression=>'.5'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(24802572982944245)
,p_event_id=>wwv_flow_imp.id(8549171840038922)
,p_event_result=>'TRUE'
,p_action_sequence=>270
,p_execute_on_page_init=>'Y'
,p_name=>'Change balance number format'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_ANNUAL_LEAVE_BALANCE'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'0.5'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P3_ANNUAL_LEAVE_BALANCE'
,p_client_condition_expression=>',5'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(8547890619038909)
,p_name=>'Change end date'
,p_event_sequence=>60
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_END_DATE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(8547970181038910)
,p_event_id=>wwv_flow_imp.id(8547890619038909)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'if :P3_ALL_DAY = ''Y'' then',
'select ROUND(TO_DATE(:P3_END_DATE,''DD/MM/YYYY'')-TO_DATE(:P3_FROM_DATE,''DD/MM/YYYY''))+1 into :P3_TOTAL_DAYS FROM DUAL;',
'end if;',
'if :P3_ALL_DAY = ''N'' then',
'select (TO_DATE(:P3_END_DATE,''DD/MM/YYYY'')-TO_DATE(:P3_FROM_DATE,''DD/MM/YYYY''))+0.5 into :P3_TOTAL_DAYS FROM DUAL;',
'end if;',
'end;'))
,p_attribute_02=>'P3_FROM_DATE,P3_END_DATE,P3_ALL_DAY'
,p_attribute_03=>'P3_TOTAL_DAYS'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(9263201318015839)
,p_name=>'P3_TOTAL_DAYS_ON_CHANGE'
,p_event_sequence=>70
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_TOTAL_DAYS'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9263346341015840)
,p_event_id=>wwv_flow_imp.id(9263201318015839)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'Check 0.5'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_TOTAL_DAYS'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'0.5'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'EQUALS'
,p_client_condition_element=>'P3_ALL_DAY'
,p_client_condition_expression=>'N'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9517310348313736)
,p_event_id=>wwv_flow_imp.id(9263201318015839)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'Y'
,p_name=>'Check 0.5'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_TOTAL_DAYS'
,p_attribute_01=>'STATIC_ASSIGNMENT'
,p_attribute_02=>'0'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'LESS_THAN'
,p_client_condition_element=>'P3_TOTAL_DAYS'
,p_client_condition_expression=>'0'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(9515355651313716)
,p_name=>'New_1'
,p_event_sequence=>80
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_START_TIME'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9515404157313717)
,p_event_id=>wwv_flow_imp.id(9515355651313716)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Set End Time'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    :P3_END_TIME:= :P3_START_TIME;',
'END;',
''))
,p_attribute_02=>'P3_START_TIME'
,p_attribute_03=>'P3_END_TIME'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
,p_server_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_server_condition_expr1=>'disabled'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20705899273292523)
,p_event_id=>wwv_flow_imp.id(9515355651313716)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'Set END_TIME for HO'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_END_TIME'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// Parse the hour and minute from START_TIME',
'let [hour, minute] = $v("P3_START_TIME").split(":").map(Number);',
'',
'// Add 4 hours',
'hour += 4;',
'',
'// Handle situations where the hour is 24 or more',
'if (hour >= 24) {',
'  hour -= 24;',
'}',
'',
'// Update END_TIME',
'$s("P3_END_TIME", ("0" + hour).slice(-2) + ":" + ("0" + minute).slice(-2));'))
,p_client_condition_type=>'NOT_EQUALS'
,p_client_condition_element=>'P3_LEAVE_TYPE_DEPT'
,p_client_condition_expression=>'HO'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(12440965232222312)
,p_name=>'On_click Pre_submit'
,p_event_sequence=>90
,p_triggering_element_type=>'BUTTON'
,p_triggering_button_id=>wwv_flow_imp.id(7872181374886710)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'click'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(12442175766222324)
,p_event_id=>wwv_flow_imp.id(12440965232222312)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Turn on loading'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'//$("#loader-container").css("display", "block");',
'console.log(''Loading'');',
''))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(20706178884292526)
,p_name=>'On change'
,p_event_sequence=>100
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_START_TIME_HO'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(20706267988292527)
,p_event_id=>wwv_flow_imp.id(20706178884292526)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'Y'
,p_name=>'Set End_time_ho'
,p_action=>'NATIVE_EXECUTE_PLSQL_CODE'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    :P3_END_TIME := CASE',
'        WHEN TRIM(:P3_START_TIME_HO) = ''08:00'' THEN ''12:00''',
'        WHEN TRIM(:P3_START_TIME_HO) = ''13:30'' THEN ''18:00''',
'    END;',
'END;'))
,p_attribute_02=>'P3_START_TIME_HO'
,p_attribute_03=>'P3_END_TIME'
,p_attribute_04=>'N'
,p_attribute_05=>'PLSQL'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(23663682883578113)
,p_name=>'Leave_detail onchange'
,p_event_sequence=>110
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_LEAVE_DETAIL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(23664982781578126)
,p_name=>'ON_CHANGE_FROM_DATE_AND_LEAVE_DETAIL'
,p_event_sequence=>120
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P3_FROM_DATE,P3_LEAVE_DETAIL'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23664532874578122)
,p_event_id=>wwv_flow_imp.id(23664982781578126)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Change End_Date when in specified absence_code'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P3_END_DATE'
,p_attribute_01=>'FUNCTION_BODY'
,p_attribute_06=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_start_time NUMBER;',
'    v_end_time NUMBER;',
'    o_end_date DATE;',
'    total_month number;',
'begin',
'    -- v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second',
'    -- LOOP',
'    --     v_end_time := DBMS_UTILITY.GET_TIME;',
'    --     EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds',
'    -- END LOOP;',
'    ',
'    -- SELECT MAXIMUM_LIMIT_PER_TIME INTO v_total_maxium_date FROM ABSENCE_CODE_LIST WHERE lower(ACL_ABSENCECODE_ID) = lower(:P3_LEAVE_DETAIL) AND ROWNUM=1;',
'    -- return TO_CHAR((to_date(:P3_FROM_DATE,''DD/MM/YYYY'') + INTERVAL ''1'' DAY * (FLOOR(abs(v_total_maxium_date)) - 1)),''DD/MM/YYYY'');',
'',
'    SELECT MAXIMUM_MONTHS_LIMIT_PER_TIME into total_month FROM ABSENCE_CODE_LIST WHERE lower(ACL_ABSENCECODE_ID) = lower(:P3_LEAVE_DETAIL) AND ROWNUM=1;',
'    -- DBMS_OUTPUT.PUT_LINE(total_month);',
'    o_end_date := to_date(:P3_FROM_DATE, ''DD/MM/YYYY'') + interval ''1'' month * total_month - interval ''1'' day;',
'    -- DBMS_OUTPUT.PUT_LINE(TO_CHAR(o_end_date,''DD/MM/YYYY''));',
'',
'    return TO_CHAR(o_end_date,''DD/MM/YYYY'');    ',
'',
'end;'))
,p_attribute_07=>'P3_FROM_DATE,P3_LEAVE_DETAIL'
,p_attribute_08=>'N'
,p_attribute_09=>'N'
,p_wait_for_result=>'Y'
,p_client_condition_type=>'IN_LIST'
,p_client_condition_element=>'P3_LEAVE_DETAIL'
,p_client_condition_expression=>'ML2,ML3,ML4,ML5'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(23027018818956606)
,p_name=>'auto_close_noti'
,p_event_sequence=>130
,p_bind_type=>'bind'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23027151149956607)
,p_event_id=>wwv_flow_imp.id(23027018818956606)
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
end;
/
begin
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23027259873956608)
,p_event_id=>wwv_flow_imp.id(23027018818956606)
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
unistr('        }, 5000); // \0110\1ED5i 3000 (3 gi\00E2y) th\00E0nh 5000 \0111\1EC3 l\00E0m 5 gi\00E2y n\1EBFu c\1EA7n'),
unistr('        clearInterval(checkExist); // X\00F3a interval sau khi \0111\00E3 t\00ECm th\1EA5y v\00E0 x\1EED l\00FD th\00F4ng b\00E1o'),
'     }',
unistr('  }, 500); // Ki\1EC3m tra m\1ED7i n\1EEDa gi\00E2y'),
'});',
''))
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(7872380520886712)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save when submit'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'v_request_id_temp number:=1;',
'v_id NUMBER:=1;',
'v_name_type nvarchar2(100);',
'v_benefit_code nvarchar2(100):='''';',
'v_annual_temp float:=0;',
'v_crf_temp float:=0;',
'manager_email nvarchar2(100);',
'manager_name nvarchar2(100);',
'requester_schedule NVARCHAR2(50);',
'v_body_emp clob := '''';',
'v_body_man clob:= '''';',
'p3_total_days FLOAT;',
'begin',
'',
'    requester_schedule := LOWER(TRIM(:P3_LEAVE_TYPE_DEPT));',
'',
'    -- Waiting for the end to come',
'    -- dbms_session.sleep(1);',
'',
'    -- INSERT INTO DEMO_ATTACHMENT(URL) VALUES(:P3_URL_FILES);',
'',
'    p3_total_days := case when :P3_TOTAL_DAYS = ''0.5'' then 0.5 else TO_NUMBER(:P3_TOTAL_DAYS) end;',
'',
'    if :P3_ANNUAL_LEAVE = ''APL'' then',
'        for rec in ( select * from ABSENCE_GROUP_EMPLOYEE where employee_code = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,''MM/DD/YYYY''))loop',
'            if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,''MM/DD/YYYY'') then',
'                -- CF not expired',
'                if  p3_total_days <= rec.CARRY_FORWARD_AVALABLE and rec.CARRY_FORWARD_AVALABLE > 0 then',
'                    -- CF enough',
'                    v_benefit_code := rec.CARRY_FORWARD_CODE;',
'                    v_crf_temp := p3_total_days;',
'                elsif rec.CARRY_FORWARD_AVALABLE > 0 and p3_total_days > rec.CARRY_FORWARD_AVALABLE then',
'                    -- CF not enough',
'                    v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN||'',''||rec.CARRY_FORWARD_CODE;',
'                    v_crf_temp := rec.CARRY_FORWARD_AVALABLE;',
'                    v_annual_temp := p3_total_days - rec.CARRY_FORWARD_AVALABLE;',
'                elsif rec.CARRY_FORWARD_AVALABLE <= 0 THEN',
'                    -- CF not expired, CF = 0',
'                    v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN;',
'                    v_annual_temp := p3_total_days;',
'                end if;',
'            else',
'                v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN;',
'                v_annual_temp := p3_total_days;',
'            end if;',
'        end loop;',
'    else ',
'        v_annual_temp := p3_total_days;',
'        v_benefit_code := :P3_LEAVE_DETAIL;',
'    end if;',
'',
'    select "REQUEST_ID".nextval into v_request_id_temp from sys.dual; ',
'',
'    -- Insert leave request',
'    -- insert into EMPLOYEE_REQUESTS (',
'    --     REQUESTOR_ID,REQUEST_ID,EMPLOYEE_CODE_REQ,EMPLOYEE_NAME,FROM_DATE,',
'    --     END_DATE,ALL_DAY,NOTE,TOTAL_DAYS,EMP_REQ_STATUS,LEAVE_TYPE,RESPONSER_ID,TARGET_CODE,',
'    --     START_TIME,END_TIME,SUBMIT_DATE,BENEFIT_CODE,CRF_DAY_TEMP,ANNUAL_DAY_TEMP,ATTACH_NAME,ATTATCH_FILE',
'    --     ) values (',
'    --         :APP_USER_ID,v_request_id_temp,:P3_EMPLOYEE_CODE,:P3_EMPLOYEE,:P3_FROM_DATE,',
'    --         :P3_END_DATE,to_char(:P3_ALL_DAY),:P3_NOTE,p3_total_days,2,:P3_ANNUAL_LEAVE,:P3_APPROVED_MANAGER,:P3_MANAGER_CODE,',
'    --         :P3_START_TIME,:P3_END_TIME,sysdate,v_benefit_code,v_crf_temp,v_annual_temp,nvl(:P3_NAME_FILES,''''),nvl(:P3_URL_FILES,''#'')',
'    --         ); ',
'    --     returning ID into v_id;',
'',
'        -- Insert a leave request and retrieve the ID into v_id',
'        insert into EMPLOYEE_REQUESTS (',
'            REQUESTOR_ID,REQUEST_ID,EMPLOYEE_CODE_REQ,EMPLOYEE_NAME,FROM_DATE,',
'            END_DATE,ALL_DAY,NOTE,TOTAL_DAYS,EMP_REQ_STATUS,LEAVE_TYPE,RESPONSER_ID,TARGET_CODE,',
'            START_TIME,END_TIME,SUBMIT_DATE,BENEFIT_CODE,CRF_DAY_TEMP,ANNUAL_DAY_TEMP,ATTACH_NAME,ATTATCH_FILE, LEAVE_BALANCE',
'        ) values (',
'            :APP_USER_ID,v_request_id_temp,:P3_EMPLOYEE_CODE,:P3_EMPLOYEE,to_date(:P3_FROM_DATE, ''DD/MM/YYYY''),',
'            CASE WHEN :P3_END_DATE IS NULL OR :P3_END_DATE = '''' THEN to_date(:P3_FROM_DATE, ''DD/MM/YYYY'') ELSE to_date(:P3_END_DATE, ''DD/MM/YYYY'') END,to_char(:P3_ALL_DAY),:P3_NOTE,p3_total_days,2,:P3_ANNUAL_LEAVE,:P3_APPROVED_MANAGER,:P3_MANAGER_COD'
||'E,',
'            CASE WHEN requester_schedule = ''ho'' THEN :P3_START_TIME_HO ELSE :P3_START_TIME END,:P3_END_TIME,sysdate,v_benefit_code,v_crf_temp,v_annual_temp,nvl(:P3_NAME_FILES,''''),:P3_URL_FILES, :P3_ANNUAL_LEAVE_BALANCE',
'        ) returning ID into v_id;',
'',
'    :P3_REQUEST_ID_IMPORTED := v_id;',
'',
'',
'    -- -- -- Log data into tables',
'    -- INSERT INTO OUTPUT_LOGS(DATE1, DATE2, STR1, STR2)',
'    -- VALUES (TO_DATE(:P3_FROM_DATE, ''DD/MM/YYYY''),TO_DATE(:P3_END_DATE, ''DD/MM/YYYY''), :P3_FROM_DATE, :P3_END_DATE);',
'',
'',
'    -- Send mail',
'',
'    SELECT USER_NAME, FULL_NAME INTO manager_email, manager_name FROM EMPLOYEES WHERE (SELECT MANAGER_ID FROM EMPLOYEES WHERE EMPLOYEE_CODE = :P3_EMPLOYEE_CODE) = EMPLOYEE_CODE;',
'        ',
'    --For employee',
'',
'    -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'', ''Leave Request Submitted Successfully'', ''<p> Dear ''|| :P3_EMPLOYEE ||'', </p>'' ||',
'    -- -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', :APP_USER_NAME, ''Leave Request Submitted Successfully'', ''<p> Dear ''|| :P3_EMPLOYEE ||'', </p>'' ||',
'    -- ''<p>Successfully submitted. Kindly return <b>My leave history page</b> to follow your leave request. Here are the details: </p>'' ||',
'    -- ''<p>Employee Code: ''|| :P3_EMPLOYEE_CODE ||'' </p>'' ||',
'    -- -- ''<p> Total Days: ''|| CASE',
'    -- --            WHEN p3_total_days = 0.5 THEN to_char(p3_total_days, ''0.0'')',
'    -- --            ELSE p3_total_days',
'    -- --        END ||'' </p>'' ||',
'    -- ''<p>Total Days: ''|| to_char(p3_total_days, ''0.0'') ||'' </p>'' ||',
'    -- ''<p>From Date: ''|| :P3_FROM_DATE ||'' </p>'' ||',
'    -- ''<p>To Date: ''|| :P3_END_DATE ||'' </p>'' ||',
'    -- ''<br>'' || ',
'    -- ''<p>If you have any questions or need further assistance, please feel free to reach out to the HR department. </p>'' ||',
'    -- ''<br>'' || ',
'    -- ''<p>Thank you, </p>'' ||',
'    -- ''<p>VUS </p>'');',
'',
'    -- v_body_emp := v_body_emp || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('    v_body_emp := v_body_emp || ''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\01A0N XIN NGH\1EC8 PH\00C9P</h3>'';'),
unistr('    v_body_emp := v_body_emp || ''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 REQUEST FOR LEAVE LETTER</h3>'';'),
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''|| :P3_EMPLOYEE ||'' th\00E2n m\1EBFn,</p>'';'),
'    v_body_emp := v_body_emp || ''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''|| :P3_EMPLOYEE ||'',</p>'';',
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB xin ngh\1EC9 ph\00E9p c\1EE7a nh\00E2n vi\00EAn nh\01B0 sau:</p>'';'),
'    v_body_emp := v_body_emp || ''<p style=''''color:black''''>Employee Portal system has received a request for leave as below:</p>'';',
'    v_body_emp := v_body_emp || ''<ul>'';',
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn/ Full name:</strong> ''|| :P3_EMPLOYEE ||''</p>'';'),
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn/ Employee Code:</strong> ''|| :P3_EMPLOYEE_CODE ||''</p>'';'),
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- Lo\1EA1i ph\00E9p/ Leave Type:</strong> ''|| :P3_ANNUAL_LEAVE ||''</p>'';'),
'    if (p3_total_days <= 0.5) then',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng S\1ED1 Ng\00E0y/ Total Days:</strong> ''|| to_char(p3_total_days, ''0.0'') ||''</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1EEB Ng\00E0y/ From Date:</strong> ''|| :P3_FROM_DATE ||''</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- \0110\1EBFn Ng\00E0y/ To Date:</strong> ''|| :P3_END_DATE ||''</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1EEB/ Start Time:</strong> ''|| :P3_START_TIME ||''</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- \0110\1EBFn/ To Time:</strong> ''|| :P3_END_TIME ||''</p>'';'),
'    else',
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng S\1ED1 Ng\00E0y/ Total Days:</strong> ''|| p3_total_days ||''</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1EEB Ng\00E0y/ From Date:</strong> ''|| :P3_FROM_DATE ||''</p>'';'),
unistr('        v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- \0110\1EBFn Ng\00E0y/ To Date:</strong> ''|| :P3_END_DATE ||''</p>'';'),
'    end if;',
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ghi Ch\00FA/ Note:</strong> ''|| :P3_NOTE ||''</p>'';'),
'    v_body_emp := v_body_emp || ''</ul><br>'';',
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black''''>\0110\01A1n xin ngh\1EC9 ph\00E9p c\1EE7a b\1EA1n \0111\00E3 \0111\01B0\1EE3c g\1EEDi \0111i th\00E0nh c\00F4ng!</p>'';'),
'    v_body_emp := v_body_emp || ''<p style=''''color:black''''>Your leave request has been successfully submitted!</p>'';',
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh s\1EBD xem x\00E9t v\00E0 ph\1EA3n h\1ED3i \0111\01A1n xin ngh\1EC9 ph\00E9p c\1EE7a b\1EA1n trong 3 \0111\1EBFn 5 ng\00E0y l\00E0m vi\1EC7c.</p>'';'),
'    v_body_emp := v_body_emp || ''<p style=''''color:black''''>HRA department will review and respond your leave request within 3-5 working days.</p>'';',
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black''''>Vui l\00F2ng quay l\1EA1i ''''L\1ECBch s\1EED xin ngh\1EC9 ph\00E9p c\1EE7a t\00F4i'''' \0111\1EC3 theo d\00F5i \0111\01A1n ngh\1EC9 ph\00E9p c\1EE7a b\1EA1n.</p>'';'),
'    v_body_emp := v_body_emp || ''<p style=''''color:black''''>Please return to ''''My Leave History'''' to follow your leave request.</p><br>'';',
'',
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black''''>N\1EBFu b\1EA1n c\00F3 b\1EA5t k\1EF3 c\00E2u h\1ECFi n\00E0o ho\1EB7c c\1EA7n th\00EAm s\1EF1 h\1ED7 tr\1EE3, xin \0111\1EEBng ng\1EA7n ng\1EA1i li\00EAn h\1EC7 v\1EDBi ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh.</p>'';'),
'    v_body_emp := v_body_emp || ''<p style=''''color:black''''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>'';',
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('    v_body_emp := v_body_emp || ''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'    v_body_emp := v_body_emp || ''<p style=''''color:black''''>Best regards,</p>'';',
'    v_body_emp := v_body_emp || ''<p style=''''color:black''''>HR & Admin Department </p>'';',
'    -- v_body_emp := v_body_emp || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
unistr('    SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', :APP_USER_NAME, ''G\1EEDi \0111\01A1n xin ngh\1EC9 ph\00E9p th\00E0nh c\00F4ng'', v_body_emp);'),
unistr('    SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'', ''G\1EEDi \0111\01A1n xin ngh\1EC9 ph\00E9p th\00E0nh c\00F4ng'', v_body_emp);'),
'',
'    --For manager',
'',
'    -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'', ''Leave Request Approval Required'', ''<p>Dear ''|| manager_name ||'',</p>'' ||',
'    -- -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', manager_email, ''Leave Request Approval Required'', ''<p>Dear ''|| manager_name ||'',</p>'' ||',
'    --     ''<p>A leave request from ''|| :P3_EMPLOYEE ||'' requires your approval. Here are the details:</p>'' ||',
'    --     ''<p>Employee Code: ''|| :P3_EMPLOYEE_CODE ||''</p>'' ||',
'    --     -- ''<p>Total Days: ''|| CASE',
'    --     --        WHEN p3_total_days = 0.5 THEN to_char(p3_total_days, ''0.0'')',
'    --     --        ELSE p3_total_days',
'    --     --    END ||''</p>'' ||',
'    --     ''<p>Total Days: ''|| to_char(p3_total_days, ''0.0'') ||'' </p>'' ||',
'    --     ''<p>From Date: ''|| :P3_FROM_DATE ||''</p>'' ||',
'    --     ''<p>To Date: ''|| :P3_END_DATE ||''</p>'' ||',
'    --     ''<br>'' || ',
'    --     ''<p>Please log in to the leave management system to review and approve the request. You can approve the leave by clicking on the following link: <a href=\"https://erp-pilot.vus.edu.vn/ords/r/erp/erp/approve-leave?request_id='' || to_char(v_'
||unistr('id) || ''\005C"> link to approve the leave \2197.</a></p>'' ||'),
'    --     ''<br>'' || ',
'    --     ''<p>If you have any questions or need further information, please contact the HR department.</p>'' ||',
'    --     ''<br>'' || ',
'    --     ''<p>Thank you,</p>'' ||''<p>VUS</p>'');',
'',
'    -- v_body_man := v_body_man || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('    v_body_man := v_body_man || ''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\01A0N XIN NGH\1EC8 PH\00C9P</h3>'';'),
unistr('    v_body_man := v_body_man || ''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 REQUEST FOR LEAVE LETTER</h3>'';'),
unistr('    v_body_man := v_body_man || ''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''|| manager_name ||'' th\00E2n m\1EBFn,</p>'';'),
'    v_body_man := v_body_man || ''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''|| manager_name ||'',</p>'';',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB xin ngh\1EC9 ph\00E9p c\1EE7a nh\00E2n vi\00EAn nh\01B0 sau:</p>'';'),
'    v_body_man := v_body_man || ''<p style=''''color:black''''>Employee Portal system has received a request for leave as below:</p>'';',
'    v_body_man := v_body_man || ''<ul>'';',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn/ Full name:</strong> ''|| :P3_EMPLOYEE ||''</p>'';'),
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn/ Employee Code:</strong> ''|| :P3_EMPLOYEE_CODE ||''</p>'';'),
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Lo\1EA1i ph\00E9p/ Leave Type:</strong> ''|| :P3_ANNUAL_LEAVE ||''</p>'';'),
'    if (p3_total_days <= 0.5) then',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng S\1ED1 Ng\00E0y/ Total Days:</strong> ''|| to_char(p3_total_days, ''0.0'') ||''</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1EEB Ng\00E0y/ From Date:</strong> ''|| :P3_FROM_DATE ||''</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- \0110\1EBFn Ng\00E0y/ To Date:</strong> ''|| :P3_END_DATE ||''</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1EEB/ Start Time:</strong> ''|| :P3_START_TIME ||''</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- \0110\1EBFn/ To Time:</strong> ''|| :P3_END_TIME ||''</p>'';'),
'    else',
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1ED5ng S\1ED1 Ng\00E0y/ Total Days:</strong> ''|| p3_total_days ||''</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- T\1EEB Ng\00E0y/ From Date:</strong> ''|| :P3_FROM_DATE ||''</p>'';'),
unistr('        v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- \0110\1EBFn Ng\00E0y/ To Date:</strong> ''|| :P3_END_DATE ||''</p>'';'),
'    end if;',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''><strong style=''''color:black''''>- Ghi Ch\00FA/ Note:</strong> ''|| :P3_NOTE ||''</p>'';'),
'    v_body_man := v_body_man || ''</ul><br>'';',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''>Vui l\00F2ng \0111\0103ng nh\1EADp v\00E0o H\1EC7 th\1ED1ng Qu\1EA3n l\00FD ngh\1EC9 ph\00E9p \0111\1EC3 xem x\00E9t v\00E0 ph\1EA3n h\1ED3i y\00EAu c\1EA7u. B\1EA1n c\00F3 th\1EC3 ph\1EA3n h\1ED3i y\00EAu c\1EA7u ngh\1EC9 ph\00E9p b\1EB1ng c\00E1ch nh\1EA5p v\00E0o li\00EAn k\1EBFt sau:</p>'';'),
'    v_body_man := v_body_man || ''<p style=''''color:black''''>Please log in to The leave management system to review and respond the leave request. You can respond the leave request by clicking on the following link: <a href=\"https://erp-pilot.vus.edu.v'
||unistr('n/ords/r/erp/erp/approve-leave?request_id='' || to_char(v_id) || ''\005C"> link to respond the leave request \2197.</a></p><br>'';'),
'',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''>N\1EBFu b\1EA1n c\00F3 b\1EA5t k\1EF3 c\00E2u h\1ECFi n\00E0o ho\1EB7c c\1EA7n th\00EAm s\1EF1 h\1ED7 tr\1EE3, xin \0111\1EEBng ng\1EA7n ng\1EA1i li\00EAn h\1EC7 v\1EDBi ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh.</p>'';'),
'    v_body_man := v_body_man || ''<p style=''''color:black''''>If you have any questions or need further assistance, please feel free to reach out to the HRA department.</p>'';',
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('    v_body_man := v_body_man || ''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'    v_body_man := v_body_man || ''<p style=''''color:black''''>Best regards,</p>'';',
'    v_body_man := v_body_man || ''<p style=''''color:black''''>HR & Admin Department </p>'';',
'    -- v_body_man := v_body_man || ''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
unistr('    SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', manager_email, ''Y\00EAu c\1EA7u duy\1EC7t \0111\01A1n ngh\1EC9 ph\00E9p'', v_body_man);'),
unistr('    SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'', ''Y\00EAu c\1EA7u duy\1EC7t \0111\01A1n ngh\1EC9 ph\00E9p'', v_body_man);'),
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(7872298095886711)
,p_process_success_message=>'Successfully submitted. Kindly return My leave history page to follow your leave request!'
,p_internal_uid=>7872380520886712
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(8549589038038926)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Calculate request'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- declare',
'-- v_request_id number;',
'-- v_action nvarchar2(100);',
'-- v_day_temp number:=0;',
'',
'-- begin',
'',
'-- for rec in (select * from ABSENCE_GROUP_EMPLOYEE eal ',
'-- join (',
'--     select * from EMPLOYEE_REQUESTS where EMPLOYEE_CODE_REQ = :APP_EMP_CODE ',
'--     order by submit_date desc',
'--     FETCH FIRST 1 ROWS ONLY',
'-- ) er on er.EMPLOYEE_CODE_REQ = eal.employee_code ',
'-- where eal.EMPLOYEE_CODE = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,''MM/DD/YYYY'')',
'-- and eal.HRM_ABSENCE_CODE_GROUP_ID = :P3_ANNUAL_LEAVE ',
'-- )loop',
'-- if rec.HRM_ABSENCE_CODE_GROUP_ID = ''APL'' then',
'-- update ABSENCE_GROUP_EMPLOYEE ',
'--                 set CARRY_FORWARD_USED = rec.CARRY_FORWARD_USED + rec.CRF_DAY_TEMP,',
'--                 DAY_APPROVE = sysdate,',
'--                 CARRY_FORWARD_AVALABLE = rec.CARRY_FORWARD_AVALABLE - rec.CRF_DAY_TEMP,',
'--                 AVAILABLE = rec.AVAILABLE - rec.ANNUAL_DAY_TEMP,',
'--                 PLAN_YEAR_USED = rec.PLAN_YEAR_USED + rec.ANNUAL_DAY_TEMP',
'--                 where EMPLOYEE_CODE = rec.EMPLOYEE_CODE and EXPIRATION_DATE >= to_char(sysdate,''MM/DD/YYYY'') ;',
'',
'-- end if;',
'-- end loop;',
'-- end;',
'',
'',
'declare',
'v_request_id number;',
'v_action nvarchar2(100);',
'v_day_temp number:=0;',
'',
'v_balance number:=0;',
'',
'begin',
'',
'',
'-- Update used day and available balance ABSENCE_GROUP_EMPLOYEE',
'',
'for rec in (select * from ABSENCE_GROUP_EMPLOYEE eal ',
'    join (',
'        select * from EMPLOYEE_REQUESTS where EMPLOYEE_CODE_REQ = :APP_EMP_CODE',
'        AND ID = to_number(:P3_REQUEST_ID_IMPORTED)',
'    ) er on er.EMPLOYEE_CODE_REQ = eal.employee_code ',
'    where eal.EMPLOYEE_CODE = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,''MM/DD/YYYY'')',
'    and eal.HRM_ABSENCE_CODE_GROUP_ID = :P3_ANNUAL_LEAVE ',
')loop',
'    if rec.HRM_ABSENCE_CODE_GROUP_ID = ''APL'' then',
'    update ABSENCE_GROUP_EMPLOYEE ',
'                    set CARRY_FORWARD_USED = rec.CARRY_FORWARD_USED + rec.CRF_DAY_TEMP,',
'                    DAY_APPROVE = sysdate,',
'                    CARRY_FORWARD_AVALABLE = rec.CARRY_FORWARD_AVALABLE - rec.CRF_DAY_TEMP,',
'                    AVAILABLE = rec.AVAILABLE - rec.ANNUAL_DAY_TEMP,',
'                    PLAN_YEAR_USED = rec.PLAN_YEAR_USED + rec.ANNUAL_DAY_TEMP',
'                    where EMPLOYEE_CODE = rec.EMPLOYEE_CODE and EXPIRATION_DATE >= to_char(sysdate,''MM/DD/YYYY'') ;',
'',
'    end if;',
'end loop;',
'',
'-- Update balance day in EMPLOYEE_REQUESTS',
'',
'for rec in (select * from ABSENCE_GROUP_EMPLOYEE ',
'emp_al',
'right JOIN EMPLOYEES e ON emp_al.EMPLOYEE_CODE = e.EMPLOYEE_CODE',
'where e.EMPLOYEE_CODE = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,''MM/DD/YYYY'') ',
' and HRM_ABSENCE_CODE_GROUP_ID = :P3_ANNUAL_LEAVE and HRM_ABSENCE_CODE_GROUP_ID = ''APL''',
')loop',
'    if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,''MM/DD/YYYY'')  then',
'        v_balance := rec.AVAILABLE + rec.CARRY_FORWARD_AVALABLE;',
'    else',
'        v_balance := rec.AVAILABLE;',
'    end if;',
'end loop;',
'',
'update EMPLOYEE_REQUESTS set LEAVE_BALANCE = v_balance where ID = to_number(:P3_REQUEST_ID_IMPORTED);',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(7872298095886711)
,p_process_when=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_count number:=0;',
'begin',
'select count(id) into v_count from ABSENCE_GROUP_EMPLOYEE where EMPLOYEE_CODE = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,''MM/DD/YYYY'');',
'if v_count > 0 then',
'    return true;',
'else',
'    return false;',
'end if;',
'end;'))
,p_process_when_type=>'FUNCTION_BODY'
,p_process_when2=>'PLSQL'
,p_internal_uid=>8549589038038926
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(7873591263886724)
,p_process_sequence=>10
,p_process_point=>'BEFORE_HEADER'
,p_process_type=>'NATIVE_SESSION_STATE'
,p_process_name=>'New_1'
,p_attribute_01=>'CLEAR_CACHE_CURRENT_PAGE'
,p_internal_uid=>7873591263886724
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
