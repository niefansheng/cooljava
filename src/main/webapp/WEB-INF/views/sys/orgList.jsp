<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/inc/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>机构管理</title>
    <link rel="stylesheet" href="${path}/res/layui/css/layui.css" media="all" >
     <link rel="stylesheet" href="${path}/res/css/common.css" media="all" >
    <style type="text/css">
	.treeTable-empty {
		width: 20px;
		display: inline-block;
	}
	
	.treeTable-icon {
		cursor: pointer;
	}
	
	.treeTable-icon .layui-icon-triangle-d:before {
		content: "\e623";
	}
	
	.treeTable-icon.open .layui-icon-triangle-d:before {
		content: "\e625";
		background-color: transparent;
	}
	
	.layui-icon {
		font-family: layui-icon !important;
		font-size: 16px;
		font-style: normal;
		-webkit-font-smoothing: antialiased;
		-moz-osx-font-smoothing: grayscale;
	}

</style>
</head>
<body>
<div class="layui-fluid">
	 <div class="layui-row  animated bounceIn">
	 
    	<div class="layui-col-lg12 layui-col-md12 layui-col-sm12 layui-col-xs12">
    		<fieldset class="layui-elem-field layui-field-title site-title">
                <legend><a name="color-design">机构管理</a></legend>
            </fieldset>
            <div class="layui-btn-group" id="one_group">
            	 <div class="layui-btn-group">
	               <!--  <button class="layui-btn"  data-type="add"><i class="layui-icon">&#xe61f;</i><cite>增加</cite></button> -->
	                <!-- <button class="layui-btn layui-btn-normal"  data-type="edit"><i class="layui-icon">&#xe642;</i><cite>修改用户</cite></button>
	                <button class="layui-btn layui-btn-danger"  data-type="del"><i class="layui-icon">&#xe640;</i><cite>删除用户</cite></button> -->
	            	<button class="layui-btn" id="btn-expand">全部展开</button>
			        <button class="layui-btn" id="btn-fold">全部折叠</button>
			        <button class="layui-btn" id="btn-refresh">刷新表格</button>
		        </div>
		          &nbsp;
            </div>
            <div class="layui-input-inline">
					<input type="text" class="layui-input searchVal" id="edt-search"  placeholder="请输入搜索的内容" />
				</div>
    			<button class="layui-btn" id="btn-search">&nbsp;&nbsp;搜索&nbsp;&nbsp;</button>
    	</div>
 				
    	<div class="layui-col-lg10 layui-col-md10 layui-col-sm12 layui-col-xs12">
    		<div class="user-tables">
    			  <table id="table1" class="layui-table" lay-filter="table1"></table>
    		</div>
    	</div>
    </div>

</div>
<!-- 操作列 -->
<script type="text/html" id="oper-col">
  <a class="layui-btn layui-btn-xs" lay-event="edit"><i class="layui-icon">&#xe642;</i>编辑</a>
  <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon">&#xe640;</i>删除</a>
  <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="add"><i class="layui-icon">&#xe608;</i>添加下一节点</a>
</script>
<script type="text/html" id="type">
		 {{#  if(d.type === '0'){ }}
     		 公司机构
  		{{#  } else { }}
			部门机构
  		{{#  } }}
	</script>
<script type="text/javascript" src="${path}/res/layui/layui.js"></script>
<script type="text/javascript">
	var path = "${path}";
</script>
<script>
    layui.config({
        base: '../res/js/'
    }).extend({
        treetable: '/treetable'
    }).use(['layer', 'table', 'treetable'], function () {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var treetable = layui.treetable;

        // 渲染表格
        var renderTable = function () {
            layer.load(2);
            treetable.render({
                treeColIndex: 1,
                treeSpid: -1,
                treeIdName: 'id',
                treePidName: 'pid',
                treeDefaultClose: true,
                treeLinkage: false,
                elem: '#table1',
                url: path + '/org/dataJson.do?id=-1',
                page: false,
                cols: [[
                    {type: 'numbers'},
                    {field: 'name', title: 'name'},
                    {field: 'sort', title: '排序'},
                    {field: 'type', title: '机构类型',templet: '#type'},
                   /*  {field: 'id', title: 'id'},
                    {field: 'pid', title: 'pid'}, */
                    {templet: '#oper-col', title: '操作'}
                ]],
                done: function () {
                    layer.closeAll('loading');
                }
            });
        };

        renderTable();

        $('#btn-expand').click(function () {
            treetable.expandAll('#table1');
        });

        $('#btn-fold').click(function () {
            treetable.foldAll('#table1');
        });

        $('#btn-refresh').click(function () {
            renderTable();
        });

        //监听工具条
        table.on('tool(table1)', function (obj) {
            var data = obj.data;
            var layEvent = obj.event;

            if (layEvent === 'del') {
				layer.confirm('真的删除机构及其所有子机构么？', function(index) {
					var ajaxReturnData;
			        $.ajax({
			            url: path + '/org/delete.do',
			            type: 'post',
			            async: false,
			            data: {id:data.id},
			            success: function (data) {
			                ajaxReturnData = data;
			            }
			        });
			        //删除结果
			        if (ajaxReturnData == '0') {
			            renderTable();
			            layer.msg('删除成功', {icon: 1});
			        } else {
			        	layer.msg('删除失败', {icon: 5});
			        }
					
					layer.close(index);
				});
            } else if (layEvent === 'edit') {
				var index = layer.open({
					title: "机构修改",
					type: 2,
					skin:'',
					content: path + "/org/edit.do?id="+data.id,
				});
				 	layui.layer.full(index);
			        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
			        $(window).on("resize",function(){
			            layui.layer.full(index);
			        });
            }else if (obj.event === 'add') {//增加下一节点
				var index = layer.open({
					title: "机构添加",
					type: 2,
					skin:'',
					offset: ['85px', '430px'],
					area: ['560px', '550px'],
					content: path + "/org/form.do?pid="+data.id,
				});
				layui.layer.full(index);
		        //改变窗口大小时，重置弹窗的宽高，防止超出可视区域（如F12调出debug的操作）
		        $(window).on("resize",function(){
		            layui.layer.full(index);
		        });
			}
        });
        $('#btn-search').click(function () {
            var keyword = $('#edt-search').val();
            var searchCount = 0;
            $('#table1').next('.treeTable').find('.layui-table-body tbody tr td').each(function () {
                $(this).css('background-color', 'transparent');
                var text = $(this).text();
                if (keyword != '' && text.indexOf(keyword) >= 0) {
                    $(this).css('background-color', 'rgba(250,230,160,0.5)');
                    if (searchCount == 0) {
                        treetable.expandAll('#table1');
                        $('html,body').stop(true);
                        $('html,body').animate({scrollTop: $(this).offset().top - 150}, 500);
                    }
                    searchCount++;
                }
            });
            if (keyword == '') {
                layer.msg("请输入搜索内容", {icon: 5});
            } else if (searchCount == 0) {
                layer.msg("没有匹配结果", {icon: 5});
            }
        });
    });
</script>
</body>
</html>