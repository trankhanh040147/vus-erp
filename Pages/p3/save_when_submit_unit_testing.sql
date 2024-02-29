declare
v_request_id_temp number:=1;
v_id NUMBER:=1;
v_name_type nvarchar2(100);
v_benefit_code nvarchar2(100):='';
v_annual_temp float:=0;
v_crf_temp float:=0;
v_crf_balance number;
manager_email nvarchar2(100);
manager_name nvarchar2(100);
requester_schedule NVARCHAR2(50);
v_body_emp clob := '';
v_body_man clob:= '';
p3_total_days FLOAT;
leave_type nvarchar2(200);

begin

    -- Waiting for the end to come
    -- dbms_session.sleep(1);

    -- Unit Testing
    :APP_EMP_CODE := '002795';
    :P3_FROM_DATE := '30/12/2024';
    :P3_END_DATE := '01/01/2025';
    :P3_TOTAL_DAYS := '3';
    :P3_ANNUAL_LEAVE := 'APL';

    p3_total_days := case when :P3_TOTAL_DAYS = '0.5' then 0.5 else TO_NUMBER(:P3_TOTAL_DAYS) end;

    if :P3_ANNUAL_LEAVE = 'APL' then
        for rec in ( select * from ABSENCE_GROUP_EMPLOYEE where employee_code = :APP_EMP_CODE and EXPIRATION_DATE >= to_char(sysdate,'MM/DD/YYYY'))loop

            -- CF not expired
            if rec.CARRY_FORWORD_EXP_DATE >= to_char(sysdate,'MM/DD/YYYY') then
                
                -- Calculate CF balance, if the EndDate exceed CARRY_FORWORD_EXP_DATE, then the balance will be CARRY_FORWORD_EXP_DATE - FROM_DATE, otherwise it will be its CARRY_FORWARD_AVALABLE    
                if to_date(:P3_END_DATE, 'DD/MM/YYYY') > to_date(rec.CARRY_FORWORD_EXP_DATE, 'MM/DD/YYYY') then
                    v_crf_balance := to_date(rec.CARRY_FORWORD_EXP_DATE, 'MM/DD/YYYY') - to_date(:P3_FROM_DATE, 'DD/MM/YYYY') +1;
                else
                    v_crf_balance := rec.CARRY_FORWARD_AVALABLE;
                end if;

                if p3_total_days <= v_crf_balance and v_crf_balance > 0 then
                    -- CF enough
                    v_benefit_code := rec.CF_BENEFIT_ACCRUAL_PLAN;
                    v_crf_temp := p3_total_days;
                elsif v_crf_balance > 0 and p3_total_days > v_crf_balance then
                    -- CF not enough
                    v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN||','||rec.CF_BENEFIT_ACCRUAL_PLAN;
                    v_crf_temp := v_crf_balance;
                    v_annual_temp := p3_total_days - v_crf_balance;
                elsif v_crf_balance <= 0 THEN
                    -- CF not expired, CF = 0
                    v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN;
                    v_annual_temp := p3_total_days;
                end if;
            else
                v_benefit_code := rec.BENEFIT_ACCRUAL_PLAN;
                v_annual_temp := p3_total_days;
            end if;
        end loop;
    end if;

    -- PRINT OUT THE RESULT
    dbms_output.put_line('v_benefit_code: '||v_benefit_code);
    dbms_output.put_line('v_annual_temp: '||v_annual_temp);
    dbms_output.put_line('v_crf_temp: '||v_crf_temp);
    dbms_output.put_line('v_crf_balance: '||v_crf_balance);
    dbms_output.put_line('p3_total_days: '||p3_total_days);
    dbms_output.put_line('leave_type: '||leave_type);

end;