
# Create your views here.
from django.contrib import messages
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from django.core.exceptions import PermissionDenied
from django.http import Http404
from django.db.models import Q, Sum
from datetime import datetime
from . import backends
from . import models
from . import forms

def register(request):
    import hashlib

    if request.method == 'POST':
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        ##username is the email
        username = request.POST['username']
        password = request.POST['password']
        confirm_password = request.POST['confirm_password']
        street_addr = request.POST['street_address']
        city = request.POST['city']
        zip_code = request.POST['zip_code']
        phone_num = request.POST['phone_num']
        sec_question = request.POST['sec_question']
        
        password_hash = hashlib.md5(password.encode()).hexdigest()
        question_hash = hashlib.md5(sec_question.encode()).hexdigest()
    
        if password==confirm_password:
            if models.Users.objects.filter(email=username).exists():
                messages.info(request, 'Username is already taken')
                return redirect(register)
            
                
            else:
                user = models.Users(email=username, password=password_hash, 
                                         first_name=first_name, last_name=last_name, street_address=street_addr, street_address_2=street_addr, city=city, zip_code=zip_code, phone_number=phone_num, user_type='Driver', security_question_answer=question_hash)
                user.save()
                
                return redirect('done')


        else:
            messages.info(request, 'Both passwords are not matching')
            return redirect(register)
    else:
        return render(request, 'registration.html')
    
    
def driverHome(request):
    return render(request, 'driverHome.html')
    

def login(request):
    from datetime import datetime
    
    if request.method == "POST":
        
        email = request.POST.get('username')
        password = request.POST.get('password')
        
        user = backends.CustomAuthBackend.authenticate( username=email, password=password)
        if user is not None:
            auth_login(request, user)
            message = 'You are logged in!'
            messages.info(request, message)
            
            return redirect(user_profile)
        else:
            if models.Users.objects.filter(email=email).exists():
                user_id_queryset = models.Users.objects.filter(email=email).values('user_id')
                ##gets id from query
                user_id = user_id_queryset[0]['user_id']
                CURRENT_TIME = datetime.utcnow()
                new_login_attempt = models.LoginAttempt(user_id = user_id, date_time=CURRENT_TIME, was_accepted=0)
                new_login_attempt.save()
                #models.LoginAttempt.save(user_id=user_obj, date_time=CURRENT_TIME,was_accepted=0)
            
            message = 'Username or Password Incorrect'
            ##saves message to html template
            messages.info(request, message)
            return redirect(login)
    elif request.method == "GET":
        if request.user.is_anonymous == False:
            messages.info(request, "Already logged in")
            return redirect(user_profile)
        return render(request, 'registration/login.html')

def get_trailing_number(s):
    import re
    m = re.search(r'\d+$', s)
    return int(m.group()) if m else None
    
def logout(request):
    if request.user.is_impersonation == 1:
        # Last digits of a impersonating user's email is the id of the original requester user (either sponsor or admin)
        originalUserID = get_trailing_number(request.user.email)
        sponsorOrAdminEntity = models.Users.objects.get(user_id=originalUserID)
        originalUserType = sponsorOrAdminEntity.user_type

        # Specifically for Sponsors impersonating drivers
        if request.user.user_type == "Driver" and originalUserType == "Sponsor":
            return redirect(end_driver_impersonation)
        # Specifically for Admins impersonating drivers
        elif request.user.user_type == "Driver" and originalUserType == "Admin":
            # replace this with function driver->back to admin*******************************************************
            return redirect(end_admin_driver_impersonation)
        # Specifically for Admins impersonating Sponsors (currently, only admins can impersonate other sponsors, no need to check orig type)
        elif request.user.user_type == "Sponsor":
            # replace this with function sponsor->back to admin*******************************************************
            return redirect(end_admin_sponsor_impersonation)

    if request.method == "POST":
        auth_logout(request)
        
        return redirect(login)
        
    elif request.method == "GET":
        auth_logout(request)
        messages.info(request, "You have logged out")
        return redirect(login)

        

def resetPassword(request):
    import hashlib
    import datetime
    if request.method == 'POST':
        
        change_type = 'User'
        username = request.POST['username']
        new_password = request.POST['new_password']
        confirm_password = request.POST['confirm_password']
        sec_question_answer = request.POST['sec_question']

        answer_hash = hashlib.md5(sec_question_answer.encode()).hexdigest()
        user = models.Users.objects.get(email=username)
        correct_answer_hash = user.security_question_answer

        if answer_hash == correct_answer_hash:
            if new_password == confirm_password:
                # Hash the new password
                hashed_password = hashlib.md5(new_password.encode()).hexdigest()
                print("Debug: " + hashed_password)
                user.password = hashed_password
                user.save()
                pass_change_obj = models.PasswordChanges(user=user, date_time=datetime.datetime.utcnow(), type_of_change=change_type)
                pass_change_obj.save()
                return redirect('done')
            
            else:
                message = "New password and confirm password do not match"
                messages.info(request, message)
                return render(request, 'resetPassword.html', {"message":message})
        else:
            message = "Your mother's maiden name was entered incorrectly."
            messages.info(request, message)
            return render(request, 'resetPassword.html', {"message":message})
            
    else:
        return render(request, 'resetPassword.html')

def sponsorView(request):
    return render(request, 'sponsorView.html')

def pointChange(request):
    from datetime import datetime
    if request.user.is_anonymous == True:
        raise FileNotFoundError
    # Logic for if a user is signed in AND is of the 'Sponsor' type
    elif request.user.user_type == "Sponsor":
        if request.method == "GET":
            user_sponsor_obj = models.SponsorUser.objects.get(user_id=request.user.user_id)
            sponsor_id = getattr(user_sponsor_obj, 'sponsor_id')
            driver_query = models.DriverSponsor.objects.select_related('user').filter(sponsor=sponsor_id).order_by('user__first_name')#.values()
            driver_list = []
            for driver in driver_query:
                id = driver.user.user_id
                name = driver.user.first_name + " " + driver.user.last_name
                driver_list.append({'Name':name, 'id':id})
            
            return render(request, 'pointChange.html', {'driver_list': driver_list})
        elif request.method == "POST":
           
            user_sponsor_obj = models.SponsorUser.objects.get(user_id=request.user.user_id)
            sponsor_id = getattr(user_sponsor_obj, 'sponsor_id')
            point_amount = request.POST['point_amount']

            reasoning=request.POST['reason']
            # Confirm that the reasoning is not blank
            if reasoning == "" or reasoning == "Reason":
                messages.info(request, "Reasoning Field Cannot be left Blank or the default text!")
                return redirect(pointChange)
            if(request.POST['add_or_subtract'] == 'deduct'):
                messages.info(request,"Points Deducted")
                point_amount = str(int(point_amount) * -1)
            else:
                messages.info(request,"Points Added")
            
            
            new_point_history = models.PointsHistory(user=models.Users.objects.get(user_id = request.POST['driver_id']), sponsor=models.Sponsor.objects.get(sponsor_id=sponsor_id), point_change=point_amount, date_time=datetime.utcnow(), reason=reasoning)
            new_point_history.save()
            
            return redirect(pointChange)

def pointHistory(request):
    if request.user.is_anonymous == True:
        redirect(login)
    # Logic for if a user is signed in 
    elif request.user.user_type == "Driver":
        if request.method == "GET":
            points_query = models.Points.objects.select_related('sponsor').filter(user=request.user.user_id)
            points_list = []
            for obj in points_query:
                sponsor = obj.sponsor.name
                points = obj.point_total
                new_dict = {"Sponsor": sponsor, "Points": points}
                points_list.append(new_dict)
            
            points_history_query = models.PointsHistory.objects.select_related('sponsor').filter(user=request.user.user_id).order_by('sponsor__name', "-date_time")
            points_hist_list = []
            for obj in points_history_query:
                sponsor = obj.sponsor.name
                point_change = obj.point_change
                reason = obj.reason
                date_time = obj.date_time

                new_dict = {"sponsor": sponsor, "point_change": point_change, 'reason':reason, "date_time":date_time}
                points_hist_list.append(new_dict)
            
            return render(request, 'pointHistory.html', {"point_list": points_list, "point_history_list":points_hist_list})
        elif request.method == "POST":
            return None

def user_profile(request):
    if request.method == "GET":

        return render(request, 'user_profile.html')
    elif request.method == "POST":
        # Take in new edits
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        street_addr = request.POST['street_address']
        city = request.POST['city']
        zip_code = request.POST['zip_code']
        phone_num = request.POST['phone_number']

        user = models.Users.objects.get(user_id=request.user.user_id)
        if first_name != "":
            user.first_name = first_name
        if last_name != "":
            user.last_name = last_name
        if street_addr != "":
            user.street_address = street_addr
        if city != "":
            user.city = city
        if zip_code != "" and zip_code.isnumeric():
            user.zip_code = int(zip_code)
        elif zip_code != "" and not zip_code.isnumeric():
            messages.info(request, 'Zip Code must be a number')
        if phone_num != "":
            user.phone_number = phone_num

        user.save()
        return render(request, 'user_profile.html')

    
def admin_panel(request):
    # Denies permission to ANYONE who is NOT signed in
    if request.user.is_anonymous == True:
        raise PermissionDenied
    # Logic for if a user is signed in AND is of the 'Admin' type
    elif request.user.user_type == "Admin":
        if request.method == "GET":
            # Give page with button options of letting the admin choose what action they want to take:
                #   - Create Account (Driver, Sponsor, Admin)
                #   - Delete Account (Sponsor)
            return render(request, 'adminPanel.html')
        else: raise Http404
    # Returns 403 Error (Permission Denied)    
    else: raise PermissionDenied

def admin_create_account(request):
    # Denies permission to ANYONE who is NOT signed in
    if request.user.is_anonymous == True:
        raise PermissionDenied
    # Logic for if a user is signed in AND is of the 'Admin' type
    elif request.user.user_type == "Admin":
        if request.method == "GET":
            # Give page with basically a registration page, but with more details available
            return render(request, 'adminCreateAccount.html')
        elif request.method == "POST":
            import hashlib

            first_name = request.POST['first_name']
            last_name = request.POST['last_name']
            ##username is the email
            username = request.POST['username']
            password = request.POST['password']
            confirm_password = request.POST['confirm_password']
            street_addr = request.POST['street_address']
            city = request.POST['city']
            zip_code = request.POST['zip_code']
            phone_num = request.POST['phone_num']
            user_type = request.POST['user_type']
            sec_question = request.POST['sec_question']
            
            password_hash = hashlib.md5(password.encode()).hexdigest()
            sec_hash = hashlib.md5(sec_question.encode()).hexdigest()
            
            if password==confirm_password:
                if models.Users.objects.filter(email=username).exists():
                    messages.info(request, 'Username is already taken')
                    return redirect(admin_create_account)
                else:
                    user = models.Users(email=username, password=password_hash, 
                                            first_name=first_name, last_name=last_name, street_address=street_addr, 
                                            street_address_2=street_addr, city=city, zip_code=zip_code, 
                                            phone_number=phone_num, user_type=user_type, security_question_answer=sec_hash)
                    user.save()
                    
                    if user.user_type == 'Admin':
                        adminUser = models.AdminUser(user=user)
                        adminUser.save()
                    elif user.user_type == 'Sponsor':
                        
                        sponsor = request.POST['sponsor']
                        # Check if the organization exists
                        if models.Sponsor.objects.filter(name=sponsor).exists():
                            organization = models.Sponsor.objects.get(name=sponsor)
                        # if not, make it, if so make it equal to organization
                        else:
                            organization = models.Sponsor(point_value=0.01, name=sponsor)
                            organization.save()

                        sponsorUser = models.SponsorUser(user=user, sponsor=organization)
                        sponsorUser.save()
                    
                    messages.info(request, 'User Created')
                    return redirect('.')
            else:
                messages.info(request, 'Both passwords are not matching')
                return redirect(admin_create_account)
        else: raise Http404
    # Returns 403 Error (Permission Denied)    
    else: raise PermissionDenied
    
# Creates a SPONSOR COMPANY in the sponsor table, NOT a sponsor USER ACCOUNT
def admin_create_sponsor(request):
    # Denies permission to ANYONE who is NOT signed in
    if request.user.is_anonymous == True:
        raise PermissionDenied
    # Logic for if a user is signed in AND is of the 'Admin' type
    elif request.user.user_type == "Admin":
        if request.method == "GET":
            # Give page with basically a registration page, but with more details available
            return render(request, 'adminCreateSponsor.html')
        elif request.method == "POST":

            sponsor_name = request.POST['name']
            point_value = request.POST['point_value']
            
            # Ensures a new sponsor is being created
            if not models.Sponsor.objects.filter(name=sponsor_name).exists():
                new_sponsor = models.Sponsor(point_value=point_value, name=sponsor_name)
                new_sponsor.save()

                return redirect('done')
            else:
                messages.info(request, 'Sponsor Company Name Already Taken! Please Try a Different Name.')
                return redirect(admin_create_sponsor)
        else: raise Http404
    # Returns 403 Error (Permission Denied)    
    else: raise PermissionDenied

def admin_delete_account(request):
    # Denies permission to ANYONE who is NOT signed in
    if request.user.is_anonymous == True:
        raise PermissionDenied
    # Logic for if a user is signed in AND is of the 'Admin' type
    elif request.user.user_type == "Admin":
        if request.method == "GET":
            # Give page with option to enter a user's info to delete from the db
            return render(request, 'adminDeleteAccount.html')
        elif request.method == "POST":
            username = request.POST['username']

            if request.user.email == username:
                messages.info(request, 'You cannot delete your own account while signed-in to it!')
                return redirect(admin_delete_account)

            if models.Users.objects.filter(email=username).exists():
                # Gets the User object for the specified person
                User = models.Users.objects.get(email=username)

                # Logic block to delete from all exterior (non base-user) tables
                

                # Delete from base Users table
                User.delete()
                messages.info(request, 'User has been removed from the system')
                return redirect(admin_delete_account)
            else:
                messages.info(request, 'Username does not exist')
                return redirect(admin_delete_account)
        else: 
            raise Http404
    # Returns 403 Error (Permission Denied)    
    else: raise PermissionDenied

def admin_change_user_password(request):
    import hashlib
    import datetime
    # Denies permission to ANYONE who is NOT signed in
    if request.user.is_anonymous == True:
        raise PermissionDenied
    # Logic for if a user is signed in AND is of the 'Admin' type
    elif request.user.user_type == "Admin":
        if request.method == "GET":
            # Give page with option to enter a user's info to delete from the db
            return render(request, 'adminChangeUserPassword.html')
        elif request.method == "POST":
            username = request.POST['username']
            password = request.POST['password']
            confirm_password = request.POST['confirm_password']

            # Make sure both passwords are the same
            if password != confirm_password:
                messages.info(request, 'Both passwords do not match!')
                return redirect(admin_change_user_password)
            # Ensures password isn't an empty string
            elif password == "":
                messages.info(request, 'Password cannot be blank!')
                return redirect(admin_change_user_password)

            password_hash = hashlib.md5(password.encode()).hexdigest()

            # If the user does exist, it updates their password with the new one in the DB
            if models.Users.objects.filter(email=username).exists():
                userToUpdate = models.Users.objects.get(email=username)
                userToUpdate.password = password_hash
                userToUpdate.save()
                pass_change_obj = models.PasswordChanges(user=userToUpdate, date_time=datetime.datetime.utcnow(), type_of_change='Admin')
                pass_change_obj.save()
                return redirect('done')
            else:
                messages.info(request, 'Username does not exist')
                return redirect(admin_change_user_password)
        else: 
            raise Http404
    # Returns 403 Error (Permission Denied)    
    else: raise PermissionDenied

def admin_add_driver_to_org(request):
    # Denies permission to ANYONE who is NOT signed in
    if request.user.is_anonymous == True:
        raise PermissionDenied
    # Logic for if a user is signed in AND is of the 'Admin' type
    elif request.user.user_type == "Admin":
        if request.method == "GET":
            all_sponsor_query = models.Sponsor.objects.all()
            sponsor_list = []
            
            for sponsor in all_sponsor_query:
                sponsor_id=sponsor.sponsor_id
                point_value=sponsor.point_value
                name=sponsor.name
                new_dict = {'sponsor_id':sponsor_id,'point_value':point_value,'name':name}
                
                sponsor_list.append(new_dict)

            all_driver_query = models.Users.objects.filter(user_type="Driver")
            driver_list = []
            
            for driver in all_driver_query:
                first_name=driver.first_name
                last_name=driver.last_name
                userid=driver.user_id
                email=driver.email
                new_dict = {'name':first_name+' '+last_name,'user_id':userid,'email':email}
                
                driver_list.append(new_dict)

            return render(request, 'adminAddDriverToOrganization.html', {'sponsor_list': sponsor_list, 'driver_list': driver_list})
        elif request.method == "POST":
            driverIDChosen = request.POST['driver']
            sponsorIDChosen = request.POST['sponsor']

            # Check if user is already a part of this sponsor, error if so, otherwise add them to the org and put a success message
            if models.DriverSponsor.objects.filter(user=driverIDChosen, sponsor=sponsorIDChosen).exists():
                messages.info(request, 'This Driver is already a part of the chosen Organization!')
            else:
                driverInstance = models.Users.objects.get(user_id=driverIDChosen)
                sponsorOrgInstance = models.Sponsor.objects.get(sponsor_id=sponsorIDChosen)
                newDriverSponsor = models.DriverSponsor(user=driverInstance, sponsor=sponsorOrgInstance)
                newDriverSponsor.save()
                messages.info(request, 'The Driver has been successfully added to the chosen Organization!')

            return redirect(admin_add_driver_to_org)
    # Returns 403 Error (Permission Denied)    
    else: raise PermissionDenied

def sponsor_panel(request):
    # Denies permission to ANYONE who is NOT signed in
    if request.user.is_anonymous == True:
        raise PermissionDenied
    # Logic for if a user is signed in AND is of the 'Sponsor' type
    elif request.user.user_type == "Sponsor":
        if request.method == "GET":
            # Give page with button options of letting the sponsor choose what action they want to take:
                #   - Create Account (Sponsor)
            return render(request, 'sponsorPanel.html')
        else: raise Http404
    # Returns 403 Error (Permission Denied)    
    else: raise PermissionDenied

# Creates a new sponsor account (Not an organization)
def sponsor_create_account(request):
    # Denies permission to ANYONE who is NOT signed in
    if request.user.is_anonymous == True:
        raise PermissionDenied
    # Logic for if a user is signed in AND is of the 'Sponsor' type
    elif request.user.user_type == "Sponsor":
        if request.method == "GET":
            # Give page with basically a registration page, but with more details available
            return render(request, 'sponsorCreateAccount.html')
        elif request.method == "POST":
            import hashlib
            Sponsor = models.Sponsor.objects.get(sponsor_id=models.SponsorUser.objects.get(user_id=request.user.user_id).sponsor_id)

            first_name = request.POST['first_name']
            last_name = request.POST['last_name']
            ##username is the email
            username = request.POST['username']
            password = request.POST['password']
            confirm_password = request.POST['confirm_password']
            street_addr = request.POST['street_address']
            city = request.POST['city']
            zip_code = request.POST['zip_code']
            phone_num = request.POST['phone_num']
            
            password_hash = hashlib.md5(password.encode()).hexdigest()
            if password==confirm_password:
                if models.Users.objects.filter(email=username).exists():
                    messages.info(request, 'Username is already taken')
                    return redirect(sponsor_create_account)
                else:
                    # Add to Users table
                    user = models.Users(email=username, password=password_hash, 
                                            first_name=first_name, last_name=last_name, street_address=street_addr, 
                                            street_address_2=street_addr, city=city, zip_code=zip_code, 
                                            phone_number=phone_num, user_type="Sponsor")
                    user.save()

                    # Get user id just created from auto-increment, and create a new entry matching it inside sponsor users table
                    sponsorUser = models.SponsorUser(user=user, sponsor=Sponsor)
                    sponsorUser.save()
                    
                    return redirect('done')
            else:
                messages.info(request, 'Both passwords are not matching')
                return redirect(sponsor_create_account)
        else: raise Http404
    # Returns 403 Error (Permission Denied)    
    else: raise PermissionDenied

# Removes driver from the sponsor
def sponsor_remove_driver(request):
    # Denies permission to ANYONE who is NOT signed in
    if request.user.is_anonymous == True:
        raise PermissionDenied
    # Logic for if a user is signed in AND is of the 'Sponsor' type
    elif request.user.user_type == "Sponsor":
        if request.method == "GET":
            return render(request, 'sponsorRemoveDriver.html')
        elif request.method == "POST":
            username = request.POST['username']

            # Checks that this user even exists within the shared table | Also counts as a check that the user is of "Driver" considering only drivers should be in this table
            if models.Users.objects.filter(email=username).exists():
                user_sponsor_obj = models.SponsorUser.objects.get(user_id=request.user.user_id)
                sponsor_id = getattr(user_sponsor_obj, 'sponsor_id')
                sponsor_obj = models.Sponsor.objects.get(sponsor_id=sponsor_id)
                sponsor_name = getattr(sponsor_obj, 'name')
                User = models.Users.objects.get(email=username)
                # Gets the User object for the requester (Sponsor user, not typed tho; just plain User)
                RequestingUser = models.Users.objects.get(email=request.user.email)
                
                # Make sure that exisiting user that sponsor wants to remove is within THEIR organization already
                #    by checking the bridge table entity Driver_Sponsor
                if not models.DriverSponsor.objects.filter(user=User, sponsor=sponsor_obj).exists():
                    messages.info(request, 'Username given is not associated with your Organization!')
                    return redirect(sponsor_remove_driver)

                # Delete all records from DriverSponsor table that has the specified user associated with the sponsor's sponsor id
                models.DriverSponsor.objects.filter(user=User, sponsor_id=sponsor_obj).delete()
                messages.info(request, 'Successfully removed driver')
                return redirect(sponsor_remove_driver)
            else:
                messages.info(request, 'Username does not exist')
                return redirect(sponsor_remove_driver)
        else: raise Http404
    # Returns 403 Error (Permission Denied)    
    else: raise PermissionDenied

# Allows for a sponsor user to create a new driver account that is automatically placed within their organization
def sponsor_add_driver(request):
    # Denies permission to ANYONE who is NOT signed in
    if request.user.is_anonymous == True:
        raise PermissionDenied
    # Logic for if a user is signed in AND is of the 'Sponsor' type
    elif request.user.user_type == "Sponsor":
        if request.method == "GET":
            # Give page with basically a registration page, but with more details available
            return render(request, 'sponsorAddDriverRegistration.html')
        elif request.method == "POST":        
            import hashlib
            # Get the sponsor entity (organization) that matches the sponsor that's signed in and requesting this process
            Sponsor = models.Sponsor.objects.get(sponsor_id=models.SponsorUser.objects.get(user_id=request.user.user_id).sponsor_id)

            first_name = request.POST['first_name']
            last_name = request.POST['last_name']
            ##username is the email
            username = request.POST['username']
            password = request.POST['password']
            confirm_password = request.POST['confirm_password']
            street_addr = request.POST['street_address']
            city = request.POST['city']
            zip_code = request.POST['zip_code']
            phone_num = request.POST['phone_num']
            
            password_hash = hashlib.md5(password.encode()).hexdigest()
            if password==confirm_password:
                if models.Users.objects.filter(email=username).exists():
                    messages.info(request, 'Username already exists! Please choose another one.')
                    return redirect(sponsor_add_driver)
                else:
                    # Add to Users table
                    user = models.Users(email=username, password=password_hash, 
                                            first_name=first_name, last_name=last_name, street_address=street_addr, 
                                            street_address_2=street_addr, city=city, zip_code=zip_code, 
                                            phone_number=phone_num, user_type="Driver")
                    user.save()

                    # Get user just created, and create a new entry matching it inside the Driver_Sponsor table
                    driverSponsor = models.DriverSponsor(user=user, sponsor=Sponsor)
                    
                    driverSponsor.save()
                    
                    return redirect('done')
        else: raise Http404
    # Returns 403 Error (Permission Denied)    
    else: raise PermissionDenied

def sponsor_edit_organization(request):
    if request.user.is_anonymous == True:
        messages.info(request, 'You must be logged in as a sponsor')
        return redirect(login)
    elif request.user.user_type == "Sponsor":
        # check if sponsor is associated with an org, error out and return to sponsorpanel if not
        if not models.SponsorUser.objects.filter(user=request.user.user_id).exists():
            messages.info(request, 'You must be associated with a sponsor organization!')
            return redirect(sponsor_panel)
        
        currSponsorUser = models.SponsorUser.objects.get(user=request.user.user_id)
        sponsorsOrg = models.Sponsor.objects.get(sponsor_id=currSponsorUser.sponsor.sponsor_id)
        #if has a valid org to change, go to the edit org page if GET request
        if request.method == "GET":
            return render(request, 'sponsorEditOrganization.html', {'sponsorName': sponsorsOrg.name})

        #if POST req, update db
        elif request.method == "POST":
            newName = request.POST['newName']
            maxPrice = request.POST['maxPrice']

            if newName != "":
                sponsorsOrg.name = newName
            if maxPrice != "":
                sponsorsOrg.maxPrice = float(maxPrice)

            sponsorsOrg.save()
            messages.info(request, 'Successfully Updated the Organization')
            return render(request, 'sponsorEditOrganization.html', {'sponsorName': sponsorsOrg.name})
    else:
        messages.info(request, 'You must be logged in as a sponsor')
        return redirect(home)

def driverApplications(request):
    from datetime import datetime
    if request.user.is_anonymous == True:
        messages.info(request, 'You must be logged in to apply to a sponsor')
        return redirect(login)
    elif(request.user.user_type == "Driver"):
        ##gets sponsor name that the currently logged in user is a part of

        #get user object
        user_obj = models.Users.objects.get(user_id=request.user.user_id)

        #get user name
        user_name = user_obj.first_name + " " + user_obj.last_name
        
        #find the applications for the driver
        app_list = models.DriverApplication.objects.filter(driver=request.user.user_id)
        
        list_of_apps = []
        for app in app_list:
            sponsor_name = app.sponsor.name
            new_dict = {'sponsor_name':sponsor_name, 'status':app.status, 'reason':app.reason, 'date_time':app.date_time, 'application_id': app.application_id}
            list_of_apps.append(new_dict)

        return render(request, 'driver_application.html', {'app_list': list_of_apps, 'sponsor_name':user_name})

def application(request):
    from datetime import datetime
    if request.user.is_anonymous == True:
        messages.info(request, 'You must be logged in to apply to a sponsor')
        return redirect(login)
    elif request.user.user_type == 'Driver':
        if request.method == "GET":
            ## gets sponsor form from forms.py and puts it in application.html
            form = forms.SponsorForm()
            return render(request,'application.html', {'form': form})
        elif request.method == "POST":
            user_id = request.user.user_id
            user_obj = models.Users.objects.get(user_id=user_id)
            sponsor_obj = models.Sponsor.objects.get(name=request.POST['sponsor_name'])
            
            sponsor_id = getattr(sponsor_obj, 'sponsor_id')
            
            ##prevents duplicate application while original app is still pending
            if(models.DriverApplication.objects.filter(driver=user_id,sponsor=sponsor_id,status='Pending').exists()):
                messages.info(request,"You already applied to " + request.POST['sponsor_name'])
                return redirect(application)
            if(models.DriverSponsor.objects.filter(user=user_id,sponsor=sponsor_obj).exists()):
                messages.info(request,"You are already sponsored by " + request.POST['sponsor_name'])
                return redirect(application)

            CURRENT_TIME = datetime.utcnow()
            

            ##gets id from query
            
            new_Application = models.DriverApplication(driver=user_obj,sponsor=sponsor_obj,date_time=CURRENT_TIME,status="Pending",reason=None)
            new_Application.save()
            messages.info(request, 'You applied successfully')
            return redirect(application)
    elif(request.user.user_type == "Sponsor"):
        if request.method == "GET":
            ##gets sponsor name that the currently logged in user is a part of
            user_sponsor_obj = models.SponsorUser.objects.get(user_id=request.user.user_id)
            sponsor_id = getattr(user_sponsor_obj, 'sponsor_id')
            sponsor_obj = models.Sponsor.objects.get(sponsor_id=sponsor_id)
            sponsor_name = getattr(sponsor_obj, 'name')
            
            ##select related gets the necessary Users objects so the database only needs to be queried once
            app_list = models.DriverApplication.objects.select_related('driver').filter(sponsor=sponsor_obj,status='Pending')
            
            list_of_apps = []
            for app in app_list:
                first_name = app.driver.first_name
                last_name = app.driver.last_name
                street_address = app.driver.street_address
                city = app.driver.city
                zip_code = app.driver.zip_code
                phone_number = app.driver.phone_number
                new_dict = {'first_name':first_name,'last_name':last_name,'street_address':street_address,'city':city,'zip_code':zip_code, 'phone_number':phone_number, 'status':app.status, 'reason':app.reason, 'date_time':app.date_time, 'application_id': app.application_id}
                list_of_apps.append(new_dict)
            
            
            return render(request, 'application.html', {'app_list': list_of_apps, 'sponsor_name':sponsor_name})
        elif request.method == "POST":
            
            application_obj = models.DriverApplication.objects.select_related('sponsor').get(application_id=request.POST['application_id'])
            
            if(request.POST['decision'] == "Accept"):
                new_DriverSponsor = models.DriverSponsor(user=application_obj.driver, sponsor=application_obj.sponsor)
                new_DriverSponsor.save()
                application_obj.status = "Accepted"
                application_obj.reason = request.POST['reason_input']
                application_obj.save()
                messages.info(request, "Successfully Accepted Application Number " + request.POST['application_id'])
            elif(request.POST['decision'] == "Reject"):
                application_obj.status = "Rejected"
                application_obj.reason = request.POST['reason_input']
                application_obj.save()
                messages.info(request, "Successfully Rejected Application Number " + request.POST['application_id'])

            return redirect(application)

def sponsorHome(request):
    return render(request, 'sponsorHome.html')

def adminHome(request):
    return render(request, 'adminHome.html')
def driverManagement(request):
    return render(request, 'driverManagement.html')

def pointTracking(request):
    if request.user.is_anonymous == True:
        return redirect(login)
    elif request.user.user_type == "Sponsor":
        if request.method == "GET":
            return render(request, 'pointTracking.html')
    raise Http404
def driverSales(request):
    import json
    if request.user.is_anonymous == True:
        return redirect(login)
    elif request.user.user_type != "Admin":
        raise PermissionDenied
    if request.method == "GET":
        form = forms.SponsorFormWithAllOption()
        driverQuery = models.DriverSponsor.objects.select_related('user', 'sponsor').all()
        driverList = []
        driverIDs = []
        for driver in driverQuery:
            new_dict = {'name': driver.user.first_name + " " + driver.user.last_name, 'sponsor': driver.sponsor.name}
            id_dict = {'name': driver.user.first_name + " " + driver.user.last_name, 'id': driver.user.user_id}
            driverList.append(new_dict)
            if id_dict not in driverIDs:
                driverIDs.append(id_dict)
        
        return render(request, 'driverSales.html', {'form':form,'driverList': json.dumps(driverList), 'idList':json.dumps(driverIDs)})
    elif request.method == "POST":
        
        ## Sanity checks
        if(request.POST['start_date'] == ''):
            messages.info(request, 'Please Enter a Start Date')
            return redirect('.')
        if(request.POST['end_date'] == ''):
            messages.info(request, 'Please Enter an End Date')
            return redirect('.')
        if(request.POST['end_date'] < request.POST['start_date']):
            messages.info(request, 'End Date must be after Start Date')
            return redirect('.')
        ##Start of actual code
        
        
        if(request.POST['sponsor_name'] == 'All Sponsors'):
            driver_name = "none"
            order_query = models.Orders.objects.select_related('sponsor', 'user').filter(date_time__range=(request.POST['start_date'],request.POST['end_date'])).order_by("sponsor")
            total_orders = len(order_query)
            total_price = round(models.Orders.objects.filter(date_time__range=(request.POST['start_date'],request.POST['end_date'])).aggregate(price__sum = Sum('price', filter=~Q(status='Cancelled')))['price__sum'], 2)
            order_list = []
            for order in order_query:
                sponsor = order.sponsor.name
                item_name = order.item_name
                points = order.points
                price = order.price
                status = order.status
                date_time = order.date_time
                user = order.user.first_name + " " + order.user.last_name
                new_dict = {'item_name':item_name, 'points':points,'price':price,'status':status,'date_time':date_time, 'sponsor':sponsor, 'user':user}
                order_list.append(new_dict)
            
            return render(request, 'driverSalesReport.html', {'report_list': order_list, 'summary':{'total_price':total_price,'total_orders':total_orders}, 'sponsor_name':request.POST['sponsor_name']})
        else:
            driver_name = request.POST['driverChoice']
            if(request.POST['driverChoice'] == 'All Drivers'):
                
                sponsor_obj = models.Sponsor.objects.get(name=request.POST['sponsor_name'])
                order_query = models.Orders.objects.select_related('user').filter(sponsor=sponsor_obj, date_time__range=(request.POST['start_date'],request.POST['end_date'])).order_by("-date_time")
                ## gets number of rows in query
                total_orders = len(order_query)
                print("Total orders are ", end='')
                print(total_orders)
                ## needs the dictionary dereference. This is a complex aggregate which returns a dictionary that is rounded to get the final price
                if total_orders != 0:
                    total_price = round(models.Orders.objects.filter(sponsor=sponsor_obj, date_time__range=(request.POST['start_date'],request.POST['end_date'])).aggregate(price__sum = Sum('price', filter=~Q(status='Cancelled')))['price__sum'], 2)
                else:
                    total_price = 0
                order_list = []
                for order in order_query:
                    item_name = order.item_name
                    points = order.points
                    price = order.price
                    status = order.status
                    date_time = order.date_time
                    user = order.user.first_name + " " + order.user.last_name
                    new_dict = {'item_name':item_name, 'points':points,'price':price,'status':status,'date_time':date_time, 'user':user}
                    order_list.append(new_dict)
            else:
                sponsor_obj = models.Sponsor.objects.get(name=request.POST['sponsor_name'])
                
                user_obj = models.Users.objects.get(user_id=request.POST['driverChoice'])
                order_query = models.Orders.objects.select_related('user').filter(sponsor=sponsor_obj, user=user_obj, date_time__range=(request.POST['start_date'],request.POST['end_date'])).order_by("-date_time")
                ## gets number of rows in query
                total_orders = len(order_query)
                print("Total orders are ", end='')
                print(total_orders)
                ## needs the dictionary dereference. This is a complex aggregate which returns a dictionary that is rounded to get the final price
                if total_orders != 0:
                    
                    total_price = round(models.Orders.objects.filter(sponsor=sponsor_obj, user=user_obj, date_time__range=(request.POST['start_date'],request.POST['end_date'])).aggregate(price__sum = Sum('price', filter=~Q(status='Cancelled')))['price__sum'], 2)
                else:
                    total_price = 0
                order_list = []
                for order in order_query:
                    item_name = order.item_name
                    points = order.points
                    price = order.price
                    status = order.status
                    date_time = order.date_time
                    user = order.user.first_name + " " + order.user.last_name
                    new_dict = {'item_name':item_name, 'points':points,'price':price,'status':status,'date_time':date_time, 'user':user}
                    order_list.append(new_dict)
        return render(request, 'driverSalesReport.html', {'report_list': order_list, 'summary':{'total_price':total_price,'total_orders':total_orders}, 'sponsor_name':request.POST['sponsor_name'], 'driver_name':driver_name})


def sponsorSales(request):
    if request.user.is_anonymous == True:
        return redirect(login)
    elif request.user.user_type != "Admin":
        raise PermissionDenied
    if request.method == "GET":
        form = forms.SponsorFormWithAllOption()
        return render(request, 'sponsorSales.html', {'form':form})
    elif request.method == "POST":
        print(request.POST)
        ## Sanity checks
        if(request.POST['start_date'] == ''):
            messages.info(request, 'Please Enter a Start Date')
            return redirect('.')
        if(request.POST['end_date'] == ''):
            messages.info(request, 'Please Enter an End Date')
            return redirect('.')
        if(request.POST['end_date'] < request.POST['start_date']):
            messages.info(request, 'End Date must be after Start Date')
            return redirect('.')
        if(request.POST['sponsor_name'] == 'All Sponsors'):
            order_query = models.Orders.objects.select_related('sponsor').filter(date_time__range=(request.POST['start_date'],request.POST['end_date'])).order_by("sponsor")
            total_orders = len(order_query)
            if total_orders != 0:
                total_price = round(models.Orders.objects.filter( date_time__range=(request.POST['start_date'],request.POST['end_date'])).aggregate(price__sum = Sum('price', filter=~Q(status='Cancelled')))['price__sum'], 2)
            else:
                total_price = 0
            order_list = []
            for order in order_query:
                sponsor = order.sponsor.name
                item_name = order.item_name
                points = order.points
                price = order.price
                status = order.status
                date_time = order.date_time
                new_dict = {'item_name':item_name, 'points':points,'price':price,'status':status,'date_time':date_time, 'sponsor':sponsor}
                order_list.append(new_dict)
            #messages.info(request, 'Working on it')
            return render(request, 'sponsorSalesReport.html', {'report_list': order_list, 'summary':{'total_price':total_price,'total_orders':total_orders}, 'sponsor_name':request.POST['sponsor_name']})
        else:
            sponsor_obj = models.Sponsor.objects.get(name=request.POST['sponsor_name'])
            order_query = models.Orders.objects.filter(sponsor=sponsor_obj, date_time__range=(request.POST['start_date'],request.POST['end_date'])).order_by("-date_time")
            ## gets number of rows in query
            total_orders = len(order_query)
            ## needs the dictionary dereference. This is a complex aggregate which returns a dictionary that is rounded to get the final price
            if total_orders != 0:
                total_price = round(models.Orders.objects.filter(sponsor=sponsor_obj, date_time__range=(request.POST['start_date'],request.POST['end_date'])).aggregate(price__sum = Sum('price', filter=~Q(status='Cancelled')))['price__sum'], 2)
            else:
                total_price = 0
            order_list = []
            for order in order_query:
                item_name = order.item_name
                points = order.points
                price = order.price
                status = order.status
                date_time = order.date_time
                new_dict = {'item_name':item_name, 'points':points,'price':price,'status':status,'date_time':date_time}
                order_list.append(new_dict)

        return render(request, 'sponsorSalesReport.html', {'report_list': order_list, 'summary':{'total_price':total_price,'total_orders':total_orders}, 'sponsor_name':request.POST['sponsor_name']})

def invoice(request):
    if request.user.is_anonymous == True:
        return redirect(login)
    elif request.user.user_type != "Admin":
        raise PermissionDenied
    if request.method == "GET":
        form = forms.SponsorFormWithAllOption()
        return render(request, 'invoice.html', {'form':form})

def audit(request):
    if request.user.is_anonymous == True:
        raise FileNotFoundError
    elif request.user.user_type == "Sponsor":
        if request.method == "GET":
            return render(request, 'audit.html')
        elif request.method == "POST":
            start_date = request.POST.get('start_date')
            end_date = request.POST.get('end_date')
            current_date = datetime.now().strftime('%Y-%m-%d')

            if start_date and end_date and start_date > end_date:
                return render(request, 'audit.html', {'error': 'Start date should be before end date'})
            elif start_date and end_date and start_date > current_date:
                return render(request, 'audit.html', {'error': 'Start date should be before current date'})
            elif start_date and end_date and end_date > current_date:
                return render(request, 'audit.html', {'error': 'End date should be before current date'})

            user_sponsor_obj = models.SponsorUser.objects.get(user_id=request.user.user_id)
            sponsor_id = getattr(user_sponsor_obj, 'sponsor_id')
            sponsor_obj = models.Sponsor.objects.get(sponsor_id=sponsor_id)
            sponsor_name = getattr(sponsor_obj, 'name')

            driver_list = []
            
            if request.POST['options'] == "password_change":
               
                driver_query = models.DriverSponsor.objects.select_related('user').filter(sponsor=sponsor_obj)
                for driver in driver_query:
                    pass_change_query = models.PasswordChanges.objects.filter(user=driver.user)
                    for entry in pass_change_query:
                        date = entry.date_time
                        first_name = driver.user.first_name
                        last_name = driver.user.last_name
                        type_change = entry.type_of_change
                        new_dict = {'date':date,'first_name':first_name,'last_name':last_name,'type_change':type_change}
                        driver_list.append(new_dict)
                return render(request, 'passwordChangeAudit.html', {'driver_list': driver_list})
                
            elif request.POST['options'] == "login_attempt":
                driver_query = models.DriverSponsor.objects.select_related('user').filter(sponsor=sponsor_obj)
                for driver in driver_query:
                    login_query = models.LoginAttempt.objects.filter(user=driver.user)
                    for entry in login_query:
                        date = entry.date_time
                        first_name = driver.user.first_name
                        last_name = driver.user.last_name
                        if entry.was_accepted == b"\x01":
                            was_accepted = "True"
                        else:
                            was_accepted = "False"
                        new_dict = {'date':date,'first_name':first_name,'last_name':last_name,'was_accepted':was_accepted}
                        driver_list.append(new_dict)
                return render(request, 'loginAttemptAudit.html', {'driver_list': driver_list})
            
            elif request.POST['options'] == "point_change":
                driver_query = models.PointsHistory.objects.select_related('user').filter(sponsor=sponsor_obj,date__range=[start_date,end_date])
                for driver in driver_query:
                    first_name = driver.user.first_name
                    last_name = driver.user.last_name
                    point_total = 0
                    point_change = driver.point_change
                    reason = driver.reason
                    date = driver.date_time
                    new_dict = {'first_name':first_name,'last_name':last_name,'point_total':point_total,'point_change':point_change,'reason':reason,'date':date}
                    driver_list.append(new_dict)
                return render(request, 'pointChangeAudit.html', {'driver_list': driver_list})
            
            elif request.POST['options'] == "driver_application":
                application_query = models.DriverApplication.objects.select_related('sponsor','driver')
                for app in application_query:
                    driver_app_query = models.ApplicationStateChange.objects.filter(application=app.application_id)
                    for entry in driver_app_query:
                        date = entry.date_time
                        first_name = app.driver.first_name
                        last_name = app.driver.last_name
                        status = entry.new_status
                        reason = entry.new_reason
                        new_dict = {'date':date,'first_name':first_name,'last_name':last_name,'status':status,'reason':reason}
                        driver_list.append(new_dict)
                return render(request, 'driverApplicationAudit.html', {'driver_list': driver_list})

def sponsorReport(request):
    return render(request, 'sponsorReport.html')

def adminReport(request):
    return render(request, 'adminReport.html')

def report(request):
    if request.user.is_anonymous == True:
        return redirect(login)
    if request.user.user_type == "Sponsor":
        return render(request, 'sponsorReport.html')
    if request.user.user_type == "Admin":
        return render(request, 'adminReport.html')
def adminInfo(request):
    return render(request, 'adminInfo.html')

def sponsor_see_all_drivers(request):
    if request.user.is_anonymous == True:
        raise FileNotFoundError
    # Logic for if a user is signed in AND is of the 'Sponsor' type
    elif request.user.user_type == "Sponsor":
        if request.method == "GET":
            user_sponsor_obj = models.SponsorUser.objects.get(user_id=request.user.user_id)
            sponsor_id = getattr(user_sponsor_obj, 'sponsor_id')
            sponsor_obj = models.Sponsor.objects.get(sponsor_id=sponsor_id)
            sponsor_name = getattr(sponsor_obj, 'name')
            
            ##select related gets the necessary Users objects so the database only needs to be queried once
            driver_query = models.DriverSponsor.objects.select_related('user').filter(sponsor=sponsor_obj)
            driver_list = []
            
            for driver in driver_query:
                
                
                first_name = driver.user.first_name
                last_name = driver.user.last_name
                street_address = driver.user.street_address
                city = driver.user.city
                zip_code = driver.user.zip_code
                phone_number = driver.user.phone_number
                new_dict = {'first_name':first_name,'last_name':last_name,'street_address':street_address,'city':city,'zip_code':zip_code, 'phone_number':phone_number}
                
                driver_list.append(new_dict)
            
            return render(request, 'all_drivers.html', {'driver_list': driver_list, 'sponsor_name':sponsor_name})
        elif request.method == "POST":
            return None


def pointChangeAudit(request):
    if request.user.is_anonymous == True:
        raise FileNotFoundError
    elif request.user.user_type == "Sponsor":
        if request.method == "GET":
            user_sponsor_obj = models.SponsorUser.objects.get(user_id=request.user.user_id)
            sponsor_id = getattr(user_sponsor_obj, 'sponsor_id')
            sponsor_obj = models.Sponsor.objects.get(sponsor_id=sponsor_id)
            sponsor_name = getattr(sponsor_obj, 'name')

            start_date = request.GET.get('start_date')
            end_date = request.GET.get('end_date')

            driver_query = models.PointsOld.objects.select_related('user').filter(sponsor=sponsor_obj,date_time__range=(start_date, end_date))
            driver_list = []
            
            for driver in driver_query:
                first_name = driver.user.first_name
                last_name = driver.user.last_name
                point_total = driver.point_total
                point_change = driver.points_added_or_deducted
                reason = driver.reason
                date = driver.date_time
                new_dict = {'first_name':first_name,'last_name':last_name,'point_total':point_total,'point_change':point_change,'reason':reason,'date':date}
                driver_list.append(new_dict)

            response = HttpResponse(content_type='text/csv')
            response['Content-Disposition'] = 'attachment; filename="Point_Change_Audit.csv"'
            writer = csv.writer(response)
            writer.writerow(['Driver', 'Last Name', 'Point Total', 'Point Change', 'Reason', 'Date'])
            for driver in driver_list:
                writer.writerow([driver['first_name'], driver['last_name'], driver['point_total'], driver['point_change'], driver['reason'], driver['date']])

            return response and render(request, 'pointChangeAudit.html', {'driver_list': driver_list, 'sponsor_name':sponsor_name})
    elif request.method == "POST":
            return None

def home(request):
    
    if request.user.is_anonymous == True:
        message = 'Please log in to access the home page'
        ##saves message to html template
        messages.info(request, message)
        return redirect(login)
    elif request.user.user_type == "Driver":
        return render(request, 'driverHome.html')
    elif request.user.user_type == "Sponsor":
        return render(request, 'sponsorHome.html')
    elif request.user.user_type == "Admin":
        return render(request, 'adminHome.html')
def admin_edit_account(request):
    # Denies permission to anyone who is not signed in as an Admin
    if  request.user.is_anonymous == True or (request.user.user_type != "Admin" and request.user.user_type != "Sponsor"):
        raise PermissionDenied

    #print('User ID:', request.user.user_id)

    both_forms = {"form1": forms.getDriverEmail, "form2": forms.getDriverInfo}

    if request.method == "GET":
        return render(request, 'adminEditAccount.html', both_forms)
    elif request.method == "POST":
        print(request.POST)
        #get the requested email from the POST request
        form1 = forms.getDriverEmail(request.POST)

        # if the form is valid, update the email, otherwise use the previous email
        if form1.is_valid():
            target_user_email = form1.cleaned_data['email']
        else:
            target_user_email = request.POST['email']

        # if the user has requested info about a driver by entering their email
        if 'showInfo' in request.POST:

            #make sure these are different invalid IDs
            #    so they will only match if both the driver and the sposor are in the same organization
            target_sponsor_id = -1
            sponsor_id = -2

            #make sure the user exists
            if models.Users.objects.filter(email=target_user_email).exists():

                #get the user from the database
                target_user_queryset = models.Users.objects.filter(email=target_user_email).values('email', 'first_name', 'last_name', 'phone_number', 'street_address', 'street_address_2', 'user_type', 'zip_code', 'city', 'user_id')
                target = target_user_queryset[0]
                user_id = target['user_id']

                #if the requested driver exists, find their sponsor_id
                if models.DriverSponsor.objects.filter(user_id=target['user_id']).exists():
                    target_sponsor_id = models.DriverSponsor.objects.filter(user_id=target['user_id']).values('sponsor_id')[0]['sponsor_id']
            else:
                messages.info(request, "Not a user")
                return redirect('.')
            #get the sponsor ID for the logged in user
            if models.SponsorUser.objects.filter(user_id=request.user.user_id).exists():
                sponsor_id = models.SponsorUser.objects.filter(user_id=request.user.user_id).values('sponsor_id')[0]['sponsor_id']

            #if the web user is authorized to see and modify the target user's data
            if  sponsor_id == target_sponsor_id or request.user.user_type == 'Admin':
                #populate the returned page with the data about the requested driver
                context_data =  {"form1": forms.getDriverEmail, "form2": forms.getDriverInfo, 'other_email': target['email'], 'other_first_name': target['first_name'], 'other_last_name':target['last_name'], 'other_street_address':target['street_address'], 'other_city':target['city'], 'other_zip_code':target['zip_code'], 'other_phone_number':target['phone_number'], 'other_user_type':target['user_type'], 'user_id':user_id}
            else:
                #do non populate any context data, only provide the blank forms
                context_data = both_forms
            return render(request, 'adminEditAccount.html', context_data)
        #   
        #  If the "Update Provided Fields" button is pressed
        #
        elif 'updateInfo' in request.POST:
            #print('Updating info')
            #get form submission data
            context_data = {}
            first_name = request.POST['first_name']
            last_name = request.POST['last_name']
            street_addr = request.POST['street_address']
            city = request.POST['city']
            zip_code = request.POST['zip_code']
            phone_num = request.POST['phone_number']
            email = request.POST['email']

            target_user_queryset = models.Users.objects.get(email=email)#.values('email', 'first_name', 'last_name', 'phone_number', 'street_address', 'street_address_2', 'user_type', 'zip_code', 'city', 'user_id')
            #update queryset for updated info
            if first_name != "":
                target_user_queryset.first_name = first_name
                context_data['other_first_name'] = first_name 
            if last_name != "":
                target_user_queryset.last_name =last_name
                context_data['other_last_name'] = last_name
            if street_addr != "":
                target_user_queryset.street_address=street_addr
                context_data['other_street_address'] = street_addr
            if city != "":
                target_user_queryset.city=city
                context_data['other_city'] = city
            if zip_code != "" and zip_code.isnumeric():
                target_user_queryset.zip_code=zip_code
                context_data['other_zip_code'] = zip_code
            if phone_num != "":
                target_user_queryset.phone_number=phone_num
                context_data['other_phone_number'] = phone_num
            target_user_queryset.save()
        else:
            context_data = both_forms
        messages.info(request, 'User ' + request.POST['email'] + " has been updated")
        return redirect(".")

def catalog(request):
    if request.user.is_anonymous == True:
        redirect(login)
    # Logic for if a user is signed in 
    elif request.user.user_type == "Driver":
        if request.method == "GET":
            driver_sponsor_query = models.DriverSponsor.objects.select_related('sponsor').filter(user=request.user.user_id)
            sponsor_list = []
            for obj in driver_sponsor_query:
                sponsor_list.append(obj.sponsor.name)
            
            #print(sponsor_list)
            return render(request, 'catalog.html', {'sponsor_list':sponsor_list})
        elif request.method == "POST" and 'sponsor_name' in request.POST:
            url = './' + request.POST['sponsor_name'] + '/catalogOverview/pageNum=1'
            return redirect(url)
        # Invalid Organization chosen
        else:
            driver_sponsor_query = models.DriverSponsor.objects.select_related('sponsor').filter(user=request.user.user_id)
            sponsor_list = []
            for obj in driver_sponsor_query:
                sponsor_list.append(obj.sponsor.name)
            
            #print(sponsor_list)
            messages.info(request, 'An Invalid Organization Was Chosen!')
            return render(request, 'catalog.html', {'sponsor_list':sponsor_list})
    elif request.user.user_type == "Sponsor":
        sponsor_model = models.SponsorUser.objects.select_related('sponsor').get(user=request.user.user_id)
        url = './' + sponsor_model.sponsor.name + '/catalogOverview/pageNum=1'
        return redirect(url)
    
def catalog_overview(request, sponsor, pageNum=1, search="search"):
    import math
    # We will need to determine what sponsors can choose for filtering the catalog page ex: name, category, price, etc. (or all the above!)
        # this currently just tests it with a simple query for the name of the item (IN SANDBOX MODE)
    if request.method == "GET" and request.user.user_type == "Driver":
        # Validate that the driver's link with the sponsor is one of their actual sponsors
        sponsor_list_query = models.DriverSponsor.objects.select_related('sponsor').filter(user=request.user.user_id)
        sponsor_found = False
        for obj in sponsor_list_query:
           if obj.sponsor.name == sponsor:
               sponsor_found = True
        if sponsor_found == False:
            messages.info(request, 'An Invalid Organization Was Chosen!')
            return redirect(catalog)
        
        sponsor_obj = models.Sponsor.objects.get(name=sponsor)
        conversion_rate = sponsor_obj.point_value
        try:
            points_obj = models.Points.objects.get(user=request.user, sponsor=sponsor_obj)
            current_points = points_obj.point_total
        except:
            current_points = 0

        sponsorMaxPrice = sponsor_obj.maxPrice
        results_tuple = search_ebay_products(search, pageNum, sponsorMaxPrice)

        sponsor_entity = models.Sponsor.objects.get(name=sponsor)
        
        
        try:
            

            productResultsDict = results_tuple[0]
            
            total_pages = results_tuple[1]
            if(productResultsDict != {}):
                for item in productResultsDict['searchResult']['item']:
                    item["point_cost"] = math.ceil(float(item['sellingStatus']['currentPrice']['value']) / float(conversion_rate))
                
            
            return render(request, 'catalog_overview.html', {"product_result_list": productResultsDict, 'pageNum': pageNum, 'totalPages': int(total_pages), 'search':search, 'sponsor':sponsor, 'points':current_points, 'sponsorPointConversion':conversion_rate})
        except Exception as e:
            print(e)
            productResultsDict = {}
            total_pages = 0
            return render(request, 'catalog_overview.html', {"product_result_list": productResultsDict, 'pageNum': pageNum, 'totalPages': int(total_pages), 'search':search
                                                             , 'points': current_points, 'sponsorPointConversion': conversion_rate, 
                                                             'sponsor': sponsor})
    # If a sponsor user decides to use the catalog, they can only access their own
    if request.method == "GET" and request.user.user_type == "Sponsor":
        # Validate that the driver's link with the sponsor is one of their actual sponsors
        sponsor_list_query = models.SponsorUser.objects.select_related('sponsor').filter(user=request.user.user_id)
        sponsor_found = False
        for obj in sponsor_list_query:
           if obj.sponsor.name == sponsor:
               sponsor_found = True
        if sponsor_found == False:
            messages.info(request, 'An Invalid Organization Was Chosen!')
            return redirect(catalog)

        #print(search)
        currSponsorUser = models.SponsorUser.objects.get(user=request.user.user_id)
        sponsorMaxPrice = models.Sponsor.objects.get(sponsor_id=currSponsorUser.sponsor.sponsor_id).maxPrice
        results_tuple = search_ebay_products(search, pageNum, sponsorMaxPrice)

        sponsor_entity = models.Sponsor.objects.get(name=sponsor)
        
        productResultsDict = results_tuple[0]
        
        total_pages = results_tuple[1]
        return render(request, 'catalog_overview.html', {"product_result_list": productResultsDict, 'pageNum': pageNum, 'totalPages': int(total_pages), 'search':search
                                                            , 'pointsAvailable': 0, 'sponsorPointConversion': sponsor_entity.point_value, 
                                                            'sponsor': sponsor, 'minPointsForADollar': 0})

    elif request.method == "POST":
        
        return redirect('../pageNum=1&&search=' + request.POST['search'])

def search_ebay_products(query, pageNum, sponsorMaxPrice):
    import datetime
    from ebaysdk.exception import ConnectionError
    from ebaysdk.finding import Connection as Finding
    from ebaysdk.shopping import Connection as Shopping

    try:
        api = Finding(domain='svcs.sandbox.ebay.com', appid='HaydenSt-DriverIn-SBX-0cd4f0a51-76ca4c5c', config_file=None)
        response = api.execute('findItemsAdvanced', {
            'keywords': query,
            'itemFilter': [
                # Category that excludes all NSFW results
                {'name': 'ExcludeCategory', 'value': '176992'},
                {'name': 'MaxPrice', 'value': str(sponsorMaxPrice), 'paramName': 'Currency', 'paramValue': 'USD'}
            ],
            'paginationInput': { 
                'entriesPerPage': 10,
                'pageNumber': pageNum
            }
        })
        
        #print(response.dict())
        try:
            total_pages = response.reply.paginationOutput.totalPages
        except:
            total_pages = 0
        if(response.reply.searchResult._count == '0'):
            return {}, total_pages
        assert(response.reply.ack == 'Success')
        assert(type(response.reply.timestamp) == datetime.datetime)
        assert(type(response.reply.searchResult.item) == list)

        item = response.reply.searchResult.item[0]
        assert(type(item.listingInfo.endTime) == datetime.datetime)
        assert(type(response.dict()) == dict)
        #print(response.dict())
        
        total_pages = response.reply.paginationOutput.totalPages
        return response.dict(), total_pages

    except ConnectionError as e:
        print(e)
        print(e.response.dict())

def order_item(request, sponsor):
    import datetime
    import math
    if request.method == "GET":
        raise Http404
    elif request.method == "POST":
        if request.user.user_type == "Driver":
            #print(request.POST)
            user=request.user
            sponsor_obj = models.Sponsor.objects.get(name=sponsor)
            sponsor_id = sponsor_obj.sponsor_id
            conversion_rate = sponsor_obj.point_value
            
            
            price = float(request.POST['price'][1:])
            current_time = datetime.datetime.utcnow()
            
            item_id = request.POST['item_id']
            

            
            
            
            point_cost = math.ceil(float(price) / float(conversion_rate))
            

            points_obj = models.Points.objects.get(user=user, sponsor=sponsor_obj)
            current_points = points_obj.point_total
            item_name = request.POST['item_name']
            
            
            if(current_points < point_cost):
                messages.info(request, "You do not have enough points to order that item")
                return redirect("./catalogOverview/pageNum=1")
            
            point_history_obj = models.PointsHistory(user=user, sponsor=sponsor_obj, point_change=(point_cost * -1), date_time=current_time, reason="Item Ordered")
            point_history_obj.save()

            new_order = models.Orders(user=user, sponsor=sponsor_obj, date_time=current_time, status='Pending', price=price, points=point_cost, item_id=item_id, item_name=item_name)
            new_order.save()
            

            messages.info(request, "Item Ordered")
            return redirect("./catalogOverview/pageNum=1")
            
        else:
            raise Http404
    
def order(request):
    import datetime
    if request.user.is_anonymous == True:
        message = 'Please log in'
        ##saves message to html template
        messages.info(request, message)
        return redirect(login)
    elif request.user.user_type == "Driver":
        if request.method == "GET":
            user = request.user
            curr_order_query = models.Orders.objects.select_related('sponsor').filter(Q(user=user), Q(status='Pending') | Q(status='Confirmed') | Q(status='Shipped')) 
            completed_order_query = models.Orders.objects.select_related('sponsor').filter(Q(user=user), Q(status='Delivered') | Q(status='Cancelled')) 
            curr_order_list = []
            completed_order_list = []
            for entry in curr_order_query:
                order_id = entry.order_id
                date = entry.date_time
                status = entry.status
                points = entry.points
                item_id = entry.item_id
                item_name= entry.item_name
                sponsor = entry.sponsor.name
                new_dict = {'date':date, 'status':status,'points':points, 'item_id':item_id, 'sponsor':sponsor, 'order_id':order_id, 'item_name':item_name}
                curr_order_list.append(new_dict)
            #print(curr_order_list)
            for entry in completed_order_query:
                order_id = entry.order_id
                date = entry.date_time
                status = entry.status
                points = entry.points
                item_id = entry.item_id
                item_name= entry.item_name
                sponsor = entry.sponsor.name
                new_dict = {'date':date, 'status':status,'points':points, 'item_id':item_id, 'sponsor':sponsor, 'order_id':order_id, 'item_name':item_name}
                completed_order_list.append(new_dict)
            

            return render(request, 'orders.html', {'curr_order_list':curr_order_list, 'completed_order_list':completed_order_list})
        elif request.method == "POST":
            
            order = models.Orders.objects.get(order_id=request.POST['order_id'])
            order.status = "Cancelled"
            sponsor_obj = order.sponsor
            point_to_refund = order.points
            order.save()
            point_history_obj = models.PointsHistory(user=request.user, sponsor=sponsor_obj, point_change=point_to_refund, date_time=datetime.datetime.utcnow(), reason="Order Cancelled")
            point_history_obj.save()
            messages.info(request, "Order Cancelled. You will be refunded shortly")
            return redirect('../orders')

# For Sponsor users, this starts the Driver impersonation session, adds new Driver to db, and logs them into that limited account with points pre-added    
def start_driver_impersonation(request):
    if request.user.user_type == "Sponsor":
        import hashlib

        if not models.SponsorUser.objects.filter(user_id=request.user.user_id).exists():
            messages.info(request, "You are not part of an Organization! Unable to impersonate a Driver.")
            return redirect(user_profile)

        # Create impersonation driver within the given org (Has a unique email tied to the requester's id)
        email = "driverImpostor" + str(request.user.user_id)
        imp_driver = models.Users(email=email, password=hashlib.md5("1234".encode()).hexdigest(), 
                                            first_name="Impostor", last_name="Driver", street_address="1234 Impostor Ln", street_address_2="1234 Impostor Ln", 
                                            city="Impostorville", zip_code=12345, 
                                            phone_number="No Phone", user_type='Driver', is_impersonation=1)
        imp_driver.save()

        # Add this new driver to requester's org and add points to play with (no ordering allowed) (Driver_Sponsor and Points tables edited)
            # Sponsor from requester (MUST HAVE SPONSOR ORG ASSOCIATED WITH SPONSOR USER IN ORDER TO WORK!)
        sponsor=models.Sponsor.objects.get(sponsor_id=models.SponsorUser.objects.get(user_id=request.user.user_id).sponsor_id)
        driverSponsorEntry = models.DriverSponsor(user=imp_driver, sponsor=sponsor)
        driverSponsorEntry.save()

        pointEntry = models.Points(user=imp_driver, sponsor=sponsor, point_total=99999)
        pointEntry.save()
        
        # Store the original user's email and password in the session
        oldEmail = request.user.email
        oldPassword = request.user.password
        impDriverEmail = imp_driver.email

        auth_logout(request)

        # Log in user as impostor
        user = backends.CustomAuthBackend.authenticate(username=email, password="1234")
        if user is not None:
            auth_login(request, user)
            message = 'You are logged in as the impostor driver!'
            messages.info(request, message)

        request.session['original_email'] = oldEmail
        request.session['original_password'] = oldPassword
        request.session['impostor_driver'] = impDriverEmail

        return redirect(user_profile)
    else:
        return redirect(user_profile)

# For Sponsor users, this ends the Driver impersonation session, deletes from db, and relogs them back into their original Sponsor account
def end_driver_impersonation(request):
    oldEmail = request.session.get('original_email')
    oldPassword = request.session.get('original_password')
    impDriverEmail = request.session.get('impostor_driver')

    # Clear the session variables
    del request.session['original_email']
    del request.session['original_password']
    del request.session['impostor_driver']

    # Log out of driver impostor
    auth_logout(request)

    # Log back into the original requester's account, frictionlessly
    user = backends.CustomAuthBackend.prehashed_auth(username=oldEmail, password=oldPassword)
    if user is not None:
        auth_login(request, user)

    # Delete the impostor's instances from Users, Driver_Sponsor, and Points tables
    imp_driver = models.Users.objects.get(email=impDriverEmail)
    driverSponsorEntry = models.DriverSponsor.objects.get(user=imp_driver)
    driverSponsorEntry.delete()

    pointEntry = models.Points.objects.get(user=imp_driver)
    pointEntry.delete()

    imp_driver.delete()

    messages.info(request, "You have successfully ended the impostor session, and are now logged back into your original account.")
    return redirect(user_profile)

# For Admin users, this is the menu to choose which view they want (Driver or Sponsor)
def change_view(request):
    if request.method == "GET":
        all_sponsor_query = models.Sponsor.objects.all()
        sponsor_list = []
        sponsor_list.append({'sponsor_id':-1,'point_value':0.0,'name':"Empty Sponsor"})
        
        for sponsor in all_sponsor_query:
            sponsor_id=sponsor.sponsor_id
            point_value=sponsor.point_value
            name=sponsor.name
            new_dict = {'sponsor_id':sponsor_id,'point_value':point_value,'name':name}
            
            sponsor_list.append(new_dict)

        return render(request, 'change_view.html', {'sponsor_list': sponsor_list})
    elif request.method == "POST":
        # Default value for a blank sponsor
        chosenSponsor = models.Sponsor(sponsor_id=-1, point_value=0.0, name="Empty Sponsor")

        # Gets the sponsor id from the drop-down menu in change_view
        if request.POST['sponsor'] != "-1":
            chosenSponsor = models.Sponsor.objects.get(sponsor_id=request.POST['sponsor'])
      
        userTypeChosen = request.POST['user_type']
        request.session['sponsor'] = chosenSponsor.sponsor_id

        if userTypeChosen == "Sponsor":
            return redirect(start_admin_sponsor_impersonation)
        elif userTypeChosen == "Driver":
            return redirect(start_admin_driver_impersonation)
        
# Logs in the Admin user into the impersonator Driver account
def start_admin_driver_impersonation(request):
    if request.user.user_type == "Admin":
        chosenSponsor = request.session.get('sponsor')
        import hashlib

        # Create impersonation driver within the given org (Has a unique email tied to the requester's id)
        email = "driverImpostor" + str(request.user.user_id)
        imp_driver = models.Users(email=email, password=hashlib.md5("1234".encode()).hexdigest(), 
                                            first_name="Impostor", last_name="Driver", street_address="1234 Impostor Ln", street_address_2="1234 Impostor Ln", 
                                            city="Impostorville", zip_code=12345, 
                                            phone_number="No Phone", user_type='Driver', is_impersonation=1)
        imp_driver.save()

        # Add this new driver to requested org and add points to play with (no ordering allowed) (Driver_Sponsor and Points tables edited)
        if chosenSponsor != -1:
            sponsor=models.Sponsor.objects.get(sponsor_id=chosenSponsor)
            driverSponsorEntry = models.DriverSponsor(user=imp_driver, sponsor=sponsor)
            driverSponsorEntry.save()

            pointEntry = models.Points(user=imp_driver, sponsor=sponsor, point_total=99999)
            pointEntry.save()

        del request.session['sponsor']
        
        # Store the original user's email and password in the session
        oldEmail = request.user.email
        oldPassword = request.user.password
        impDriverEmail = imp_driver.email

        auth_logout(request)

        # Log in user as impostor
        user = backends.CustomAuthBackend.authenticate(username=email, password="1234")
        if user is not None:
            auth_login(request, user)
            message = 'You are logged in as the impostor driver!'
            messages.info(request, message)

        request.session['original_email'] = oldEmail
        request.session['original_password'] = oldPassword
        request.session['impostor_driver'] = impDriverEmail

        return redirect(user_profile)
    else:
        return redirect(user_profile)

# Logs out the Admin user of the impersonator Driver account, and back into their Admin account
def end_admin_driver_impersonation(request):
    oldEmail = request.session.get('original_email')
    oldPassword = request.session.get('original_password')
    impDriverEmail = request.session.get('impostor_driver')

    # Clear the session variables
    del request.session['original_email']
    del request.session['original_password']
    del request.session['impostor_driver']

    # Log out of driver impostor
    auth_logout(request)

    # Log back into the original requester's account, frictionlessly
    user = backends.CustomAuthBackend.prehashed_auth(username=oldEmail, password=oldPassword)
    if user is not None:
        auth_login(request, user)

    # Delete the impostor's instances from Users, Driver_Sponsor, and Points tables
    imp_driver = models.Users.objects.get(email=impDriverEmail)
    if models.DriverSponsor.objects.filter(user=imp_driver).exists():
        driverSponsorEntry = models.DriverSponsor.objects.get(user=imp_driver)
        driverSponsorEntry.delete()

        pointEntry = models.Points.objects.get(user=imp_driver)
        pointEntry.delete()

    imp_driver.delete()

    messages.info(request, "You have successfully ended the impostor session, and are now logged back into your original account.")
    return redirect(user_profile)

# Logs in the Admin user into the impersonator Sponsor account
def start_admin_sponsor_impersonation(request):
    if request.user.user_type == "Admin":
        chosenSponsor = request.session.get('sponsor')
        import hashlib

        # Create impersonation sponsor within the given org (Has a unique email tied to the requester's id)
        email = "sponsorImpostor" + str(request.user.user_id)
        imp_sponsor = models.Users(email=email, password=hashlib.md5("1234".encode()).hexdigest(), 
                                            first_name="Impostor", last_name="Sponsor", street_address="1234 Impostor Ln", street_address_2="1234 Impostor Ln", 
                                            city="Impostorville", zip_code=12345, 
                                            phone_number="No Phone", user_type='Sponsor', is_impersonation=1)
        imp_sponsor.save()

        # Add this new sponsor to requested org and add points to play with (no ordering allowed) (SponsorUser table edited)
        if chosenSponsor != -1:
            sponsor=models.Sponsor.objects.get(sponsor_id=chosenSponsor)
            sponsorUserEntry = models.SponsorUser(user=imp_sponsor, sponsor=sponsor)
            sponsorUserEntry.save()

        del request.session['sponsor']
        
        # Store the original user's email and password in the session
        oldEmail = request.user.email
        oldPassword = request.user.password
        impSponsorEmail = imp_sponsor.email

        auth_logout(request)

        # Log in user as impostor
        user = backends.CustomAuthBackend.authenticate(username=email, password="1234")
        if user is not None:
            auth_login(request, user)
            message = 'You are logged in as the impostor sponsor!'
            messages.info(request, message)

        request.session['original_email'] = oldEmail
        request.session['original_password'] = oldPassword
        request.session['impostor_sponsor'] = impSponsorEmail

        return redirect(user_profile)
    else:
        return redirect(user_profile)

# Logs out the Admin user of the impersonator Sponsor account, and back into their Admin account
def end_admin_sponsor_impersonation(request):
    oldEmail = request.session.get('original_email')
    oldPassword = request.session.get('original_password')
    impSponsorEmail = request.session.get('impostor_sponsor')

    # Clear the session variables
    del request.session['original_email']
    del request.session['original_password']
    del request.session['impostor_sponsor']

    # Log out of sponsor impostor
    auth_logout(request)

    # Log back into the original requester's account, frictionlessly
    user = backends.CustomAuthBackend.prehashed_auth(username=oldEmail, password=oldPassword)
    if user is not None:
        auth_login(request, user)

    # Delete the impostor's instances from Users and SponsorUser tables
    imp_sponsor = models.Users.objects.get(email=impSponsorEmail)
    if models.SponsorUser.objects.filter(user=imp_sponsor).exists():
        sponsorUserEntry = models.SponsorUser.objects.filter(user=imp_sponsor)
        sponsorUserEntry.delete()

    imp_sponsor.delete()

    messages.info(request, "You have successfully ended the impostor session, and are now logged back into your original account.")
    return redirect(user_profile)