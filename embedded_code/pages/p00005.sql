-- --------------------------------------------------------------------------------
-- 
-- Oracle APEX source export file
-- 
-- The contents of this file are intended for review and analysis purposes only.
-- Developers must use the Application Builder to make modifications to an
-- application. Changes to this file will not be reflected in the application.
-- 
-- --------------------------------------------------------------------------------

-- ----------------------------------------
-- Page: 5 - Personal Information > Region: Degree > Source > SQL Query

SELECT 
    edu.ID,
    edu.EMPLOYEE_ID,
    edu.TYPE,
    edu.LEVEL_OF_EDU,
    edu.MAJOR,
    edu.PLACE,
    edu.GRADUATED_DATE,
    edu.ATTACH_FILE,
    edu.EMPLOYEE_CODE,
    --IS_DEL,
    --EXPIRATION_DATE,
    --EFFECTIVE_DATE,
    '#' as Action,
    '<span><i class="fa fa-upload"></span>' as Upload,
    TO_HREF_HTML_ATTACHMENT(edu.ATTACH_URL, edu.ATTACH_NAME) as edu_attachment,
    edu.TEMP_ID
from EMP_EDUCATION edu where edu.EMPLOYEE_CODE = :APP_EMP_CODE and edu.IS_DEL = 0
/*
INNER JOIN 
  EMPLOYEES e ON edu.EMPLOYEE_CODE = e.EMPLOYEE_CODE
WHERE e.USER_NAME = :APP_USER_NAME and edu.IS_DEL = 0
*/;

-- ----------------------------------------
-- Page: 5 - Personal Information > Region: Other Certificates > Column: CERTIFICATE_TYPE > List of Values > SQL Query

SELECT LCT_CERTIFICATE_DESCRIPTION, LCT_HCM_CERTIFICATE_TYPE_ID AS ID from LIST_CERTIFICATE_TYPE;

-- ----------------------------------------
-- Page: 5 - Personal Information > Region: Degree > Column: PLACE > List of Values > SQL Query

select LEI_NAME_OF_SCHOOL, LEI_NAME_OF_SCHOOL as ID from LIST_EDUCATION_INSTITUTION;

-- ----------------------------------------
-- Page: 5 - Personal Information > Region: Degree > Column: LEVEL_OF_EDU > List of Values > SQL Query

SELECT LEV_DESCRIPTION, LEV_DESCRIPTION as ID FROM LIST_EDUCATION_LEVEL;

-- ----------------------------------------
-- Page: 5 - Personal Information > Process: GET_NEXT_CERT_TEMP_ID_SEQ > Source > PL/SQL Code

DECLARE
  l_next_val NUMBER;
BEGIN
  SELECT SEQ_CERTIFICATE_TEMP_ID.NEXTVAL INTO l_next_val FROM DUAL;
  apex_json.open_object;
  apex_json.write('nextSeqValue', l_next_val);
  apex_json.close_object;
  -- Ensure the content type is set to application/json
  apex_application.g_unrecoverable_error := true;
END;


-- ----------------------------------------
-- Page: 5 - Personal Information > Process: PREPARE_URL > Source > PL/SQL Code

declare
    result varchar2(32767);
begin
    result := apex_util.prepare_url(apex_application.g_x01);
    apex_json.open_object;
    apex_json.write('success', true);
    apex_json.write('url', result);
    apex_json.close_object;
exception
    when others then
        apex_json.open_object;
        apex_json.write('success', false);
        apex_json.write('message', sqlerrm);
        apex_json.close_object;
end;


-- ----------------------------------------
-- Page: 5 - Personal Information > Process: GET_NEXT_EDU_TEMP_ID_SEQ > Source > PL/SQL Code

DECLARE
  l_next_val NUMBER;
BEGIN
  SELECT EMP_EDUCATION_SEQ.NEXTVAL INTO l_next_val FROM DUAL;
  apex_json.open_object;
  apex_json.write('nextSeqValue', l_next_val);
  apex_json.close_object;
  -- Ensure the content type is set to application/json
  apex_application.g_unrecoverable_error := true;
END;


-- ----------------------------------------
-- Page: 5 - Personal Information > Process: Save Passport > Source > PL/SQL Code

    -- begin
    -- insert into EMP_ID_NUMBER(ID_NUMBER,ATTACH_FILE,EMPLOYEE_CODE,ATTACH_NAME)
    -- values (:P5_ID_PP_NUMBER,:P5_URL,:APP_EMP_CODE,:P5_URL_NAME);
    -- end;

begin
    update EMP_ID_NUMBER
    set ATTACH_FILE = :P5_URL_1,
        ATTACH_NAME = :P5_URL_NAME_1
    where ID_NUMBER = :P5_ID_PP_NUMBER_1
      and EMPLOYEE_CODE = :APP_EMP_CODE and ID_TYPE = 1;
end;


-- ----------------------------------------
-- Page: 5 - Personal Information > Process: Save ID Number > Source > PL/SQL Code

    -- begin
    -- insert into EMP_ID_NUMBER(ID_NUMBER,ATTACH_FILE,EMPLOYEE_CODE,ATTACH_NAME)
    -- values (:P5_ID_PP_NUMBER,:P5_URL,:APP_EMP_CODE,:P5_URL_NAME);
    -- end;

begin
    update EMP_ID_NUMBER
    set ATTACH_FILE = :P5_URL,
        ATTACH_NAME = :P5_URL_NAME
    where ID_NUMBER = :P5_ID_PP_NUMBER
      and EMPLOYEE_CODE = :APP_EMP_CODE;
end;


-- ----------------------------------------
-- Page: 5 - Personal Information > Process: Send email change info tab Education certificates > Source > PL/SQL Code

declare
    v_body clob:='';
    is_changed boolean := false;
    -- biến để kiểm tra đoạn json
    o_id number;
    o_certificate_type nvarchar2(100);
    o_start_date nvarchar2(50);
    temp_start date;
    o_end_date nvarchar2(50);
    temp_end date;
    o_short_note nvarchar2(100);
    o_attach_name nvarchar2(2000);
    o_attach_url nvarchar2(5000);

    l_numrows number;
    
    old_string apex_t_number;      -- BẢNG CŨ (JSON)
    new_string apex_t_number;      -- BẢNG MỚI

    add_ids apex_t_number;      -- BẢNG ADD
    delete_ids apex_t_number;       -- BẢNG DELETE
    current_ids apex_t_number;       -- BẢNG id không đổi, dùng để kiểm tra dữ liệu update

    n_start_date nvarchar2(50); 
    n_end_date nvarchar2(50);
    n_certificate_type nvarchar2(100);
    n_short_note nvarchar2(100);
    n_attach_name nvarchar2(2000);
    n_attach_url nvarchar2(5000);

begin
    -- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
    v_body := v_body||'<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐỀ XUẤT THAY ĐỔI THÔNG TIN CÁ NHÂN</h3>';
    v_body := v_body||'<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – PERSONAL INFORMATION UPDATE LETTERS</h3>';
    v_body := v_body||'<p style=''color:black;margin-top:20px''>Anh/Chị '||:P5_FULL_NAME||' thân mến,</p>';
    v_body := v_body||'<p style=''color:black;margin-top:0''>Dear Mr/Ms. '||:P5_FULL_NAME||',</p>';
    v_body := v_body||'<p style=''color:black''>Hệ thống nhận được đề nghị cập nhật thay đổi thông tin cá nhân của nhân viên sau:</p>';
    v_body := v_body||'<p style=''color:black''>Employee Portal system has received a Personal information update request as below:</p>';
    v_body := v_body||'<ul>';
    v_body := v_body||'<li style=''color:black''><strong style=''color:black''>Họ và tên/ Full name:</strong> '||:P5_FULL_NAME||'</li>';
    v_body := v_body||'<li style=''color:black''><strong style=''color:black''>Mã số nhân viên/ Employee Code:</strong> '||:P5_EMPLOYEE_CODE||'</li>';
    v_body := v_body||'<li style=''color:black''><strong style=''color:black''>Chức danh/ Title:</strong> '||:P5_TITLE||'</li>';
    v_body := v_body||'</ul>';
    v_body := v_body||'<table style=''border-collapse: collapse;border: 1px solid black;''>';
    v_body := v_body||'<tr>';
    v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0;font-weight:700''>Thông tin Học vấn</p><p style=''color:black;margin:0;font-style:italic;margin-bottom:10px''>Education</p></th>';
    v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐÃ ĐĂNG KÝ</strong></p><p style=''color:black;margin:0;font-weight:400''><i>CURRENT PERSONAL INFORMATION</i></p></th>';
    v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐỀ NGHỊ THAY ĐỔI</strong></p><p style=''color:black;margin:0;font-weight:400''><i>PERSONAL INFORMATION UPDATE</i></p></th>';
    v_body := v_body||'</tr>';
    v_body := v_body||'<tr style=''border: 1px solid black;border-bottom: none;''><td style=''padding:0 10px; border-left: 1px solid black;''></td><td style=''padding:0 10px; border-left: 1px solid black;''></td><td style=''padding:0 10px; border-left: 1px solid black''></td></tr>';
   
    old_string := apex_t_number();
    new_string := apex_t_number();
    -- parse page item đang lưu giá trị json của bảng cũ
    APEX_JSON.PARSE(:P5_EMP_CURRENT_CERTIFICATES);
    -- biến đếm số object của json
    l_numrows := APEX_JSON.GET_COUNT(p_path => '.');

    if l_numrows > 0 then
        for i in 1..l_numrows loop
            o_id := to_number(APEX_JSON.get_varchar2(p_path => '[%d].id', p0 => i));
            old_string.extend();
            old_string(old_string.COUNT) := o_id;
            
        end loop;
    end if;

    for rec in (select cer.id 
                from EMP_CERTIFICATE cer
                INNER JOIN 
                EMPLOYEES e ON cer.EMPLOYEE_CODE = e.EMPLOYEE_CODE
                WHERE e.USER_NAME = :APP_USER_NAME) loop
        new_string.extend();
        new_string(new_string.COUNT) := rec.id;
    end loop;

    -- KHỞI TẠO 2 BẢNG RỖNG ĐỂ LƯU GIÁ TRỊ TỪ FUNCTION
    add_ids := apex_t_number();
    delete_ids := apex_t_number();
    
    add_ids := CHECK_ADD_ID(old_string, new_string);
    delete_ids := CHECK_DELETE_ID(old_string, new_string);

    -- kiểm tra xem nếu add_ids có giá trị thì thêm nội dung vào mail
    if add_ids.COUNT != 0 then
        is_changed := true;
        for rec in 1..add_ids.COUNT loop
            
            -- Update attachment for new row in EMP_CERTIFICATE from TEMP_UPLOAD through TEMP_ID
            Update EMP_CERTIFICATE cert
            set cert.ATTACHMENT_NAME = (select att.ATTACHMENT_NAME from TEMP_UPLOAD att where att.TEMP_ID = cert.TEMP_ID and att.TABLE_NAME = 'EMP_CERTIFICATE'),
                cert.ATTACHMENT_URL = (select att.ATTACHMENT_URL from TEMP_UPLOAD att where att.TEMP_ID = cert.TEMP_ID and att.TABLE_NAME = 'EMP_CERTIFICATE')
            where cert.ID = add_ids(rec);

            select CERTIFICATE_TYPE, to_char(START_DATE, 'DD/MM/YYYY'), to_char(END_DATE, 'DD/MM/YYYY'), SHORT_NOTE, ATTACHMENT_NAME, ATTACHMENT_URL
            into n_certificate_type, n_start_date, n_end_date, n_short_note, n_attach_name, n_attach_url
            from EMP_CERTIFICATE
            where ID = add_ids(rec);
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''><p style=''color:black;font-weight:700;margin-top:20px;margin-bottom:0''>Chứng chỉ đã thêm</p><p style=''color:black;margin:0;font-style:italic''>Addition of a certificate</p></td><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Tên chứng chỉ / Certificate type</td><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_certificate_type ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ngày cấp / Issue date</td><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_start_date ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ngày hết hạn / Expiration date</td><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_end_date ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''> Ghi chú / Note </td><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_short_note ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''> Đính kèm / Attachment </td><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| to_href_html(n_attach_url, n_attach_name) ||'</td></tr>';
            -- v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';
            
        end loop;
    end if;

    -- kiểm tra xem nếu delete_ids có giá trị thì thêm nội dung vào mail
    if delete_ids.COUNT != 0 then
        is_changed := true;
        for i in 1..old_string.COUNT loop
            o_id := to_number(APEX_JSON.get_varchar2(p_path => '[%d].id', p0 => i));
            for j in 1..delete_ids.COUNT loop
                if o_id = delete_ids(j) then
                    v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''><p style=''color:black;font-weight:700;margin-top:20px;margin-bottom:0''>Chứng chỉ đã xoá</p><p style=''color:black;margin:0;font-style:italic;''>Deletion of a certificate</p></td><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';
                    
                    o_certificate_type := APEX_JSON.get_varchar2(p_path => '[%d].certificate_type', p0 => i);
                    
                    temp_start := to_date(APEX_JSON.get_varchar2(p_path => '[%d].start_date', p0 => i), 'YYYY-MM-DD"T"HH24:MI:SS');
                    o_start_date := to_char(temp_start, 'DD/MM/YYYY');
                    
                    temp_end := to_date(APEX_JSON.get_varchar2(p_path => '[%d].end_date', p0 => i), 'YYYY-MM-DD"T"HH24:MI:SS');
                    o_end_date := to_char(temp_end, 'DD/MM/YYYY');
                    
                    o_short_note := APEX_JSON.get_varchar2(p_path => '[%d].short_note', p0 => i);
                    
                    -- o_attach_name := APEX_JSON.get_varchar2(p_path => '[%d].attachment_name', p0 => i);
                    -- o_attach_url := APEX_JSON.get_varchar2(p_path => '[%d].attachment_url', p0 => i);

                    v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Tên chứng chỉ / Certificate type</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_certificate_type ||'</td><td style=''padding:0 10px;''></td></tr>';
                    v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ngày cấp / Issue date</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_start_date ||'</td><td style=''padding:0 10px;''></td></tr>';
                    v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ngày hết hạn / Expiration date</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_end_date ||'</td><td style=''padding:0 10px;''></td></tr>';
                    v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ghi chú / Note</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_short_note ||'</td><td style=''padding:0 10px;''></td></tr>';
                    -- v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''> Đính kèm / Attachment </td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_attach_name ||'</td><td style=''padding:0 10px;''></td></tr>';
                end if;
            end loop;
        end loop;
    end if;

    -- kiểm tra update
    current_ids := apex_t_number();

    for i in 1..new_string.count loop
        if new_string(i) member of old_string then
            current_ids.extend();
            current_ids(current_ids.count) := new_string(i);
        end if;
    end loop;

    if current_ids.count != 0 then
        for i in 1..old_string.count loop      -- phải chạy theo số lượng của o_ids thì mới xét hết đc object của json, nếu dùng current sẽ có thì sẽ ko chạy hết object
            o_id := to_number(APEX_JSON.get_varchar2(p_path => '[%d].id', p0 => i));
            for j in 1..current_ids.count loop
                if o_id = current_ids(j) then     -- nếu id cũ bằng với id hiện tại, khi đó mình mới bắt đc đúng i cùng = id mới
                    o_certificate_type := APEX_JSON.get_varchar2(p_path => '[%d].certificate_type', p0 => i);
                    
                    temp_start := to_date(APEX_JSON.get_varchar2(p_path => '[%d].start_date', p0 => i), 'YYYY-MM-DD"T"HH24:MI:SS');
                    o_start_date := to_char(temp_start, 'DD/MM/YYYY');
                    
                    temp_end := to_date(APEX_JSON.get_varchar2(p_path => '[%d].end_date', p0 => i), 'YYYY-MM-DD"T"HH24:MI:SS');
                    o_end_date := to_char(temp_end, 'DD/MM/YYYY');
                    
                    o_short_note := APEX_JSON.get_varchar2(p_path => '[%d].short_note', p0 => i);

                    o_attach_name := APEX_JSON.get_varchar2(p_path => '[%d].attachment_name', p0 => i);
                    o_attach_url := APEX_JSON.get_varchar2(p_path => '[%d].attachment_url', p0 => i);
                    
                    -- lấy giá trị của dòng dữ liệu mới
                    select CERTIFICATE_TYPE, to_char(START_DATE, 'DD/MM/YYYY'), to_char(END_DATE, 'DD/MM/YYYY'), SHORT_NOTE, ATTACHMENT_NAME, ATTACHMENT_URL
                    into n_certificate_type, n_start_date, n_end_date, n_short_note, n_attach_name, n_attach_url
                    from EMP_CERTIFICATE
                    where ID = current_ids(j);

                    if ((o_certificate_type != n_certificate_type) or (o_certificate_type is null and n_certificate_type is not null) or (o_certificate_type is not null and n_certificate_type is null))
                    or ((o_start_date != n_start_date) or (o_start_date is null and n_start_date is not null) or (o_start_date is not null and n_start_date is null))
                    or (o_end_date != n_end_date or (o_end_date is null and n_end_date is not null) or (o_end_date is not null and n_end_date is null))
                    or (o_short_note != n_short_note or (o_short_note is null and n_short_note is not null) or (o_short_note is not null and n_short_note is null))
                    or (o_attach_url != n_attach_url or (o_attach_url is null and n_attach_url is not null) or (o_attach_url is not null and n_attach_url is null)) then
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''><p style=''color:black;font-weight:700; margin-top:20px;margin-bottom:0;''>Chứng chỉ đã cập nhật</p><p style=''color:black;margin:0;font-style:italic;''>Updating of a certificate</p></td><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';
                    end if;
                     
                    -- if (o_certificate_type != n_certificate_type) or n_certificate_type = ' ' then
                    if (o_certificate_type != n_certificate_type) or (o_certificate_type is null and n_certificate_type is not null) or (o_certificate_type is not null and n_certificate_type is null) then
                        is_changed := true;
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Tên chứng chỉ / Certificate type</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_certificate_type ||'</td><td style=''padding:0 10px;''>'|| n_certificate_type ||'</td></tr>';
                    end if;

                    if (o_start_date != n_start_date) or (o_start_date is null and n_start_date is not null) or (o_start_date is not null and n_start_date is null) then
                        is_changed := true;
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ngày cấp / Issue date</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_start_date ||'</td><td style=''padding:0 10px;''>'|| n_start_date ||'</td></tr>';
                    end if;

                    if o_end_date != n_end_date or (o_end_date is null and n_end_date is not null) or (o_end_date is not null and n_end_date is null) then
                        is_changed := true;
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ngày hết hạn / Expiration date</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_start_date ||'</td><td style=''padding:0 10px;''>'|| n_end_date ||'</td></tr>';
                    end if;  

                    --n_short_note := to_char(temp_start_2, 'DD/MM/YYYY');
                    if o_short_note != n_short_note or (o_short_note is null and n_short_note is not null) or (o_short_note is not null and n_short_note is null) then
                        is_changed := true;
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;margin-bottom:10px''>Ghi chú / Note</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_short_note ||'</td><td style=''padding:0 10px;''>'|| n_short_note ||'</td></tr>';
                    end if;

                    if o_attach_url != n_attach_url or (o_attach_url is null and n_attach_url is not null) or (o_attach_url is not null and n_attach_url is null) then
                        is_changed := true;
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;margin-bottom:10px''>Đính kèm / Attachment</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| to_href_html(o_attach_url, o_attach_name) ||'</td><td style=''padding:0 10px;''>'|| to_href_html(n_attach_url, n_attach_name) ||'</td></tr>';
                    end if;

                    -- if ((o_end_date != n_certificate_type) or (o_end_date is null and n_certificate_type is not null) or (o_end_date is not null and n_certificate_type is null))
                    -- or ((o_certificate_type != n_start_date) or (o_certificate_type is null and n_start_date is not null) or (o_certificate_type is not null and n_start_date is null))
                    -- or (o_start_date != n_end_date or (o_start_date is null and n_end_date is not null) or (o_start_date is not null and n_end_date is null))
                    -- or (old_graduated_date != n_short_note or (old_graduated_date is null and n_short_note is not null) or (old_graduated_date is not null and n_short_note is null)) then
                    --     v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;margin-bottom:10px''></td><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';
                    -- end if;

                end if;
            end loop;
        end loop;
        -- for i in 1..current_ids.count loop
        --     -- lấy giá trị của dòng dữ liệu cũ
        --     o_end_date := APEX_JSON.get_varchar2(p_path => '[%d].level_of_edu', p0 => i);
        --     o_certificate_type := APEX_JSON.get_varchar2(p_path => '[%d].major', p0 => i);
        --     o_start_date := APEX_JSON.get_varchar2(p_path => '[%d].place', p0 => i);
        --     -- old_graduated_date := APEX_JSON.get_varchar2(p_path => '[%d].graduated_date', p0 => i);
        --     temp_start := to_date(APEX_JSON.get_varchar2(p_path => '[%d].graduated_date', p0 => i), 'YYYY-MM-DD"T"HH24:MI:SS');
        --     old_graduated_date := to_char(temp_start, 'DD/MM/YYYY');

        --     o_attach_name := APEX_JSON.get_varchar2(p_path => '[%d].attach_file', p0 => i);

        --     -- lấy giá trị của dòng dữ liệu mới
        --     select LEVEL_OF_EDU, MAJOR, PLACE, GRADUATED_DATE, ATTACH_FILE
        --     into n_certificate_type, n_start_date, n_end_date, temp_start_2, n_attach_name
        --     from EMP_EDUCATION
        --     where ID = current_ids(i);

        --     -- if (o_end_date != n_certificate_type) or n_certificate_type = ' ' then
        --     if (o_end_date != n_certificate_type) or (o_end_date is null and n_certificate_type is not null) or (o_end_date is not null and n_certificate_type is null) then
        --         is_changed := true;
        --         v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Trình độ học vấn / Level of edu</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_end_date ||'</td><td style=''padding:0 10px;''>'|| n_certificate_type ||'</td></tr>';
        --     end if;

        --     if (o_certificate_type != n_start_date) or (o_certificate_type is null and n_start_date is not null) or (o_certificate_type is not null and n_start_date is null) then
        --         is_changed := true;
        --         v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Chuyên ngành / Major</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_certificate_type ||'</td><td style=''padding:0 10px;''>'|| n_start_date ||'</td></tr>';
        --     end if;

        --     if o_start_date != n_end_date or (o_start_date is null and n_end_date is not null) or (o_start_date is not null and n_end_date is null) then
        --         is_changed := true;
        --         v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Tên trường học / Name of school/university/institute </td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| o_start_date ||'</td><td style=''padding:0 10px;''>'|| n_end_date ||'</td></tr>';
        --     end if;  

        --     n_short_note := to_char(temp_start_2, 'DD/MM/YYYY');
        --     if old_graduated_date != n_short_note or (old_graduated_date is null and n_short_note is not null) or (old_graduated_date is not null and n_short_note is null) then
        --         is_changed := true;
        --         v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''> Năm tốt nghiệp / Graduated date </td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| old_graduated_date ||'</td><td style=''padding:0 10px;''>'|| n_short_note ||'</td></tr>';
        --     end if; 
        -- end loop;
    end if;

    v_body := v_body||'</table>';
    v_body := v_body||'<p style=''color:black''>Anh/Chị vui lòng click tại đây để kiểm tra thông tin và xác nhận cập nhật vào hệ thống D365 HRM.</p>';
    v_body := v_body||'<p style=''color:black''>Please click Link to review and update information to D365 HRM System.</p>';
    v_body := v_body||'<p style=''color:black''>Trân trọng,</p>';
    v_body := v_body||'<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
    v_body := v_body||'<p style=''color:black''>Best regards,</p>';
    v_body := v_body||'<p style=''color:black''>HR & Admin Department </p>';
    -- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

-------------------------------------------------------
----- Send mail
    if is_changed then
    -- Send to HRs (for pilot)
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'phuongpham@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'trang.th@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'hravus@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'haitran@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- send tester
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'huyen.ptt@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thudang@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thi.tnh@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ngan.tranvu@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- Send to Devs
        -- SP_SENDGRID_EMAIL('ky.nguyenquoc@vus-etsc.edu.vn', 'quocky600@gmail.com', 'Cập nhật thay đổi thông tin NV '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ky.nguyenquoc@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'quocky600@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'tranquangkhanh2k1qv@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'khanhnguyendev@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
    end if;
end;

-- ----------------------------------------
-- Page: 5 - Personal Information > Process: Send email change info tab Education degree > Source > PL/SQL Code

declare
    v_body clob:='';
    is_changed boolean := false;
    -- biến để kiểm tra đoạn json
    old_id number;
    old_major nvarchar2(100);
    old_place nvarchar2(500);
    old_level_of_edu nvarchar2(50);
    temp date;
    old_graduated_date nvarchar2(50);
    old_attach_name nvarchar2(2000);
    old_attach_url nvarchar2(5000);
    l_numrows number;
    old_string apex_t_number;      -- BẢNG CŨ (JSON)
    new_string apex_t_number;      -- BẢNG MỚI
    add_ids apex_t_number;      -- BẢNG ADD
    delete_ids apex_t_number;       -- BẢNG DELETE
    current_ids apex_t_number;       -- BẢNG id không đổi, dùng để kiểm tra dữ liệu update
    n_major nvarchar2(100); 
    n_place nvarchar2(500);
    n_level_of_edu nvarchar2(50);
    n_graduated_date nvarchar2(50);
    n_attach_name nvarchar2(2000);
    n_attach_url nvarchar2(5000);

begin
    -- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
    v_body := v_body||'<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐỀ XUẤT THAY ĐỔI THÔNG TIN CÁ NHÂN</h3>';
    v_body := v_body||'<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – PERSONAL INFORMATION UPDATE LETTERS</h3>';
    v_body := v_body||'<p style=''color:black;margin-top:20px''>Anh/Chị '||:P5_FULL_NAME||' thân mến,</p>';
    v_body := v_body||'<p style=''color:black;margin-top:0''>Dear Mr/Ms. '||:P5_FULL_NAME||',</p>';
    v_body := v_body||'<p style=''color:black''>Hệ thống nhận được đề nghị cập nhật thay đổi thông tin cá nhân của nhân viên sau:</p>';
    v_body := v_body||'<p style=''color:black''>Employee Portal system has received a Personal information update request as below:</p>';
    v_body := v_body||'<ul>';
    v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '||:P5_FULL_NAME||'</p>';
    v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '||:P5_EMPLOYEE_CODE||'</p>';
    v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Chức danh/ Title:</strong> '||:P5_TITLE||'</p>';
    v_body := v_body||'</ul>';
    v_body := v_body||'<table style=''border-collapse: collapse;border: 1px solid black;''>';
    v_body := v_body||'<tr>';
    v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0;font-weight:700''>Thông tin Học vấn</p><p style=''color:black;margin:0;font-style:italic;margin-bottom:10px''>Education</p></th>';
    v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐÃ ĐĂNG KÝ</strong></p><p style=''color:black;margin:0;font-weight:400''><i>CURRENT PERSONAL INFORMATION</i></p></th>';
    v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐỀ NGHỊ THAY ĐỔI</strong></p><p style=''color:black;margin:0;font-weight:400''><i>PERSONAL INFORMATION UPDATE</i></p></th>';
    v_body := v_body||'</tr>';
    v_body := v_body||'<tr style=''border: 1px solid black;border-bottom: none;''><td style='' padding:0 10px; border-left: 1px solid black;''></td><td style='' padding:0 10px; border-left: 1px solid black;''></td><td style='' padding:0 10px; border-left: 1px solid black''></td></tr>';
   
    old_string := apex_t_number();
    new_string := apex_t_number();
    -- parse page item đang lưu giá trị json của bảng cũ
    APEX_JSON.PARSE(:P5_EMP_CURRENT_EDUCATION);
    -- biến đếm số object của json
    l_numrows := APEX_JSON.GET_COUNT(p_path => '.');

    if l_numrows > 0 then
        for i in 1..l_numrows loop
            old_id := to_number(APEX_JSON.get_varchar2(p_path => '[%d].id', p0 => i));
            old_string.extend();
            old_string(old_string.COUNT) := old_id;
            
        end loop;
    end if;

    for temp in (select edu.id 
                from EMP_EDUCATION edu
                INNER JOIN 
                EMPLOYEES e ON edu.EMPLOYEE_CODE = e.EMPLOYEE_CODE
                WHERE e.USER_NAME = :APP_USER_NAME) loop
        new_string.extend();
        new_string(new_string.COUNT) := temp.id;
    end loop;

    -- KHỞI TẠO 2 BẢNG RỖNG ĐỂ LƯU GIÁ TRỊ TỪ FUNCTION
    add_ids := apex_t_number();
    delete_ids := apex_t_number();
    
    add_ids := CHECK_ADD_ID(old_string, new_string);
    delete_ids := CHECK_DELETE_ID(old_string, new_string);

    -- kiểm tra xem nếu add_ids có giá trị thì thêm nội dung vào mail
    if add_ids.COUNT != 0 then
        is_changed := true;
        for rec in 1..add_ids.COUNT loop
            -- Update attachment for new row in EMP_EDUCATION from TEMP_UPLOAD through TEMP_ID
            Update EMP_EDUCATION edu
            set edu.ATTACH_NAME = (select att.ATTACHMENT_NAME from TEMP_UPLOAD att where att.TEMP_ID = edu.TEMP_ID and att.TABLE_NAME = 'EMP_EDUCATION'),
                edu.ATTACH_URL = (select att.ATTACHMENT_URL from TEMP_UPLOAD att where att.TEMP_ID = edu.TEMP_ID and att.TABLE_NAME = 'EMP_EDUCATION')
            where edu.ID = add_ids(rec);

            select LEVEL_OF_EDU, MAJOR, PLACE, to_char(GRADUATED_DATE, 'DD/MM/YYYY'), ATTACH_NAME, ATTACH_URL
            into n_level_of_edu, n_major, n_place, n_graduated_date, n_attach_name, n_attach_url
            from EMP_EDUCATION
            where ID = add_ids(rec);
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''><p style=''color:black;font-weight:700; margin-top:20px;margin-bottom:0;''>Bằng cấp đã thêm</p><p style=''color:black;margin:0;font-style:italic''>Addition of a degree</p></td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Trình độ học vấn / Level of edu</td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_level_of_edu ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Chuyên ngành / Major</td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_major ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Tên trường học / Name of school/university/institute </td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_place ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''> Năm tốt nghiệp / Graduated date </td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_graduated_date ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;margin-bottom:10px''> Đính kèm / Attachment </td><td style=''padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| to_href_html(n_attach_url, n_attach_name) ||'</td></tr>';
            -- v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''> Đính kèm / Attachment </td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| to_href_html(n_attach_file, n_attach_name) ||'</td></tr>';
            -- v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';    
        end loop;
    end if;

    -- kiểm tra xem nếu delete_ids có giá trị thì thêm nội dung vào mail
    if delete_ids.COUNT != 0 then
        is_changed := true;
        for i in 1..old_string.COUNT loop
            old_id := to_number(APEX_JSON.get_varchar2(p_path => '[%d].id', p0 => i));
            for j in 1..delete_ids.COUNT loop
                if old_id = delete_ids(j) then
                    v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''><p style=''color:black;font-weight:700;margin-top:20px;margin-bottom:0;''>Bằng cấp đã xoá</p><p style=''color:black;margin:0;font-style:italic;''>Deletion of a degree</p></td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';
                    
                    old_major := APEX_JSON.get_varchar2(p_path => '[%d].major', p0 => i);
                    old_place := APEX_JSON.get_varchar2(p_path => '[%d].place', p0 => i);
                    old_level_of_edu := APEX_JSON.get_varchar2(p_path => '[%d].level_of_edu', p0 => i);
                    temp := to_date(APEX_JSON.get_varchar2(p_path => '[%d].graduated_date', p0 => i), 'YYYY-MM-DD"T"HH24:MI:SS');
                    old_graduated_date := to_char(temp, 'DD/MM/YYYY');
                    -- old_attach_name := APEX_JSON.get_varchar2(p_path => '[%d].attach_file', p0 => i);
                    v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Trình độ học vấn / Level of edu</td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_level_of_edu ||'</td><td style=''padding:0 10px;''></td></tr>';
                    v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Chuyên ngành / Major</td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_major ||'</td><td style=''padding:0 10px;''></td></tr>';
                    v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Tên trường học / Name of school/university/institute </td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_place ||'</td><td style=''padding:0 10px;''></td></tr>';
                    v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''> Năm tốt nghiệp / Graduated date </td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_graduated_date ||'</td><td style=''padding:0 10px;''></td></tr>';
                    -- v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''> Đính kèm / Attachment </td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_attach_name ||'</td><td style=''padding:0 10px;''></td></tr>';
                end if;
            end loop;
        end loop;
    end if;

    -- kiểm tra update
    current_ids := apex_t_number();

    for i in 1..new_string.count loop
        if new_string(i) member of old_string then
            current_ids.extend();
            current_ids(current_ids.count) := new_string(i);
        end if;
    end loop;

    if current_ids.count != 0 then
        for i in 1..old_string.count loop      -- phải chạy theo số lượng của old_ids thì mới xét hết đc object của json, nếu dùng current sẽ có thì sẽ ko chạy hết object
            old_id := to_number(APEX_JSON.get_varchar2(p_path => '[%d].id', p0 => i));
            for j in 1..current_ids.count loop
                if old_id = current_ids(j) then     -- nếu id cũ bằng với id hiện tại, khi đó mình mới bắt đc đúng i cùng = id mới
                    old_level_of_edu := APEX_JSON.get_varchar2(p_path => '[%d].level_of_edu', p0 => i);
                    old_major := APEX_JSON.get_varchar2(p_path => '[%d].major', p0 => i);
                    old_place := APEX_JSON.get_varchar2(p_path => '[%d].place', p0 => i);
                    -- old_graduated_date := APEX_JSON.get_varchar2(p_path => '[%d].graduated_date', p0 => i);
                    temp := to_date(APEX_JSON.get_varchar2(p_path => '[%d].graduated_date', p0 => i), 'YYYY-MM-DD"T"HH24:MI:SS');
                    old_graduated_date := to_char(temp, 'DD/MM/YYYY');

                    old_attach_name := APEX_JSON.get_varchar2(p_path => '[%d].attach_name', p0 => i);
                    old_attach_url := APEX_JSON.get_varchar2(p_path => '[%d].attach_url', p0 => i);
                    
                    -- lấy giá trị của dòng dữ liệu mới
                    select LEVEL_OF_EDU, MAJOR, PLACE, to_char(GRADUATED_DATE, 'DD/MM/YYYY'), ATTACH_NAME, ATTACH_URL
                    into n_level_of_edu, n_major, n_place, n_graduated_date, n_attach_name, n_attach_url
                    from EMP_EDUCATION
                    where ID = current_ids(j);

                    if ((old_level_of_edu != n_level_of_edu) or (old_level_of_edu is null and n_level_of_edu is not null) or (old_level_of_edu is not null and n_level_of_edu is null))
                    or ((old_major != n_major) or (old_major is null and n_major is not null) or (old_major is not null and n_major is null))
                    or (old_place != n_place or (old_place is null and n_place is not null) or (old_place is not null and n_place is null))
                    or (old_graduated_date != n_graduated_date or (old_graduated_date is null and n_graduated_date is not null) or (old_graduated_date is not null and n_graduated_date is null)) then
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''><p style=''color:black;margin-top:20px;margin-bottom:0;font-weight:700''>Bằng cấp đã cập nhật</p><p style=''color:black;margin:0;font-style:italic;''>Updating of a degree</p></td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';
                    end if;
                     
                    -- if (old_level_of_edu != n_level_of_edu) or n_level_of_edu = ' ' then
                    if (old_level_of_edu != n_level_of_edu) or (old_level_of_edu is null and n_level_of_edu is not null) or (old_level_of_edu is not null and n_level_of_edu is null) then
                        is_changed := true;
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Trình độ học vấn / Level of edu</td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_level_of_edu ||'</td><td style=''padding:0 10px;''>'|| n_level_of_edu ||'</td></tr>';
                    end if;

                    if (old_major != n_major) or (old_major is null and n_major is not null) or (old_major is not null and n_major is null) then
                        is_changed := true;
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Chuyên ngành / Major</td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_major ||'</td><td style=''padding:0 10px;''>'|| n_major ||'</td></tr>';
                    end if;

                    if old_place != n_place or (old_place is null and n_place is not null) or (old_place is not null and n_place is null) then
                        is_changed := true;
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Tên trường học / Name of school/university/institute </td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_place ||'</td><td style=''padding:0 10px;''>'|| n_place ||'</td></tr>';
                    end if;  

                    --n_graduated_date := to_char(temp_2, 'DD/MM/YYYY');
                    if old_graduated_date != n_graduated_date or (old_graduated_date is null and n_graduated_date is not null) or (old_graduated_date is not null and n_graduated_date is null) then
                        is_changed := true;
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;margin-bottom:10px''> Năm tốt nghiệp / Graduated date </td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_graduated_date ||'</td><td style=''padding:0 10px;''>'|| n_graduated_date ||'</td></tr>';
                    end if;

                    if old_attach_url != n_attach_url or (old_attach_url is null and n_attach_url is not null) or (old_attach_url is not null and n_attach_url is null) then
                        is_changed := true;
                        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;margin-bottom:10px''> Đính kèm / Attachment </td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| to_href_html(old_attach_url, old_attach_name) ||'</td><td style=''padding:0 10px;''>'|| to_href_html(n_attach_url, n_attach_name) ||'</td></tr>';
                    end if;

                    -- if ((old_level_of_edu != n_level_of_edu) or (old_level_of_edu is null and n_level_of_edu is not null) or (old_level_of_edu is not null and n_level_of_edu is null))
                    -- or ((old_major != n_major) or (old_major is null and n_major is not null) or (old_major is not null and n_major is null))
                    -- or (old_place != n_place or (old_place is null and n_place is not null) or (old_place is not null and n_place is null))
                    -- or (old_graduated_date != n_graduated_date or (old_graduated_date is null and n_graduated_date is not null) or (old_graduated_date is not null and n_graduated_date is null)) then
                    --     v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;margin-bottom:10px''></td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';
                    -- end if;

                end if;
            end loop;
        end loop;
        -- for i in 1..current_ids.count loop
        --     -- lấy giá trị của dòng dữ liệu cũ
        --     old_level_of_edu := APEX_JSON.get_varchar2(p_path => '[%d].level_of_edu', p0 => i);
        --     old_major := APEX_JSON.get_varchar2(p_path => '[%d].major', p0 => i);
        --     old_place := APEX_JSON.get_varchar2(p_path => '[%d].place', p0 => i);
        --     -- old_graduated_date := APEX_JSON.get_varchar2(p_path => '[%d].graduated_date', p0 => i);
        --     temp := to_date(APEX_JSON.get_varchar2(p_path => '[%d].graduated_date', p0 => i), 'YYYY-MM-DD"T"HH24:MI:SS');
        --     old_graduated_date := to_char(temp, 'DD/MM/YYYY');

        --     old_attach_name := APEX_JSON.get_varchar2(p_path => '[%d].attach_file', p0 => i);

        --     -- lấy giá trị của dòng dữ liệu mới
        --     select LEVEL_OF_EDU, MAJOR, PLACE, GRADUATED_DATE, ATTACH_FILE
        --     into n_level_of_edu, n_major, n_place, temp_2, n_attach_name
        --     from EMP_EDUCATION
        --     where ID = current_ids(i);

        --     -- if (old_level_of_edu != n_level_of_edu) or n_level_of_edu = ' ' then
        --     if (old_level_of_edu != n_level_of_edu) or (old_level_of_edu is null and n_level_of_edu is not null) or (old_level_of_edu is not null and n_level_of_edu is null) then
        --         is_changed := true;
        --         v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Trình độ học vấn / Level of edu</td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_level_of_edu ||'</td><td style=''padding:0 10px;''>'|| n_level_of_edu ||'</td></tr>';
        --     end if;

        --     if (old_major != n_major) or (old_major is null and n_major is not null) or (old_major is not null and n_major is null) then
        --         is_changed := true;
        --         v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Chuyên ngành / Major</td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_major ||'</td><td style=''padding:0 10px;''>'|| n_major ||'</td></tr>';
        --     end if;

        --     if old_place != n_place or (old_place is null and n_place is not null) or (old_place is not null and n_place is null) then
        --         is_changed := true;
        --         v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Tên trường học / Name of school/university/institute </td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_place ||'</td><td style=''padding:0 10px;''>'|| n_place ||'</td></tr>';
        --     end if;  

        --     n_graduated_date := to_char(temp_2, 'DD/MM/YYYY');
        --     if old_graduated_date != n_graduated_date or (old_graduated_date is null and n_graduated_date is not null) or (old_graduated_date is not null and n_graduated_date is null) then
        --         is_changed := true;
        --         v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''> Năm tốt nghiệp / Graduated date </td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| old_graduated_date ||'</td><td style=''padding:0 10px;''>'|| n_graduated_date ||'</td></tr>';
        --     end if; 
        -- end loop;
    end if;

    v_body := v_body||'</table>';
    v_body := v_body||'<p style=''color:black''>Anh/Chị vui lòng click tại đây để kiểm tra thông tin và xác nhận cập nhật vào hệ thống D365 HRM.</p>';
    v_body := v_body||'<p style=''color:black''>Please click Link to review and update information to D365 HRM System.</p>';
    v_body := v_body||'<p style=''color:black''>Trân trọng,</p>';
    v_body := v_body||'<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
    v_body := v_body||'<p style=''color:black''>Best regards,</p>';
    v_body := v_body||'<p style=''color:black''>HR & Admin Department </p>';
    -- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

-------------------------------------------------------
----- Send mail
    if is_changed then
    -- Send to HRs (for pilot)
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'phuongpham@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'trang.th@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'hravus@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'haitran@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- send tester
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'huyen.ptt@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thudang@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thi.tnh@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ngan.tranvu@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- Send to Devs
        -- SP_SENDGRID_EMAIL('ky.nguyenquoc@vus-etsc.edu.vn', 'quocky600@gmail.com', 'Cập nhật thay đổi thông tin NV '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ky.nguyenquoc@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'quocky600@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'tranquangkhanh2k1qv@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'khanhnguyendev@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
    end if;
end;

-- ----------------------------------------
-- Page: 5 - Personal Information > Process: Send email change info tab PIT number > Source > PL/SQL Code

DECLARE
    v_body clob:='';
    is_changed boolean := false;
BEGIN
-- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
v_body := v_body||'<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐỀ XUẤT THAY ĐỔI THÔNG TIN CÁ NHÂN</h3>';
v_body := v_body||'<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – PERSONAL INFORMATION UPDATE LETTERS</h3>';
v_body := v_body||'<p style=''color:black;margin-top:20px''>Anh/Chị '||:P5_FULL_NAME||' thân mến,</p>';
v_body := v_body||'<p style=''color:black;margin-top:0''>Dear Mr/Ms. '||:P5_FULL_NAME||',</p>';
v_body := v_body||'<p style=''color:black''>Hệ thống nhận được đề nghị cập nhật thay đổi thông tin cá nhân của nhân viên sau:</p>';
v_body := v_body||'<p style=''color:black''>Employee Portal system has received a Personal information update request as below:</p>';
v_body := v_body||'<ul>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '||:P5_FULL_NAME||'</p>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '||:P5_EMPLOYEE_CODE||'</p>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Chức danh/ Title:</strong> '||:P5_TITLE||'</p>';
v_body := v_body||'</ul>';
v_body := v_body||'<table style=''border-collapse: collapse;border: 1px solid black;''>';
v_body := v_body||'<tr>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>MÃ SỐ ĐỊNH DANH</strong></p><p style=''color:black;margin:0;font-weight:400''><i>IDENTIFY NUMBER</i></p></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐÃ ĐĂNG KÝ</strong></p><p style=''color:black;margin:0;font-weight:400''><i>CURRENT PERSONAL INFORMATION</i></p></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐỀ NGHỊ THAY ĐỔI</strong></p><p style=''color:black;margin:0;font-weight:400''><i>PERSONAL INFORMATION UPDATE</i></p></th>';
v_body := v_body||'</tr>';
v_body := v_body||'<tr style=''border: 1px solid black;border-bottom: none;''><td style='' padding:0 10px; border-left: 1px solid black;''><p style=''color:black;margin:0;font-weight:700''>Thông tin Mã số thuế</p><p style=''color:black;margin:0;font-style:italic;margin-bottom:10px''>PIT</p></td><td style='' padding:0 10px; border-left: 1px solid black;''></td><td style='' padding:0 10px; border-left: 1px solid black''></td></tr>';
FOR rec IN (SELECT 
    CASE
        WHEN emp_id.ISSUE_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
        ELSE TO_CHAR(emp_id.ISSUE_DATE, 'DD/MM/YYYY')
    END AS ISSUE_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 3 AND e.USER_NAME = :APP_USER_NAME 
)LOOP
    --if to_date(rec.ISSUE_DATE, 'MM/DD/YYYY') <> to_date(:P5_ISS_DATE_PIT_NUM, 'DD/MM/YYYY')
    -- IF rec.ISSUE_DATE <> :P5_ISS_DATE_PIT_NUM
    IF rec.ISSUE_DATE <> :P5_ISS_DATE_PIT_NUM 
    OR (rec.ISSUE_DATE IS NULL AND :P5_ISS_DATE_PIT_NUM IS NOT NULL)  
    THEN
        is_changed := true;
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Ngày cấp mã số thuế / Issue date</td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| rec.ISSUE_DATE ||'</td><td style='' padding:0 10px; border-right: 1px solid black;''>'|| :P5_ISS_DATE_PIT_NUM ||'</td></tr>';
    END IF;
END LOOP;
v_body := v_body||'</table>';
v_body := v_body||'<p style=''color:black''>Anh/Chị vui lòng click tại đây để kiểm tra thông tin và xác nhận cập nhật vào hệ thống D365 HRM.</p>';
v_body := v_body||'<p style=''color:black''>Please click Link to review and update information to D365 HRM System.</p>';
v_body := v_body||'<p style=''color:black''>Trân trọng,</p>';
v_body := v_body||'<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
v_body := v_body||'<p style=''color:black''>Best regards,</p>';
v_body := v_body||'<p style=''color:black''>HR & Admin Department </p>';
-- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

UPDATE EMP_ID_NUMBER
SET
    ISSUE_DATE = TO_DATE(:P5_ISS_DATE_PIT_NUM, 'DD/MM/YYYY')
    -- ISSUE_DATE = :P5_ISS_DATE_PIT_NUM
WHERE ID_TYPE = 3 AND EMPLOYEE_CODE = :APP_EMP_CODE;

    if is_changed then
    -- Send to HRs (for pilot)
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'phuongpham@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'trang.th@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'hravus@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'haitran@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- send tester
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'huyen.ptt@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thudang@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thi.tnh@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ngan.tranvu@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- Send to Devs
        -- SP_SENDGRID_EMAIL('ky.nguyenquoc@vus-etsc.edu.vn', 'quocky600@gmail.com', 'Cập nhật thay đổi thông tin NV '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ky.nguyenquoc@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'quocky600@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'tranquangkhanh2k1qv@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'khanhnguyendev@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
    end if;

END;

-- ----------------------------------------
-- Page: 5 - Personal Information > Process: Send email change info tab Social Insurance number > Source > PL/SQL Code

declare
    v_body clob:='';
    is_changed boolean := false;
begin

-- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
v_body := v_body||'<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐỀ XUẤT THAY ĐỔI THÔNG TIN CÁ NHÂN</h3>';
v_body := v_body||'<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – PERSONAL INFORMATION UPDATE LETTERS</h3>';
v_body := v_body||'<p style=''color:black;margin-top:20px''>Anh/Chị '||:P5_FULL_NAME||' thân mến,</p>';
v_body := v_body||'<p style=''color:black;margin-top:0''>Dear Mr/Ms. '||:P5_FULL_NAME||',</p>';
v_body := v_body||'<p style=''color:black''>Hệ thống nhận được đề nghị cập nhật thay đổi thông tin cá nhân của nhân viên sau:</p>';
v_body := v_body||'<p style=''color:black''>Employee Portal system has received a Personal information update request as below:</p>';
v_body := v_body||'<ul>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '||:P5_FULL_NAME||'</p>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '||:P5_EMPLOYEE_CODE||'</p>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Chức danh/ Title:</strong> '||:P5_TITLE||'</p>';
v_body := v_body||'</ul>';
v_body := v_body||'<table style=''border-collapse: collapse;border: 1px solid black;''>';
v_body := v_body||'<tr>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>MÃ SỐ ĐỊNH DANH</strong></p><p style=''color:black;margin:0;font-weight:400''><i>IDENTIFY NUMBER</i></p></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐÃ ĐĂNG KÝ</strong></p><p style=''color:black;margin:0;font-weight:400''><i>CURRENT PERSONAL INFORMATION</i></p></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐỀ NGHỊ THAY ĐỔI</strong></p><p style=''color:black;margin:0;font-weight:400''><i>PERSONAL INFORMATION UPDATE</i></p></th>';
v_body := v_body||'</tr>';
v_body := v_body||'<tr style=''border: 1px solid black;border-bottom: none;''><td style=''padding:0 10px; border-left: 1px solid black;''><p style=''color:black;margin:0;font-weight:700''>Thông tin Bảo hiểm xã hội</p><p style=''color:black;margin:0;font-style:italic;margin-bottom:10px''>Social insurance</p></td><td style=''padding:0 10px; border-left: 1px solid black;''></td><td style=''padding:0 10px; border-left: 1px solid black''></td></tr>';
for rec in (SELECT
    EMP_SI.SOC_INS_NUMBER,
    EMP_SI.PRI_HEAL_SERVICE,
    EMP_SI.SOC_HOSPITAL_CODE,
    EMP_SI.SOC_HOU_NAME,
    CASE
        WHEN EMP_SI.SOC_HOU_DOB = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
        ELSE TO_CHAR(EMP_SI.SOC_HOU_DOB, 'DD/MM/YYYY')
    END AS SOC_HOU_DOB,
    EMP_SI.SOC_HOU_ID,
    EMP_SI.SOC_RELATIONSHIP,
    EMP_SI.ATTACH_FILE,
    EMP_SI.ATTACH_NAME
FROM
    EMP_SOCICAL_INSURANCE EMP_SI
INNER JOIN
    EMPLOYEES e ON e.EMPLOYEE_CODE = EMP_SI.EMPLOYEE_CODE
WHERE
    e.USER_NAME = :APP_USER_NAME
)loop
    if NVL(rec.SOC_INS_NUMBER,'$') <> NVL(:P5_SOC_INS_NUMBER, '$') then
        v_body := v_body||'<tr  style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;color:black''>Số sổ Bảo hiểm xã hội / Social insurance number</td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||rec.SOC_INS_NUMBER||'</td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||:P5_SOC_INS_NUMBER||'</td></tr>';
        is_changed := true;
    end if;
    
    if NVL(rec.PRI_HEAL_SERVICE,'$') <> NVL(:P5_SOC_INS_PRI_HEAL, '$') then
        v_body := v_body||'<tr  style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;color:black''>Nơi đăng ký khám chữa bệnh / Primary healthcare service establishment </td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||rec.PRI_HEAL_SERVICE||'</td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||:P5_SOC_INS_PRI_HEAL||'</td></tr>';
        is_changed := true;
    end if;
    
    if NVL(rec.SOC_HOSPITAL_CODE,'$') <> NVL(:P5_SOC_INS_HOS_CODE,'$') then
        v_body := v_body||'<tr  style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;color:black''>Mã bệnh viện/phòng khám / Hospital/clinic code</td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||rec.SOC_HOSPITAL_CODE||'</td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||:P5_SOC_INS_HOS_CODE||'</td></tr>';
        is_changed := true;
    end if;
    
    if NVL(rec.SOC_HOU_NAME,'$') <> NVL(:P5_SOC_INS_HOU_NAME,'$') then
        v_body := v_body||'<tr  style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;color:black''>Họ và tên chủ hộ / Householder’s full name</td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||rec.SOC_HOU_NAME||'</td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||:P5_SOC_INS_HOU_NAME||'</td></tr>';
        is_changed := true;
    end if;
    
    if rec.SOC_HOU_DOB <> :P5_SOC_INS_HOU_DOB
    or (rec.SOC_HOU_DOB IS NULL AND :P5_SOC_INS_HOU_DOB IS NOT NULL)
    then
        v_body := v_body||'<tr  style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;color:black''>Ngày sinh chủ hộ khẩu / Householder’s DOB </td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'|| rec.SOC_HOU_DOB ||'</td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'|| :P5_SOC_INS_HOU_DOB ||'</td></tr>';
        is_changed := true;
    end if;
    
    if NVL(rec.SOC_HOU_ID,'$') <> NVL(:P5_SOC_INS_HOU_ID,'$') then
        v_body := v_body||'<tr  style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;color:black''>Số CMND chủ hộ  /Householder’s ID number</td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||rec.SOC_HOU_ID||'</td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||:P5_SOC_INS_HOU_ID||'</td></tr>';
        is_changed := true;
    end if;
    
    if NVL(rec.SOC_RELATIONSHIP,'$') <> NVL(:P5_SOC_INS_RELATIONS,'$') then
        v_body := v_body||'<tr  style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;color:black''>Mối quan hệ với chủ hộ / Relationship between householder and employee </td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||rec.SOC_RELATIONSHIP||'</td><td style=''padding:0 10px; border-right: 1px solid black;color:black''>'||:P5_SOC_INS_RELATIONS||'</td></tr>';
        is_changed := true;
    end if;
    
    if NVL(rec.ATTACH_FILE,'$') <> NVL(:P5_SOC_ATTACH,'$') then
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Đính kèm / Attachment</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| to_href_html(rec.ATTACH_FILE, rec.ATTACH_NAME)  ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| to_href_html(:P5_URL_SS, :P5_URL_NAME_SS ) ||'</td></tr>';
        is_changed := true;
    end if;
end loop;
v_body := v_body||'</table>';
v_body := v_body||'<p style=''color:black''>Anh/Chị vui lòng click tại đây để kiểm tra thông tin và xác nhận cập nhật vào hệ thống D365 HRM.</p>';
v_body := v_body||'<p style=''color:black''>Please click Link to review and update information to D365 HRM System.</p>';
v_body := v_body||'<p style=''color:black''>Trân trọng,</p>';
v_body := v_body||'<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
v_body := v_body||'<p style=''color:black''>Best regards,</p>';
v_body := v_body||'<p style=''color:black''>HR & Admin Department </p>';
-- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

update EMP_SOCICAL_INSURANCE
set
    SOC_INS_NUMBER = :P5_SOC_INS_NUMBER,
    PRI_HEAL_SERVICE = :P5_SOC_INS_PRI_HEAL,
    SOC_HOSPITAL_CODE = :P5_SOC_INS_HOS_CODE,
    SOC_HOU_NAME = :P5_SOC_INS_HOU_NAME,
    SOC_HOU_DOB = to_date(:P5_SOC_INS_HOU_DOB, 'DD/MM/YYYY'),
    SOC_HOU_ID = :P5_SOC_INS_HOU_ID,
    SOC_RELATIONSHIP = :P5_SOC_INS_RELATIONS,
    ATTACH_FILE = :P5_URL_SS,
    ATTACH_NAME = :P5_URL_NAME_SS
where EMPLOYEE_CODE = :APP_EMP_CODE;


-------------------------------------------------------
----- Send mail
    if is_changed then
    -- Send to HRs (for pilot)
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'phuongpham@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'trang.th@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'hravus@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'haitran@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- send tester
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'huyen.ptt@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thudang@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thi.tnh@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ngan.tranvu@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- Send to Devs
        -- SP_SENDGRID_EMAIL('ky.nguyenquoc@vus-etsc.edu.vn', 'quocky600@gmail.com', 'Cập nhật thay đổi thông tin NV '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ky.nguyenquoc@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'quocky600@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'tranquangkhanh2k1qv@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'khanhnguyendev@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
    end if;


end;

-- ----------------------------------------
-- Page: 5 - Personal Information > Process: Send email change info tab passport number > Source > PL/SQL Code

declare
    v_body clob:='';
    is_changed boolean := false;
begin

-- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
v_body := v_body||'<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐỀ XUẤT THAY ĐỔI THÔNG TIN CÁ NHÂN</h3>';
v_body := v_body||'<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – PERSONAL INFORMATION UPDATE LETTERS</h3>';
v_body := v_body||'<p style=''color:black;margin-top:20px''>Anh/Chị '||:P5_FULL_NAME||' thân mến,</p>';
v_body := v_body||'<p style=''color:black;margin-top:0''>Dear Mr/Ms. '||:P5_FULL_NAME||',</p>';
v_body := v_body||'<p style=''color:black''>Hệ thống nhận được đề nghị cập nhật thay đổi thông tin cá nhân của nhân viên sau:</p>';
v_body := v_body||'<p style=''color:black''>Employee Portal system has received a Personal information update request as below:</p>';
v_body := v_body||'<ul>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '||:P5_FULL_NAME||'</p>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '||:P5_EMPLOYEE_CODE||'</p>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Chức danh/ Title:</strong> '||:P5_TITLE||'</p>';
v_body := v_body||'</ul>';
v_body := v_body||'<table style=''border-collapse: collapse;border: 1px solid black;''>';
v_body := v_body||'<tr>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>MÃ SỐ ĐỊNH DANH</strong></p><p style=''color:black;margin:0;font-weight:400''><i>IDENTIFY NUMBER</i></p></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐÃ ĐĂNG KÝ</strong></p><p style=''color:black;margin:0;font-weight:400''><i>CURRENT PERSONAL INFORMATION</i></p></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐỀ NGHỊ THAY ĐỔI</strong></p><p style=''color:black;margin:0;font-weight:400''><i>PERSONAL INFORMATION UPDATE</i></p></th>';
v_body := v_body||'</tr>';
v_body := v_body||'<tr style=''border: 1px solid black;border-bottom: none;''><td style=''padding:0 10px; border-left: 1px solid black;''><p style=''color:black;margin:0;font-weight:700''>Thông tin CMND/CCCD/Hộ chiếu cá nhân </p><p style=''color:black;margin:0;font-style:italic;margin-bottom:10px''>Passport/ Hộ chiếu</p></td><td style=''padding:0 10px; border-left: 1px solid black;''></td><td style=''padding:0 10px; border-left: 1px solid black''></td></tr>';
for rec in (SELECT emp_id.ATTACH_FILE, emp_id.ATTACH_NAME,
    emp_id.ID_NUMBER,
    CASE
        WHEN emp_id.ISSUE_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
        -- ELSE TO_CHAR(emp_id.ISSUE_DATE, 'MM/DD/YYYY')
        ELSE TO_CHAR(emp_id.ISSUE_DATE, 'DD/MM/YYYY')
    END AS ISSUE_DATE,
    CASE
        WHEN emp_id.EXPIRATION_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
        -- ELSE TO_CHAR(emp_id.EXPIRATION_DATE, 'MM/DD/YYYY')
        ELSE TO_CHAR(emp_id.EXPIRATION_DATE, 'DD/MM/YYYY')
    END AS EXPIRATION_DATE,
    emp_id.ISSUE_PLACE
FROM
    EMP_ID_NUMBER emp_id
INNER JOIN
    EMPLOYEES e ON e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE
     e.USER_NAME = :APP_USER_NAME AND emp_id.ID_TYPE = 1
)loop
    if NVL(rec.ID_NUMBER,'$') <> NVL(:P5_ID_PP_NUMBER_1, '$') then
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Số Hộ chiếu / Passport number</td><td style=''padding:0 10px; border-right: 1px solid black;''>'||rec.ID_NUMBER||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'||:P5_ID_PP_NUMBER_1||'</td></tr>';
        is_changed := true;
    END IF;

    -- if rec.ISSUE_DATE <> :P5_ISSUE_DATE_ID_1 then
    IF rec.ISSUE_DATE <> :P5_ISSUE_DATE_ID_1 
    OR (rec.ISSUE_DATE IS NULL AND :P5_ISSUE_DATE_ID_1 IS NOT NULL) 
    THEN
    --if (rec.ISSUE_DATE <> :P5_ISSUE_DATE_ID_1) OR (rec.ISSUE_DATE is null and :P5_ISSUE_DATE_ID_1 is not null) then
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ngày cấp Hộ chiếu / Issue date of Passport</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.ISSUE_DATE ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| :P5_ISSUE_DATE_ID_1 ||'</td></tr>';
        is_changed := true;
    END IF;
    
    -- if rec.EXPIRATION_DATE <> to_char(:P5_EXP_DATE_ID_1, 'MM/DD/YYYY') then
    --if NVL(rec.EXPIRATION_DATE, '$') <> NVL(to_char(to_date(:P5_EXP_DATE_ID_1, 'DD/MM/YYYY'), 'DD/MM/YYYY'), '$') then
    IF rec.EXPIRATION_DATE <> :P5_EXP_DATE_ID_1
    OR (rec.EXPIRATION_DATE IS NULL AND :P5_EXP_DATE_ID_1 IS NOT NULL)
    THEN
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ngày hết hạn Hộ chiếu / Expiration date of Passport</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.EXPIRATION_DATE ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| :P5_EXP_DATE_ID_1 ||'</td></tr>';
        is_changed := true;
    END IF;
    
     if NVL(rec.ISSUE_PLACE,'$') <> NVL(:P5_PLACE_DATE_ID_1, '$') then
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Nơi cấp Hộ chiếu / Issue place of Passport</td><td style=''padding:0 10px; border-right: 1px solid black;''>'||rec.ISSUE_PLACE||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'||:P5_PLACE_DATE_ID_1||'</td></tr>';
        is_changed := true;
    END IF;
    
    --   if rec.ATTACH_FILE <> :P5_ID_NUM_ATTACH_1 OR (rec.ATTACH_FILE IS NULL AND :P5_ID_NUM_ATTACH_1 IS NOT NULL)  then
      if NVL(rec.ATTACH_FILE, '$') <> NVL(:P5_ID_NUM_ATTACH_1, '$') then
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Đính kèm / Attachment</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| to_href_html(rec.ATTACH_FILE, rec.ATTACH_NAME) ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| to_href_html(:P5_URL_1, :P5_URL_NAME_1) ||'</td></tr>';
        is_changed := true;
    END IF;
    
end loop;
v_body := v_body||'</table>';
v_body := v_body||'<p style=''color:black''>Anh/Chị vui lòng click tại đây để kiểm tra thông tin và xác nhận cập nhật vào hệ thống D365 HRM.</p>';
v_body := v_body||'<p style=''color:black''>Please click Link to review and update information to D365 HRM System.</p>';
v_body := v_body||'<p style=''color:black''>Trân trọng,</p>';
v_body := v_body||'<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
v_body := v_body||'<p style=''color:black''>Best regards,</p>';
v_body := v_body||'<p style=''color:black''>HR & Admin Department </p>';
-- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

UPDATE EMP_ID_NUMBER
SET
    ID_NUMBER = :P5_ID_PP_NUMBER_1,
    ISSUE_DATE = to_date(:P5_ISSUE_DATE_ID_1, 'DD/MM/YYYY'),
    EXPIRATION_DATE =  to_date(:P5_EXP_DATE_ID_1, 'DD/MM/YYYY'),
    ISSUE_PLACE = :P5_PLACE_DATE_ID_1,
    ATTACH_FILE = :P5_URL_1,
    ATTACH_NAME = :P5_URL_NAME_1
WHERE ID_TYPE = 1 and EMPLOYEE_CODE = :APP_EMP_CODE;

-------------------------------------------------------
----- Send mail
    if is_changed then
    -- Send to HRs (for pilot)
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'phuongpham@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'trang.th@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'hravus@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'haitran@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- send tester
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'huyen.ptt@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thudang@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thi.tnh@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ngan.tranvu@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- Send to Devs
        -- SP_SENDGRID_EMAIL('ky.nguyenquoc@vus-etsc.edu.vn', 'quocky600@gmail.com', 'Cập nhật thay đổi thông tin NV '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ky.nguyenquoc@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'quocky600@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'tranquangkhanh2k1qv@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'khanhnguyendev@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
    end if;
end;

-- ----------------------------------------
-- Page: 5 - Personal Information > Process: Send email change info tab iden number > Source > PL/SQL Code

declare
    v_body clob:='';
    is_changed boolean := false;
    v_start_time NUMBER;
    v_end_time NUMBER;
    r_inserted_status number; 
BEGIN
    -- v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second
    -- LOOP
    --     v_end_time := DBMS_UTILITY.GET_TIME;
    --     EXIT WHEN (v_end_time - v_start_time) > (2 * 100);  -- 5 seconds
    -- END LOOP;

    -- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
    v_body := v_body||'<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐỀ XUẤT THAY ĐỔI THÔNG TIN CÁ NHÂN</h3>';
    v_body := v_body||'<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – PERSONAL INFORMATION UPDATE LETTERS</h3>';
    v_body := v_body||'<p style=''color:black;margin-top:20px''>Anh/Chị '||:P5_FULL_NAME||' thân mến,</p>';
    v_body := v_body||'<p style=''color:black;margin-top:0''>Dear Mr/Ms. '||:P5_FULL_NAME||',</p>';
    v_body := v_body||'<p style=''color:black''>Hệ thống nhận được đề nghị cập nhật thay đổi thông tin cá nhân của nhân viên sau:</p>';
    v_body := v_body||'<p style=''color:black''>Employee Portal system has received a Personal information update request as below:</p>';
    v_body := v_body||'<ul>';
    v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '||:P5_FULL_NAME||'</p>';
    v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '||:P5_EMPLOYEE_CODE||'</p>';
    v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Chức danh/ Title:</strong> '||:P5_TITLE||'</p>';
    v_body := v_body||'</ul>';
    v_body := v_body||'<table style=''border-collapse: collapse;border: 1px solid black;''>';
    v_body := v_body||'<tr>';
    v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>MÃ SỐ ĐỊNH DANH</strong></p><p style=''color:black;margin:0;font-weight:400''><i>IDENTIFY NUMBER</i></p></th>';
    v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐÃ ĐĂNG KÝ</strong></p><p style=''color:black;margin:0;font-weight:400''><i>CURRENT PERSONAL INFORMATION</i></p></th>';
    v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐỀ NGHỊ THAY ĐỔI</strong></p><p style=''color:black;margin:0;font-weight:400''><i>PERSONAL INFORMATION UPDATE</i></p></th>';
    v_body := v_body||'</tr>';
    v_body := v_body||'<tr style=''border: 1px solid black;border-bottom: none;''><td style=''padding:0 10px; border-left: 1px solid black;''><p style=''color:black;margin:0;font-weight:700''>Thông tin CMND/CCCD cá nhân </p><p style=''color:black;margin:0;font-style:italic;margin-bottom:10px''>Identification number</p></td><td style=''padding:0 10px; border-left: 1px solid black;''></td><td style=''padding:0 10px; border-left: 1px solid black''></td></tr>';
    FOR rec IN (
        SELECT
            emp_id.ID_NUMBER,
            CASE
                WHEN emp_id.ISSUE_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN NULL
                -- ELSE TO_CHAR(emp_id.ISSUE_DATE, 'MM/DD/YYYY')
                ELSE TO_CHAR(emp_id.ISSUE_DATE, 'DD/MM/YYYY')
            END AS ISSUE_DATE,
            CASE
                WHEN emp_id.EXPIRATION_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN NULL
                -- ELSE TO_CHAR(emp_id.EXPIRATION_DATE, 'MM/DD/YYYY')
                ELSE TO_CHAR(emp_id.EXPIRATION_DATE, 'DD/MM/YYYY')
            END AS EXPIRATION_DATE,
            emp_id.ISSUE_PLACE,
            emp_id.ATTACH_FILE,
            emp_id.ATTACH_NAME
        FROM
            EMP_ID_NUMBER emp_id
        INNER JOIN
            EMPLOYEES e ON e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
        WHERE
            emp_id.ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME
    )
    LOOP
        -- IF rec.ID_NUMBER <> :P5_ID_PP_NUMBER OR (rec.ID_NUMBER IS NULL AND :P5_ID_PP_NUMBER IS NOT NULL) OR (rec.ID_NUMBER IS NOT NULL AND :P5_ID_PP_NUMBER IS NULL) THEN
        IF NVL(rec.ID_NUMBER,'$') <> NVL(:P5_ID_PP_NUMBER, '$') THEN
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Số CMND/CCCD / Identify number</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.ID_NUMBER ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| :P5_ID_PP_NUMBER ||'</td></tr>';
            is_changed := true;
        END IF;
        
        -- IF rec.ISSUE_DATE <> to_date(:P5_ISSUE_DATE_ID, 'DD/MM/YYYY') OR (rec.ISSUE_DATE IS NULL AND :P5_ISSUE_DATE_ID IS NOT NULL) OR (rec.ISSUE_DATE IS NOT NULL AND :P5_ISSUE_DATE_ID IS NULL) THEN
        -- IF TO_CHAR(TO_DATE(rec.ISSUE_DATE, 'MM/DD/YYYY'), 'DD/MM/YYYY') <> :P5_ISSUE_DATE_ID 
        IF rec.ISSUE_DATE <> :P5_ISSUE_DATE_ID 
        OR (rec.ISSUE_DATE IS NULL AND :P5_ISSUE_DATE_ID IS NOT NULL)
        THEN
            -- v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ngày cấp CMND/CCCD / Issue date</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| to_char(to_date(rec.ISSUE_DATE, 'MM/DD/YYYY'), 'DD/MM/YYYY') ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| :P5_ISSUE_DATE_ID ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ngày cấp CMND/CCCD / Issue date</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.ISSUE_DATE ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| :P5_ISSUE_DATE_ID ||'</td></tr>';
            is_changed := true;
        END IF;
        
        -- IF rec.EXPIRATION_DATE <> to_date(:P5_EXP_DATE_ID, 'DD/MM/YYYY') OR (rec.EXPIRATION_DATE IS NULL AND :P5_EXP_DATE_ID IS NOT NULL) OR (rec.EXPIRATION_DATE IS NOT NULL AND :P5_EXP_DATE_ID IS NULL) THEN
        -- IF rec.EXPIRATION_DATE <> TO_CHAR(TO_DATE(:P5_EXP_DATE_ID, 'DD/MM/YYYY'), 'MM/DD/YYYY')
        IF rec.EXPIRATION_DATE <> :P5_EXP_DATE_ID
        OR (rec.EXPIRATION_DATE IS NULL AND :P5_EXP_DATE_ID IS NOT NULL)
        THEN
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Ngày hết hạn CMND/CCCD / Expiration date</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.EXPIRATION_DATE ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| :P5_EXP_DATE_ID ||'</td></tr>';
            is_changed := true;
        END IF;
        
        -- IF rec.ISSUE_PLACE <> :P5_PLACE_DATE_ID OR (rec.ISSUE_PLACE IS NULL AND :P5_PLACE_DATE_ID IS NOT NULL) OR (rec.ISSUE_PLACE IS NOT NULL AND :P5_PLACE_DATE_ID IS NULL) THEN
        IF NVL(rec.ISSUE_PLACE,'$') <> NVL(:P5_PLACE_DATE_ID, '$') THEN
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Nơi cấp CMND/CCCD / Place of Issue</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.ISSUE_PLACE ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| :P5_PLACE_DATE_ID ||'</td></tr>';
            is_changed := true;
        END IF;
        
        -- IF rec.ATTACH_FILE <> :P5_ID_NUM_ATTACH OR (rec.ATTACH_FILE IS NULL AND :P5_ID_NUM_ATTACH IS NOT NULL)  THEN
        IF NVL(rec.ATTACH_FILE, '$') <> NVL(:P5_ID_NUM_ATTACH, '$') THEN
            -- v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Đính kèm / Attachment</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| to_href_html(rec.ATTACH_FILE, rec.ATTACH_NAME) ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| :P5_ID_NUM_ATTACH ||'</td></tr>';
            -- v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Đính kèm / Attachment</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| to_href_html(rec.ATTACH_FILE, rec.ATTACH_NAME) ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| :P5_ID_NUM_ATTACH ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Đính kèm / Attachment</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| to_href_html(rec.ATTACH_FILE, rec.ATTACH_NAME) ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| to_href_html(:P5_URL, :P5_URL_NAME) ||'</td></tr>';
            is_changed := true;
        END IF;
    END LOOP;
    v_body := v_body||'</table>';
    v_body := v_body||'<p style=''color:black''>Anh/Chị vui lòng click tại đây để kiểm tra thông tin và xác nhận cập nhật vào hệ thống D365 HRM.</p>';
    v_body := v_body||'<p style=''color:black''>Please click Link to review and update information to D365 HRM System.</p>';
    v_body := v_body||'<p style=''color:black''>Trân trọng,</p>';
    v_body := v_body||'<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
    v_body := v_body||'<p style=''color:black''>Best regards,</p>';
    v_body := v_body||'<p style=''color:black''>HR & Admin Department </p>';
    -- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';
    -- v_body := v_body||'<img style=''width:100%'' src=''https://vus.edu.vn/wp-content/uploads/2023/11/header-email.png''></img>';

    v_start_time := DBMS_UTILITY.GET_TIME;  -- Current time in 1/100ths of a second
    LOOP
        v_end_time := DBMS_UTILITY.GET_TIME;
        EXIT WHEN (v_end_time - v_start_time) > (1 * 100);  -- 5 seconds
    END LOOP;

    UPDATE EMP_ID_NUMBER
    SET
        ID_NUMBER = :P5_ID_PP_NUMBER,
        ISSUE_DATE = to_date(:P5_ISSUE_DATE_ID, 'DD/MM/YYYY'),
        EXPIRATION_DATE = to_date(:P5_EXP_DATE_ID, 'DD/MM/YYYY'),
        ISSUE_PLACE = :P5_PLACE_DATE_ID,
        ATTACH_FILE = :P5_URL,
        ATTACH_NAME = :P5_URL_NAME
    WHERE ID_TYPE = 0 and EMPLOYEE_CODE = :APP_EMP_CODE;

    -------------------------------------------------------
    ----- Send mail
    if is_changed then
    -- Send to HRs (for pilot)
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'phuongpham@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'trang.th@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'hravus@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'haitran@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- send tester
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'huyen.ptt@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thudang@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thi.tnh@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ngan.tranvu@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- Send to Devs
        -- SP_SENDGRID_EMAIL('ky.nguyenquoc@vus-etsc.edu.vn', 'quocky600@gmail.com', 'Cập nhật thay đổi thông tin NV '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ky.nguyenquoc@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'quocky600@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'tranquangkhanh2k1qv@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'khanhnguyendev@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'huynd@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
    end if;
end;

-- ----------------------------------------
-- Page: 5 - Personal Information > Process: Send email change info tab bank > Source > PL/SQL Code

declare
    v_body clob:='';
    is_changed boolean := false;
begin

-- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
v_body := v_body||'<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐỀ XUẤT THAY ĐỔI THÔNG TIN CÁ NHÂN</h3>';
v_body := v_body||'<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – PERSONAL INFORMATION UPDATE LETTERS</h3>';
v_body := v_body||'<p style=''color:black;margin-top:20px''>Anh/Chị '||:P5_FULL_NAME||' thân mến,</p>';
v_body := v_body||'<p style=''color:black;margin-top:0''>Dear Mr/Ms. '||:P5_FULL_NAME||',</p>';
v_body := v_body||'<p style=''color:black''>Hệ thống nhận được đề nghị cập nhật thay đổi thông tin cá nhân của nhân viên sau:</p>';
v_body := v_body||'<p style=''color:black''>Employee Portal system has received a Personal information update request as below:</p>';
v_body := v_body||'<ul>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '||:P5_FULL_NAME||'</p>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '||:P5_EMPLOYEE_CODE||'</p>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Chức danh/ Title:</strong> '||:P5_TITLE||'</p>';
v_body := v_body||'</ul>';
v_body := v_body||'<table style=''border-collapse: collapse;border: 1px solid black;''>';
v_body := v_body||'<tr>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>TÀI KHOẢN NGÂN HÀNG</strong></p><p style=''color:black;margin:0;font-weight:400''><i>BANK ACCOUNT</i></p></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐÃ ĐĂNG KÝ</strong></p><p style=''color:black;margin:0;font-weight:400''><i>CURRENT PERSONAL INFORMATION</i></p></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐỀ NGHỊ THAY ĐỔI</strong></p><p style=''color:black;margin:0;font-weight:400''><i>PERSONAL INFORMATION UPDATE</i></p></th>';
v_body := v_body||'</tr>';
v_body := v_body||'<tr style=''border: 1px solid black;border-bottom: none;''><td style=''padding:0 10px; border-left: 1px solid black;''><p style=''color:black;margin:0;font-weight:700''>Thông tin số tài khoản ngân hàng</p><p style=''color:black;margin:0;font-style:italic;margin-bottom:10px''>Bank account</p></td><td style=''padding:0 10px; border-left: 1px solid black;''></td><td style=''padding:0 10px; border-left: 1px solid black''></td></tr>';
FOR rec IN (
    SELECT e.*
    FROM EMP_BANK e
    WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE
)
LOOP
    -- IF nvl(rec.BANK_ACC_NUM, '$') <> nvl(:P5_BANK_ACC_NUM, '$')
    -- OR nvl(rec.BANK_BRANCH, '$') <> nvl(:P5_BANK_BRANCH, '$')
    -- THEN
    --     v_body := v_body||'<tr style=''border: 1px solid black;border-bottom: none;''><td style=''padding:0 10px; border-left: 1px solid black;''><p style=''color:black;margin:0;font-weight:700''>Thông tin số tài khoản ngân hàng</p><p style=''color:black;margin:0;font-style:italic;margin-bottom:10px''>Bank account</p></td><td style=''padding:0 10px; border-left: 1px solid black;''></td><td style=''padding:0 10px; border-left: 1px solid black''></td></tr>';
    -- END IF;

    -- IF rec.BANK_ACC_NUM <> :P5_BANK_ACC_NUM OR (rec.BANK_ACC_NUM IS NULL AND :P5_BANK_ACC_NUM IS NOT NULL) OR (rec.BANK_ACC_NUM IS NOT NULL AND :P5_BANK_ACC_NUM IS NULL) THEN
    IF nvl(rec.BANK_ACC_NUM, '$') <> nvl(:P5_BANK_ACC_NUM, '$') THEN
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Bank account number / Số tài khoản ngân hàng</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.BANK_ACC_NUM ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| :P5_BANK_ACC_NUM ||'</td></tr>';
        is_changed := true;
    END IF;
    
    -- IF rec.BANK_NAME <> :P5_BANK_NAME OR (rec.BANK_NAME IS NULL AND :P5_BANK_NAME IS NOT NULL) OR (rec.BANK_NAME IS NOT NULL AND :P5_BANK_NAME IS NULL) THEN
    --     v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Bank Name</td><td style=''padding:0 10px; border-right: 1px solid black;''>'||NVL(rec.BANK_NAME, 'NULL')||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'||NVL(:P5_BANK_NAME, 'NULL')||'</td></tr>';
    --     is_changed := true;
    -- END IF;
        
    -- IF rec.BANK_BRANCH <> :P5_BANK_BRANCH OR (rec.BANK_BRANCH IS NULL AND :P5_BANK_BRANCH IS NOT NULL) OR (rec.BANK_BRANCH IS NOT NULL AND :P5_BANK_BRANCH IS NULL) THEN
    IF nvl(rec.BANK_BRANCH, '$') <> nvl(:P5_BANK_BRANCH, '$') THEN
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;border-bottom: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Bank branch / Chi nhánh ngân hàng</td><td  style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.BANK_BRANCH ||'</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| :P5_BANK_BRANCH ||'</td></tr>';
        is_changed := true;
    END IF;
END LOOP;
v_body := v_body||'</table>';
v_body := v_body||'<p style=''color:black''>Anh/Chị vui lòng click tại đây để kiểm tra thông tin và xác nhận cập nhật vào hệ thống D365 HRM.</p>';
v_body := v_body||'<p style=''color:black''>Please click Link to review and update information to D365 HRM System.</p>';
v_body := v_body||'<p style=''color:black''>Trân trọng,</p>';
v_body := v_body||'<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
v_body := v_body||'<p style=''color:black''>Best regards,</p>';
v_body := v_body||'<p style=''color:black''>HR & Admin Department </p>';
-- v_body := v_body||'<img style='';width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';


-- UPDATE
UPDATE EMP_BANK
SET 
    BANK_ACC_NUM = :P5_BANK_ACC_NUM,
    BANK_BRANCH = :P5_BANK_BRANCH
WHERE 
    EMPLOYEE_CODE = :APP_EMP_CODE;

-------------------------------------------------------
----- Send mail
if is_changed then
    -- Send to HRs
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'phuongpham@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'trang.th@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'huyen.ptt@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thudang@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'hravus@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        
    -- send tester
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ngan.tranvu@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thi.tnh@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'haitran@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- Send to Devs
        -- SP_SENDGRID_EMAIL('ky.nguyenquoc@vus-etsc.edu.vn', 'quocky600@gmail.com', 'Cập nhật thay đổi thông tin NV '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ky.nguyenquoc@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'quocky600@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'tranquangkhanh2k1qv@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'khanhnguyendev@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
end if;

end;

-- ----------------------------------------
-- Page: 5 - Personal Information > Process: Send email change info tab personal > Source > PL/SQL Code

declare
    v_body clob:='';
    is_changed boolean := false;
    relationship_old nvarchar2(200);
    relationship_new nvarchar2(200);
begin
-- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
v_body := v_body||'<h3 style=''color:black;text-align:center''>[PHÒNG NHÂN SỰ HÀNH CHÍNH - VUS] – ĐỀ XUẤT THAY ĐỔI THÔNG TIN CÁ NHÂN</h3>';
v_body := v_body||'<h3 style=''color:black;text-align:center''>[HRA DEPARTMENT - VUS] – PERSONAL INFORMATION UPDATE LETTERS</h3>';
v_body := v_body||'<p style=''color:black;margin-top:20px''>Anh/Chị '||:P5_FULL_NAME||' thân mến,</p>';
v_body := v_body||'<p style=''color:black;margin-top:0''>Dear Mr/Ms. '||:P5_FULL_NAME||',</p>';
v_body := v_body||'<p style=''color:black''>Hệ thống nhận được đề nghị cập nhật thay đổi thông tin cá nhân của nhân viên sau:</p>';
v_body := v_body||'<p style=''color:black''>Employee Portal system has received a Personal information update request as below:</p>';
v_body := v_body||'<ul>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Họ và tên/ Full name:</strong> '||:P5_FULL_NAME||'</p>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Mã số nhân viên/ Employee Code:</strong> '||:P5_EMPLOYEE_CODE||'</p>';
v_body := v_body||'<p style=''color:black''><strong style=''color:black''>- Chức danh/ Title:</strong> '||:P5_TITLE||'</p>';
v_body := v_body||'</ul>';
v_body := v_body||'<table style=''border-collapse: collapse;border: 1px solid black;''>';
v_body := v_body||'<tr>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>CÁ NHÂN</strong></p><p style=''color:black;margin:0;font-weight:400''><i>PERSONAL</i></p></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐÃ ĐĂNG KÝ</strong></p><p style=''color:black;margin:0;font-weight:400''><i>CURRENT PERSONAL INFORMATION</i></p></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐỀ NGHỊ THAY ĐỔI</strong></p><p style=''color:black;margin:0;font-weight:400''><i>PERSONAL INFORMATION UPDATE</i></p></th>';
v_body := v_body||'</tr>';

FOR rec IN (
    SELECT 
        --e.*, 
        e.PHONE_NUMBER,
        e.PERSONAL_EMAIL,
        e.PERMANENT_ADDRESS,
        e.TEMPORARY_ADDRESS,
        emc.RELATION_SHIP, 
        emc.EME_FULL_NAME AS emc_name,
        emc.EME_PHONE_NUMBER AS emc_phone
    FROM EMPLOYEES e
    JOIN EMP_EMERGENCY_CONTACT emc ON e.EMPLOYEE_CODE = emc.EMPLOYEE_CODE
    WHERE e.EMPLOYEE_CODE = :APP_EMP_CODE
)
LOOP

    -- Query relationship value
    SELECT NVL(MAX(RELATIONSHIP_TYPE_DESCRIPTION), ' ') 
    INTO relationship_old
    FROM EMP_RELATIONSHIP 
    WHERE rec.RELATION_SHIP = RELATIONSHIP_TYPE_ID;

    select NVL(MAX(RELATIONSHIP_TYPE_DESCRIPTION), ' ') into relationship_new 
    from EMP_RELATIONSHIP where :P5_EME_RELATIONSHIP = RELATIONSHIP_TYPE_ID;

    IF nvl(rec.PHONE_NUMBER,'$') <> nvl(:P5_PHONE_NUMBER,'$')
    OR nvl(rec.PERSONAL_EMAIL,'$') <> nvl(:P5_PERSONAL_EMAIL ,'$')
    OR nvl(rec.PERMANENT_ADDRESS,'$') <> nvl(:P5_PERMANENT_ADDRESS ,'$')  
    OR nvl(rec.TEMPORARY_ADDRESS,'$') <> nvl(:P5_TEMPORARY_ADDRESS ,'$')  
    THEN
        v_body := v_body||'<tr style=''border: 1px solid black;border-bottom:none;''><td style=''padding:0 10px; border-left: 1px solid black;''><p style=''color:black;margin:0;font-weight:700''>Thông tin cá nhân</p><p style=''color:black;margin:0;font-style:italic;margin-bottom:10px''>Personal information</p></td><td style=''padding:0 10px; border-left: 1px solid black;''></td><td style=''padding:0 10px; border-left: 1px solid black''></td></tr>';
    END IF;

    IF nvl(rec.PHONE_NUMBER,'$') <> nvl(:P5_PHONE_NUMBER,'$') 
    THEN
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Số điện thoại / Phone number</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.PHONE_NUMBER ||'</td><td style=''padding:0 10px;''>'|| :P5_PHONE_NUMBER ||'</td></tr>';
        is_changed := true;
    END IF;
    
    IF nvl(rec.PERSONAL_EMAIL,'$') <> nvl(:P5_PERSONAL_EMAIL ,'$')
    THEN
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''> Email cá nhân / Personal email </td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.PERSONAL_EMAIL ||'</td><td style=''padding:0 10px;''>'|| :P5_PERSONAL_EMAIL ||'</td></tr>';
        is_changed := true; 
    END IF;
    
    IF nvl(rec.PERMANENT_ADDRESS,'$') <> nvl(:P5_PERMANENT_ADDRESS ,'$')  
    THEN
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Địa chỉ thường trú / Permanent address</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.PERMANENT_ADDRESS ||'</td><td style=''padding:0 10px;''>'|| :P5_PERMANENT_ADDRESS ||'</td></tr>';
        is_changed := true;
    END IF;
    
    IF nvl(rec.TEMPORARY_ADDRESS,'$') <> nvl(:P5_TEMPORARY_ADDRESS ,'$')
    THEN
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;border-bottom: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Địa chỉ tạm trú / Temporary residence address</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.TEMPORARY_ADDRESS ||'</td><td style=''padding:0 10px;''>'|| :P5_TEMPORARY_ADDRESS ||'</td></tr>';
        is_changed := true;
    END IF;   

    IF nvl(rec.emc_name,'$') <> nvl(:P5_EME_NAME ,'$')
    OR nvl(rec.emc_phone,'$') <> nvl(:P5_EME_PHONE_NUMBER ,'$')
    OR nvl(rec.RELATION_SHIP,'$') <> nvl(:P5_EME_RELATIONSHIP ,'$')
    THEN
        v_body := v_body||'<tr style=''border: 1px solid black;border-bottom: none;''><td style=''padding:0 10px; border-left: 1px solid black;''><p style=''color:black;margin-top:20px;margin-bottom:0;font-weight:700''>Thông tin người liên hệ khẩn cấp</p><p style=''color:black;margin:0;font-style:italic;margin-bottom:10px''>Person of emergency contact information</p></td><td style=''padding:0 10px; border-left: 1px solid black;''></td><td style=''padding:0 10px; border-left: 1px solid black;''></td></tr>';
    END IF;
    
    IF nvl(rec.emc_name,'$') <> nvl(:P5_EME_NAME ,'$')
    THEN
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''padding:0 10px; border-right: 1px solid black;''>Họ và tên / Full name </td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.emc_name ||'</td><td style=''padding:0 10px;''>'|| :P5_EME_NAME ||'</td></tr>';
        is_changed := true;
    END IF;    

    IF nvl(rec.emc_phone,'$') <> nvl(:P5_EME_PHONE_NUMBER ,'$')
    THEN
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;border-top: none;''><td style=''padding:0 10px; border-right: 1px solid black;''>Số điện thoại / Phone number</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.emc_phone ||'</td><td style=''padding:0 10px;''>'|| :P5_EME_PHONE_NUMBER ||'</td></tr>';
        is_changed := true;
    END IF;   

    IF nvl(rec.RELATION_SHIP,'$') <> nvl(:P5_EME_RELATIONSHIP ,'$')
    THEN
        -- v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;border-top: none;''><td style=''padding:0 10px; border-right: 1px solid black;''>Mối quan hệ / Relationship</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| rec.RELATION_SHIP ||'</td><td style=''padding:0 10px;''>'|| :P5_EME_RELATIONSHIP ||'</td></tr>';
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;border-top: none;''><td style=''padding:0 10px; border-right: 1px solid black;''>Mối quan hệ / Relationship</td><td style=''padding:0 10px; border-right: 1px solid black;''>'|| relationship_old ||'</td><td style=''padding:0 10px;''>'|| relationship_new ||'</td></tr>';
        is_changed := true;
    END IF;    
END LOOP;

v_body := v_body||'</table>';
v_body := v_body||'<p style=''color:black''>Anh/Chị vui lòng click tại đây để kiểm tra thông tin và xác nhận cập nhật vào hệ thống D365 HRM.</p>';
v_body := v_body||'<p style=''color:black''>Please click Link to review and update information to D365 HRM System.</p>';
v_body := v_body||'<p style=''color:black''>Trân trọng,</p>';
v_body := v_body||'<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
v_body := v_body||'<p style=''color:black''>Best regards,</p>';
v_body := v_body||'<p style=''color:black''>HR & Admin Department </p>';
-- v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';


-- Update [EMPLOYEES]
UPDATE EMPLOYEES
SET
    PHONE_NUMBER = :P5_PHONE_NUMBER,
    PERSONAL_EMAIL = :P5_PERSONAL_EMAIL,
    PERMANENT_ADDRESS = :P5_PERMANENT_ADDRESS,
    TEMPORARY_ADDRESS = :P5_TEMPORARY_ADDRESS
WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

UPDATE EMP_EMERGENCY_CONTACT
SET
    EME_FULL_NAME = :P5_EME_NAME,
    EME_PHONE_NUMBER = :P5_EME_PHONE_NUMBER,
    RELATION_SHIP = :P5_EME_RELATIONSHIP
WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

    if is_changed then
    -- Send to HRs (for pilot)
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'phuongpham@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'trang.th@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'hravus@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'haitran@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- send tester
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'huyen.ptt@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thudang@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thi.tnh@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ngan.tranvu@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);

    -- Send to Devs
        -- SP_SENDGRID_EMAIL('ky.nguyenquoc@vus-etsc.edu.vn', 'quocky600@gmail.com', 'Cập nhật thay đổi thông tin NV '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ky.nguyenquoc@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'quocky600@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'tranquangkhanh2k1qv@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'khanhnguyendev@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
        SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thviet615@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
    end if;

end;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_DEFAULT_IMAGES_URL > Default > SQL Query

SELECT ATTACH_FILE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_DEFAULT_IMAGES_NAME > Default > SQL Query

SELECT ATTACH_NAME
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_DEFAULT_IMAGES_URL_SS > Default > SQL Query

select ATTACH_FILE from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_COMPANY_EMAIL > Default > SQL Query

select USER_NAME from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_DEFAULT_IMAGES_NAME_SS > Default > SQL Query

select ATTACH_NAME from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_TITLE > Default > SQL Query

select TITLE from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_PERSONAL_EMAIL > Default > SQL Query

select PERSONAL_EMAIL from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_PHONE_NUMBER > Default > SQL Query

select PHONE_NUMBER from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_TERMINATE_DATE > Default > SQL Query

-- SELECT
--   CASE
--     WHEN TERMINATE_DATE = TO_DATE('12/31/2154', 'MM/DD/YYYY') THEN 'Never'
--     ELSE TO_CHAR(TERMINATE_DATE, 'MM/DD/YYYY')
--   END AS TERMINATE_DATE
-- FROM EMPLOYEES
-- WHERE USER_NAME = :APP_USER_NAME;

-- SELECT
-- TERMINATE_DATE
-- FROM EMPLOYEES
-- WHERE USER_NAME = :APP_USER_NAME;

SELECT
  CASE
    WHEN TERMINATE_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
    ELSE TO_CHAR(TERMINATE_DATE, 'DD/MM/YYYY')
  END AS TERMINATE_DATE
FROM EMPLOYEES
WHERE USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_DEFAULT_IMAGES_URL_1 > Default > SQL Query

SELECT ATTACH_FILE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_SOC_INS_RELATIONS > Default > SQL Query

select SOC_RELATIONSHIP from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_START_DATE > Default > SQL Query

SELECT
  CASE
    WHEN START_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
    ELSE TO_CHAR(START_DATE, 'DD/MM/YYYY')
  END AS START_DATE
FROM EMPLOYEES
WHERE USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_SOC_INS_HOU_ID > Default > SQL Query

select SOC_HOU_ID from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_PLACE_DATE_ID > Default > SQL Query

SELECT ISSUE_PLACE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_PLACE_DATE_ID > List of Values > SQL Query

SELECT LIA_NAME, LIA_NAME as ID FROM LIST_ISSUING_AGENCY;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_PER_DETAIL > Default > SQL Query

select PERSONAL_EMAIL from employees where PERSONAL_EMAIL = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_DEFAULT_IMAGES_NAME_1 > Default > SQL Query

SELECT ATTACH_NAME
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_SOC_INS_HOU_DOB > Default > SQL Query

select 
    case 
        when SOC_HOU_DOB = to_date('1/1/1900', 'MM/DD/YYYY') then ''
        else TO_CHAR(SOC_HOU_DOB, 'DD/MM/YYYY') 
    end as SOC_HOU_DOB
from EMP_SOCICAL_INSURANCE EMP_SI 
where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME);

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_NEW_ID > Default > PL/SQL Function Body

declare
    -- biến để kiểm tra đoạn json
    emp_education_id number;
    l_numrows number;
    new_string apex_t_number;
    temp2 date;
begin
    -- APEX_JSON.PARSE(:P5_EMP_CURRENT_EDUCATION);
    -- -- biến đếm số object của json
    -- l_numrows := APEX_JSON.GET_COUNT(p_path => '.');

    -- if l_numrows > 0 then
    --     for i in 1..l_numrows loop
    --         emp_education_id := to_number(APEX_JSON.get_varchar2(p_path => '[%d].id', p0 => i));
    --     end loop;
    -- end if;
    new_string := apex_t_number();
    for rec in (select cer.id 
                from EMP_CERTIFICATE cer
                INNER JOIN 
                EMPLOYEES e ON cer.EMPLOYEE_CODE = e.EMPLOYEE_CODE
                WHERE e.USER_NAME = :APP_USER_NAME) loop
        new_string.extend();
        new_string(new_string.COUNT) := rec.id;
    end loop;

    --return new_string(1);
end;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_GENDER > Default > SQL Query

SELECT 
    CASE 
        WHEN GENDER = 0 THEN 'Others'
        WHEN GENDER = 1 THEN 'Male'
        WHEN GENDER = 2 THEN 'Female'
        ELSE 'Unknown' -- Optional, handle any other values not in the mapping
    END AS GENDER_LABEL
FROM 
    employees
WHERE 
    USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_SOC_INS_HOU_NAME > Default > SQL Query

select SOC_HOU_NAME from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_EXP_DATE_ID > Default > SQL Query

SELECT
  CASE
    WHEN EXPIRATION_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
    ELSE TO_CHAR(EXPIRATION_DATE, 'DD/MM/YYYY')
  END AS EXPIRATION_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_OLD_ID > Default > PL/SQL Function Body

declare
    -- biến để kiểm tra đoạn json
    o_id number;
    l_numrows number;
    o_certificate_type nvarchar2(1000);
    temp date;
begin
    APEX_JSON.PARSE(:P5_EMP_CURRENT_CERTIFICATES);

    l_numrows := APEX_JSON.GET_COUNT(p_path => '.');

    if l_numrows > 0 then
        for i in 1..l_numrows loop
            -- temp := to_date(APEX_JSON.get_varchar2(p_path => '[%d].graduated_date', p0 => i), 'YYYY-MM-DD"T"HH24:MI:SS');
            -- old_graduated_date := to_char(temp, 'DD/MM/YYYY');
            --TO_CHAR(TO_DATE(apex_json.get_varchar2('[%d].BirthDate', i), 'YYYY-MM-DD"T"HH24:MI:SS'), 'MM/DD/YYYY')
            -- n_date := TO_DATE(l_json_values('graduated_date').get_varchar2, 'YYYY-MM-DD"T"HH24:MI:SS');
        
            -- -- In ngày với định dạng 'MM/DD/YYYY'
            -- DBMS_OUTPUT.put_line('Converted Date: ' || TO_CHAR(n_date, 'MM/DD/YYYY'));
            o_id := to_number(APEX_JSON.get_varchar2(p_path => '[%d].id', p0 => i));
            -- o_certificate_type := APEX_JSON.get_varchar2(p_path => '[%d].certificate_type', p0 => i);
            -- temp := to_date(APEX_JSON.get_varchar2(p_path => '[%d].start_date', p0 => i), 'YYYY-MM-DD"T"HH24:MI:SS');
            -- o_certificate_type := to_char(temp, 'DD/MM/YYYY');
            -- o_certificate_type := APEX_JSON.get_varchar2(p_path => '[%d].short_note', p0 => i);
            o_certificate_type := APEX_JSON.get_varchar2(p_path => '[%d].attachment_url', p0 => i);
        end loop;
    end if;
    return o_certificate_type;
end;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_DOB > Default > SQL Query

select DOB from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_ISSUE_PLACE_WP > Default > SQL Query

SELECT ISSUE_PLACE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 2 AND e.EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_EMP_CURRENT_CERTIFICATES > Default > SQL Query

SELECT JSON_ARRAYAGG(
    JSON_OBJECT(
        'id' VALUE ID,
        'employee_id' VALUE EMPLOYEE_ID,
        'certificate_description' VALUE CERTIFICATE_DESCRIPTION,
        'end_date' VALUE END_DATE,
        'start_date' VALUE START_DATE,
        'short_note' VALUE SHORT_NOTE,
        'certificate_type' VALUE CERTIFICATE_TYPE,
        'employee_code' VALUE EMPLOYEE_CODE,
        'is_del' VALUE IS_DEL,
        'attachment' VALUE ATTACHMENT,
        'rec_id' VALUE REC_ID,
        'attachment_url' VALUE ATTACHMENT_URL,
        'attachment_name' VALUE ATTACHMENT_NAME
    )
) as json_data
FROM EMP_CERTIFICATE
WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_EMPLOYEE_CODE > Default > SQL Query

select EMPLOYEE_CODE from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_SOC_INS_HOS_CODE > Default > SQL Query

select SOC_HOSPITAL_CODE from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_EXP_WP_DATE > Default > SQL Query

SELECT TO_CHAR(emp_id.EXPIRATION_DATE, 'DD/MM/YYYY')
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 2 AND e.EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_BANK_BRANCH > Default > SQL Query

SELECT
    eb.BANK_BRANCH
FROM
    EMP_BANK eb
INNER JOIN
    EMPLOYEES e ON eb.EMPLOYEE_CODE = e.EMPLOYEE_CODE
WHERE 
    e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_ISSUE_DATE_ID > Default > SQL Query

SELECT
  CASE
    WHEN ISSUE_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
    ELSE TO_CHAR(ISSUE_DATE, 'DD/MM/YYYY')
    --ELSE ISSUE_DATE
  END AS ISSUE_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_EME_PHONE_NUMBER > Default > SQL Query

select EME_PHONE_NUMBER from EMP_EMERGENCY_CONTACT EMP_EC where EMP_EC.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_EMP_CURRENT_EDUCATION > Default > SQL Query

SELECT JSON_ARRAYAGG(
    JSON_OBJECT(
        'id' VALUE ID,
        'employee_id' VALUE EMPLOYEE_ID,
        'type' VALUE TYPE,
        'level_of_edu' VALUE LEVEL_OF_EDU,
        'major' VALUE MAJOR,
        'place' VALUE PLACE,
        'graduated_date' VALUE GRADUATED_DATE,
        'attach_file' VALUE ATTACH_FILE,
        'is_del' VALUE IS_DEL,
        'expiration_date' VALUE EXPIRATION_DATE,
        'effective_date' VALUE EFFECTIVE_DATE,
        'certificate_name' VALUE CERTIFICATE_NAME,
        'employee_code' VALUE EMPLOYEE_CODE,
        'primary_education' VALUE PRIMARY_EDUCATION,
        'attach_name' VALUE ATTACH_NAME,
        'rec_id' VALUE REC_ID,
        'discipline_id' VALUE DISCIPLINE_ID,
        'institution_id' VALUE INSTITUTION_ID,
        'attach_url' VALUE ATTACH_URL
    )
) as json_data
FROM EMP_EDUCATION
WHERE EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_BANK_NAME > Default > SQL Query

SELECT
    eb.BANK_NAME
FROM
    EMP_BANK eb
INNER JOIN
    EMPLOYEES e ON eb.EMPLOYEE_CODE = e.EMPLOYEE_CODE
WHERE 
    e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_ISS_DATE_PIT_NUM > Default > SQL Query

-- SELECT 
--     TO_CHAR(ISSUE_DATE, 'DD/MM/YYYY') AS ISSUE_DATE
-- FROM EMP_ID_NUMBER emp_id
-- INNER JOIN 
--     EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
-- WHERE ID_TYPE = 3 AND e.USER_NAME = :APP_USER_NAME 

SELECT
  CASE
    WHEN ISSUE_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
    ELSE TO_CHAR(ISSUE_DATE, 'DD/MM/YYYY')
  END AS ISSUE_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 3 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_SOC_INS_PRI_HEAL > Default > SQL Query

select PRI_HEAL_SERVICE from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_SOC_INS_PRI_HEAL > List of Values > SQL Query

SELECT DESCRIPTION, HEALTH_INSU_FACILITY_CODE 
FROM HEALTH_INSURANCE_ESTABLISHMENT;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_ISSUE_WP_DATE > Default > SQL Query

SELECT TO_CHAR(ISSUE_DATE, 'DD/MM/YYYY')
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 2 AND e.EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_EME_RELATIONSHIP > Default > SQL Query

select RELATION_SHIP from EMP_EMERGENCY_CONTACT EMP_EC where EMP_EC.EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_EME_RELATIONSHIP > List of Values > SQL Query

SELECT RELATIONSHIP_TYPE_DESCRIPTION, RELATIONSHIP_TYPE_ID AS ID
FROM EMP_RELATIONSHIP;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_FULL_NAME > Default > SQL Query

select FULL_NAME from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_TEMPORARY_ADDRESS > Default > SQL Query

select TEMPORARY_ADDRESS from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_TEMP_ADDRESS > Default > SQL Query

select TEMPORARY_ADDRESS from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_PLACE_DATE_ID_1 > Default > SQL Query

SELECT ISSUE_PLACE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_PLACE_DATE_ID_1 > List of Values > SQL Query

SELECT LIA_NAME, LIA_NAME as ID FROM LIST_ISSUING_AGENCY;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_EXP_DATE_ID_1 > Default > SQL Query

-- SELECT TO_CHAR(emp_id.EXPIRATION_DATE, 'DD/MM/YYYY')
-- FROM EMP_ID_NUMBER emp_id
-- INNER JOIN 
--     EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
-- WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME

SELECT
  CASE
    WHEN emp_id.EXPIRATION_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
    ELSE TO_CHAR(emp_id.EXPIRATION_DATE, 'DD/MM/YYYY')
  END AS EXPIRATION_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_ISSUE_DATE_ID_1 > Default > SQL Query

-- SELECT ISSUE_DATE
-- FROM EMP_ID_NUMBER emp_id
-- INNER JOIN 
--     EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
-- WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME 

SELECT
  CASE
    WHEN ISSUE_DATE = TO_DATE('1/1/1900', 'MM/DD/YYYY') THEN ''
    ELSE TO_CHAR(ISSUE_DATE, 'DD/MM/YYYY')
  END AS ISSUE_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_ID_PP_NUMBER_1 > Default > SQL Query

SELECT ID_NUMBER
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 1 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_PERMANENT_ADDRESS > Default > SQL Query

select PERMANENT_ADDRESS from employees where USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_HIGHEST_LEVEL > Default > SQL Query

SELECT DISCIPLINE_ID from EMP_EDUCATION where EMPLOYEE_CODE = :APP_EMP_CODE AND PRIMARY_EDUCATION = 1 and ROWNUM = 1;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_BANK_ACC_NUM > Default > SQL Query

SELECT
    eb.BANK_ACC_NUM
FROM
    EMP_BANK eb
INNER JOIN
    EMPLOYEES e ON eb.EMPLOYEE_CODE = e.EMPLOYEE_CODE
WHERE 
    e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_PIT_NUMBER > Default > SQL Query

SELECT ID_NUMBER
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 3 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_SOC_INS_NUMBER > Default > SQL Query

select SOC_INS_NUMBER from EMP_SOCICAL_INSURANCE EMP_SI where EMP_SI.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_WP_NUMBER > Default > SQL Query

SELECT ID_NUMBER
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 2 AND e.EMPLOYEE_CODE = :APP_EMP_CODE;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_ID_PP_NUMBER > Default > SQL Query

SELECT ID_NUMBER
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 0 AND e.USER_NAME = :APP_USER_NAME;

-- ----------------------------------------
-- Page: 5 - Personal Information > Page Item: P5_EME_NAME > Default > SQL Query

select EME_FULL_NAME from EMP_EMERGENCY_CONTACT EMP_EC where EMP_EC.EMPLOYEE_CODE = 
(select EMPLOYEE_CODE from EMPLOYEES where USER_NAME = :APP_USER_NAME  );

-- ----------------------------------------
-- Page: 5 - Personal Information > Region: Other Certificates > Source > SQL Query

select 
       cert.ID,
       cert.EMPLOYEE_ID,
       cert.CERTIFICATE_DESCRIPTION,
       cert.END_DATE,
       cert.START_DATE,  
       cert.SHORT_NOTE,     
       cert.CERTIFICATE_TYPE,
       cert.EMPLOYEE_CODE,
       cert.ATTACHMENT,
       TO_HREF_HTML_ATTACHMENT(cert.ATTACHMENT_URL, cert.ATTACHMENT_NAME) as cert_attachment,
       '#' as Upload,
       cert.TEMP_ID

from EMP_CERTIFICATE cert where cert.EMPLOYEE_CODE = :APP_EMP_CODE and cert.IS_DEL = 0
/*
INNER JOIN 
    EMPLOYEES e ON cert.EMPLOYEE_CODE = e.EMPLOYEE_CODE
WHERE e.USER_NAME = :APP_USER_NAME
*/;

