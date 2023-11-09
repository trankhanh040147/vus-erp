-- Khi clone server từ UAT --> PILOT, cần thay đổi các dữ liệu sau

-- 1. Thay đổi resource

-- 4. Đồng bộ thông tin user

begin
  SP_GET_ALL_EMPLOYEES(0,1800);
end;

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

-- 8. Đổi link gửi send mail (page 3, 10)

-- **TESTING

-- 1. Test các chức năng của page 5: Cập nhật thông tin, upload file, send mail

-- 2. Test tạo & approve leave_request