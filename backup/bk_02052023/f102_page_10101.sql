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
--   Date and Time:   19:26 Monday February 5, 2024
--   Exported By:     ERP
--   Flashback:       0
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
'function _closeDialog(){',
'document.querySelector(''.ui-dialog-titlebar-close'').click();',
'}'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
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
'} */'))
,p_page_template_options=>'#DEFAULT#'
,p_page_is_public_y_n=>'Y'
,p_rejoin_existing_sessions=>'Y'
,p_page_component_map=>'16'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20231121154114'
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
'        var imageUrlsID = apex.item("P10101_DEFAULT_IMAGES_URL").getValue();',
'        var imageNamesID = apex.item("P10101_DEFAULT_IMAGES_NAME").getValue();',
'        var imageContainer = document.getElementById("P10101_ATTACH_GROUP");',
'        const urlArray = imageUrlsID.split(";");',
'        const nameArray = imageNamesID.split(";");',
'        apex.item("P10101_ATTACHMENT_URL").setValue(imageUrlsID);',
'        apex.item("P10101_ATTACHMENT_NAME").setValue(imageNamesID);',
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
'        var userName = apex.item("P10101_FULL_NAME").getValue();',
'        var userCode = apex.item("P10101_EMPLOYEE_CODE").getValue();',
'',
'        formData_PP.append("name", userName);',
'        formData_PP.append("msnv", userCode);',
'        document',
'            .getElementById("P10101_ATTACH")',
'            .addEventListener("change", function (event) {',
'                const imageFiles = event.target.files;',
'                const hiddenInputContainer = document.getElementById(',
'                    "P10101_ATTACH_GROUP"',
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
'    document.addEventListener(''DOMContentLoaded'', function () {',
'        document',
'            .getElementById("btn_submit")',
'            .addEventListener("click", async function (event) {',
'                let nullFormData = false;',
'                const elements = document.querySelectorAll(".dynamic-value-page");',
'                const names = [];',
'                const hrefs = [];',
'                var imageNamesID = apex.item("P10101_DEFAULT_IMAGES_NAME").getValue();',
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
'                            await apex.item("P10101_ATTACHMENT_URL").setValue(newfileUrls_PP);',
'                            await apex.item("P10101_ATTACHMENT_NAME").setValue(newfileNames_PP);',
'                        } else {',
'                            console.log("Upload failed");',
'                        }',
'                    } catch (error) {',
'                        console.error("An error occurred:", error);',
'                    } finally {',
'                        document.getElementById("loader-container").style.display = "none";',
'',
'                        setTimeout(function () {',
'                            apex.submit("btn_submit");',
'                        }, 200);',
'                        // apex.submit("btn_submit");',
'',
'',
'                        var button = parent.$(''.ui-dialog-titlebar-close''); //get the button',
'                        // button.click(); //close the dialog',
'                        setTimeout(function () {',
'                            button.click(); //close the dialog',
'                        }, 1000);',
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
'                    await apex.item("P10101_ATTACHMENT_URL").setValue(urlString);',
'                    await apex.item("P10101_ATTACHMENT_NAME").setValue(namesString);',
'',
'                    setTimeout(function () {',
'                        apex.submit("btn_submit");',
'                    }, 200);',
'                    // apex.submit("btn_submit");',
'',
'                    var button = parent.$(''.ui-dialog-titlebar-close''); //get the button',
'                    // button.click(); //close the dialog',
'                    setTimeout(function () {',
'                        button.click(); //close the dialog',
'                    }, 1000);',
'                }',
'                document.getElementById("loader-container").style.display = "none";',
'            });',
'    });',
'',
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
'    WHEN :P10101_EMP_EDUCATION_ID IS NOT NULL AND :P10101_EMP_EDUCATION_ID != ''t1000'' THEN',
'        (SELECT ATTACH_NAME FROM EMP_EDUCATION WHERE ID = :P10101_EMP_EDUCATION_ID)',
'    ELSE (SELECT ATTACHMENT_NAME FROM TEMP_UPLOAD WHERE TEMP_ID = to_number(:P10101_TEMP_ID) AND TABLE_NAME = ''EMP_EDUCATION'')',
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
'    WHEN :P10101_EMP_EDUCATION_ID IS NOT NULL AND :P10101_EMP_EDUCATION_ID != ''t1000'' THEN',
'        (SELECT ATTACH_URL FROM EMP_EDUCATION WHERE ID = :P10101_EMP_EDUCATION_ID)',
'    ELSE (SELECT ATTACHMENT_URL FROM TEMP_UPLOAD WHERE TEMP_ID = TO_NUMBER(:P10101_TEMP_ID) AND TABLE_NAME = ''EMP_EDUCATION'')',
'END AS ATTACHMENT_URL',
'FROM DUAL'))
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
'    ',
'    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second',
'    LOOP',
'        v_end_time := DBMS_UTILITY.GET_TIME;',
'        EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds',
'    END LOOP;',
'',
'    if :P10101_EMP_EDUCATION_ID IS NOT NULL AND :P10101_EMP_EDUCATION_ID != ''t1000'' then',
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
'    --     ''Upload file'',',
'    --     :P10101_EMP_EDUCATION_ID',
'    -- FROM',
'    --     DUAL;',
'',
'    COMMIT;',
'',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error!'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_success_message=>'Success!'
,p_internal_uid=>22955023576327216
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
