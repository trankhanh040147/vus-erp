-- Table: EMP_EDUCATION
-- ID	NUMBER(10,0)
-- EMPLOYEE_ID	NUMBER(10,0)
-- TYPE	NVARCHAR2(100 CHAR)
-- LEVEL_OF_EDU	NVARCHAR2(50 CHAR)
-- MAJOR	NVARCHAR2(100 CHAR)
-- PLACE	NVARCHAR2(500 CHAR)
-- GRADUATED_DATE	DATE
-- ATTACH_FILE	NVARCHAR2(100 CHAR)
-- IS_DEL	NUMBER(2,0)
-- EXPIRATION_DATE	DATE
-- EFFECTIVE_DATE	DATE
-- CERTIFICATE_NAME	NVARCHAR2(100 CHAR)
-- EMPLOYEE_CODE	NVARCHAR2(100 CHAR)
-- PRIMARY_EDUCATION	NUMBER(1,0)
-- ATTACH_NAME	VARCHAR2(1000 CHAR)
-- REC_ID	NVARCHAR2(50 CHAR)
-- DISCIPLINE_ID	NVARCHAR2(30 CHAR)
-- INSTITUTION_ID	NVARCHAR2(10 CHAR)
-- ATTACH_URL	VARCHAR2(1500 CHAR)
-- TEMP_ID	NUMBER(10,0)

-- Table: TEMP_UPLOAD
-- ID	NUMBER(10,0)
-- TABLE_NAME	NVARCHAR2(30 CHAR)
-- TEMP_ID	NUMBER(10,0)
-- ATTACHMENT_URL	VARCHAR2(2000 CHAR)
-- ATTACHMENT_NAME	VARCHAR2(1000 CHAR)

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
    v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
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
            select LEVEL_OF_EDU, MAJOR, PLACE, to_char(GRADUATED_DATE, 'DD/MM/YYYY'), ATTACH_NAME, ATTACH_URL
            into n_level_of_edu, n_major, n_place, n_graduated_date, n_attach_name, n_attach_url
            from EMP_EDUCATION
            where ID = add_ids(rec);
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''><p style=''color:black;font-weight:700; margin-top:20px;margin-bottom:0;''>Bằng cấp đã thêm</p><p style=''color:black;margin:0;font-style:italic''>Addition of a degree</p></td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Trình độ học vấn / Level of edu</td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_level_of_edu ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Chuyên ngành / Major</td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_major ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''>Tên trường học / Name of school/university/institute </td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_place ||'</td></tr>';
            v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''> Năm tốt nghiệp / Graduated date </td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| n_graduated_date ||'</td></tr>';
            -- v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''> Đính kèm / Attachment </td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''>'|| to_href_html(n_attach_file, n_attach_name) ||'</td></tr>';
            -- v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style='' padding:0 10px; border-right: 1px solid black;''></td><td style=''padding:0 10px;''></td></tr>';
        
            -- Update attachment for new row in EMP_EDUCATION from TEMP_UPLOAD through TEMP_ID
            Update EMP_EDUCATION edu
            set edu.ATTACH_NAME = (select att.ATTACHMENT_NAME from TEMP_UPLOAD att where att.TEMP_ID = edu.TEMP_ID),
                edu.ATTACH_URL = (select att.ATTACHMENT_URL from TEMP_UPLOAD att where att.TEMP_ID = edu.TEMP_ID)
            where edu.ID = add_ids(rec);
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
    v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';

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