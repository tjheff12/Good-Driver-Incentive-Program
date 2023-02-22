
# Create your views here.
from django.contrib import messages
from django.shortcuts import render, redirect
from . import models

def register(request):
    if request.method == 'POST':
        first_name = request.POST['first_name']
        last_name = request.POST['last_name']
        username = request.POST['username']
        email = request.POST['email']
        password = request.POST['password']
        confirm_password = request.POST['confirm_password']

        if password==confirm_password:
            if User.objects.filter(username=username).exists():
                messages.info(request, 'Username is already taken')
                return redirect(register)
            elif User.objects.filter(email=email).exists():
                messages.info(request, 'Email is already taken')
                return redirect(register)
            else:
                user = User.objects.create_user(username=username, password=password, 
                                        email=email, first_name=first_name, last_name=last_name)
                user.save()
                
                return redirect('login_user')


        else:
            messages.info(request, 'Both passwords are not matching')
            return redirect(register)
    else:
        return render(request, 'registration.html')
    

from django.views.generic import TemplateView

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

def test(request):
    if request.method == "GET":
        new_item = models.Item( item_desc="Apple Ipohne", item_price=2.00)
        new_item.save()
        return render(request, 'registration.html')