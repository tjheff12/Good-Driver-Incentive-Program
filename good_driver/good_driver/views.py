from django.shortcuts import render
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

def driverHome(request):
    return render(request, 'driverHome.html')

def sponsorHome(request):
    return render(request, 'sponsorHome.html')

def adminHome(request):
    return render(request, 'adminHome.html')
def driverManagement(request):
    return render(request, 'driverManagement.html')

def done(request):
    return render(request, 'done.html')