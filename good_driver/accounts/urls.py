from django.urls import path
from . import views


urlpatterns = [
    path("register/", views.register, name="register"),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('user_profile/', views.user_profile, name='user_profile'),
    path('adminPanel/', views.admin_panel, name='adminPanel'),
    path('adminCreateAccount/', views.admin_create_account, name='adminCreateAccount'),
    path('adminDeleteAccount/', views.admin_delete_account, name='adminDeleteAccount'),
    path('adminCreateSponsor/', views.admin_create_sponsor, name='adminCreateSponsor'),
    path('adminEditAccount/', views.admin_edit_account, name='adminEditAccount'),
    path('sponsorPanel/', views.sponsor_panel, name='sponsorPanel'),
    path('sponsorCreateAccount/', views.sponsor_create_account, name='sponsorCreateAccount'),
    path('sponsorRemoveDriver/', views.sponsor_remove_driver, name='sponsorRemoveDriver'),
    path('application/', views.application,name='application'),    
    #path("home", views.home, name="home")
]