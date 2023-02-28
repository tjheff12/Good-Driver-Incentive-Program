from django.urls import path
from . import views


urlpatterns = [
    path("register/", views.register, name="register"),
    path('test/', views.test, name="test"),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('user_profile/', views.user_profile, name='user_profile')
    #path("login_user", views.login_user, name="login_user"),
    #path("logout_user", views.logout_user, name="logout_user"),
    #path("home", views.home, name="home")
]