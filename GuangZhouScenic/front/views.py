import random
from datetime import datetime

from django.http import HttpResponseRedirect
from django.shortcuts import render

import manage.utils as utils
from front.forms import RegisterForm
from manage import views as manage_view
from manage.models import User, Article, Scenic


def index(request):
    # 随机获取3个景点
    scenicList = find("SELECT id, name, img FROM scenic")
    scenicList = random.sample(scenicList, 3)
    return render(request, 'front/index.html', {'scenicList': scenicList, 'firstScenic': scenicList[0]})


# ===========================景点===========================
def scenic_page(request):
    return manage_view.scenic_page(request)


# 查看景点
def scenic_view(request):
    id = request.GET.get("id")
    scenic = findFisrt(
        "SELECT id, name, img, intro, content, address, ticket_price ticketPrice, open_time openTime, is_hot isHot FROM scenic WHERE id=" + id)

    # 获取3篇打卡文章
    articleList = find('SELECT article.id, article.title, article.text, user.name user_name '
                       'FROM article LEFT JOIN user ON user.id=article.user_id WHERE article.scenic_id=' + id + ' LIMIT 3')

    return render(request, 'front/scenic/scenic-view.html', {'scenic': scenic, 'articleList': articleList})


# 查看所有打卡
def scenic_article(request):
    id = request.GET.get("id")
    scenic = findFisrt(
        "SELECT id, name, img, intro, content, address, ticket_price ticketPrice, open_time openTime, is_hot isHot FROM scenic WHERE id=" + id)

    # 获取所有打卡
    articleList = find('SELECT article.id, article.title, article.text, user.name user_name '
                       'FROM article LEFT JOIN user ON user.id=article.user_id WHERE article.scenic_id=' + id)

    return render(request, 'front/scenic/scenic-article.html', {'scenic': scenic, 'articleList': articleList})

# ===========================打卡文章===========================
def article_save(request):
    if request.method == 'GET':
        # 查看信息
        return render(request, 'front/article/article-save.html')
    elif request.method == 'POST':
        id = request.POST.get("id")
        # 判断是新增还是编辑
        if id:
            article = Article.objects.get(id=id)
        else:
            user = request.session['user']

            article = Article()
            article.user_id = user.id
            article.scenic_id = int(request.POST.get('scenicId'))
            article.create_time = datetime.now()

        article.title = request.POST.get('title')
        article.text = request.POST.get('text')
        article.content = request.POST.get('content')
        article.save()

        return success("保存成功", article.id)


def article_view(request):
    id = request.GET.get("id")
    article = findFisrt(
        "SELECT id, user_id, scenic_id, title, content, DATE_FORMAT(create_time, '%Y年%m月%d日') createTime FROM article WHERE id=" + id)
    user = User.objects.get(id=article['user_id'])
    scenic = Scenic.objects.get(id=article['scenic_id'])
    return render(request, 'front/article/article-view.html', {'article': article, 'user': user, 'scenic': scenic, })


def article_get(request):
    id = request.GET.get("id")
    article = findFisrt("SELECT id, user_id, scenic_id, title, content FROM article WHERE id=" + id)
    return success("获取成功", article)


# 我的
def me(request):
    return render(request, 'front/me/me.html', {'user': request.session['user']})


def me_article(request):
    # 获取自己的所有文章
    user = request.session['user']

    articleList = find("SELECT article.*, scenic.img FROM article "
                       "LEFT JOIN scenic ON article.scenic_id=scenic.id WHERE user_id=" + str(user.id))

    return render(request, 'front/me/article-me.html', {'articleList': articleList})


def change_password(request):
    if request.method == 'GET':
        # 查看信息
        return render(request, 'front/me/change-password.html')
    elif request.method == 'POST':
        user = request.session['user']
        old_password = request.POST['oldPassword']
        new_password = request.POST['newPassword']
        repeat_password = request.POST['repeatPassword']

        if utils.get_md5(old_password) != user.password:
            return fail("旧密码错误")

        if new_password is None or new_password == '':
            return fail("新密码为空")

        if new_password != repeat_password:
            return fail("两次密码不一致")

        user.password = utils.get_md5(new_password)
        user.save()
        del request.session['user']
        return success("修改成功")


# ===========================用户服务===========================

def login(request):
    if request.method == 'GET':
        return render(request, 'front/login.html')
    elif request.method == 'POST':
        number = request.POST['number']
        password = utils.get_md5(request.POST['password'])
        user = None
        try:
            user = User.objects.get(number=number, password=password)
        except Exception as error:
            print('账号或者密码错误', error)

        if user is None:
            return fail('账号或者密码错误')
        # 登陆成功
        request.session['user'] = user
        return success('登录成功')


def logout(request):
    try:
        del request.session['user']  # 不存在时报错
    except Exception as error:
        print('没有登陆', error)
    return HttpResponseRedirect('/manage/login')


def register(request):
    if request.method == 'GET':
        # 查看信息
        return render(request, 'front/register.html')
    if request.method == 'POST':
        form = RegisterForm(request.POST)
        if form.is_valid():
            name = form.cleaned_data['name']
            number = form.cleaned_data['number']
            password = form.cleaned_data['password']

            # 查询一下这个邮箱有没被注册过
            try:
                User.objects.get(number=number)
                return fail('号码已经被注册')
            except Exception as error:
                print('没有注册', error)

            user = User()
            user.name = name
            user.number = number
            user.password = utils.get_md5(password)
            user.create_time = datetime.now()
            user.save()
            return success('注册成功')


def change_info(request):
    if request.method == 'GET':
        return render(request, 'front/me/change-info.html', {'user': request.session['user']})
    elif request.method == 'POST':
        user = request.session['user']
        user.name = request.POST['name']
        user.number = request.POST['number']
        user.save()

        request.session['user'] = user
        return success("更新成功")


# 上传图片
def upload_image(request):
    return manage_view.upload_image(request)


# 定义基础方法
def success(message, data=None):
    return manage_view.success(message, data)


def fail(message):
    return manage_view.fail(message)


# 分页
def page(selectSql, whereSql, request):
    return manage_view.page(selectSql, whereSql, request)


# 执行SQL，返回字典值列表
def find(sql):
    return manage_view.find(sql)


# 获取第一条数据
def findFisrt(sql):
    return manage_view.findFisrt(sql)
