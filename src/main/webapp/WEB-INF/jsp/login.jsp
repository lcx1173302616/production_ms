<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ include file="/WEB-INF/jsp/common_js.jsp"%>
<%@ include file="/WEB-INF/jsp/common_css.jsp"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>生产管理系统</title>
</head>
<body style="background-color: #F3F3F3">
	<div class="easyui-window" title="用户登录"
		data-options="closable:false,draggable:false"
		style="width:400px;padding:1px 40px 30px 10px">
		<div style="margin-left: 38px;margin-top: 38px;">

			<div style="margin-bottom:10px">
				<input id="username" class="easyui-textbox"
					style="width:100%;height:40px;padding:12px"
					data-options="required:true,prompt:'用户名',iconCls:'icon-man',iconWidth:38" value="22">
			</div>
			<div>
				<span id="userspan"></span>
			</div>


			<div style="margin-bottom:20px">

				<div style="margin-bottom:10px">
					<input id="password" class="easyui-textbox" type="password"
						style="width:100%;height:40px;padding:12px"
						data-options="prompt:'密码',iconCls:'icon-lock',iconWidth:38" value="22">
				</div>
				<div>
					<span id="passsword_span"></span>
				</div>

				<div style="margin-bottom:30px">
					<div id="randiv" style="display: none">
						验证码：<input id="randomcode" name="randomcode" size="8" /> <img
							id="randomcode_img" src="${baseurl}validatecode.jsp" alt=""
							width="56" height="20" align='absMiddle' /> <a
							href=javascript:randomcode_refresh()>刷新</a>
					</div>
					<div>
						<span id="randomcode_span"></span>
					</div>

				</div>
			</div>
			<div style="margin-bottom:20px">
				<input type="checkbox" checked="checked"> <span>记住我</span>
			</div>
			<div>
				<a href="#" id="login" class="easyui-linkbutton"
					data-options="iconCls:'icon-ok'"
					style="padding:5px 0px;width:100%;"> <span
					style="font-size:14px;">登录</span>
				</a>
			</div>
			<div>
				<span id="error_span"></span>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		$("#login")
				.click(
						function() {

							var uname = $("#username");
							var pwd = $("#password");
							var display = $("#randiv").css('display');
							var rcode = $("#randomcode");

							if (display == 'none') {
								if ($.trim(uname.val()) == "") {
									$("#passsword_span").html("");
									$("#userspan")
											.html(
													"<font color='red'>用户名不能为空！</font>");
									uname.focus();
								} else if ($.trim(pwd.val()) == "") {
									$("#userspan").html("");
									$("#passsword_span").html(
											"<font color='red'>密码不能为空！</font>");
									pwd.focus();
								} else {
									$("#userspan").html("");
									$("#passsword_span").html("");
									$
											.ajax({
												url : '${baseurl}ajaxLogin',// 跳转到 action  
												data : {
													username : uname.val(),
													password : pwd.val(),
												},
												type : 'post',
												cache : false,
												dataType : 'json',
												success : function(data) {
													if (data.msg == 'account_error') {
														$("#error_span")
																.html(
																		"<font color='red'> 用户不存在！</font>");
														rcode_flag = 1;
														$("#randiv").show();
													} else if (data.msg == 'password_error') {
														$("#error_span")
																.html(
																		"<font color='red'> 密码错误！</font>");
														rcode_flag = 1;
														$("#randiv").show();
													} else if (data.msg == 'authentication_error') {
														$("#error_span")
																.html(
																		"<font color='red'> 您没有授权！</font>");
														rcode_flag = 1;
														$("#randiv").show();
													} else {
														location.href = "${baseurl}home";
													}
												},
												error : function() {
													// view("异常！");  
													alert("异常！");
												}
											});
								}
							} else {
								$("#error_span").html("");
								if ($.trim(uname.val()) == "") {
									$("#passsword_span").html("");
									$("#userspan")
											.html(
													"<font color='red'>用户名不能为空！</font>");
									uname.focus();
								} else if ($.trim(pwd.val()) == "") {
									$("#userspan").html("");
									$("#passsword_span").html(
											"<font color='red'>密码不能为空！</font>");
									pwd.focus();
								} else if ($.trim(rcode.val()) == "") {
									$("#userspan").html("");
									$("#randomcode_span")
											.html(
													"<font color='red'>验证码不能为空！</font>");
									rcode.focus();
								} else {
									$("#userspan").html("");
									$("#passsword_span").html("");
									$("#randomcode_span").html("");
									$
											.ajax({
												url : '${baseurl}ajaxLogin',// 跳转到 action  
												data : {
													username : uname.val(),
													password : pwd.val(),
													randomcode : rcode.val(),
												},
												type : 'post',
												cache : false,
												dataType : 'json',
												success : function(data) {
													if (data.msg == 'account_error') {
														$("#error_span")
																.html(
																		"<font color='red'> 用户不存在！</font>");
														rcode_flag = true;
													} else if (data.msg == 'password_error') {
														$("#error_span")
																.html(
																		"<font color='red'> 密码错误！</font>");
														rcode_flag = true;
													} else if (data.msg == 'randomcode_error') {
														$("#error_span")
																.html(
																		"<font color='red'> 验证码错误！</font>");
														rcode_flag = true;
													} else if (data.msg == 'authentication_error') {
														$("#error_span")
																.html(
																		"<font color='red'> 您没有授权！</font>");
														rcode_flag = true;
													} else {
														location.href = "${baseurl}home";
													}
												},
												error : function() {
													// view("异常！");  
													alert("异常！");
												}
											});
								}
							}
						});

		//刷新验证码
		//实现思路，重新给图片的src赋值，后边加时间，防止缓存
		function randomcode_refresh() {
			$("#randomcode_img").attr('src',
					'${baseurl}validatecode.jsp?time' + new Date().getTime());
		}
	</script>
</body>
</html>