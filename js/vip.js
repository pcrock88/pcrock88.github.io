// ==UserScript==
// @name         pcrock VIP
// @homepage     https://greasyfork.org/scripts/31867-pcrock-vip/code/pcrock VIP.user.js
// @version      22.9.13.1647
// @description  解析VIP
// @author       pcrock
// @icon         data:image/x-icon;base64,AAABAAEAEBAAAAEAIABoBAAAFgAAACgAAAAQAAAAIAAAAAEAIAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADq6uoA3d3dCMnJySqsrKxAkJCQTnt7e05HR0erUFBQkYmJiVzMzMwQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADr7OwAWlpaZE5OTlanp6cMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADv7u4AdXeHHDQzVLkuLzStmpubFgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA7e/sAiUlRrMTEVf/Bwkc/ygoKWwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAo6OjFFBRU5MPES39Cwwu/wUGDv8iIyLfoqOhXO3v7QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADBv78CVVhUKkVERLcVFhf/IyYo/xodHf8MDQ3/ISQh/0lNSfO3uLZA7u7uAAAAAAAAAAAAAAAAAAAAAAAAAAAASEpKg0RHRt0RERH/YGdl/3yGg/9WXlv/LzQz/0pRTP9IT0r/hYWFi+/v7wAAAAAAAAAAAO7u7wDu7+8AeX59EkNDQ6cXGBn/GRwb/1FWVP+wurX9foiC/11oZf9sdnD/Sk9M8bm6uiQAAAAAAAAAAAAAAADv7+0AfX+JIDU6PcMgJCT/EhUV/yAlJP8TFRX/MTU0/z5CQf9AREP/MjU0/1xcXKfq6uoAAAAAAAAAAADt7e0Ae32rRjEye/MoKV//QEVH/yEdS/8XFDv/QkNE/WhoaPdGR0f5REVF1Y6Pjk66urkeAAAAAAAAAAAAAAAA8O/sAlJVqJVBSav/NDyT/0VJZP80MXf/NDV4/4eHkue+vr7dzMzM3c3NzbHNzc0q8PDvAAAAAAAAAAAAAAAAAPDv7wCjp8wubXm8u2Vum+1KS1b7am6b23d8ndHGx8fZu7u768vLy93Ozs7Zzs7Ow9DQ0AYAAAAAAAAAAAAAAAAAAAAA7e/uAOns7gLZ29cIzc7NFNfY2Ai8vbw6xMTE5crKytvIyMjhzs7O2c3Nzd3MzMwqAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA19fXAsDAwMfNzc3dzc3N2crKysPKysrXxMTEFgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO7u7gC/v79czMzM4c3NzdvPz88a7e3tAOvr6wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADs7OwA1NTUAsXFxZnMzMyD6OjoAAAAAAAAAAAAAAAAAAAAAAAAAAAA/58AAP//AAD/nwAA/x8AAP4PAAD8BwAA8AMAAPAHAADgBwAAwB8AAIAfAADADwAA/g8AAP4PAAD/PwAA/z8AAA==
// @match        *
// @grant        none
// @namespace    https://pcrock.gitee.io/
// @require      https://gitee.com/pcrock/pcrock/raw/master/js/TopBottom.js
// @require      https://gitee.com/pcrock/pcrock/raw/master/js/WebAstrict.js
// @require      https://gitee.com/pcrock/pcrock/blob/master/js/CSDNADS.js
// ==/UserScript==

//    VIP    //window.open("https://okjx.cc/?url=" + location.href, "_blank")};
(function() {
    let dom = document.createElement("ruby");
    dom.style.background = "rgb(0 255 255 / 15%)";dom.style.position = "fixed";dom.style.zIndex = "99999";
    dom.style.width = "20px";dom.style.height = "20px";dom.style.top = "20%";dom.style.borderRadius = "0 5px 5px 0";
    document.body.appendChild(dom);dom.addEventListener("click", linkTo);
    function linkTo() {location.href = "https://okjx.cc/?url=" + (location.href)}
        {let dom = document.createElement("ruby");
        dom.style.background = "rgb(255 255 0 / 15%)";dom.style.position = "fixed";dom.style.zIndex = "99999";
        dom.style.width = "20px";dom.style.height = "20px";dom.style.top = "22.5%";dom.style.borderRadius = "0 5px 5px 0";
        document.body.appendChild(dom);dom.addEventListener("click", linkTo);
        function linkTo() {location.href = "https://z1.m1907.cn/?jx=" + (location.href)}
        }
})();

/*
(function() {
    'use strict';
    var vipBtn = "<div id='vipBtn' style='cursor:pointer;z-index:998;position:fixed;left:10px;top:300px;'><img src='https://cdn.80note.com/vip.gif' height='55' ></div>";
    $("body").append(vipBtn);
    $('#vipBtn').click(function() {
        window.location.href = "https://okjx.cc/?url=" + location.href;
    });
})();
(function() {
    location.href = "https://okjx.cc/?url=" + (location.href)
})();
*/
