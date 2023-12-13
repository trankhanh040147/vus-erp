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
--   Date and Time:   16:28 Tuesday December 12, 2023
--   Exported By:     ERP
--   Flashback:       0
--   Export Type:     Page Export
--   Manifest
--     PAGE: 43
--   Manifest End
--   Version:         23.1.5
--   Instance ID:     7949320442804181
--

begin
null;
end;
/
prompt --application/pages/delete_00043
begin
wwv_flow_imp_page.remove_page (p_flow_id=>wwv_flow.g_flow_id, p_page_id=>43);
end;
/
prompt --application/pages/page_00043
begin
wwv_flow_imp_page.create_page(
 p_id=>43
,p_name=>'Working Schedule'
,p_alias=>'WORKING-SCHEDULE'
,p_step_title=>'Working Schedule'
,p_autocomplete_on_off=>'OFF'
,p_html_page_header=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">',
'<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>',
'<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>',
'<script src="https://cdn.jsdelivr.net/npm/fullcalendar-scheduler@6.1.9/index.global.min.js"></script>',
'<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>',
''))
,p_inline_css=>wwv_flow_string.join(wwv_flow_t_varchar2(
'.fc-direction-ltr a.fc-timeline-event.fc-event-end{',
'    height:37px',
'}',
'.option{',
'    cursor: pointer;',
'}',
'.selectOptions{',
'    text-align: center;',
'    width:100%;',
'    height:100%;',
'    position: relative;',
'}',
'select{',
'    color: black',
'}',
'.active-value,',
'.fc-timeline-event .fc-event-main{',
'    height:100%',
'}',
'.fc-direction-ltr a.fc-timeline-event.fc-event-end{',
'    padding:0',
'}',
'.fc-timeline-event-harness{',
'    cursor: pointer;',
'}',
'thead div,',
'thead tr,',
'thead a{',
'    color:black',
'}',
'.fc .fc-button-group > .fc-button{',
'    padding:0;',
'    display:flex;',
'    justify-content: center;',
'    align-items: center;',
'    width:30px;',
'    margin-right:5px    ',
'}',
'/* .fc-timeline-lane.fc-resource{',
'    border: 1px solid rgb(221, 221, 221)',
'} */',
'.fc-event-main{',
'    cursor: pointer;',
'}',
'/* .fc-event.fc-event-draggable.fc-event-resizable.fc-event-start.fc-event-end.fc-event-past.fc-timeline-event.fc-h-event{',
'    background:transparent !important;',
'    background-color:transparent !important;',
'}',
'.page-43 .fc-direction-ltr a.fc-timeline-event.fc-event-end{',
'    border:none;',
'    background-color: transparent !important;',
'} */',
'#external-events .fc-event{',
'    margin-bottom:10px',
'}',
'#external-events .fc-event-main{',
'    display: flex;',
'    align-items: center;',
'    flex-direction: column;',
'}',
'#external-events .fc-event-main p{margin:0 !Important}',
'.fc-event-main >div{',
'    display: flex; height: 100%; width: 100%; flex-direction: column; align-items: center;',
'}',
'.fc-event-main >div >p{',
'    margin:0;',
'    text-align: center;',
'}',
'',
'.fc-event-main >div >p:nth-child(2){',
'    font-size: 10px;',
'}',
'.fc-event.fc-event-start.fc-event-end.fc-event-past.fc-timeline-event.fc-h-event{',
'    border:none!important;',
'    background:transparent !important;',
'}'))
,p_page_template_options=>'#DEFAULT#'
,p_protection_level=>'C'
,p_page_component_map=>'16'
,p_last_updated_by=>'ERP'
,p_last_upd_yyyymmddhh24miss=>'20231130045217'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(14112905306957645)
,p_plug_name=>'Filter Content'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18634318196889013)
,p_plug_display_sequence=>70
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<style>',
'#filterContent{',
'    display:none',
'}',
'</style>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(14740699270795723)
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
 p_id=>wwv_flow_imp.id(14741278004795724)
,p_plug_name=>'Working Schedule'
,p_region_name=>'calendar-custom'
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>90
,p_plug_new_grid_row=>false
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(14974236664135411)
,p_plug_name=>'DISPLAY CALENDAR'
,p_parent_plug_id=>wwv_flow_imp.id(14741278004795724)
,p_plug_display_sequence=>20
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id="calendar"></div>',
'<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">',
'    <div class="modal-dialog">',
'        <div class="modal-content">',
'            <div class="modal-header">',
'                <h5 class="modal-title" id="exampleModalLabel">Enter event</h5>',
'                <button type="button" class="close" data-dismiss="modal" aria-label="Close">',
'                    <span aria-hidden="true">&times;</span>',
'                </button>',
'            </div>',
'            <div class="modal-body" id="modal-content">',
'                <div id="current-evt"></div>',
'                <label for="event-title-star">Event</label>',
'                <input type="text" id="event-title-star">',
'                <div class="row">',
'                    <div class="close" data-dismiss="modal" aria-label="Close">Add event</div>',
'                    <div class="close delete-date" data-dismiss="modal" aria-label="Close">Delete day</div>',
'                </div>',
'                ',
'            </div>',
'        </div>',
'    </div>',
'</div>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(18547654995230309)
,p_plug_name=>'Release 1.0'
,p_parent_plug_id=>wwv_flow_imp.id(14741278004795724)
,p_region_template_options=>'#DEFAULT#:t-Region--scrollBody'
,p_plug_template=>wwv_flow_imp.id(18700356306889064)
,p_plug_display_sequence=>40
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<script>',
'    document.addEventListener("DOMContentLoaded", function () {',
'',
'        var containerEl = document.getElementById("external-events");',
'        var calendarEl = document.getElementById("calendar");',
'        async function callApi(apiUrl) {',
'            try {',
'                const response = await fetch(apiUrl);',
'                if (!response.ok) {',
'                    throw new Error(`HTTP error! status: ${response.status}`);',
'                }',
'                const data = await response.json(); // Convert response to JSON',
'                return data; // Return the data',
'            } catch (error) {',
'                console.error(''Error fetching data:'', error);',
'                throw error; // Re-throw to allow caller to handle it',
'            }',
'        }',
'        async function fetchData(apiUrl) {',
'            try {',
'                const response = await callApi(apiUrl);',
'                return response.items;  // assuming the API returns an object with an ''items'' property',
'            } catch (error) {',
'                console.error(''Error fetching data:'', error);',
'                return null;  // or handle the error as appropriate',
'            }',
'        }',
'',
'        function convertHtmlEncodedJson(jsonString) {',
'            const decodedJsonString = jsonString.replace(/&quot;/g, ''"'');',
'            try {',
'                return JSON.parse(decodedJsonString);',
'            } catch (error) {',
'                console.error("Error parsing JSON:", error);',
'                return null;',
'            }',
'        }',
'        function getRandomHexColor() {',
'            var randomColor = Math.floor(Math.random() * 16777215).toString(16);',
'            while (randomColor.length < 6) {',
'                randomColor = "0" + randomColor;',
'            }',
'            return randomColor;',
'        }',
'',
'        function getTimePeriodValue(timeString) {',
'            if (timeString == "18:00:00-24:00:00") {',
'                return 3;',
'            } else if (timeString == "12:00:00-18:00:00") {',
'                return 2;',
'            } else if (timeString == "06:00:00-12:00:00") {',
'                return 1;',
'            }',
'        }',
'        function transformResourceData(jsonData, type) {',
'            if (type == "id") {',
'                return jsonData.map((item) => item.employee_code);',
'            }',
'            return jsonData.map((item) => ({',
'                id: item.employee_code,',
'                fId: item.employee_code,',
'                lName: item.employee_fullname,',
'            }));',
'        }',
'        function handleDatesSet() {',
'            const elements = document.querySelectorAll(',
'                ".fc-timeline-slot-cushion.fc-scrollgrid-sync-inner"',
'            );',
'            elements.forEach(function (element) {',
'                const text = element.textContent;',
'                if (text === "06") {',
unistr('                    element.textContent = "S\00E1ng";'),
'                } else if (text === "12") {',
unistr('                    element.textContent = "Chi\1EC1u";'),
'                } else if (text === "18") {',
unistr('                    element.textContent = "T\1ED1i";'),
'                }',
'            });',
'        }',
'        function adjustStartTime(startTime) {',
'            if (startTime >= "06:00:00" && startTime <= "12:00:00") {',
'                return "06:00:00";',
'            } else if (startTime > "12:00:00" && startTime <= "18:00:00") {',
'                return "12:00:01";',
'            } else if (startTime > "18:00:00" && startTime <= "24:00:00") {',
'                return "18:00:00";',
'            }',
'            // Handle any other cases here',
'            return startTime;',
'        }',
'        function adjustBrokeStartTime(startTime) {',
'            if (startTime >= "06:00:00" && startTime <= "12:00:00") {',
'                return "06:00:00";',
'            } else if (startTime > "12:00:00" && startTime <= "18:00:00") {',
'                return "12:00:01";',
'            } else if (startTime > "18:00:00" && startTime <= "24:00:00") {',
'                return "18:00:00";',
'            }',
'            // Handle any other cases here',
'            return startTime;',
'        }',
'',
'        function adjustEndTime(endTime) {',
'            if (endTime >= "06:00:00" && endTime <= "12:00:00") {',
'                return "12:00:00";',
'            } else if (endTime > "12:00:00" && endTime <= "18:00:00") {',
'                return "18:00:00";',
'            } else if (endTime > "18:00:00" && endTime <= "24:00:00") {',
'                return "24:00:00";',
'            }',
'            // Handle any other cases here',
'            return endTime;',
'        }',
'        function adjustBrokeEndTime(endTime) {',
'            if (endTime >= "06:00:00" && endTime <= "18:00:00") {',
'                return "18:00:00";',
'            } else if (endTime > "18:00:00" && endTime <= "24:00:00") {',
'                return "24:00:00";',
'            }',
'            return endTime;',
'        }',
'        function convertTo12HourFormat(time) {',
'            var timeParts = time.split(":");',
'            var hours = parseInt(timeParts[0]);',
'            if (hours > 12) {',
'                hours -= 12;',
'            }',
'            var formattedTime =',
'                hours.toString().padStart(2, "0") + ":" + timeParts[1];',
'            return formattedTime;',
'        }',
'        const inputProfileTimes = document.getElementById("P43_PROFILE_LINES");',
'        const inputValueProfileTimes = inputProfileTimes.value;',
'        const jsonObjectProfileTimes = convertHtmlEncodedJson(',
'            inputValueProfileTimes',
'        );',
'        async function useData() {',
'            const data = await fetchData("https://erp-uat.vus.edu.vn/ords/erp/calendar/items/");',
'',
'            if (data) {',
'                console.log(data)',
'                var Calendar = FullCalendar.Calendar;',
'                const jsonObjectCalendarItems = data',
'                const uniqueArray = jsonObjectCalendarItems.filter(',
'                    (item, index, self) =>',
'                        self.findIndex((i) => i.employee_code === item.employee_code) === index',
'                );',
'                const resourcesData = transformResourceData(uniqueArray, "all");',
'                const resourcesID = transformResourceData(uniqueArray, "id");',
'                const dataEvents = generateNewCalendarItems(jsonObjectCalendarItems)',
'                const currentEvt = document.getElementById("current-evt");',
'                console.log(resourcesData)',
'                console.log(dataEvents)',
'                var calendar = new Calendar(calendarEl, {',
'                    editable: false,',
'                    droppable: true,',
'                    datesAboveResources: true,',
'                    timeZone: "Asia/Ho_Chi_Minh",',
'                    initialView: "resourceTimelineWeek",',
'                    locale: "vi",',
'                    height: "auto",',
'                    contentHeight: "auto",',
'                    slotDuration: "6:00:00",',
'                    slotMinTime: "06:00:00",',
'                    snapDuration: "06:00:00",',
'                    slotMaxTime: "24:00:00",',
'                    datesSet: handleDatesSet,',
'                    resources: resourcesData,',
'                    events: dataEvents,',
'                    resourceAreaColumns: [',
'                        {',
'                            field: "fId",',
'                            headerContent: "ID",',
'                        },',
'                        {',
'                            field: "lName",',
'                            headerContent: "Full name",',
'                        },',
'                    ],',
'                    headerToolbar: {',
'                        left: "prev,next",',
'                        center: "title",',
'                    },',
'                    views: {',
'                        resourceTimelineWeek: {',
'                            type: "resourceDayGrid",',
'                            duration: { week: 1 },',
'                            buttonText: "4 days",',
'                        },',
'                    },',
'                    eventClick: function (info) {',
'                        var event = info.event;',
'                        const infoTimeLine = event._def.extendedProps.time_line;',
'                        const color = event._def.extendedProps.color;',
'                        const title = event._def.extendedProps.title;',
'                        const startTime = event._def.extendedProps.startTime;',
'                        const endTime = event._def.extendedProps.endTime;',
'                        const wpl_id = event._def.extendedProps.wpl_id;',
'                        const date = event._def.extendedProps.date;',
'                        const employCode = info.event._def.resourceIds[0];',
'                        const dataId = info.event._def.publicId;',
'                        const infoEvtElement = document.getElementById(',
'                            `${employCode}-${wpl_id}`',
'                        );',
'                        const evt_description =',
'                            infoEvtElement.textContent != "" ? infoEvtElement.textContent : "";',
'                        buttonAddEvent.setAttribute("ID", dataId);',
'                        buttonAddEvent.setAttribute("EMPLOYEE_CODE", employCode);',
'                        buttonAddEvent.setAttribute("DATE", date);',
'                        buttonAddEvent.setAttribute("PROFILE_ID", title);',
'                        buttonAddEvent.setAttribute("LINE_REC_ID", wpl_id);',
'                        buttonAddEvent.setAttribute("TIMELINE", `${startTime}-${endTime}`);',
'                        buttonAddEvent.setAttribute("COLOR", color);',
'',
'                        buttonDeleteDate.setAttribute("ID", dataId);',
'                        buttonDeleteDate.setAttribute("EMPLOYEE_CODE", employCode);',
'                        buttonDeleteDate.setAttribute("DATE", date);',
'                        buttonDeleteDate.setAttribute("PROFILE_ID", title);',
'                        buttonDeleteDate.setAttribute("LINE_REC_ID", wpl_id);',
'                        buttonDeleteDate.setAttribute("TIMELINE", `${startTime}-${endTime}`);',
'                        buttonDeleteDate.setAttribute("COLOR", color);',
'',
'                        currentEvt.innerHTML = evt_description;',
'                        buttonAddEvent.addEventListener("click", function (evt) {',
'                            event.setProp("classNames", ["fa fa-star"]);',
'                        });',
'                    },',
'                    eventContent: function (info) {',
'                        const dataId = info.event._def.publicId;',
'                        const infoStartTime = info.event._def.extendedProps.startTime;',
'                        const infoEndTime = info.event._def.extendedProps.endTime;',
'                        const title = info.event._def.extendedProps.title;',
'                        const color = info.event._def.extendedProps.color;',
'                        const evt_description =',
'                            info.event._def.extendedProps.evt_description ?? "";',
'                        const idTag = `${info.event._def.resourceIds[0]}-${info.event._def.extendedProps.wpl_id}`;',
'                        const classHasEvent =',
'                            evt_description != "" && evt_description != null ? `fa fa-star` : "";',
'                        // console.log(info);',
'                        return {',
'                            html: `<div id="evt-${dataId}" class="event-calendar ${classHasEvent}" data-toggle="modal" data-target="#exampleModal" style="background-color:#${color}"><p>${title}</p><p>${infoStartTime}-${infoEndTime}</p><div class="inf'
||'o-evt" id="${idTag}" style="display:none">${evt_description}</div></div>`,',
'                        };',
'                    },',
'                    eventReceive: function (info) {',
'                        const originalEvent = info.event;',
'                        const infoTimeLine = info.event._def.extendedProps.time_line;',
'                        const timePeriods = infoTimeLine.split(";");',
'                        const infoWplId = info.event._def.extendedProps.wpl_id;',
'                        const infoTitle = info.event._def.extendedProps.title;',
'                        const employCode = info.event._def.resourceIds[0];',
'                        const dataId = info.event._def.publicId;',
'                        const color = info.event._def.extendedProps.color;',
'                        const startDate = info.event.start;',
'                        const day = startDate.getDate();',
'                        const month = startDate.getMonth() + 1;',
'                        const year = startDate.getFullYear();',
'                        function convertDay(day) {',
'                            if (day <= 9) {',
'                                return `0${day}`;',
'                            }',
'                            return day;',
'                        }',
'                        let time_line = [];',
'                        if (timePeriods.length == 1) {',
'                            timePeriods.forEach(function (timePeriod) {',
'                                const newTime = timePeriod.split("-");',
'                                let newStartDateTime;',
'                                let newEndDateTime;',
'                                let newStartTime;',
'                                let newEndTime;',
'                                for (let i = 0; i < newTime.length; i++) {',
'                                    if (i == 0) {',
'                                        newStartTime = newTime[i] + ":00";',
'                                        newStartDateTime = `${year}-${month}-${convertDay(',
'                                            day',
'                                        )}T${adjustStartTime(newTime[i] + ":00")}`;',
'                                    }',
'                                    if (i == 1) {',
'                                        newEndTime = newTime[i] + ":00";',
'                                        newEndDateTime = `${year}-${month}-${convertDay(',
'                                            day',
'                                        )}T${adjustEndTime(newTime[i] + ":00")}`;',
'                                    }',
'                                }',
'                                time_line.push(`${newStartTime}-${newEndTime}`);',
'                                calendar.addEvent({',
'                                    id: "",',
'                                    title: info.event._def.extendedProps.title,',
'                                    start: newStartDateTime,',
'                                    end: newEndDateTime,',
'                                    resourceId: employCode,',
'                                    extendedProps: {',
'                                        startTime: newStartTime,',
'                                        endTime: newEndTime,',
'                                        title: infoTitle,',
'                                        wpl_id: infoWplId,',
'                                        color: color,',
'                                        date: `${year}-${month}-${convertDay(day)}`,',
'                                    },',
'                                });',
'                            });',
'                        }',
'                        if (timePeriods.length == 2) {',
'                            timePeriods.forEach(function (timePeriod) {',
'                                const newTime = timePeriod.split("-");',
'                                let newStartDateTime;',
'                                let newEndDateTime;',
'                                let newStartTime;',
'                                let newEndTime;',
'                                for (let i = 0; i < newTime.length; i++) {',
'                                    if (i == 0) {',
'                                        newStartTime = newTime[0] + ":00";',
'                                        newStartDateTime = `${year}-${month}-${convertDay(',
'                                            day',
'                                        )}T${adjustStartTime(newTime[0] + ":00")}`;',
'                                    }',
'                                    if (i == 1) {',
'                                        newEndTime = newTime[1] + ":00";',
'                                        newEndDateTime = `${year}-${month}-${convertDay(',
'                                            day',
'                                        )}T${adjustEndTime(newTime[1] + ":00")}`;',
'                                    }',
'                                    if (newTime[1] > "18:00" && newTime[0] > "12:00") {',
'                                        newStartTime = newTime[0] + ":00";',
'                                        newStartDateTime = `${year}-${month}-${convertDay(',
'                                            day',
'                                        )}T${adjustStartTime("19:00:00")}`;',
'                                        newEndTime = newTime[1] + ":00";',
'                                        newEndDateTime = `${year}-${month}-${convertDay(',
'                                            day',
'                                        )}T${adjustEndTime("24:00:00")}`;',
'                                    }',
'                                }',
'                                time_line.push(`${newStartTime}-${newEndTime}`);',
'                                calendar.addEvent({',
'                                    id: "",',
'                                    title: info.event._def.extendedProps.title,',
'                                    start: newStartDateTime,',
'                                    end: newEndDateTime,',
'                                    resourceId: employCode,',
'                                    extendedProps: {',
'                                        startTime: newStartTime,',
'                                        endTime: newEndTime,',
'                                        title: infoTitle,',
'                                        wpl_id: infoWplId,',
'                                        color: color,',
'                                        date: `${year}-${month}-${convertDay(day)}`,',
'                                    },',
'                                });',
'                            });',
'                        }',
'                        originalEvent.remove();',
'                        const combinedString = time_line.join(";");',
'                        const dataObject = {',
'                            ID: dataId,',
'                            EMPLOYEE_CODE: employCode,',
'                            DATE: `${year}-${month}-${convertDay(day)}`,',
'                            PROFILE_ID: infoTitle,',
'                            LINE_REC_ID: infoWplId,',
'                            TIMELINE: combinedString,',
'                            COLOR: color,',
'                            EVENT_DESCRIPTION: "",',
'                        };',
'                        if (dataId === "") {',
'                            // ID is empty, add a new entry',
'                            dataImport.push(dataObject);',
'                        } else {',
'                            // Find the index of the existing entry with the same ID',
'                            const existingDataIndex = dataImport.findIndex(',
'                                (item) => item.ID === dataId',
'                            );',
'                            if (existingDataIndex !== -1) {',
'                                // Update the existing entry',
'                                dataImport[existingDataIndex] = dataObject;',
'                            } else {',
'                                // ID doesn''t match any existing entries, add a new one',
'                                dataImport.push(dataObject);',
'                            }',
'                        }',
'                        apex.item("P43_IMPORT_DATA").setValue(JSON.stringify(dataImport));',
'                    },',
'                    eventDrop: function (info) { },',
'                });',
'',
'                calendar.render();',
'            }',
'',
'',
'        }',
'        useData()',
'',
'        function generateNewCalendarItems(inputArray) {',
'            let newArrayObjects = [];',
'            inputArray.forEach(function (item) {',
'                const defineBrokeTime = item.timeline.split(";");',
'                if (defineBrokeTime.length > 1) {',
'                    defineBrokeTime.forEach(function (timePeriod) {',
'                        const newTime = timePeriod.split("-");',
'                        let newStartDateTime;',
'                        let newEndDateTime;',
'                        let newStartTime;',
'                        let newEndTime;',
'                        for (let i = 0; i < newTime.length; i++) {',
'                            if (newTime[0] > "12:00:00" && newTime[1] > "18:00:00") {',
'                                newStartTime = newTime[0];',
'                                newStartDateTime = `${item.date}T${adjustStartTime(',
'                                    "19:00:00"',
'                                )}`;',
'                                newEndTime = newTime[1];',
'                                newEndDateTime = `${item.date}T${adjustEndTime("24:00:00")}`;',
'                            }',
'                            if (i == 0) {',
'                                newStartTime = newTime[0];',
'                                newStartDateTime = `${item.date}T${adjustStartTime(',
'                                    newTime[0]',
'                                )}`;',
'                            }',
'                            if (i == 1) {',
'                                newEndTime = newTime[1];',
'                                newEndDateTime = `${item.date}T${adjustEndTime(newTime[1])}`;',
'                            }',
'                        }',
'',
'                        const newObject = {',
'                            id: item.id,',
'                            title: item.profile_id,',
'                            start: newStartDateTime,',
'                            end: newEndDateTime,',
'                            resourceId: item.employee_code,',
'                            extendedProps: {',
'                                startTime: newStartTime,',
'                                endTime: newEndTime,',
'                                title: item.profile_id,',
'                                wpl_id: item.line_rec_id,',
'                                color: item.color ?? getRandomHexColor(),',
'                                date: item.date,',
'                                evt_description: item.event_description ?? "",',
'                            },',
'                        };',
'                        newArrayObjects.push(newObject);',
'                    });',
'                } else {',
'                    defineBrokeTime.forEach(function (timePeriod) {',
'                        const newTime = timePeriod.split("-");',
'                        let newStartDateTime;',
'                        let newEndDateTime;',
'                        let newStartTime;',
'                        let newEndTime;',
'                        for (let i = 0; i < newTime.length; i++) {',
'                            if (i == 0) {',
'                                newStartTime = newTime[0];',
'                                newStartDateTime = `${item.date}T${adjustStartTime(',
'                                    newTime[0]',
'                                )}`;',
'                            }',
'                            if (i == 1) {',
'                                newEndTime = newTime[1];',
'                                newEndDateTime = `${item.date}T${adjustEndTime(newTime[1])}`;',
'                            }',
'                        }',
'                        const newObject = {',
'                            id: item.id,',
'                            title: item.profile_id,',
'                            start: newStartDateTime,',
'                            end: newEndDateTime,',
'                            resourceId: item.employee_code,',
'                            extendedProps: {',
'                                startTime: newStartTime,',
'                                endTime: newEndTime,',
'                                title: item.profile_id,',
'                                wpl_id: item.line_rec_id,',
'                                color: item.color ?? getRandomHexColor(),',
'                                date: item.date,',
'                                evt_description: item.event_description ?? "",',
'                            },',
'                        };',
'                        newArrayObjects.push(newObject);',
'                    });',
'                }',
'            });',
'            return newArrayObjects;',
'        }',
'        var Draggable = FullCalendar.Draggable;',
'',
'        new Draggable(containerEl, {',
'            itemSelector: ".fc-event-main",',
'            eventData: function (eventEl) {',
'                return {',
'                    title: eventEl.innerText,',
'                    extendedProps: {',
'                        title: eventEl.getAttribute("title"),',
'                        time_line: eventEl.getAttribute("time-line"),',
'                        wpl_id: eventEl.getAttribute("attr-id"),',
'                        color: eventEl.getAttribute("attr-color"),',
'                    },',
'                };',
'            },',
'        });',
'',
'        function createEventElement(eventData) {',
'            const eventDiv = document.createElement("div");',
'            const Color =',
'                eventData.COLOR == "0" ? getRandomHexColor() : eventData.COLOR;',
'            eventDiv.className =',
'                "fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event";',
'            eventDiv.innerHTML = `<div attr-id="${eventData.WPL_ID}"title="${eventData.PROFILE_ID}"class=''fc-event-main'' time-line="${eventData.TIMELINE}" style="background:#${Color};" attr-color="${Color}"><p>${eventData.PROFILE_ID}</p><p>${eventDat'
||'a.TIMELINE}</p></div>`;',
'            return eventDiv;',
'        }',
'',
'        function renderEvents(eventData) {',
'            const eventContainer = document.getElementById("external-events");',
'            eventData.forEach((eventData) => {',
'                const eventElement = createEventElement(eventData);',
'                eventContainer.appendChild(eventElement);',
'            });',
'        }',
'        renderEvents(jsonObjectProfileTimes);',
'',
'        let dataImport = [];',
'        let dataRemove = [];',
'        const inputModal = document.querySelector("#modal-content input");',
'        const buttonAddEvent = document.querySelector("#modal-content div.close");',
'        const buttonDeleteDate = document.querySelector("#modal-content div.close.delete-date");',
'        buttonDeleteDate.addEventListener("click", function (evt) {',
'            const ID = buttonAddEvent.getAttribute("ID");',
'            const elements = document.querySelectorAll(`#evt-${ID}`);',
'            elements.forEach(function (el, index) {',
'                el.style.display = "none"',
'            })',
'            dataRemove.push(ID)',
'            apex.item("P43_REMOVE_DATA").setValue(JSON.stringify(dataRemove));',
'            console.log(ID);',
'        })',
'        buttonAddEvent.addEventListener("click", function (evt) {',
'            const ID = buttonAddEvent.getAttribute("ID");',
'            const EMPLOYEE_CODE = buttonAddEvent.getAttribute("EMPLOYEE_CODE");',
'            const DATE = buttonAddEvent.getAttribute("DATE");',
'            const PROFILE_ID = buttonAddEvent.getAttribute("PROFILE_ID");',
'            const LINE_REC_ID = buttonAddEvent.getAttribute("LINE_REC_ID");',
'            const TIMELINE = buttonAddEvent.getAttribute("TIMELINE");',
'            const COLOR = buttonAddEvent.getAttribute("COLOR");',
'            const EVENT_DESCRIPTION = inputModal.value;',
'',
'            const dataObject = {',
'                ID,',
'                EMPLOYEE_CODE,',
'                DATE,',
'                PROFILE_ID,',
'                LINE_REC_ID,',
'                TIMELINE,',
'                COLOR,',
'                EVENT_DESCRIPTION,',
'            };',
'            setText(EMPLOYEE_CODE, LINE_REC_ID);',
'            const existingIndex = dataImport.findIndex(',
'                (existingObject) =>',
'                    existingObject.EMPLOYEE_CODE === dataObject.EMPLOYEE_CODE &&',
'                    existingObject.DATE === dataObject.DATE &&',
'                    existingObject.PROFILE_ID === dataObject.PROFILE_ID &&',
'                    existingObject.LINE_REC_ID === dataObject.LINE_REC_ID &&',
'                    existingObject.TIMELINE === dataObject.TIMELINE &&',
'                    existingObject.COLOR === dataObject.COLOR',
'            );',
'            if (existingIndex !== -1) {',
'                dataImport[existingIndex].EVENT_DESCRIPTION =',
'                    dataObject.EVENT_DESCRIPTION;',
'            } else {',
'                dataImport.push(dataObject);',
'            }',
'            inputModal.value = "";',
'            apex.item("P43_IMPORT_DATA").setValue(JSON.stringify(dataImport));',
'            console.log(dataImport);',
'        });',
'',
'        function setText(EMPLOYEE_CODE, LINE_REC_ID) {',
'            const infoEvtElement = document.getElementById(',
'                `${EMPLOYEE_CODE}-${LINE_REC_ID}`',
'            );',
'            infoEvtElement.innerHTML = inputModal.value;',
'        }',
'',
'        function removeAllChildren(container) {',
'            while (container.firstChild) {',
'                container.removeChild(container.firstChild);',
'            }',
'        }',
'        const inputProfile = document.getElementById("P43_SEARCH_PROFILE");',
'        inputProfile.addEventListener("input", function () {',
'            const inputValue = inputProfile.value;',
'            const eventContainer = document.getElementById("external-events");',
'            const inputProfileTimes = document.getElementById(',
'                "P43_PROFILE_LINES_FILTER"',
'            );',
'            const inputValueProfileTimes = inputProfileTimes.value;',
'            const jsonObjectProfileTimesFilter =',
'                convertHtmlEncodedJson(inputValueProfileTimes) ?? [];',
'            removeAllChildren(eventContainer);',
'            renderEvents(jsonObjectProfileTimesFilter);',
'        });',
'    });',
'</script>'))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
end;
/
begin
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(18492693541148026)
,p_plug_name=>'profile_list'
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18690518860889053)
,p_plug_display_sequence=>80
,p_plug_grid_column_span=>1
,p_prn_units=>'INCHES'
,p_prn_paper_size=>'LETTER'
,p_prn_width=>11
,p_prn_height=>8.5
,p_prn_orientation=>'HORIZONTAL'
,p_prn_page_header=>'profile_list'
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
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_plug(
 p_id=>wwv_flow_imp.id(19001543624440202)
,p_plug_name=>'External-events'
,p_parent_plug_id=>wwv_flow_imp.id(18492693541148026)
,p_region_template_options=>'#DEFAULT#'
,p_plug_template=>wwv_flow_imp.id(18637118701889022)
,p_plug_display_sequence=>30
,p_plug_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'<div id=''external-events''>',
'</div>',
''))
,p_attribute_01=>'N'
,p_attribute_02=>'HTML'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(18491964086148019)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(14112905306957645)
,p_button_name=>'Reset'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Reset'
,p_button_execute_validations=>'N'
,p_grid_new_row=>'N'
,p_grid_column=>7
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(18706014808964720)
,p_button_sequence=>30
,p_button_plug_id=>wwv_flow_imp.id(14741278004795724)
,p_button_name=>'Save'
,p_button_static_id=>'save-btn'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Save'
,p_grid_new_row=>'Y'
,p_grid_row_css_classes=>'_row-save-btn'
);
wwv_flow_imp_page.create_page_button(
 p_id=>wwv_flow_imp.id(14113208633957648)
,p_button_sequence=>40
,p_button_plug_id=>wwv_flow_imp.id(14112905306957645)
,p_button_name=>'Search'
,p_button_action=>'SUBMIT'
,p_button_template_options=>'#DEFAULT#:t-Button--iconLeft'
,p_button_template_id=>wwv_flow_imp.id(18773349465889123)
,p_button_is_hot=>'Y'
,p_button_image_alt=>'Search'
,p_button_execute_validations=>'N'
,p_grid_new_row=>'N'
,p_grid_column=>8
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(14113083297957646)
,p_name=>'P43_EMPLOYEE_NAME'
,p_item_sequence=>10
,p_item_plug_id=>wwv_flow_imp.id(14112905306957645)
,p_pre_element_text=>'Employee Name'
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
 p_id=>wwv_flow_imp.id(14113146435957647)
,p_name=>'P43_PROFILE_TIME'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(14112905306957645)
,p_item_default=>'na'
,p_pre_element_text=>'Profile Time'
,p_display_as=>'NATIVE_POPUP_LOV'
,p_lov=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT PROFILE_ID, PROFILE_ID as ID',
'FROM WORKING_PROFILE WP',
'WHERE lower(WP.PROFILE_ID) NOT LIKE ''%test%''',
'AND lower(WP.PROFILE_ID) NOT LIKE ''%nam%'';'))
,p_lov_display_null=>'YES'
,p_lov_null_text=>'ALL'
,p_lov_null_value=>'na'
,p_cSize=>30
,p_begin_on_new_line=>'N'
,p_colspan=>3
,p_field_template=>wwv_flow_imp.id(18770793693889114)
,p_item_template_options=>'#DEFAULT#'
,p_lov_display_extra=>'YES'
,p_attribute_01=>'POPUP'
,p_attribute_02=>'FIRST_ROWSET'
,p_attribute_03=>'N'
,p_attribute_04=>'N'
,p_attribute_05=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(18492566103148025)
,p_name=>'P43_PROFILE_LINES'
,p_item_sequence=>40
,p_use_cache_before_default=>'NO'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- SELECT JSON_ARRAYAGG(',
'--   JSON_OBJECT(',
'--     ''WPL_ID'' VALUE WPL.LINE_REC_ID,',
'--     ''COLOR'' VALUE WP.COLOR,',
'--     ''PROFILE_ID'' VALUE WPL.PROFILE_ID,',
'--     ''START_TIME'' VALUE WPL.START_TIME,',
'--     ''END_TIME'' VALUE WPL.END_TIME',
'--   )',
'-- ) AS json_data',
'-- FROM WORKING_PROFILE_LINES WPL',
'-- JOIN WORKING_PROFILE WP ON WPL.PROFILE_ID = WP.PROFILE_ID',
'-- -- WHERE lower(WP.PROFILE_ID) NOT LIKE ''%test%''',
'-- -- AND lower(WP.PROFILE_ID) NOT LIKE ''%nam%''',
'-- AND (WPL.START_DAY = 2 AND WPL.END_DAY = 2 AND WPL.DAY_OF_WEEK = 2)',
'-- AND wpl.PROFILE_TYPE_ID = ''standardtime'';',
'',
'SELECT JSON_ARRAYAGG(',
'  JSON_OBJECT(',
'    ''WPL_ID'' VALUE STV.LINE_REC_IDS,',
'    ''COLOR'' VALUE WP.COLOR,',
'    ''PROFILE_ID'' VALUE STV.PROFILE_ID,',
'    ''TIMELINE'' VALUE STV.TIMELINE',
'    -- ''START_TIME'' VALUE WPL.START_TIME,',
'    -- ''END_TIME'' VALUE WPL.END_TIME',
'  )',
') AS json_data',
'FROM STANDARDTIME_VIEW STV',
'JOIN WORKING_PROFILE WP ON STV.PROFILE_ID = WP.PROFILE_ID',
'-- WHERE lower(WP.PROFILE_ID) NOT LIKE ''%test%''',
'-- AND lower(WP.PROFILE_ID) NOT LIKE ''%nam%''',
'AND (STV.START_DAY = 2 AND STV.END_DAY = 2 AND STV.DAY_OF_WEEK = 2)',
'AND STV.PROFILE_TYPE_ID = ''standardtime'';'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(19001442124440201)
,p_name=>'P43_IMPORT_DATA'
,p_data_type=>'CLOB'
,p_item_sequence=>10
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(19352407684421107)
,p_name=>'P43_SEARCH_PROFILE'
,p_item_sequence=>20
,p_item_plug_id=>wwv_flow_imp.id(18492693541148026)
,p_placeholder=>'Profile time'
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
 p_id=>wwv_flow_imp.id(19354421186421127)
,p_name=>'P43_PROFILE_LINES_FILTER'
,p_item_sequence=>60
,p_use_cache_before_default=>'NO'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- SELECT JSON_ARRAYAGG(',
'--   JSON_OBJECT(',
'--     ''WPL_ID'' VALUE WPL.LINE_REC_ID,',
'--     ''COLOR'' VALUE WP.COLOR,',
'--     ''PROFILE_ID'' VALUE WPL.PROFILE_ID,',
'--     ''START_TIME'' VALUE WPL.START_TIME,',
'--     ''END_TIME'' VALUE WPL.END_TIME',
'--   )',
'-- ) AS json_data',
'-- FROM WORKING_PROFILE_LINES WPL',
'-- JOIN WORKING_PROFILE WP ON WPL.PROFILE_ID = WP.PROFILE_ID',
'-- -- WHERE lower(WP.PROFILE_ID) NOT LIKE ''%test%''',
'-- -- AND lower(WP.PROFILE_ID) NOT LIKE ''%nam%''',
'-- AND (WPL.START_DAY = 2 AND WPL.END_DAY = 2 AND WPL.DAY_OF_WEEK = 2)',
'-- AND wpl.PROFILE_TYPE_ID = ''standardtime'';',
'',
'SELECT JSON_ARRAYAGG(',
'  JSON_OBJECT(',
'    ''WPL_ID'' VALUE STV.LINE_REC_IDS,',
'    ''COLOR'' VALUE WP.COLOR,',
'    ''PROFILE_ID'' VALUE STV.PROFILE_ID,',
'    ''TIMELINE'' VALUE STV.TIMELINE',
'    -- ''START_TIME'' VALUE WPL.START_TIME,',
'    -- ''END_TIME'' VALUE WPL.END_TIME',
'  )',
') AS json_data',
'FROM STANDARDTIME_VIEW STV',
'JOIN WORKING_PROFILE WP ON STV.PROFILE_ID = WP.PROFILE_ID',
'-- WHERE lower(WP.PROFILE_ID) NOT LIKE ''%test%''',
'-- AND lower(WP.PROFILE_ID) NOT LIKE ''%nam%''',
'AND (STV.START_DAY = 2 AND STV.END_DAY = 2 AND STV.DAY_OF_WEEK = 2)',
'AND STV.PROFILE_TYPE_ID = ''standardtime'';'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(20704118181292506)
,p_name=>'P43_WORKING_SCHEDULE_EVENT'
,p_data_type=>'CLOB'
,p_item_sequence=>50
,p_use_cache_before_default=>'NO'
,p_source=>wwv_flow_string.join(wwv_flow_t_varchar2(
'SELECT JSON_ARRAYAGG(',
'  JSON_OBJECT(',
'    ''EVENT_ID'' VALUE WSE.ID,',
'    ''WS_ID'' VALUE WSE.WS_ID,',
'    ''EVENT_DESCRIPTION'' VALUE WSE.DESCRIPTION',
'  )',
') AS json_data',
'FROM WORKING_SCHEDULE_EVENTS WSE'))
,p_source_type=>'QUERY'
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(20708356722292548)
,p_name=>'P43_EVENT_DATA'
,p_data_type=>'CLOB'
,p_item_sequence=>30
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_item(
 p_id=>wwv_flow_imp.id(25950909634067401)
,p_name=>'P43_REMOVE_DATA'
,p_data_type=>'CLOB'
,p_item_sequence=>20
,p_display_as=>'NATIVE_HIDDEN'
,p_is_persistent=>'N'
,p_attribute_01=>'N'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(18493356395148033)
,p_name=>'ON_CHANGE'
,p_event_sequence=>10
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P43_PROFILE_SELECT'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'change'
);
wwv_flow_imp_page.create_page_da_event(
 p_id=>wwv_flow_imp.id(19352783745421110)
,p_name=>'Typing'
,p_event_sequence=>20
,p_triggering_element_type=>'ITEM'
,p_triggering_element=>'P43_SEARCH_PROFILE'
,p_bind_type=>'bind'
,p_execution_type=>'IMMEDIATE'
,p_bind_event_type=>'keyup'
,p_display_when_type=>'REQUEST_EQUALS_CONDITION'
,p_display_when_cond=>'hidden'
);
wwv_flow_imp_page.create_page_da_action(
 p_id=>wwv_flow_imp.id(19352874024421111)
,p_event_id=>wwv_flow_imp.id(19352783745421110)
,p_event_result=>'TRUE'
,p_action_sequence=>10
,p_execute_on_page_init=>'N'
,p_name=>'Reload list'
,p_action=>'NATIVE_SET_VALUE'
,p_affected_elements_type=>'ITEM'
,p_affected_elements=>'P43_PROFILE_LINES_FILTER'
,p_attribute_01=>'SQL_STATEMENT'
,p_attribute_03=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- SELECT JSON_ARRAYAGG(',
'--   JSON_OBJECT(',
'--     ''WP_ID'' VALUE WP.ID,',
'--     ''WPL_ID'' VALUE WPL.ID,',
'--     ''COLOR'' VALUE WP.COLOR,',
'--     ''PROFILE_ID'' VALUE WPL.PROFILE_ID,',
'--     ''START_TIME'' VALUE WPL.START_TIME,',
'--     ''END_TIME'' VALUE WPL.END_TIME',
'--   )',
'-- ) AS json_data',
'-- FROM WORKING_PROFILE_LINES WPL',
'-- JOIN WORKING_PROFILE WP ON WPL.PROFILE_ID = WP.PROFILE_ID',
'-- WHERE lower(WP.PROFILE_ID) NOT LIKE ''%test%''',
'-- AND lower(WP.PROFILE_ID) NOT LIKE ''%nam%''',
'-- AND lower(WP.PROFILE_ID) LIKE ''%'' || LOWER(TRIM(:P43_SEARCH_PROFILE)) || ''%'';',
'',
'SELECT JSON_ARRAYAGG(',
'  JSON_OBJECT(',
'    ''WPL_ID'' VALUE WPL.LINE_REC_ID,',
'    ''COLOR'' VALUE WP.COLOR,',
'    ''PROFILE_ID'' VALUE WPL.PROFILE_ID,',
'    ''START_TIME'' VALUE WPL.START_TIME,',
'    ''END_TIME'' VALUE WPL.END_TIME',
'  )',
') AS json_data',
'FROM WORKING_PROFILE_LINES WPL',
'JOIN WORKING_PROFILE WP ON WPL.PROFILE_ID = WP.PROFILE_ID',
'WHERE lower(WP.PROFILE_ID) NOT LIKE ''%test%''',
'AND lower(WP.PROFILE_ID) NOT LIKE ''%nam%''',
'AND (WPL.START_DAY = 2 AND WPL.END_DAY = 2 AND WPL.DAY_OF_WEEK = 2)',
'AND lower(WP.PROFILE_ID) LIKE ''%'' || LOWER(TRIM(:P43_SEARCH_PROFILE)) || ''%''',
'AND wpl.PROFILE_TYPE_ID = ''standardtime'';'))
,p_attribute_07=>'P43_SEARCH_PROFILE'
,p_attribute_08=>'N'
,p_attribute_09=>'Y'
,p_wait_for_result=>'Y'
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(18706166527964721)
,p_process_sequence=>10
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Save data'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'-- declare',
'--     l_numrows number;',
'--     id_rec number;',
'-- begin',
'--     APEX_JSON.PARSE(:P43_IMPORT_DATA); ',
'--     l_numrows := APEX_JSON.get_count(p_path => ''.'');',
'    ',
'--     if l_numrows > 0 then',
'--         FOR i IN 1 .. l_numrows',
'--         LOOP',
'--             id_rec := to_number(APEX_JSON.get_varchar2(p_path => ''[%d].ID'', p0 => i));',
'            ',
'--             IF id_rec is not null and id_rec > 0 THEN',
'--                 UPDATE WORKING_SCHEDULE',
'--                 SET ',
'--                     EMPLOYEE_CODE = APEX_JSON.get_varchar2(p_path => ''[%d].EMPLOYEE_CODE'', p0 => i),',
'--                     WS_DATE = to_date(APEX_JSON.get_varchar2(p_path => ''[%d].DATE'', p0 => i), ''YYYY-MM-DD''),',
'--                     PROFILE_ID = APEX_JSON.get_varchar2(p_path => ''[%d].PROFILE_ID'', p0 => i),',
'--                     LINE_REC_ID = APEX_JSON.get_varchar2(p_path => ''[%d].LINE_REC_ID'', p0 => i),',
'--                     -- START_TIME =  SUBSTR(APEX_JSON.get_varchar2(p_path => ''[%d].START_TIME'', p0 => i), 1, 5),',
'--                     -- END_TIME = SUBSTR(APEX_JSON.get_varchar2(p_path => ''[%d].END_TIME'', p0 => i), 1, 5),',
'--                     TIMELINE = APEX_JSON.get_varchar2(p_path => ''[%d].TIMELINE'', p0 => i),',
'--                     COLOR = APEX_JSON.get_varchar2(p_path => ''[%d].COLOR'', p0 => i)',
'--                 WHERE ID = id_rec;',
'--             ELSE',
'--                 insert into WORKING_SCHEDULE (',
'--                     EMPLOYEE_CODE,',
'--                     WS_DATE,',
'--                     PROFILE_ID,',
'--                     LINE_REC_ID,',
'--                     TIMELINE,',
'--                     COLOR',
'--                 )',
'--                 values (',
'--                     APEX_JSON.get_varchar2(p_path => ''[%d].EMPLOYEE_CODE'', p0 => i),',
'--                     to_date(APEX_JSON.get_varchar2(p_path => ''[%d].DATE'', p0 => i), ''YYYY-MM-DD''),',
'--                     APEX_JSON.get_varchar2(p_path => ''[%d].PROFILE_ID'', p0 => i),',
'--                     APEX_JSON.get_varchar2(p_path => ''[%d].LINE_REC_ID'', p0 => i),',
'--                     APEX_JSON.get_varchar2(p_path => ''[%d].TIMELINE'', p0 => i),',
'--                     APEX_JSON.get_varchar2(p_path => ''[%d].COLOR'', p0 => i)',
'--                 );',
'--             end if;',
'--         end loop;',
'--     end if;',
'-- end;',
'',
'-- declare',
'-- l_numrows number;',
'-- begin',
'-- APEX_JSON.PARSE(:P43_IMPORT_DATA); ',
'--     l_numrows := APEX_JSON.get_count (p_path => ''.'');',
'--     if l_numrows > 0 then',
'--         FOR i IN 1 .. l_numrows   ',
'--         LOOP',
'--             insert into',
'--                 WORKING_SCHEDULE (',
'--                     EMPLOYEE_CODE,',
'--                     WS_DATE,',
'--                     PROFILE_ID,',
'--                     LINE_REC_ID,',
'--                     START_TIME,',
'--                     END_TIME',
'--                 )',
'--             values',
'--                 (',
'--                     APEX_JSON.get_varchar2(''[%d].EMPLOYEE_CODE'', i),',
'--                     to_date(APEX_JSON.get_varchar2(''[%d].DATE'', i),''YYYY-MM-DD''),',
'--                     APEX_JSON.get_varchar2(''[%d].PROFILE_ID'', i),',
'--                     APEX_JSON.get_varchar2(''[%d].LINE_REC_ID'', i),',
'--                     APEX_JSON.get_varchar2(''[%d].START_TIME'', i),',
'--                     APEX_JSON.get_varchar2(''[%d].END_TIME'', i)',
'--                 );',
'--         end loop;',
'--     end if;',
'-- end;',
'',
'declare',
'    l_numrows number;',
'    id_rec number;',
'    id_event number;',
'begin',
'    APEX_JSON.PARSE(:P43_IMPORT_DATA); ',
'    l_numrows := APEX_JSON.get_count(p_path => ''.'');',
'    ',
'    if l_numrows > 0 then',
'        FOR i IN 1 .. l_numrows',
'        LOOP',
'            id_rec := to_number(APEX_JSON.get_varchar2(p_path => ''[%d].ID'', p0 => i));',
'',
'            id_event := to_number(APEX_JSON.get_varchar2(p_path => ''[%d].WS_ID'', p0 => i));',
'            ',
'            IF id_rec is not null and id_rec > 0 THEN',
'                UPDATE WORKING_SCHEDULE',
'                SET ',
'                    EMPLOYEE_CODE = APEX_JSON.get_varchar2(p_path => ''[%d].EMPLOYEE_CODE'', p0 => i),',
'                    WS_DATE = to_date(APEX_JSON.get_varchar2(p_path => ''[%d].DATE'', p0 => i), ''YYYY-MM-DD''),',
'                    PROFILE_ID = APEX_JSON.get_varchar2(p_path => ''[%d].PROFILE_ID'', p0 => i),',
'                    LINE_REC_ID = APEX_JSON.get_varchar2(p_path => ''[%d].LINE_REC_ID'', p0 => i),',
'                    -- START_TIME =  SUBSTR(APEX_JSON.get_varchar2(p_path => ''[%d].START_TIME'', p0 => i), 1, 5),',
'                    -- END_TIME = SUBSTR(APEX_JSON.get_varchar2(p_path => ''[%d].END_TIME'', p0 => i), 1, 5),',
'                    TIMELINE = APEX_JSON.get_varchar2(p_path => ''[%d].TIMELINE'', p0 => i),',
'                    COLOR = APEX_JSON.get_varchar2(p_path => ''[%d].COLOR'', p0 => i),',
'                    EVENT_DESCRIPTION = APEX_JSON.get_varchar2(p_path => ''[%d].EVENT_DESCRIPTION'', p0 => i)',
'                WHERE ID = id_rec;',
'            ELSE',
'                insert into WORKING_SCHEDULE (',
'                    EMPLOYEE_CODE,',
'                    WS_DATE,',
'                    PROFILE_ID,',
'                    LINE_REC_ID,',
'                    TIMELINE,',
'                    COLOR,',
'                    EVENT_DESCRIPTION',
'                )',
'                values (',
'                    APEX_JSON.get_varchar2(p_path => ''[%d].EMPLOYEE_CODE'', p0 => i),',
'                    to_date(APEX_JSON.get_varchar2(p_path => ''[%d].DATE'', p0 => i), ''YYYY-MM-DD''),',
'                    APEX_JSON.get_varchar2(p_path => ''[%d].PROFILE_ID'', p0 => i),',
'                    APEX_JSON.get_varchar2(p_path => ''[%d].LINE_REC_ID'', p0 => i),',
'                    APEX_JSON.get_varchar2(p_path => ''[%d].TIMELINE'', p0 => i),',
'                    APEX_JSON.get_varchar2(p_path => ''[%d].COLOR'', p0 => i),',
'                    APEX_JSON.get_varchar2(p_path => ''[%d].EVENT_DESCRIPTION'', p0 => i)',
'                );',
'            end if;',
'',
'            -- IF id_event is not null and id_event > 0 THEN',
'            --     UPDATE WORKING_SCHEDULE_EVENTS',
'            --     SET ',
'            --         WS_ID = TO_NUMBER(APEX_JSON.get_varchar2(p_path => ''[%d].WS_ID'', p0 => i)),',
'            --         DESCRIPTION = APEX_JSON.get_varchar2(p_path => ''[%d].EVENT_DESCRIPTION'', p0 => i)',
'            --     WHERE ID = id_event;',
'            -- ELSE',
'            --     insert into WORKING_SCHEDULE_EVENTS (',
'            --         WS_ID,',
'            --         DESCRIPTION',
'            --     )',
'            --     values (',
'            --         TO_NUMBER(APEX_JSON.get_varchar2(p_path => ''[%d].WS_ID'', p0 => i)),',
'            --         APEX_JSON.get_varchar2(p_path => ''[%d].EVENT_DESCRIPTION'', p0 => i)',
'            --     );',
'            -- end if;',
'',
'            -- $(''#P43_REMOVE_DATA'').val()',
'            -- ''["332","331"]''',
'            -- delete from WORKING_SCHEDULE where ID in p43_remove_data;',
'',
'        end loop;',
'    end if;',
'',
'    APEX_JSON.PARSE(:P43_REMOVE_DATA);',
'    l_numrows := APEX_JSON.get_count(p_path => ''.'');',
'    if l_numrows > 0 then',
'        FOR i IN 1 .. l_numrows',
'        LOOP',
'            id_rec := to_number(APEX_JSON.get_varchar2(p_path => ''[%d]'', p0 => i));',
'            delete from WORKING_SCHEDULE where ID = id_rec;',
'        end loop;',
'    end if;',
'end;',
'',
''))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(18706014808964720)
,p_process_success_message=>'Saved!'
,p_internal_uid=>18706166527964721
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(18492275376148022)
,p_process_sequence=>20
,p_process_point=>'AFTER_SUBMIT'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'Reset '
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'BEGIN',
'    :P43_EMPLOYEE_NAME := '''';',
'    :P43_PROFILE_TIME := '''';',
'END;'))
,p_process_clob_language=>'PLSQL'
,p_error_display_location=>'INLINE_IN_NOTIFICATION'
,p_process_when_button_id=>wwv_flow_imp.id(18491964086148019)
,p_internal_uid=>18492275376148022
);
wwv_flow_imp_page.create_page_process(
 p_id=>wwv_flow_imp.id(18494354163148043)
,p_process_sequence=>10
,p_process_point=>'ON_DEMAND'
,p_process_type=>'NATIVE_PLSQL'
,p_process_name=>'GET_PROFILE_LINES'
,p_process_sql_clob=>wwv_flow_string.join(wwv_flow_t_varchar2(
'DECLARE',
'   l_cursor SYS_REFCURSOR;',
'BEGIN',
'   -- Initialize the JSON output',
'   APEX_JSON.initialize_clob_output;',
'   ',
'   -- Open the cursor',
'   OPEN l_cursor FOR',
'      SELECT ID, START_TIME, END_TIME ',
'      FROM WORKING_PROFILE_LINES ',
'      WHERE PROFILE_ID = APEX_APPLICATION.G_X01;',
'',
'   -- Convert cursor data to JSON format',
'   APEX_JSON.open_object; -- Open the main JSON object',
'   APEX_JSON.write(''data'', l_cursor); -- Write cursor data as ''data'' array in JSON',
'   APEX_JSON.close_object; -- Close the main JSON object',
'',
'   -- Fetch the JSON output',
'   HTP.p(APEX_JSON.get_clob_output);',
'',
'   -- Close JSON output and free memory',
'   APEX_JSON.free_output;',
'END;',
''))
,p_process_clob_language=>'PLSQL'
,p_internal_uid=>18494354163148043
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
