import config from "../config/apikey.js"

const MOVIE_API_KEY = config.MOVIE_API_KEY
const KAKAO_API_KEY = config.KAKAO_API_KEY

$(document).ready(function() {
    $('input[type="date"]').change(function() {
        let selectedDate = $(this).val().replace(/-/g, ""); // YYYY-MM-DD → YYYYMMDD
        myFunc(selectedDate); // 변환한 날짜를 myFunc에 전달
    });
});

function imageSearch(movieNm, callback) {
    $.ajax({


        async: true,
        url: "https://dapi.kakao.com/v2/search/image",
        type: "GET",
        data: {
            query: movieNm + " 포스터",
            page: 1,
            size: 1
        },
        headers: {
            "Authorization": `KakaoAK ${KAKAO_API_KEY}` // REST API 키 입력


        },
        success: function(response) {
            let imageUrl = response.documents.length > 0 ? response.documents[0].thumbnail_url : "no_image.png";
            callback(imageUrl); // 이미지 URL을 콜백 함수로 전달
        },
        error: function(error) {
            console.error(error);
            callback("no_image.png"); // 에러 발생 시 기본 이미지 사용
        }
    });
}

function myFunc(targetDt) {
    $.ajax({
        async: true,
        url: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json",
        type: "GET",
        data: {
            key: MOVIE_API_KEY,

            targetDt: targetDt
        },
        dataType: "json",
        success: function (result) {
            let boxOfficeList = result.boxOfficeResult.dailyBoxOfficeList;
            let tbody = $("table tbody");
            tbody.empty(); // 기존 데이터 초기화

            // 데이터가 없을 경우
            if (boxOfficeList.length === 0) {
                tbody.append("<tr><td colspan='6'>결과가 없습니다.</td></tr>");
                return; // 더 이상 실행하지 않도록 종료
            }

            // 각 영화에 대한 imageSearch를 실행하고, Promise로 변환
            let promises = boxOfficeList.map((movie, index) => {
                return new Promise((resolve) => {
                    imageSearch(movie.movieNm, function (imageUrl) {
                        let row = `<tr>
                            <td>${index + 1}</td>
                            <td><img src="${imageUrl}" alt="${movie.movieNm}" width="50"></td>
                            <td>${movie.movieNm}</td>
                            <td>${movie.audiCnt}</td>
                            <td>${movie.openDt}</td>
                            <td><input type="button" value="삭제" class="delete-btn"></td>
                        </tr>`;
                        resolve(row); // 각 행을 Promise로 반환
                    });
                });
            });

            // 모든 이미지 검색이 완료된 후 실행
            Promise.all(promises).then((rows) => {
                rows.forEach((row) => {
                    tbody.append(row);
                });

                // 삭제 버튼 이벤트 추가
                tbody.on("click", ".delete-btn", function () {
                    $(this).closest("tr").remove();
                });
            });
        },
        error: function () {
            alert("데이터 불러오기 실패");
        }
    });
}


