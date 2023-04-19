USE Good_Driver;

SELECT `application_state_change`.`State_Change_ID`,
    `application_state_change`.`Application_ID`,
    `application_state_change`.`Date_Time`,
    `application_state_change`.`New_Status`,
    `application_state_change`.`New_Reason`
FROM `Good_Driver`.`application_state_change`;

SELECT `auth_group`.`id`,
    `auth_group`.`name`
FROM `Good_Driver`.`auth_group`;

SELECT `auth_group_permissions`.`id`,
    `auth_group_permissions`.`group_id`,
    `auth_group_permissions`.`permission_id`
FROM `Good_Driver`.`auth_group_permissions`;

SELECT `auth_permission`.`id`,
    `auth_permission`.`name`,
    `auth_permission`.`content_type_id`,
    `auth_permission`.`codename`
FROM `Good_Driver`.`auth_permission`;

SELECT `django_admin_log`.`id`,
    `django_admin_log`.`action_time`,
    `django_admin_log`.`object_id`,
    `django_admin_log`.`object_repr`,
    `django_admin_log`.`action_flag`,
    `django_admin_log`.`change_message`,
    `django_admin_log`.`content_type_id`,
    `django_admin_log`.`user_id`
FROM `Good_Driver`.`django_admin_log`;

SELECT `django_content_type`.`id`,
    `django_content_type`.`app_label`,
    `django_content_type`.`model`
FROM `Good_Driver`.`django_content_type`;

SELECT `django_migrations`.`id`,
    `django_migrations`.`app`,
    `django_migrations`.`name`,
    `django_migrations`.`applied`
FROM `Good_Driver`.`django_migrations`;

SELECT `django_session`.`session_key`,
    `django_session`.`session_data`,
    `django_session`.`expire_date`
FROM `Good_Driver`.`django_session`;

SELECT `driver_application`.`Application_ID`,
    `driver_application`.`Driver_ID`,
    `driver_application`.`Sponsor_ID`,
    `driver_application`.`Date_Time`,
    `driver_application`.`Status`,
    `driver_application`.`Reason`
FROM `Good_Driver`.`driver_application`;

SELECT `driver_sponsor`.`ID`,
    `driver_sponsor`.`User_ID`,
    `driver_sponsor`.`Sponsor_ID`
FROM `Good_Driver`.`driver_sponsor`;

SELECT `login_attempt`.`Attempt_ID`,
    `login_attempt`.`User_ID`,
    `login_attempt`.`Date_Time`,
    `login_attempt`.`Was_Accepted`
FROM `Good_Driver`.`login_attempt`;

SELECT `orders`.`Order_ID`,
    `orders`.`User_ID`,
    `orders`.`Sponsor_ID`,
    `orders`.`date_time`,
    `orders`.`Status`,
    `orders`.`Price`,
    `orders`.`Points`,
    `orders`.`Item_ID`,
    `orders`.`Item_Name`
FROM `Good_Driver`.`orders`;

SELECT `password_changes`.`Change_ID`,
    `password_changes`.`Date_Time`,
    `password_changes`.`User_ID`,
    `password_changes`.`Type_Of_Change`
FROM `Good_Driver`.`password_changes`;

SELECT `points`.`Points_ID`,
    `points`.`User_ID`,
    `points`.`Sponsor_ID`,
    `points`.`Point_Total`
FROM `Good_Driver`.`points`;

SELECT `points_history`.`Change_ID`,
    `points_history`.`User_ID`,
    `points_history`.`Sponsor_ID`,
    `points_history`.`Point_Change`,
    `points_history`.`Date_Time`,
    `points_history`.`Reason`,
    `points_history`.`Sponsor_User_ID`
FROM `Good_Driver`.`points_history`;

SELECT `sponsor`.`Sponsor_ID`,
    `sponsor`.`Point_Value`,
    `sponsor`.`Name`,
    `sponsor`.`Auto_Points`,
    `sponsor`.`Max_Price`
FROM `Good_Driver`.`sponsor`;

SELECT `sponsor_user`.`User_ID`,
    `sponsor_user`.`Sponsor_ID`
FROM `Good_Driver`.`sponsor_user`;

SELECT `users`.`User_ID`,
    `users`.`First_Name`,
    `users`.`Last_Name`,
    `users`.`Street_Address`,
    `users`.`Street_Address_2`,
    `users`.`City`,
    `users`.`ZIP_Code`,
    `users`.`Phone_Number`,
    `users`.`User_Type`,
    `users`.`Email`,
    `users`.`Password`,
    `users`.`last_login`,
    `users`.`is_impersonation`,
    `users`.`Security_Question_Answer`
FROM `Good_Driver`.`users`;
