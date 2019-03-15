<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
<title>����� ����</title>
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap.min.css" rel="stylesheet">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="<c:url value="/resources/import/lib/vue.min.js" />"></script>
<script src="<c:url value="/resources/import/lib/axios.min.js" />"></script>
<script src="<c:url value="/resources/import/lib/jquery-3.3.1.min.js" />"></script>
<script>

setDataFormat = function(getUserId, getName, getGender, getCity){
	let dataFormat = { userId:getUserId, name:getName, gender:getGender, city:getCity };
	return dataFormat
}


selectUselist = function(){
	axios.get('/SpringWebPrj/users').then(function(response){
		vueOJ.userList = response.data.data;
	}).catch(function(error){
		console.log(error);
	}).then(function(){
		// finally execute code
	});
}

</script>
</head>
<body>
	<div id="app" class="container">
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
		<tbody> 
			
				<tr v-for="user in userList">
					<td>
					 	<a :href="'getUser.do?id=' + user.userId">{{user.userId}}</a>
					 </td>
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
					<a href="insertUserForm.do">����� ���</a>
				</td>
			</tr>
		</tbody>
	</table>
	</div>
	<script src="<c:url value="/resources/import/vue/app.js" />"></script>
	<script type="text/javascript">
	selectUselist();
	vueOJ.userEdit = function(getUserId){
		let userEditName =$("#"+getUserId+"_name").val();
		let userEditGender =$("#"+getUserId+"_gender").val();
		let userEditCity =$("#"+getUserId+"_city").val();
		let sendData = setDataFormat(getUserId, userEditName, userEditGender, userEditCity);
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
			selectUselist();
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
			selectUselist();
		});
	}
	</script>
</body>
</html>
