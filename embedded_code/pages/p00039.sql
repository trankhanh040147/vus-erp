-- --------------------------------------------------------------------------------
-- 
-- Oracle APEX source export file
-- 
-- The contents of this file are intended for review and analysis purposes only.
-- Developers must use the Application Builder to make modifications to an
-- application. Changes to this file will not be reflected in the application.
-- 
-- --------------------------------------------------------------------------------

-- ----------------------------------------
-- Page: 39 - Process_time_sheet > Dynamic Action: New > Action: Employee - Confirm > Settings > PL/SQL Code

BEGIN
    UPDATE P_TIME_SHEET 
    SET STATUS = 3
    WHERE ID = :P39_ID_REQUEST;
END;

-- ----------------------------------------
-- Page: 39 - Process_time_sheet > Dynamic Action: New > Action: Mana - Re-confirm > Settings > PL/SQL Code

BEGIN
    -- Approve
    UPDATE P_TIME_SHEET 
    SET STATUS = 1
    WHERE ID = :P39_ID_REQUEST;
END;

-- ----------------------------------------
-- Page: 39 - Process_time_sheet > Dynamic Action: New > Action: Mana - Submit to HR > Settings > PL/SQL Code

BEGIN
    -- Approve
    UPDATE P_TIME_SHEET 
    SET STATUS = 6
    WHERE ID = :P39_ID_REQUEST;
END;

-- ----------------------------------------
-- Page: 39 - Process_time_sheet > Dynamic Action: New > Action: Mana - Reject > Settings > PL/SQL Code

BEGIN
    -- Approve
    UPDATE P_TIME_SHEET 
    SET STATUS = 5
    WHERE ID = :P39_ID_REQUEST;
END;

-- ----------------------------------------
-- Page: 39 - Process_time_sheet > Dynamic Action: New > Action: Mana - Approve > Settings > PL/SQL Code

BEGIN
    -- Approve
    UPDATE P_TIME_SHEET 
    SET STATUS = 4
    WHERE ID = :P39_ID_REQUEST;
END;

