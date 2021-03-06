<%@ page language="java" contentType="text/html;charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path;
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script type="text/javascript">
<!--
	//新建实体
	ns.employee.newEmployee = function(){
		$.pdialog.open("<%=basePath%>/pages/business/employee/add.action","newEmployeeDialog","新建",{width:950,height:650,mask:true,resizable:true});
	}
	
	//删除实体
	ns.employee.deleteEmployee = function(){
		var url = "<%=basePath%>/pages/business/employee/delete.action";
		var param = $("#tableForm").serialize();
		var url = url + "?" + param;
		var items = $("input[type='checkbox']:checked").length;
		if(items == 0){
			alertMsg.warn("请选择要删除的数据!");
			return;
		}
		alertMsg.confirm("确定要删除吗?", {okCall:function(){ajaxTodo(url,refreshList);}});
	}
	
	//查看实体明细
	ns.employee.viewEmployee = function(id) {
		$.pdialog.open("<%=basePath%>/pages/business/employee/view.action?employee.id=" + id,"viewEmployeeDialog","明细",{width:950,height:650,mask:true,resizable:true});
	}
	
	//修改实体
	ns.employee.editEmployee = function(id){
		$.pdialog.closeCurrent();
		$.pdialog.open("<%=basePath%>/pages/business/employee/edit.action?employee.id=" + id,"editEmployeeDialog","修改",{width:950,height:650,mask:true,resizable:true});
	}
	
	$(function() {
		//判断是否显示高级查询
		ns.common.showQuery('${queryType}')
		//按钮样式根据鼠标停留而变化
		ns.common.mouseForButton();
	});
//-->
</script>
</head>
<body>	
	<form id="pagerForm" method="post" action="<%=basePath%>/pages/business/employee/list.action?queryType=${queryType}">
<!--		<input type="hidden" name="status" value="${param.status}">-->
<!--		<input type="hidden" name="orderField" value="${param.orderField}" />-->
		<input type="hidden" name="pageNum" value="1" />
		<input type="hidden" name="numPerPage" value="${pageResult.pageSize}" />
		<input type="hidden" name="employee.name" value="${employee.name}"/>
		<input type="hidden" name="employee.code" value="${employee.code}"/>
		<input type="hidden" name="employee.birthday" value="${employee.birthday}"/>
		<input type="hidden" name="employee.phone" value="${employee.phone}"/>
	</form>
	<div class="pageContent">
		<div class="panelBar">
			<table>
				<tr><td>
					<button type="button" id="newEmployee" name="newEmployee" class="listbutton" onclick="ns.employee.newEmployee();" >新建</button>
					<button type="button" id="deleteEmployee" name="deleteEmployee" class="listbutton" onclick="ns.employee.deleteEmployee();" >删除</button>				
				</td></tr>
			</table>
		</div>
	</div>
	<div id="defaultQuery" class="pageHeader">
		<div class="searchBar">
			<form id="defaultQueryForm" onsubmit="return navTabSearch(this);" action="<%=basePath%>/pages/business/employee/list.action?queryType=0" method="post">
				<table class="searchContent">
					<tr><td>
						<td>姓名</td>
						<td class="queryTd">
							<input type="text" name="employee.name" value="${employee.name}"  class="textInput" style="width:180px;"/>
						</td>
						<td>编号</td>
						<td class="queryTd">
							<input type="text" name="employee.code" value="${employee.code}"  class="textInput" style="width:180px;"/>
						</td>
						<td>手机</td>
						<td class="queryTd">
							<input type="text" name="employee.phone" value="${employee.phone}"  class="textInput" style="width:180px;"/>
						</td>
						<td>
							<button type="button" class="listbutton" onclick="ns.common.query('defaultQueryForm');">查询</button>
							<button type="button" class="listbutton" onclick="ns.common.showQuery(1);">高级查询</button>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
	<div id="advanceQuery" align="center" class="pageHeader" style="display:none;">
		<fieldset class="queryFieldset" >
			<legend style="border:0px;">查询项</legend>
			<form id="advanceQueryForm" onsubmit="return navTabSearch(this);" action="<%=basePath%>/pages/business/employee/list.action?queryType=1" method="post">
				<table width="98%"  class="queryTable" >
					<tr>
						<td class="advanceTd">高级查询字段名</td><td class="advanceTd">高级查询字段值	</td>
					</tr>
				</table>
				<div align="center" style="margin-top: 5px;">
					<input type="hidden" name="listId" value="${listId}"/>
					<button type="button" class="listbutton" onclick="ns.common.showQuery(0);">隐藏</button>
					<button type="button" class="listbutton" onclick="ns.common.query('advanceQueryForm');">查询</button>
				</div>
			</form>
		</fieldset>
	</div>
	<div class="panelBar">
		<div class="pages">
			<span>显示</span>
			<select class="combox" name="numPerPage" onchange="navTabPageBreak({numPerPage:this.value})">
				<option value="20" <c:if test="${pageResult.pageSize==20}">selected</c:if>>20</option>
				<option value="50" <c:if test="${pageResult.pageSize==50}">selected</c:if>>50</option>
				<option value="100" <c:if test="${pageResult.pageSize==100}">selected</c:if>>100</option>
				<option value="200" <c:if test="${pageResult.pageSize==200}">selected</c:if>>200</option>
			</select>
			<span>条，共${pageResult.totalCount}条</span>
		</div>
		<div class="pagination" targetType="navTab" totalCount="${pageResult.totalCount}" numPerPage="${pageResult.pageSize}" pageNumShown="${pageResult.pageCountShow}" currentPage="${pageResult.currentPage}"></div>
	</div>
	<form id="tableForm" name="tableForm" method="post">
		<div>
			<table class="table" width="100%" layoutH="138">
				<thead>
					<tr>
						<th align="center" width="5%" ><input name="all" type="checkbox"  class="checkbox" onclick="ns.common.selectAll(this,'employeeIDs')"/></th>
						<th align="center" width="5%">序号</th>
							<th align="center">姓名</th>
							<th align="center">编号</th>
							<th align="center">生日</th>
							<th align="center">手机</th>
						<th align="center">操作</th>
					</tr>
				</thead>
				<tbody>
	            <c:forEach items="${pageResult.content}" var="employee" varStatus="status">
	                <c:if test="${status.count%2==0}">
	                	<tr target="id_column" rel="1" class='event'>
	                </c:if>
	                <c:if test="${status.count%2!=0}">
	                	<tr target="id_column" rel="1">
	                </c:if>
                    	<td align="center"><input type="checkbox" class="checkbox"  name="employeeIDs" value="${employee.id}"/></td>
						<td align="center">${(pageResult.currentPage-1) * pageResult.pageSize + status.count}</td>
						<td align="center">${employee.name}</td>
						<td align="center">${employee.code}</td>
						<td align="center"><fmt:formatDate value="${employee.birthday}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
						<td align="center">${employee.phone}</td>
                    	<td align="center">
                    		<a style="cursor: pointer;color:blue;" onclick="ns.employee.viewEmployee('${employee.id}');">明细</a>&nbsp;
                    		<a style="cursor: pointer;color:blue;" onclick="ns.employee.editEmployee('${employee.id}');">编辑</a>
                    	</td>
                    </tr>
	            </c:forEach>
				</tbody>
			</table>
		</div>
	</form>
</body>
</html>