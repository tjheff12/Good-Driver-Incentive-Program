
# Create your views here.
from django.contrib import messages
from django.shortcuts import render, redirect, get_object_or_404
from django.contrib.auth import authenticate, login as auth_login, logout as auth_logout
from . import backends
from . import models

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
        
        password_hash = hashlib.md5(password.encode()).hexdigest()
        
    
        if password==confirm_password:
            if models.Users.objects.filter(email=username).exists():
                messages.info(request, 'Username is already taken')
                return redirect(register)
            
                
            else:
                user = models.Users(email=username, password=password_hash, 
                                         first_name=first_name, last_name=last_name, street_address=street_addr, street_address_2=street_addr, city=city, zip_code=zip_code, phone_number=phone_num, user_type='Driver')
                user.save()
                
                return redirect('done')


        else:
            messages.info(request, 'Both passwords are not matching')
            return redirect(register)
    else:
        return render(request, 'registration.html')
    
    
def driverHome(request):
    return render(request, 'navigation/driverHome.html')
    

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
            
            return render(request, 'user_profile.html', {"message":message})
        else:
            if models.Users.objects.filter(email=email).exists():
                user_id_queryset = models.Users.objects.filter(email=email).values('user_id')
                ##gets id from query
                user_id = user_id_queryset[0]['user_id']
                CURRENT_TIME = datetime.now()
                new_login_attempt = models.LoginAttempt(user_id = user_id, date_time=CURRENT_TIME, was_accepted=0)
                new_login_attempt.save()
                #models.LoginAttempt.save(user_id=user_obj, date_time=CURRENT_TIME,was_accepted=0)
            
            message = 'Username or Password Incorrect'
            ##saves message to html template
            messages.info(request, message)
            return redirect(login)
    elif request.method == "GET":
        
        return render(request, 'registration/login.html')
    
def logout(request):
    if request.method == "POST":
        auth_logout(request)
        
        return redirect(login)
        
    elif request.method == "GET":
        return render(request, 'registration/logout.html' )
    
def resetPassword(request):
    return render(request, 'resetPassword.html')

def sponsorView(request):
    return render(request, 'sponsorView.html')

def pointChange(request):
    return render(request, 'pointChange.html')

def catalog(request):
    return render(request, 'catalog.html')

def pointHistory(request):
    return render(request, 'pointHistory.html')


def user_profile(request):
    return render(request, 'user_profile.html')

def test(request):
    if request.method == "GET":
        new_item = models.Item( item_desc="Apple Ipohne", item_price=2.00)
        new_item.save()
        return render(request, 'registration.html')