declare
    v_body clob:='';
begin
v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/header.png''></img>';
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
v_body := v_body||'<table style=''border-collapse: collapse;border-bottom: 1px solid black;''>';
v_body := v_body||'<tr>';
v_body := v_body||'<th style=''border: 1px solid black;''></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐÃ ĐĂNG KÝ</strong></p><p style=''color:black;margin:0;font-weight:400''><i>CURRENT PERSONAL INFORMATION</i></p></th>';
v_body := v_body||'<th style=''border: 1px solid black;''><p style=''color:black;margin:0''><strong style=''color:black;margin:0''>NỘI DUNG ĐỀ NGHỊ THAY ĐỔI</strong></p><p style=''color:black;margin:0;font-weight:400''><i>PERSONAL INFORMATION UPDATE</i></p></th>';
v_body := v_body||'</tr>';
v_body := v_body||'<tr style=''border: 1px solid black;border-bottom: none;''><td style=''border-left: 1px solid black;''><p style=''color:black;margin:0;font-weight:700''>Thông tin Mã số thuế</p><p style=''color:black;margin:0;font-style:italic;margin-bottom:10px''>PIT</p></td><td style=''border-left: 1px solid black;''></td><td style=''border-left: 1px solid black''></td></tr>';
for rec in (SELECT ISSUE_DATE
FROM EMP_ID_NUMBER emp_id
INNER JOIN 
    EMPLOYEES e on e.EMPLOYEE_CODE = emp_id.EMPLOYEE_CODE
WHERE ID_TYPE = 3 AND e.USER_NAME = :APP_USER_NAME 
)loop
    -- if rec.ISSUE_DATE IS NULL then
    --     v_body := v_body||'<p>Issue date of PIT : '||:P5_ISS_DATE_PIT_NUM||'</p>';
    -- end if;
    if rec.ISSUE_DATE <> to_date(:P5_ISS_DATE_PIT_NUM, 'DD/MM/YYYY') OR rec.ISSUE_DATE IS NULL  then
        v_body := v_body||'<tr style=''border-left: 1px solid black;border-right: 1px solid black;''><td style=''border-right: 1px solid black;''>Ngày cấp mã số thuế/Issue date</td><td style=''border-right: 1px solid black;''>'||rec.ISSUE_DATE||'</td><td style=''border-right: 1px solid black;''>'||:P5_ISS_DATE_PIT_NUM||'</td></tr>';
    end if;
end loop;
v_body := v_body||'</table>';
v_body := v_body||'<p style=''color:black''>Anh/Chị vui lòng click tại đây để kiểm tra thông tin và xác nhận cập nhật vào hệ thống D365 HRM.</p>';
v_body := v_body||'<p style=''color:black''>Please click Link to review and update information to D365 HRM System.</p>';
v_body := v_body||'<p style=''color:black''>Trân trọng,</p>';
v_body := v_body||'<p style=''color:black''>Phòng Nhân sự Hành chính</p>';
v_body := v_body||'<p style=''color:black''>Best regards,</p>';
v_body := v_body||'<p style=''color:black''>HR & Admin Department </p>';
v_body := v_body||'<img style=''width:100%'' src=''https://hcm01.vstorage.vngcloud.vn/v1/AUTH_77c1e15122904b63990a9da99711590d/LXP_Media/ERP/images/footer.jpg''></img>';



    -- SP_SENDGRID_EMAIL('ky.nguyenquoc@vus-etsc.edu.vn', 'quocky600@gmail.com', 'Cập nhật thay đổi thông tin NV '||:P5_FULL_NAME||'',v_body);
    --SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'ky.nguyenquoc@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
    --SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'quocky600@gmail.com' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
    -- SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'haitran@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'phuongpham@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);
    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'trang.th@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'huyen.ptt@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'thudang@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'hravus@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin Nhân viên '||:P5_FULL_NAME||'',v_body);
    

    SP_SENDGRID_EMAIL('VUSERP-PORTAL@vus-etsc.edu.vn', 'khanhnguyendev@vus-etsc.edu.vn' , 'Cập nhật thay đổi thông tin nhân viên '||:P5_FULL_NAME||'',v_body);

    
end;