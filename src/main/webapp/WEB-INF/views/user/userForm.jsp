<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/inc/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>用户管理</title>
	<meta name="keywords" content="" />
    <meta name="description" content="CoolJava Version:2.0" />
	<meta name="Author" content="" />
	<meta name="renderer" content="webkit">	
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">	
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">	
	<meta name="apple-mobile-web-app-capable" content="yes">	
	<meta name="format-detection" content="telephone=no">
	<!-- load css -->
	<link rel="stylesheet" type="text/css" href="${path }/res/layui/css/layui.css" media="all">
</head>
<style type="text/css" media="screen">
	.one-tj{
		margin-left: 10px;
		margin-right: 25px;
	}
	.one-btn-btn{
		width: 230px;
		padding-top: 10px;
		margin: 0 auto;
	}
	.layui-form .layui-form-label{
		padding-left: 15px;
		color: #666666;
	}
	.layui-form .layui-input-block{
		width: 300px;
	}
	.layui-form .layui-input-block input,.layui-form .layui-input-block textarea{
		color: #aaaaaa;
	}
</style>
<body>
<div class="layui-fluid">

    <fieldset class="layui-elem-field layui-field-title site-title">
      <legend><a name="methodRender">用户编辑</a></legend>
    </fieldset>
  <form class="layui-form">
  		<input type="hidden" name="id" value="${u.id }">
  		<input type="hidden" name="pwd" value="${u.pwd }">
		<div class="layui-form-item">
			<label class="layui-form-label">登录名</label>
			<div class="layui-input-block">
				<input type="text" name="loginName" value="${u.loginName }" class="layui-input linksName" lay-verify="required" placeholder="请输入登录名">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">真实姓名</label>
			<div class="layui-input-block">
				<input type="text" name="name" value="${u.name }" class="layui-input" lay-verify="required" placeholder="请输入真实姓名">
			</div>
		</div>
		
		<div class="layui-form-item">
			<label class="layui-form-label">邮箱</label>
			<div class="layui-input-block">
				<input type="text" name="email" value="${u.email }" class="layui-input masterEmail" lay-verify="email" placeholder="请输入邮箱">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">手机</label>
			<div class="layui-input-block">
				<input type="tel" name="mobile" value="${u.mobile }" class="layui-input" lay-verify="required|phone" placeholder="请输入手机号码">
			</div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">部门</label>
		    <div class="layui-input-block">
		    <input type="hidden" id="orgId" name="orgId" value="${u.orgId}">
		      <input type="text" id="tree" lay-filter="tree" class="layui-input">
		    </div>
		 </div>
		<div class="layui-form-item">
		    <label class="layui-form-label">角色</label>
		    <div class="layui-input-block">
		      <select name="roleId" lay-verify="required" id="sel">
		        <option value=""></option>
		        <c:forEach items="${roles }" var="role">
		        	<option value="${role.id }">${role.name }</option>
		        </c:forEach>
		      </select>
		    </div>
		 </div>
		 <div class="layui-form-item" style="text-align:center;color:red;">
		 	温馨提示：初始密码为 123456
		 </div>
		<div class="layui-form-item one-btn-btn">
				<button class="layui-btn one-tj" lay-submit lay-filter="add">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		</div>
	</form>
</div>

<!-- 加载js文件 -->
<script type="text/javascript" src="${path }/res/layui/layui.js"></script> 
<script type="text/javascript">
	layui.config({
	    base: '../res/js/'
	}).extend({
	    treeSelect: 'treeSelect'
	});

	var path = "${path}";
	var roleId = "${u.roleId}";
	var orgId = "${u.orgId}";
	
	layui.use(['form','layer','jquery','treeSelect'],function(){
		   var $ = layui.$,
		   form = layui.form,
		   treeSelect= layui.treeSelect,
		   layer = layui.layer;
		   
	        treeSelect.render({
	            // 选择器
	            elem: '#tree',
	            // 数据
	            data: path + '/org/treeDataJson.do?id=-1',
	            // 异步加载方式：get/post，默认get
	            type: 'get',
	            // 占位符
	            placeholder: '请选择部门',
	            // 是否开启搜索功能：true/false，默认false
	            search: true,
	            // 点击回调
	            click: function(d){
	            	$("#orgId").val(d.current.id);
	                console.log(d.current.id);
	            },
	            // 加载完成后的回调函数
	            success: function (d) {
	                console.log(d);
//	                选中节点，根据id筛选
	                treeSelect.checkNode('tree', orgId);

//	                获取zTree对象，可以调用zTree方法
//	                var treeObj = treeSelect.zTree('tree');
//	                console.log(treeObj);

//	                刷新树结构
//	                treeSelect.refresh();
	            }
	        });
	        
		   //select赋值
		   $("#sel").find("option[value='" + roleId + "']").attr("selected",true);
		   form.render('select');
		   
		   form.on('submit(add)',function(data){
		     var ajaxReturnData;
		        //登陆验证
		        $.ajax({
		            url: path + '/user/save.do',
		            type: 'post',
		            async: false,
		            data: data.field,
		            success: function (data) {
		                ajaxReturnData = data;
		            }
		        });
		        //结果回应
		        if (ajaxReturnData == '0') {
		        	top.layer.msg('保存成功', {icon: 1});
		            var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		            parent.layer.close(index); //再执行关闭                        //刷新父页面
		            parent.location.reload();
		        } else {
		        	top.layer.msg('保存失败', {icon: 5});
		        }
		        return false;
		   });
		});
</script>
</body>
</html>