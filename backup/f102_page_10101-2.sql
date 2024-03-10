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
--   Date and Time:   07:16 Sunday March 10, 2024
--   Exported By:     ERP
--   Flashback:       5
--   Export Type:     Page Export
--   Manifest
--     PAGE: 10101
--   Manifest End
--   Version:         23.2.3
--   Instance ID:     7949320442804181
--

begin
null;
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
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'const is_modal_page = true',
'function _closeDialog() {',
'    parent.document.querySelector(''.ui-dialog-titlebar-close'').click();',
'}',
'// Util functions',
'function handleDeleteClick(event, formData, fileArrayNames, fileArrayUrls) {',
'    if (event.target.classList.contains("delete-item")) {',
'        const itemToRemove = event.target.closest("div");',
'        const name = event.target.dataset.name;',
'        const url = itemToRemove.querySelector("a").getAttribute("href");',
'        const files = formData.getAll("files");',
'        const updatedFiles = files.filter((file) => file.name !== name);',
'        formData.delete("files");',
'        fileArrayNames = fileArrayNames.filter((item) => item !== name);',
'        fileArrayUrls = fileArrayNames.filter((item) => item !== url);',
'        updatedFiles.forEach((file) => formData.append("files", file));',
'        if (itemToRemove) {',
'            itemToRemove.remove();',
'            document.getElementById("loader-container").style.display = "none";',
'        }',
'        let existingInput = document.getElementById("hiddenDeleteItems");',
'        if (!existingInput) {',
'            let newInput = document.createElement("input");',
'            newInput.id = "hiddenDeleteItems";',
'            newInput.type = "hidden";',
'            newInput.value = name;',
'            document.body.appendChild(newInput);',
'        } else {',
'            existingInput.value = existingInput.value + ";" + name;',
'        }',
'    }',
'}',
'function getCurrentDateFormatted() {',
'    const currentDate = new Date();',
'',
'    const day = String(currentDate.getDate()).padStart(2, "0");',
'    const month = String(currentDate.getMonth() + 1).padStart(2, "0");',
'    // Months are zero-based, so add 1',
'    const year = currentDate.getFullYear();',
'',
'    return `${day}-${month}-${year}`;',
'}',
'function deleteValue(formData, key, value) {',
'    const values = formData.getAll(key);',
'    const updatedValues = values.filter((v) => v !== value);',
'',
'    // Remove all values associated with the key',
'    formData.delete(key);',
'',
'    // Append the updated values back to the FormData object',
'    updatedValues.forEach((updatedValue) => {',
'        formData.append(key, updatedValue);',
'    });',
'}',
'',
'// BindEvent functions',
'function BindFileUploadEvent(fileUpload, eleSelector) {',
'    jQuery(".apex-item-wrapper--file").append(',
'        ''<div class="ATTACH_GROUP t-Form-inputContainer"></div>''',
'    );',
'',
'    var imageUrlsID = apex.item(eleSelector.eleDefUrl).getValue();',
'    var imageNamesID = apex.item(eleSelector.eleDefName).getValue();',
'    var imageContainer = document.querySelector(',
'        eleSelector.eleAttCon + " .ATTACH_GROUP"',
'    );',
'    const urlArray = imageUrlsID.split(";");',
'    const nameArray = imageNamesID.split(";");',
'',
'    apex.item(eleSelector.eleAttUrl).setValue(imageUrlsID);',
'    apex.item(eleSelector.eleAttName).setValue(imageNamesID);',
'',
'    for (let i = 0; i < urlArray.length; i++) {',
'        const imageUrl = urlArray[i];',
'        const imageName = nameArray[i];',
'        fileUpload.fileArrayNames.push(imageName);',
'        fileUpload.fileArrayUrls.push(imageUrl);',
'        let hiddenInputHTML;',
'        if (imageUrl != "" || imageName != "") {',
'            hiddenInputHTML = `',
'          <div class="file-item ">',
'              <span  id="deleteItem${imageName}" data-name="${imageName}" class="delete-item btn-delete vng-true"> X </span>',
'              <a name="${imageName}" href="${imageUrl}" target="_blank" class="${eleSelector.eleDynamicValue}">',
'                  ${imageName}',
'              </a>',
'          </div>',
'      `;',
'        } else {',
'            hiddenInputHTML = ``;',
'        }',
'        imageContainer.insertAdjacentHTML("beforeend", hiddenInputHTML);',
'    }',
'    var deleteButtons = document.querySelectorAll(".btn-delete");',
'    deleteButtons.forEach(function (button) {',
'        button.addEventListener("click", function (event) {',
'            handleDeleteClick(',
'                event,',
'                fileUpload.formData,',
'                fileUpload.fileArrayNames,',
'                fileUpload.fileArrayUrls',
'            );',
'        });',
'    });',
'',
'    var userName = apex.item(eleSelector.eleEmpName).getValue();',
'    var userCode = apex.item(eleSelector.eleEmpCode).getValue();',
'',
'    fileUpload.formData.append("name", userName);',
'    fileUpload.formData.append("msnv", userCode);',
'    document',
'        .getElementById(eleSelector.eleAtt)',
'        .addEventListener("change", function (event) {',
'            const imageFiles = event.target.files;',
'            const hiddenInputContainer = document.querySelector(',
'                eleSelector.eleAttCon + " .ATTACH_GROUP"',
'            );',
'            const maxFileSize = 5 * 1024 * 1024; // 1MB in bytes',
'',
'            fileUpload.formData.append("date", getCurrentDateFormatted());',
'            console.log(getCurrentDateFormatted());',
'',
'            for (const imageFile of imageFiles) {',
'                const fileName = imageFile.name;',
'                const fileURL = URL.createObjectURL(imageFile);',
'                if (imageFile.size > maxFileSize) {',
'                    // Show an error message or take appropriate action',
'                    alert(',
'                        `File ${fileName} is larger than 5MB. Please choose a smaller file.`',
'                    );',
'                    continue; // Skip this file',
'                }',
'',
'                fileUpload.formData.append("files", imageFile);',
'',
'                const hiddenInputHTML = `',
'          <div class="file-item id-numb-file">',
'              <a href="${fileURL}" target="_blank">',
'                  ${fileName}',
'              </a>',
'              <span id="deleteItem${fileName}" data-name="${fileName}" class="delete-item btn-delete"> X </span>',
'          </div>',
'        `;',
'                hiddenInputContainer.insertAdjacentHTML("beforeend", hiddenInputHTML);',
'            }',
'            hiddenInputContainer.addEventListener("click", function (event) {',
'                handleDeleteClick(',
'                    event,',
'                    fileUpload.formData,',
'                    fileUpload.fileArrayNames,',
'                    fileUpload.fileArrayUrls',
'                );',
'            });',
'        });',
'}',
'',
'function BindEventSubmitBtn(fileUpload, eleSelector) {',
'    document',
'        .getElementById(eleSelector.eleBtnSubmitId)',
'        .addEventListener("click", async function (event) {',
'            let nullFormData = false;',
'            const elements = document.querySelectorAll(".dynamic-value-page");',
'            const names = [];',
'            const hrefs = [];',
'            var imageNamesID = apex.item(eleSelector.eleDefName).getValue();',
'            const nameArray = imageNamesID.split(";");',
'',
'            // document.getElementById(''loader-container'').style.display = ''block'';',
'            for (const value of fileUpload.formData.values()) {',
'                if (value.name != null) {',
'                    nullFormData = true;',
'                }',
'            }',
'',
'            //  else {',
'            // await elements.forEach((element) => {',
'            //   const name = element.getAttribute("name");',
'            //   const href = element.getAttribute("href");',
'            //   if (name && href) {',
'            //     names.push(name);',
'            //     hrefs.push(href);',
'            //   }',
'            // });',
'            // namesString = names.join(";");',
'            // urlString = hrefs.join(";");',
'            // const missingValuesNameId = await nameArray.filter(',
'            //   (value) => !names.includes(value)',
'            // );',
'            // const urlDelete =',
'            //   "https://graphapi.vus.edu.vn/delete-multiple-objects-vng-cloud";',
'            // const data = {',
'            //   fileNames: missingValuesNameId,',
'            // };',
'            // console.log(missingValuesNameId);',
'            // const requestOptions = {',
'            //   method: "POST",',
'            //   headers: {',
'            //     "Content-Type": "application/json",',
'            //   },',
'            //   body: JSON.stringify(data),',
'            // };',
'            // try {',
'            //   await fetch(urlDelete, requestOptions)',
'            //     .then((response) => {',
'            //       if (!response.ok) {',
'            //         throw new Error("Network response was not ok");',
'            //       }',
'            //       return response.json();',
'            //     })',
'            //     .then((data) => {',
'            //       console.log(data);',
'            //     });',
'            // } catch (error) {',
'            //   console.error("Error:", error);',
'            // } finally {',
'            //   document.getElementById("loader-container").style.display = "none";',
'            // }',
'            // await apex.item(eleSelector.eleAttUrl).setValue(urlString);',
'            // await apex.item(eleSelector.eleAttName).setValue(namesString);',
'            // apex.submit(eleSelector.eleBtnSubmit);',
'            // setTimeout(function () {',
'            //   if (log_mode == 1) {',
'            //     console.log("Submit button clicked");',
'            //   } else {',
'            //     apex.submit(eleSelector.eleBtnSubmitApexName);',
'            //   }',
'            // }, 500);',
'            // }',
'            let stringUrlsImport = "";',
'            let stringNamesImport = "";',
'            let arrayDeleteItems = document.querySelector("#hiddenDeleteItems")',
'                ? document.querySelector("#hiddenDeleteItems").value.split(";")',
'                : [];',
'            const allItems = document.querySelectorAll(".file-item");',
'            allItems.forEach((item) => {',
'                const child = item.querySelector("a");',
'                if (child.classList.contains("dynamic-value-page")) {',
'                    stringNamesImport += `;${child.getAttribute("name")}`;',
'                    stringUrlsImport += `;${child.getAttribute("href")}`;',
'                }',
'            });',
'            if (nullFormData) {',
'                try {',
'                    // Set time out 15s',
'                    const response = await fetch("https://graphapi.vus.edu.vn/upload", {',
'                        method: "POST",',
'                        body: fileUpload.formData,',
'                        timeout: 15000,',
'                    });',
'                    console.log(response);',
'                    if (response.status === 200) {',
'                        const responseBody = await response.json();',
'                        const apiNames = responseBody.data',
'                            .map((item) => item.name)',
'                            .join(";");',
'                        const apiUrls = responseBody.data',
'                            .map((item) => item.path)',
'                            .join(";");',
'                        stringNamesImport += `;${apiNames}`;',
'                        stringUrlsImport += `;${apiUrls}`;',
'                    } else {',
'                        console.log("Upload failed");',
'                    }',
'                } catch (error) {',
'                    console.error("An error occurred:", error);',
'                } finally {',
'                    document.getElementById("loader-container").style.display = "none";',
'                }',
'            }',
'            if (getUniqueValues(arrayDeleteItems).length != 0) {',
'                const urlDelete =',
'                    "https://graphapi.vus.edu.vn/delete-multiple-objects-vng-cloud";',
'                const data = {',
'                    fileNames: getUniqueValues(arrayDeleteItems),',
'                };',
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
'            }',
'            // console.log(getUniqueValues(arrayDeleteItems));',
'            // console.log(stringUrlsImport);',
'            // console.log(stringNamesImport);',
'            await apex.item(eleSelector.eleAttUrl).setValue(stringUrlsImport);',
'            await apex.item(eleSelector.eleAttName).setValue(stringNamesImport);',
'            setTimeout(function () {',
'                if (log_mode == 1) {',
'                    console.log("Submit button clicked");',
'                } else {',
'',
'                    // Khanh update - 08/03/24',
'                    // update 1: use apex.server.process',
'                    // *apex.submit | apex.page.submit do not support success and error callback',
'                    // update 2: add is_modal_page for modal page upload (page 10101, 10102)',
'                    // update 3: add alert if no changes detected',
'                    // update 4: close modal dialog after submit',
'                    /* --- */',
'                    if (typeof is_modal_page != ''undefined'' && is_modal_page == true) {',
'                        // if eleAttUrl is different from eleDefUrl, then submit the page, else do nothing',
'                        if (apex.item(eleSelector.eleAttUrl).getValue() != apex.item(eleSelector.eleDefUrl).getValue()) {',
'',
'                            // console.log(''-------: '' + fileUpload.fileArrayUrls);',
'',
'                            apex.server.process(''test_submit_write_json'', {',
'                                // x01: ''test-past-value'',',
'                                pageItems: "#P10101_ATTACHMENT_URL"',
'                            }, { dataType: "text" },',
'                                {',
'                                    success: function () {',
'                                        _closeDialog();',
'                                        // console.log(''-------: '' + fileUpload.fileArrayUrls);',
'                                    },',
'                                    error: function (xhr, status, error) {',
'                                        console.log(''Error: '' + error);',
'                                        // _closeDialog();',
'                                    }',
'                                });',
'',
'                        }',
'                        else {',
'                            alert(''No changes detected!'');',
'                            return false',
'                        }',
'                    }',
'                    // if not modal page, just submit the page',
'                    else {',
'                        apex.server.process(eleSelector.eleBtnSubmitApexName, {',
'                            // x01: ''submit'', // pass a variable if needed',
'                        }, {',
'                            success: function (data) {',
'                                console.log(''Process completed successfully'');',
'                            },',
'                            error: function (xhr, status, error) {',
'                                console.log(''Error: '' + error);',
'                            }',
'                        });',
'                    }',
'                    /* --- */',
'',
'                }',
'            }, 500);',
'            // document.getElementById("loader-container").style.display = "none";',
'        });',
'}',
'function getUniqueValues(arr) {',
'    return [...new Set(arr)];',
'}',
'// Create class CustomFileUpload to store all variables',
'class CustomFileUpload {',
'    constructor() {',
'        this.formData = new FormData();',
'        this.filesName;',
'        this.filesUrl;',
'        this.fileArrayNames = [];',
'        this.fileArrayUrls = [];',
'    }',
'}',
'',
'// get log_mode from params url /?log_mode=1',
'const log_mode = new URLSearchParams(window.location.search).get("log_mode");'))
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
,p_page_component_map=>'16'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20240310071039'
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
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'SUBMIT'
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
'    l_count_temp_id NUMBER;',
'BEGIN    ',
'',
'    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second',
'    LOOP',
'        v_end_time := DBMS_UTILITY.GET_TIME;',
'        EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds',
'    END LOOP;',
'',
'    if :P10101_EMP_EDUCATION_ID IS NOT NULL AND :P10101_EMP_EDUCATION_ID not like ''t%'' then',
'        -- Update attachment in EMP_EDUCATION when ID is not null (existing record)',
'        UPDATE',
'            EMP_EDUCATION',
'        SET',
'            ATTACH_URL = :P10101_ATTACHMENT_URL,',
'            ATTACH_NAME = :P10101_ATTACHMENT_NAME',
'        WHERE ID = :P10101_EMP_EDUCATION_ID;',
'    else',
'        -- Insert/Update TEMP_UPLOAD when ID is null (new record)',
'        SELECT COUNT(*) INTO l_count_temp_id FROM TEMP_UPLOAD WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = ''EMP_EDUCATION'';',
'        if l_count_temp_id > 0 then',
'            UPDATE',
'                TEMP_UPLOAD',
'            SET',
'                ATTACHMENT_URL = :P10101_ATTACHMENT_URL,',
'                ATTACHMENT_NAME = :P10101_ATTACHMENT_NAME',
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
'                :P10101_ATTACHMENT_URL,',
'                :P10101_ATTACHMENT_NAME',
'            FROM',
'                DUAL;',
'        end if;',
'    end if;',
'',
'    -- write log ',
'',
'    -- -- *store P10101_ATTACHMENT_URL, P10101_ATTACHMENT_NAME',
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
'    --     :P10101_ATTACHMENT_URL,',
'    --     :P10101_ATTACHMENT_NAME,',
'    --     :P10101_EMPLOYEE_CODE,',
'    --     ''EMP_EDUCATION'',',
'    --     SYSDATE,',
'    --     ''Upload file - P10101_ATTACHMENT_URL, P10101_ATTACHMENT_NAME'',',
'    --     :P10101_EMP_EDUCATION_ID',
'    -- FROM',
'    --     DUAL;',
'',
'    -- -- * store P10101_DEFAULT_IMAGES_URL, P10101_DEFAULT_IMAGES_NAME',
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
'    --     :P10101_DEFAULT_IMAGES_URL,',
'    --     :P10101_DEFAULT_IMAGES_NAME,',
'    --     :P10101_EMPLOYEE_CODE,',
'    --     ''EMP_EDUCATION'',',
'    --     SYSDATE,',
'    --     ''Upload file - P10101_DEFAULT_IMAGES_URL, P10101_DEFAULT_IMAGES_NAME'',',
'    --     :P10101_EMP_EDUCATION_ID',
'    -- FROM',
'    --     DUAL;',
'',
'  -- Your existing PL/SQL code here',
'        ',
'    COMMIT;',
'',
'    -- return json',
'    apex_json.initialize_clob_output;',
'    apex_json.open_object;',
'    apex_json.write(''result'', ''Success''); -- Provide a meaningful result key',
'    apex_json.close_object;',
'    -- If needed, you can add additional key-value pairs here',
'    ',
'    apex_json.write(''additional_key'', ''additional_value'');',
'    ',
'    htp.p(apex_json.get_clob_output);',
'    --',
'',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Success!'
,p_internal_uid=>22955023576327216
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(31736983850632341)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'test_submit'
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
'    l_count_temp_id NUMBER;',
'    l_json_output CLOB;',
'BEGIN    ',
'',
'    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second',
'    LOOP',
'        v_end_time := DBMS_UTILITY.GET_TIME;',
'        EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds',
'    END LOOP;',
'',
'    if :P10101_EMP_EDUCATION_ID IS NOT NULL AND :P10101_EMP_EDUCATION_ID not like ''t%'' then',
'        -- Update attachment in EMP_EDUCATION when ID is not null (existing record)',
'        UPDATE',
'            EMP_EDUCATION',
'        SET',
'            ATTACH_URL = :P10101_ATTACHMENT_URL,',
'            ATTACH_NAME = :P10101_ATTACHMENT_NAME',
'        WHERE ID = :P10101_EMP_EDUCATION_ID;',
'    else',
'        -- Insert/Update TEMP_UPLOAD when ID is null (new record)',
'        SELECT COUNT(*) INTO l_count_temp_id FROM TEMP_UPLOAD WHERE TEMP_ID = :P10101_TEMP_ID AND TABLE_NAME = ''EMP_EDUCATION'';',
'        if l_count_temp_id > 0 then',
'            UPDATE',
'                TEMP_UPLOAD',
'            SET',
'                ATTACHMENT_URL = :P10101_ATTACHMENT_URL,',
'                ATTACHMENT_NAME = :P10101_ATTACHMENT_NAME',
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
'                :P10101_ATTACHMENT_URL,',
'                :P10101_ATTACHMENT_NAME',
'            FROM',
'                DUAL;',
'        end if;',
'    end if;',
'',
'    -- write log ',
'',
'    -- -- *store P10101_ATTACHMENT_URL, P10101_ATTACHMENT_NAME',
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
'    --     :P10101_ATTACHMENT_URL,',
'    --     :P10101_ATTACHMENT_NAME,',
'    --     :P10101_EMPLOYEE_CODE,',
'    --     ''EMP_EDUCATION'',',
'    --     SYSDATE,',
'    --     ''Upload file - P10101_ATTACHMENT_URL, P10101_ATTACHMENT_NAME'',',
'    --     :P10101_EMP_EDUCATION_ID',
'    -- FROM',
'    --     DUAL;',
'',
'    -- -- * store P10101_DEFAULT_IMAGES_URL, P10101_DEFAULT_IMAGES_NAME',
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
'    --     :P10101_DEFAULT_IMAGES_URL,',
'    --     :P10101_DEFAULT_IMAGES_NAME,',
'    --     :P10101_EMPLOYEE_CODE,',
'    --     ''EMP_EDUCATION'',',
'    --     SYSDATE,',
'    --     ''Upload file - P10101_DEFAULT_IMAGES_URL, P10101_DEFAULT_IMAGES_NAME'',',
'    --     :P10101_EMP_EDUCATION_ID',
'    -- FROM',
'    --     DUAL;',
'',
'  -- Your existing PL/SQL code here',
'        ',
'    -- write json output',
'',
'    apex_json.initialize_clob_output;',
'    apex_json.open_object;',
'    apex_json.write(''result'', ''Success'');',
'    apex_json.write(''additional_key'', ''additional_value'');',
'    apex_json.close_object;',
'    l_json_output := apex_json.get_clob_output;',
'    htp.p(l_json_output);',
'',
'    COMMIT;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'error'
,p_process_success_message=>'success'
,p_internal_uid=>31736983850632341
);
end;
/
begin
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(31737031911632342)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'test_submit_write_json'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    l_json_output CLOB;',
'    -- x1 from apex.server.process',
'    x1 VARCHAR2(4000) := apex_application.g_x01;',
'    v_parameter_in   VARCHAR2(200);',
'BEGIN',
'',
'    v_parameter_in := :P10101_ATTACHMENT_URL;',
'',
'    INSERT INTO TABLE_DEMO_1(NAME) ',
'    VALUES (v_parameter_in);',
'    ',
'    -- INSERT INTO TABLE_DEMO_1(NAME) ',
'    -- VALUES (:P10101_ATTACHMENT_URL);',
'',
'    -- Initialize JSON output',
'    apex_json.initialize_clob_output;',
'    ',
'    -- Open JSON object',
'    apex_json.open_object;',
'    ',
'    -- Write key-value pairs',
'    apex_json.write(''result'', ''Success'');',
'    apex_json.write(''additional_key'', ''additional_value'');',
'    ',
'    -- Close JSON object',
'    apex_json.close_object;',
'    ',
'    -- Get JSON output',
'    l_json_output := apex_json.get_clob_output;',
'    ',
'    -- Print JSON output',
'    htp.p(l_json_output);',
'END;',
'',
'',
'-- DECLARE',
'--     l_json_output CLOB;',
'--     -- x1 from apex.server.process',
'--     x1 VARCHAR2(4000) := apex_application.g_x01;',
'    ',
'-- BEGIN',
'',
'--     INSERT INTO TABLE_DEMO(id, GIA_TRI_CHU) ',
'--     values(10001, x1);',
'',
'--     -- Initialize JSON output',
'--     apex_json.initialize_clob_output;',
'    ',
'--     -- Open JSON object',
'--     apex_json.open_object;',
'    ',
'--     -- Write key-value pairs',
'--     apex_json.write(''result'', ''Success'');',
'--     apex_json.write(''additional_key'', ''additional_value'');',
'    ',
'--     -- Close JSON object',
'--     apex_json.close_object;',
'    ',
'--     -- Get JSON output',
'--     l_json_output := apex_json.get_clob_output;',
'    ',
'--     -- Print JSON output',
'--     htp.p(l_json_output);',
'-- END;',
''))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>31737031911632342
);
null;
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
