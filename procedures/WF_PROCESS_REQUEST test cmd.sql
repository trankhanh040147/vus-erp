declare 
    p_request_status_out number;
begin
    -- call procedure
    -- wf_process_request('099', 743, 1, 'approve 1st', p_request_status_out);
    wf_process_request('2741', 743, 1, 'approve 2st', p_request_status_out);
end;

delete from WORKFLOW_DETAIL WHERE request_id = 743;

