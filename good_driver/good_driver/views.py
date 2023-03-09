from django.shortcuts import render
from django.views.generic import TemplateView


def resetPassword(request):
    return render(request, 'resetPassword.html')

def pointChange(request):
    return render(request, 'pointChange.html')

def catalog(request):
    return render(request, 'catalog.html')

def pointHistory(request):
    return render(request, 'pointHistory.html')

def driverHome(request):
    return render(request, 'driverHome.html')


def done(request):
    return render(request, 'done.html')