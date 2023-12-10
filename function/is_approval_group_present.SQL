CREATE OR REPLACE FUNCTION is_approval_group_present(
    p_approval_groups IN VARCHAR2, 
    p_approval_group IN VARCHAR2
) RETURN BOOLEAN IS
BEGIN
    -- Check if p_approval_group is part of the comma-separated list in p_approval_groups
    RETURN INSTR(',' || p_approval_groups || ',', ',' || p_approval_group || ',') > 0;
END is_approval_group_present;


BEGIN
    -- print test with head_of_SSCCP,head_of_HRT,head_of_BOD,head_of_TQM,head_of_MKT,head_of_BDD,head_of_ASA,head_of_OPE
    -- head_of_SSCCP
    if is_approval_group_present('head_of_SSCCP,head_of_HRT,head_of_BOD,head_of_TQM,head_of_MKT,head_of_BDD,head_of_ASA,head_of_OPE', 'head_of_SSCCP') then
        dbms_output.put_line('head_of_SSCCP is present');
    else
        dbms_output.put_line('head_of_SSCCP is not present');
    end if;
END;