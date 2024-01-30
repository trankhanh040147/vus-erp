document.addEventListener("DOMContentLoaded", function () {
    var containerEl = document.getElementById("external-events");
    var calendarEl = document.getElementById("calendar");
    async function callApi(apiUrl) {
        try {
            const response = await fetch(apiUrl);
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            const data = await response.json();
            return data; // Return the data
        } catch (error) {
            console.error("Error fetching data:", error);
            throw error;
        }
    }
    async function fetchData(apiUrl) {
        try {
            const response = await callApi(apiUrl);
            return response.items;
        } catch (error) {
            console.error("Error fetching data:", error);
            return null; // or handle the error as appropriate
        }
    }

    function convertHtmlEncodedJson(jsonString) {
        const decodedJsonString = jsonString.replace(/&quot;/g, '"');
        try {
            return JSON.parse(decodedJsonString);
        } catch (error) {
            console.error("Error parsing JSON:", error);
            return null;
        }
    }
    function getRandomHexColor() {
        var randomColor = Math.floor(Math.random() * 16777215).toString(16);
        while (randomColor.length < 6) {
            randomColor = "0" + randomColor;
        }
        return randomColor;
    }

    function getTimePeriodValue(timeString) {
        if (timeString == "18:00:00-24:00:00") {
            return 3;
        } else if (timeString == "12:00:00-18:00:00") {
            return 2;
        } else if (timeString == "06:00:00-12:00:00") {
            return 1;
        }
    }
    function transformResourceData(jsonData, type) {
        if (type == "id") {
            return jsonData.map((item) => item.employee_code);
        }
        return jsonData.map((item) => ({
            id: item.employee_code,
            fId: item.employee_code,
            lName: item.employee_fullname,
        }));
    }
    function handleDatesSet() {
        const elements = document.querySelectorAll(
            ".fc-timeline-slot-cushion.fc-scrollgrid-sync-inner"
        );
        elements.forEach(function (element) {
            const text = element.textContent;
            if (text === "06") {
                element.textContent = "SĂ¡ng";
            } else if (text === "12") {
                element.textContent = "Chiá»u";
            } else if (text === "18") {
                element.textContent = "Tá»‘i";
            }
        });
    }
    function adjustStartTime(startTime) {
        if (startTime >= "06:00:00" && startTime <= "12:00:00") {
            return "06:00:00";
        } else if (startTime > "12:00:00" && startTime <= "18:00:00") {
            return "12:00:01";
        } else if (startTime > "18:00:00" && startTime <= "24:00:00") {
            return "18:00:00";
        }
        // Handle any other cases here
        return startTime;
    }
    function adjustBrokeStartTime(startTime) {
        if (startTime >= "06:00:00" && startTime <= "12:00:00") {
            return "06:00:00";
        } else if (startTime > "12:00:00" && startTime <= "18:00:00") {
            return "12:00:01";
        } else if (startTime > "18:00:00" && startTime <= "24:00:00") {
            return "18:00:00";
        }
        // Handle any other cases here
        return startTime;
    }

    function adjustEndTime(endTime) {
        if (endTime >= "06:00:00" && endTime <= "12:00:00") {
            return "12:00:00";
        } else if (endTime > "12:00:00" && endTime <= "18:00:00") {
            return "18:00:00";
        } else if (endTime > "18:00:00" && endTime <= "24:00:00") {
            return "24:00:00";
        }
        // Handle any other cases here
        return endTime;
    }
    function adjustBrokeEndTime(endTime) {
        if (endTime >= "06:00:00" && endTime <= "18:00:00") {
            return "18:00:00";
        } else if (endTime > "18:00:00" && endTime <= "24:00:00") {
            return "24:00:00";
        }
        return endTime;
    }
    function convertTo12HourFormat(time) {
        var timeParts = time.split(":");
        var hours = parseInt(timeParts[0]);
        if (hours > 12) {
            hours -= 12;
        }
        var formattedTime = hours.toString().padStart(2, "0") + ":" + timeParts[1];
        return formattedTime;
    }
    const inputProfileTimes = document.getElementById("P43_PROFILE_LINES");
    const inputValueProfileTimes = inputProfileTimes.value;
    const jsonObjectProfileTimes = convertHtmlEncodedJson(inputValueProfileTimes);
    async function useData() {
        const data = await fetchData(
            "https://erp-uat.vus.edu.vn/ords/erp/calendar/items/"
        );

        if (data) {
            var Calendar = FullCalendar.Calendar;
            const jsonObjectCalendarItems = data;
            const uniqueArray = jsonObjectCalendarItems.filter(
                (item, index, self) =>
                    self.findIndex((i) => i.employee_code === item.employee_code) ===
                    index
            );
            const resourcesData = transformResourceData(uniqueArray, "all");
            const resourcesID = transformResourceData(uniqueArray, "id");
            const dataEvents = generateNewCalendarItems(jsonObjectCalendarItems);
            const currentEvt = document.getElementById("current-evt");

            var calendar = new Calendar(calendarEl, {
                editable: false,
                droppable: true,
                datesAboveResources: true,
                timeZone: "Asia/Ho_Chi_Minh",
                initialView: "resourceTimelineWeek",
                locale: "vi",
                height: "auto",
                contentHeight: "auto",
                slotDuration: "6:00:00",
                slotMinTime: "06:00:00",
                snapDuration: "06:00:00",
                slotMaxTime: "24:00:00",
                datesSet: handleDatesSet,
                resources: resourcesData,
                events: dataEvents,
                resourceAreaColumns: [
                    {
                        field: "fId",
                        headerContent: "ID",
                    },
                    {
                        field: "lName",
                        headerContent: "Full name",
                    },
                ],
                headerToolbar: {
                    left: "prev,next",
                    center: "title",
                },
                views: {
                    resourceTimelineWeek: {
                        type: "resourceDayGrid",
                        duration: { week: 1 },
                        buttonText: "4 days",
                    },
                },
                eventClick: function (info) {
                    var event = info.event;
                    var dataId_new = info.el
                        .querySelector(".event-calendar")
                        .getAttribute("id")
                        .split("-")[1];
                    const infoTimeLine = event._def.extendedProps.time_line;
                    const color = event._def.extendedProps.color;
                    const title = event._def.extendedProps.title;
                    const startTime = event._def.extendedProps.startTime;
                    const endTime = event._def.extendedProps.endTime;
                    const wpl_id = event._def.extendedProps.wpl_id;
                    const date = event._def.extendedProps.date;
                    const employCode = info.event._def.resourceIds[0];
                    const dataId =
                        info.event._def.publicId != ""
                            ? info.event._def.publicId
                            : dataId_new;
                    const infoEvtElement = document.getElementById(
                        `${employCode}-${wpl_id}`
                    );
                    const evt_description =
                        infoEvtElement.textContent != "" ? infoEvtElement.textContent : "";
                    buttonAddEvent.setAttribute("ID", dataId);
                    buttonAddEvent.setAttribute("EMPLOYEE_CODE", employCode);
                    buttonAddEvent.setAttribute("DATE", date);
                    buttonAddEvent.setAttribute("PROFILE_ID", title);
                    buttonAddEvent.setAttribute("LINE_REC_ID", wpl_id);
                    buttonAddEvent.setAttribute("TIMELINE", `${startTime}-${endTime}`);
                    buttonAddEvent.setAttribute("COLOR", color);

                    buttonDeleteDate.setAttribute("ID", dataId);
                    buttonDeleteDate.setAttribute("EMPLOYEE_CODE", employCode);
                    buttonDeleteDate.setAttribute("DATE", date);
                    buttonDeleteDate.setAttribute("PROFILE_ID", title);
                    buttonDeleteDate.setAttribute("LINE_REC_ID", wpl_id);
                    buttonDeleteDate.setAttribute("TIMELINE", `${startTime}-${endTime}`);
                    buttonDeleteDate.setAttribute("COLOR", color);

                    currentEvt.innerHTML = evt_description;
                    buttonAddEvent.addEventListener("click", function (evt) {
                        event.setProp("classNames", ["fa fa-star"]);
                    });
                },
                eventContent: function (info) {
                    function getRandomInteger(max) {
                        const randomNumber = Math.floor(Math.random() * (max + 5));
                        return `new_${randomNumber}`;
                    }
                    const dataIdRandom = getRandomInteger(100);
                    const data_info_title = info.event._def.title;
                    var dataId =
                        info.event._def.publicId != ""
                            ? info.event._def.publicId
                            : dataIdRandom;
                    var doubleTime = "";

                    if (data_info_title.includes("doubleTime")) {
                        var wpl_id_double = info.event._def.extendedProps.wpl_id
                            .split(";")
                            .join("-");
                        doubleTime = `doubleTime_${info.event._def.resourceIds[0]}_${info.event._def.extendedProps.date}_${wpl_id_double}`;
                    }
                    const infoStartTime = info.event._def.extendedProps.startTime;
                    const infoEndTime = info.event._def.extendedProps.endTime;
                    const title = info.event._def.extendedProps.title;
                    const color = info.event._def.extendedProps.color;
                    const evt_description =
                        info.event._def.extendedProps.evt_description ?? "";
                    const idTag = `${info.event._def.resourceIds[0]}-${info.event._def.extendedProps.wpl_id}`;
                    const classHasEvent =
                        evt_description != "" && evt_description != null
                            ? `fa fa-star`
                            : "";
                    return {
                        html: `<div id="evt-${dataId}" class="event-calendar ${classHasEvent} ${doubleTime}" data-toggle="modal" data-target="#exampleModal" style="background-color:#${color}"><p>${title}</p><p>${infoStartTime}-${infoEndTime}</p><div class="info-evt" id="${idTag}" style="display:none">${evt_description}</div></div>`,
                    };
                },
                eventReceive: function (info) {
                    const originalEvent = info.event;
                    const infoTimeLine = info.event._def.extendedProps.time_line;
                    const timePeriods = infoTimeLine.split(";");
                    const infoWplId = info.event._def.extendedProps.wpl_id;
                    const infoTitle = info.event._def.extendedProps.title;
                    const employCode = info.event._def.resourceIds[0];
                    const dataId = info.event._def.publicId;
                    const color = info.event._def.extendedProps.color;
                    const startDate = info.event.start;
                    const day = startDate.getDate();
                    const month = startDate.getMonth() + 1;
                    const year = startDate.getFullYear();
                    function convertDay(day) {
                        if (day <= 9) {
                            return `0${day}`;
                        }
                        return day;
                    }
                    let time_line = [];
                    if (timePeriods.length == 1) {
                        timePeriods.forEach(function (timePeriod) {
                            const newTime = timePeriod.split("-");
                            let newStartDateTime;
                            let newEndDateTime;
                            let newStartTime;
                            let newEndTime;
                            for (let i = 0; i < newTime.length; i++) {
                                if (i == 0) {
                                    newStartTime = newTime[i] + ":00";
                                    newStartDateTime = `${year}-${convertDay(month)}-${convertDay(
                                        day
                                    )}T${adjustStartTime(newTime[i] + ":00")}`;
                                }
                                if (i == 1) {
                                    newEndTime = newTime[i] + ":00";
                                    newEndDateTime = `${year}-${convertDay(month)}-${convertDay(
                                        day
                                    )}T${adjustEndTime(newTime[i] + ":00")}`;
                                }
                            }
                            time_line.push(`${newStartTime}-${newEndTime}`);
                            console.log({
                                id: "",
                                title: info.event._def.extendedProps.title,
                                start: newStartDateTime,
                                end: newEndDateTime,
                                resourceId: employCode,
                                extendedProps: {
                                    startTime: newStartTime,
                                    endTime: newEndTime,
                                    title: infoTitle,
                                    wpl_id: infoWplId,
                                    color: color,
                                    date: `${year}-${month}-${convertDay(day)}`,
                                },
                            });
                            calendar.addEvent({
                                id: "",
                                title: info.event._def.extendedProps.title,
                                start: newStartDateTime,
                                end: newEndDateTime,
                                resourceId: employCode,
                                extendedProps: {
                                    startTime: newStartTime,
                                    endTime: newEndTime,
                                    title: infoTitle,
                                    wpl_id: infoWplId,
                                    color: color,
                                    date: `${year}-${month}-${convertDay(day)}`,
                                },
                            });
                        });
                    }
                    if (timePeriods.length == 2) {
                        timePeriods.forEach(function (timePeriod) {
                            const newTime = timePeriod.split("-");
                            let newStartDateTime;
                            let newEndDateTime;
                            let newStartTime;
                            let newEndTime;
                            for (let i = 0; i < newTime.length; i++) {
                                if (i == 0) {
                                    newStartTime = newTime[0] + ":00";
                                    newStartDateTime = `${year}-${convertDay(month)}-${convertDay(
                                        day
                                    )}T${adjustStartTime(newTime[0] + ":00")}`;
                                }
                                if (i == 1) {
                                    newEndTime = newTime[1] + ":00";
                                    newEndDateTime = `${year}-${convertDay(month)}-${convertDay(
                                        day
                                    )}T${adjustEndTime(newTime[1] + ":00")}`;
                                }
                                if (newTime[1] > "18:00" && newTime[0] > "12:00") {
                                    newStartTime = newTime[0] + ":00";
                                    newStartDateTime = `${year}-${convertDay(month)}-${convertDay(
                                        day
                                    )}T${adjustStartTime("19:00:00")}`;
                                    newEndTime = newTime[1] + ":00";
                                    newEndDateTime = `${year}-${convertDay(month)}-${convertDay(
                                        day
                                    )}T${adjustEndTime("24:00:00")}`;
                                }
                            }
                            time_line.push(`${newStartTime}-${newEndTime}`);
                            calendar.addEvent({
                                id: "",
                                // title: info.event._def.extendedProps.title,
                                title: `${info.event._def.extendedProps.title}-doubleTime`,
                                start: newStartDateTime,
                                end: newEndDateTime,
                                resourceId: employCode,
                                extendedProps: {
                                    startTime: newStartTime,
                                    endTime: newEndTime,
                                    title: infoTitle,
                                    wpl_id: infoWplId,
                                    color: color,
                                    date: `${year}-${month}-${convertDay(day)}`,
                                },
                            });
                        });
                    }
                    originalEvent.remove();
                    const combinedString = time_line.join(";");
                    const dataObject = {
                        ID: dataId,
                        EMPLOYEE_CODE: employCode,
                        DATE: `${year}-${month}-${convertDay(day)}`,
                        PROFILE_ID: infoTitle,
                        LINE_REC_ID: infoWplId,
                        TIMELINE: combinedString,
                        COLOR: color,
                        EVENT_DESCRIPTION: "",
                    };
                    var curent_data_import = apex.item("P43_IMPORT_DATA").getValue();
                    if (curent_data_import == "") {
                        dataImport = [];
                    } else {
                        dataImport = JSON.parse(curent_data_import);
                    }
                    if (dataId === "") {
                        dataImport.push(dataObject);
                    } else {
                        const existingDataIndex = dataImport.findIndex(
                            (item) => item.ID === dataId
                        );
                        if (existingDataIndex !== -1) {
                            dataImport[existingDataIndex] = dataObject;
                        } else {
                            dataImport.push(dataObject);
                        }
                    }
                    apex.item("P43_IMPORT_DATA").setValue(JSON.stringify(dataImport));
                },
                eventDrop: function (info) { },
            });

            calendar.render();
        }
    }
    useData();

    function generateNewCalendarItems(inputArray) {
        let newArrayObjects = [];
        inputArray.forEach(function (item) {
            const defineBrokeTime = item.timeline.split(";");
            if (defineBrokeTime.length > 1) {
                defineBrokeTime.forEach(function (timePeriod) {
                    const newTime = timePeriod.split("-");
                    let newStartDateTime;
                    let newEndDateTime;
                    let newStartTime;
                    let newEndTime;
                    for (let i = 0; i < newTime.length; i++) {
                        if (newTime[0] > "12:00:00" && newTime[1] > "18:00:00") {
                            newStartTime = newTime[0];
                            newStartDateTime = `${item.date}T${adjustStartTime("19:00:00")}`;
                            newEndTime = newTime[1];
                            newEndDateTime = `${item.date}T${adjustEndTime("24:00:00")}`;
                        }
                        if (i == 0) {
                            newStartTime = newTime[0];
                            newStartDateTime = `${item.date}T${adjustStartTime(newTime[0])}`;
                        }
                        if (i == 1) {
                            newEndTime = newTime[1];
                            newEndDateTime = `${item.date}T${adjustEndTime(newTime[1])}`;
                        }
                    }

                    const newObject = {
                        id: item.id,
                        title: item.profile_id,
                        start: newStartDateTime,
                        end: newEndDateTime,
                        resourceId: item.employee_code,
                        extendedProps: {
                            startTime: newStartTime,
                            endTime: newEndTime,
                            title: item.profile_id,
                            wpl_id: item.line_rec_id,
                            color: item.color ?? getRandomHexColor(),
                            date: item.date,
                            evt_description: item.event_description ?? "",
                        },
                    };
                    newArrayObjects.push(newObject);
                });
            } else {
                defineBrokeTime.forEach(function (timePeriod) {
                    const newTime = timePeriod.split("-");
                    let newStartDateTime;
                    let newEndDateTime;
                    let newStartTime;
                    let newEndTime;
                    for (let i = 0; i < newTime.length; i++) {
                        if (i == 0) {
                            newStartTime = newTime[0];
                            newStartDateTime = `${item.date}T${adjustStartTime(newTime[0])}`;
                        }
                        if (i == 1) {
                            newEndTime = newTime[1];
                            newEndDateTime = `${item.date}T${adjustEndTime(newTime[1])}`;
                        }
                    }
                    const newObject = {
                        id: item.id,
                        title: item.profile_id,
                        start: newStartDateTime,
                        end: newEndDateTime,
                        resourceId: item.employee_code,
                        extendedProps: {
                            startTime: newStartTime,
                            endTime: newEndTime,
                            title: item.profile_id,
                            wpl_id: item.line_rec_id,
                            color: item.color ?? getRandomHexColor(),
                            date: item.date,
                            evt_description: item.event_description ?? "",
                        },
                    };
                    newArrayObjects.push(newObject);
                });
            }
        });
        return newArrayObjects;
    }
    var Draggable = FullCalendar.Draggable;

    new Draggable(containerEl, {
        itemSelector: ".fc-event-main",
        eventData: function (eventEl) {
            return {
                title: eventEl.innerText,
                extendedProps: {
                    title: eventEl.getAttribute("title"),
                    time_line: eventEl.getAttribute("time-line"),
                    wpl_id: eventEl.getAttribute("attr-id"),
                    color: eventEl.getAttribute("attr-color"),
                },
            };
        },
    });

    function createEventElement(eventData) {
        const eventDiv = document.createElement("div");
        const Color =
            eventData.COLOR == "0" ? getRandomHexColor() : eventData.COLOR;
        eventDiv.className =
            "fc-event fc-h-event fc-daygrid-event fc-daygrid-block-event";
        eventDiv.innerHTML = `<div attr-id="${eventData.WPL_ID}"title="${eventData.PROFILE_ID}"class='fc-event-main' time-line="${eventData.TIMELINE}" style="background:#${Color};" attr-color="${Color}"><p>${eventData.PROFILE_ID}</p><p>${eventData.TIMELINE}</p></div>`;
        return eventDiv;
    }

    function renderEvents(eventData) {
        const eventContainer = document.getElementById("external-events");
        eventData.forEach((eventData) => {
            const eventElement = createEventElement(eventData);
            eventContainer.appendChild(eventElement);
        });
    }
    renderEvents(jsonObjectProfileTimes);

    // let dataImport = JSON.parse(apex.item("P43_IMPORT_DATA").getValue());
    let dataImport = [];
    let dataRemove = [];
    const inputModal = document.querySelector("#modal-content input");
    const buttonAddEvent = document.querySelector("#modal-content div.close");
    const buttonDeleteDate = document.querySelector(
        "#modal-content div.close.delete-date"
    );
    // button click delete element date
    buttonDeleteDate.addEventListener("click", function (evt) {
        var ID = buttonAddEvent.getAttribute("ID");
        const EMPLOYEE_CODE = buttonAddEvent.getAttribute("employee_code");
        const DATE = buttonAddEvent.getAttribute("date");
        const PROFILE_ID = buttonAddEvent.getAttribute("profile_id");
        const LINE_REC_ID = buttonAddEvent.getAttribute("line_rec_id");
        const TIMELINE = buttonAddEvent.getAttribute("timeline");
        const COLOR = buttonAddEvent.getAttribute("color");
        const EVENT_DESCRIPTION = "";

        const elements = document.querySelectorAll(`#evt-${ID}`);
        var classesWithDoubleTime = "";
        Array.from(elements).forEach((element) => {
            const classList = Array.from(element.classList);
            classesWithDoubleTime = classList.filter((className) =>
                className.includes("doubleTime")
            );
        });
        var classNameDoubleTime = classesWithDoubleTime[0];
        var elementDoubleTime = document.querySelectorAll(
            `.${classNameDoubleTime}`
        );
        console.log(classNameDoubleTime);
        if (elementDoubleTime.length > 0) {
            for (var i = 0; i < elementDoubleTime.length; i++) {
                console.log(elementDoubleTime[i]);
                elementDoubleTime[i].style.display = "none";
            }
        }
        elements.forEach(function (el, index) {
            el.style.display = "none";
        });
        if (ID.startsWith("new")) {
            // dataRemove.push('');
            ID = "";
        } else {
            dataRemove.push(ID);
        }
        apex.item("P43_REMOVE_DATA").setValue(JSON.stringify(dataRemove));
        const data_remove_single = {
            ID,
            EMPLOYEE_CODE,
            DATE,
            PROFILE_ID,
            LINE_REC_ID,
            TIMELINE,
            COLOR,
            EVENT_DESCRIPTION,
        };
        var data_double_time = "";
        var employCode_double_time = "";
        var date_double_time = "";
        var lineRecId_double_time = "";
        if (classNameDoubleTime != undefined) {
            var data_double_time = classNameDoubleTime.split("_");
            var employCode_double_time = data_double_time[1];
            var date_double_time = data_double_time[2];
            var lineRecId_double_time = data_double_time[3].split("-").join(";");
        }

        var data_import = apex.item("P43_IMPORT_DATA").getValue();
        data_import = JSON.parse(data_import);
        for (var i = 0; i < data_import.length; i++) {
            var currentItem = data_import[i];
            console.log(currentItem);
            // KiĂ¡Â»Æ’m tra xem phĂ¡ÂºÂ§n tĂ¡Â»Â­ hiĂ¡Â»â€¡n tĂ¡ÂºÂ¡i cÄ‚Â³ trÄ‚Â¹ng vĂ¡Â»â€ºi data_remove_single khÄ‚Â´ng
            if (
                currentItem.ID == data_remove_single.ID &&
                currentItem.EMPLOYEE_CODE == data_remove_single.EMPLOYEE_CODE &&
                currentItem.DATE == data_remove_single.DATE &&
                currentItem.PROFILE_ID == data_remove_single.PROFILE_ID &&
                currentItem.LINE_REC_ID == data_remove_single.LINE_REC_ID &&
                currentItem.TIMELINE == data_remove_single.TIMELINE &&
                currentItem.COLOR == data_remove_single.COLOR
                // currentItem.EVENT_DESCRIPTION === data_remove_single.EVENT_DESCRIPTION
            ) {
                // NĂ¡ÂºÂ¿u trÄ‚Â¹ng, xÄ‚Â³a phĂ¡ÂºÂ§n tĂ¡Â»Â­ khĂ¡Â»Âi mĂ¡ÂºÂ£ng
                data_import.splice(i, 1);
                i--; // GiĂ¡ÂºÂ£m giÄ‚Â¡ trĂ¡Â»â€¹ cĂ¡Â»Â§a i Ă„â€˜Ă¡Â»Æ’ kiĂ¡Â»Æ’m tra phĂ¡ÂºÂ§n tĂ¡Â»Â­ tiĂ¡ÂºÂ¿p theo
            } else if (
                currentItem.EMPLOYEE_CODE == employCode_double_time &&
                currentItem.DATE == date_double_time &&
                currentItem.LINE_REC_ID == lineRecId_double_time
            ) {
                // NĂ¡ÂºÂ¿u trÄ‚Â¹ng, xÄ‚Â³a phĂ¡ÂºÂ§n tĂ¡Â»Â­ khĂ¡Â»Âi mĂ¡ÂºÂ£ng
                data_import.splice(i, 1);
                i--; // GiĂ¡ÂºÂ£m giÄ‚Â¡ trĂ¡Â»â€¹ cĂ¡Â»Â§a i Ă„â€˜Ă¡Â»Æ’ kiĂ¡Â»Æ’m tra phĂ¡ÂºÂ§n tĂ¡Â»Â­ tiĂ¡ÂºÂ¿p theo
            }
        }
        apex.item("P43_IMPORT_DATA").setValue(JSON.stringify(data_import));
    });
    buttonAddEvent.addEventListener("click", function (evt) {
        console.log(evt);
        const ID = buttonAddEvent.getAttribute("ID");
        const EMPLOYEE_CODE = buttonAddEvent.getAttribute("EMPLOYEE_CODE");
        const DATE = buttonAddEvent.getAttribute("DATE");
        const PROFILE_ID = buttonAddEvent.getAttribute("PROFILE_ID");
        const LINE_REC_ID = buttonAddEvent.getAttribute("LINE_REC_ID");
        const TIMELINE = buttonAddEvent.getAttribute("TIMELINE");
        const COLOR = buttonAddEvent.getAttribute("COLOR");
        const EVENT_DESCRIPTION = inputModal.value;

        const dataObject = {
            ID,
            EMPLOYEE_CODE,
            DATE,
            PROFILE_ID,
            LINE_REC_ID,
            TIMELINE,
            COLOR,
            EVENT_DESCRIPTION,
        };
        setText(EMPLOYEE_CODE, LINE_REC_ID);
        console.log(dataImport);
        const existingIndex = dataImport.findIndex(
            (existingObject) =>
                existingObject.EMPLOYEE_CODE === dataObject.EMPLOYEE_CODE &&
                existingObject.DATE === dataObject.DATE &&
                existingObject.PROFILE_ID === dataObject.PROFILE_ID &&
                existingObject.LINE_REC_ID === dataObject.LINE_REC_ID &&
                existingObject.TIMELINE === dataObject.TIMELINE &&
                existingObject.COLOR === dataObject.COLOR
        );
        if (existingIndex !== -1) {
            dataImport[existingIndex].EVENT_DESCRIPTION =
                dataObject.EVENT_DESCRIPTION;
        } else {
            dataImport.push(dataObject);
        }
        inputModal.value = "";
        apex.item("P43_IMPORT_DATA").setValue(JSON.stringify(dataImport));
        // console.log(dataImport);
    });

    function setText(EMPLOYEE_CODE, LINE_REC_ID) {
        const infoEvtElement = document.getElementById(
            `${EMPLOYEE_CODE}-${LINE_REC_ID}`
        );
        infoEvtElement.innerHTML = inputModal.value;
    }

    function removeAllChildren(container) {
        while (container.firstChild) {
            container.removeChild(container.firstChild);
        }
    }
    const inputProfile = document.getElementById("P43_SEARCH_PROFILE");
    const filterProfilesButton = document.querySelector("#filter-profiles");
    inputProfile.addEventListener("input", function () {
        setTimeout(function () {
            const inputValue = inputProfile.value;
            const eventContainer = document.getElementById("external-events");
            const inputProfileTimes = document.getElementById(
                "P43_PROFILE_LINES_FILTER"
            );
            const inputValueProfileTimes = inputProfileTimes.value;
            const jsonObjectProfileTimesFilter =
                convertHtmlEncodedJson(inputValueProfileTimes) ?? [];
            removeAllChildren(eventContainer);
            renderEvents(jsonObjectProfileTimesFilter);

        }, 500);
    });
    var closeButton = document.querySelector(".page-43 .close.delete-date");

    if (closeButton) {
        closeButton.addEventListener("click", function () {
            var eventCalendars = document.querySelectorAll(".event-calendar");

            eventCalendars.forEach(function (eventCalendar) {
                var computedStyle = window.getComputedStyle(eventCalendar);
                if (computedStyle.display === "none") {
                    var closestEventEnd = eventCalendar.closest(
                        ".fc-timeline-event.fc-event-end"
                    );
                    if (closestEventEnd) {
                        closestEventEnd.style.display = "none";
                    }
                }
            });
        });
    }

});
