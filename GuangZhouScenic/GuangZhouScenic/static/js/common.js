/**
 * 公共的js工具类
 */

/**
 * 给JS的String定义一个替换所有的函数
 */
String.prototype.replaceAll = function (text, replaceText) {
    regExp = new RegExp(text, "g");
    return this.replace(regExp, replaceText);
};

/**
 * 渲染简单模板 #name 作为占位符
 * TODO 启用此方法
 */
function renderSimpleTemplate(domId, data) {
    var template = document.getElementById(domId).innerHTML;
    for (var key in data) {
        template = template.replaceAll('#' + key, data[key]);
    }
    return template;
}

/**
 * 同步渲染模板
 */
function renderTemplate(templateId, domId, data) {
    var view = document.getElementById(domId);
    view.innerHTML = renderTemplateToString(templateId, data);
}

/**
 * 渲染模板，返回渲染结果
 */
function renderTemplateToString(templateId, data) {
    var template = document.getElementById(templateId);
    return layui.laytpl(template.innerHTML).render(data);
}

/**
 * 把一个表单里面的值转化为数据
 */
function formToData(domId) {
    // 暂时只处理input和select
    var $form = $('#' + domId);
    var $inputs = $form.find('input');
    var $selects = $form.find('select');
    var formData = {};
    // 获取所有input的值
    for (var i = 0; i < $inputs.length; i++) {
        var input = $inputs[i];
        var name = input.name;
        var value = input.value;
        formData[name] = value;
    }

    // 获取所有select的值
    for (var i = 0; i < $selects.length; i++) {
        var select = $selects[i];
        // 获取选中的
        var $option = $(select).find('option:selected');
        var name = select.name;
        var value = $option.val();
        formData[name] = value;
    }

    return formData;
}

/**
 * 将数据填充到form里面，暂时支持input和select
 */
function fillForm(domId, formData) {
    var $form = $('#' + domId);
    var $inputs = $form.find('input');
    var $selects = $form.find('select');
    // 获取所有input的值
    for (var i = 0; i < $inputs.length; i++) {
        var input = $inputs[i];
        var name = input.name;
        $(input).val(formData[name]);
    }

    // 获取所有select的值
    for (var i = 0; i < $selects.length; i++) {
        var select = $selects[i];
        var name = select.name;
        $(select).val(formData[name]);
    }
    layui.form.render('select');
}

/**
 * 初始化字典值下拉框
 */
function initSelect(domId, url, callback) {
    $.get(url, function (res) {
        if (res.success) {
            var list = res.data;
            var $select = $('#' + domId);
            $select.empty();
            $select.append("<option value=''>请选择</option>");
            $.each(list, function (index, item) {
                $select.append("<option value='" + item.value + "'>" + item.name + "</option>");
            });
            layui.form.render('select');
        }
        if (callback) {
            callback();
        }
    });
}

/**
 * 获取Url参数
 */
function getUrlParam(name) {
    var query = window.location.search.substring(1);
    var vars = query.split("&");
    for (var i = 0; i < vars.length; i++) {
        var pair = vars[i].split("=");
        if (pair[0] === name) {
            return pair[1];
        }
    }
    return null;
}

layui.use('form', function () {
    // 检查url有没有查询参数，有的话填充到搜索框
    var name = getUrlParam('name');
    if (name) {
        $('#headSearchName').val(decodeURI(name));
    }

    layui.form.on('submit(search)', function (data) {
        var searchName = data.field.name;
        if (searchName) {
            search(searchName);
        } else {
            window.location.href = '/';
        }
        return false;
    });
});

/**
 * 搜索
 */
function search(name) {
    window.location.href = '/?name=' + name;
}

/**
 * 显示一个提示对话框，2秒之后跳转到另外一个页面
 *
 * @param message
 * @param url
 */
function showAlertThenJumpTo(message, url) {
    layer.alert(message, {
        time: 2000, // 两秒后执行end
        end: function () {
            window.location.href = url;
        }
    }, function () {
        // 注销并回到登录页面
        window.location.href = url;
    });
}

/**
 * 当前登录用户
 */
var currentUser = {};

/**
 * 初始化用户信息
 */
function initUserInfo() {
    // 检查一下cookie设置的时间，如果超过30分钟，更新一下cookie
    var createTime = 0;
    if (Cookies.get('createTime')) {
        createTime = parseInt(Cookies.get('createTime'));
    }
    if (new Date().getTime() - createTime > 10 * 60 * 1000) {
        // 已经超时，更新一下cookie，这样可以避免，登陆已经超时，但是本地的cookie信息还在
        $.get('/getCurrentUserInfo', function (res) {
            if (!res.success) {
                // 当前用户没有登录，清空本地cookie
                Cookies.set('userId', null);
                Cookies.set('userName', null);
                Cookies.set('userType', null);
                Cookies.set('createTime', null);
            }
            // 当前用户没有登录，设置顶端菜单
            initNavMenu();
        });
    } else {
        // 优先从cookie中获取信息，否则页面控制买家/卖家就出问题了
        currentUser.id = parseInt(Cookies.get('userId'));
        currentUser.name = Cookies.get('userName');
        currentUser.type = Cookies.get('userType');

        initNavMenu();
    }
}

function initNavMenu() {
    if (currentUser.id) {
        // 当前用户已经登录
        $('div[flag="needLogin"]').show();
        $('#menuUser').text('你好，' + currentUser.name);
        $('#menuLogin').hide();

        if (currentUser.type === '01') {
            // 买家不能发布房屋信息
            $('#menuAddHouse').hide();
        }
    } else {
        // 当前用户没有登录，设置顶端菜单
        $('div[flag="needLogin"]').hide();
        $('#menuLogin').show();
    }
}

/**
 * 毫秒转换友好的显示格式
 * 输出格式：21小时前
 */
function friendTime(milliseconds) {
    //获取js 时间戳
    var time = new Date().getTime();
    //去掉 js 时间戳后三位
    time = parseInt((time - milliseconds) / 1000);

    //存储转换值
    var s;
    if (time < 60 * 10) {//十分钟内
        return '刚刚';
    } else if ((time < 60 * 60) && (time >= 60 * 10)) {
        //超过十分钟少于1小时
        s = Math.floor(time / 60);
        return s + "分钟前";
    } else if ((time < 60 * 60 * 24) && (time >= 60 * 60)) {
        //超过1小时少于24小时
        s = Math.floor(time / 60 / 60);
        return s + "小时前";
    } else if ((time < 60 * 60 * 24 * 3) && (time >= 60 * 60 * 24)) {
        //超过1天少于3天内
        s = Math.floor(time / 60 / 60 / 24);
        return s + "天前";
    } else {
        //超过3天
        var date = new Date(milliseconds);
        return date.getFullYear() + "/" + (date.getMonth() + 1) + "/" + date.getDate();
    }
}