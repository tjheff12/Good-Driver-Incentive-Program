

# Create your models here.
# This is an auto-generated Django model module.
# You'll have to do the following manually to clean this up:
#   * Rearrange models' order
#   * Make sure each model has one field with primary_key=True
#   * Make sure each ForeignKey and OneToOneField has `on_delete` set to the desired behavior
#   * Remove `managed = False` lines if you wish to allow Django to create, modify, and delete the table
# Feel free to rename the models, but don't rename db_table values or field names.
from django.db import models
from django.contrib.auth.models import AbstractBaseUser, UserManager

class AdminUser(models.Model):
    user = models.OneToOneField('Users', models.CASCADE, db_column='User_ID', primary_key=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'admin_user'


class ApplicationStateChange(models.Model):
    state_change_id = models.AutoField(db_column='State_Change_ID', primary_key=True)  # Field name made lowercase.
    application = models.ForeignKey('DriverApplication', models.CASCADE, db_column='Application_ID')  # Field name made lowercase.
    date_time = models.DateTimeField(db_column='Date_Time')  # Field name made lowercase.
    new_status = models.CharField(db_column='New_Status', max_length=15)  # Field name made lowercase.
    new_reason = models.CharField(db_column='New_Reason', max_length=30, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'application_state_change'


class DriverApplication(models.Model):
    application_id = models.AutoField(db_column='Application_ID', primary_key=True)  # Field name made lowercase.
    driver = models.ForeignKey('Users', models.CASCADE, db_column='Driver_ID')  # Field name made lowercase.
    sponsor = models.ForeignKey('Sponsor', models.CASCADE, db_column='Sponsor_ID')  # Field name made lowercase.
    date_time = models.DateTimeField(db_column='Date_Time')  # Field name made lowercase.
    status = models.CharField(db_column='Status', max_length=15)  # Field name made lowercase.
    reason = models.CharField(db_column='Reason', max_length=30, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'driver_application'
        


class DriverSponsor(models.Model):
    id = models.AutoField(db_column='ID', primary_key=True)  # Field name made lowercase.
    user = models.ForeignKey('Users', models.CASCADE, db_column='User_ID')  # Field name made lowercase.
    sponsor = models.ForeignKey('Sponsor', models.CASCADE, db_column='Sponsor_ID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'driver_sponsor'
        unique_together = (('user', 'sponsor'),)


class DriverUser(models.Model):
    user = models.OneToOneField('Users', models.CASCADE, db_column='User_ID', primary_key=True)  # Field name made lowercase.
    sponsor_id = models.IntegerField(db_column='Sponsor_ID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'driver_user'


class Item(models.Model):
    item_id = models.AutoField(db_column='Item_ID', primary_key=True)  # Field name made lowercase.
    item_desc = models.CharField(db_column='Item_Desc', max_length=400)  # Field name made lowercase.
    item_price = models.DecimalField(db_column='Item_Price', max_digits=10, decimal_places=2)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'item'


class LoginAttempt(models.Model):
    attempt_id = models.AutoField(db_column='Attempt_ID', primary_key=True)  # Field name made lowercase.
    user = models.ForeignKey('Users', models.CASCADE, db_column='User_ID')  # Field name made lowercase.
    date_time = models.DateTimeField(db_column='Date_Time')  # Field name made lowercase.
    was_accepted = models.IntegerField(db_column='Was_Accepted')  # Field name made lowercase. This field type is a guess.

    class Meta:
        managed = False
        db_table = 'login_attempt'


class Orders(models.Model):
    order_id = models.AutoField(db_column='Order_ID', primary_key=True)  # Field name made lowercase.
    user = models.ForeignKey('Users', models.CASCADE, db_column='User_ID')  # Field name made lowercase.
    sponsor = models.ForeignKey('Sponsor', models.CASCADE, db_column='Sponsor_ID')  # Field name made lowercase.
    date_time = models.DateTimeField()
    status = models.CharField(db_column='Status', max_length=20)  # Field name made lowercase.
    price = models.FloatField(db_column='Price')  # Field name made lowercase.
    points = models.IntegerField(db_column='Points')  # Field name made lowercase.
    item_id = models.CharField(db_column='Item_ID', max_length=20 )
    item_name = models.CharField(db_column='Item_Name', max_length=100)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'orders'

class PasswordChanges(models.Model):
    change_id = models.AutoField(db_column='Change_ID', primary_key=True)  # Field name made lowercase.
    date_time = models.DateTimeField(db_column='Date_Time')  # Field name made lowercase.
    user = models.ForeignKey('Users', models.CASCADE, db_column='User_ID')  # Field name made lowercase.
    type_of_change = models.CharField(db_column='Type_Of_Change', max_length=10, blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'password_changes'


class Points(models.Model):
    points_id = models.AutoField(db_column='Points_ID', primary_key=True)  # Field name made lowercase.
    user = models.ForeignKey('Users', models.CASCADE, db_column='User_ID')  # Field name made lowercase.
    sponsor = models.ForeignKey('Sponsor', models.CASCADE, db_column='Sponsor_ID')  # Field name made lowercase.
    point_total = models.IntegerField(db_column='Point_Total')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'points'


class PointsHistory(models.Model):
    change_id = models.AutoField(db_column='Change_ID', primary_key=True)  # Field name made lowercase.
    user = models.ForeignKey('Users', models.CASCADE, db_column='User_ID', related_name='user')  # Field name made lowercase.
    sponsor = models.ForeignKey('Sponsor', models.CASCADE, db_column='Sponsor_ID')  # Field name made lowercase.
    point_change = models.IntegerField(db_column='Point_Change')  # Field name made lowercase.
    date_time = models.DateTimeField(db_column='Date_Time')  # Field name made lowercase.
    reason = models.CharField(db_column='Reason', max_length=50)  # Field name made lowercase.
    sponsor_user = models.ForeignKey('Users', models.CASCADE, db_column='Sponsor_User_ID', related_name='sponsor_user')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'points_history'


class PointsOld(models.Model):
    transaction_id = models.AutoField(db_column='Transaction_ID', primary_key=True)  # Field name made lowercase.
    user = models.ForeignKey(DriverUser, models.CASCADE, db_column='User_ID')  # Field name made lowercase.
    point_total = models.IntegerField(db_column='Point_Total')  # Field name made lowercase.
    points_added_or_deducted = models.IntegerField(db_column='Points_Added_Or_Deducted')  # Field name made lowercase.
    date_time = models.DateTimeField(db_column='Date_Time')  # Field name made lowercase.
    reason = models.CharField(db_column='Reason', max_length=30)  # Field name made lowercase.
    purchase = models.ForeignKey('Purchase', models.CASCADE, db_column='Purchase_ID', blank=True, null=True)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'points'


class Purchase(models.Model):
    purchase_id = models.AutoField(db_column='Purchase_ID', primary_key=True)  # Field name made lowercase.
    total_price = models.DecimalField(db_column='Total_Price', max_digits=10, decimal_places=2)  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'purchase'


class PurchaseItem(models.Model):
    purchase = models.OneToOneField(Purchase, models.CASCADE, db_column='Purchase_ID', primary_key=True)  # Field name made lowercase.
    item = models.ForeignKey(Item, models.CASCADE, db_column='Item_ID')  # Field name made lowercase.
    quantity = models.IntegerField(db_column='Quantity')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'purchase_item'
        unique_together = (('purchase', 'item'),)


class Sponsor(models.Model):
    sponsor_id = models.AutoField(db_column='Sponsor_ID', primary_key=True)  # Field name made lowercase.
    point_value = models.DecimalField(db_column='Point_Value', max_digits=10, decimal_places=2, default=0.01)  # Field name made lowercase.
    name = models.CharField(db_column='Name', max_length=40)  # Field name made lowercase.
    autoPoints = models.IntegerField(db_column='Auto_Points')
    maxPrice = models.FloatField(db_column='Max_Price')

    class Meta:
        managed = False
        db_table = 'sponsor'
        


class SponsorUser(models.Model):
    user = models.OneToOneField('Users', models.CASCADE, db_column='User_ID', primary_key=True)  # Field name made lowercase.
    sponsor = models.ForeignKey(Sponsor, models.CASCADE, db_column='Sponsor_ID')  # Field name made lowercase.

    class Meta:
        managed = False
        db_table = 'sponsor_user'


class Users(AbstractBaseUser):
    REQUIRED_FIELDS = ('password',)
    USERNAME_FIELD = 'email'
    is_authenticated = True
    is_anonymous = False
    user_id = models.AutoField(db_column='User_ID', primary_key=True)  # Field name made lowercase.
    email = models.CharField(db_column='Email', max_length=100, blank=False, unique=True)
    password = models.CharField(db_column='Password', max_length=100)
    first_name = models.CharField(db_column='First_Name', max_length=20)  # Field name made lowercase.
    last_name = models.CharField(db_column='Last_Name', max_length=20)  # Field name made lowercase.
    street_address = models.CharField(db_column='Street_Address', max_length=80, blank=True, null=True)  # Field name made lowercase.
    street_address_2 = models.CharField(db_column='Street_Address_2', max_length=80, blank=True, null=True)  # Field name made lowercase.
    city = models.CharField(db_column='City', max_length=30, blank=True, null=True)  # Field name made lowercase.
    zip_code = models.IntegerField(db_column='ZIP_Code', blank=True, null=True)  # Field name made lowercase.
    phone_number = models.CharField(db_column='Phone_Number', max_length=15, blank=True, null=True)  # Field name made lowercase.
    user_type = models.CharField(db_column='User_Type', max_length=15)  # Field name made lowercase.
    security_question_answer = models.CharField(db_column='Security_Question_Answer', max_length=35, null=False)

    is_impersonation = models.BooleanField(db_column='is_impersonation', default=0)

    objects = UserManager()

    class Meta:
        managed = False
        db_table = 'users'
