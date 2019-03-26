<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!doctype html>
<html>
<head>
<title>사용자 관리</title>
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

</head>
<body>
	<div id="app">
	<template>
	  <div>
	    <md-table v-model="userList" md-card >
	      <md-table-toolbar>
	        <h1 class="md-title">Users</h1>
	      </md-table-toolbar>
	      <md-table-row slot="md-table-row" slot-scope="{ item }">
	        <md-table-cell md-label="ID" md-sort-by="id">{{ item.userId }}</md-table-cell>
	        <md-table-cell md-label="Name" md-sort-by="name">{{ item.name }}</md-table-cell>
	        <md-table-cell md-label="Gender" md-sort-by="gender">{{ item.gender }}</md-table-cell>
	        <md-table-cell md-label="City" md-sort-by="city">{{ item.city }}</md-table-cell>
	        <md-table-cell md-label="Edit" md-sort-by="edit"><button :onclick="'vueOJ.userEdit(&quot;'+item.userId+'&quot;)'">수정</button></md-table-cell>
	        <md-table-cell md-label="Delete" md-sort-by="delete"><button :onclick="'vueOJ.deleteUser(&quot;'+item.userId+'&quot;)'">삭제</button></md-table-cell>
	      </md-table-row>
	      <md-table-row id="registrationButton">
	        <md-table-cell colspan="7"><button v-on:click="changeInsertLine(true)">사용자 등록</button></md-table-cell>
	      </md-table-row>
	    </md-table>
	  </div>
	</template>
	<br>
	
	<template>
	  <div id="insertTemplate" style="display: none">
	    <md-table md-card >
		  <md-table-toolbar>
		    <h1 class="md-title">insert User</h1>
	      </md-table-toolbar>
	      <md-table-row>
	        <md-table-head>ID</md-table-head>
	        <md-table-head>Name</md-table-head>
	        <md-table-head>Gender</md-table-head>
	        <md-table-head>City</md-table-head>
	        <md-table-head>Add</md-table-head>
	        <md-table-head>Cancel</md-table-head>
	      </md-table-row>
	      <md-table-row  slot="md-table-row">
	        <md-table-cell><input type='text' id='tempUserId'></md-table-cell>
	        <md-table-cell><input type='text' id='tempName'></md-table-cell>
	        <md-table-cell>
			    <select id="tempGender">
		          <option value="남">남</option>
		          <option value="여">여</option>
		        </select>
        	</md-table-cell>
	        <md-table-cell><input type='text' id='tempCity'></md-table-cell>
	        <md-table-cell><button v-on:click="addUser()">등록</button></md-table-cell>
	        <md-table-cell><button v-on:click="changeInsertLine(false)">등록취소</button></md-table-cell>
	      </md-table-row>
	    </md-table>
	  </div>
	</template>

	</div>
	
	<script src="<c:url value="/resources/import/vue/app.js" />"></script>
	
	<script type="text/javascript">
	vueOJ.setDataFormat = function(getUserId, getName, getGender, getCity){
		let dataFormat = { userId:getUserId, name:getName, gender:getGender, city:getCity };
		$("#tempUserId").val("");
		$("#tempName").val("");
		$("#tempGender").val("");
		$("#tempCity").val("");
		return dataFormat
	}

	vueOJ.changeInsertLine = function(input){
		if (input){
			$("#insertTemplate").css("display", "");
			$("#registrationButton").css("display", "none");
		} else {
			$("#insertTemplate").css("display", "none");
			$("#registrationButton").css("display", "");
		}
		
	}

	
	vueOJ.deleteBlankUser = function(){
		$("#tempTr").remove();
		this.isCreateRow = false;
	}
	vueOJ.selectUselist = function(){
		axios.get('/SpringWebPrj/users').then(function(response){
			vueOJ.userList = response.data.userList;
		}).catch(function(error){
			console.log(error);
		}).then(function(){
			vueOJ.changeInsertLine(false);
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
				alert(getUserId + '님의 사용자 정보가 수정 되었습니다');
			} else {
				alert('사용자 정보 수정이 실패하였습니다');
			}
		}).catch(function(error){
			alert('error'+ error);
			console.log(error);
		}).then(function(){
			vueOJ.selectUselist();
		});
		
	}
	vueOJ.deleteUser = function(getUserId){
		
		axios({
			method:'delete',
			url: '/SpringWebPrj/users/' + getUserId,
		}).then(function(response){
			let getResult = response.data.result;
			if(getResult){
				alert(getUserId + '님 계정 삭제 되었습니다');
			} else {
				alert('사용자 정보 계정삭제가 실패하였습니다');
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
				alert(userAddUserId + '님의 사용자 정보가 등록 되었습니다');
			} else {
				alert('사용자 정보 등이 실패하였습니다');
			}
		}).catch(function(error){
			alert('error'+ error);
			console.log(error);
		}).then(function(){
			vueOJ.selectUselist();
			//vueOJ.deleteBlankUser();
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
			emptRecord += "<td><button onclick='addUserCall()'>등록</button></td>";
			emptRecord += "<td><button onclick='deleteBlankUserCall()'>삭제</button></td>";
			emptRecord += "</tr>";
			$("#printUserList").append(emptRecord);
			let createRow = $("#tempTr");
			createRow.prev().before(createRow);	
		} else {
			alert("이미 새로운 레코드가 존재합니다. 레코드를 등록하세요");
			
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
