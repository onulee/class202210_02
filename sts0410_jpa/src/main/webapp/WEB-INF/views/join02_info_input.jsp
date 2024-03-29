<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입 - 회원정보입력</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		<link rel="stylesheet" type="text/css" href="css/style_join02_info_input.css">
		<style>
		  .onIdCheck{color:blue; font-weight: 600;}
		  .offIdCheck{color:red; font-weight: 600;}
		</style>
		<script>
		   var idFlag=0;  //중복확인을 했는지 확인하는 변수
		   $(function(){
			   //이메일주소 입력
			   $("#mail").change(function(){
			      var mail = $("#mail").val();
				  if(mail!=""){
					  $("#mail_tail").val(mail);
					  $("#mail_tail").attr("readonly",true);
				  }else{
					  $("#mail_tail").val("");
					  $("#mail_tail").attr("readonly",false);
				  } 
			   });
			   //년도 넣기
			   var now = new Date();
			   var year = now.getFullYear();
			   var htmlData="";
			   htmlData +="<option selected>선택</option>";
			   for(var i=1900;i<=year;i++){
				    htmlData +="<option value='"+i+"'>"+i+"</option>";
			   }
			   $("#birth_year").html(htmlData); 
			   
			   //월 넣기
			   htmlData="";
			   htmlData +="<option selected>선택</option>";
			   for(var i=1;i<=12;i++){
				    htmlData +="<option value='"+i+"'>"+i+"</option>";
			   }
			   $("#birth_month").html(htmlData); 
			   
			   //일 넣기
			   htmlData="";
			   htmlData +="<option selected>선택</option>";
			   for(var i=1;i<=31;i++){
				    htmlData +="<option value='"+i+"'>"+i+"</option>";
			   }
			   $("#birth_day").html(htmlData); 
		   });//jquery
		   
		   
		   //취소버튼
		   function cancelBtn(){
			   if(confirm("회원가입을 취소하시겠습니까?"))
				   location.href="index";
		   }//cancelBtn
		   
		   //회원가입 버튼
		   function joinBtn(){
			   if(idFlag==1){
				   alert("중복확인을 하셔야 회원가입이 가능합니다.");
				   return;
			   }
			   
			   if($("input:checkbox[name=hobby]:checked").length==0){
				   alert("취미를 1개 이상 체크 하셔야 회원가입이 가능합니다.");
				   return;
			   }
			   
			   //입력패턴 체크
			   var idPattern = /^[a-zA-Z0-9]{3,16}$/;
			   // 영문자1개이상,숫자1개이상,특수문자1개이상
			   var pwPattern = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*<>?]).{3,10}$/;
			   var namePattern = /^[가-힣]{1,10}$/;
			   
			   var id = $("#id").val();
			   if(!idPattern.test(id)){
				   alert("아이디는 3자리 이상 영문,숫자만 가능합니다.");
				   return;
			   }
			   
			   agree.submit();
		   }//
		   
		   //중복체크 확인
		   function checkBtn(){
			   var id = $("#id").val();
			   $.ajax({
				   type:"post",
				   url:"memberIdCheck.do",
				   data:{"id":id},
				   dataType:"json",
				   //contentType:'application/json',
				   success:function(data){ // [{"result":"s-selectOne"}]
				       if(data[0].result=='s-selectOne'){
						   $("#idCheck").addClass("onIdCheck");
						   $("#idCheck").removeClass("offIdCheck");
						   $("#idCheck").text("사용가능한 아이디 입니다.");
					       idFlag=1;
				       }else{
				    	   $("#idCheck").addClass("offIdCheck");
						   $("#idCheck").removeClass("onIdCheck");
						   $("#idCheck").text("아이디를 사용할 수 없습니다.");
						   alert("아이디를 사용하고 있습니다. 다른 아이디를 사용하세요.");
						   idFlag=0;
				       }
				   },
				   error:function(){
					   alert("시스템 오류로 인해 확인이 되지 않았습니다. 다시 입력하세요.");
					   idFlag=0;
				   }
			   });//ajax
		   }//function
		   
		</script>
	</head>
	<body>
	<!-- top부분 시작 -->
    <%@ include file="top/top.jsp" %>
    <!-- top부분 끝 -->
		<section>
			<form action="join03_success" name="agree" method="post" >
				<div id="subBanner"></div>
				<div id="locationN">
					<ul>
						<li>HOME</li>
						<li>회원가입</li>
						<li>회원정보입력</li>
					</ul>
				</div>
				
				<div id="sub_top_area">
					<h3>회원가입</h3>
				</div>
				
				<div id="join_step_div">
					<ul>
						<li>
							<span>STEP.1</span>
							<p>약관동의</p>
						</li>
						<li>
							<span>STEP.2</span>
							<p>회원정보</p>
						</li>
						<li>
							<span>STEP.3</span>
							<p>회원가입완료</p>
						</li>
					</ul>
				</div>
				
				<h4>
					필수 정보 입력 
					<span>(* 항목은 필수 항목입니다.)</span>
				</h4>
				<fieldset class="fieldset_class">
					<dl id="join_name_dl">
						<dt>
							<div></div>
							<label for="name">이름</label>
						</dt>
						<dd>
							<input type="text" id="name" name="name" required/>
						</dd>
					</dl>
					<dl id="join_id_dl">
						<dt>
							<div></div>
							<label for="id">아이디</label>
						</dt>
						<dd>
							<input type="text" id="id" name="id" minlength="4" maxlength="16" required/>
							<input type="button" onclick="checkBtn()" value="중복확인"/>
							<span id="idCheck">아이디 중복확인을 해주셔야 합니다.</span>
							<span>4~16자리의 영문, 숫자, 특수기호(_)만 사용하실 수 있습니다. 첫 글자는 영문으로 입력해 주세요.</span>
						</dd>
					</dl>
					<dl id="join_pw1_dl">
						<dt>
							<div></div>
							<label for="pw">비밀번호</label>
						</dt>
						<dd>
							<input type="password" id="pw" name="pw" minlength="8" required />
							<span>영문, 숫자, 특수문자 중 2종류 조합 시 10자리 이상 입력</span>
							<span>영문, 숫자, 특수문자 모두 조합 시 8자리 이상 입력</span>
						</dd>
					</dl>
					<dl id="join_pw2_dl">
						<dt>
							<div></div>
							<label for="pw2">비밀번호 확인</label>
						</dt>
						<dd>
							<input type="password" id="pw2" name="pw2" minlength="8" />
							<span>비밀번호를 다시 한번 입력해 주세요.</span>
						</dd>
					</dl>
					<dl id="join_tell_dl">
						<dt>
							<div></div>
							<label for="phone">휴대전화</label>
						</dt>
						<dd>
							<input type="text" id="phone" name="phone" />
						</dd>
					</dl>
					<dl id="join_gender_dl">
						<dt>
							<div></div>
							<label for="">성별</label>
						</dt>
						<dd>
							<div>
								<input type="radio" name="gender" id="male" value="male" checked="checked"/>
								<label for="male">남성</label>
								<input type="radio" name="gender" id="female" value="female" />
								<label for="female">여성</label>
							</div>
						</dd>
					</dl>
					<dl id="join_interests_dl">
						<dt>
						    <div></div>
							<label>취미</label>
						</dt>
						<dd>
							<ul>
								<li>
									<input type="checkbox" name="hobby" id="game" value="game" />
									<label for="game">게임</label>
								</li>
								<li>
									<input type="checkbox" name="hobby" id="golf" value="golf" />
									<label for="golf">골프</label>
								</li>
								<li>
									<input type="checkbox" name="hobby" id="run" value="run" />
									<label for="run">조깅</label>
								</li>
								<li>
									<input type="checkbox" name="hobby" id="swim" value="swim" />
									<label for="swim">수영</label>
								</li>
								<li>
									<input type="checkbox" name="hobby" id="book" value="book" />
									<label for="book">독서</label>
								</li>
								<li>
									<input type="checkbox" name="hobby" id="culture" value="culture" />
									<label for="culture">문화/예술</label>
								</li>
								<li>
									<input type="checkbox" name="hobby" id="parenting" value="parenting" />
									<label for="parenting">육아/아동</label>
								</li>
								<li>
									<input type="checkbox" name="hobby" id="cooking" value="cooking" />
									<label for="cooking">요리</label>
								</li>
								<li>
									<input type="checkbox" name="hobby" id="interier" value="interier" />
									<label for="interier">인테리어</label>
								</li>
								<li>
									<input type="checkbox" name="hobby" id="leisure" value="leisure" />
									<label for="leisure">레저/여가</label>
								</li>
								<li>
									<input type="checkbox" name="health" id="health" value="health" />
									<label for="health">건강/다이어트</label>
								</li>
								<li>
									<input type="checkbox" name="hobby" id="fashion" value="fashion" />
									<label for="fashion">패션/미용</label>
								</li>
							</ul>
						</dd>
					</dl>
					
					<dl id="join_mail_dl">
						<dt>
							<div></div>
							<label for="mail_id">이메일</label>
						</dt>
						<dd>
							<input type="text" id="mail_id" name="mail_id" />
							<span>@</span>
							<input type="text" id="mail_tail" name="mail_tail" />
							<select id="mail">
								<option value="" selected>직접입력</option>
								<option value="gmail.com">지메일</option>
								<option value="naver.com">네이버</option>
								<option value="daum.net">한메일(다음)</option>
								<option value="nate.com">네이트</option>
							</select>
						</dd>
					</dl>
					<script>
					  function addressBtn(){
						  new daum.Postcode({
						        oncomplete: function(data) {
						            $("#f_postal").val(data.zonecode);
						            $("#address1").val(data.address);
						        }
						    }).open();
					  }
					</script>
					<dl id="join_address_dl">
						<dt> 
							<div></div>
							<label for="">주소</label>
						</dt>
						<dd>
							<input type="text" id="f_postal" name="f_postal" readonly="readonly" />
							<input type="button" onclick="addressBtn()" value="우편번호"/><br>
							<input type="text" id="address1" name="address1" readonly="readonly"/>
							<input type="text" id="address2" name="address2" />
						</dd>
						
					</dl>
					
					
					<dl id="join_birth_dl">
						<dt>
							<div></div>
							<label for="birth_year">생년월일</label>
						</dt>
						<dd>
							<select id="birth_year" name="birth_year" >
							</select>
							<span>년</span>
							<select id="birth_month" name="birth_month" >
							</select>
							<span>월</span>
							<select id="birth_day" name="birth_day" >
							</select>
							<span>일</span>
							<div>
								<input type="radio" name="calendar" id="lunar" value="lunar" checked="checked"/>
								<label for="lunar">양력</label>
								<input type="radio" name="calendar" id="solar" value="solar" />
								<label for="solar">음력</label>
							</div>
						</dd>
					</dl>
					
					<dl id="join_newsletter_dl">
						<dt>
							<div></div>
							<label for="">뉴스레터 수신여부</label>
						</dt>
						<dd>
							<span>이메일을 통한 상품 및 이벤트 정보 수신에 동의합니다.</span>
							<div>
								<input type="radio" name="newletter" id="newletter_y" value="yes" checked="checked"/>
								<label for="newletter_y">예</label>
								<input type="radio" name="newletter" id="newletter_n" value="no" />
								<label for="newletter_n">아니오</label>
							</div>
						</dd>
					</dl>
					<dl id="join_sms_dl">
						<dt>
							<div></div>
							<label for="">SMS 수신여부</label>
						</dt>
						<dd>
							<span>이메일을 통한 상품 및 이벤트 정보 수신에 동의합니다.</span>
							<div>
								<input type="radio" name="sms" id="sms_y" value="yes" checked="checked"/>
								<label for="sms_y">예</label>
								<input type="radio" name="sms" id="sms_n" value="no" />
								<label for="sms_n">아니오</label>
							</div>
						</dd>
					</dl>
				</fieldset>
				<h4>
					선택 입력 정보 
				</h4>
				<fieldset class="fieldset_class">
					<dl id="join_job_dl">
						<dt>
							<label for="job">직업</label>
						</dt>
						<dd>
							<select id="job" name="job">
								<option selected>선택</option>
								<option value="worker">회사원</option>
								<option value="slef">자영업자</option>
								<option value="freelancer">프리랜서</option>
								<option value="housewife">전업주부</option>
								<option value="student">학생</option>
								<option value="etc">기타</option>						
							</select>
						</dd>
					</dl>
					<dl id="join_marital_status_dl">
						<dt>
							<label for="">결혼여부</label>
						</dt>
						<dd>
							<input type="radio" name="marital_status" id="marital_status_y" value="yes" />
							<label for="marital_status_y">예</label>
							<input type="radio" name="marital_status" id="marital_status_n" value="no" />
							<label for="marital_status_n">아니오</label>
						</dd>
					</dl>
					
				</fieldset>
				<div id="info_input_button">
					<input type="button" onclick="cancelBtn()" value="취소하기" />
					<input type="button" onclick="joinBtn()" value="가입하기" />
				</div>
				
			</form>
		</section>
		<footer>
			<div id="footer_wrap">
				<div id="footer_cont">
					<div id="fl_l">
						<a href="#"></a>
						<p>© COOKIT ALL RIGHTS RESERVED</p>
					</div>
					<div id="fl_c">
						<ul>
							<li><a href="#">이용약관</a></li>
							<li><a href="#">개인정보처리 방침</a></li>
							<li><a href="#">법적고지</a></li>
							<li><a href="#">사업자정보 확인</a></li>
						</ul>
						<div id="fl_c_info">
							<p>씨제이제일제당(주)</p>
							<p>대표이사 : 손경식,강신호,신현재</p>
							<p>사업자등록번호 : 104-86-09535</p>
							<p>주소 : 서울 중구 동호로 330 CJ제일제당 센터 (우) 04560</p>
							<p>통신판매업신고 중구 제 07767호</p>
							<p>개인정보보호책임자 : 조영민</p>
							<p>이메일 : cjon@cj.net</p>
							<p>호스팅제공자 : CJ올리브네트웍스㈜</p>
							<p>고객님은 안전거래를 위해 현금등으로 결제시 LG U+ 전자 결제의 매매보호(에스크로) 서비스를 이용하실 수 있습니다. <a href="#">가입 사실 확인</a></p>
						</div>
					</div>
					<div id="fl_r">
						<span>cj그룹계열사 바로가기 ▼</span>
						<dl>
							<dt>고객행복센터</dt>
								<dd>1688-1920</dd>
						</dl>
						<a href="#">1:1문의</a>						
					</div>
				</div>
			</div>
		</footer>
	</body>
</html>