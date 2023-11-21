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