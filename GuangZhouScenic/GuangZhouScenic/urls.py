"""GuangZhouScenic URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/3.0/topics/http/urls/
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
from django.urls import path
from django.contrib import admin
from front import views as front_views
from manage import views as manage_views
# 添加media
from django.views.static import serve
from django.conf import settings
from django.conf.urls import url

urlpatterns = [
    path('admin/', admin.site.urls),

    url(r'^media/(?P<path>.*)$', serve, {"document_root": settings.MEDIA_ROOT}),

    # 前台
    path('', front_views.index),
    path('login', front_views.login),
    path('register', front_views.register),
    path('uploadImage', front_views.upload_image),
    path('me', front_views.me),
    path('me/article', front_views.me_article),
    path('me/changePassword', front_views.change_password),
    path('me/changeInfo', front_views.change_info),

    path('scenic/page', front_views.scenic_page),
    path('scenic/view', front_views.scenic_view),
    path('scenic/article', front_views.scenic_article),

    path('article/save', front_views.article_save),
    path('article/view', front_views.article_view),
    path('article/getArticle', front_views.article_get),

    # 后台管理
    path('manage/login', manage_views.login),
    path('manage/logout', manage_views.logout),
    path('manage', manage_views.index),
    path('manage/uploadImage', manage_views.upload_image),
    path('manage/home', manage_views.home),
    path('manage/user', manage_views.user),
    path('manage/user/page', manage_views.user_page),
    path('manage/user/getUser', manage_views.user_get),
    path('manage/user/delete', manage_views.user_delete),
    path('manage/user/save', manage_views.user_save),

    path('manage/scenic', manage_views.scenic),
    path('manage/scenic/page', manage_views.scenic_page),
    path('manage/scenic/save', manage_views.scenic_save),
    path('manage/scenic/getScenic', manage_views.scenic_get),
    path('manage/scenic/delete', manage_views.scenic_delete),

    path('manage/article', manage_views.article),
    path('manage/article/page', manage_views.article_page),

    path('manage/admin', manage_views.admin),
    path('manage/admin/page', manage_views.admin_page),
    path('manage/admin/getAdmin', manage_views.admin_get),
    path('manage/admin/save', manage_views.admin_save),

]
