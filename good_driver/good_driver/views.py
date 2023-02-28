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

def driverManagement(request):
    return render(request, 'driverManagement.html')

def done(request):
    return render(request, 'done.html')

def pointTracking(request):
    return render(request, 'pointTracking.html')

def driverSales(request):
    return render(request, 'driverSales.html')

def sponsorSales(request):
    return render(request, 'sponsorSales.html')

def invoice(request):
    return render(request, 'invoice.html')

def audit(request):
    return render(request, 'audit.html')

def sponsorReport(request):
    return render(request, 'sponsorReport.html')

def adminReport(request):
    return render(request, 'adminReport.html')

def adminInfo(request):
    return render(request, 'adminInfo.html')