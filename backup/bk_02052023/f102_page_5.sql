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
--   Date and Time:   21:22 Sunday February 4, 2024
--   Exported By:     ERP
--   Flashback:       60
--   Export Type:     Page Export
--   Manifest
--     PAGE: 5
--   Manifest End
--   Version:         23.2.3
--   Instance ID:     7949320442804181
--

begin
null;
end;
/
prompt --application/pages/delete_00005
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>5);
end;
/
prompt --application/pages/page_00005
begin
wwv_flow_imp_page.create_page(
 p_id=>5
,p_name=>'Personal Information'
,p_alias=>'PERSONAL-INFORMATION'
,p_step_title=>'My profile'
,p_warn_on_unsaved_changes=>'N'
,p_autocomplete_on_off=>'OFF'
,p_javascript_code=>wwv_flow_string.join(wwv_flow_t_varchar2(
'function generateTempKey(ig$, column, record, value, rowIndex, modelInstance) {',
'  var tempKey = ''temp_'' + new Date().getTime() + ''_'' + Math.random().toString(36).substr(2, 9);',
'  return tempKey;',
'}',
''))
,p_javascript_code_onload=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// $(''#education-box'').before(''<h3 style="font-weight: 700;">Degree</h3>'');',
'// $(''#certificate-box #certificate-box_ig'').before(''<h3 style="font-weight: 700;">Other certificates</h3>'');',
'',
'$(''#education-box'').before(''<h3 style="font-weight: 700;" id="mess_degree"></h3>'');',
'$(''#certificate-box #certificate-box_ig'').before(''<h3 style="font-weight: 700;" id="mess_certificates"></h3>'');',
'',
'// document.addEventListener(''DOMContentLoaded'', function() {',
'document.getElementById(''mess_degree'').textContent = apex.lang.getMessage(''DEGREE'');',
'//document.getElementById(''mess_degree'').textContent = ''TEXT'';',
'document.getElementById(''mess_certificates'').textContent = apex.lang.getMessage(''CERTIFICATES'');',
'// });',
'',
'apex.jQuery(function($) {',
'  // Wait for the Interactive Grid to be initialized',
'  $(''body'').on(''interactivegridviewmodelcreate'', function(event, viewmodel) {',
'    var grid = viewmodel.grid;',
'',
'    // Bind an event to the ''Add Row'' button click',
'    grid.widget().on(''gridpageaddrow'', function(e, ui) {',
'      // Get model from the grid',
'      var model = grid.model;',
'',
'      // Get the newly added record',
'      var record = model.getRecord(ui.recordId);',
'',
'      // Generate and set the temporary key',
'      var tempKey = generateTempKey();',
'      model.setValue(record, ''TEMP_KEY'', tempKey);',
'    });',
'  });',
'});',
'',
'',
'// -------------------------------------------------------',
'',
'jQuery(document).on(''click'', ''.edu-upload-link'', function (e) {',
'    e.preventDefault();',
'    var $this = jQuery(this);',
'    var tempId = $this.data(''tempid'');',
'    var empCode = $this.data(''empcode'');',
'    var eduId = $this.data(''edu-id'');',
'',
'    // Construct the base URL',
'    // var url = "f?p=#APP_ID#:20002:#SESSION#::NO::P20002_REQUEST_ID,P20002_STATUS:" + $v(''SCHOLARSHIP_ID_NEW'') + "," + ''1'';',
'    var url = "f?p=#APP_ID#:10101:#SESSION#::NO::P10101_TEMP_ID,P10101_EMPLOYEE_CODE,P10101_EMP_EDUCATION_ID:" + tempId + "," + empCode + "," + eduId;',
'    url = url.replace("#APP_ID#", $v("pFlowId"));',
'    url = url.replace("#SESSION#", $v("pInstance"));',
'',
'    // Make the AJAX call',
'    apex.server.process("PREPARE_URL", {',
'        x01: url',
'    }, {',
'        success: function(pData) {',
'            if (pData.success === true) {',
'                apex.navigation.redirect(pData.url);',
'            } else {',
'                console.log("Error: URL preparation failed");',
'            }',
'        },',
'        error: function(request, status, error) {',
'            console.log("AJAX error: " + status + " - " + error);',
'        }',
'    });',
'});',
'',
'',
'// Upload attachment IG Certificate',
'',
'jQuery(document).on(''click'', ''.cert-upload-link'', function (e) {',
'    e.preventDefault();',
'    var $this = jQuery(this);',
'    var tempId = $this.data(''tempid'');',
'    var empCode = $this.data(''empcode'');',
'    var certId = $this.data(''cert-id'');',
'',
'    // Construct the base URL',
'    var url = "f?p=#APP_ID#:10102:#SESSION#::NO::P10102_TEMP_ID,P10102_EMPLOYEE_CODE,P10102_EMP_CERTIFICATE_ID:" + tempId + "," + empCode + "," + certId;',
'    url = url.replace("#APP_ID#", $v("pFlowId"));',
'    url = url.replace("#SESSION#", $v("pInstance"));',
'',
'    // Make the AJAX call',
'    apex.server.process("PREPARE_URL", {',
'        x01: url',
'    }, {',
'        success: function(pData) {',
'            if (pData.success === true) {',
'                apex.navigation.redirect(pData.url);',
'            } else {',
'                console.log("Error: URL preparation failed");',
'            }',
'        },',
'        error: function(request, status, error) {',
'            console.log("AJAX error: " + status + " - " + error);',
'        }',
'    });',
'});',
'',
'// document.addEventListener(''DOMContentLoaded'', function() {',
'//     if ($(''html[lang="vi"]'').length) {',
unistr('//         $('' ("Add Row")'').text(''Th\00EAm D\00F2ng'');'),
unistr('//         $(''.a-Toolbar-item span.a-Button-label:contains("Edit")'').text(''S\1EEDa'');'),
unistr('//         $(''.a-Toolbar-item span.a-Button-label:contains("Actions")'').text(''H\00E0nh \0110\1ED9ng'');'),
unistr('//         $(''.a-Menu-inner .a-Menu-label:contains("Single Row View")'').text(''Xem m\1ED9t d\00F2ng'');'),
'//     }',
'// });'))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.a-GV-header .a-GV-headerLabel {',
'  white-space: normal;',
'  text-align: center;',
'}',
'/* auto wrap cho cell */',
'.a-GV-cell {',
'    white-space: normal !important;',
'    /* text-align: center !important; */',
'}',
'#identify-detail ul.t-Tabs{',
'    display: inline-flex;',
'    flex-direction: column;',
'}',
'/* #identify-detail div.a-Tabs-panel{',
'    float: right;',
'} */',
'',
'#certificate-box {',
' margin-top: 50px;',
'}',
'',
'/* Submit | Cancle on ID Numbers */',
'#__tab_id .t-TabsRegion div.col.col-6.apex-col-auto {',
'    flex-basis: 0 !important;',
'    flex-grow: 0 !important;',
'}',
'#identify-detail > div{',
'    min-height: 0px;',
'    display: flex;',
'    flex-direction: row;',
'    width: 100%;',
'    gap:5%',
'}',
'#identify-detail > div > ul{',
'    width: 25%;',
'}',
'#SR_R8178776054022832{',
'    width:70%',
'}',
'.btn-delete{',
'    color: white;font-size: 12px;cursor: pointer;background: red !important;display: block;width: 20px;height:20px;text-align: center;border-radius: 50%;',
'}',
'.file-item{',
'    display:flex; gap:10px;margin:15px 0',
'}',
'.a-GV-w-scroll {',
'    height: unset !important;',
'}',
'.apex-item-filedrop-filename {',
'    display: none;',
'}',
'',
'#SOC_Submit {',
'    background-color: #056ac8 !important;',
'}',
'#SOC_Submit .t-Button-label {',
'    color: #ffffff !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_page_component_map=>'25'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20240123045619'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8101674187268648)
,p_plug_name=>'My profile'
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(18710165183889068)
,p_plug_display_sequence=>10
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style>',
'    /* Center the loader container */',
'    .loader-container {',
'        position: fixed;',
'        top: 0;',
'        left: 0;',
'        width: 100%;',
'        height: 100%;',
'        background-color: rgba(0, 0, 0, 0.7);',
'        display: flex;',
'        justify-content: center;',
'        align-items: center;',
'        z-index: 9999;',
'        /* Ensure it''s above other elements */',
'    }',
'',
'    /* Define the loader animation */',
'    .loader {',
'        border: 4px solid rgba(255, 255, 255, 0.3);',
'        border-top: 4px solid #2196F3;',
'        border-radius: 50%;',
'        width: 50px;',
'        height: 50px;',
'        animation: spin 2s linear infinite;',
'        position: absolute;',
'        left: 0;',
'        top: 0;',
'        bottom: 0;',
'        right: 0;',
'        margin: auto;',
'    }',
'',
'    @keyframes spin {',
'        0% {',
'            transform: rotate(0deg);',
'        }',
'',
'        100% {',
'            transform: rotate(360deg);',
'        }',
'    }',
'',
'    /* Hide the loader initially */',
'    .loader-container {',
'        display: none;',
'    }',
'',
'    #P5_ID_NUM_ATTACH_CONTAINER>span {',
'        align-items: start;',
'        padding-top: 5px;',
'    }',
'    #identify-detail .t-Tabs-item a{',
'        text-align:left !important;',
'    }',
'    ',
'</style>',
'',
'<script>',
'    // GLOBAL FUNCTION',
'    function getCurrentDateFormatted() {',
'        const currentDate = new Date();',
'',
'        const day = String(currentDate.getDate()).padStart(2, ''0'');',
'        const month = String(currentDate.getMonth() + 1).padStart(2, ''0''); // Months are zero-based, so add 1',
'        const year = currentDate.getFullYear();',
'',
'        return `${day}-${month}-${year}`;',
'    }',
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
'</script>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8101712201268649)
,p_plug_name=>'Personal'
,p_parent_plug_id=>wwv_flow_imp.id(8101674187268648)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_landmark_type=>'exclude_landmark'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8176592605022810)
,p_plug_name=>'Permanent address'
,p_parent_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P5_PER_PROVINCE'
,p_plug_display_when_cond2=>'''666'''
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8177005121022815)
,p_plug_name=>'Temporary address'
,p_parent_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>40
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_display_condition_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_display_when_condition=>'P5_TEMP_PROVINCE'
,p_plug_display_when_cond2=>'''666'''
,p_plug_read_only_when_type=>'VAL_OF_ITEM_IN_COND_EQ_COND2'
,p_plug_read_only_when=>'P5_TEMP_PROVINCE'
,p_plug_read_only_when2=>'666'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8177526385022820)
,p_plug_name=>'Employee''s Emergency Contact'
,p_parent_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>50
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8922551035040310)
,p_plug_name=>'Permanent Address'
,p_parent_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(9259903859015806)
,p_plug_name=>'Temporary Address'
,p_parent_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8178295422022827)
,p_plug_name=>'Identity Number'
,p_region_name=>'__tab_id'
,p_parent_plug_id=>wwv_flow_imp.id(8101674187268648)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_landmark_type=>'exclude_landmark'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8178309666022828)
,p_plug_name=>'Detail'
,p_region_name=>'identify-detail'
,p_parent_plug_id=>wwv_flow_imp.id(8178295422022827)
,p_region_template_options=>'#DEFAULT#:t-TabsRegion-mod--simple'
,p_plug_template=>wwv_flow_imp.id(18710165183889068)
,p_plug_display_sequence=>10
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8178431762022829)
,p_plug_name=>'ID Number'
,p_parent_plug_id=>wwv_flow_imp.id(8178309666022828)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- Loading spinner container -->',
'<div class="loader-container" id="loader-container">',
'    <div class="loader"></div>',
'</div>',
'',
'<script>',
'    let formDataIdNumber = new FormData();',
'    let fileNamesID;',
'    let fileUrlsID;',
'    let fileArrayNames = [];',
'    let fileArrayUrls = [];',
'    window.addEventListener("load", function () {',
'        var imageUrlsID = apex.item("P5_DEFAULT_IMAGES_URL").getValue();',
'        var imageNamesID = apex.item("P5_DEFAULT_IMAGES_NAME").getValue();',
'        var imageContainer = document.getElementById("P5_ID_NUM_ATTACH_GROUP");',
'        const urlArray = imageUrlsID.split(";");',
'        const nameArray = imageNamesID.split(";");',
'        apex.item("P5_URL").setValue(imageUrlsID);',
'        apex.item("P5_URL_NAME").setValue(imageNamesID);',
'',
'        for (let i = 0; i < urlArray.length; i++) {',
'            const imageUrl = urlArray[i];',
'            const imageName = nameArray[i];',
'            fileArrayNames.push(imageName);',
'            fileArrayUrls.push(imageUrl);',
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
'        var deleteButtons = document.querySelectorAll(".btn-delete");',
'        deleteButtons.forEach(function (button) {',
'            button.addEventListener("click", handleDeleteClick);',
'        });',
'',
'        var userName = apex.item("P5_FULL_NAME_DISPLAY").getValue();',
'        var userCode = apex.item("P5_EMPLOYEE_CODE_DISPLAY").getValue();',
'',
'        formDataIdNumber.append("name", userName);',
'        formDataIdNumber.append("msnv", userCode);',
'        document',
'            .getElementById("P5_ID_NUM_ATTACH")',
'            .addEventListener("change", function (event) {',
'                const imageFiles = event.target.files;',
'                const hiddenInputContainer = document.getElementById(',
'                    "P5_ID_NUM_ATTACH_GROUP"',
'                );',
'                const maxFileSize = 1 * 1024 * 1024; // 1MB in bytes',
'',
'                formDataIdNumber.append("date", getCurrentDateFormatted());',
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
'                    formDataIdNumber.append("files", imageFile);',
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
'                hiddenInputContainer.addEventListener("click", handleDeleteClick);',
'            });',
'    });',
'',
'    //UPLOAD FILE',
'    //SUBMIT FORM',
'    document.addEventListener(''DOMContentLoaded'', function () {',
'        document',
'            .getElementById("iden_submit")',
'            .addEventListener("click", async function (event) {',
'                let nullFormData = false;',
'                const elements = document.querySelectorAll(".dynamic-value-page");',
'                const names = [];',
'                const hrefs = [];',
'                var imageNamesID = apex.item("P5_DEFAULT_IMAGES_NAME").getValue();',
'                const nameArray = imageNamesID.split(";");',
'',
'                // document.getElementById(''loader-container'').style.display = ''block'';',
'                for (const value of formDataIdNumber.values()) {',
'                    if (value.name != null) {',
'                        nullFormData = true;',
'                    }',
'                }',
'',
'                if (nullFormData) {',
'                    try {',
'                        // Set time out 15s',
'                        const response = await fetch("https://graphapi.vus.edu.vn/upload", {',
'                            method: "POST",',
'                            body: formDataIdNumber,',
'                            timeout: 15000,',
'                        });',
'',
'                        if (response.status === 200) {',
'                            const responseBody = await response.json();',
'                            fileNamesID = responseBody.data.map((item) => item.name).join(";");',
'                            fileUrlsID = responseBody.data.map((item) => item.path).join(";");',
'                            const newfileUrlsID = fileArrayUrls.join(";") + ";" + fileUrlsID;',
'                            const newfileNamesID = fileArrayNames.join(";") + ";" + fileNamesID;',
'                            await apex.item("P5_URL").setValue(newfileUrlsID);',
'                            await apex.item("P5_URL_NAME").setValue(newfileNamesID);',
'                        } else {',
'                            console.log("Upload failed");',
'                        }',
'                    } catch (error) {',
'                        console.error("An error occurred:", error);',
'                    } finally {',
'                        document.getElementById("loader-container").style.display = "none";',
'                        setTimeout(function () {',
'                            apex.submit("IDEN_Submit");',
'                        }, 500);',
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
'                    await apex.item("P5_URL").setValue(urlString);',
'                    await apex.item("P5_URL_NAME").setValue(namesString);',
'                    // apex.submit("IDEN_Submit");',
'                    setTimeout(function () {',
'                        apex.submit("IDEN_Submit");',
'                    }, 500);',
'                }',
'                document.getElementById("loader-container").style.display = "none";',
'            });',
'    });',
'',
'    function handleDeleteClick(event) {',
'        if (event.target.classList.contains("delete-item")) {',
'            const itemToRemove = event.target.closest("div");',
'            const name = event.target.dataset.name;',
'            const url = itemToRemove.querySelector("a").getAttribute("href");',
'            const files = formDataIdNumber.getAll("files");',
'            const updatedFiles = files.filter((file) => file.name !== name);',
'            formDataIdNumber.delete("files");',
'            fileArrayNames = fileArrayNames.filter((item) => item !== name);',
'            fileArrayUrls = fileArrayNames.filter((item) => item !== url);',
'            updatedFiles.forEach((file) => formDataIdNumber.append("files", file));',
'            if (itemToRemove) {',
'                itemToRemove.remove();',
'                document.getElementById("loader-container").style.display = "none";',
'            }',
'        }',
'    }',
'</script>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(10005145356336817)
,p_plug_name=>'Attatch url'
,p_parent_plug_id=>wwv_flow_imp.id(8178431762022829)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_function_body_language=>'PLSQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
'',
'htp.p(''<ul>'');',
'for rec in (select ATTACH_FILE,ATTACH_NAME from EMP_ID_NUMBER where EMPLOYEE_CODE = :APP_EMP_CODE',
'and ATTACH_FILE is not null',
')loop',
'    htp.p(''<li><a href="''||rec.ATTACH_FILE||''" target="_blank">''||rec.ATTACH_NAME||''</a></li>'');',
'end loop;',
'',
'return ''</ul>'';',
'',
'end;'))
,p_lazy_loading=>false
,p_plug_source_type=>'NATIVE_DYNAMIC_CONTENT'
,p_plug_display_condition_type=>'EXPRESSION'
,p_plug_display_when_condition=>'false'
,p_plug_display_when_cond2=>'PLSQL'
,p_landmark_type=>'exclude_landmark'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8178776054022832)
,p_plug_name=>'Work Permit Number'
,p_parent_plug_id=>wwv_flow_imp.id(8178309666022828)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>40
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8179033279022835)
,p_plug_name=>'Social Insurance Number'
,p_parent_plug_id=>wwv_flow_imp.id(8178309666022828)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>50
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- Loading spinner container -->',
'<div class="loader-container" id="loader-container">',
'    <div class="loader"></div>',
'</div>',
'',
'<script>',
'    let formData_SOC = new FormData();',
'    let fileNames_SOC;',
'    let fileUrls_SOC;',
'    let fileArrayNames_SOC = [];',
'    let fileArrayUrls_SOC = [];',
'    window.addEventListener("load", function () {',
'        var imageUrlsID = apex.item("P5_DEFAULT_IMAGES_URL_SS").getValue();',
'        var imageNamesID = apex.item("P5_DEFAULT_IMAGES_NAME_SS").getValue();',
'        var imageContainer = document.getElementById("P5_SOC_ATTACH_GROUP");',
'        const urlArray = imageUrlsID.split(";");',
'        const nameArray = imageNamesID.split(";");',
'        apex.item("P5_URL_SS").setValue(imageUrlsID);',
'        apex.item("P5_URL_NAME_SS").setValue(imageNamesID);',
'',
'        for (let i = 0; i < urlArray.length; i++) {',
'            const imageUrl = urlArray[i];',
'            const imageName = nameArray[i];',
'            fileArrayNames_SOC.push(imageName);',
'            fileArrayUrls_SOC.push(imageUrl);',
'            let hiddenInputHTML;',
'            if (imageUrl != "" || imageName != "") {',
'                hiddenInputHTML = `',
'        <div class="file-item ">',
'            <span  id="deleteItem${imageName}" data-name="${imageName}" class="delete-item btn-delete vng-true"> X </span>',
'            <a name="${imageName}" href="${imageUrl}" target="_blank" class="dynamic-value-page-3">',
'                ${imageName}',
'            </a>',
'        </div>',
'    `;',
'            } else {',
'                hiddenInputHTML = ``;',
'            }',
'            imageContainer.insertAdjacentHTML("beforeend", hiddenInputHTML);',
'        }',
'        var deleteButtons = document.querySelectorAll(".btn-delete");',
'        deleteButtons.forEach(function (button) {',
'            button.addEventListener("click", handleDeleteClick_SOC);',
'        });',
'',
'        var userName = apex.item("P5_FULL_NAME_DISPLAY").getValue();',
'        var userCode = apex.item("P5_EMPLOYEE_CODE_DISPLAY").getValue();',
'',
'        formData_SOC.append("name", userName);',
'        formData_SOC.append("msnv", userCode);',
'        document',
'            .getElementById("P5_SOC_ATTACH")',
'            .addEventListener("change", function (event) {',
'                const imageFiles = event.target.files;',
'                const hiddenInputContainer = document.getElementById(',
'                    "P5_SOC_ATTACH_GROUP"',
'                );',
'                const maxFileSize = 1 * 1024 * 1024; // 1MB in bytes',
'',
'                formData_SOC.append("date", getCurrentDateFormatted());',
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
'                    formData_SOC.append("files", imageFile);',
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
'                hiddenInputContainer.addEventListener("click", handleDeleteClick_SOC);',
'            });',
'    });',
'',
'    //UPLOAD FILE',
'    //SUBMIT FORM',
'    document.addEventListener(''DOMContentLoaded'', function () {',
'        document',
'            .getElementById("SOC_Submit")',
'            .addEventListener("click", async function (event) {',
'                let nullFormData = false;',
'                const elements = document.querySelectorAll(".dynamic-value-page-3");',
'                const names = [];',
'                const hrefs = [];',
'                var imageNamesID = apex.item("P5_DEFAULT_IMAGES_NAME_SS").getValue();',
'                const nameArray = imageNamesID.split(";");',
'',
'                // document.getElementById(''loader-container'').style.display = ''block'';',
'                for (const value of formData_SOC.values()) {',
'                    if (value.name != null) {',
'                        nullFormData = true;',
'                    }',
'                }',
'',
'                if (nullFormData) {',
'                    try {',
'                        const response = await fetch("https://graphapi.vus.edu.vn/upload", {',
'                            method: "POST",',
'                            body: formData_SOC,',
'                        });',
'',
'                        if (response.status === 200) {',
'                            const responseBody = await response.json();',
'                            fileNames_SOC = responseBody.data.map((item) => item.name).join(";");',
'                            fileUrls_SOC = responseBody.data.map((item) => item.path).join(";");',
'                            const newfileUrls_SOC = fileArrayUrls_SOC.join(";") + ";" + fileUrls_SOC;',
'                            const newfileNames_SOC = fileArrayNames_SOC.join(";") + ";" + fileNames_SOC;',
'                            await apex.item("P5_URL_SS").setValue(newfileUrls_SOC);',
'                            await apex.item("P5_URL_NAME_SS").setValue(newfileNames_SOC);',
'                        } else {',
'                            console.log("Upload failed");',
'                        }',
'                    } catch (error) {',
'                        console.error("An error occurred:", error);',
'                    } finally {',
'                        document.getElementById("loader-container").style.display = "none";',
'                        setTimeout(function () {',
'                            apex.submit("SOC_Submit");',
'                        }, 500);',
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
'                    await apex.item("P5_URL_SS").setValue(urlString);',
'                    await apex.item("P5_URL_NAME_SS").setValue(namesString);',
'                    // apex.submit("SOC_Submit");',
'                    setTimeout(function () {',
'                        apex.submit("SOC_Submit");',
'                    }, 500);',
'                }',
'                document.getElementById("loader-container").style.display = "none";',
'            });',
'    });',
'',
'    function handleDeleteClick_SOC(event) {',
'        if (event.target.classList.contains("delete-item")) {',
'            const itemToRemove = event.target.closest("div");',
'            const name = event.target.dataset.name;',
'            const url = itemToRemove.querySelector("a").getAttribute("href");',
'            const files = formData_SOC.getAll("files");',
'            const updatedFiles = files.filter((file) => file.name !== name);',
'            formData_SOC.delete("files");',
'            fileArrayNames_SOC = fileArrayNames_SOC.filter((item) => item !== name);',
'            fileArrayUrls_SOC = fileArrayNames_SOC.filter((item) => item !== url);',
'            updatedFiles.forEach((file) => formData_SOC.append("files", file));',
'            if (itemToRemove) {',
'                itemToRemove.remove();',
'                document.getElementById("loader-container").style.display = "none";',
'            }',
'        }',
'    }',
'',
'</script>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
end;
/
begin
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8179356274022838)
,p_plug_name=>'PIT Number'
,p_parent_plug_id=>wwv_flow_imp.id(8178309666022828)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>60
,p_plug_display_point=>'SUB_REGIONS'
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8923261530040317)
,p_plug_name=>'Passport Number'
,p_region_name=>'passport-number'
,p_parent_plug_id=>wwv_flow_imp.id(8178309666022828)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>20
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- Loading spinner container -->',
'<div class="loader-container" id="loader-container">',
'    <div class="loader"></div>',
'</div>',
'',
'<script>',
'    let formData_PP = new FormData();',
'    let fileNames_PP;',
'    let fileUrls_PP;',
'    let fileArrayNames_PP = [];',
'    let fileArrayUrls_PP = [];',
'    window.addEventListener("load", function () {',
'        var imageUrlsID = apex.item("P5_DEFAULT_IMAGES_URL_1").getValue();',
'        var imageNamesID = apex.item("P5_DEFAULT_IMAGES_NAME_1").getValue();',
'        var imageContainer = document.getElementById("P5_ID_NUM_ATTACH_1_GROUP");',
'        const urlArray = imageUrlsID.split(";");',
'        const nameArray = imageNamesID.split(";");',
'        apex.item("P5_URL_1").setValue(imageUrlsID);',
'        apex.item("P5_URL_NAME_1").setValue(imageNamesID);',
'',
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
'            <a name="${imageName}" href="${imageUrl}" target="_blank" class="dynamic-value-page-1">',
'                ${imageName}',
'            </a>',
'        </div>',
'    `;',
'            } else {',
'                hiddenInputHTML = ``;',
'            }',
'            imageContainer.insertAdjacentHTML("beforeend", hiddenInputHTML);',
'        }',
'        var deleteButtons = document.querySelectorAll(".btn-delete");',
'        deleteButtons.forEach(function (button) {',
'            button.addEventListener("click", handleDeleteClick_PP);',
'        });',
'',
'        var userName = apex.item("P5_FULL_NAME_DISPLAY").getValue();',
'        var userCode = apex.item("P5_EMPLOYEE_CODE_DISPLAY").getValue();',
'',
'        formData_PP.append("name", userName);',
'        formData_PP.append("msnv", userCode);',
'        document',
'            .getElementById("P5_ID_NUM_ATTACH_1")',
'            .addEventListener("change", function (event) {',
'                const imageFiles = event.target.files;',
'                const hiddenInputContainer = document.getElementById(',
'                    "P5_ID_NUM_ATTACH_1_GROUP"',
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
'            .getElementById("iden_submit_1")',
'            .addEventListener("click", async function (event) {',
'                let nullFormData = false;',
'                const elements = document.querySelectorAll(".dynamic-value-page-1");',
'                const names = [];',
'                const hrefs = [];',
'                var imageNamesID = apex.item("P5_DEFAULT_IMAGES_NAME_1").getValue();',
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
'                            await apex.item("P5_URL_1").setValue(newfileUrls_PP);',
'                            await apex.item("P5_URL_NAME_1").setValue(newfileNames_PP);',
'                        } else {',
'                            console.log("Upload failed");',
'                        }',
'                    } catch (error) {',
'                        console.error("An error occurred:", error);',
'                    } finally {',
'                        document.getElementById("loader-container").style.display = "none";',
'                        setTimeout(function () {',
'                            apex.submit("IDEN_Submit_1");',
'                        }, 500);',
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
'                    await apex.item("P5_URL_1").setValue(urlString);',
'                    await apex.item("P5_URL_NAME_1").setValue(namesString);',
'                    // apex.submit("iden_submit_1");',
'                    setTimeout(function () {',
'                        apex.submit("IDEN_Submit_1");',
'                    }, 500);',
'                }',
'                document.getElementById("loader-container").style.display = "none";',
'            });',
'    });',
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
'',
'</script>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8179601555022841)
,p_plug_name=>'Education'
,p_region_name=>'education_tab'
,p_parent_plug_id=>wwv_flow_imp.id(8101674187268648)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>20
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<script>',
'document.addEventListener(''DOMContentLoaded'', function() {',
'jQuery(document).ready(function($) {',
'    if ($(''html[lang="vi"]'').length) {',
unistr('        $(''.a-Toolbar-item span.a-Button-label:contains("Add Row")'').text(''Th\00EAm D\00F2ng'');'),
unistr('        $(''.a-Toolbar-item span.a-Button-label:contains("Edit")'').text(''S\1EEDa'');'),
unistr('        $(''.a-Toolbar-item span.a-Button-label:contains("Actions")'').text(''H\00E0nh \0110\1ED9ng'');'),
unistr('        $(''.a-Menu-inner .a-Menu-label:contains("Single Row View")'').text(''Xem m\1ED9t d\00F2ng'');'),
'    }',
'});',
'});',
'',
'</script>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8236520445381416)
,p_plug_name=>'Degree'
,p_region_name=>'education-box'
,p_parent_plug_id=>wwv_flow_imp.id(8179601555022841)
,p_region_template_options=>'#DEFAULT#'
,p_component_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>10
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    edu.ID,',
'    edu.EMPLOYEE_ID,',
'    edu.TYPE,',
'    edu.LEVEL_OF_EDU,',
'    edu.MAJOR,',
'    edu.PLACE,',
'    edu.GRADUATED_DATE,',
'    edu.ATTACH_FILE,',
'    edu.EMPLOYEE_CODE,',
'    --IS_DEL,',
'    --EXPIRATION_DATE,',
'    --EFFECTIVE_DATE,',
'    ''#'' as Action,',
'    ''<span><i class="fa fa-upload"></span>'' as Upload,',
'    TO_HREF_HTML_ATTACHMENT(edu.ATTACH_URL, edu.ATTACH_NAME) as edu_attachment,',
'    edu.TEMP_ID',
'from EMP_EDUCATION edu where edu.EMPLOYEE_CODE = :APP_EMP_CODE and edu.IS_DEL = 0',
'/*',
'INNER JOIN ',
'  EMPLOYEES e ON edu.EMPLOYEE_CODE = e.EMPLOYEE_CODE',
'WHERE e.USER_NAME = :APP_USER_NAME and edu.IS_DEL = 0',
'*/'))
,p_plug_source_type=>'NATIVE_IG'
,p_ajax_items_to_submit=>'APP_EMP_CODE'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Degree'
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
 p_id=>wwv_flow_imp.id(8236758894381418)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(8236858845381419)
,p_name=>'EMPLOYEE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'APP_EMP_CODE'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(8236944114381420)
,p_name=>'TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TYPE'
,p_data_type=>'VARCHAR2'
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
 p_id=>wwv_flow_imp.id(8237066523381421)
,p_name=>'LEVEL_OF_EDU'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'LEVEL_OF_EDU'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Level Of Education'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>60
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>'SELECT LEV_DESCRIPTION, LEV_DESCRIPTION as ID FROM LIST_EDUCATION_LEVEL'
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
 p_id=>wwv_flow_imp.id(8237131682381422)
,p_name=>'MAJOR'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'MAJOR'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Major'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
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
 p_id=>wwv_flow_imp.id(8237274437381423)
,p_name=>'PLACE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'PLACE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_POPUP_LOV'
,p_heading=>'Name of School/University/Institute'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
,p_is_required=>false
,p_max_length=>500
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>'select LEI_NAME_OF_SCHOOL, LEI_NAME_OF_SCHOOL as ID from LIST_EDUCATION_INSTITUTION'
,p_lov_display_extra=>true
,p_lov_display_null=>true
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
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(8237331696381424)
,p_name=>'GRADUATED_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'GRADUATED_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Graduation Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
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
 p_id=>wwv_flow_imp.id(8237446545381425)
,p_name=>'ATTACH_FILE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATTACH_FILE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>100
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(8237869148381429)
,p_name=>'Action'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ACTION'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_LINK'
,p_heading=>'Action'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>110
,p_value_alignment=>'CENTER'
,p_link_target=>'f?p=&APP_ID.:17:&SESSION.::&DEBUG.:17:P17_ID,P17_TYPE:&ID.,edu'
,p_link_text=>'Delete'
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
,p_include_in_export=>true
,p_display_condition_type=>'REQUEST_EQUALS_CONDITION'
,p_display_condition=>'disabled'
,p_escape_on_http_output=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(9767589187102034)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(9767643012102035)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'N'
,p_attribute_03=>'N'
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(10004157428336807)
,p_name=>'EMPLOYEE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>120
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'APP_EMP_CODE'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(22746451036164443)
,p_name=>'UPLOAD'
,p_source_type=>'NONE'
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>130
,p_value_alignment=>'CENTER'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="javascript:void(0);";  class="edu-upload-link" data-edu-id="&ID." data-empcode="&EMPLOYEE_CODE." data-tempid="&TEMP_ID."><span class="fa fa-upload"></span></a>',
'',
''))
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_hide=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(23665114858578128)
,p_name=>'EDU_ATTACHMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EDU_ATTACHMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Attachments'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'LEFT'
,p_attribute_05=>'HTML'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(23666104302578138)
,p_name=>'TEMP_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TEMP_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>150
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>false
,p_include_in_export=>false
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(8236612957381417)
,p_internal_uid=>8236612957381417
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
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
,p_toolbar_buttons=>null
,p_enable_save_public_report=>true
,p_public_report_auth_scheme=>wwv_flow_imp.id(8357747594961355)
,p_enable_subscriptions=>true
,p_enable_flashback=>false
,p_define_chart_view=>false
,p_enable_download=>false
,p_download_formats=>null
,p_fixed_header=>'PAGE'
,p_show_icon_view=>false
,p_show_detail_view=>false
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(8247446280521818)
,p_interactive_grid_id=>wwv_flow_imp.id(8236612957381417)
,p_static_id=>'82475'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(8247618615521819)
,p_report_id=>wwv_flow_imp.id(8247446280521818)
,p_view_type=>'GRID'
,p_stretch_columns=>false
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8248143020521825)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(8236758894381418)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8249087498521831)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(8236858845381419)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8249941130521835)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(8236944114381420)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8250817679521838)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(8237066523381421)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>148
,p_sort_order=>1
,p_sort_direction=>'DESC'
,p_sort_nulls=>'FIRST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8251757272521841)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(8237131682381422)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>173
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8252531003521844)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(8237274437381423)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>389.938
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8253418538521847)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(8237331696381424)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>160.969
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8254377256521850)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(8237446545381425)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8258707794544542)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(8237869148381429)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(9956665419803561)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(9767589187102034)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(10030569995357387)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(10004157428336807)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(22996338471657093)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(22746451036164443)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>97
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(24398527791499129)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(23665114858578128)
,p_is_visible=>true
,p_is_frozen=>true
,p_width=>517
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(24498715505047244)
,p_view_id=>wwv_flow_imp.id(8247618615521819)
,p_display_seq=>14
,p_column_id=>wwv_flow_imp.id(23666104302578138)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8237984547381430)
,p_plug_name=>'Other Certificates'
,p_region_name=>'certificate-box'
,p_parent_plug_id=>wwv_flow_imp.id(8179601555022841)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>30
,p_plug_display_point=>'SUB_REGIONS'
,p_query_type=>'SQL'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'       cert.ID,',
'       cert.EMPLOYEE_ID,',
'       cert.CERTIFICATE_DESCRIPTION,',
'       cert.END_DATE,',
'       cert.START_DATE,  ',
'       cert.SHORT_NOTE,     ',
'       cert.CERTIFICATE_TYPE,',
'       cert.EMPLOYEE_CODE,',
'       cert.ATTACHMENT,',
'       TO_HREF_HTML_ATTACHMENT(cert.ATTACHMENT_URL, cert.ATTACHMENT_NAME) as cert_attachment,',
'       ''#'' as Upload,',
'       cert.TEMP_ID',
'',
'from EMP_CERTIFICATE cert where cert.EMPLOYEE_CODE = :APP_EMP_CODE and cert.IS_DEL = 0',
'/*',
'INNER JOIN ',
'    EMPLOYEES e ON cert.EMPLOYEE_CODE = e.EMPLOYEE_CODE',
'WHERE e.USER_NAME = :APP_USER_NAME',
'*/'))
,p_plug_source_type=>'NATIVE_IG'
,p_prn_content_disposition=>'ATTACHMENT'
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'Other Certificates'
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
 p_id=>wwv_flow_imp.id(8275658290603807)
,p_name=>'ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>30
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>true
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(8275714822603808)
,p_name=>'EMPLOYEE_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>40
,p_attribute_01=>'N'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(8922057848040305)
,p_name=>'CERTIFICATE_DESCRIPTION'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CERTIFICATE_DESCRIPTION'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>60
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
end;
/
begin
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(8922174791040306)
,p_name=>'END_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'END_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Expiration Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>70
,p_value_alignment=>'CENTER'
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
 p_id=>wwv_flow_imp.id(8922206941040307)
,p_name=>'START_DATE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'START_DATE'
,p_data_type=>'DATE'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_DATE_PICKER_APEX'
,p_heading=>'Effective Date'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>80
,p_value_alignment=>'CENTER'
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
 p_id=>wwv_flow_imp.id(8922364685040308)
,p_name=>'SHORT_NOTE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'SHORT_NOTE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_TEXT_FIELD'
,p_heading=>'Note'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>90
,p_value_alignment=>'CENTER'
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
 p_id=>wwv_flow_imp.id(8922488955040309)
,p_name=>'CERTIFICATE_TYPE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CERTIFICATE_TYPE'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_SELECT_LIST'
,p_heading=>'Certificate Type'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>100
,p_value_alignment=>'CENTER'
,p_is_required=>false
,p_lov_type=>'SQL_QUERY'
,p_lov_source=>'SELECT LCT_CERTIFICATE_DESCRIPTION, LCT_HCM_CERTIFICATE_TYPE_ID AS ID from LIST_CERTIFICATE_TYPE'
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
 p_id=>wwv_flow_imp.id(9767895371102037)
,p_name=>'APEX$ROW_ACTION'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_ACTION'
,p_display_sequence=>20
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(9767954388102038)
,p_name=>'APEX$ROW_SELECTOR'
,p_session_state_data_type=>'VARCHAR2'
,p_item_type=>'NATIVE_ROW_SELECTOR'
,p_display_sequence=>10
,p_attribute_01=>'N'
,p_attribute_03=>'N'
,p_use_as_row_header=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(10004266004336808)
,p_name=>'EMPLOYEE_CODE'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'EMPLOYEE_CODE'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>110
,p_attribute_01=>'Y'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_default_type=>'ITEM'
,p_default_expression=>'APP_EMP_CODE'
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(15569305637256540)
,p_name=>'ATTACHMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'ATTACHMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>120
,p_attribute_01=>'Y'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(23665272369578129)
,p_name=>'CERT_ATTACHMENT'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'CERT_ATTACHMENT'
,p_data_type=>'VARCHAR2'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_DISPLAY_ONLY'
,p_heading=>'Attachments'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>140
,p_value_alignment=>'LEFT'
,p_attribute_05=>'HTML'
,p_enable_filter=>true
,p_filter_operators=>'C:S:CASE_INSENSITIVE:REGEXP'
,p_filter_is_required=>false
,p_filter_text_case=>'MIXED'
,p_filter_lov_type=>'NONE'
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>true
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(24801638849944236)
,p_name=>'CERT_UPLOAD'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'UPLOAD'
,p_data_type=>'VARCHAR2'
,p_is_query_only=>true
,p_item_type=>'NATIVE_HTML_EXPRESSION'
,p_heading_alignment=>'CENTER'
,p_display_sequence=>150
,p_value_alignment=>'CENTER'
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<a href="javascript:void(0);";  class="cert-upload-link" data-cert-id="&ID." data-empcode="&EMPLOYEE_CODE." data-tempid="&TEMP_ID."><span class="fa fa-upload"></span></a>',
'',
''))
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_enable_hide=>true
,p_is_primary_key=>false
,p_include_in_export=>false
);
wwv_flow_imp_page.create_region_column(
 p_id=>wwv_flow_imp.id(24801796814944237)
,p_name=>'TEMP_ID'
,p_source_type=>'DB_COLUMN'
,p_source_expression=>'TEMP_ID'
,p_data_type=>'NUMBER'
,p_session_state_data_type=>'VARCHAR2'
,p_is_query_only=>false
,p_item_type=>'NATIVE_HIDDEN'
,p_display_sequence=>160
,p_attribute_01=>'N'
,p_filter_is_required=>false
,p_use_as_row_header=>false
,p_enable_sort_group=>false
,p_is_primary_key=>false
,p_duplicate_value=>true
,p_include_in_export=>false
);
wwv_flow_imp_page.create_interactive_grid(
 p_id=>wwv_flow_imp.id(8275523840603806)
,p_internal_uid=>8275523840603806
,p_is_editable=>true
,p_edit_operations=>'i:u:d'
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
,p_oracle_text_index_column=>'ID'
);
wwv_flow_imp_page.create_ig_report(
 p_id=>wwv_flow_imp.id(8292688863617978)
,p_interactive_grid_id=>wwv_flow_imp.id(8275523840603806)
,p_static_id=>'82927'
,p_type=>'PRIMARY'
,p_default_view=>'GRID'
,p_show_row_number=>false
,p_settings_area_expanded=>true
);
wwv_flow_imp_page.create_ig_report_view(
 p_id=>wwv_flow_imp.id(8292863558617978)
,p_report_id=>wwv_flow_imp.id(8292688863617978)
,p_view_type=>'GRID'
,p_stretch_columns=>true
,p_srv_exclude_null_values=>false
,p_srv_only_display_columns=>true
,p_edit_mode=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8293319591617981)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>2
,p_column_id=>wwv_flow_imp.id(8275658290603807)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8294215977617984)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>3
,p_column_id=>wwv_flow_imp.id(8275714822603808)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8948386536826227)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>5
,p_column_id=>wwv_flow_imp.id(8922057848040305)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8949242620826236)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>7
,p_column_id=>wwv_flow_imp.id(8922174791040306)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>84
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8950149062826239)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>6
,p_column_id=>wwv_flow_imp.id(8922206941040307)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>88
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8951031883826242)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>8
,p_column_id=>wwv_flow_imp.id(8922364685040308)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>486
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(8951928442826246)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>4
,p_column_id=>wwv_flow_imp.id(8922488955040309)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>130
,p_sort_order=>1
,p_sort_direction=>'DESC'
,p_sort_nulls=>'FIRST'
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(9963671080831901)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>1
,p_column_id=>wwv_flow_imp.id(9767895371102037)
,p_is_visible=>true
,p_is_frozen=>true
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(10031485702357391)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>9
,p_column_id=>wwv_flow_imp.id(10004266004336808)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(17851452212106753)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>10
,p_column_id=>wwv_flow_imp.id(15569305637256540)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(24405017743542931)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>11
,p_column_id=>wwv_flow_imp.id(23665272369578129)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>473
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(25067454249527409)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>12
,p_column_id=>wwv_flow_imp.id(24801638849944236)
,p_is_visible=>true
,p_is_frozen=>false
,p_width=>89
);
wwv_flow_imp_page.create_ig_report_column(
 p_id=>wwv_flow_imp.id(25068311652527413)
,p_view_id=>wwv_flow_imp.id(8292863558617978)
,p_display_seq=>13
,p_column_id=>wwv_flow_imp.id(24801796814944237)
,p_is_visible=>true
,p_is_frozen=>false
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8179722526022842)
,p_plug_name=>' Bank Account'
,p_parent_plug_id=>wwv_flow_imp.id(8101674187268648)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>30
,p_include_in_reg_disp_sel_yn=>'Y'
,p_plug_display_point=>'SUB_REGIONS'
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<!-- <script>',
'    document.addEventListener("DOMContentLoaded", function(event){',
'        var selectList = apex.item(''P5_BANK_NAME'');',
'        selectList.disable();',
'    });',
'</script> -->'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(8174482272996537)
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
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8236131725381412)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(8179356274022838)
,p_button_name=>'PIT_Submit'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_grid_column_css_classes=>'col-2'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8236236431381413)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(8179356274022838)
,p_button_name=>'PIT_Reset'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancel'
,p_grid_column_css_classes=>'col-2'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8236352292381414)
,p_button_sequence=>50
,p_button_plug_id=>wwv_flow_imp.id(8179722526022842)
,p_button_name=>'BANK_Submit'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_grid_new_row=>'Y'
,p_database_action=>'UPDATE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8180297924022847)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(8178431762022829)
,p_button_name=>'IDEN_Submit'
,p_button_static_id=>'iden_submit'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_execute_validations=>'N'
,p_warn_on_unsaved_changes=>null
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8236414121381415)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(8179722526022842)
,p_button_name=>'BANK_Cancel'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancel'
,p_grid_column_css_classes=>'col-2'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8923872414040323)
,p_button_sequence=>60
,p_button_plug_id=>wwv_flow_imp.id(8923261530040317)
,p_button_name=>'IDEN_Submit_1'
,p_button_static_id=>'iden_submit_1'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_warn_on_unsaved_changes=>null
,p_grid_column_css_classes=>'col-2'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8180387421022848)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(8178431762022829)
,p_button_name=>'IDEN_Reset'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancel'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8923995276040324)
,p_button_sequence=>70
,p_button_plug_id=>wwv_flow_imp.id(8923261530040317)
,p_button_name=>'IDEN_Reset_1'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--small:t-Button--stretch'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancel'
,p_grid_column_css_classes=>'col-2'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8235933053381410)
,p_button_sequence=>90
,p_button_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_button_name=>'SOC_Submit'
,p_button_static_id=>'SOC_Submit'
,p_button_action=>'DEFINED_BY_DA'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_warn_on_unsaved_changes=>null
,p_grid_column_css_classes=>'col-2'
,p_grid_new_row=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8236073632381411)
,p_button_sequence=>100
,p_button_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_button_name=>'SOC_Reset'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancel'
,p_grid_column_css_classes=>'col-2'
,p_grid_new_row=>'N'
,p_grid_new_column=>'Y'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8178056811022825)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_button_name=>'Submit'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_position=>'CHANGE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8239352126381444)
,p_button_sequence=>10
,p_button_plug_id=>wwv_flow_imp.id(8179601555022841)
,p_button_name=>'EDU_Submit'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Submit'
,p_button_position=>'CHANGE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8177916495022824)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_button_name=>'Cancel'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancel'
,p_button_position=>'CHANGE'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(8239437400381445)
,p_button_sequence=>20
,p_button_plug_id=>wwv_flow_imp.id(8179601555022841)
,p_button_name=>'EDU_Cancel'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#'
,p_button_template_id=>wwv_flow_imp.id(18773230366889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Cancel'
,p_button_position=>'CHANGE'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8101832979268650)
,p_name=>'P5_FULL_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_item_default=>'select FULL_NAME from employees where USER_NAME = :APP_USER_NAME'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Full Name'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(8175681021022801)
,p_name=>'P5_EMPLOYEE_CODE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_item_default=>'select EMPLOYEE_CODE from employees where USER_NAME = :APP_USER_NAME'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Employee Code'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(8175763814022802)
,p_name=>'P5_DOB'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_item_default=>'select to_char(DOB, ''DD/MM/YYYY'') from employees where USER_NAME = :APP_USER_NAME'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Birthdate'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_read_only_when_type=>'ALWAYS'
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
 p_id=>wwv_flow_imp.id(8175830937022803)
,p_name=>'P5_GENDER'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    CASE ',
'        WHEN GENDER = 0 THEN ''Others''',
'        WHEN GENDER = 1 THEN ''Male''',
'        WHEN GENDER = 2 THEN ''Female''',
'        ELSE ''Unknown'' -- Optional, handle any other values not in the mapping',
'    END AS GENDER_LABEL',
'FROM ',
'    employees',
'WHERE ',
'    USER_NAME = :APP_USER_NAME;'))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Gender'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'STATIC:Female;1,Male;2,Non-Specific;3'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
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
 p_id=>wwv_flow_imp.id(8175956848022804)
,p_name=>'P5_START_DATE'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'  CASE',
'    WHEN START_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN NULL',
'    ELSE TO_CHAR(START_DATE, ''DD/MM/YYYY'')',
'    -- ELSE START_DATE',
'  END',
'FROM EMPLOYEES',
'WHERE USER_NAME = :APP_USER_NAME;',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Start Date'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_read_only_when_type=>'ALWAYS'
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
 p_id=>wwv_flow_imp.id(8176052450022805)
,p_name=>'P5_TERMINATE_DATE'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- SELECT',
'--   CASE',
'--     WHEN TERMINATE_DATE = TO_DATE(''12/31/2154'', ''MM/DD/YYYY'') THEN ''Never''',
'--     ELSE TO_CHAR(TERMINATE_DATE, ''MM/DD/YYYY'')',
'--   END AS TERMINATE_DATE',
'-- FROM EMPLOYEES',
'-- WHERE USER_NAME = :APP_USER_NAME;',
'',
'-- SELECT',
'-- TERMINATE_DATE',
'-- FROM EMPLOYEES',
'-- WHERE USER_NAME = :APP_USER_NAME;',
'',
'SELECT',
'  CASE',
'    WHEN TERMINATE_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN null',
'    ELSE TO_CHAR(TERMINATE_DATE, ''DD/MM/YYYY'')',
'  END AS TERMINATE_DATE',
'FROM EMPLOYEES',
'WHERE USER_NAME = :APP_USER_NAME;',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Terminate Date'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_read_only_when_type=>'ALWAYS'
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
 p_id=>wwv_flow_imp.id(8176168962022806)
,p_name=>'P5_PHONE_NUMBER'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_item_default=>'select PHONE_NUMBER from employees where USER_NAME = :APP_USER_NAME'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Phone Number'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEL'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8176396979022808)
,p_name=>'P5_PERSONAL_EMAIL'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_item_default=>'select PERSONAL_EMAIL from employees where USER_NAME = :APP_USER_NAME'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Personal Email'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'EMAIL'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8176443621022809)
,p_name=>'P5_COMPANY_EMAIL'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_item_default=>'select USER_NAME from employees where USER_NAME = :APP_USER_NAME'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Company Email'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>6
,p_read_only_when_type=>'ALWAYS'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'EMAIL'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8176685473022811)
,p_name=>'P5_PER_PROVINCE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8176592605022810)
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:HCM;1'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'--- Select Province ---'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8176751727022812)
,p_name=>'P5_PER_DISTRICT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(8176592605022810)
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:1;1'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'--- Select District ---'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8176834298022813)
,p_name=>'P5_PER_WARD'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(8176592605022810)
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:1;1'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'--- Select Ward ---'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8176977015022814)
,p_name=>'P5_PER_DETAIL'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(8176592605022810)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PERSONAL_EMAIL from employees where PERSONAL_EMAIL = :APP_USER_NAME',
''))
,p_item_default_type=>'SQL_QUERY'
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
 p_id=>wwv_flow_imp.id(8177170704022816)
,p_name=>'P5_TEMP_PROVINCE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(8177005121022815)
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:HCM;1'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'--- Select Province ---'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8177223444022817)
,p_name=>'P5_TEMP_DISTRICT'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(8177005121022815)
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:1;1'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'--- Select District ---'
,p_cHeight=>1
,p_begin_on_new_line=>'N'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8177370745022818)
,p_name=>'P5_TEMP_WARD'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(8177005121022815)
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:1;1'
,p_lov_display_null=>'YES'
,p_lov_null_text=>'--- Select Ward ---'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8177482638022819)
,p_name=>'P5_TEMP_DETAIL'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(8177005121022815)
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
 p_id=>wwv_flow_imp.id(8177660721022821)
,p_name=>'P5_EME_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8177526385022820)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select EME_FULL_NAME from EMP_EMERGENCY_CONTACT EMP_EC where EMP_EC.EMPLOYEE_CODE = ',
'(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  )',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Full Name'
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
 p_id=>wwv_flow_imp.id(8177760307022822)
,p_name=>'P5_EME_RELATIONSHIP'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(8177526385022820)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select RELATION_SHIP from EMP_EMERGENCY_CONTACT EMP_EC where EMP_EC.EMPLOYEE_CODE = :APP_EMP_CODE',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Relationship'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT RELATIONSHIP_TYPE_DESCRIPTION, RELATIONSHIP_TYPE_ID AS ID',
'FROM EMP_RELATIONSHIP'))
,p_lov_display_null=>'YES'
,p_cSize=>30
,p_begin_on_new_line=>'N'
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
 p_id=>wwv_flow_imp.id(8177804988022823)
,p_name=>'P5_EME_PHONE_NUMBER'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(8177526385022820)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select EME_PHONE_NUMBER from EMP_EMERGENCY_CONTACT EMP_EC where EMP_EC.EMPLOYEE_CODE = ',
'(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  )',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Phone Number'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEL'
,p_attribute_05=>'BOTH'
);
end;
/
begin
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8178547060022830)
,p_name=>'P5_ID_PP_NUMBER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8178431762022829)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ID_NUMBER',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME ',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'ID number'
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
 p_id=>wwv_flow_imp.id(8178651284022831)
,p_name=>'P5_ISSUE_DATE_ID'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(8178431762022829)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'  CASE',
'    WHEN ISSUE_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN null',
'    ELSE TO_CHAR(ISSUE_DATE, ''DD/MM/YYYY'')',
'    --ELSE ISSUE_DATE',
'  END AS ISSUE_DATE',
'    -- ISSUE_DATE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME '))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Issue date of ID card '
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
 p_id=>wwv_flow_imp.id(8178892794022833)
,p_name=>'P5_WP_NUMBER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8178776054022832)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ID_NUMBER',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 2 AND e.EMPLOYEE_CODE = :APP_EMP_CODE ',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Work permit number'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(8178955248022834)
,p_name=>'P5_ISSUE_WP_DATE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(8178776054022832)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'    -- TO_CHAR(ISSUE_DATE, ''DD/MM/YYYY'')',
'    CASE',
'        WHEN emp_id.ISSUE_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN null',
'        ELSE TO_CHAR(emp_id.ISSUE_DATE, ''DD/MM/YYYY'')',
'    END AS ISSUE_DATE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 2 AND e.EMPLOYEE_CODE = :APP_EMP_CODE',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Issue date of work permit'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_read_only_when_type=>'ALWAYS'
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
 p_id=>wwv_flow_imp.id(8179134998022836)
,p_name=>'P5_SOC_INS_NUMBER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select SOC_INS_NUMBER from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = ',
'(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  )',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Social insurance number'
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
 p_id=>wwv_flow_imp.id(8179256256022837)
,p_name=>'P5_SOC_INS_PRI_HEAL'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PRI_HEAL_SERVICE from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = ',
'(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  )',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Primary healthcare service establishment (Health insurance card)'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT DESCRIPTION, HEALTH_INSU_FACILITY_CODE ',
'FROM HEALTH_INSURANCE_ESTABLISHMENT'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'---Select---'
,p_cHeight=>1
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8179401076022839)
,p_name=>'P5_PIT_NUMBER'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8179356274022838)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ID_NUMBER',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 3 AND e.USER_NAME = :APP_USER_NAME ',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'PIT Number'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(8179548958022840)
,p_name=>'P5_ISS_DATE_PIT_NUM'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(8179356274022838)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'  CASE',
'    WHEN ISSUE_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN null',
'    ELSE TO_CHAR(ISSUE_DATE, ''DD/MM/YYYY'')',
'  END AS ISSUE_DATE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 3 AND e.USER_NAME = :APP_USER_NAME ',
'',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Issue date of PIT'
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
 p_id=>wwv_flow_imp.id(8179896779022843)
,p_name=>'P5_BANK_ACC_NUM'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8179722526022842)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    eb.BANK_ACC_NUM',
'FROM',
'    EMP_BANK eb',
'INNER JOIN',
'    EMPLOYEES e ON eb.EMPLOYEE_CODE = e.EMPLOYEE_CODE',
'WHERE ',
'    e.USER_NAME = :APP_USER_NAME',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Bank Account Number'
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
 p_id=>wwv_flow_imp.id(8179943289022844)
,p_name=>'P5_BANK_NAME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(8179722526022842)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    eb.BANK_NAME',
'FROM',
'    EMP_BANK eb',
'INNER JOIN',
'    EMPLOYEES e ON eb.EMPLOYEE_CODE = e.EMPLOYEE_CODE',
'WHERE ',
'    e.USER_NAME = :APP_USER_NAME',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Bank Name'
,p_display_as=>'NATIVE_SELECT_LIST'
,p_lov=>'STATIC:Vietcom;VCB,BIDV;BIDV'
,p_cHeight=>1
,p_tag_css_classes=>'apex_disabled'
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'NONE'
,p_attribute_02=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8180082152022845)
,p_name=>'P5_BANK_BRANCH'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(8179722526022842)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'    eb.BANK_BRANCH',
'FROM',
'    EMP_BANK eb',
'INNER JOIN',
'    EMPLOYEES e ON eb.EMPLOYEE_CODE = e.EMPLOYEE_CODE',
'WHERE ',
'    e.USER_NAME = :APP_USER_NAME',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Bank Branch'
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
 p_id=>wwv_flow_imp.id(8180155176022846)
,p_name=>'P5_HIGHEST_LEVEL'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8179601555022841)
,p_item_default=>'SELECT DISCIPLINE_ID from EMP_EDUCATION where EMPLOYEE_CODE = :APP_EMP_CODE AND PRIMARY_EDUCATION = 1 and ROWNUM = 1'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Highest Academic Level'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_tag_css_classes=>'apex_disabled'
,p_colspan=>8
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
,p_attribute_02=>'N'
,p_attribute_04=>'TEXT'
,p_attribute_05=>'BOTH'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8180476224022849)
,p_name=>'P5_EXP_DATE_ID'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(8178431762022829)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT',
'  CASE',
'    WHEN EXPIRATION_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN null',
'    ELSE TO_CHAR(EXPIRATION_DATE, ''DD/MM/YYYY'')',
'  END AS EXPIRATION_DATE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME ',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Expiration date of ID card'
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
 p_id=>wwv_flow_imp.id(8180557214022850)
,p_name=>'P5_PLACE_DATE_ID'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(8178431762022829)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (SELECT LIA_NAME FROM LIST_ISSUING_AGENCY WHERE ISSUE_PLACE = LIA_ISSUING_AGENCY_ID ) ',
'-- SELECT ISSUE_PLACE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 0 AND e.EMPLOYEE_CODE = :APP_EMP_CODE',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Issue place of ID card'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'SELECT LIA_NAME, LIA_ISSUING_AGENCY_ID as ID FROM LIST_ISSUING_AGENCY'
,p_lov_display_null=>'YES'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(8235079384381401)
,p_name=>'P5_ID_NUM_ATTACH'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(8178431762022829)
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
,p_attribute_13=>'Upload file'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8235182841381402)
,p_name=>'P5_EXP_WP_DATE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(8178776054022832)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ',
'-- TO_CHAR(emp_id.EXPIRATION_DATE, ''DD/MM/YYYY'')',
'    CASE',
'        WHEN emp_id.EXPIRATION_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN null',
'        ELSE TO_CHAR(emp_id.EXPIRATION_DATE, ''DD/MM/YYYY'')',
'    END AS EXPIRATION_DATE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 2 AND e.EMPLOYEE_CODE = :APP_EMP_CODE',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Expiration date of work permit'
,p_format_mask=>'DD/MM/YYYY'
,p_display_as=>'NATIVE_DATE_PICKER_APEX'
,p_cSize=>30
,p_read_only_when_type=>'ALWAYS'
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
 p_id=>wwv_flow_imp.id(8235255015381403)
,p_name=>'P5_ISSUE_PLACE_WP'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(8178776054022832)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ISSUE_PLACE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 2 AND e.EMPLOYEE_CODE = :APP_EMP_CODE',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Issue place of work permit'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(8235314944381404)
,p_name=>'P5_SOC_INS_HOS_CODE'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select SOC_HOSPITAL_CODE from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = ',
'(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  )',
''))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8235424520381405)
,p_name=>'P5_SOC_INS_HOU_NAME'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select SOC_HOU_NAME from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = ',
'(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  )',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>unistr('Social insurance - Householder\2019s full name (On house hold registration book)')
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
 p_id=>wwv_flow_imp.id(8235541285381406)
,p_name=>'P5_SOC_INS_HOU_DOB'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ',
'    case ',
'        when SOC_HOU_DOB = to_date(''1/1/1900'', ''MM/DD/YYYY'') then null',
'        else TO_CHAR(SOC_HOU_DOB, ''DD/MM/YYYY'') ',
'    end as SOC_HOU_DOB',
'from EMP_SOCICAL_INSURANCE EMP_SI ',
'where EMP_SI.EMPLOYEE_CODE = ',
'(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME)'))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>unistr('Social insurance - Householder\2019s DOB')
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
 p_id=>wwv_flow_imp.id(8235686978381407)
,p_name=>'P5_SOC_INS_HOU_ID'
,p_item_sequence=>60
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select SOC_HOU_ID from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = ',
'(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  )',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>unistr('Social insurance - Householder\2019s ID number')
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
 p_id=>wwv_flow_imp.id(8235713746381408)
,p_name=>'P5_SOC_INS_RELATIONS'
,p_item_sequence=>70
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select SOC_RELATIONSHIP from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = ',
'(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  )',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Social insurance - Relationship between household and employee'
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
 p_id=>wwv_flow_imp.id(8235891482381409)
,p_name=>'P5_SOC_ATTACH'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
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
,p_attribute_13=>'Upload file'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(8921851694040303)
,p_name=>'P5_TITLE'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(8101712201268649)
,p_item_default=>'select TITLE from employees where USER_NAME = :APP_USER_NAME'
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Title'
,p_display_as=>'NATIVE_TEXT_FIELD'
,p_cSize=>30
,p_colspan=>6
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
 p_id=>wwv_flow_imp.id(8922999797040314)
,p_name=>'P5_PERMANENT_ADDRESS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8922551035040310)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select PERMANENT_ADDRESS from employees where USER_NAME = :APP_USER_NAME',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Permanent Address'
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
 p_id=>wwv_flow_imp.id(8923347948040318)
,p_name=>'P5_ID_PP_NUMBER_1'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8923261530040317)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ID_NUMBER',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME ',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Passport number'
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
 p_id=>wwv_flow_imp.id(8923491415040319)
,p_name=>'P5_ISSUE_DATE_ID_1'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(8923261530040317)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- SELECT ISSUE_DATE',
'-- FROM EMP_ID_NUMBER emp_id',
'-- INNER JOIN ',
'--     EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'-- WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME ',
'',
'SELECT',
'  CASE',
'    WHEN ISSUE_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN null',
'    ELSE TO_CHAR(ISSUE_DATE, ''DD/MM/YYYY'')',
'  END AS ISSUE_DATE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME ',
'',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Issue date of passport'
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
 p_id=>wwv_flow_imp.id(8923534619040320)
,p_name=>'P5_EXP_DATE_ID_1'
,p_item_sequence=>30
,p_item_plug_id=>wwv_flow_imp.id(8923261530040317)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- SELECT TO_CHAR(emp_id.EXPIRATION_DATE, ''DD/MM/YYYY'')',
'-- FROM EMP_ID_NUMBER emp_id',
'-- INNER JOIN ',
'--     EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'-- WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME',
'',
'SELECT',
'  CASE',
'    WHEN emp_id.EXPIRATION_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN null',
'    ELSE TO_CHAR(emp_id.EXPIRATION_DATE, ''DD/MM/YYYY'')',
'  END AS EXPIRATION_DATE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME ',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Expiration date of passport'
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
 p_id=>wwv_flow_imp.id(8923689806040321)
,p_name=>'P5_PLACE_DATE_ID_1'
,p_item_sequence=>40
,p_item_plug_id=>wwv_flow_imp.id(8923261530040317)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT (SELECT LIA_NAME FROM LIST_ISSUING_AGENCY WHERE ISSUE_PLACE = LIA_ISSUING_AGENCY_ID )',
'-- SELECT ISSUE_PLACE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME ',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Issue place of passport'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>'SELECT LIA_NAME, LIA_ISSUING_AGENCY_ID as ID FROM LIST_ISSUING_AGENCY'
,p_lov_display_null=>'YES'
,p_cSize=>30
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
 p_id=>wwv_flow_imp.id(8923716851040322)
,p_name=>'P5_ID_NUM_ATTACH_1'
,p_item_sequence=>50
,p_item_plug_id=>wwv_flow_imp.id(8923261530040317)
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
,p_attribute_13=>'Upload file'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(9260094351015807)
,p_name=>'P5_TEMP_ADDRESS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8176592605022810)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select TEMPORARY_ADDRESS from employees where USER_NAME = :APP_USER_NAME',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Temporary Address'
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
 p_id=>wwv_flow_imp.id(10004749533336813)
,p_name=>'P5_URL'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(8178431762022829)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10005304110336819)
,p_name=>'P5_URL_NAME'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(8178431762022829)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10575308937987801)
,p_name=>'P5_DEFAULT_IMAGES_NAME'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(8178431762022829)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ATTACH_NAME',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME ',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10575476013987802)
,p_name=>'P5_DEFAULT_IMAGES_URL'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(8178431762022829)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ATTACH_FILE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME',
'',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10577559529987823)
,p_name=>'P5_URL_1'
,p_item_sequence=>80
,p_item_plug_id=>wwv_flow_imp.id(8923261530040317)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10577683398987824)
,p_name=>'P5_URL_NAME_1'
,p_item_sequence=>90
,p_item_plug_id=>wwv_flow_imp.id(8923261530040317)
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10577725328987825)
,p_name=>'P5_DEFAULT_IMAGES_NAME_1'
,p_item_sequence=>100
,p_item_plug_id=>wwv_flow_imp.id(8923261530040317)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ATTACH_NAME',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME ',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10577804482987826)
,p_name=>'P5_DEFAULT_IMAGES_URL_1'
,p_item_sequence=>110
,p_item_plug_id=>wwv_flow_imp.id(8923261530040317)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT ATTACH_FILE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME',
'',
'',
''))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10578052565987828)
,p_name=>'P5_URL_SS'
,p_item_sequence=>120
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10578177438987829)
,p_name=>'P5_URL_NAME_SS'
,p_item_sequence=>130
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10578282954987830)
,p_name=>'P5_DEFAULT_IMAGES_NAME_SS'
,p_item_sequence=>140
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select ATTACH_NAME from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = :APP_EMP_CODE',
''))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(10578381263987831)
,p_name=>'P5_DEFAULT_IMAGES_URL_SS'
,p_item_sequence=>150
,p_item_plug_id=>wwv_flow_imp.id(8179033279022835)
,p_item_default=>'select ATTACH_FILE from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = :APP_EMP_CODE'
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(19866660763766449)
,p_name=>'P5_SEND_MAIL_MODE'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(8174482272996537)
,p_item_default=>'1'
,p_display_as=>'NATIVE_HIDDEN'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(20143079189893606)
,p_name=>'P5_TEMPORARY_ADDRESS'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(9259903859015806)
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'select TEMPORARY_ADDRESS from employees where USER_NAME = :APP_USER_NAME',
''))
,p_item_default_type=>'SQL_QUERY'
,p_pre_element_text=>'Temporary Address'
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
 p_id=>wwv_flow_imp.id(22745978228164438)
,p_name=>'P5_EMP_CURRENT_EDUCATION'
,p_item_sequence=>20
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT JSON_ARRAYAGG(',
'    JSON_OBJECT(',
'        ''id'' VALUE ID,',
'        ''employee_id'' VALUE EMPLOYEE_ID,',
'        ''type'' VALUE TYPE,',
'        ''level_of_edu'' VALUE LEVEL_OF_EDU,',
'        ''major'' VALUE MAJOR,',
'        ''place'' VALUE PLACE,',
'        ''graduated_date'' VALUE GRADUATED_DATE,',
'        ''attach_file'' VALUE ATTACH_FILE,',
'        ''is_del'' VALUE IS_DEL,',
'        ''expiration_date'' VALUE EXPIRATION_DATE,',
'        ''effective_date'' VALUE EFFECTIVE_DATE,',
'        ''certificate_name'' VALUE CERTIFICATE_NAME,',
'        ''employee_code'' VALUE EMPLOYEE_CODE,',
'        ''primary_education'' VALUE PRIMARY_EDUCATION,',
'        ''attach_name'' VALUE ATTACH_NAME,',
'        ''rec_id'' VALUE REC_ID,',
'        ''discipline_id'' VALUE DISCIPLINE_ID,',
'        ''institution_id'' VALUE INSTITUTION_ID,',
'        ''attach_url'' VALUE ATTACH_URL',
'    )',
') as json_data',
'FROM EMP_EDUCATION',
'WHERE EMPLOYEE_CODE = :APP_EMP_CODE'))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
end;
/
begin
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(23026570615956601)
,p_name=>'P5_OLD_ID'
,p_item_sequence=>40
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
unistr('    -- bi\1EBFn \0111\1EC3 ki\1EC3m tra \0111o\1EA1n json'),
'    o_id number;',
'    l_numrows number;',
'    o_certificate_type nvarchar2(1000);',
'    temp date;',
'begin',
'    APEX_JSON.PARSE(:P5_EMP_CURRENT_CERTIFICATES);',
'',
'    l_numrows := APEX_JSON.GET_COUNT(p_path => ''.'');',
'',
'    if l_numrows > 0 then',
'        for i in 1..l_numrows loop',
'            -- temp := to_date(APEX_JSON.get_varchar2(p_path => ''[%d].graduated_date'', p0 => i), ''YYYY-MM-DD"T"HH24:MI:SS'');',
'            -- old_graduated_date := to_char(temp, ''DD/MM/YYYY'');',
'            --TO_CHAR(TO_DATE(apex_json.get_varchar2(''[%d].BirthDate'', i), ''YYYY-MM-DD"T"HH24:MI:SS''), ''MM/DD/YYYY'')',
'            -- n_date := TO_DATE(l_json_values(''graduated_date'').get_varchar2, ''YYYY-MM-DD"T"HH24:MI:SS'');',
'        ',
unistr('            -- -- In ng\00E0y v\1EDBi \0111\1ECBnh d\1EA1ng ''MM/DD/YYYY'''),
'            -- DBMS_OUTPUT.put_line(''Converted Date: '' || TO_CHAR(n_date, ''MM/DD/YYYY''));',
'            o_id := to_number(APEX_JSON.get_varchar2(p_path => ''[%d].id'', p0 => i));',
'            -- o_certificate_type := APEX_JSON.get_varchar2(p_path => ''[%d].certificate_type'', p0 => i);',
'            -- temp := to_date(APEX_JSON.get_varchar2(p_path => ''[%d].start_date'', p0 => i), ''YYYY-MM-DD"T"HH24:MI:SS'');',
'            -- o_certificate_type := to_char(temp, ''DD/MM/YYYY'');',
'            -- o_certificate_type := APEX_JSON.get_varchar2(p_path => ''[%d].short_note'', p0 => i);',
'            o_certificate_type := APEX_JSON.get_varchar2(p_path => ''[%d].attachment_url'', p0 => i);',
'        end loop;',
'    end if;',
'    return o_certificate_type;',
'end;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(23026669264956602)
,p_name=>'P5_NEW_ID'
,p_item_sequence=>50
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
unistr('    -- bi\1EBFn \0111\1EC3 ki\1EC3m tra \0111o\1EA1n json'),
'    emp_education_id number;',
'    l_numrows number;',
'    new_string apex_t_number;',
'    temp2 date;',
'begin',
'    -- APEX_JSON.PARSE(:P5_EMP_CURRENT_EDUCATION);',
unistr('    -- -- bi\1EBFn \0111\1EBFm s\1ED1 object c\1EE7a json'),
'    -- l_numrows := APEX_JSON.GET_COUNT(p_path => ''.'');',
'',
'    -- if l_numrows > 0 then',
'    --     for i in 1..l_numrows loop',
'    --         emp_education_id := to_number(APEX_JSON.get_varchar2(p_path => ''[%d].id'', p0 => i));',
'    --     end loop;',
'    -- end if;',
'    new_string := apex_t_number();',
'    for rec in (select cer.id ',
'                from EMP_CERTIFICATE cer',
'                INNER JOIN ',
'                EMPLOYEES e ON cer.EMPLOYEE_CODE = e.EMPLOYEE_CODE',
'                WHERE e.USER_NAME = :APP_USER_NAME) loop',
'        new_string.extend();',
'        new_string(new_string.COUNT) := rec.id;',
'    end loop;',
'',
'    --return new_string(1);',
'end;'))
,p_item_default_type=>'FUNCTION_BODY'
,p_item_default_language=>'PLSQL'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'Y'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(23026705244956603)
,p_name=>'P5_EMP_CURRENT_CERTIFICATES'
,p_item_sequence=>30
,p_item_default=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT JSON_ARRAYAGG(',
'    JSON_OBJECT(',
'        ''id'' VALUE ID,',
'        ''employee_id'' VALUE EMPLOYEE_ID,',
'        ''certificate_description'' VALUE CERTIFICATE_DESCRIPTION,',
'        ''end_date'' VALUE END_DATE,',
'        ''start_date'' VALUE START_DATE,',
'        ''short_note'' VALUE SHORT_NOTE,',
'        ''certificate_type'' VALUE CERTIFICATE_TYPE,',
'        ''employee_code'' VALUE EMPLOYEE_CODE,',
'        ''is_del'' VALUE IS_DEL,',
'        ''attachment'' VALUE ATTACHMENT,',
'        ''rec_id'' VALUE REC_ID,',
'        ''attachment_url'' VALUE ATTACHMENT_URL,',
'        ''attachment_name'' VALUE ATTACHMENT_NAME',
'    )',
') as json_data',
'FROM EMP_CERTIFICATE',
'WHERE EMPLOYEE_CODE = :APP_EMP_CODE'))
,p_item_default_type=>'SQL_QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(25414398025379003)
,p_validation_name=>'check_P5_PHONE_NUMBER'
,p_validation_sequence=>10
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' return is_valid_phone_number(:P5_PHONE_NUMBER);',
'end;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please enter a valid phone number!'
,p_when_button_pressed=>wwv_flow_imp.id(8178056811022825)
,p_associated_item=>wwv_flow_imp.id(8176168962022806)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(25414459727379004)
,p_validation_name=>'check_P5_EME_PHONE_NUMBER'
,p_validation_sequence=>20
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' return is_valid_phone_number(:P5_EME_PHONE_NUMBER);',
'end;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please enter a valid phone number!'
,p_when_button_pressed=>wwv_flow_imp.id(8178056811022825)
,p_associated_item=>wwv_flow_imp.id(8177804988022823)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(25414692757379006)
,p_validation_name=>'check_P5_ID_PP_NUMBER'
,p_validation_sequence=>30
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' return is_numeric(:P5_ID_PP_NUMBER);',
'end;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please enter a valid number!'
,p_when_button_pressed=>wwv_flow_imp.id(8180297924022847)
,p_associated_item=>wwv_flow_imp.id(8178547060022830)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(25414770758379007)
,p_validation_name=>'check_P5_ID_PP_NUMBER_1_PASSPORT'
,p_validation_sequence=>40
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' return is_numeric(:P5_ID_PP_NUMBER_1);',
'end;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please enter a valid number!'
,p_when_button_pressed=>wwv_flow_imp.id(8923872414040323)
,p_associated_item=>wwv_flow_imp.id(8923347948040318)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(25414954982379009)
,p_validation_name=>'check_P5_SOC_INS_NUMBER'
,p_validation_sequence=>50
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' return is_numeric(:P5_SOC_INS_NUMBER);',
'end;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please enter a valid number!'
,p_when_button_pressed=>wwv_flow_imp.id(8235933053381410)
,p_associated_item=>wwv_flow_imp.id(8179134998022836)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(25414893786379008)
,p_validation_name=>'check_P5_SOC_INS_HOU_ID'
,p_validation_sequence=>60
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' return is_numeric(:P5_SOC_INS_HOU_ID);',
'end;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please enter a valid number!'
,p_when_button_pressed=>wwv_flow_imp.id(8235933053381410)
,p_associated_item=>wwv_flow_imp.id(8235686978381407)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_validation(
 p_id=>wwv_flow_imp.id(25415014584379010)
,p_validation_name=>'check_P5_BANK_ACC_NUM'
,p_validation_sequence=>70
,p_validation=>wwv_flow_string.join(wwv_flow_t_varchar2(
'begin',
' return is_numeric(:P5_BANK_ACC_NUM);',
'end;'))
,p_validation2=>'PLSQL'
,p_validation_type=>'FUNC_BODY_RETURNING_BOOLEAN'
,p_error_message=>'Please enter a valid number!'
,p_when_button_pressed=>wwv_flow_imp.id(8236352292381414)
,p_associated_item=>wwv_flow_imp.id(8179896779022843)
,p_error_display_location=>'INLINE_WITH_FIELD_AND_NOTIFICATION'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(9768306679102042)
,p_name=>'Reload'
,p_event_sequence=>10
,p_triggering_element_type=>'JAVASCRIPT_EXPRESSION'
,p_triggering_element=>'window'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'apexafterclosedialog'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(9768484011102043)
,p_event_id=>wwv_flow_imp.id(9768306679102042)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_action=>'NATIVE_REFRESH'
,p_affected_elements_type=>'JAVASCRIPT_EXPRESSION'
,p_affected_elements=>'location.reload();'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(24420876271440480)
,p_name=>'auto_close_noti'
,p_event_sequence=>30
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'ready'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(24421702961440487)
,p_event_id=>wwv_flow_imp.id(24420876271440480)
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
 p_id=>wwv_flow_imp.id(24421249946440487)
,p_event_id=>wwv_flow_imp.id(24420876271440480)
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
 p_id=>wwv_flow_imp.id(23665638974578133)
,p_name=>'Row Init'
,p_event_sequence=>40
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(8236520445381416)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|apexbeginrecordedit'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(23665991339578136)
,p_event_id=>wwv_flow_imp.id(23665638974578133)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'Set edu_temp_id'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(8236520445381416)
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// Get the model and record data from the Interactive Grid',
'var model = this.data.model,',
'    rec = this.data.record,',
'    meta = model.getRecordMetadata(this.data.recordId);',
'',
'// Check if the record has been newly inserted',
'if (meta.inserted) {',
'    apex.server.process(''GET_NEXT_EDU_TEMP_ID_SEQ'', {',
'        // x01 could be used to pass any additional data if needed',
'    }, {',
'        success: function(data) {',
'            // Assuming the server returns the next sequence value in the ''nextSeqValue'' attribute',
'            var seqValue = data.nextSeqValue;',
'',
'            // Set the TEMP_ID column value using the sequence value obtained from the server',
'            model.setValue(rec, "TEMP_ID", seqValue.toString());',
'',
'            var employee_code = rec[model.getFieldKey(''EMPLOYEE_CODE'')];',
'            var emp_education_id = rec[model.getFieldKey(''EMP_EDUCATION_ID'')];',
'            var TEMP_ID = rec[model.getFieldKey(''TEMP_ID'')];',
'',
'            console.log(''employee_code: '' + employee_code);',
'            console.log(''emp_education_id: '' + emp_education_id);',
'            console.log(''TEMP_ID: '' + TEMP_ID);',
'',
'            // After setting TEMP_ID, find the link in the current row and update it',
'            var linkSelector = ''a.edu-upload-link'';',
'            var currentRowSelector = ''#education-box .a-GV-row.is-selected.is-inserted '' + linkSelector;',
'            var $linkInCurrentRow = jQuery(currentRowSelector);',
'            $linkInCurrentRow.attr(''data-tempid'', seqValue);',
'',
'            // Issue: When set value of the TEMP_ID column using model.setValue, the record do not save value of the TEMP_ID column when inserted (new record)',
'            // Workaround: Set value of the TEMP_ID column using jQuery',
'            // jQuery(''#education-box .a-GV-row.is-selected.is-inserted .a-GV-cell[data-header="TEMP_ID"]'').text(seqValue);',
'            ',
'        },',
'        error: function(jqXHR, textStatus, errorThrown) {',
'            // Handle any errors',
'            apex.debug.error(''Error fetching next sequence value:'', errorThrown);',
'        }',
'    });',
'}'))
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(24802020994944240)
,p_name=>'IG Certificate - Row init'
,p_event_sequence=>50
,p_triggering_element_type=>'REGION'
,p_triggering_region_id=>wwv_flow_imp.id(8237984547381430)
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'NATIVE_IG|REGION TYPE|apexbeginrecordedit'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(24802219840944242)
,p_event_id=>wwv_flow_imp.id(24802020994944240)
,p_event_result=>'TRUE'
,p_action_sequence=>20
,p_execute_on_page_init=>'N'
,p_name=>'Set Certiciate''s TEMP_ID'
,p_action=>'NATIVE_JAVASCRIPT_CODE'
,p_affected_elements_type=>'REGION'
,p_affected_region_id=>wwv_flow_imp.id(8236520445381416)
,p_attribute_01=>wwv_flow_string.join(wwv_flow_t_varchar2(
'// Get the model and record data from the Interactive Grid',
'var model = this.data.model,',
'    rec = this.data.record,',
'    meta = model.getRecordMetadata(this.data.recordId);',
'',
'// Check if the record has been newly inserted',
'if (meta.inserted) {',
'    apex.server.process(''GET_NEXT_CERT_TEMP_ID_SEQ'', {',
'        // x01 could be used to pass any additional data if needed',
'    }, {',
'        success: function(data) {',
'            // Assuming the server returns the next sequence value in the ''nextSeqValue'' attribute',
'            var seqValue = data.nextSeqValue;',
'',
'            // Set the TEMP_ID column value using the sequence value obtained from the server',
'            model.setValue(rec, "TEMP_ID", seqValue.toString());',
'',
'            // After setting TEMP_ID, find the link in the current row and update it',
'            var linkSelector = ''a.cert-upload-link'';',
'            var currentRowSelector = ''#certificate-box .a-GV-row.is-selected.is-inserted '' + linkSelector;',
'            var $linkInCurrentRow = jQuery(currentRowSelector);',
'            $linkInCurrentRow.attr(''data-tempid'', seqValue);',
'',
'            // Issue: When set value of the TEMP_ID column using model.setValue, the record do not save value of the TEMP_ID column when inserted (new record)',
'            // Workaround: Set value of the TEMP_ID column using jQuery',
'            // jQuery(''#education-box .a-GV-row.is-selected.is-inserted .a-GV-cell[data-header="TEMP_ID"]'').text(seqValue);',
'            ',
'        },',
'        error: function(jqXHR, textStatus, errorThrown) {',
'            // Handle any errors',
'            apex.debug.error(''Error fetching next sequence value:'', errorThrown);',
'        }',
'    });',
'}'))
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9767781793102036)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(8236520445381416)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'EMP_EDUCATION - Save Interactive Grid Data'
,p_attribute_01=>'TABLE'
,p_attribute_03=>'EMP_EDUCATION'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'N'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8239352126381444)
,p_only_for_changed_rows=>'N'
,p_process_success_message=>'Saved'
,p_internal_uid=>9767781793102036
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9768011389102039)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_region_id=>wwv_flow_imp.id(8237984547381430)
,p_process_type=>'NATIVE_IG_DML'
,p_process_name=>'Other certificates - Save Interactive Grid Data'
,p_attribute_01=>'TABLE'
,p_attribute_03=>'EMP_CERTIFICATE'
,p_attribute_05=>'Y'
,p_attribute_06=>'Y'
,p_attribute_08=>'Y'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8239352126381444)
,p_process_success_message=>'Created'
,p_internal_uid=>9768011389102039
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9143883679317039)
,p_process_sequence=>30
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send email change info tab personal'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_body clob:='''';',
'    is_changed boolean := false;',
'    relationship_old nvarchar2(200);',
'    relationship_new nvarchar2(200);',
'begin',
'-- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\1EC0 XU\1EA4T THAY \0110\1ED4I TH\00D4NG TIN C\00C1 NH\00C2N</h3>'';'),
unistr('v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 PERSONAL INFORMATION UPDATE LETTERS</h3>'';'),
unistr('v_body := v_body||''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''||:P5_FULL_NAME||'' th\00E2n m\1EBFn,</p>'';'),
'v_body := v_body||''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''||:P5_FULL_NAME||'',</p>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB c\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin c\00E1 nh\00E2n c\1EE7a nh\00E2n vi\00EAn sau:</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Employee Portal system has received a Personal information update request as below:</p>'';',
'v_body := v_body||''<ul>'';',
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn/ Full name:</strong> ''||:P5_FULL_NAME||''</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn/ Employee Code:</strong> ''||:P5_EMPLOYEE_CODE||''</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- Ch\1EE9c danh/ Title:</strong> ''||:P5_TITLE||''</p>'';'),
'v_body := v_body||''</ul>'';',
'v_body := v_body||''<table style=''''border-collapse: collapse;border: 1px solid black;''''>'';',
'v_body := v_body||''<tr>'';',
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>C\00C1 NH\00C2N</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>PERSONAL</i></p></th>'';'),
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\00C3 \0110\0102NG K\00DD</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>CURRENT PERSONAL INFORMATION</i></')
||'p></th>'';',
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\1EC0 NGH\1ECA THAY \0110\1ED4I</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>PERSONAL INFORMATION UPDATE<')
||'/i></p></th>'';',
'v_body := v_body||''</tr>'';',
'',
'FOR rec IN (',
'    SELECT ',
'        --e.*, ',
'        e.PHONE_NUMBER,',
'        e.PERSONAL_EMAIL,',
'        e.PERMANENT_ADDRESS,',
'        e.TEMPORARY_ADDRESS,',
'        emc.RELATION_SHIP, ',
'        emc.EME_FULL_NAME AS emc_name,',
'        emc.EME_PHONE_NUMBER AS emc_phone',
'    FROM EMPLOYEES e',
'    JOIN EMP_EMERGENCY_CONTACT emc ON e.EMPLOYEE_CODE = emc.EMPLOYEE_CODE',
'    WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE',
')',
'LOOP',
'',
'    -- Query relationship value',
'    SELECT NVL(MAX(RELATIONSHIP_TYPE_DESCRIPTION), '' '') ',
'    INTO relationship_old',
'    FROM EMP_RELATIONSHIP ',
'    WHERE rec.RELATION_SHIP = RELATIONSHIP_TYPE_ID;',
'',
'    select NVL(MAX(RELATIONSHIP_TYPE_DESCRIPTION), '' '') into relationship_new ',
'    from EMP_RELATIONSHIP where :P5_EME_RELATIONSHIP = RELATIONSHIP_TYPE_ID;',
'',
'    IF nvl(rec.PHONE_NUMBER,''$'') <> nvl(:P5_PHONE_NUMBER,''$'')',
'    OR nvl(rec.PERSONAL_EMAIL,''$'') <> nvl(:P5_PERSONAL_EMAIL ,''$'')',
'    OR nvl(rec.PERMANENT_ADDRESS,''$'') <> nvl(:P5_PERMANENT_ADDRESS ,''$'')  ',
'    OR nvl(rec.TEMPORARY_ADDRESS,''$'') <> nvl(:P5_TEMPORARY_ADDRESS ,''$'')  ',
'    THEN',
unistr('        v_body := v_body||''<tr style=''''border: 1px solid black;border-bottom:none;''''><td style=''''padding:0 10px; border-left: 1px solid black;''''><p style=''''color:black;margin:0;font-weight:700''''>Th\00F4ng tin c\00E1 nh\00E2n</p><p style=''''color:black;margin:0;fo')
||'nt-style:italic;margin-bottom:10px''''>Personal information</p></td><td style=''''padding:0 10px; border-left: 1px solid black;''''></td><td style=''''padding:0 10px; border-left: 1px solid black''''></td></tr>'';',
'    END IF;',
'',
'    IF nvl(rec.PHONE_NUMBER,''$'') <> nvl(:P5_PHONE_NUMBER,''$'') ',
'    THEN',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>S\1ED1 \0111i\1EC7n tho\1EA1i / Phone number</td><td style=''''padding:0 10px; border-right: 1px solid bla')
||'ck;''''>''|| rec.PHONE_NUMBER ||''</td><td style=''''padding:0 10px;''''>''|| :P5_PHONE_NUMBER ||''</td></tr>'';',
'        is_changed := true;',
'    END IF;',
'    ',
'    IF nvl(rec.PERSONAL_EMAIL,''$'') <> nvl(:P5_PERSONAL_EMAIL ,''$'')',
'    THEN',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''> Email c\00E1 nh\00E2n / Personal email </td><td style=''''padding:0 10px; border-right: 1px solid')
||' black;''''>''|| rec.PERSONAL_EMAIL ||''</td><td style=''''padding:0 10px;''''>''|| :P5_PERSONAL_EMAIL ||''</td></tr>'';',
'        is_changed := true; ',
'    END IF;',
'    ',
'    IF nvl(rec.PERMANENT_ADDRESS,''$'') <> nvl(:P5_PERMANENT_ADDRESS ,''$'')  ',
'    THEN',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>\0110\1ECBa ch\1EC9 th\01B0\1EDDng tr\00FA / Permanent address</td><td style=''''padding:0 10px; border-right: 1px')
||' solid black;''''>''|| rec.PERMANENT_ADDRESS ||''</td><td style=''''padding:0 10px;''''>''|| :P5_PERMANENT_ADDRESS ||''</td></tr>'';',
'        is_changed := true;',
'    END IF;',
'    ',
'    IF nvl(rec.TEMPORARY_ADDRESS,''$'') <> nvl(:P5_TEMPORARY_ADDRESS ,''$'')',
'    THEN',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;border-bottom: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>\0110\1ECBa ch\1EC9 t\1EA1m tr\00FA / Temporary residence address</td><td sty')
||'le=''''padding:0 10px; border-right: 1px solid black;''''>''|| rec.TEMPORARY_ADDRESS ||''</td><td style=''''padding:0 10px;''''>''|| :P5_TEMPORARY_ADDRESS ||''</td></tr>'';',
'        is_changed := true;',
'    END IF;   ',
'',
'    IF nvl(rec.emc_name,''$'') <> nvl(:P5_EME_NAME ,''$'')',
'    OR nvl(rec.emc_phone,''$'') <> nvl(:P5_EME_PHONE_NUMBER ,''$'')',
'    OR nvl(rec.RELATION_SHIP,''$'') <> nvl(:P5_EME_RELATIONSHIP ,''$'')',
'    THEN',
unistr('        v_body := v_body||''<tr style=''''border: 1px solid black;border-bottom: none;''''><td style=''''padding:0 10px; border-left: 1px solid black;''''><p style=''''color:black;margin-top:20px;margin-bottom:0;font-weight:700''''>Th\00F4ng tin ng\01B0\1EDDi li\00EAn h\1EC7 kh\1EA9n c\1EA5')
||'p</p><p style=''''color:black;margin:0;font-style:italic;margin-bottom:10px''''>Person of emergency contact information</p></td><td style=''''padding:0 10px; border-left: 1px solid black;''''></td><td style=''''padding:0 10px; border-left: 1px solid black;''''><'
||'/td></tr>'';',
'    END IF;',
'    ',
'    IF nvl(rec.emc_name,''$'') <> nvl(:P5_EME_NAME ,''$'')',
'    THEN',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>H\1ECD v\00E0 t\00EAn / Full name </td><td style=''''padding:0 10px; border-right: 1px solid black;''''>')
||'''|| rec.emc_name ||''</td><td style=''''padding:0 10px;''''>''|| :P5_EME_NAME ||''</td></tr>'';',
'        is_changed := true;',
'    END IF;    ',
'',
'    IF nvl(rec.emc_phone,''$'') <> nvl(:P5_EME_PHONE_NUMBER ,''$'')',
'    THEN',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;border-top: none;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>S\1ED1 \0111i\1EC7n tho\1EA1i / Phone number</td><td style=''''padding:0 10px; border-rig')
||'ht: 1px solid black;''''>''|| rec.emc_phone ||''</td><td style=''''padding:0 10px;''''>''|| :P5_EME_PHONE_NUMBER ||''</td></tr>'';',
'        is_changed := true;',
'    END IF;   ',
'',
'    IF nvl(rec.RELATION_SHIP,''$'') <> nvl(:P5_EME_RELATIONSHIP ,''$'')',
'    THEN',
unistr('        -- v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;border-top: none;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>M\1ED1i quan h\1EC7 / Relationship</td><td style=''''padding:0 10px; border-ri')
||'ght: 1px solid black;''''>''|| rec.RELATION_SHIP ||''</td><td style=''''padding:0 10px;''''>''|| :P5_EME_RELATIONSHIP ||''</td></tr>'';',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;border-top: none;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>M\1ED1i quan h\1EC7 / Relationship</td><td style=''''padding:0 10px; border-right')
||': 1px solid black;''''>''|| relationship_old ||''</td><td style=''''padding:0 10px;''''>''|| relationship_new ||''</td></tr>'';',
'        is_changed := true;',
'    END IF;    ',
'END LOOP;',
'',
'v_body := v_body||''</table>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>Anh/Ch\1ECB vui l\00F2ng click t\1EA1i \0111\00E2y \0111\1EC3 ki\1EC3m tra th\00F4ng tin v\00E0 x\00E1c nh\1EADn c\1EADp nh\1EADt v\00E0o h\1EC7 th\1ED1ng D365 HRM.</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Please click Link to review and update information to D365 HRM System.</p>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Best regards,</p>'';',
'v_body := v_body||''<p style=''''color:black''''>HR & Admin Department </p>'';',
'-- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
'',
'-- Update [EMPLOYEES]',
'UPDATE EMPLOYEES',
'SET',
'    PHONE_NUMBER = :P5_PHONE_NUMBER,',
'    PERSONAL_EMAIL = :P5_PERSONAL_EMAIL,',
'    PERMANENT_ADDRESS = :P5_PERMANENT_ADDRESS,',
'    TEMPORARY_ADDRESS = :P5_TEMPORARY_ADDRESS',
'WHERE EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
'UPDATE EMP_EMERGENCY_CONTACT',
'SET',
'    EME_FULL_NAME = :P5_EME_NAME,',
'    EME_PHONE_NUMBER = :P5_EME_PHONE_NUMBER,',
'    RELATION_SHIP = :P5_EME_RELATIONSHIP',
'WHERE EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
'    if is_changed then',
'    -- Send to HRs (for pilot)',
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''phuongpham@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''trang.th@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''hravus@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''haitran@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- send tester',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''huyen.ptt@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thudang@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thi.tnh@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ngan.tranvu@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- Send to Devs',
unistr('        -- SP_SENDGRID_EMAIL(''ky.nguyenquoc@vus-etsc.edu.vn'', ''quocky600@gmail.com'', ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin NV ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ky.nguyenquoc@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''quocky600@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''tranquangkhanh2k1qv@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''khanhnguyendev@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'    end if;',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8178056811022825)
,p_process_success_message=>'Successfully submitted. HR-Admin department will check and update your information within 3-5 working days!'
,p_internal_uid=>9143883679317039
);
end;
/
begin
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9406695911131410)
,p_process_sequence=>40
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send email change info tab bank'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_body clob:='''';',
'    is_changed boolean := false;',
'begin',
'',
'-- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\1EC0 XU\1EA4T THAY \0110\1ED4I TH\00D4NG TIN C\00C1 NH\00C2N</h3>'';'),
unistr('v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 PERSONAL INFORMATION UPDATE LETTERS</h3>'';'),
unistr('v_body := v_body||''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''||:P5_FULL_NAME||'' th\00E2n m\1EBFn,</p>'';'),
'v_body := v_body||''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''||:P5_FULL_NAME||'',</p>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB c\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin c\00E1 nh\00E2n c\1EE7a nh\00E2n vi\00EAn sau:</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Employee Portal system has received a Personal information update request as below:</p>'';',
'v_body := v_body||''<ul>'';',
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn/ Full name:</strong> ''||:P5_FULL_NAME||''</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn/ Employee Code:</strong> ''||:P5_EMPLOYEE_CODE||''</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- Ch\1EE9c danh/ Title:</strong> ''||:P5_TITLE||''</p>'';'),
'v_body := v_body||''</ul>'';',
'v_body := v_body||''<table style=''''border-collapse: collapse;border: 1px solid black;''''>'';',
'v_body := v_body||''<tr>'';',
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>T\00C0I KHO\1EA2N NG\00C2N H\00C0NG</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>BANK ACCOUNT</i></p></th>'';'),
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\00C3 \0110\0102NG K\00DD</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>CURRENT PERSONAL INFORMATION</i></')
||'p></th>'';',
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\1EC0 NGH\1ECA THAY \0110\1ED4I</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>PERSONAL INFORMATION UPDATE<')
||'/i></p></th>'';',
'v_body := v_body||''</tr>'';',
unistr('v_body := v_body||''<tr style=''''border: 1px solid black;border-bottom: none;''''><td style=''''padding:0 10px; border-left: 1px solid black;''''><p style=''''color:black;margin:0;font-weight:700''''>Th\00F4ng tin s\1ED1 t\00E0i kho\1EA3n ng\00E2n h\00E0ng</p><p style=''''color:black;mar')
||'gin:0;font-style:italic;margin-bottom:10px''''>Bank account</p></td><td style=''''padding:0 10px; border-left: 1px solid black;''''></td><td style=''''padding:0 10px; border-left: 1px solid black''''></td></tr>'';',
'FOR rec IN (',
'    SELECT e.*',
'    FROM EMP_BANK e',
'    WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE',
')',
'LOOP',
'    -- IF nvl(rec.BANK_ACC_NUM, ''$'') <> nvl(:P5_BANK_ACC_NUM, ''$'')',
'    -- OR nvl(rec.BANK_BRANCH, ''$'') <> nvl(:P5_BANK_BRANCH, ''$'')',
'    -- THEN',
unistr('    --     v_body := v_body||''<tr style=''''border: 1px solid black;border-bottom: none;''''><td style=''''padding:0 10px; border-left: 1px solid black;''''><p style=''''color:black;margin:0;font-weight:700''''>Th\00F4ng tin s\1ED1 t\00E0i kho\1EA3n ng\00E2n h\00E0ng</p><p style=''''colo')
||'r:black;margin:0;font-style:italic;margin-bottom:10px''''>Bank account</p></td><td style=''''padding:0 10px; border-left: 1px solid black;''''></td><td style=''''padding:0 10px; border-left: 1px solid black''''></td></tr>'';',
'    -- END IF;',
'',
'    -- IF rec.BANK_ACC_NUM <> :P5_BANK_ACC_NUM OR (rec.BANK_ACC_NUM IS NULL AND :P5_BANK_ACC_NUM IS NOT NULL) OR (rec.BANK_ACC_NUM IS NOT NULL AND :P5_BANK_ACC_NUM IS NULL) THEN',
'    IF nvl(rec.BANK_ACC_NUM, ''$'') <> nvl(:P5_BANK_ACC_NUM, ''$'') THEN',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Bank account number / S\1ED1 t\00E0i kho\1EA3n ng\00E2n h\00E0ng</td><td style=''''padding:0 10px; border-righ')
||'t: 1px solid black;''''>''|| rec.BANK_ACC_NUM ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| :P5_BANK_ACC_NUM ||''</td></tr>'';',
'        is_changed := true;',
'    END IF;',
'    ',
'    -- IF rec.BANK_NAME <> :P5_BANK_NAME OR (rec.BANK_NAME IS NULL AND :P5_BANK_NAME IS NOT NULL) OR (rec.BANK_NAME IS NOT NULL AND :P5_BANK_NAME IS NULL) THEN',
'    --     v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Bank Name</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''||NVL(rec'
||'.BANK_NAME, ''NULL'')||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''||NVL(:P5_BANK_NAME, ''NULL'')||''</td></tr>'';',
'    --     is_changed := true;',
'    -- END IF;',
'        ',
'    -- IF rec.BANK_BRANCH <> :P5_BANK_BRANCH OR (rec.BANK_BRANCH IS NULL AND :P5_BANK_BRANCH IS NOT NULL) OR (rec.BANK_BRANCH IS NOT NULL AND :P5_BANK_BRANCH IS NULL) THEN',
'    IF nvl(rec.BANK_BRANCH, ''$'') <> nvl(:P5_BANK_BRANCH, ''$'') THEN',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;border-bottom: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Bank branch / Chi nh\00E1nh ng\00E2n h\00E0ng</td><td  style=''''paddin')
||'g:0 10px; border-right: 1px solid black;''''>''|| rec.BANK_BRANCH ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| :P5_BANK_BRANCH ||''</td></tr>'';',
'        is_changed := true;',
'    END IF;',
'END LOOP;',
'v_body := v_body||''</table>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>Anh/Ch\1ECB vui l\00F2ng click t\1EA1i \0111\00E2y \0111\1EC3 ki\1EC3m tra th\00F4ng tin v\00E0 x\00E1c nh\1EADn c\1EADp nh\1EADt v\00E0o h\1EC7 th\1ED1ng D365 HRM.</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Please click Link to review and update information to D365 HRM System.</p>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Best regards,</p>'';',
'v_body := v_body||''<p style=''''color:black''''>HR & Admin Department </p>'';',
'-- v_body := v_body||''<img style='''';width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
'',
'-- UPDATE',
'UPDATE EMP_BANK',
'SET ',
'    BANK_ACC_NUM = :P5_BANK_ACC_NUM,',
'    BANK_BRANCH = :P5_BANK_BRANCH',
'WHERE ',
'    EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
'-------------------------------------------------------',
'----- Send mail',
'if is_changed then',
'    -- Send to HRs (for pilot)',
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''phuongpham@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''trang.th@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''hravus@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''haitran@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- send tester',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''huyen.ptt@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thudang@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thi.tnh@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ngan.tranvu@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- Send to Devs',
unistr('        -- SP_SENDGRID_EMAIL(''ky.nguyenquoc@vus-etsc.edu.vn'', ''quocky600@gmail.com'', ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin NV ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ky.nguyenquoc@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''quocky600@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''tranquangkhanh2k1qv@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''khanhnguyendev@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
' end if;',
'',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8236352292381414)
,p_process_success_message=>'Successfully submitted. HR-Admin department will check and update your information within 3-5 working days!'
,p_internal_uid=>9406695911131410
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9408207588131426)
,p_process_sequence=>50
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send email change info tab iden number'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_body clob:='''';',
'    is_changed boolean := false;',
'    v_start_time NUMBER;',
'    v_end_time NUMBER;',
'    r_inserted_status number; ',
'    old_issue_place nvarchar2(100);',
'    new_issue_place nvarchar2(100);',
'BEGIN',
'    -- v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second',
'    -- LOOP',
'    --     v_end_time := DBMS_UTILITY.GET_TIME;',
'    --     EXIT WHEN (v_end_time - v_start_time) > (2 * 100);  -- 5 seconds',
'    -- END LOOP;',
'',
'    -- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('    v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\1EC0 XU\1EA4T THAY \0110\1ED4I TH\00D4NG TIN C\00C1 NH\00C2N</h3>'';'),
unistr('    v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 PERSONAL INFORMATION UPDATE LETTERS</h3>'';'),
unistr('    v_body := v_body||''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''||:P5_FULL_NAME||'' th\00E2n m\1EBFn,</p>'';'),
'    v_body := v_body||''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''||:P5_FULL_NAME||'',</p>'';',
unistr('    v_body := v_body||''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB c\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin c\00E1 nh\00E2n c\1EE7a nh\00E2n vi\00EAn sau:</p>'';'),
'    v_body := v_body||''<p style=''''color:black''''>Employee Portal system has received a Personal information update request as below:</p>'';',
'    v_body := v_body||''<ul>'';',
unistr('    v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn/ Full name:</strong> ''||:P5_FULL_NAME||''</p>'';'),
unistr('    v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn/ Employee Code:</strong> ''||:P5_EMPLOYEE_CODE||''</p>'';'),
unistr('    v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- Ch\1EE9c danh/ Title:</strong> ''||:P5_TITLE||''</p>'';'),
'    v_body := v_body||''</ul>'';',
'    v_body := v_body||''<table style=''''border-collapse: collapse;border: 1px solid black;''''>'';',
'    v_body := v_body||''<tr>'';',
unistr('    v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>M\00C3 S\1ED0 \0110\1ECANH DANH</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>IDENTIFY NUMBER</i></p></th>'';'),
unistr('    v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\00C3 \0110\0102NG K\00DD</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>CURRENT PERSONAL INFORMATION</')
||'i></p></th>'';',
unistr('    v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\1EC0 NGH\1ECA THAY \0110\1ED4I</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>PERSONAL INFORMATION UPD')
||'ATE</i></p></th>'';',
'    v_body := v_body||''</tr>'';',
unistr('    v_body := v_body||''<tr style=''''border: 1px solid black;border-bottom: none;''''><td style=''''padding:0 10px; border-left: 1px solid black;''''><p style=''''color:black;margin:0;font-weight:700''''>Th\00F4ng tin CMND/CCCD c\00E1 nh\00E2n </p><p style=''''color:black;mar')
||'gin:0;font-style:italic;margin-bottom:10px''''>Identification number</p></td><td style=''''padding:0 10px; border-left: 1px solid black;''''></td><td style=''''padding:0 10px; border-left: 1px solid black''''></td></tr>'';',
'    FOR rec IN (',
'        SELECT',
'            emp_id.ID_NUMBER,',
'            CASE',
'                WHEN emp_id.ISSUE_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN NULL',
'                -- ELSE TO_CHAR(emp_id.ISSUE_DATE, ''MM/DD/YYYY'')',
'                ELSE TO_CHAR(emp_id.ISSUE_DATE, ''DD/MM/YYYY'')',
'            END AS ISSUE_DATE,',
'            CASE',
'                WHEN emp_id.EXPIRATION_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN NULL',
'                -- ELSE TO_CHAR(emp_id.EXPIRATION_DATE, ''MM/DD/YYYY'')',
'                ELSE TO_CHAR(emp_id.EXPIRATION_DATE, ''DD/MM/YYYY'')',
'            END AS EXPIRATION_DATE,',
'            emp_id.ISSUE_PLACE,',
'            emp_id.ATTACH_FILE,',
'            emp_id.ATTACH_NAME',
'        FROM',
'            EMP_ID_NUMBER emp_id',
'        INNER JOIN',
'            EMPLOYEES e ON e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'        WHERE',
'            emp_id.ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME',
'    )',
'    LOOP',
'',
'        SELECT NVL(MAX(LIA_NAME), '' '') ',
'        INTO old_issue_place',
'        FROM LIST_ISSUING_AGENCY ',
'        WHERE rec.ISSUE_PLACE = LIA_ISSUING_AGENCY_ID;',
'',
'        select NVL(MAX(LIA_NAME), '' '') into new_issue_place ',
'        from LIST_ISSUING_AGENCY where :P5_PLACE_DATE_ID = LIA_ISSUING_AGENCY_ID;',
'   ',
'        -- IF rec.ID_NUMBER <> :P5_ID_PP_NUMBER OR (rec.ID_NUMBER IS NULL AND :P5_ID_PP_NUMBER IS NOT NULL) OR (rec.ID_NUMBER IS NOT NULL AND :P5_ID_PP_NUMBER IS NULL) THEN',
'        IF NVL(rec.ID_NUMBER,''$'') <> NVL(:P5_ID_PP_NUMBER, ''$'') THEN',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>S\1ED1 CMND/CCCD / Identify number</td><td style=''''padding:0 10px; border-right: 1px sol')
||'id black;''''>''|| rec.ID_NUMBER ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| :P5_ID_PP_NUMBER ||''</td></tr>'';',
'            is_changed := true;',
'        END IF;',
'        ',
'        -- IF rec.ISSUE_DATE <> to_date(:P5_ISSUE_DATE_ID, ''DD/MM/YYYY'') OR (rec.ISSUE_DATE IS NULL AND :P5_ISSUE_DATE_ID IS NOT NULL) OR (rec.ISSUE_DATE IS NOT NULL AND :P5_ISSUE_DATE_ID IS NULL) THEN',
'        -- IF TO_CHAR(TO_DATE(rec.ISSUE_DATE, ''MM/DD/YYYY''), ''DD/MM/YYYY'') <> :P5_ISSUE_DATE_ID ',
'        IF rec.ISSUE_DATE <> :P5_ISSUE_DATE_ID ',
'        OR (rec.ISSUE_DATE IS NULL AND :P5_ISSUE_DATE_ID IS NOT NULL)',
'        THEN',
unistr('            -- v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y c\1EA5p CMND/CCCD / Issue date</td><td style=''''padding:0 10px; border-right: 1px')
||' solid black;''''>''|| to_char(to_date(rec.ISSUE_DATE, ''MM/DD/YYYY''), ''DD/MM/YYYY'') ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| :P5_ISSUE_DATE_ID ||''</td></tr>'';',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y c\1EA5p CMND/CCCD / Issue date</td><td style=''''padding:0 10px; border-right: 1px so')
||'lid black;''''>''|| rec.ISSUE_DATE ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| :P5_ISSUE_DATE_ID ||''</td></tr>'';',
'            is_changed := true;',
'        END IF;',
'        ',
'        -- IF rec.EXPIRATION_DATE <> to_date(:P5_EXP_DATE_ID, ''DD/MM/YYYY'') OR (rec.EXPIRATION_DATE IS NULL AND :P5_EXP_DATE_ID IS NOT NULL) OR (rec.EXPIRATION_DATE IS NOT NULL AND :P5_EXP_DATE_ID IS NULL) THEN',
'        -- IF rec.EXPIRATION_DATE <> TO_CHAR(TO_DATE(:P5_EXP_DATE_ID, ''DD/MM/YYYY''), ''MM/DD/YYYY'')',
'        IF rec.EXPIRATION_DATE <> :P5_EXP_DATE_ID',
'        OR (rec.EXPIRATION_DATE IS NULL AND :P5_EXP_DATE_ID IS NOT NULL)',
'        THEN',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y h\1EBFt h\1EA1n CMND/CCCD / Expiration date</td><td style=''''padding:0 10px; border-righ')
||'t: 1px solid black;''''>''|| rec.EXPIRATION_DATE ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| :P5_EXP_DATE_ID ||''</td></tr>'';',
'            is_changed := true;',
'        END IF;',
'        ',
'        -- IF rec.ISSUE_PLACE <> :P5_PLACE_DATE_ID OR (rec.ISSUE_PLACE IS NULL AND :P5_PLACE_DATE_ID IS NOT NULL) OR (rec.ISSUE_PLACE IS NOT NULL AND :P5_PLACE_DATE_ID IS NULL) THEN',
'        -- IF NVL(rec.ISSUE_PLACE,''$'') <> NVL(:P5_PLACE_DATE_ID, ''$'') THEN',
unistr('        --     v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>N\01A1i c\1EA5p CMND/CCCD / Place of Issue</td><td style=''''padding:0 10px; border-right: ')
||'1px solid black;''''>''|| rec.ISSUE_PLACE ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| :P5_PLACE_DATE_ID ||''</td></tr>'';',
'        --     is_changed := true;',
'        -- END IF;',
'        IF NVL(rec.ISSUE_PLACE,''$'') <> NVL(:P5_PLACE_DATE_ID, ''$'') THEN',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>N\01A1i c\1EA5p CMND/CCCD / Place of Issue</td><td style=''''padding:0 10px; border-right: 1px')
||' solid black;''''>''|| old_issue_place ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| new_issue_place ||''</td></tr>'';',
'            is_changed := true;',
'        END IF;',
'        ',
'        -- IF rec.ATTACH_FILE <> :P5_ID_NUM_ATTACH OR (rec.ATTACH_FILE IS NULL AND :P5_ID_NUM_ATTACH IS NOT NULL)  THEN',
'        IF NVL(rec.ATTACH_FILE, ''$'') <> NVL(:P5_ID_NUM_ATTACH, ''$'') THEN',
unistr('            -- v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>\0110\00EDnh k\00E8m / Attachment</td><td style=''''padding:0 10px; border-right: 1px solid bla')
||'ck;''''>''|| to_href_html(rec.ATTACH_FILE, rec.ATTACH_NAME) ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| :P5_ID_NUM_ATTACH ||''</td></tr>'';',
unistr('            -- v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>\0110\00EDnh k\00E8m / Attachment</td><td style=''''padding:0 10px; border-right: 1px solid bla')
||'ck;''''>''|| to_href_html(rec.ATTACH_FILE, rec.ATTACH_NAME) ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| :P5_ID_NUM_ATTACH ||''</td></tr>'';',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>\0110\00EDnh k\00E8m / Attachment</td><td style=''''padding:0 10px; border-right: 1px solid black;')
||'''''>''|| to_href_html(rec.ATTACH_FILE, rec.ATTACH_NAME) ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| to_href_html(:P5_URL, :P5_URL_NAME) ||''</td></tr>'';',
'            is_changed := true;',
'        END IF;',
'    END LOOP;',
'    v_body := v_body||''</table>'';',
unistr('    v_body := v_body||''<p style=''''color:black''''>Anh/Ch\1ECB vui l\00F2ng click t\1EA1i \0111\00E2y \0111\1EC3 ki\1EC3m tra th\00F4ng tin v\00E0 x\00E1c nh\1EADn c\1EADp nh\1EADt v\00E0o h\1EC7 th\1ED1ng D365 HRM.</p>'';'),
'    v_body := v_body||''<p style=''''color:black''''>Please click Link to review and update information to D365 HRM System.</p>'';',
unistr('    v_body := v_body||''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('    v_body := v_body||''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'    v_body := v_body||''<p style=''''color:black''''>Best regards,</p>'';',
'    v_body := v_body||''<p style=''''color:black''''>HR & Admin Department </p>'';',
'    -- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'    -- v_body := v_body||''<img style=''''width:100%'''' src=''''https://vus.edu.vn/wp-content/uploads/2023/11/header-email.png''''></img>'';',
'',
'    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second',
'    LOOP',
'        v_end_time := DBMS_UTILITY.GET_TIME;',
'        EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds',
'    END LOOP;',
'',
'    UPDATE EMP_ID_NUMBER',
'    SET',
'        ID_NUMBER = :P5_ID_PP_NUMBER,',
'        ISSUE_DATE = to_date(:P5_ISSUE_DATE_ID, ''DD/MM/YYYY''),',
'        EXPIRATION_DATE = to_date(:P5_EXP_DATE_ID, ''DD/MM/YYYY''),',
'        ISSUE_PLACE = :P5_PLACE_DATE_ID,',
'        ATTACH_FILE = :P5_URL,',
'        ATTACH_NAME = :P5_URL_NAME',
'    WHERE ID_TYPE = 0 and EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
'    -------------------------------------------------------',
'    ----- Send mail',
'    if is_changed then',
'    -- Send to HRs (for pilot)',
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''phuongpham@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''trang.th@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''hravus@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''haitran@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- send tester',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''huyen.ptt@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thudang@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thi.tnh@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ngan.tranvu@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- Send to Devs',
unistr('        -- SP_SENDGRID_EMAIL(''ky.nguyenquoc@vus-etsc.edu.vn'', ''quocky600@gmail.com'', ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin NV ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ky.nguyenquoc@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''quocky600@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''tranquangkhanh2k1qv@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''khanhnguyendev@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8180297924022847)
,p_process_success_message=>'Successfully submitted. HR-Admin department will check and update your information within 3-5 working days!'
,p_internal_uid=>9408207588131426
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9408383888131427)
,p_process_sequence=>60
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send email change info tab passport number'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_body clob:='''';',
'    is_changed boolean := false;',
'    old_issue_place nvarchar2(100);',
'    new_issue_place nvarchar2(100);',
'begin',
'',
'-- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\1EC0 XU\1EA4T THAY \0110\1ED4I TH\00D4NG TIN C\00C1 NH\00C2N</h3>'';'),
unistr('v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 PERSONAL INFORMATION UPDATE LETTERS</h3>'';'),
unistr('v_body := v_body||''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''||:P5_FULL_NAME||'' th\00E2n m\1EBFn,</p>'';'),
'v_body := v_body||''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''||:P5_FULL_NAME||'',</p>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB c\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin c\00E1 nh\00E2n c\1EE7a nh\00E2n vi\00EAn sau:</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Employee Portal system has received a Personal information update request as below:</p>'';',
'v_body := v_body||''<ul>'';',
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn/ Full name:</strong> ''||:P5_FULL_NAME||''</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn/ Employee Code:</strong> ''||:P5_EMPLOYEE_CODE||''</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- Ch\1EE9c danh/ Title:</strong> ''||:P5_TITLE||''</p>'';'),
'v_body := v_body||''</ul>'';',
'v_body := v_body||''<table style=''''border-collapse: collapse;border: 1px solid black;''''>'';',
'v_body := v_body||''<tr>'';',
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>M\00C3 S\1ED0 \0110\1ECANH DANH</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>IDENTIFY NUMBER</i></p></th>'';'),
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\00C3 \0110\0102NG K\00DD</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>CURRENT PERSONAL INFORMATION</i></')
||'p></th>'';',
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\1EC0 NGH\1ECA THAY \0110\1ED4I</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>PERSONAL INFORMATION UPDATE<')
||'/i></p></th>'';',
'v_body := v_body||''</tr>'';',
unistr('v_body := v_body||''<tr style=''''border: 1px solid black;border-bottom: none;''''><td style=''''padding:0 10px; border-left: 1px solid black;''''><p style=''''color:black;margin:0;font-weight:700''''>Th\00F4ng tin CMND/CCCD/H\1ED9 chi\1EBFu c\00E1 nh\00E2n </p><p style=''''color:blac')
||unistr('k;margin:0;font-style:italic;margin-bottom:10px''''>Passport/ H\1ED9 chi\1EBFu</p></td><td style=''''padding:0 10px; border-left: 1px solid black;''''></td><td style=''''padding:0 10px; border-left: 1px solid black''''></td></tr>'';'),
'for rec in (SELECT emp_id.ATTACH_FILE, emp_id.ATTACH_NAME,',
'    emp_id.ID_NUMBER,',
'    CASE',
'        WHEN emp_id.ISSUE_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN ''''',
'        -- ELSE TO_CHAR(emp_id.ISSUE_DATE, ''MM/DD/YYYY'')',
'        ELSE TO_CHAR(emp_id.ISSUE_DATE, ''DD/MM/YYYY'')',
'    END AS ISSUE_DATE,',
'    CASE',
'        WHEN emp_id.EXPIRATION_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN ''''',
'        -- ELSE TO_CHAR(emp_id.EXPIRATION_DATE, ''MM/DD/YYYY'')',
'        ELSE TO_CHAR(emp_id.EXPIRATION_DATE, ''DD/MM/YYYY'')',
'    END AS EXPIRATION_DATE,',
'    emp_id.ISSUE_PLACE',
'FROM',
'    EMP_ID_NUMBER emp_id',
'INNER JOIN',
'    EMPLOYEES e ON e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE',
'     e.USER_NAME = :APP_USER_NAME AND emp_id.ID_TYPE = 1',
')loop',
'',
'    SELECT NVL(MAX(LIA_NAME), '' '') ',
'    INTO old_issue_place',
'    FROM LIST_ISSUING_AGENCY ',
'    WHERE rec.ISSUE_PLACE = LIA_ISSUING_AGENCY_ID;',
'',
'    select NVL(MAX(LIA_NAME), '' '') into new_issue_place ',
'    from LIST_ISSUING_AGENCY where :P5_PLACE_DATE_ID_1 = LIA_ISSUING_AGENCY_ID;',
'',
'    if NVL(rec.ID_NUMBER,''$'') <> NVL(:P5_ID_PP_NUMBER_1, ''$'') then',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>S\1ED1 H\1ED9 chi\1EBFu / Passport number</td><td style=''''padding:0 10px; border-right: 1px solid bl')
||'ack;''''>''||rec.ID_NUMBER||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''||:P5_ID_PP_NUMBER_1||''</td></tr>'';',
'        is_changed := true;',
'    END IF;',
'',
'    -- if rec.ISSUE_DATE <> :P5_ISSUE_DATE_ID_1 then',
'    IF rec.ISSUE_DATE <> :P5_ISSUE_DATE_ID_1 ',
'    OR (rec.ISSUE_DATE IS NULL AND :P5_ISSUE_DATE_ID_1 IS NOT NULL) ',
'    THEN',
'    --if (rec.ISSUE_DATE <> :P5_ISSUE_DATE_ID_1) OR (rec.ISSUE_DATE is null and :P5_ISSUE_DATE_ID_1 is not null) then',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y c\1EA5p H\1ED9 chi\1EBFu / Issue date of Passport</td><td style=''''padding:0 10px; border-right:')
||' 1px solid black;''''>''|| rec.ISSUE_DATE ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| :P5_ISSUE_DATE_ID_1 ||''</td></tr>'';',
'        is_changed := true;',
'    END IF;',
'    ',
'    -- if rec.EXPIRATION_DATE <> to_char(:P5_EXP_DATE_ID_1, ''MM/DD/YYYY'') then',
'    --if NVL(rec.EXPIRATION_DATE, ''$'') <> NVL(to_char(to_date(:P5_EXP_DATE_ID_1, ''DD/MM/YYYY''), ''DD/MM/YYYY''), ''$'') then',
'    IF rec.EXPIRATION_DATE <> :P5_EXP_DATE_ID_1',
'    OR (rec.EXPIRATION_DATE IS NULL AND :P5_EXP_DATE_ID_1 IS NOT NULL)',
'    THEN',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y h\1EBFt h\1EA1n H\1ED9 chi\1EBFu / Expiration date of Passport</td><td style=''''padding:0 10px; bord')
||'er-right: 1px solid black;''''>''|| rec.EXPIRATION_DATE ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| :P5_EXP_DATE_ID_1 ||''</td></tr>'';',
'        is_changed := true;',
'    END IF;',
'    ',
'     if NVL(rec.ISSUE_PLACE,''$'') <> NVL(:P5_PLACE_DATE_ID_1, ''$'') then',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>N\01A1i c\1EA5p H\1ED9 chi\1EBFu / Issue place of Passport</td><td style=''''padding:0 10px; border-right:')
||' 1px solid black;''''>''||old_issue_place||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''||new_issue_place||''</td></tr>'';',
'        is_changed := true;',
'    END IF;',
'    ',
'    --   if rec.ATTACH_FILE <> :P5_ID_NUM_ATTACH_1 OR (rec.ATTACH_FILE IS NULL AND :P5_ID_NUM_ATTACH_1 IS NOT NULL)  then',
'      if NVL(rec.ATTACH_FILE, ''$'') <> NVL(:P5_ID_NUM_ATTACH_1, ''$'') then',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>\0110\00EDnh k\00E8m / Attachment</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''')
||'|| to_href_html(rec.ATTACH_FILE, rec.ATTACH_NAME) ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| to_href_html(:P5_URL_1, :P5_URL_NAME_1) ||''</td></tr>'';',
'        is_changed := true;',
'    END IF;',
'    ',
'end loop;',
'v_body := v_body||''</table>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>Anh/Ch\1ECB vui l\00F2ng click t\1EA1i \0111\00E2y \0111\1EC3 ki\1EC3m tra th\00F4ng tin v\00E0 x\00E1c nh\1EADn c\1EADp nh\1EADt v\00E0o h\1EC7 th\1ED1ng D365 HRM.</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Please click Link to review and update information to D365 HRM System.</p>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Best regards,</p>'';',
'v_body := v_body||''<p style=''''color:black''''>HR & Admin Department </p>'';',
'-- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
'UPDATE EMP_ID_NUMBER',
'SET',
'    ID_NUMBER = :P5_ID_PP_NUMBER_1,',
'    ISSUE_DATE = to_date(:P5_ISSUE_DATE_ID_1, ''DD/MM/YYYY''),',
'    EXPIRATION_DATE =  to_date(:P5_EXP_DATE_ID_1, ''DD/MM/YYYY''),',
'    ISSUE_PLACE = :P5_PLACE_DATE_ID_1,',
'    ATTACH_FILE = :P5_URL_1,',
'    ATTACH_NAME = :P5_URL_NAME_1',
'WHERE ID_TYPE = 1 and EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
'-------------------------------------------------------',
'----- Send mail',
'    if is_changed then',
'    -- Send to HRs (for pilot)',
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''phuongpham@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''trang.th@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''hravus@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''haitran@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- send tester',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''huyen.ptt@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thudang@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thi.tnh@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ngan.tranvu@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- Send to Devs',
unistr('        -- SP_SENDGRID_EMAIL(''ky.nguyenquoc@vus-etsc.edu.vn'', ''quocky600@gmail.com'', ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin NV ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ky.nguyenquoc@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''quocky600@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''tranquangkhanh2k1qv@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''khanhnguyendev@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8923872414040323)
,p_process_success_message=>'Successfully submitted. HR-Admin department will check and update your information within 3-5 working days!'
,p_internal_uid=>9408383888131427
);
end;
/
begin
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9408477963131428)
,p_process_sequence=>70
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send email change info tab Social Insurance number'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_body clob:='''';',
'    is_changed boolean := false;',
'begin',
'',
'-- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\1EC0 XU\1EA4T THAY \0110\1ED4I TH\00D4NG TIN C\00C1 NH\00C2N</h3>'';'),
unistr('v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 PERSONAL INFORMATION UPDATE LETTERS</h3>'';'),
unistr('v_body := v_body||''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''||:P5_FULL_NAME||'' th\00E2n m\1EBFn,</p>'';'),
'v_body := v_body||''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''||:P5_FULL_NAME||'',</p>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB c\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin c\00E1 nh\00E2n c\1EE7a nh\00E2n vi\00EAn sau:</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Employee Portal system has received a Personal information update request as below:</p>'';',
'v_body := v_body||''<ul>'';',
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn/ Full name:</strong> ''||:P5_FULL_NAME||''</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn/ Employee Code:</strong> ''||:P5_EMPLOYEE_CODE||''</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- Ch\1EE9c danh/ Title:</strong> ''||:P5_TITLE||''</p>'';'),
'v_body := v_body||''</ul>'';',
'v_body := v_body||''<table style=''''border-collapse: collapse;border: 1px solid black;''''>'';',
'v_body := v_body||''<tr>'';',
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>M\00C3 S\1ED0 \0110\1ECANH DANH</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>IDENTIFY NUMBER</i></p></th>'';'),
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\00C3 \0110\0102NG K\00DD</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>CURRENT PERSONAL INFORMATION</i></')
||'p></th>'';',
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\1EC0 NGH\1ECA THAY \0110\1ED4I</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>PERSONAL INFORMATION UPDATE<')
||'/i></p></th>'';',
'v_body := v_body||''</tr>'';',
unistr('v_body := v_body||''<tr style=''''border: 1px solid black;border-bottom: none;''''><td style=''''padding:0 10px; border-left: 1px solid black;''''><p style=''''color:black;margin:0;font-weight:700''''>Th\00F4ng tin B\1EA3o hi\1EC3m x\00E3 h\1ED9i</p><p style=''''color:black;margin:0;f')
||'ont-style:italic;margin-bottom:10px''''>Social insurance</p></td><td style=''''padding:0 10px; border-left: 1px solid black;''''></td><td style=''''padding:0 10px; border-left: 1px solid black''''></td></tr>'';',
'for rec in (SELECT',
'    EMP_SI.SOC_INS_NUMBER,',
'    EMP_SI.PRI_HEAL_SERVICE,',
'    EMP_SI.SOC_HOSPITAL_CODE,',
'    EMP_SI.SOC_HOU_NAME,',
'    CASE',
'        WHEN EMP_SI.SOC_HOU_DOB = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN ''''',
'        ELSE TO_CHAR(EMP_SI.SOC_HOU_DOB, ''DD/MM/YYYY'')',
'    END AS SOC_HOU_DOB,',
'    EMP_SI.SOC_HOU_ID,',
'    EMP_SI.SOC_RELATIONSHIP,',
'    EMP_SI.ATTACH_FILE,',
'    EMP_SI.ATTACH_NAME',
'FROM',
'    EMP_SOCICAL_INSURANCE EMP_SI',
'INNER JOIN',
'    EMPLOYEES e ON e.EMPLOYEE_CODE = EMP_SI.EMPLOYEE_CODE',
'WHERE',
'    e.USER_NAME = :APP_USER_NAME',
')loop',
'    if NVL(rec.SOC_INS_NUMBER,''$'') <> NVL(:P5_SOC_INS_NUMBER, ''$'') then',
unistr('        v_body := v_body||''<tr  style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>S\1ED1 s\1ED5 B\1EA3o hi\1EC3m x\00E3 h\1ED9i / Social insurance number</td><td style=''''padding:0 10')
||'px; border-right: 1px solid black;color:black''''>''||rec.SOC_INS_NUMBER||''</td><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>''||:P5_SOC_INS_NUMBER||''</td></tr>'';',
'        is_changed := true;',
'    end if;',
'    ',
'    if NVL(rec.PRI_HEAL_SERVICE,''$'') <> NVL(:P5_SOC_INS_PRI_HEAL, ''$'') then',
unistr('        v_body := v_body||''<tr  style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>N\01A1i \0111\0103ng k\00FD kh\00E1m ch\1EEFa b\1EC7nh / Primary healthcare service establishment </td><')
||'td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>''||rec.PRI_HEAL_SERVICE||''</td><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>''||:P5_SOC_INS_PRI_HEAL||''</td></tr>'';',
'        is_changed := true;',
'    end if;',
'    ',
'    if NVL(rec.SOC_HOSPITAL_CODE,''$'') <> NVL(:P5_SOC_INS_HOS_CODE,''$'') then',
unistr('        v_body := v_body||''<tr  style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>M\00E3 b\1EC7nh vi\1EC7n/ph\00F2ng kh\00E1m / Hospital/clinic code</td><td style=''''padding:0 10p')
||'x; border-right: 1px solid black;color:black''''>''||rec.SOC_HOSPITAL_CODE||''</td><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>''||:P5_SOC_INS_HOS_CODE||''</td></tr>'';',
'        is_changed := true;',
'    end if;',
'    ',
'    if NVL(rec.SOC_HOU_NAME,''$'') <> NVL(:P5_SOC_INS_HOU_NAME,''$'') then',
unistr('        v_body := v_body||''<tr  style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>H\1ECD v\00E0 t\00EAn ch\1EE7 h\1ED9 / Householder\2019s full name</td><td style=''''padding:0 10px; b')
||'order-right: 1px solid black;color:black''''>''||rec.SOC_HOU_NAME||''</td><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>''||:P5_SOC_INS_HOU_NAME||''</td></tr>'';',
'        is_changed := true;',
'    end if;',
'    ',
'    if rec.SOC_HOU_DOB <> :P5_SOC_INS_HOU_DOB',
'    or (rec.SOC_HOU_DOB IS NULL AND :P5_SOC_INS_HOU_DOB IS NOT NULL)',
'    then',
unistr('        v_body := v_body||''<tr  style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>Ng\00E0y sinh ch\1EE7 h\1ED9 kh\1EA9u / Householder\2019s DOB </td><td style=''''padding:0 10px; b')
||'order-right: 1px solid black;color:black''''>''|| rec.SOC_HOU_DOB ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>''|| :P5_SOC_INS_HOU_DOB ||''</td></tr>'';',
'        is_changed := true;',
'    end if;',
'    ',
'    if NVL(rec.SOC_HOU_ID,''$'') <> NVL(:P5_SOC_INS_HOU_ID,''$'') then',
unistr('        v_body := v_body||''<tr  style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>S\1ED1 CMND ch\1EE7 h\1ED9  /Householder\2019s ID number</td><td style=''''padding:0 10px; bor')
||'der-right: 1px solid black;color:black''''>''||rec.SOC_HOU_ID||''</td><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>''||:P5_SOC_INS_HOU_ID||''</td></tr>'';',
'        is_changed := true;',
'    end if;',
'    ',
'    if NVL(rec.SOC_RELATIONSHIP,''$'') <> NVL(:P5_SOC_INS_RELATIONS,''$'') then',
unistr('        v_body := v_body||''<tr  style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>M\1ED1i quan h\1EC7 v\1EDBi ch\1EE7 h\1ED9 / Relationship between householder and employee </td>')
||'<td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>''||rec.SOC_RELATIONSHIP||''</td><td style=''''padding:0 10px; border-right: 1px solid black;color:black''''>''||:P5_SOC_INS_RELATIONS||''</td></tr>'';',
'        is_changed := true;',
'    end if;',
'    ',
'    if NVL(rec.ATTACH_FILE,''$'') <> NVL(:P5_SOC_ATTACH,''$'') then',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>\0110\00EDnh k\00E8m / Attachment</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''')
||'|| to_href_html(rec.ATTACH_FILE, rec.ATTACH_NAME)  ||''</td><td style=''''padding:0 10px; border-right: 1px solid black;''''>''|| to_href_html(:P5_URL_SS, :P5_URL_NAME_SS ) ||''</td></tr>'';',
'        is_changed := true;',
'    end if;',
'end loop;',
'v_body := v_body||''</table>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>Anh/Ch\1ECB vui l\00F2ng click t\1EA1i \0111\00E2y \0111\1EC3 ki\1EC3m tra th\00F4ng tin v\00E0 x\00E1c nh\1EADn c\1EADp nh\1EADt v\00E0o h\1EC7 th\1ED1ng D365 HRM.</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Please click Link to review and update information to D365 HRM System.</p>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Best regards,</p>'';',
'v_body := v_body||''<p style=''''color:black''''>HR & Admin Department </p>'';',
'-- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
'update EMP_SOCICAL_INSURANCE',
'set',
'    SOC_INS_NUMBER = :P5_SOC_INS_NUMBER,',
'    PRI_HEAL_SERVICE = :P5_SOC_INS_PRI_HEAL,',
'    SOC_HOSPITAL_CODE = :P5_SOC_INS_HOS_CODE,',
'    SOC_HOU_NAME = :P5_SOC_INS_HOU_NAME,',
'    SOC_HOU_DOB = to_date(:P5_SOC_INS_HOU_DOB, ''DD/MM/YYYY''),',
'    SOC_HOU_ID = :P5_SOC_INS_HOU_ID,',
'    SOC_RELATIONSHIP = :P5_SOC_INS_RELATIONS,',
'    ATTACH_FILE = :P5_URL_SS,',
'    ATTACH_NAME = :P5_URL_NAME_SS',
'where EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
'',
'-------------------------------------------------------',
'----- Send mail',
'    if is_changed then',
'    -- Send to HRs (for pilot)',
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''phuongpham@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''trang.th@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''hravus@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''haitran@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- send tester',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''huyen.ptt@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thudang@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thi.tnh@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ngan.tranvu@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- Send to Devs',
unistr('        -- SP_SENDGRID_EMAIL(''ky.nguyenquoc@vus-etsc.edu.vn'', ''quocky600@gmail.com'', ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin NV ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ky.nguyenquoc@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''quocky600@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''tranquangkhanh2k1qv@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''khanhnguyendev@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8235933053381410)
,p_process_success_message=>'Successfully submitted. HR-Admin department will check and update your information within 3-5 working days!'
,p_internal_uid=>9408477963131428
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9408503908131429)
,p_process_sequence=>80
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send email change info tab PIT number'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'    v_body clob:='''';',
'    is_changed boolean := false;',
'BEGIN',
'-- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\1EC0 XU\1EA4T THAY \0110\1ED4I TH\00D4NG TIN C\00C1 NH\00C2N</h3>'';'),
unistr('v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 PERSONAL INFORMATION UPDATE LETTERS</h3>'';'),
unistr('v_body := v_body||''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''||:P5_FULL_NAME||'' th\00E2n m\1EBFn,</p>'';'),
'v_body := v_body||''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''||:P5_FULL_NAME||'',</p>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB c\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin c\00E1 nh\00E2n c\1EE7a nh\00E2n vi\00EAn sau:</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Employee Portal system has received a Personal information update request as below:</p>'';',
'v_body := v_body||''<ul>'';',
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn/ Full name:</strong> ''||:P5_FULL_NAME||''</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn/ Employee Code:</strong> ''||:P5_EMPLOYEE_CODE||''</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- Ch\1EE9c danh/ Title:</strong> ''||:P5_TITLE||''</p>'';'),
'v_body := v_body||''</ul>'';',
'v_body := v_body||''<table style=''''border-collapse: collapse;border: 1px solid black;''''>'';',
'v_body := v_body||''<tr>'';',
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>M\00C3 S\1ED0 \0110\1ECANH DANH</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>IDENTIFY NUMBER</i></p></th>'';'),
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\00C3 \0110\0102NG K\00DD</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>CURRENT PERSONAL INFORMATION</i></')
||'p></th>'';',
unistr('v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\1EC0 NGH\1ECA THAY \0110\1ED4I</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>PERSONAL INFORMATION UPDATE<')
||'/i></p></th>'';',
'v_body := v_body||''</tr>'';',
unistr('v_body := v_body||''<tr style=''''border: 1px solid black;border-bottom: none;''''><td style='''' padding:0 10px; border-left: 1px solid black;''''><p style=''''color:black;margin:0;font-weight:700''''>Th\00F4ng tin M\00E3 s\1ED1 thu\1EBF</p><p style=''''color:black;margin:0;font-')
||'style:italic;margin-bottom:10px''''>PIT</p></td><td style='''' padding:0 10px; border-left: 1px solid black;''''></td><td style='''' padding:0 10px; border-left: 1px solid black''''></td></tr>'';',
'FOR rec IN (SELECT ',
'    CASE',
'        WHEN emp_id.ISSUE_DATE = TO_DATE(''1/1/1900'', ''MM/DD/YYYY'') THEN ''''',
'        ELSE TO_CHAR(emp_id.ISSUE_DATE, ''DD/MM/YYYY'')',
'    END AS ISSUE_DATE',
'FROM EMP_ID_NUMBER emp_id',
'INNER JOIN ',
'    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE',
'WHERE ID_TYPE = 3 AND e.USER_NAME = :APP_USER_NAME ',
')LOOP',
'    --if to_date(rec.ISSUE_DATE, ''MM/DD/YYYY'') <> to_date(:P5_ISS_DATE_PIT_NUM, ''DD/MM/YYYY'')',
'    -- IF rec.ISSUE_DATE <> :P5_ISS_DATE_PIT_NUM',
'    IF rec.ISSUE_DATE <> :P5_ISS_DATE_PIT_NUM ',
'    OR (rec.ISSUE_DATE IS NULL AND :P5_ISS_DATE_PIT_NUM IS NOT NULL)  ',
'    THEN',
'        is_changed := true;',
unistr('        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y c\1EA5p m\00E3 s\1ED1 thu\1EBF / Issue date</td><td style='''' padding:0 10px; border-right: 1px sol')
||'id black;''''>''|| rec.ISSUE_DATE ||''</td><td style='''' padding:0 10px; border-right: 1px solid black;''''>''|| :P5_ISS_DATE_PIT_NUM ||''</td></tr>'';',
'    END IF;',
'END LOOP;',
'v_body := v_body||''</table>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>Anh/Ch\1ECB vui l\00F2ng click t\1EA1i \0111\00E2y \0111\1EC3 ki\1EC3m tra th\00F4ng tin v\00E0 x\00E1c nh\1EADn c\1EADp nh\1EADt v\00E0o h\1EC7 th\1ED1ng D365 HRM.</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Please click Link to review and update information to D365 HRM System.</p>'';',
unistr('v_body := v_body||''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('v_body := v_body||''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'v_body := v_body||''<p style=''''color:black''''>Best regards,</p>'';',
'v_body := v_body||''<p style=''''color:black''''>HR & Admin Department </p>'';',
'-- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
'UPDATE EMP_ID_NUMBER',
'SET',
'    ISSUE_DATE = TO_DATE(:P5_ISS_DATE_PIT_NUM, ''DD/MM/YYYY'')',
'    -- ISSUE_DATE = :P5_ISS_DATE_PIT_NUM',
'WHERE ID_TYPE = 3 AND EMPLOYEE_CODE = :APP_EMP_CODE;',
'',
'    if is_changed then',
'    -- Send to HRs (for pilot)',
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''phuongpham@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''trang.th@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''hravus@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''haitran@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- send tester',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''huyen.ptt@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thudang@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thi.tnh@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ngan.tranvu@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- Send to Devs',
unistr('        -- SP_SENDGRID_EMAIL(''ky.nguyenquoc@vus-etsc.edu.vn'', ''quocky600@gmail.com'', ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin NV ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ky.nguyenquoc@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''quocky600@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''tranquangkhanh2k1qv@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''khanhnguyendev@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'    end if;',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8236131725381412)
,p_process_success_message=>'Successfully submitted. HR-Admin department will check and update your information within 3-5 working days!'
,p_internal_uid=>9408503908131429
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9408691352131430)
,p_process_sequence=>90
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send email change info tab Education degree'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_body clob:='''';',
'    is_changed boolean := false;',
unistr('    -- bi\1EBFn \0111\1EC3 ki\1EC3m tra \0111o\1EA1n json'),
'    old_id number;',
'    old_major nvarchar2(100);',
'    old_place nvarchar2(500);',
'    old_level_of_edu nvarchar2(50);',
'    temp date;',
'    old_graduated_date nvarchar2(50);',
'    old_attach_name nvarchar2(2000);',
'    old_attach_url nvarchar2(5000);',
'    l_numrows number;',
unistr('    old_string apex_t_number;      -- B\1EA2NG C\0168 (JSON)'),
unistr('    new_string apex_t_number;      -- B\1EA2NG M\1EDAI'),
unistr('    add_ids apex_t_number;      -- B\1EA2NG ADD'),
unistr('    delete_ids apex_t_number;       -- B\1EA2NG DELETE'),
unistr('    current_ids apex_t_number;       -- B\1EA2NG id kh\00F4ng \0111\1ED5i, d\00F9ng \0111\1EC3 ki\1EC3m tra d\1EEF li\1EC7u update'),
'    n_major nvarchar2(100); ',
'    n_place nvarchar2(500);',
'    n_level_of_edu nvarchar2(50);',
'    n_graduated_date nvarchar2(50);',
'    n_attach_name nvarchar2(2000);',
'    n_attach_url nvarchar2(5000);',
'',
'begin',
'    -- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('    v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\1EC0 XU\1EA4T THAY \0110\1ED4I TH\00D4NG TIN C\00C1 NH\00C2N</h3>'';'),
unistr('    v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 PERSONAL INFORMATION UPDATE LETTERS</h3>'';'),
unistr('    v_body := v_body||''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''||:P5_FULL_NAME||'' th\00E2n m\1EBFn,</p>'';'),
'    v_body := v_body||''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''||:P5_FULL_NAME||'',</p>'';',
unistr('    v_body := v_body||''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB c\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin c\00E1 nh\00E2n c\1EE7a nh\00E2n vi\00EAn sau:</p>'';'),
'    v_body := v_body||''<p style=''''color:black''''>Employee Portal system has received a Personal information update request as below:</p>'';',
'    v_body := v_body||''<ul>'';',
unistr('    v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- H\1ECD v\00E0 t\00EAn/ Full name:</strong> ''||:P5_FULL_NAME||''</p>'';'),
unistr('    v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- M\00E3 s\1ED1 nh\00E2n vi\00EAn/ Employee Code:</strong> ''||:P5_EMPLOYEE_CODE||''</p>'';'),
unistr('    v_body := v_body||''<p style=''''color:black''''><strong style=''''color:black''''>- Ch\1EE9c danh/ Title:</strong> ''||:P5_TITLE||''</p>'';'),
'    v_body := v_body||''</ul>'';',
'    v_body := v_body||''<table style=''''border-collapse: collapse;border: 1px solid black;''''>'';',
'    v_body := v_body||''<tr>'';',
unistr('    -- v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0;font-weight:700''''>Th\00F4ng tin H\1ECDc v\1EA5n</p><p style=''''color:black;margin:0;font-style:italic;margin-bottom:10px''''>Education</p></th>'';'),
unistr('    v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>TH\00D4NG TIN H\1ECCC V\1EA4N</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>EDUCATION</i></p></th>'';'),
unistr('    v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\00C3 \0110\0102NG K\00DD</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>CURRENT PERSONAL INFORMATION</')
||'i></p></th>'';',
unistr('    v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\1EC0 NGH\1ECA THAY \0110\1ED4I</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>PERSONAL INFORMATION UPD')
||'ATE</i></p></th>'';',
'    v_body := v_body||''</tr>'';',
'    v_body := v_body||''<tr style=''''border: 1px solid black;border-bottom: none;''''><td style='''' padding:0 10px; border-left: 1px solid black;''''></td><td style='''' padding:0 10px; border-left: 1px solid black;''''></td><td style='''' padding:0 10px; border-'
||'left: 1px solid black''''></td></tr>'';',
'   ',
'    old_string := apex_t_number();',
'    new_string := apex_t_number();',
unistr('    -- parse page item \0111ang l\01B0u gi\00E1 tr\1ECB json c\1EE7a b\1EA3ng c\0169'),
'    APEX_JSON.PARSE(:P5_EMP_CURRENT_EDUCATION);',
unistr('    -- bi\1EBFn \0111\1EBFm s\1ED1 object c\1EE7a json'),
'    l_numrows := APEX_JSON.GET_COUNT(p_path => ''.'');',
'',
'    if l_numrows > 0 then',
'        for i in 1..l_numrows loop',
'            old_id := to_number(APEX_JSON.get_varchar2(p_path => ''[%d].id'', p0 => i));',
'            old_string.extend();',
'            old_string(old_string.COUNT) := old_id;',
'            ',
'        end loop;',
'    end if;',
'',
'    for temp in (select edu.id ',
'                from EMP_EDUCATION edu',
'                INNER JOIN ',
'                EMPLOYEES e ON edu.EMPLOYEE_CODE = e.EMPLOYEE_CODE',
'                WHERE e.USER_NAME = :APP_USER_NAME) loop',
'        new_string.extend();',
'        new_string(new_string.COUNT) := temp.id;',
'    end loop;',
'',
unistr('    -- KH\1EDEI T\1EA0O 2 B\1EA2NG R\1ED6NG \0110\1EC2 L\01AFU GI\00C1 TR\1ECA T\1EEA FUNCTION'),
'    add_ids := apex_t_number();',
'    delete_ids := apex_t_number();',
'    ',
'    add_ids := CHECK_ADD_ID(old_string, new_string);',
'    delete_ids := CHECK_DELETE_ID(old_string, new_string);',
'',
unistr('    -- ki\1EC3m tra xem n\1EBFu add_ids c\00F3 gi\00E1 tr\1ECB th\00EC th\00EAm n\1ED9i dung v\00E0o mail'),
'    if add_ids.COUNT != 0 then',
'        is_changed := true;',
'        for rec in 1..add_ids.COUNT loop',
'            -- Update attachment for new row in EMP_EDUCATION from TEMP_UPLOAD through TEMP_ID',
'            Update EMP_EDUCATION edu',
'            set edu.ATTACH_NAME = (select att.ATTACHMENT_NAME from TEMP_UPLOAD att where att.TEMP_ID = edu.TEMP_ID and att.TABLE_NAME = ''EMP_EDUCATION''),',
'                edu.ATTACH_URL = (select att.ATTACHMENT_URL from TEMP_UPLOAD att where att.TEMP_ID = edu.TEMP_ID and att.TABLE_NAME = ''EMP_EDUCATION'')',
'            where edu.ID = add_ids(rec);',
'',
'            select LEVEL_OF_EDU, MAJOR, PLACE, to_char(GRADUATED_DATE, ''DD/MM/YYYY''), ATTACH_NAME, ATTACH_URL',
'            into n_level_of_edu, n_major, n_place, n_graduated_date, n_attach_name, n_attach_url',
'            from EMP_EDUCATION',
'            where ID = add_ids(rec);',
'            ',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''><p style=''''color:black;font-weight:700; margin-top:20px;margin-bottom:0;''''>B\1EB1ng c\1EA5p')
||unistr(' \0111\00E3 th\00EAm</p><p style=''''color:black;margin:0;font-style:italic''''>Addition of a degree</p></td><td style='''' padding:0 10px; border-right: 1px solid black;''''></td><td style=''''padding:0 10px;''''></td></tr>'';'),
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>Tr\00ECnh \0111\1ED9 h\1ECDc v\1EA5n / Level of edu</td><td style='''' padding:0 10px; border-right: 1px ')
||'solid black;''''></td><td style=''''padding:0 10px;''''>''|| n_level_of_edu ||''</td></tr>'';',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>Chuy\00EAn ng\00E0nh / Major</td><td style='''' padding:0 10px; border-right: 1px solid black')
||';''''></td><td style=''''padding:0 10px;''''>''|| n_major ||''</td></tr>'';',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>T\00EAn tr\01B0\1EDDng h\1ECDc / Name of school/university/institute </td><td style='''' padding:0 10')
||'px; border-right: 1px solid black;''''></td><td style=''''padding:0 10px;''''>''|| n_place ||''</td></tr>'';',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''> N\0103m t\1ED1t nghi\1EC7p / Graduated date </td><td style='''' padding:0 10px; border-right: 1p')
||'x solid black;''''></td><td style=''''padding:0 10px;''''>''|| n_graduated_date ||''</td></tr>'';',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;margin-bottom:10px''''> \0110\00EDnh k\00E8m / Attachment </td><td style=''''padding:0 10px; border-rig')
||'ht: 1px solid black;''''></td><td style=''''padding:0 10px;''''>''|| to_href_html(n_attach_url, n_attach_name) ||''</td></tr>'';',
unistr('            -- v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''> \0110\00EDnh k\00E8m / Attachment </td><td style='''' padding:0 10px; border-right: 1px solid')
||' black;''''></td><td style=''''padding:0 10px;''''>''|| to_href_html(n_attach_file, n_attach_name) ||''</td></tr>'';',
'            -- v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''></td><td style='''' padding:0 10px; border-right: 1px solid black;''''></td><td styl'
||'e=''''padding:0 10px;''''></td></tr>'';    ',
'        end loop;',
'    end if;',
'',
unistr('    -- ki\1EC3m tra xem n\1EBFu delete_ids c\00F3 gi\00E1 tr\1ECB th\00EC th\00EAm n\1ED9i dung v\00E0o mail'),
'    if delete_ids.COUNT != 0 then',
'        is_changed := true;',
'        for i in 1..old_string.COUNT loop',
'            old_id := to_number(APEX_JSON.get_varchar2(p_path => ''[%d].id'', p0 => i));',
'            for j in 1..delete_ids.COUNT loop',
'                if old_id = delete_ids(j) then',
'                    v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''><p style=''''color:black;font-weight:700;margin-top:20px;margin-bottom:0;''''>B'
||unistr('\1EB1ng c\1EA5p \0111\00E3 xo\00E1</p><p style=''''color:black;margin:0;font-style:italic;''''>Deletion of a degree</p></td><td style='''' padding:0 10px; border-right: 1px solid black;''''></td><td style=''''padding:0 10px;''''></td></tr>'';'),
'                    ',
'                    old_major := APEX_JSON.get_varchar2(p_path => ''[%d].major'', p0 => i);',
'                    old_place := APEX_JSON.get_varchar2(p_path => ''[%d].place'', p0 => i);',
'                    old_level_of_edu := APEX_JSON.get_varchar2(p_path => ''[%d].level_of_edu'', p0 => i);',
'                    temp := to_date(APEX_JSON.get_varchar2(p_path => ''[%d].graduated_date'', p0 => i), ''YYYY-MM-DD"T"HH24:MI:SS'');',
'                    old_graduated_date := to_char(temp, ''DD/MM/YYYY'');',
'                    -- old_attach_name := APEX_JSON.get_varchar2(p_path => ''[%d].attach_file'', p0 => i);',
unistr('                    v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>Tr\00ECnh \0111\1ED9 h\1ECDc v\1EA5n / Level of edu</td><td style='''' padding:0 10px; border-rig')
||'ht: 1px solid black;''''>''|| old_level_of_edu ||''</td><td style=''''padding:0 10px;''''></td></tr>'';',
unistr('                    v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>Chuy\00EAn ng\00E0nh / Major</td><td style='''' padding:0 10px; border-right: 1px sol')
||'id black;''''>''|| old_major ||''</td><td style=''''padding:0 10px;''''></td></tr>'';',
unistr('                    v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>T\00EAn tr\01B0\1EDDng h\1ECDc / Name of school/university/institute </td><td style='''' padd')
||'ing:0 10px; border-right: 1px solid black;''''>''|| old_place ||''</td><td style=''''padding:0 10px;''''></td></tr>'';',
unistr('                    v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''> N\0103m t\1ED1t nghi\1EC7p / Graduated date </td><td style='''' padding:0 10px; border-r')
||'ight: 1px solid black;''''>''|| old_graduated_date ||''</td><td style=''''padding:0 10px;''''></td></tr>'';',
unistr('                    -- v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''> \0110\00EDnh k\00E8m / Attachment </td><td style='''' padding:0 10px; border-right: 1')
||'px solid black;''''>''|| old_attach_name ||''</td><td style=''''padding:0 10px;''''></td></tr>'';',
'                end if;',
'            end loop;',
'        end loop;',
'    end if;',
'',
unistr('    -- ki\1EC3m tra update'),
'    current_ids := apex_t_number();',
'',
'    for i in 1..new_string.count loop',
'        if new_string(i) member of old_string then',
'            current_ids.extend();',
'            current_ids(current_ids.count) := new_string(i);',
'        end if;',
'    end loop;',
'',
'    if current_ids.count != 0 then',
unistr('        for i in 1..old_string.count loop      -- ph\1EA3i ch\1EA1y theo s\1ED1 l\01B0\1EE3ng c\1EE7a old_ids th\00EC m\1EDBi x\00E9t h\1EBFt \0111c object c\1EE7a json, n\1EBFu d\00F9ng current s\1EBD c\00F3 th\00EC s\1EBD ko ch\1EA1y h\1EBFt object'),
'            old_id := to_number(APEX_JSON.get_varchar2(p_path => ''[%d].id'', p0 => i));',
'            for j in 1..current_ids.count loop',
unistr('                if old_id = current_ids(j) then     -- n\1EBFu id c\0169 b\1EB1ng v\1EDBi id hi\1EC7n t\1EA1i, khi \0111\00F3 m\00ECnh m\1EDBi b\1EAFt \0111c \0111\00FAng i c\00F9ng = id m\1EDBi'),
'                    old_level_of_edu := APEX_JSON.get_varchar2(p_path => ''[%d].level_of_edu'', p0 => i);',
'                    old_major := APEX_JSON.get_varchar2(p_path => ''[%d].major'', p0 => i);',
'                    old_place := APEX_JSON.get_varchar2(p_path => ''[%d].place'', p0 => i);',
'                    -- old_graduated_date := APEX_JSON.get_varchar2(p_path => ''[%d].graduated_date'', p0 => i);',
'                    temp := to_date(APEX_JSON.get_varchar2(p_path => ''[%d].graduated_date'', p0 => i), ''YYYY-MM-DD"T"HH24:MI:SS'');',
'                    old_graduated_date := to_char(temp, ''DD/MM/YYYY'');',
'',
'                    old_attach_name := APEX_JSON.get_varchar2(p_path => ''[%d].attach_name'', p0 => i);',
'                    old_attach_url := APEX_JSON.get_varchar2(p_path => ''[%d].attach_url'', p0 => i);',
'                    ',
unistr('                    -- l\1EA5y gi\00E1 tr\1ECB c\1EE7a d\00F2ng d\1EEF li\1EC7u m\1EDBi'),
'                    select LEVEL_OF_EDU, MAJOR, PLACE, to_char(GRADUATED_DATE, ''DD/MM/YYYY''), ATTACH_NAME, ATTACH_URL',
'                    into n_level_of_edu, n_major, n_place, n_graduated_date, n_attach_name, n_attach_url',
'                    from EMP_EDUCATION',
'                    where ID = current_ids(j);',
'',
'                    if ((old_level_of_edu != n_level_of_edu) or (old_level_of_edu is null and n_level_of_edu is not null) or (old_level_of_edu is not null and n_level_of_edu is null))',
'                    or ((old_major != n_major) or (old_major is null and n_major is not null) or (old_major is not null and n_major is null))',
'                    or (old_place != n_place or (old_place is null and n_place is not null) or (old_place is not null and n_place is null))',
'                    or (old_graduated_date != n_graduated_date or (old_graduated_date is null and n_graduated_date is not null) or (old_graduated_date is not null and n_graduated_date is null))',
'                    or old_attach_url != n_attach_url or (old_attach_url is null and n_attach_url is not null) or (old_attach_url is not null and n_attach_url is null) then',
'                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''><p style=''''color:black;margin-top:20px;margin-bottom:0;font-weight:700'''
||unistr('''>B\1EB1ng c\1EA5p \0111\00E3 c\1EADp nh\1EADt</p><p style=''''color:black;margin:0;font-style:italic;''''>Updating of a degree</p></td><td style='''' padding:0 10px; border-right: 1px solid black;''''></td><td style=''''padding:0 10px;''''></td></tr>'';'),
'                    end if;',
'                     ',
'                    -- if (old_level_of_edu != n_level_of_edu) or n_level_of_edu = '' '' then',
'                    if (old_level_of_edu != n_level_of_edu) or (old_level_of_edu is null and n_level_of_edu is not null) or (old_level_of_edu is not null and n_level_of_edu is null) then',
'                        is_changed := true;',
unistr('                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>Tr\00ECnh \0111\1ED9 h\1ECDc v\1EA5n / Level of edu</td><td style='''' padding:0 10px; border')
||'-right: 1px solid black;''''>''|| old_level_of_edu ||''</td><td style=''''padding:0 10px;''''>''|| n_level_of_edu ||''</td></tr>'';',
'                    end if;',
'',
'                    if (old_major != n_major) or (old_major is null and n_major is not null) or (old_major is not null and n_major is null) then',
'                        is_changed := true;',
unistr('                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>Chuy\00EAn ng\00E0nh / Major</td><td style='''' padding:0 10px; border-right: 1px')
||' solid black;''''>''|| old_major ||''</td><td style=''''padding:0 10px;''''>''|| n_major ||''</td></tr>'';',
'                    end if;',
'',
'                    if old_place != n_place or (old_place is null and n_place is not null) or (old_place is not null and n_place is null) then',
'                        is_changed := true;',
unistr('                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>T\00EAn tr\01B0\1EDDng h\1ECDc / Name of school/university/institute </td><td style='''' ')
||'padding:0 10px; border-right: 1px solid black;''''>''|| old_place ||''</td><td style=''''padding:0 10px;''''>''|| n_place ||''</td></tr>'';',
'                    end if;  ',
'',
'                    --n_graduated_date := to_char(temp_2, ''DD/MM/YYYY'');',
'                    if old_graduated_date != n_graduated_date or (old_graduated_date is null and n_graduated_date is not null) or (old_graduated_date is not null and n_graduated_date is null) then',
'                        is_changed := true;',
unistr('                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;margin-bottom:10px''''> N\0103m t\1ED1t nghi\1EC7p / Graduated date </td><td style='''' pa')
||'dding:0 10px; border-right: 1px solid black;''''>''|| old_graduated_date ||''</td><td style=''''padding:0 10px;''''>''|| n_graduated_date ||''</td></tr>'';',
'                    end if;',
'',
'                    if old_attach_url != n_attach_url or (old_attach_url is null and n_attach_url is not null) or (old_attach_url is not null and n_attach_url is null) then',
'                        is_changed := true;',
unistr('                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;margin-bottom:10px''''> \0110\00EDnh k\00E8m / Attachment </td><td style='''' padding:0 10')
||'px; border-right: 1px solid black;''''>''|| to_href_html(old_attach_url, old_attach_name) ||''</td><td style=''''padding:0 10px;''''>''|| to_href_html(n_attach_url, n_attach_name) ||''</td></tr>'';',
'                    end if;',
'',
'                    -- if ((old_level_of_edu != n_level_of_edu) or (old_level_of_edu is null and n_level_of_edu is not null) or (old_level_of_edu is not null and n_level_of_edu is null))',
'                    -- or ((old_major != n_major) or (old_major is null and n_major is not null) or (old_major is not null and n_major is null))',
'                    -- or (old_place != n_place or (old_place is null and n_place is not null) or (old_place is not null and n_place is null))',
'                    -- or (old_graduated_date != n_graduated_date or (old_graduated_date is null and n_graduated_date is not null) or (old_graduated_date is not null and n_graduated_date is null)) then',
'                    --     v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;margin-bottom:10px''''></td><td style='''' padding:0 10px; border-right: 1p'
||'x solid black;''''></td><td style=''''padding:0 10px;''''></td></tr>'';',
'                    -- end if;',
'',
'                end if;',
'            end loop;',
'        end loop;',
'        -- for i in 1..current_ids.count loop',
unistr('        --     -- l\1EA5y gi\00E1 tr\1ECB c\1EE7a d\00F2ng d\1EEF li\1EC7u c\0169'),
'        --     old_level_of_edu := APEX_JSON.get_varchar2(p_path => ''[%d].level_of_edu'', p0 => i);',
'        --     old_major := APEX_JSON.get_varchar2(p_path => ''[%d].major'', p0 => i);',
'        --     old_place := APEX_JSON.get_varchar2(p_path => ''[%d].place'', p0 => i);',
'        --     -- old_graduated_date := APEX_JSON.get_varchar2(p_path => ''[%d].graduated_date'', p0 => i);',
'        --     temp := to_date(APEX_JSON.get_varchar2(p_path => ''[%d].graduated_date'', p0 => i), ''YYYY-MM-DD"T"HH24:MI:SS'');',
'        --     old_graduated_date := to_char(temp, ''DD/MM/YYYY'');',
'',
'        --     old_attach_name := APEX_JSON.get_varchar2(p_path => ''[%d].attach_file'', p0 => i);',
'',
unistr('        --     -- l\1EA5y gi\00E1 tr\1ECB c\1EE7a d\00F2ng d\1EEF li\1EC7u m\1EDBi'),
'        --     select LEVEL_OF_EDU, MAJOR, PLACE, GRADUATED_DATE, ATTACH_FILE',
'        --     into n_level_of_edu, n_major, n_place, temp_2, n_attach_name',
'        --     from EMP_EDUCATION',
'        --     where ID = current_ids(i);',
'',
'        --     -- if (old_level_of_edu != n_level_of_edu) or n_level_of_edu = '' '' then',
'        --     if (old_level_of_edu != n_level_of_edu) or (old_level_of_edu is null and n_level_of_edu is not null) or (old_level_of_edu is not null and n_level_of_edu is null) then',
'        --         is_changed := true;',
unistr('        --         v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>Tr\00ECnh \0111\1ED9 h\1ECDc v\1EA5n / Level of edu</td><td style='''' padding:0 10px; border-righ')
||'t: 1px solid black;''''>''|| old_level_of_edu ||''</td><td style=''''padding:0 10px;''''>''|| n_level_of_edu ||''</td></tr>'';',
'        --     end if;',
'',
'        --     if (old_major != n_major) or (old_major is null and n_major is not null) or (old_major is not null and n_major is null) then',
'        --         is_changed := true;',
unistr('        --         v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>Chuy\00EAn ng\00E0nh / Major</td><td style='''' padding:0 10px; border-right: 1px soli')
||'d black;''''>''|| old_major ||''</td><td style=''''padding:0 10px;''''>''|| n_major ||''</td></tr>'';',
'        --     end if;',
'',
'        --     if old_place != n_place or (old_place is null and n_place is not null) or (old_place is not null and n_place is null) then',
'        --         is_changed := true;',
unistr('        --         v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''>T\00EAn tr\01B0\1EDDng h\1ECDc / Name of school/university/institute </td><td style='''' paddi')
||'ng:0 10px; border-right: 1px solid black;''''>''|| old_place ||''</td><td style=''''padding:0 10px;''''>''|| n_place ||''</td></tr>'';',
'        --     end if;  ',
'',
'        --     n_graduated_date := to_char(temp_2, ''DD/MM/YYYY'');',
'        --     if old_graduated_date != n_graduated_date or (old_graduated_date is null and n_graduated_date is not null) or (old_graduated_date is not null and n_graduated_date is null) then',
'        --         is_changed := true;',
unistr('        --         v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style='''' padding:0 10px; border-right: 1px solid black;''''> N\0103m t\1ED1t nghi\1EC7p / Graduated date </td><td style='''' padding:0 10px; border-ri')
||'ght: 1px solid black;''''>''|| old_graduated_date ||''</td><td style=''''padding:0 10px;''''>''|| n_graduated_date ||''</td></tr>'';',
'        --     end if; ',
'        -- end loop;',
'    end if;',
'',
'    v_body := v_body||''</table>'';',
unistr('    v_body := v_body||''<p style=''''color:black''''>Anh/Ch\1ECB vui l\00F2ng click t\1EA1i \0111\00E2y \0111\1EC3 ki\1EC3m tra th\00F4ng tin v\00E0 x\00E1c nh\1EADn c\1EADp nh\1EADt v\00E0o h\1EC7 th\1ED1ng D365 HRM.</p>'';'),
'    v_body := v_body||''<p style=''''color:black''''>Please click Link to review and update information to D365 HRM System.</p>'';',
unistr('    v_body := v_body||''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('    v_body := v_body||''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'    v_body := v_body||''<p style=''''color:black''''>Best regards,</p>'';',
'    v_body := v_body||''<p style=''''color:black''''>HR & Admin Department </p>'';',
'    -- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
'-------------------------------------------------------',
'----- Send mail',
'    if is_changed then',
'    -- Send to HRs (for pilot)',
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''phuongpham@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''trang.th@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''hravus@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''haitran@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- send tester',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''huyen.ptt@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thudang@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thi.tnh@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ngan.tranvu@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- Send to Devs',
unistr('        -- SP_SENDGRID_EMAIL(''ky.nguyenquoc@vus-etsc.edu.vn'', ''quocky600@gmail.com'', ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin NV ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ky.nguyenquoc@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''quocky600@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''tranquangkhanh2k1qv@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''khanhnguyendev@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8239352126381444)
,p_process_success_message=>'Successfully submitted. HR-Admin department will check and update your information within 3-5 working days!'
,p_internal_uid=>9408691352131430
);
end;
/
begin
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(9408740409131431)
,p_process_sequence=>100
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Send email change info tab Education certificates'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    v_body clob:='''';',
'    is_changed boolean := false;',
unistr('    -- bi\1EBFn \0111\1EC3 ki\1EC3m tra \0111o\1EA1n json'),
'    o_id number;',
'    o_certificate_type nvarchar2(100);',
'    o_start_date nvarchar2(50);',
'    temp_start date;',
'    o_end_date nvarchar2(50);',
'    temp_end date;',
'    o_short_note nvarchar2(100);',
'    o_attach_name nvarchar2(2000);',
'    o_attach_url nvarchar2(5000);',
'',
'    l_numrows number;',
'    ',
unistr('    old_string apex_t_number;      -- B\1EA2NG C\0168 (JSON)'),
unistr('    new_string apex_t_number;      -- B\1EA2NG M\1EDAI'),
'',
unistr('    add_ids apex_t_number;      -- B\1EA2NG ADD'),
unistr('    delete_ids apex_t_number;       -- B\1EA2NG DELETE'),
unistr('    current_ids apex_t_number;       -- B\1EA2NG id kh\00F4ng \0111\1ED5i, d\00F9ng \0111\1EC3 ki\1EC3m tra d\1EEF li\1EC7u update'),
'',
'    n_start_date nvarchar2(50); ',
'    n_end_date nvarchar2(50);',
'    n_certificate_type nvarchar2(100);',
'    n_short_note nvarchar2(100);',
'    n_attach_name nvarchar2(2000);',
'    n_attach_url nvarchar2(5000);',
'',
'begin',
'    -- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''''></img>'';',
unistr('    v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[PH\00D2NG NH\00C2N S\1EF0 H\00C0NH CH\00CDNH - VUS] \2013 \0110\1EC0 XU\1EA4T THAY \0110\1ED4I TH\00D4NG TIN C\00C1 NH\00C2N</h3>'';'),
unistr('    v_body := v_body||''<h3 style=''''color:black;text-align:center''''>[HRA DEPARTMENT - VUS] \2013 PERSONAL INFORMATION UPDATE LETTERS</h3>'';'),
unistr('    v_body := v_body||''<p style=''''color:black;margin-top:20px''''>Anh/Ch\1ECB ''||:P5_FULL_NAME||'' th\00E2n m\1EBFn,</p>'';'),
'    v_body := v_body||''<p style=''''color:black;margin-top:0''''>Dear Mr/Ms. ''||:P5_FULL_NAME||'',</p>'';',
unistr('    v_body := v_body||''<p style=''''color:black''''>H\1EC7 th\1ED1ng nh\1EADn \0111\01B0\1EE3c \0111\1EC1 ngh\1ECB c\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin c\00E1 nh\00E2n c\1EE7a nh\00E2n vi\00EAn sau:</p>'';'),
'    v_body := v_body||''<p style=''''color:black''''>Employee Portal system has received a Personal information update request as below:</p>'';',
'    v_body := v_body||''<ul>'';',
unistr('    v_body := v_body||''<li style=''''color:black''''><strong style=''''color:black''''>H\1ECD v\00E0 t\00EAn/ Full name:</strong> ''||:P5_FULL_NAME||''</li>'';'),
unistr('    v_body := v_body||''<li style=''''color:black''''><strong style=''''color:black''''>M\00E3 s\1ED1 nh\00E2n vi\00EAn/ Employee Code:</strong> ''||:P5_EMPLOYEE_CODE||''</li>'';'),
unistr('    v_body := v_body||''<li style=''''color:black''''><strong style=''''color:black''''>Ch\1EE9c danh/ Title:</strong> ''||:P5_TITLE||''</li>'';'),
'    v_body := v_body||''</ul>'';',
'    v_body := v_body||''<table style=''''border-collapse: collapse;border: 1px solid black;''''>'';',
'    v_body := v_body||''<tr>'';',
unistr('    -- v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0;font-weight:700''''>Th\00F4ng tin H\1ECDc v\1EA5n</p><p style=''''color:black;margin:0;font-style:italic;margin-bottom:10px''''>Education</p></th>'';'),
unistr('    v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>TH\00D4NG TIN H\1ECCC V\1EA4N</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>EDUCATION</i></p></th>'';'),
unistr('    v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\00C3 \0110\0102NG K\00DD</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>CURRENT PERSONAL INFORMATION</')
||'i></p></th>'';',
unistr('    v_body := v_body||''<th style=''''border: 1px solid black;''''><p style=''''color:black;margin:0''''><strong style=''''color:black;margin:0''''>N\1ED8I DUNG \0110\1EC0 NGH\1ECA THAY \0110\1ED4I</strong></p><p style=''''color:black;margin:0;font-weight:400''''><i>PERSONAL INFORMATION UPD')
||'ATE</i></p></th>'';',
'    v_body := v_body||''</tr>'';',
'    v_body := v_body||''<tr style=''''border: 1px solid black;border-bottom: none;''''><td style=''''padding:0 10px; border-left: 1px solid black;''''></td><td style=''''padding:0 10px; border-left: 1px solid black;''''></td><td style=''''padding:0 10px; border-lef'
||'t: 1px solid black''''></td></tr>'';',
'   ',
'    old_string := apex_t_number();',
'    new_string := apex_t_number();',
unistr('    -- parse page item \0111ang l\01B0u gi\00E1 tr\1ECB json c\1EE7a b\1EA3ng c\0169'),
'    APEX_JSON.PARSE(:P5_EMP_CURRENT_CERTIFICATES);',
unistr('    -- bi\1EBFn \0111\1EBFm s\1ED1 object c\1EE7a json'),
'    l_numrows := APEX_JSON.GET_COUNT(p_path => ''.'');',
'',
'    if l_numrows > 0 then',
'        for i in 1..l_numrows loop',
'            o_id := to_number(APEX_JSON.get_varchar2(p_path => ''[%d].id'', p0 => i));',
'            old_string.extend();',
'            old_string(old_string.COUNT) := o_id;',
'            ',
'        end loop;',
'    end if;',
'',
'    for rec in (select cer.id ',
'                from EMP_CERTIFICATE cer',
'                INNER JOIN ',
'                EMPLOYEES e ON cer.EMPLOYEE_CODE = e.EMPLOYEE_CODE',
'                WHERE e.USER_NAME = :APP_USER_NAME) loop',
'        new_string.extend();',
'        new_string(new_string.COUNT) := rec.id;',
'    end loop;',
'',
unistr('    -- KH\1EDEI T\1EA0O 2 B\1EA2NG R\1ED6NG \0110\1EC2 L\01AFU GI\00C1 TR\1ECA T\1EEA FUNCTION'),
'    add_ids := apex_t_number();',
'    delete_ids := apex_t_number();',
'    ',
'    add_ids := CHECK_ADD_ID(old_string, new_string);',
'    delete_ids := CHECK_DELETE_ID(old_string, new_string);',
'',
unistr('    -- ki\1EC3m tra xem n\1EBFu add_ids c\00F3 gi\00E1 tr\1ECB th\00EC th\00EAm n\1ED9i dung v\00E0o mail'),
'    if add_ids.COUNT != 0 then',
'        is_changed := true;',
'        for rec in 1..add_ids.COUNT loop',
'            ',
'            -- Update attachment for new row in EMP_CERTIFICATE from TEMP_UPLOAD through TEMP_ID',
'            Update EMP_CERTIFICATE cert',
'            set cert.ATTACHMENT_NAME = (select att.ATTACHMENT_NAME from TEMP_UPLOAD att where att.TEMP_ID = cert.TEMP_ID and att.TABLE_NAME = ''EMP_CERTIFICATE''),',
'                cert.ATTACHMENT_URL = (select att.ATTACHMENT_URL from TEMP_UPLOAD att where att.TEMP_ID = cert.TEMP_ID and att.TABLE_NAME = ''EMP_CERTIFICATE'')',
'            where cert.ID = add_ids(rec);',
'',
'            select CERTIFICATE_TYPE, to_char(START_DATE, ''DD/MM/YYYY''), to_char(END_DATE, ''DD/MM/YYYY''), SHORT_NOTE, ATTACHMENT_NAME, ATTACHMENT_URL',
'            into n_certificate_type, n_start_date, n_end_date, n_short_note, n_attach_name, n_attach_url',
'            from EMP_CERTIFICATE',
'            where ID = add_ids(rec);',
'',
unistr('            --l\1EA5y m\00F4 t\1EA3 ch\1EE9ng ch\1EC9 v\00EC \0111ang l\01B0u id c\1EE7a ch\1EE9ng ch\1EC9 trong bi\1EBFn n_certificate_type '),
'            select NVL(MAX(LCT_CERTIFICATE_DESCRIPTION), '' '') into n_certificate_type ',
'            from LIST_CERTIFICATE_TYPE where LCT_HCM_CERTIFICATE_TYPE_ID = n_certificate_type;',
'',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''><p style=''''color:black;font-weight:700;margin-top:20px;margin-bottom:0''''>Ch\1EE9ng ch\1EC9 \0111')
||unistr('\00E3 th\00EAm</p><p style=''''color:black;margin:0;font-style:italic''''>Addition of a certificate</p></td><td style=''''padding:0 10px; border-right: 1px solid black;''''></td><td style=''''padding:0 10px;''''></td></tr>'';'),
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>T\00EAn ch\1EE9ng ch\1EC9 / Certificate type</td><td style=''''padding:0 10px; border-right: 1px s')
||'olid black;''''></td><td style=''''padding:0 10px;''''>''|| n_certificate_type ||''</td></tr>'';',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y c\1EA5p / Issue date</td><td style=''''padding:0 10px; border-right: 1px solid black;')
||'''''></td><td style=''''padding:0 10px;''''>''|| n_start_date ||''</td></tr>'';',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y h\1EBFt h\1EA1n / Expiration date</td><td style=''''padding:0 10px; border-right: 1px sol')
||'id black;''''></td><td style=''''padding:0 10px;''''>''|| n_end_date ||''</td></tr>'';',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''> Ghi ch\00FA / Note </td><td style=''''padding:0 10px; border-right: 1px solid black;''''></')
||'td><td style=''''padding:0 10px;''''>''|| n_short_note ||''</td></tr>'';',
unistr('            v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''> \0110\00EDnh k\00E8m / Attachment </td><td style=''''padding:0 10px; border-right: 1px solid blac')
||'k;''''></td><td style=''''padding:0 10px;''''>''|| to_href_html(n_attach_url, n_attach_name) ||''</td></tr>'';',
'            -- v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''></td><td style=''''padding:0 10px; border-right: 1px solid black;''''></td><td style='
||'''''padding:0 10px;''''></td></tr>'';',
'            ',
'        end loop;',
'    end if;',
'',
unistr('    -- ki\1EC3m tra xem n\1EBFu delete_ids c\00F3 gi\00E1 tr\1ECB th\00EC th\00EAm n\1ED9i dung v\00E0o mail'),
'    if delete_ids.COUNT != 0 then',
'        is_changed := true;',
'        for i in 1..old_string.COUNT loop',
'            o_id := to_number(APEX_JSON.get_varchar2(p_path => ''[%d].id'', p0 => i));',
'            for j in 1..delete_ids.COUNT loop',
'                if o_id = delete_ids(j) then',
unistr('                    v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''><p style=''''color:black;font-weight:700;margin-top:20px;margin-bottom:0''''>Ch\1EE9')
||unistr('ng ch\1EC9 \0111\00E3 xo\00E1</p><p style=''''color:black;margin:0;font-style:italic;''''>Deletion of a certificate</p></td><td style=''''padding:0 10px; border-right: 1px solid black;''''></td><td style=''''padding:0 10px;''''></td></tr>'';'),
'                    ',
'                    o_certificate_type := APEX_JSON.get_varchar2(p_path => ''[%d].certificate_type'', p0 => i);',
'                    ',
'                    temp_start := to_date(APEX_JSON.get_varchar2(p_path => ''[%d].start_date'', p0 => i), ''YYYY-MM-DD"T"HH24:MI:SS'');',
'                    o_start_date := to_char(temp_start, ''DD/MM/YYYY'');',
'                    ',
'                    temp_end := to_date(APEX_JSON.get_varchar2(p_path => ''[%d].end_date'', p0 => i), ''YYYY-MM-DD"T"HH24:MI:SS'');',
'                    o_end_date := to_char(temp_end, ''DD/MM/YYYY'');',
'                    ',
'                    o_short_note := APEX_JSON.get_varchar2(p_path => ''[%d].short_note'', p0 => i);',
'                    ',
'                    -- o_attach_name := APEX_JSON.get_varchar2(p_path => ''[%d].attachment_name'', p0 => i);',
'                    -- o_attach_url := APEX_JSON.get_varchar2(p_path => ''[%d].attachment_url'', p0 => i);',
'',
unistr('                    --l\1EA5y m\00F4 t\1EA3 ch\1EE9ng ch\1EC9 v\00EC \0111ang l\01B0u id c\1EE7a ch\1EE9ng ch\1EC9 trong bi\1EBFn o_certificate_type'),
'                    -- select LCT_CERTIFICATE_DESCRIPTION into o_certificate_type from LIST_CERTIFICATE_TYPE where LCT_HCM_CERTIFICATE_TYPE_ID = o_certificate_type;',
'                    select NVL(MAX(LCT_CERTIFICATE_DESCRIPTION), '' '') into o_certificate_type ',
'                    from LIST_CERTIFICATE_TYPE where LCT_HCM_CERTIFICATE_TYPE_ID = o_certificate_type;',
'',
unistr('                    v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>T\00EAn ch\1EE9ng ch\1EC9 / Certificate type</td><td style=''''padding:0 10px; border-righ')
||'t: 1px solid black;''''>''|| o_certificate_type ||''</td><td style=''''padding:0 10px;''''></td></tr>'';',
unistr('                    v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y c\1EA5p / Issue date</td><td style=''''padding:0 10px; border-right: 1px soli')
||'d black;''''>''|| o_start_date ||''</td><td style=''''padding:0 10px;''''></td></tr>'';',
unistr('                    v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y h\1EBFt h\1EA1n / Expiration date</td><td style=''''padding:0 10px; border-right:')
||' 1px solid black;''''>''|| o_end_date ||''</td><td style=''''padding:0 10px;''''></td></tr>'';',
unistr('                    v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ghi ch\00FA / Note</td><td style=''''padding:0 10px; border-right: 1px solid black')
||';''''>''|| o_short_note ||''</td><td style=''''padding:0 10px;''''></td></tr>'';',
unistr('                    -- v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''> \0110\00EDnh k\00E8m / Attachment </td><td style=''''padding:0 10px; border-right: 1px')
||' solid black;''''>''|| o_attach_name ||''</td><td style=''''padding:0 10px;''''></td></tr>'';',
'                end if;',
'            end loop;',
'        end loop;',
'    end if;',
'',
unistr('    -- ki\1EC3m tra update'),
'    current_ids := apex_t_number();',
'',
'    for i in 1..new_string.count loop',
'        if new_string(i) member of old_string then',
'            current_ids.extend();',
'            current_ids(current_ids.count) := new_string(i);',
'        end if;',
'    end loop;',
'',
'    if current_ids.count != 0 then',
unistr('        for i in 1..old_string.count loop      -- ph\1EA3i ch\1EA1y theo s\1ED1 l\01B0\1EE3ng c\1EE7a o_ids th\00EC m\1EDBi x\00E9t h\1EBFt \0111c object c\1EE7a json, n\1EBFu d\00F9ng current s\1EBD c\00F3 th\00EC s\1EBD ko ch\1EA1y h\1EBFt object'),
'            o_id := to_number(APEX_JSON.get_varchar2(p_path => ''[%d].id'', p0 => i));',
'            for j in 1..current_ids.count loop',
unistr('                if o_id = current_ids(j) then     -- n\1EBFu id c\0169 b\1EB1ng v\1EDBi id hi\1EC7n t\1EA1i, khi \0111\00F3 m\00ECnh m\1EDBi b\1EAFt \0111c \0111\00FAng i c\00F9ng = id m\1EDBi'),
'                    o_certificate_type := APEX_JSON.get_varchar2(p_path => ''[%d].certificate_type'', p0 => i);',
'                    ',
'                    temp_start := to_date(APEX_JSON.get_varchar2(p_path => ''[%d].start_date'', p0 => i), ''YYYY-MM-DD"T"HH24:MI:SS'');',
'                    o_start_date := to_char(temp_start, ''DD/MM/YYYY'');',
'                    ',
'                    temp_end := to_date(APEX_JSON.get_varchar2(p_path => ''[%d].end_date'', p0 => i), ''YYYY-MM-DD"T"HH24:MI:SS'');',
'                    o_end_date := to_char(temp_end, ''DD/MM/YYYY'');',
'                    ',
'                    o_short_note := APEX_JSON.get_varchar2(p_path => ''[%d].short_note'', p0 => i);',
'',
'                    o_attach_name := APEX_JSON.get_varchar2(p_path => ''[%d].attachment_name'', p0 => i);',
'                    o_attach_url := APEX_JSON.get_varchar2(p_path => ''[%d].attachment_url'', p0 => i);',
'                    ',
unistr('                    -- l\1EA5y gi\00E1 tr\1ECB c\1EE7a d\00F2ng d\1EEF li\1EC7u m\1EDBi'),
'                    select CERTIFICATE_TYPE, to_char(START_DATE, ''DD/MM/YYYY''), to_char(END_DATE, ''DD/MM/YYYY''), SHORT_NOTE, ATTACHMENT_NAME, ATTACHMENT_URL',
'                    into n_certificate_type, n_start_date, n_end_date, n_short_note, n_attach_name, n_attach_url',
'                    from EMP_CERTIFICATE',
'                    where ID = current_ids(j);',
'',
'                    if ((o_certificate_type != n_certificate_type) or (o_certificate_type is null and n_certificate_type is not null) or (o_certificate_type is not null and n_certificate_type is null))',
'                    or ((o_start_date != n_start_date) or (o_start_date is null and n_start_date is not null) or (o_start_date is not null and n_start_date is null))',
'                    or (o_end_date != n_end_date or (o_end_date is null and n_end_date is not null) or (o_end_date is not null and n_end_date is null))',
'                    or (o_short_note != n_short_note or (o_short_note is null and n_short_note is not null) or (o_short_note is not null and n_short_note is null))',
'                    or (o_attach_url != n_attach_url or (o_attach_url is null and n_attach_url is not null) or (o_attach_url is not null and n_attach_url is null)) then',
'                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''><p style=''''color:black;font-weight:700; margin-top:20px;margin-bottom:0;'
||unistr('''''>Ch\1EE9ng ch\1EC9 \0111\00E3 c\1EADp nh\1EADt</p><p style=''''color:black;margin:0;font-style:italic;''''>Updating of a certificate</p></td><td style=''''padding:0 10px; border-right: 1px solid black;''''></td><td style=''''padding:0 10px;''''></td></tr>'';'),
'                    end if;',
'                     ',
'                    -- if (o_certificate_type != n_certificate_type) or n_certificate_type = '' '' then',
'                    if (o_certificate_type != n_certificate_type) or (o_certificate_type is null and n_certificate_type is not null) or (o_certificate_type is not null and n_certificate_type is null) then',
'                        is_changed := true;',
unistr('                        --l\1EA5y m\00F4 t\1EA3 ch\1EE9ng ch\1EC9 v\00EC \0111ang l\01B0u id c\1EE7a ch\1EE9ng ch\1EC9 trong bi\1EBFn o_certificate_type '),
'                        select NVL(MAX(LCT_CERTIFICATE_DESCRIPTION), '' '') into o_certificate_type ',
'                        from LIST_CERTIFICATE_TYPE where LCT_HCM_CERTIFICATE_TYPE_ID = o_certificate_type;',
'',
'                        select NVL(MAX(LCT_CERTIFICATE_DESCRIPTION), '' '') into n_certificate_type ',
'                        from LIST_CERTIFICATE_TYPE where LCT_HCM_CERTIFICATE_TYPE_ID = n_certificate_type;',
unistr('                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>T\00EAn ch\1EE9ng ch\1EC9 / Certificate type</td><td style=''''padding:0 10px; border-')
||'right: 1px solid black;''''>''|| o_certificate_type ||''</td><td style=''''padding:0 10px;''''>''|| n_certificate_type ||''</td></tr>'';',
'                    end if;',
'',
'                    if (o_start_date != n_start_date) or (o_start_date is null and n_start_date is not null) or (o_start_date is not null and n_start_date is null) then',
'                        is_changed := true;',
unistr('                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y c\1EA5p / Issue date</td><td style=''''padding:0 10px; border-right: 1px ')
||'solid black;''''>''|| o_start_date ||''</td><td style=''''padding:0 10px;''''>''|| n_start_date ||''</td></tr>'';',
'                    end if;',
'',
'                    if o_end_date != n_end_date or (o_end_date is null and n_end_date is not null) or (o_end_date is not null and n_end_date is null) then',
'                        is_changed := true;',
unistr('                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Ng\00E0y h\1EBFt h\1EA1n / Expiration date</td><td style=''''padding:0 10px; border-ri')
||'ght: 1px solid black;''''>''|| o_start_date ||''</td><td style=''''padding:0 10px;''''>''|| n_end_date ||''</td></tr>'';',
'                    end if;  ',
'',
'                    --n_short_note := to_char(temp_start_2, ''DD/MM/YYYY'');',
'                    if o_short_note != n_short_note or (o_short_note is null and n_short_note is not null) or (o_short_note is not null and n_short_note is null) then',
'                        is_changed := true;',
unistr('                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;margin-bottom:10px''''>Ghi ch\00FA / Note</td><td style=''''padding:0 10px; border-')
||'right: 1px solid black;''''>''|| o_short_note ||''</td><td style=''''padding:0 10px;''''>''|| n_short_note ||''</td></tr>'';',
'                    end if;',
'',
'                    if o_attach_url != n_attach_url or (o_attach_url is null and n_attach_url is not null) or (o_attach_url is not null and n_attach_url is null) then',
'                        is_changed := true;',
unistr('                        v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;margin-bottom:10px''''>\0110\00EDnh k\00E8m / Attachment</td><td style=''''padding:0 10px; ')
||'border-right: 1px solid black;''''>''|| to_href_html(o_attach_url, o_attach_name) ||''</td><td style=''''padding:0 10px;''''>''|| to_href_html(n_attach_url, n_attach_name) ||''</td></tr>'';',
'                    end if;',
'',
'                    -- if ((o_end_date != n_certificate_type) or (o_end_date is null and n_certificate_type is not null) or (o_end_date is not null and n_certificate_type is null))',
'                    -- or ((o_certificate_type != n_start_date) or (o_certificate_type is null and n_start_date is not null) or (o_certificate_type is not null and n_start_date is null))',
'                    -- or (o_start_date != n_end_date or (o_start_date is null and n_end_date is not null) or (o_start_date is not null and n_end_date is null))',
'                    -- or (old_graduated_date != n_short_note or (old_graduated_date is null and n_short_note is not null) or (old_graduated_date is not null and n_short_note is null)) then',
'                    --     v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;margin-bottom:10px''''></td><td style=''''padding:0 10px; border-right: 1px '
||'solid black;''''></td><td style=''''padding:0 10px;''''></td></tr>'';',
'                    -- end if;',
'',
'                end if;',
'            end loop;',
'        end loop;',
'        -- for i in 1..current_ids.count loop',
unistr('        --     -- l\1EA5y gi\00E1 tr\1ECB c\1EE7a d\00F2ng d\1EEF li\1EC7u c\0169'),
'        --     o_end_date := APEX_JSON.get_varchar2(p_path => ''[%d].level_of_edu'', p0 => i);',
'        --     o_certificate_type := APEX_JSON.get_varchar2(p_path => ''[%d].major'', p0 => i);',
'        --     o_start_date := APEX_JSON.get_varchar2(p_path => ''[%d].place'', p0 => i);',
'        --     -- old_graduated_date := APEX_JSON.get_varchar2(p_path => ''[%d].graduated_date'', p0 => i);',
'        --     temp_start := to_date(APEX_JSON.get_varchar2(p_path => ''[%d].graduated_date'', p0 => i), ''YYYY-MM-DD"T"HH24:MI:SS'');',
'        --     old_graduated_date := to_char(temp_start, ''DD/MM/YYYY'');',
'',
'        --     o_attach_name := APEX_JSON.get_varchar2(p_path => ''[%d].attach_file'', p0 => i);',
'',
unistr('        --     -- l\1EA5y gi\00E1 tr\1ECB c\1EE7a d\00F2ng d\1EEF li\1EC7u m\1EDBi'),
'        --     select LEVEL_OF_EDU, MAJOR, PLACE, GRADUATED_DATE, ATTACH_FILE',
'        --     into n_certificate_type, n_start_date, n_end_date, temp_start_2, n_attach_name',
'        --     from EMP_EDUCATION',
'        --     where ID = current_ids(i);',
'',
'        --     -- if (o_end_date != n_certificate_type) or n_certificate_type = '' '' then',
'        --     if (o_end_date != n_certificate_type) or (o_end_date is null and n_certificate_type is not null) or (o_end_date is not null and n_certificate_type is null) then',
'        --         is_changed := true;',
unistr('        --         v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Tr\00ECnh \0111\1ED9 h\1ECDc v\1EA5n / Level of edu</td><td style=''''padding:0 10px; border-right:')
||' 1px solid black;''''>''|| o_end_date ||''</td><td style=''''padding:0 10px;''''>''|| n_certificate_type ||''</td></tr>'';',
'        --     end if;',
'',
'        --     if (o_certificate_type != n_start_date) or (o_certificate_type is null and n_start_date is not null) or (o_certificate_type is not null and n_start_date is null) then',
'        --         is_changed := true;',
unistr('        --         v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>Chuy\00EAn ng\00E0nh / Major</td><td style=''''padding:0 10px; border-right: 1px solid ')
||'black;''''>''|| o_certificate_type ||''</td><td style=''''padding:0 10px;''''>''|| n_start_date ||''</td></tr>'';',
'        --     end if;',
'',
'        --     if o_start_date != n_end_date or (o_start_date is null and n_end_date is not null) or (o_start_date is not null and n_end_date is null) then',
'        --         is_changed := true;',
unistr('        --         v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''>T\00EAn tr\01B0\1EDDng h\1ECDc / Name of school/university/institute </td><td style=''''padding')
||':0 10px; border-right: 1px solid black;''''>''|| o_start_date ||''</td><td style=''''padding:0 10px;''''>''|| n_end_date ||''</td></tr>'';',
'        --     end if;  ',
'',
'        --     n_short_note := to_char(temp_start_2, ''DD/MM/YYYY'');',
'        --     if old_graduated_date != n_short_note or (old_graduated_date is null and n_short_note is not null) or (old_graduated_date is not null and n_short_note is null) then',
'        --         is_changed := true;',
unistr('        --         v_body := v_body||''<tr style=''''border-left: 1px solid black;border-right: 1px solid black;''''><td style=''''padding:0 10px; border-right: 1px solid black;''''> N\0103m t\1ED1t nghi\1EC7p / Graduated date </td><td style=''''padding:0 10px; border-righ')
||'t: 1px solid black;''''>''|| old_graduated_date ||''</td><td style=''''padding:0 10px;''''>''|| n_short_note ||''</td></tr>'';',
'        --     end if; ',
'        -- end loop;',
'    end if;',
'',
'    v_body := v_body||''</table>'';',
unistr('    v_body := v_body||''<p style=''''color:black''''>Anh/Ch\1ECB vui l\00F2ng click t\1EA1i \0111\00E2y \0111\1EC3 ki\1EC3m tra th\00F4ng tin v\00E0 x\00E1c nh\1EADn c\1EADp nh\1EADt v\00E0o h\1EC7 th\1ED1ng D365 HRM.</p>'';'),
'    v_body := v_body||''<p style=''''color:black''''>Please click Link to review and update information to D365 HRM System.</p>'';',
unistr('    v_body := v_body||''<p style=''''color:black''''>Tr\00E2n tr\1ECDng,</p>'';'),
unistr('    v_body := v_body||''<p style=''''color:black''''>Ph\00F2ng Nh\00E2n s\1EF1 H\00E0nh ch\00EDnh</p>'';'),
'    v_body := v_body||''<p style=''''color:black''''>Best regards,</p>'';',
'    v_body := v_body||''<p style=''''color:black''''>HR & Admin Department </p>'';',
'    -- v_body := v_body||''<img style=''''width:100%'''' src=''''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''''></img>'';',
'',
'-------------------------------------------------------',
'----- Send mail',
'    if is_changed then',
'    -- Send to HRs (for pilot)',
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''phuongpham@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''trang.th@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''hravus@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''haitran@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- send tester',
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''huyen.ptt@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thudang@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thi.tnh@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ngan.tranvu@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin Nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'',
'    -- Send to Devs',
unistr('        -- SP_SENDGRID_EMAIL(''ky.nguyenquoc@vus-etsc.edu.vn'', ''quocky600@gmail.com'', ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin NV ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''ky.nguyenquoc@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''quocky600@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''tranquangkhanh2k1qv@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''khanhnguyendev@vus-etsc.edu.vn'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
unistr('        -- SP_SENDGRID_EMAIL(''VUSERP-PORTAL@vus-etsc.edu.vn'', ''thviet615@gmail.com'' , ''C\1EADp nh\1EADt thay \0111\1ED5i th\00F4ng tin nh\00E2n vi\00EAn ''||:P5_FULL_NAME||'''',v_body);'),
'    end if;',
'end;'))
,p_process_clob_language=>'PLSQL'
,p_process_error_message=>'Error'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8239352126381444)
,p_process_success_message=>'Successfully submitted. HR-Admin department will check and update your information within 3-5 working days!'
,p_internal_uid=>9408740409131431
);
null;
end;
/
begin
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(10004699641336812)
,p_process_sequence=>110
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save ID Number'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    -- begin',
'    -- insert into EMP_ID_NUMBER(ID_NUMBER,ATTACH_FILE,EMPLOYEE_CODE,ATTACH_NAME)',
'    -- values (:P5_ID_PP_NUMBER,:P5_URL,:APP_EMP_CODE,:P5_URL_NAME);',
'    -- end;',
'',
'begin',
'    update EMP_ID_NUMBER',
'    set ATTACH_FILE = :P5_URL,',
'        ATTACH_NAME = :P5_URL_NAME',
'    where ID_NUMBER = :P5_ID_PP_NUMBER',
'      and EMPLOYEE_CODE = :APP_EMP_CODE;',
'end;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8180297924022847)
,p_process_success_message=>'Success'
,p_internal_uid=>10004699641336812
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(10577992532987827)
,p_process_sequence=>120
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save Passport'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'    -- begin',
'    -- insert into EMP_ID_NUMBER(ID_NUMBER,ATTACH_FILE,EMPLOYEE_CODE,ATTACH_NAME)',
'    -- values (:P5_ID_PP_NUMBER,:P5_URL,:APP_EMP_CODE,:P5_URL_NAME);',
'    -- end;',
'',
'begin',
'    update EMP_ID_NUMBER',
'    set ATTACH_FILE = :P5_URL_1,',
'        ATTACH_NAME = :P5_URL_NAME_1',
'    where ID_NUMBER = :P5_ID_PP_NUMBER_1',
'      and EMPLOYEE_CODE = :APP_EMP_CODE and ID_TYPE = 1;',
'end;',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(8923872414040323)
,p_process_success_message=>'Success'
,p_internal_uid=>10577992532987827
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(23665531693578132)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_region_id=>wwv_flow_imp.id(8236520445381416)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'GET_NEXT_EDU_TEMP_ID_SEQ'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  l_next_val NUMBER;',
'BEGIN',
'  SELECT EMP_EDUCATION_SEQ.NEXTVAL INTO l_next_val FROM DUAL;',
'  apex_json.open_object;',
'  apex_json.write(''nextSeqValue'', l_next_val);',
'  apex_json.close_object;',
'  -- Ensure the content type is set to application/json',
'  apex_application.g_unrecoverable_error := true;',
'END;',
''))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>23665531693578132
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24801871113944238)
,p_process_sequence=>20
,p_process_point=>'ON_DEMAND'
,p_region_id=>wwv_flow_imp.id(8236520445381416)
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'GET_NEXT_CERT_TEMP_ID_SEQ'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'  l_next_val NUMBER;',
'BEGIN',
'  SELECT SEQ_CERTIFICATE_TEMP_ID.NEXTVAL INTO l_next_val FROM DUAL;',
'  apex_json.open_object;',
'  apex_json.write(''nextSeqValue'', l_next_val);',
'  apex_json.close_object;',
'  -- Ensure the content type is set to application/json',
'  apex_application.g_unrecoverable_error := true;',
'END;',
''))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>24801871113944238
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(24801211461944232)
,p_process_sequence=>30
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'PREPARE_URL'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'declare',
'    result varchar2(32767);',
'begin',
'    result := apex_util.prepare_url(apex_application.g_x01);',
'    apex_json.open_object;',
'    apex_json.write(''success'', true);',
'    apex_json.write(''url'', result);',
'    apex_json.close_object;',
'exception',
'    when others then',
'        apex_json.open_object;',
'        apex_json.write(''success'', false);',
'        apex_json.write(''message'', sqlerrm);',
'        apex_json.close_object;',
'end;',
''))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>24801211461944232
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
