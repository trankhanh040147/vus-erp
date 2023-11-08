-- Khi clone server từ UAT --> PILOT, cần thay đổi các dữ liệu sau

-- 1. Thay đổi resource

-- 2. Thay đổi quyền các user ADMIN, chạy lại hàm update Manager Role

-- 3. Thay đổi địa chỉ send mail của page 5

-- 4. Đồng bộ thông tin user

-- 5. Đồng bộ thông tin gói phép

begin
  SP_ABSENCE_CODE_GROUP_LIST();
end;

begin
  SP_GET_ABSENCE_CODE_LIST();
end;

-- 6. Đồng bộ các leave request

-- 7. Kiểm tra maximum của các gói phép

-- **TESTING

-- 1. Test các chức năng của page 5: Cập nhật thông tin, upload file, send mail

-- 2. Test tạo & approve leave_request