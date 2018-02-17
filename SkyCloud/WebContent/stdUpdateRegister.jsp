<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<title>Study Cloud 스터디 등록</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" type="text/css" href="http://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.3.0/css/font-awesome.min.css" >
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/bootstrap337/css/bootstrap.css"  >
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/datepicker3.css">
<link rel="stylesheet" type="text/css" href="/StudyCloud/lib/css/stdRegisterCss.css">
<script type="text/javascript" src="/StudyCloud/lib/bootstrap337/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="/StudyCloud/lib/bootstrap337/js/bootstrap.min.js"></script>
<script>
	//스터디 등록 결과 모달 처리 function
	function fnResultModal(result) {
		if(result>0) {//성공
			$("#regiStdBtn").click(function() {
				 window.location.href="/StudyCloud/index.jsp";
			});
		} else {//실패
			$("#updateStudyResultModal div.modal-body")[0].innerHTML = "스터드수정 중 문제가 발생했습니다. 잠시 후 다시 등록해 주십시오.";
			$("#updateStudyResultModal div.modal-footer button").removeClass("btn-info");
			$("#updateStudyResultModal div.modal-footer button").addClass("btn-danger");
			$("#regiStdBtn").click(function() {
				$("#updateStudyResultModal").modal("hide");
			});
		}
		
		$('#updateStudyResultModal').modal();
	}
</script>
<style>
th label {
	margin-top: 5px;
	font-size: 10pt;
	font-style: 맑은 고딕;
	color: #39d2fd;
}

th { vertical-align: top; }
td { vertical-align: middle;	padding: 0;}

div hr { margin-bottom: 5px;	margin-top: 5px; }

table { margin: 50px; }

.weekstyle {
	font-size: 8pt;
} 

.input-daterange input {
    width: 100%;
    font-size: 14px;
    line-height: 1.42857143;
    color: #39d2fd	;
    background-color: rgba(0, 0, 0, 0);
    background-image: none;
    border: 0px solid rgba(0, 0, 0, 0);
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, 0);
    box-shadow: inset 0 0 0 rgba(0, 0, 0, 0);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}



td.dateTd {
	border-left: 0px solid rgba(0, 0, 0, 0);
    border-right: 0px solid rgba(0, 0, 0, 0);
    border-top: 0px solid rgba(0, 0, 0, 0);
    border-bottom: 0.4px solid #39d2fd;
    -webkit-box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    box-shadow: inset 0 1px 1px rgba(0, 0, 0, .075);
    -webkit-transition: border-color ease-in-out .15s, -webkit-box-shadow ease-in-out .15s;
    -o-transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
    transition: border-color ease-in-out .15s, box-shadow ease-in-out .15s;
}

.radio-control {
	font-size: 10pt;
	vertical-align: middle;
}

input[type=radio], input[type=checkbox] {
	width:	0px;	height: 0px;
}

input:checked + i.fa { 
	color : #fff;
    background: #39d2fd; 
	border-radius:50%; padding: 12px; font-size: 12px;
}
input + i.fa { color : #39d2fd; padding: 12px; font-size: 12px; }

input:checked + label { 
	color : #fff;
    background: #39d2fd; 
	border-radius:50%; font-size: 12px;
	padding-right: 8px;	padding-left: 8px;
	padding-top: 5px;	padding-bottom: 5px;
}

input + label { 
	color : #39d2fd; font-size: 12px; 	
	padding-right: 8px;	padding-left: 8px;	
	padding-top: 5px;	padding-bottom: 5px; 
}


button.btn.active.focus, button.btn.active:focus, button.btn.focus, button.btn:active.focus,
	button.btn:active:focus, button.btn:focus {
	outline: none;
	outline-offset: 0;
}

button.btn.active, button.btn:active {
	background-image: none;
	outline: none;
	-webkit-box-shadow: inset 0 0 0 rgba(0, 0, 0, 0);
	box-shadow: inset 0 0 0 rgba(0, 0, 0, .0);
	background-color: #ffffff;
	color: #39d2fd;
}

button.btn-info:active {
	border: 0.4px solid #39d2fd;
	box-shadow: 0 4px 8px 0 rgba(57, 210, 253, 0.2), 0 6px 20px 0 rgba(57, 210, 253, 0.19);
	outline:none;
}
button.btn-info{ width: 50%; background-color: #39d2fd; }

input:focus, select:focus {
  outline: none;
}
</style>
</head>
<body>
	<div class="container-fluid" style="width:70%;">
		<div class="row">
			<div class="col-md-12">
				<form class="form-horizontal" role="form" method="post" action="/StudyCloud/fwd">
					<input type="hidden" name="command" value="STUDYUPDATE">
					<table>
						<tr>
							<th class="col-sm-2">
								<label>스터디명</label>
							</th>
							<td colspan="2" class="col-sm-10">
								<div class="form-group">
									<div class="selectbox col-sm-2">
										<label for="std_category" >
											<c:choose>
												<c:when test="${std.std_category=='lang'}">어학</c:when>
												<c:when test="${std.std_category=='job'}">취업</c:when>
												<c:when test="${std.std_category=='cert'}">자격증</c:when>
												<c:when test="${std.std_category=='bea'}">뷰티</c:when>
												<c:when test="${std.std_category=='spt'}">스포츠</c:when>
												<c:when test="${std.std_category=='etc'}">기타</c:when>
											</c:choose>
										</label>
										<select id="std_category" name="std_category">
											<option selected="selected" hidden="hidden" value="select">대분류</option>
											<option value="lang">어학</option>
			 								<option value="job">취업</option>
			  								<option value="cert">자격증</option>
			  								<option value="bea">뷰티</option>
			  								<option value="spt">스포츠</option>
			  								<option value="etc">기타</option>
										</select>
									</div>
									<div>
									<input type="text" class="rform-control col-sm-10" name="std_name" id="std_name"
										placeholder="등록할 스터디명을 입력" required="required" value="${std.std_name}">
									</div>	
								</div>
								<div id="stdName" style="padding-left: 20%; color: #F56E6E;font-size: 13px;"></div>
							</td>
						</tr>
						<tr>
							<th class="col-sm-2">
								<label>모집 인원</label>
							</th>
							<td colspan="2" class="col-sm-10">
								<div class="form-group" style="line-height: 35px;">
									<div>
										<div>
											<input type="number" class="rform-control col-sm-2" name="std_max" id="std_max" placeholder="인원 수" min="2" required="required" value="${std.std_max }">
										</div>
										<div class="col-sm-10">
										<c:choose>
											<c:when test="${std.std_gender=='M' }">
											<label class="radio-control">
												<input type="radio" value="M" name="std_gender" checked="checked">
												<i class="fa fa-mars"> 남자만 </i>
											</label>
											</c:when>
											<c:otherwise>
												<label class="radio-control">
													<input type="radio" value="M" name="std_gender" >
													<i class="fa fa-mars"> 남자만 </i>
												</label>
											</c:otherwise>
											</c:choose>
											<c:choose>											
											<c:when test="${std.std_gender=='F' }">
											
											<label class="radio-control">
												<input type="radio"	name="std_gender" value="F" checked="checked">
												<i class="fa fa-venus"> 여자만</i>
											</label>
											</c:when>
											<c:otherwise>
											<label class="radio-control">
												<input type="radio"	name="std_gender" value="F" >
												<i class="fa fa-venus"> 여자만</i>
											</label>
											</c:otherwise>
											</c:choose>
											<c:choose>
											<c:when test="${std.std_gender=='B' }">							
											<label class="radio-control">
												<input type="radio" name="std_gender" value="B" checked="checked">
												<i class="fa fa-venus-mars"> 성별무관</i>
											</label>
											</c:when>
											<c:otherwise>
											<label class="radio-control">
												<input type="radio" name="std_gender" value="B">
												<i class="fa fa-venus-mars"> 성별무관</i>
											</label>
											</c:otherwise>
										</c:choose>
										</div>
									</div>
								</div>
							</td>
						</tr>
						
						<tr>
							<th class="col-sm-2">
								<label>스터디 기간</label>
							</th>
							<td colspan="2" class="col-sm-10 dateTd">
								<div class="input-group input-daterange" id="datepicker1">
								   	<input type="text" id="startDate" value="${std.std_start }" class="form-control" name="std_start" data-date-start-date="0d" data-date-format="yyyy-mm-dd" data-date-language="kr" data-date-autoclose="true" placeholder="시작 날짜를 선택해주세요." required="required" />
								   	<div class="input-group-addon" id="dateSeperator"> ~ </div>
								    <input type="text" id="EndDate" value="${std.std_end }" class="form-control" name="std_end" data-date-start-date="+7d" data-date-format="yyyy-mm-dd" data-date-language="kr" data-date-autoclose="true" placeholder="종료 날짜를 선택해주세요." required="required" />
								</div>
							</td>
						</tr>
						<tr>
							<th class="col-sm-2">
								<label>장소 및 시간</label>
							</th>
								<c:set value="${std.timePlaceList }" var="timePlaceList"></c:set>
								<c:forEach begin="0" end="${fn:length(timePlaceList)-1 }" step="1" var="j">
								<c:set value="${timePlaceList[j].std_time }" var="time"/>
								<c:set value="${timePlaceList[j].std_day}" var="std_day"/>
								<c:set value="${fn:split( std_day,'/') }" var="day"/>
								
							<td colspan="2" class="col-sm-10" id="timePlaceTd" style="padding:3px;">
								<div class="timePlaceDiv col-sm-12" >
									<div class="col-sm-6" style="padding:0;">
										<input class="rform-control-inline text-info"  value="${fn:substring(time,0,2) }" size="2" type="number" name="std_time_h" min="0" max="23" placeholder="시" style="text-align:center">
										<label style="color:#000; padding:0;">:</label>
										<input class="rform-control-inline text-info" value="${fn:substring(time,2,5) }" size="2" type="number" name="std_time_m" min="0" max="59" placeholder="분" style="text-align:center">			
										<label style="color:#000; padding:0;">부터&nbsp;</label>
										<input class="rform-control-inline text-info" value="${timePlaceList[j].std_hour }" size="1" type="number" name="std_hour" min="0" max="8" placeholder="몇" style="text-align:center">
										<label style="color:#000; padding:0;">시간</label>
									</div>
									<div class="col-sm-6" style="padding:0; vertical-align: middle;" align="justify">
										<input name="std_day" type="checkbox" id="mon" value="월"><label for="mon">월</label>
										<input name="std_day" type="checkbox" id="tue" value="화"><label for="tue">화</label>
										<input name="std_day" type="checkbox" id="wed" value="수"><label for="wed">수</label>
										<input name="std_day" type="checkbox" id="thur" value="목"><label for="thur">목</label>
										<input name="std_day" type="checkbox" id="fri" value="금"><label for="fri">금</label>
										<input name="std_day" type="checkbox" id="sat" value="토"><label for="sat">토</label>
										<input name="std_day" type="checkbox" id="sun" value="일"><label for="sun">일 </label>
									</div>
									<div class="col-sm-12" style="padding:0;"><hr></div>
									<div class="col-sm-8" style="padding:0;">
										<input type="text" name="std_addr" class="rform-control" value="${timePlaceList[j].std_addr }" placeholder="위치 확인을 눌러 주소를 찾아주세요" id="std_addr0" required="required">
									</div>
									<div class="col-sm-2" style="padding:0;">
										<button type="button" class="btn btn-white" onclick="popupMapModal('std_addr0')">위치 확인 ${day[0]}</button>
									</div>
									<div class="col-sm-2" style="padding:0; line-height:40px;" align="right">
										<button class="btn-trans" type="button" onclick="fnAddPlace()"><i class="fa fa-plus-square-o" style="color:#39d2fd;"></i></button>
									</div>
								</div>
							</td>
							
							</c:forEach>
						</tr>
						
						<tr>
							<th class="col-sm-2">
								<label>스터디 소개글</label>
							</th>
							<td colspan="2">
								<textarea class="rform-control" name="std_info" style="width: 100%; height: 100px" required="required">${std.std_info}</textarea>
							</td>
						</tr>
						<tr>
							<th class="col-sm-2">
								<label>스터디 계획</label>
							</th>
							<td colspan="2">
								<textarea class="rform-control" name="std_plan"  style="width: 100%; height: 100px" required="required">${std.std_plan}</textarea>
							</td>
						</tr>
						<tr>
							<th class="col-sm-2">
								<label>기타사항</label>
							</th>
							<td colspan="2">
								<textarea class="rform-control" name="std_etc" style="width: 100%; height: 100px" required="required">${std.std_etc}</textarea>
							</td>
						</tr>
						<tr>
							<td class="col-sm-2"></td>
							<td colspan="2" style="padding-top: 5px;">
								<input id="contact_open" name="contact_open" type="checkbox" checked="checked">
								<label class="text-info" for="contact_open">연락처 공개<i class="glyphicon glyphicon-ok"></i></label>
							</td>
						</tr>
					</table>
					<div align="center">
						<button type="submit" class="btn btn-info" style="margin-bottom:100px;">등록</button>
					</div>
				</form>
			</div>
		</div>
	</div>
	<!-- Map modal -->
			<div class="modal fade" id="mapModal" data-backdrop="static">
				<div class="modal-dialog">
					<div class="modal-content">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<iframe id="myframe" src="/StudyCloud/mapTest.jsp" width="100%" height="500px" style="border:none"></iframe>
						<div align="center">
						<button class="btn btn-info" id="mapCheck">주소 확인</button>
						</div>
					</div>
					
				</div>
			</div>
			
	<!-- 스터디 등록 결과 모달창 -->
			<div class="modal fade" id="updateStudyResultModal" data-backdrop="static">
				<div class="modal-dialog modal-sm">
					<div class="modal-content">
						<div class="modal-header">
							<i class="fa fa-cloud" style="font-size:24px;color:#39d2fd"><strong>스터디 수정</strong></i>
							<button type="button" class="close" data-dismiss="modal">&times;</button>
						</div>
						<div class="modal-body">
							스터디 수정에 성공하셨습니다.
						</div>
						<div class="modal-footer">
							<button class="btn btn-info" id="regiStdBtn">확인</button>
						</div>
					</div>
				</div>
			</div>
			
		<!-- 스터디 등록 결과 처리 -->
		<c:if test="${! (empty updateStudyResult)}">
			<script>fnResultModal('${updateStudyResult}');</script>
		</c:if>
			

</body>
<script src="/StudyCloud/lib/js/bootstrap-datepicker.js" ></script>
<script src="/StudyCloud/lib/js/bootstrap-datepicker.kr.js" charset="UTF-8"></script>
<script>
	var placeIdNum = 1;
	function fnAddPlace() {
		$.post("/StudyCloud/timePlace/stdTimePlaceTemplate.jsp",{ stdPlaceNum:placeIdNum++ } , callback);
	}
	
	function callback(data) {
		$("#timePlaceTd").append(data);
	}
	
	function fnRemovePlace(divId) {
		$("#" + divId).remove("");
	}
	
	$(function() {
	    var selectTarget = $('.selectbox select');

		selectTarget.on({
		    'focus': function() {
		      $(this).parent().addClass('focus');
		    },
		    'blur': function() {
		      $(this).parent().removeClass('focus');
		    }
		});
		
		  selectTarget.change(function() {
		    var select_name = $(this).children('option:selected').text();
		    $(this).siblings('label').text(select_name);
		    $(this).parent().removeClass('focus');
		});
	});
	
	// mapModal
	var currentAddrId = "";
	
	function popupMapModal(addrId) {
		currentAddrId = addrId;
		$('#mapModal').modal();
	}
	
	// mapIframe 값 가져오기
	$('#mapCheck').click(function(){
		var frame = document.getElementById("myframe");
	var getval = $("#myframe").contents().find('#address').val();
	$("#"+currentAddrId).val(getval);
	$('#mapModal').modal('hide');
	});
	

	$('.input-daterange input').each(function() {
	    $(this).datepicker('clearDates');
	});

</script>
<!-- 유효성 검사 -->
<script>
	$(document).ready(function(){
		$("#std_name").focusout(function(){
			var val = $(this).val();
			var re =/^[0-9a-zA-Z가-힣]{6,16}$/;
			if(val == ""| val == null){
				$("#stdName").text("스터디명을 입력해주세요.").val();
			}
			else if(!re.test(val)){
				$("#stdName").text("6자이상, 16이하로 작성해주세요.").val();
			}
			else{
				//$("#stdName").text("사용가능합니다.").val();
				
				$.ajax({
					type:"POST",
					url:"/StudyCloud/json?command=STD_VALID_REGISTER_STDNAME",
					data:{email : "${email}"},
					success:function(result){
						alert("result : " + result);
						if(result == 0){
							$("#stdName").text("사용할 수 있는 스터디명입니다.").val();
						}
						else{
							$("#stdName").text("중복된 스터디명입니다.").val();
						}
					}
				})
			}
		})
	})
</script>
</html>










