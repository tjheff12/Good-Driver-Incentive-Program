CREATE TRIGGER `update_state_change` 
AFTER UPDATE ON `driver_application` 
FOR EACH ROW INSERT INTO 
application_state_change (Application_ID,Date_Time,New_Status,New_Reason) 
VALUES (NEW.Application_ID,NEW.Date_Time,NEW.Status,NEW.Reason);

--Yes DELIMITER is neccesary. No, I don't know why. All I know is the if statement breaks everything without it
DELIMITER $$
CREATE TRIGGER `update_login_attempt` 
AFTER UPDATE ON `users` FOR EACH ROW BEGIN
IF (NEW.last_login != OLD.last_login) 
THEN
	INSERT INTO `login_attempt`(User_ID,Date_Time,Was_Accepted) VALUES (NEW.User_ID,NEW.last_login,1);
END IF;
END$$
DELIMITER ;

CREATE TRIGGER `update_state_change_for_new_application` 
AFTER INSERT ON `driver_application` 
FOR EACH ROW INSERT INTO 
application_state_change (Application_ID,Date_Time,New_Status,New_Reason) 
VALUES (NEW.Application_ID,NEW.Date_Time,NEW.Status,NEW.Reason);