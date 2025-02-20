function myFunc () {
    // 버튼 클릭하면 실행

    // jQuery로 AJAX 호출 실행
    // 어떤 API로 호출할지, GET방식일지, POST 방식일지, 넘어가는 파라미터는 어떤건지..
    // 정보가 있어야 호출이 되겠죠? => 이 정보는 자바스크립트 객체로 만든다!
    // 자바스크립트 객체 : let obj = {} => key : value 쌍으로 표현!

    // key는 무조건 문자열임!
    let obj = {
        "name" : "홍길동",
        "age" : 20,
        address : "서울"
    }
    $.ajax({
        async: true, // 기본값은 true
        url : "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
        type: "GET",
        params : {
            key: "9b6d88c25f1430f13aef793026aefb2a",
            targetDt: "20250218"
        },
        dataType : "json",
        success: function (result) {
            alert(result.boxOfficeResult);
        }, // 성공했을 시!
        error: function (res) {
            alert("호출 실패")
        }
    })

}