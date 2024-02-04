// Util functions
function handleDeleteClick(event, formData, fileArrayNames, fileArrayUrls) {
    if (event.target.classList.contains("delete-item")) {
        const itemToRemove = event.target.closest("div");
        const name = event.target.dataset.name;
        const url = itemToRemove.querySelector("a").getAttribute("href");
        const files = formData.getAll("files");
        const updatedFiles = files.filter((file) => file.name !== name);
        formData.delete("files");
        fileArrayNames = fileArrayNames.filter((item) => item !== name);
        fileArrayUrls = fileArrayNames.filter((item) => item !== url);
        updatedFiles.forEach((file) => formData.append("files", file));
        if (itemToRemove) {
            itemToRemove.remove();
            document.getElementById("loader-container").style.display = "none";
        }
    }
}
function getCurrentDateFormatted() {
    const currentDate = new Date();

    const day = String(currentDate.getDate()).padStart(2, '0');
    const month = String(currentDate.getMonth() + 1).padStart(2, '0');
    // Months are zero-based, so add 1
    const year = currentDate.getFullYear();

    return `${day}-${month}-${year}`;
}
function deleteValue(formData, key, value) {
    const values = formData.getAll(key);
    const updatedValues = values.filter(v => v !== value);

    // Remove all values associated with the key
    formData.delete(key);

    // Append the updated values back to the FormData object
    updatedValues.forEach(updatedValue => {
        formData.append(key, updatedValue);
    }
    );
}

// BindEvent functions
function BindFileUploadEvent(fileUpload, eleSelector) {

    jQuery('.apex-item-wrapper--file').append('<div class="ATTACH_GROUP t-Form-inputContainer"></div>');

    var imageUrlsID = apex.item(eleSelector.eleDefUrl).getValue();
    var imageNamesID = apex.item(eleSelector.eleDefName).getValue();
    var imageContainer = document.querySelector(eleSelector.eleAttCon + " .ATTACH_GROUP")
    const urlArray = imageUrlsID.split(";");
    const nameArray = imageNamesID.split(";");

    apex.item(eleSelector.eleAttUrl).setValue(imageUrlsID);
    apex.item(eleSelector.eleAttName).setValue(imageNamesID);

    for (let i = 0; i < urlArray.length; i++) {
        const imageUrl = urlArray[i];
        const imageName = nameArray[i];
        fileUpload.fileArrayNames.push(imageName);
        fileUpload.fileArrayUrls.push(imageUrl);
        let hiddenInputHTML;
        if (imageUrl != "" || imageName != "") {
            hiddenInputHTML = `
        <div class="file-item ">
            <span  id="deleteItem${imageName}" data-name="${imageName}" class="delete-item btn-delete vng-true"> X </span>
            <a name="${imageName}" href="${imageUrl}" target="_blank" class="${eleSelector.eleDynamicValue}">
                ${imageName}
            </a>
        </div>
    `;
        } else {
            hiddenInputHTML = ``;
        }
        imageContainer.insertAdjacentHTML("beforeend", hiddenInputHTML);
    }
    var deleteButtons = document.querySelectorAll(".btn-delete");
    deleteButtons.forEach(function (button) {
        button.addEventListener("click", function (event) {
            handleDeleteClick(event, fileUpload.formData, fileUpload.fileArrayNames, fileUpload.fileArrayUrls);
        });
    });

    // Hide delete buttons when STATUS is not DRAFT
    if ($v("P20002_STATUS") != 1) {
        $('.delete-item.btn-delete').hide();
        $('#P20002_ATTACHMENT_inline_help').hide();
    }

    var userName = apex.item(eleSelector.eleEmpName).getValue();
    var userCode = apex.item(eleSelector.eleEmpCode).getValue();

    fileUpload.formData.append("name", userName);
    fileUpload.formData.append("msnv", userCode);
    document
        .getElementById(eleSelector.eleAtt)
        .addEventListener("change", function (event) {
            const imageFiles = event.target.files;
            const hiddenInputContainer = document.querySelector(eleSelector.eleAttCon + " .ATTACH_GROUP");
            const maxFileSize = 1 * 1024 * 1024; // 1MB in bytes

            fileUpload.formData.append("date", getCurrentDateFormatted());
            console.log(getCurrentDateFormatted());

            for (const imageFile of imageFiles) {
                const fileName = imageFile.name;
                const fileURL = URL.createObjectURL(imageFile);
                if (imageFile.size > maxFileSize) {
                    // Show an error message or take appropriate action
                    alert(
                        `File ${fileName} is larger than 1MB. Please choose a smaller file.`
                    );
                    continue; // Skip this file
                }

                fileUpload.formData.append("files", imageFile);

                const hiddenInputHTML = `
        <div class="file-item id-numb-file">
            <a href="${fileURL}" target="_blank">
                ${fileName}
            </a>
            <span id="deleteItem${fileName}" data-name="${fileName}" class="delete-item btn-delete"> X </span>
        </div>
      `;
                hiddenInputContainer.insertAdjacentHTML("beforeend", hiddenInputHTML);
            }
            hiddenInputContainer.addEventListener("click", function (event) {
                handleDeleteClick(event, fileUpload.formData, fileUpload.fileArrayNames, fileUpload.fileArrayUrls);
            });
        });
}

function BindEventSubmitBtn(fileUpload, eleSelector) {
    // Select all buttons by their IDs
    const buttons = document.querySelectorAll('#save_submit_button, #submit_button, #save_button, #update_button');

    // Iterate through the buttons and add click event listeners to each
    buttons.forEach(function (button) {
        button.addEventListener('click', async function (event) {
            // Print btn id
            let apex_id_btn = '';
            // set apex_id_btn = case save_submit_button -> T1_SAVE_SUBMIT, submit_button -> T1_SUBMIT, save_button -> T1_SAVE, update_button -> T1_UPDATE
            switch (this.id) {
                case 'save_submit_button':
                    apex_id_btn = 'T1_SAVE_SUBMIT';
                    break;
                case 'submit_button':
                    apex_id_btn = 'T1_SUBMIT';
                    break;
                case 'save_button':
                    apex_id_btn = 'T1_SAVE';
                    break;
                case 'update_button':
                    apex_id_btn = 'T1_UPDATE';
                    break;
                default:
                    break;
            }
            console.log(apex_id_btn);

            // document
            //     .getElementById(eleSelector.eleBtnSubmit)
            //     .addEventListener("click", async function (event) {
            let nullFormData = false;
            const elements = document.querySelectorAll(".dynamic-value-page");
            const names = [];
            const hrefs = [];
            var imageNamesID = apex.item(eleSelector.eleDefName).getValue();
            const nameArray = imageNamesID.split(";");

            // document.getElementById('loader-container').style.display = 'block';
            for (const value of fileUpload.formData.values()) {
                if (value.name != null) {
                    nullFormData = true;
                }
            }

            if (nullFormData) {
                try {
                    // Set time out 15s
                    const response = await fetch("https://graphapi.vus.edu.vn/upload", {
                        method: "POST",
                        body: fileUpload.formData,
                        timeout: 15000,
                    });

                    if (response.status === 200) {
                        const responseBody = await response.json();
                        fileUpload.filesName = responseBody.data.map((item) => item.name).join(";");
                        fileUpload.filesUrl = responseBody.data.map((item) => item.path).join(";");
                        const newfilesUrl = fileUpload.fileArrayUrls.join(";") + ";" + fileUpload.filesUrl;
                        const newfilesName = fileUpload.fileArrayNames.join(";") + ";" + fileUpload.filesName;
                        await apex.item(eleSelector.eleAttUrl).setValue(newfilesUrl);
                        await apex.item(eleSelector.eleAttName).setValue(newfilesName);
                    } else {
                        console.log("Upload failed");
                    }
                } catch (error) {
                    console.error("An error occurred:", error);
                } finally {
                    document.getElementById("loader-container").style.display = "none";
                    setTimeout(function () {
                        // apex.submit(eleSelector.eleBtnSubmit);
                        apex.submit(apex_id_btn);
                    }, 500);
                }
            } else {
                await elements.forEach((element) => {
                    const name = element.getAttribute("name");
                    const href = element.getAttribute("href");

                    if (name && href) {
                        names.push(name);
                        hrefs.push(href);
                    }
                });
                namesString = names.join(";");
                urlString = hrefs.join(";");
                const missingValuesNameId = await nameArray.filter(
                    (value) => !names.includes(value)
                );
                const urlDelete =
                    "https://graphapi.vus.edu.vn/delete-multiple-objects-vng-cloud";

                const data = {
                    fileNames: missingValuesNameId,
                };

                console.log(missingValuesNameId);
                const requestOptions = {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json",
                    },
                    body: JSON.stringify(data),
                };
                try {
                    await fetch(urlDelete, requestOptions)
                        .then((response) => {
                            if (!response.ok) {
                                throw new Error("Network response was not ok");
                            }
                            return response.json();
                        })
                        .then((data) => {
                            console.log(data);
                        });
                } catch (error) {
                    console.error("Error:", error);
                } finally {
                    document.getElementById("loader-container").style.display = "none";
                }

                await apex.item(eleSelector.eleAttUrl).setValue(urlString);
                await apex.item(eleSelector.eleAttName).setValue(namesString);
                // apex.submit(eleSelector.eleBtnSubmit);
                setTimeout(function () {
                    // apex.submit(eleSelector.eleBtnSubmit);
                    apex.submit(apex_id_btn);
                }, 500);
            }
            document.getElementById("loader-container").style.display = "none";
        });
    })

}

// Create class CustomFileUpload to store all variables
class CustomFileUpload {
    constructor() {
        this.formData = new FormData();
        this.filesName;
        this.filesUrl;
        this.fileArrayNames = [];
        this.fileArrayUrls = [];
    }
}