<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>客户信息管理</title>
<%@include file="/WEB-INF/jsp/include/easyui_core.jsp"%>
<!-- 对话框的样式 -->
<link href="${path}/css/list.css" rel="stylesheet" type="text/css" />

<script type="text/javascript">
	//请求地址
	var url;
	//提示消息
	var mesTitle;
	
	//添加用户信息
	function addObject(){
		$('#dlg').dialog('open').dialog('setTitle','新增用户');
		$('#fm').form('clear');
		url = path+"/customer/add";
		mesTitle = '新增用户成功';
	}
	
	//编辑用户信息
 	function editObject(){
	 	var row = $('#datagrid').datagrid('getSelected');
	 	if (row){
	 		var id = row.id;
		 	$('#dlg').dialog('open').dialog('setTitle','编辑用户');
		 	$('#fm').form('load',row);//这句话有问题，第一次加载时正确的，第二次就出错了，还保持第一次的数据
		 	url = path+"/customer/edit?id="+id;
		 	mesTitle = '编辑用户成功';
	 	}else{
	 		$.messager.alert('提示', '请选择要编辑的记录！', 'error');
	 	}
	}
 	
	//删除用信息
 	function deleteObject(){
	 	var row = $('#datagrid').datagrid('getSelected');
	 	if (row){
	 		var id = row.id;
		 	$('#dlg_delete').dialog('open').dialog('setTitle','删除用户');
		 	$('#fm').form('load',row);//这句话有问题，第一次加载时正确的，第二次就出错了，还保持第一次的数据
		 	url = path+"/customer/delete?id="+id;
		 	mesTitle = '删除用户成功';
	 	}else{
	 		$.messager.alert('提示', '请选择要删除的记录！', 'error');
	 	}
	}
 	
	//保存添加、修改内容
	function saveObject(){
	 	$('#fm').form('submit',{
		 	url: url,
		 	onSubmit: function(){
		 		return $(this).form('validate');
		 	},
			success: function(result){
				/* console.info(result); */
				var result = eval('('+result+')');
				if (result.success){
				 	$('#dlg').dialog('close'); 
				 	$('#datagrid').datagrid('reload'); 
				} else {
					 mesTitle = '新增用户失败';
				}
				$.messager.show({ 
					 title: mesTitle,
					 msg: result.msg
				});
			}
	 	});
	}	
	
	//提交删除内容
	function saveObject_del(){
	 	$('#fm').form('submit',{
		 	url: url,
			success: function(result){
				var result = eval('('+result+')');
				if (result.success){
				 	$('#dlg_delete').dialog('close'); 
				 	$('#datagrid').datagrid('reload'); 
				} else {
					 mesTitle = '删除用户失败';
				}
				$.messager.show({ 
					 title: mesTitle,
					 msg: result.msg
				});
			}
	 	});
	}
	
	//刷新
	function reload(){
		$('#datagrid').datagrid('reload'); 
	}
	//时间格式化
	function formatDate(val,row){
	    var date = new Date(val);
	    return date.Format("yyyy-MM-dd hh:mm:ss");
		
	}
	Date.prototype.Format = function (fmt) { //author: meizz 
	    var o = {
	        "M+": this.getMonth() + 1, //月份 
	        "d+": this.getDate(), //日 
	        "h+": this.getHours(), //小时 
	        "m+": this.getMinutes(), //分 
	        "s+": this.getSeconds(), //秒 
	        "q+": Math.floor((this.getMonth() + 3) / 3), //季度 
	        "S": this.getMilliseconds() //毫秒 
	    };
	    if (/(y+)/.test(fmt)) fmt = fmt.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	    for (var k in o)
	    if (new RegExp("(" + k + ")").test(fmt)) fmt = fmt.replace(RegExp.$1, (RegExp.$1.length == 1) ? (o[k]) : (("00" + o[k]).substr(("" + o[k]).length)));
	    return fmt;
	}
	//是否有电脑
	function formatIsOrNo(val,row){
		var a;
		if(val==1)
			a="是";
		else
			a="无";
		return a;
	}
	//宽带运营商  电信、移动、联通、无
	function formatBroadband(val,row){
		var a;
		switch(val){
			case 1:
				a="电信";	
			break;
			case 2:
				a="移动";	
			break;
			case 3:
				a="联通";	
			break;
			case 4:
				a="无";	
			break;
		}
		return a;
	}
		//宽带满意度 
	function formatBroadbandSatisfy(val,row){
		var a;
		switch(val){
			case 1:
				a="很满意";	
			break;
			case 2:
				a="比较满意";	
			break;
			case 3:
				a="一般";	
			break;
			case 4:
				a="不满意";	
			break;
		}
		return a;
	}
		
	//电视运营商 电信、移动、联通、广电、卫星电视接收器、无
	function formatTv(val,row){
		var a;
		switch(val){
			case 1:
				a="电信";	
			break;
			case 2:
				a="移动";	
			break;
			case 3:
				a="联通";	
			break;
			case 4:
				a="广电";	
			break;
			case 5:
				a="卫星电视接收器";	
			break;
			case 6:
				a="无";	
			break;
		}
		return a;
	}	
		
</script>

</head>
<body class="easyui-layout" fit="true">
	<div region="center" border="false" style="overflow: hidden;">
		<!-- 用户信息列表 title="用户管理" -->
		<table id="datagrid" class="easyui-datagrid" fit="true"
			url="${path}/customerinfo/datagrid" 
			toolbar="#toolbar" 
			pagination="true"
			singleSelect="true" 
			rownumbers="true"
			striped="true"
			border="false" 
			nowrap="false">
			<thead>
				<tr>
					<th field="id" width="10" hidden="true">编号</th>
					<th field="name" width="100">客户姓名</th>
					<th field="telephone" width="100">联系方式</th>
					<th field="address" width="100">地址</th>
					<th field="iscompute" width="100" formatter="formatIsOrNo">是否有电脑</th>
					<th field="broadband" width="100" formatter="formatBroadband">宽带运营商</th>
					<th field="broadbandSatisfy" width="100" formatter="formatBroadbandSatisfy">宽带满意程度</th>
					<th field="isBroadbandFusion" width="100" formatter="formatIsOrNo">是否融合</th>
					<th field="broadbandPrice" width="100">宽带资费</th>
					<th field="broadbandEndTime" width="100">宽带到期</th>
					<th field="tv" width="100" formatter="formatTv">电视运营商</th>
					<th field="tvSatisfy" width="100" formatter="formatBroadbandSatisfy">电视满意程度</th>
					<th field="tvPrice" width="100">电视资费</th>
					<th field="tvEndTime" width="100">电视到期</th>			
					<th field="districtName" width="100" >县分</th>	
					<th field="userName" width="100" >创建人</th>	
					<th field="datetime" width="100" formatter="formatDate">创建时间</th>	
				</tr>
			</thead>
		</table>

		<!-- 按钮 -->
		<div id="toolbar">
			<a href="javascript:void(0);" class="easyui-linkbutton"
				iconCls="icon-reload" plain="true" onclick="reload();">刷新</a>
			<a href="javascript:void(0);" class="easyui-linkbutton"
				iconCls="icon-add" plain="true" onclick="addObject();">新增客户</a> 
			<a href="javascript:void(0);" class="easyui-linkbutton"
				iconCls="icon-edit" plain="true" onclick="editObject();">编辑客户</a> 
			<a href="javascript:void(0);" class="easyui-linkbutton"
				iconCls="icon-remove" plain="true" onclick="deleteObject();">删除客户</a>
		</div>

		<!-- 添加/修改对话框 -->
		<div id="dlg" class="easyui-dialog"
			style="width:400px;height:280px;padding:10px 20px" closed="true"
			buttons="#dlg-buttons">
			<div class="ftitle">新增客户信息</div>
			<form id="fm" method="post" novalidate>
				<div class="fitem">
					<label>客户姓名:</label> <input name="name" class="easyui-textbox"
						required="true">
				</div>
				<div class="fitem">
					<label>联系方式:</label> <input name="telephone" class="easyui-textbox"
						required="true">
				</div>
				<div class="fitem">
					<label>地址:</label> <input name=address class="easyui-textbox"
						required="true">
				</div>
				<div class="fitem">
					<label>是否有电脑:</label> <input name="iscompute" class="easyui-textbox"
						required="true">
				</div>
			</form>
		
		<!-- 添加/修改对话框按钮 -->
		<div id="dlg-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton c6"
				iconCls="icon-ok" onclick="saveObject()" style="width:90px">保存</a> 
				<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')"
				style="width:90px">取消</a>
		</div>
		
		<!-- 删除对话框 -->
		<div id="dlg_delete" class="easyui-dialog"
			style="width:300px;height:200px;padding:10px 20px" closed="true"
			buttons="#dlg-del-buttons">
			<div class="ftitle">请谨慎操作</div>
			<form id="fm" method="post" novalidate>
					<label>确定删除客户吗？</label>
			</form>
		</div>
		
		<!-- 删除对话框按钮 -->
		<div id="dlg-del-buttons">
			<a href="javascript:void(0)" class="easyui-linkbutton c6"
				iconCls="icon-ok" onclick="saveObject_del()" style="width:90px">删除</a> 
			<a href="javascript:void(0)" class="easyui-linkbutton"
				iconCls="icon-cancel" onclick="javascript:$('#dlg_delete').dialog('close')"
				style="width:90px">取消</a>
		</div>
		
	</div>
</body>
</html>