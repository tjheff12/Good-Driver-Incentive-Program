from django.urls import path, re_path
from . import views


urlpatterns = [
    path("register/", views.register, name="register"),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('user_profile/', views.user_profile, name='user_profile'),
    path('user_profile/DriverView', views.start_driver_impersonation, name='start_driver_impersonation'),
    path('user_profile/EndDriverView', views.end_driver_impersonation, name='end_driver_impersonation'),
    path('adminPanel/', views.admin_panel, name='adminPanel'),
    path('adminCreateAccount/', views.admin_create_account, name='adminCreateAccount'),
    path('adminDeleteAccount/', views.admin_delete_account, name='adminDeleteAccount'),
    path('adminCreateSponsor/', views.admin_create_sponsor, name='adminCreateSponsor'),
    path('adminChangeUserPassword/', views.admin_change_user_password, name='adminChangeUserPassword'),
    path('sponsorPanel/', views.sponsor_panel, name='sponsorPanel'),
    path('sponsorCreateAccount/', views.sponsor_create_account, name='sponsorCreateAccount'),
    path('sponsorRemoveDriver/', views.sponsor_remove_driver, name='sponsorRemoveDriver'),
    path('sponsorAddDriver/', views.sponsor_add_driver, name='sponsorAddDriver'),
    path('application/', views.application, name='application'),
    path('sponsorHome/driverManagement/application/', views.application,name='application'),
    path('resetPassword/', views.resetPassword, name='resetPassword'),
    path('sponsorHome/driverManagement/pointChange/', views.pointChange, name='pointChange'),
    path('all_drivers', views.sponsor_see_all_drivers, name='all_drivers'),
    path('catalog/', views.catalog, name='catalog'),
    path('catalog/<str:sponsor>/catalogOverview/pageNum=<int:pageNum>/', views.catalog_overview, name='catalogOverview'),
    path('catalog/<str:sponsor>/catalogOverview/pageNum=<int:pageNum>&&search=/', views.catalog_overview, name='catalogOverview'),
    path('catalog/<str:sponsor>/catalogOverview/pageNum=<int:pageNum>&&search=<str:search>/', views.catalog_overview, name='catalogOverview'),
    path('catalogOverview/pageNum=<int:pageNum>/', views.catalog_overview, name='catalogOverview'),
    path('catalogOverview/pageNum=<int:pageNum>&&search=/', views.catalog_overview, name='catalogOverview'),
    path('catalogOverview/pageNum=<int:pageNum>&&search=<str:search>/', views.catalog_overview, name='catalogOverview'),
    path('catalog/<str:sponsor>/order', views.order_item, name='order_item'),
    path('home/orders/', views.order, name='orders'),
    path('home/', views.home, name='home'),

    path('pointHistory/', views.pointHistory, name='pointHistory'),

    path('driverHome/', views.driverHome, name='driverHome'),

    path('sponsorHome/', views.sponsorHome, name='sponsorHome'),

    path('pointChangeAudit/', views.pointChangeAudit, name='pointChangeAudit'),

    path('adminHome/', views.adminHome, name="adminHome"),

    path('sponsorHome/driverManagement/', views.driverManagement, name='driverManagement'),
    
    path('sponsorHome/driverManagement/allDrivers', views.sponsor_see_all_drivers, name='all_drivers'),

    path('sponsorHome/sponsorReport/pointTracking/', views.pointTracking, name='pointTracking'),

    path('adminHome/adminReport/driverSales/', views.driverSales, name='driverSales'),

    path('adminHome/adminReport/sponsorSales/', views.sponsorSales, name='sponsorSales'),

    path('adminHome/adminReport/invoice/', views.invoice, name='invoice'),

    path('sponsorHome/sponsorReport/audit/', views.audit, name='sponsorAudit'),

    path('adminHome/adminReport/audit/', views.audit, name='adminAudit'),

    path('sponsorHome/sponsorReport/', views.sponsorReport, name='sponsorReport'),

    path('adminHome/adminReport/', views.adminReport, name='adminReport'),

    path('adminInfo/', views.adminInfo, name='adminInfo'),
    
    path('adminEditAccount/', views.admin_edit_account, name='adminEditAccount'),
    path('sponsorPanel/', views.sponsor_panel, name='sponsorPanel'),
    path('sponsorCreateAccount/', views.sponsor_create_account, name='sponsorCreateAccount'),
    path('sponsorRemoveDriver/', views.sponsor_remove_driver, name='sponsorRemoveDriver'),
    path('application/', views.application, name='application'),    
    path('sponsorHome/driverManagement/application/', views.application,name='application'),
    path('resetPassword/', views.resetPassword, name='resetPassword'),
    path('sponsorHome/driverManagement/pointChange/', views.pointChange, name='pointChange'),
    path('all_drivers', views.sponsor_see_all_drivers, name='all_drivers'),
    path('catalog/', views.catalog, name='catalog'),
    path('home/', views.home, name='home'),

    path('pointHistory/', views.pointHistory, name='pointHistory'),

    path('driverHome/', views.driverHome, name='driverHome'),

    path('sponsorHome/', views.sponsorHome, name='sponsorHome'),

    #path('home/', views.driverHome, name="home"),

    path('adminHome/', views.adminHome, name="adminHome"),

    path('sponsorHome/driverManagement/', views.driverManagement, name='driverManagement'),
    

    path('sponsorHome/sponsorReport/pointTracking/', views.pointTracking, name='pointTracking'),

    path('adminHome/adminReport/driverSales/', views.driverSales, name='driverSales'),

    path('adminHome/adminReport/sponsorSales/', views.sponsorSales, name='sponsorSales'),

    path('adminHome/adminReport/invoice/', views.invoice, name='invoice'),

    path('sponsorHome/sponsorReport/audit/', views.audit, name='sponsorAudit'),

    path('adminHome/adminReport/audit/', views.audit, name='adminAudit'),

    path('sponsorHome/sponsorReport/', views.sponsorReport, name='sponsorReport'),

    path('adminHome/adminReport/', views.adminReport, name='adminReport'),

    path('adminInfo/', views.adminInfo, name='adminInfo'),
    #path("home", views.home, name="home")
]