begin
    SP_GET_ONE_EMPLOYEE('2741');
end;

begin
    SP_GET_ONE_EMPLOYEE('676');
end;

-- Update employee Approval_group

-- Change LoV

-- Update LoV page 18

UPDATE WORKFLOW_APPROVAL
set WA_GROUP = 'head_of_hra' 
where WA_GROUP = 'head_of_HRA';

-- Update workflow
https://erp-pilot.vus.edu.vn/ords/r/erp/erp/setup-workflow

-- Update admin
https://erp-pilot.vus.edu.vn/ords/r/erp/erp/admin-accounts
