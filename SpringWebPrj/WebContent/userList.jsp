<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head>
<title>����� ����</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<!-- Optional theme -->
<script src="<c:url value="/resources/import/lib/vue.min.js" />"></script>
<script src="<c:url value="/resources/import/lib/vue-material.min.js" />"></script>
<script src="<c:url value="/resources/import/lib/axios.min.js" />"></script>
<script src="<c:url value="/resources/import/lib/jquery-3.3.1.min.js" />"></script>
<meta content="width=device-width,initial-scale=1,minimal-ui" name="viewport">
<link rel="stylesheet" href="<c:url value="/resources/import/style/vue-material/font.css" />">
<link rel="stylesheet" href="<c:url value="/resources/import/style/vue-material/vue-material.min.css" />">
<link rel="stylesheet" href="<c:url value="/resources/import/style/vue-material/default.css" />">
<script>

</script>
</head>
<body>
	<div id="app">
		<h2 class="text-center">����� ���</h2>
		<table class="table table-bordered table table-hover"> 
			<thead> 
				<tr> 
					<th>���̵�</th> 
					<th>�̸�</th> 
					<th>����</th>
					<th>������</th>
					<th>&nbsp;</th>
					<th>&nbsp;</th>
				</tr> 
		</thead> 
		<tbody id="printUserList"> 
			
				<tr v-for="user in userList">
					<td><p>{{user.userId}}</p></td>
					<td><input type="text" :id="user.userId + '_name'" :value="user.name"></td>
					<td><input type="text" :id="user.userId + '_gender'" :value="user.gender"></td>
					<td><input type="text" :id="user.userId + '_city'" :value="user.city"></td>
					<td>
					     <!--<a :href="'updateUserForm.do?id=' + user.userId">����</a>-->
					     <button v-on:click="userEdit(user.userId)">����</button>
					     
					</td>
					<td>
					<!--  <td><a :href="'deleteUser.do/' + user.userId">����</a></td> -->
						<button v-on:click="deleteUser(user.userId)">����</button>
					</td>
				</tr>
			
			<tr>
				<td colspan="7">
					<!--  <a href="insertUserForm.do">����� ���</a>-->
					<button onclick="addRecord()">����� ���</button>
				</td>
			</tr>
		</tbody>
	</table>
	<template>
  <div>
    <md-table v-model="userList" md-card id="printUserList">
      <md-table-toolbar>
        <h1 class="md-title">Users</h1>
      </md-table-toolbar>

      <md-table-row slot="md-table-row" slot-scope="{ item }" >
        <md-table-cell md-label="ID" md-sort-by="id">{{ item.userId }}</md-table-cell>
        <md-table-cell md-label="Name" md-sort-by="name">{{ item.name }}</md-table-cell>
        <md-table-cell md-label="Gender" md-sort-by="gender">{{ item.gender }}</md-table-cell>
        <md-table-cell md-label="City" md-sort-by="city">{{ item.city }}</md-table-cell>
        <md-table-cell md-label="Edit" md-sort-by="edit"><button v-on:click="userEdit(item.userId)">����</button></md-table-cell>
        <md-table-cell md-label="Delete" md-sort-by="delete"><button v-on:click="deleteUser(item.userId)">����</button></md-table-cell>
      </md-table-row>
    </md-table>
  </div>
</template>

	</div>
	
	<script src="<c:url value="/resources/import/vue/app.js" />"></script>
	
	<script type="text/javascript">
	
	vueOJ.setDataFormat = function(getUserId, getName, getGender, getCity){
		let dataFormat = { userId:getUserId, name:getName, gender:getGender, city:getCity };
		return dataFormat
	}

	

	
	vueOJ.deleteBlankUser = function(){
		$("#tempTr").remove();
		this.isCreateRow = false;
	}
	vueOJ.selectUselist = function(){
		axios.get('/SpringWebPrj/users').then(function(response){
			vueOJ.userList = response.data.userList;
			console.log(vueOJ.users);
		}).catch(function(error){
			console.log(error);
		}).then(function(){
			// finally execute code
		});
	}
	vueOJ.selectUselist();
	vueOJ.userEdit = function(getUserId){
		let userEditName =$("#"+getUserId+"_name").val();
		let userEditGender =$("#"+getUserId+"_gender").val();
		let userEditCity =$("#"+getUserId+"_city").val();
		let sendData = this.setDataFormat(getUserId, userEditName, userEditGender, userEditCity);
		axios({
			method:'put',
			url: '/SpringWebPrj/users',
			data: sendData
		}).then(function(response){
			let getResult = response.data.result;
			if(getResult){
				alert(getUserId + '���� ����� ������ ���� �Ǿ����ϴ�');
			} else {
				alert('����� ���� ������ �����Ͽ����ϴ�');
			}
		}).catch(function(error){
			alert('error'+ error);
			console.log(error);
		}).then(function(){
			vueOJ.selectUselist();
		});
		
	}
	vueOJ,deleteUser = function(getUserId){
		
		axios({
			method:'delete',
			url: '/SpringWebPrj/users/' + getUserId,
		}).then(function(response){
			let getResult = response.data.result;
			if(getResult){
				alert(getUserId + '�� ���� ���� �Ǿ����ϴ�');
			} else {
				alert('����� ���� ���������� �����Ͽ����ϴ�');
			}
		}).catch(function(error){
			alert('error'+ error);
			console.log(error);
		}).then(function(){
			vueOJ.selectUselist();
		});
	}
	vueOJ.addUser = function(){
		let userAddUserId =$("#tempUserId").val();
		let userAddName =$("#tempName").val();
		let userAddGender =$("#tempGender").val();
		let userAddCity =$("#tempCity").val();
		let sendData = this.setDataFormat(userAddUserId, userAddName, userAddGender, userAddCity);
		axios({
			method:'post',
			url: '/SpringWebPrj/users',
			data: sendData
		}).then(function(response){
			let getResult = response.data.result;
			if(getResult){
				alert(userAddUserId + '���� ����� ������ ��� �Ǿ����ϴ�');
			} else {
				alert('����� ���� ���� �����Ͽ����ϴ�');
			}
		}).catch(function(error){
			alert('error'+ error);
			console.log(error);
		}).then(function(){
			vueOJ.selectUselist();
			vueOJ.deleteBlankUser();
		});
	}
	
	addRecord = function(){
		if(!vueOJ.isCreateRow){
			vueOJ.isCreateRow = true;
			let recordLength = $("#printUserList").children().eq(3).prevObject.length*1;
			recordLength = recordLength - 1;
			
			let emptRecord = "<tr id='tempTr'>";
			emptRecord += "<td><input type='text' id='tempUserId'></td>";
			emptRecord += "<td><input type='text' id='tempName'></td>";
			emptRecord += "<td><input type='text' id='tempGender'></td>";
			emptRecord += "<td><input type='text' id='tempCity'></td>";
			emptRecord += "<td><button onclick='addUserCall()'>���</button></td>";
			emptRecord += "<td><button onclick='deleteBlankUserCall()'>����</button></td>";
			emptRecord += "</tr>";
			$("#printUserList").append(emptRecord);
			let createRow = $("#tempTr");
			createRow.prev().before(createRow);	
		} else {
			alert("�̹� ���ο� ���ڵ尡 �����մϴ�. ���ڵ带 ����ϼ���");
			
		}
	}
	addUserCall = function(){
		vueOJ.addUser();
	}
	deleteBlankUserCall = function(){
		vueOJ.deleteBlankUser();
	}
	</script>
</body>
</html>
