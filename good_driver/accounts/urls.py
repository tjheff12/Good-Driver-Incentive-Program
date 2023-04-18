from django.urls import path, re_path
from . import views


urlpatterns = [
    path("register/", views.register, name="register"),
    path('login/', views.login, name='login'),
    path('logout/', views.logout, name='logout'),
    path('user_profile/', views.user_profile, name='user_profile'),
    path('user_profile/DriverView', views.start_driver_impersonation, name='start_driver_impersonation'),
    path('user_profile/EndDriverView', views.end_driver_impersonation, name='end_driver_impersonation'),
    path('user_profile/ChangeView', views.change_view, name='change_view'),
    path('home/adminPanel/', views.admin_panel, name='adminPanel'),
    path('home/adminPanel/adminCreateAccount/', views.admin_create_account, name='adminCreateAccount'),
    path('home/adminPanel/adminDeleteAccount/', views.admin_delete_account, name='adminDeleteAccount'),
    path('home/adminPanel/adminCreateSponsor/', views.admin_create_sponsor, name='adminCreateSponsor'),
    path('home/adminPanel/adminChangeUserPassword/', views.admin_change_user_password, name='adminChangeUserPassword'),
    path('home/adminPanel/adminAddDriverToOrganization/', views.admin_add_driver_to_org, name='adminAddDriverToOrganization'),
    path('adminStartDriverView/', views.start_admin_driver_impersonation, name='start_admin_driver_impersonation'),
    path('adminEndDriverView/', views.end_admin_driver_impersonation, name='end_admin_driver_impersonation'),
    path('adminStartSponsorView/', views.start_admin_sponsor_impersonation, name='start_admin_sponsor_impersonation'),
    path('adminEndSponsorView/', views.end_admin_sponsor_impersonation, name='end_admin_sponsor_impersonation'),
    path('home/sponsorPanel/', views.sponsor_panel, name='sponsorPanel'),
    path('home/sponsorPanel/sponsorCreateAccount/', views.sponsor_create_account, name='sponsorCreateAccount'),
    path('home/sponsorPanel/sponsorRemoveDriver/', views.sponsor_remove_driver, name='sponsorRemoveDriver'),
    path('home/sponsorPanel/sponsorAddDriver/', views.sponsor_add_driver, name='sponsorAddDriver'),
    path('home/sponsorPanel/sponsorEditOrganization/', views.sponsor_edit_organization, name='sponsorEditOrganization'),
    path('home/adminPanel/editOrganization/', views.sponsor_edit_organization, name='editOrganization'),
    path('application/', views.application, name='application'),
    path('sponsorHome/driverManagement/application/', views.application,name='application'),
    path('driverHome/applications/', views.driverApplications ,name='driver applications'),
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

    
    path('home/report/driverSales/', views.driverSales, name='driverSales'),

    path('home/report/sponsorSales/', views.sponsorSales, name='sponsorSales'),

    path('home/report/invoice/', views.invoice, name='invoice'),

    path('sponsorHome/sponsorReport/audit/', views.audit, name='sponsorAudit'),

    path('adminHome/adminReport/audit/', views.audit, name='adminAudit'),

    path('sponsorHome/sponsorReport/', views.sponsorReport, name='sponsorReport'),

    path('adminHome/adminReport/', views.adminReport, name='adminReport'),

    path('adminInfo/', views.adminInfo, name='adminInfo'),
    
    path('home/adminPanel/adminEditAccount/', views.admin_edit_account, name='adminEditAccount'),
    
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



    path('adminHome/', views.adminHome, name="adminHome"),

    path('sponsorHome/driverManagement/', views.driverManagement, name='driverManagement'),
    

    path('home/report/pointTracking/', views.pointTracking, name='pointTracking'),

    

    path('home/report/audit/', views.audit, name='audit'),

   

    path('home/report/', views.report, name='adminReport'),

    path('adminInfo/', views.adminInfo, name='adminInfo'),
    
    path('', views.index, name='index'),

    path('home/sponsorPanel/itemForDriver', views.itemForDriver, name='itemForDriver'),

    path('home/sponsorPanel/itemForDriver/<str:driver>/catalog/pageNum=<int:pageNum>/', views.sponsor_catalog_overview, name='sponsor_catalog_overview'),
    path('home/sponsorPanel/itemForDriver/<str:driver>/catalog/pageNum=<int:pageNum>&&search=/', views.sponsor_catalog_overview, name='sponsor_catalog_overview'),
    path('home/sponsorPanel/itemForDriver/<str:driver>/catalog/pageNum=<int:pageNum>&&search=<str:search>/', views.sponsor_catalog_overview, name='sponsor_catalog_overview'),
    path('home/sponsorPanel/itemForDriver/<str:sponsor>/order', views.order_item, name='order_item'),
]