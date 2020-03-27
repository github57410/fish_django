import json
import os
import random
import sys
from datetime import datetime

from django.db import connection
from django.http import HttpResponse, HttpResponseRedirect
from django.shortcuts import render
from django.views.decorators.clickjacking import xframe_options_exempt

import manage.utils as utils
import manage.utils
from manage.message import Message
from manage.models import User, Admin, Scenic


def login(request):
    if request.method == 'GET':
        return render(request, 'manage/login.html')
    elif request.method == 'POST':
        number = request.POST['number']
        password = utils.get_md5(request.POST['password'])
        admin = None
        try:
            admin = Admin.objects.get(number=number, password=password)
        except Exception as error:
            print('账号或者密码错误', error)

        if admin is None:
            return fail('账号或者密码错误')
        # 登陆成功
        request.session['admin'] = admin
        return success('登录成功')


def logout(request):
    try:
        del request.session['admin']  # 不存在时报错
    except Exception as error:
        print('没有登陆', error)
    return HttpResponseRedirect('/manage/login')


# 后台主体
def index(request):
    return render(request, 'manage/index.html',
                  {'show_type': 1, })


@xframe_options_exempt
def home(request):
    admin = request.session['admin']
    return render(request, 'manage/home.html',
                  {
                      'adminName': admin.name,
                      'scenicCount': getTableCount('scenic'),
                      'userCount': getTableCount('user'),
                      'articleCount': getTableCount('article'),
                      'adminCount': getTableCount('admin'),
                  })


# 上传图片
def upload_image(request):
    upload_photo = request.FILES['file']
    if upload_photo is not None:
        # 获取后缀名，没有考虑，上传的文件没有后缀的情况
        ext_name = os.path.splitext(upload_photo.name)[-1]
        # 生成时间戳+随机数字，用于重命名文件，防止文件重名
        target_file_name = datetime.now().strftime('%Y%b%d%H%M%S') + str(random.randint(1000, 9999)) + ext_name
        # target_file = open('D:/workspace/PyNetdisk/netdisk/static/avatar/' + target_file_name, 'wb+')
        target_file = open(sys.path[0] + '/GuangZhouScenic/static/upload/' + target_file_name, 'wb+')
        for chunk in upload_photo.chunks():
            target_file.write(chunk)
            # 关闭文件
        target_file.close()

        # 返回格式
        # {
        #   "code": 0 //0表示成功，其它失败
        #   ,"msg": "" //提示信息 //一般上传失败后返回
        #   ,"data": {
        #     "src": "图片路径"
        #     ,"title": "图片名称" //可选
        #   }
        # }
        response = {
            "code": 0,
            "msg": "上传成功",
            "data": {
                "src": "/static/upload/" + target_file_name,
                "title": target_file_name
            }
        }
    else:
        response = {
            "code": 1,
            "msg": "上传失败",
        }
    jsonString = json.dumps(response, ensure_ascii=False)
    return HttpResponse(jsonString, content_type='application/json')


# ===========================用户管理===========================
@xframe_options_exempt
def user(request):
    return render(request, 'manage/user/user.html')


def user_page(request):
    # 处理查询条件
    name = request.POST.get('name')
    number = request.POST.get('number')

    whereSql = 'FROM user WHERE 1=1'
    if name:
        whereSql + " AND name LIKE '%" + name + "%' "
    if number:
        whereSql + " AND number LIKE '%" + number + "%' "

    data = page("SELECT id, name, number, DATE_FORMAT(create_time, '%Y-%m-%d') createTime",
                whereSql, request)
    return success("获取成功", data)


def user_get(request):
    id = request.GET.get("id")
    user = findFisrt("SELECT * FROM user WHERE id=" + id)
    # 删除不需要显式的字段
    user.pop('password')
    user.pop('create_time')
    return success("获取成功", user)


def user_save(request):
    id = request.POST.get("id")
    # 判断是新增还是编辑
    if id:
        user = User.objects.get(id=id)
    else:
        user = User()
        user.create_time = datetime.now()

    user.name = request.POST.get('name')
    user.number = request.POST.get('number')

    password = request.POST.get('password')
    if password:
        user.password = utils.get_md5(password)

    user.save()

    return success("保存成功")


def user_delete(request):
    id = request.POST.get("id")
    User.objects.filter(id=id).delete()
    return success("删除成功")


# ===========================景点管理===========================
@xframe_options_exempt
def scenic(request):
    return render(request, 'manage/scenic/scenic.html')


def scenic_page(request):
    # 处理查询条件
    name = request.POST.get('name')

    whereSql = 'FROM scenic WHERE 1=1'
    if name:
        whereSql = whereSql + " AND name LIKE '%" + name + "%' "

    data = page("SELECT id, name, img, intro, address, is_hot isHot, DATE_FORMAT(create_time, '%Y-%m-%d') createTime",
                whereSql, request)
    return success("获取成功", data)


def scenic_get(request):
    id = request.GET.get("id")
    data = findFisrt(
        "SELECT id, name, img, intro, content, address, ticket_price ticketPrice, open_time openTime, is_hot isHot FROM scenic WHERE id=" + id)
    return success("获取成功", data)


@xframe_options_exempt
def scenic_save(request):
    if request.method == 'GET':
        # 查看信息
        return render(request, 'manage/scenic/scenic-save.html')
    elif request.method == 'POST':
        id = request.POST.get("id")
        # 判断是新增还是编辑
        if id:
            scenic = Scenic.objects.get(id=id)
        else:
            scenic = Scenic()
            scenic.create_time = datetime.now()

        scenic.name = request.POST.get('name')
        scenic.img = request.POST.get('img')
        scenic.intro = request.POST.get('intro')
        scenic.content = request.POST.get('content')
        scenic.address = request.POST.get('address')
        scenic.ticket_price = request.POST.get('ticketPrice')
        scenic.open_time = request.POST.get('openTime')
        scenic.save()

        return success("保存成功")


def scenic_delete(request):
    id = request.POST.get("id")
    Scenic.objects.filter(id=id).delete()
    return success("删除成功")


# ===========================打卡文章管理===========================
@xframe_options_exempt
def article(request):
    return render(request, 'manage/article/article.html')


def article_page(request):
    # 处理查询条件
    title = request.POST.get('title')

    whereSql = 'FROM article WHERE 1=1'
    if title:
        whereSql + " AND title LIKE '%" + title + "%' "

    data = page("SELECT id, title, text, DATE_FORMAT(create_time, '%Y-%m-%d') createTime",
                whereSql, request)
    return success("获取成功", data)


# ===========================管理员管理===========================
@xframe_options_exempt
def admin(request):
    return render(request, 'manage/admin/admin.html')


def admin_page(request):
    # 处理查询条件
    name = request.POST.get('name')

    whereSql = 'FROM admin WHERE 1=1'
    if name:
        whereSql + " AND name LIKE '%" + name + "%' "

    data = page("SELECT id, name, number, DATE_FORMAT(create_time, '%Y-%m-%d') createTime",
                whereSql, request)
    return success("获取成功", data)


def admin_get(request):
    id = request.GET.get("id")
    user = findFisrt("SELECT * FROM admin WHERE id=" + id)
    # 删除不需要显式的字段
    user.pop('password')
    user.pop('create_time')
    return success("获取成功", user)


def admin_save(request):
    id = request.POST.get("id")
    # 判断是新增还是编辑
    if id:
        admin = Admin.objects.get(id=id)
    else:
        admin = Admin()
        admin.create_time = datetime.now()

    admin.name = request.POST.get('name')
    admin.number = request.POST.get('number')

    password = request.POST.get('password')
    if password:
        admin.password = utils.get_md5(password)

    admin.save()
    return success("保存成功")


# 定义基础方法
def success(message, data=None):
    jsonString = json.dumps(Message.get_success_message(message, data), ensure_ascii=False,
                            default=lambda obj: obj.__dict__)
    return HttpResponse(jsonString, content_type='application/json')


def fail(message):
    return HttpResponse(Message.get_fail_message(message).to_json(), content_type='application/json')


# 分页
def page(selectSql, whereSql, request):
    pageNum = request.POST.get('pageNum')
    pageSize = request.POST.get('pageSize')
    start = (int(pageNum) - 1) * int(pageSize)
    pageSql = selectSql + ' ' + whereSql + ' LIMIT ' + str(start) + ', ' + pageSize

    countRecord = findFisrt('SELECT COUNT(1) DATA_COUNT ' + whereSql)

    page = {
        'list': find(pageSql),
        'totalRow': countRecord['DATA_COUNT']
    }
    return page


# 执行SQL，返回字典值列表
def find(sql):
    cursor = connection.cursor()
    cursor.execute(sql)
    columns = [col[0] for col in cursor.description]
    return [
        dict(zip(columns, row))
        for row in cursor.fetchall()
    ]


# 获取第一条数据
def findFisrt(sql):
    list = find(sql)
    if len(list) == 0:
        return None
    return list[0]


# 获取表的数据数量
def getTableCount(tableName):
    dic = findFisrt("SELECT COUNT(*) DATA_COUNT FROM " + tableName)
    return dic['DATA_COUNT']
