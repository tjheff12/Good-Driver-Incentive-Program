"""good_driver URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/4.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.contrib.auth import views as auth_views
from . import views

urlpatterns = [
    path('admin/', admin.site.urls),

    path('done/', views.done, name = 'done'),

    path('', include("accounts.urls")),
    path('login/', auth_views.LoginView.as_view(), name='login'),
  
    path('resetPassword/', views.resetPassword, name='resetPassword'),

    path('sponsorView/', views.sponsorView, name='sponsorView'),

    path('pointChange/', views.pointChange, name='pointChange'),

    path('catalog/', views.catalog, name='catalog'),

    path('pointHistory/', views.pointHistory, name='pointHistory'),

    path('driverManagement', views.driverManagement, name='driverManagement'),

    path('sponsorReport/pointTracking/', views.pointTracking, name='pointTracking'),

    path('adminReport/driverSales/', views.driverSales, name='driverSales'),

    path('adminReport/sponsorSales/', views.sponsorSales, name='sponsorSales'),

    path('adminReport/invoice/', views.invoice, name='invoice'),

    path('sponsorReport/audit/', views.audit, name='sponsorAudit'),

    path('adminReport/audit/', views.audit, name='adminAudit'),

    path('sponsorReport/', views.sponsorReport, name='sponsorReport'),

    path('adminReport/', views.adminReport, name='adminReport'),

    path('adminInfo/', views.adminInfo, name='adminInfo'),
]
