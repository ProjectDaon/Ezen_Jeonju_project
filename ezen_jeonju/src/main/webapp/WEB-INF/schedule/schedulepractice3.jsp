<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Drag and Drop Table Rows</title>
    <style>
        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }


        th {
            background-color: #f2f2f2;
        }

        /* 드래그 중인 행에 투명도 적용 */
        .dragged {
            opacity: 0.5;
        }

        #timetbl{
            width: 60px;
        }

        td{
            height: 50px;
        }


    </style>
<script>
    function getJeonju() {
        let obj = document.getElementById("jj");

        fetch("https://api.odcloud.kr/api/15076735/v1/uddi:98edad48-0892-4621-8741-cdff64f99c79?page=1&perPage=10&serviceKey=%2BUFeyGq0yCyRGAnfn2BZHmpxwulEWArLYaKEKRMZZSGW85K8Gxlkum5LSZjUcypheIifRSpj1kFDOTS3yFa5wQ%3D%3D")
            .then((response) => response.json())
            .then((data) => {
                data.data.forEach((restaurant) => {
                    let newP = document.createElement("p");
                    let restaurantName = restaurant['식당명'];
                    newP.innerHTML = "<a href='#' onclick='addToTable(\"" + restaurantName + "\")'>" + restaurantName + "</a>";
                    obj.appendChild(newP);
                });
            });
    }

    function addToTable(restaurantName) {
        let tableCell = document.getElementById("addSchedule"); // Adjust the ID based on your actual table cell ID
        tableCell.innerHTML = restaurantName;
    }
</script>

</head>
<body>

    <button onclick="getJeonju()">음식점</button>
    <div id="jj"></div><br>
    
    <div style="display: flex; flex-direction: row;">
    <table id="timetbl">
        <thead><th>시간</th></thead>
        <tbody>
            <tr><td></td></tr>
            <tr><td>08:00</td></tr>
            <tr><td>09:00</td></tr>
            <tr><td>10:00</td></tr>
        </tbody>
    </table>

    <table id="dragDropTable">
        <thead>
            <tr>
                <th>Header 1</th>
                <th>Header 2</th>
                <th>Header 3</th>
            </tr>
        </thead>
        <tbody>
          
            <td id="addSchedule" colspan="3">장소를 누르시고 원하는 시간대에 드래그하세요</td>
            
            <tr>
                <td id="1-1"></td>
                <td id="1-2"></td>
                <td id="1-3"></td>
            </tr>
            <tr>
                <td id="2-1"></td>
                <td id="2-2"></td>
                <td id="2-3"></td>
            </tr>
            <tr>
                <td id="3-1"></td>
                <td id="3-2"></td>
                <td id="3-3"></td>
            </tr>
        </tbody>
    </table>
</div>
    <script>
        // 드래그 시작한 요소의 참조를 저장하는 변수
        let dragSrcElement = null;

        // 드래그 시작 이벤트 핸들러
        function handleDragStart(e) {
            // 드래그 시작한 요소의 참조 저장
            dragSrcElement = this;
            // 드래그 효과 설정
            e.dataTransfer.effectAllowed = 'move';
            // 드래그 데이터 설정 (텍스트/HTML 형식)
            e.dataTransfer.setData('text/html', this.innerHTML);
            // 드래그 중인 행에 클래스 추가하여 투명도 적용
            this.classList.add('dragged');
        }

        // 드래그 중인 상태에서 다른 요소 위로 이동할 때 발생하는 이벤트 핸들러
        function handleDragOver(e) {
            // 기본 동작 방지
            if (e.preventDefault) {
                e.preventDefault();
            }
            // 드래그 가능한 효과 설정
            e.dataTransfer.dropEffect = 'move';
            return false;
        }

        // 드래그 중인 상태에서 요소에 진입했을 때 발생하는 이벤트 핸들러
        function handleDragEnter() {
            // 드래그 중인 행에 클래스 추가하여 시각적 효과 적용
            this.classList.add('over');
        }

        // 드래그 중인 상태에서 요소에서 빠져나갈 때 발생하는 이벤트 핸들러
        function handleDragLeave() {
            // 드래그 중인 행에서 클래스 제거하여 시각적 효과 제거
            this.classList.remove('over');
        }

        // 드롭이 일어났을 때 발생하는 이벤트 핸들러
        function handleDrop(e) {
            // 이벤트 전파 방지
            if (e.stopPropagation) {
                e.stopPropagation();
            }

            // 드래그 소스와 드롭 대상이 다를 경우만 처리
            if (dragSrcElement !== this) {
                // 드래그 소스의 내용을 드롭 대상으로 이동
                dragSrcElement.innerHTML = this.innerHTML;
                // 드롭 대상의 내용을 드래그 소스로 이동
                this.innerHTML = e.dataTransfer.getData('text/html');
            }

            return false;
        }

        // 드래그 종료 시 발생하는 이벤트 핸들러
        function handleDragEnd() {
            // 드래그 중인 행의 투명도 클래스 제거
            this.classList.remove('dragged');
            // 드롭 대상의 시각적 효과 클래스 제거
            items.forEach(function (item) {
                item.classList.remove('over');
            });
        }

        // 테이블의 모든 행을 선택하여 드래그 이벤트 리스너 등록
        const items = document.querySelectorAll('#dragDropTable tbody td');
        items.forEach(function(item) {
            item.draggable = true;
            item.addEventListener('dragstart', handleDragStart, false);
            item.addEventListener('dragover', handleDragOver, false);
            item.addEventListener('dragenter', handleDragEnter, false);
            item.addEventListener('dragleave', handleDragLeave, false);
            item.addEventListener('drop', handleDrop, false);
            item.addEventListener('dragend', handleDragEnd, false);
        });
    </script>

</body>
</html>