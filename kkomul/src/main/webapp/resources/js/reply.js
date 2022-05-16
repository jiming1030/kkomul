/**
 * 
 */
console.log("Reply Module.......................");

//var buyCar = function(carName) { // 이름으로 함수 호출하기(buyCar)
//	console.log("내가 구매한 차는 " + carName + "입니다.");
//};
//
//buyCar("sonata");
//
//(function(carName) { // 즉시 실행 함수 표현식
//	console.log("내가 구매한 차는 " + carName + "입니다.");	
//}("EV6"));

var replyService = (function() {
	
	function add(reply, callback, error) {
		console.log("add reply......................");
		
		$.ajax({
			type : "post",
			url : "/replies/new", 
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if (callback) {
					callback(result);
				}
			},
			error : function(xhr, status, er) {
				if (error) {
					error(er);
				}
			}
		});
	}
	
	function getList(param, callback, error) {
		var bno = param.bno;
		var page = param.page || 1;
		
		$.getJSON("/replies/pages/" + bno + "/" + page, 
			function(data) {
				if(callback) {
					callback(data.replyCnt, data.list); // 댓글 숫자, 목록
				}
			}).fail(function(xhr, status, err) {
				if(err) {
					error();
				}
			});
	}
	
	function remove(reply, callback, err) {
		$.ajax({
			type : "delete",
			url : "/replies/" + reply.rno,
			success : function(deleteResult, status, xhr) {
				if(callback) {
					callback(deleteResult);
				}
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			}
		});
	}
	
	function update(reply, callback, error) {
		console.log("RNO : " + reply.rno);
		
		$.ajax({
			type : "put",
			url : "/replies/" + reply.rno,
			data : JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success : function(result, status, xhr) {
				if(callback) {
					callback(result);
				}				
			},
			error : function(xhr, status, er) {
				if(error) {
					error(er);
				}
			} 
		});
	}
	
	function get(reply, callback, error) { // 댓글 조회
		$.get("/replies/" + reply.rno,
			function(result) {
				if(callback) {
					callback(result);
				}
			}).fail(function (xhr, status, err) {
				if(error) {
					error();
				}
			});
	}
	
	function displayTime(timeValue) { // 댓글 시간 처리
		var today = new Date(); // 오늘 날짜 취득
		
		var gap = today.getTime() - timeValue;
		
		var dateObj = new Date(timeValue);
		var str = "";
		
		if(gap < (1000 * 60 * 60 * 24)) {// 1000 * 60 * 60 * 24 > 하루를 초로 계산
			var hh = dateObj.getHours();
			var mi = dateObj.getMinutes();
			var ss = dateObj.getSeconds();
			
			return [(hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi, 
									':', (ss > 9 ? '' : '0') + ss].join('');
		} else {
			var yy = dateObj.getFullYear();
			var mm = dateObj.getMonth() + 1;
			var dd = dateObj.getDate();
			
			return [yy, '/', (mm > 9 ? '' : '0') + mm, '/', 
						(dd > 9 ? '' : '0') + dd].join('');
		}
	}
	
	return {add : add,
			get : get,
			getList : getList,
			remove : remove,
			update : update,
			displayTime : displayTime};
}());

