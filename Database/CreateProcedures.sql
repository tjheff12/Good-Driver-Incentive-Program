DELIMITER $$
CREATE PROCEDURE givePoints()
BEGIN
	DECLARE numOfSponsors INT DEFAULT 0;
	DECLARE i INT DEFAULT 0;
	DECLARE j INT DEFAULT 0;
	DECLARE drivers INT DEFAULT 0;
	DECLARE currID INT DEFAULT 0;
	DECLARE pointChange INT DEFAULT 0;
	DECLARE driverID INT DEFAULT 0;
SELECT COUNT(*) FROM sponsor s into numOfSponsors;
SET i = 0;
WHILE i < numOfSponsors DO
	SELECT (Sponsor_ID) FROM sponsor LIMIT i,1 INTO currID;
	SELECT (Auto_Points) FROM sponsor LIMIT i,1 INTO pointChange;
	SELECT COUNT(*) FROM driver_sponsor where Sponsor_ID = currID INTO drivers;
	WHILE j < drivers DO
		SELECT (User_ID) from driver_sponsor ds where Sponsor_ID = currID LIMIT j,1 INTO driverID;
		INSERT INTO points_history(User_ID,Sponsor_ID,Point_Change,Date_Time,Reason,Sponsor_User_ID) VALUES (driverID,currID,pointChange,NOW(),'Automatic Reward',NULL);
		SET j = j+1;
	END WHILE;
    SET j=0;
    SET i=i+1;
END WHILE;
END;
$$
Delimiter ;

DELIMITER $$
CREATE PROCEDURE simulate_shipping()
BEGIN
	UPDATE orders SET Status = 'Delivered' where Status = 'Shipped';
	UPDATE orders SET Status = 'Shipped' where Status = 'Confirmed';
	UPDATE orders SET Status = 'Confirmed' where Status = 'Pending';
END
$$
Delimiter ;