$(document).ready(function () {

    $('.dep').mouseover(function () {
        $(this).addClass('active');
        var result=$(this).find('.dep-inner').css('display','block');
    });
    $('.dep').mouseleave(function () {
        $(this).removeClass('active');
        var result=$(this).find('.dep-inner').css('display','none');
    });

    var menuTitles = document.querySelectorAll('.menu-title');
    
    menuTitles.forEach(function(menuTitle) {
        menuTitle.addEventListener('click', function() {
            // 현재 클릭한 요소에만 active 클래스를 추가 또는 제거
            menuTitles.forEach(function(item) {
                if (item !== menuTitle) {
                    item.classList.remove('active');
                }
            });
            this.classList.toggle('active');
            
        });
    });
});

function toggleMenu() {
    var area = document.getElementById("menu-hamburger-area");
    var submenus = area.querySelectorAll(".menu-hamburger-list ul");

    // 메뉴 토글
    area.style.display = (area.style.display === "none" || area.style.display === "") ? "block" : "none";

    // 메뉴가 숨겨질 때 하위 메뉴들을 모두 감추기
    if (area.style.display === "none") {
        submenus.forEach(function(submenu) {
            submenu.style.display = "none";
        });
    }
}
    // 브라우저 창 크기 변화 감지   
    window.addEventListener('resize', function() {
        var area = document.getElementById("menu-hamburger-area");
        
    
    // 창 크기가 1200px 이상인 경우
        if (window.innerWidth > 1200) {
            area.style.display = "none";
        }
    });


    function toggleSubMenu(submenuClassName) {
        var submenus = document.querySelectorAll(".menu-hamburger-list ul");
 
        submenus.forEach(function(submenu) {
            if (submenu.className === submenuClassName) {
                submenu.style.display = (submenu.style.display === "none" || submenu.style.display === "") ? "block" : "none";
                
            } else {
                submenu.style.display = "none";      
            }
        });
            
    }

    // 클릭 이벤트 처리
    document.addEventListener('DOMContentLoaded', function() {
        var submenu1 = document.querySelector(".submenu-title-1");
        var submenu2 = document.querySelector(".submenu-title-2");
        var submenu3 = document.querySelector(".submenu-title-3");

        if (submenu1) {
            submenu1.addEventListener("click", function() {
                toggleSubMenu("submenu-title-1");
            });
        }
    
        if (submenu2) {
            submenu2.addEventListener("click", function() {
                toggleSubMenu("submenu-title-2");
            });
        }
    
        if (submenu3) {
            submenu3.addEventListener("click", function() {
                toggleSubMenu("submenu-title-3");
            });
        }

    });


 


