-- Khi clone server từ UAT --> PILOT, cần thay đổi các dữ liệu sau

-- 1. Thay đổi resource

create or replace PACKAGE BODY global_vars AS
    g_resource_url VARCHAR2(1000) := 'https://hra.sandbox.operations.dynamics.com'; -- initial value
    -- g_resource_url VARCHAR2(1000) := 'https://vustc-test-serverae174d74817432d5aos.axcloud.dynamics.com'; -- initial value

    PROCEDURE set_resource_url(p_url VARCHAR2) IS
    BEGIN
        g_resource_url := p_url;
    END set_resource_url;

    FUNCTION get_resource_url RETURN VARCHAR2 IS
    BEGIN
        RETURN g_resource_url;  
    END get_resource_url;

END global_vars;
/

-- 4. Đồng bộ thông tin user

-- List các user cần chú ý:
-- 000000037 - trang.th@vus-etsc.edu.vn
-- 1617 - phuongpham
-- 4025 - giauhuynh
-- 000053
-- 1490
-- 3152

begin
  SP_GET_ALL_EMPLOYEES(0,1800);
end;

BEGIN
    SP_GET_ONE_EMPLOYEE('000000037');
END; 


-- 2. Thay đổi quyền các user ADMIN, chạy lại hàm update Manager Role

SELECT *  FROM EMPLOYEES WHERE WORKER_TITLE_ID = 'ADMIN'

UPDATE EMPLOYEES SET WORKER_TITLE_ID = '' WHERE WORKER_TITLE_ID =  'ADMIN' 

declare
begin
for rec in (select emp.id,emp.WORKER_TITLE_ID from employees emp 
join (select MANAGER_POSITION_ID from employees 
where MANAGER_POSITION_ID is not null group by MANAGER_POSITION_ID) mt on emp.POSITION_ID = mt.MANAGER_POSITION_ID)loop
    if rec.WORKER_TITLE_ID is null then
        update employees set WORKER_TITLE_ID = 'MANAGER' where rec.id = id;
    end if;
end loop;
end;


-- 3. Thay đổi địa chỉ send mail của page 5

-- 5. Đồng bộ thông tin gói phép

begin
  SP_ABSENCE_CODE_GROUP_LIST();
end;

begin
  SP_GET_ABSENCE_CODE_LIST();
end;

-- 6. Đồng bộ gói phép & leave request của nhân viên (Xoá các đơn không phải trên portal)

delete from ABSENCE_GROUP_EMPLOYEE 

delete from EMPLOYEE_REQUESTS 

begin
  SP_GET_ONE_ABSENCE_GROUP_EMPLOYEE('000000037');
end;

-- 7. Kiểm tra maximum của các gói phép

-- 8. Đổi link gửi send mail (page 3, 10, 5)
-- UAT --> PILOT

-- 9. Seeds Language

-- **TESTING

-- 1. Test các chức năng của page 5: Cập nhật thông tin, upload file, send mail

-- 2. Test tạo & approve leave_requestO