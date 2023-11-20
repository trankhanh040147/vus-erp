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
-- Page: 12 - Applications Configs > Process: New > Source > PL/SQL Code

Declare
n_id number;
Begin
SELECT COUNT(ID) INTO n_id FROM APPLICATIONS_CONFIGS WHERE KEY = :P12_KEY;
If n_id > 0 Then
UPDATE APPLICATIONS_CONFIGS SET VALUE = :P12_VALUE WHERE KEY = :P12_KEY;
Else
INSERT INTO APPLICATIONS_CONFIGS(KEY, VALUE) VALUES(:P12_KEY, :P12_VALUE);
End If;
End;

