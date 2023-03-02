CREATE TRIGGER `update_state_change` 
AFTER UPDATE ON `driver_application` 
FOR EACH ROW INSERT INTO 
application_state_change (Application_ID,Date_Time,New_Status,New_Reason) 
VALUES (NEW.Application_ID,NEW.Date_Time,NEW.Status,NEW.Reason);

CREATE TRIGGER `update_login_attempt` 
AFTER UPDATE ON `users` 
FOR EACH ROW 
INSERT INTO login_attempt(User_ID,Date_Time,Was_Accepted) 
VALUES (NEW.User_ID,NEW.last_login,1);