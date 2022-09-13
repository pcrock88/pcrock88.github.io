// ==UserScript==
// @name         pcrock VIP
// @homepage     https://greasyfork.org/scripts/31867-pcrock-vip/code/pcrock VIP.user.js
// @version      22.9.13.1647
// @description  解析VIP
// @author       pcrock
// @icon         data:image/x-icon;base64,AAABAAEAEBAAAAEAIABoBAAAFgAAACgAAAAQAAAAIAAAAAEAIAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADq6uoA3d3dCMnJySqsrKxAkJCQTnt7e05HR0erUFBQkYmJiVzMzMwQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADr7OwAWlpaZE5OTlanp6cMAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADv7u4AdXeHHDQzVLkuLzStmpubFgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA7e/sAiUlRrMTEVf/Bwkc/ygoKWwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAo6OjFFBRU5MPES39Cwwu/wUGDv8iIyLfoqOhXO3v7QAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADBv78CVVhUKkVERLcVFhf/IyYo/xodHf8MDQ3/ISQh/0lNSfO3uLZA7u7uAAAAAAAAAAAAAAAAAAAAAAAAAAAASEpKg0RHRt0RERH/YGdl/3yGg/9WXlv/LzQz/0pRTP9IT0r/hYWFi+/v7wAAAAAAAAAAAO7u7wDu7+8AeX59EkNDQ6cXGBn/GRwb/1FWVP+wurX9foiC/11oZf9sdnD/Sk9M8bm6uiQAAAAAAAAAAAAAAADv7+0AfX+JIDU6PcMgJCT/EhUV/yAlJP8TFRX/MTU0/z5CQf9AREP/MjU0/1xcXKfq6uoAAAAAAAAAAADt7e0Ae32rRjEye/MoKV//QEVH/yEdS/8XFDv/QkNE/WhoaPdGR0f5REVF1Y6Pjk66urkeAAAAAAAAAAAAAAAA8O/sAlJVqJVBSav/NDyT/0VJZP80MXf/NDV4/4eHkue+vr7dzMzM3c3NzbHNzc0q8PDvAAAAAAAAAAAAAAAAAPDv7wCjp8wubXm8u2Vum+1KS1b7am6b23d8ndHGx8fZu7u768vLy93Ozs7Zzs7Ow9DQ0AYAAAAAAAAAAAAAAAAAAAAA7e/uAOns7gLZ29cIzc7NFNfY2Ai8vbw6xMTE5crKytvIyMjhzs7O2c3Nzd3MzMwqAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA19fXAsDAwMfNzc3dzc3N2crKysPKysrXxMTEFgAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO7u7gC/v79czMzM4c3NzdvPz88a7e3tAOvr6wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAADs7OwA1NTUAsXFxZnMzMyD6OjoAAAAAAAAAAAAAAAAAAAAAAAAAAAA/58AAP//AAD/nwAA/x8AAP4PAAD8BwAA8AMAAPAHAADgBwAAwB8AAIAfAADADwAA/g8AAP4PAAD/PwAA/z8AAA==
// @match        *://*.iqiyi.com/v_*
// @match        *://*.iqiyi.com/w_*
// @match        *://*.iqiyi.com/a_*
// @match        *://v.youku.com/v_*
// @match        *://m.youku.com/v*
// @match        *://m.youku.com/a*
// @match        *://*.le.com/ptv/vplay/*
// @match        *://v.qq.com/x/cover/*
// @match        *://v.qq.com/x/page/*
// @match        *://v.qq.com/play*
// @match        *://v.qq.com/cover*
// @match        *://v.qq.com/tv/*
// @match        *://*.tudou.com/listplay/*
// @match        *://*.tudou.com/albumplay/*
// @match        *://*.tudou.com/programs/view/*
// @match        *://*.tudou.com/v*
// @match        *://*.mgtv.com/b/*
// @match        *://film.sohu.com/album/*
// @match        *://tv.sohu.com/v/*
// @match        *://*.acfun.cn/v/*
// @match        *://*.bilibili.com/video/*
// @match        *://*.bilibili.com/anime/*
// @match        *://*.bilibili.com/bangumi/play/*
// @match        *://*.pptv.com/show/*
// @match        *://*.wasu.cn/Play/show*
// @grant        none
// @namespace    https://pcrock.gitee.io/
// ==/UserScript==

//    VIP    //window.open("https://okjx.cc/?url=" + location.href, "_blank")};
(function() {
    let dom = document.createElement("ruby");
    dom.style.background = "rgb(0 255 255 / 15%)";dom.style.position = "fixed";dom.style.zIndex = "9999";
    dom.style.width = "20px";dom.style.height = "20px";dom.style.top = "20%";dom.style.borderRadius = "0 5px 5px 0";
    document.body.appendChild(dom);dom.addEventListener("click", linkTo);
    function linkTo() {location.href = "https://okjx.cc/?url=" + (location.href)}
        {let dom = document.createElement("ruby");
        dom.style.background = "rgb(255 255 0 / 15%)";dom.style.position = "fixed";dom.style.zIndex = "9999";
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
//    顶底
(function(){const key=encodeURIComponent('到顶到底:执行判断');if(window[key]){return}try{window[key]=true;function s(i){window.scrollTo(0,i)}const f=document.createElement('link');f.rel='stylesheet';f.href="data:text/css,@font-face{font-family:TandB;src:url('data:font/woff2;base64,d09GMgABAAAAAAKYAAoAAAAABcQAAAJLAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAABmAAgkoKgnyCMQsIAAE2AiQDDAQgBYI+ByAbvgTIjsJxr4SI0AxliGLAyxhKy8P/jzHv+4ZoMomaTBKHzCFSPUQyjUgTbZVMJpF1Wyi7fr+270zfv/OGSzJPXBNxTJMl1Ub8lhFNeGQ6oRBNhq7JHyl+AP7RJfb0NhzCML1tPI7iidum3D0cqLVrbXIJPnsoGaFVqKR7ziNwbX5hfKoNMUhaBoAYBABwcN4Vhivv1t0od/F/kTsvwhOAgDwCgBkIGRkTENjDFZjAMws0RUiLDP//AP4HHqRjiwIgGth0ZjZ53QvgCoACkiQVXiEuIKR8Oc8qrZKpLZea8Ga3ZF63rYtux7R+R7qgtfAlhVtaPePZdipbHftD2xI8r9mESzKf2KHHMIQhHPGtvKSjEN9c4ib7sR3Z7GhDC3QOTU+6XWkOhamX7Mfoo9q3HqYf03V1p5gnCg5a6utopZI5xpj8+qQxtQ9/KErJfn93HQ0IB+e+gKKwhaAoAlvA8sei9qPzdOb0RCkcCFm+v9jGcyIE8/l5ipX0CcandXWWQEic8PPDgo2gLY7o1j5McDkABIJ/xkA+5c6rSMoDeG82uflh6v8r+ZCbB6BTAsFuVl47SJirTO1xjlHIydfUnT+EkK3jsB+11w0ECBUBkqYKkFU9AhTVIASqKVoINNUyrihiCN02MpD02gVZt32oYIeg2hFc0nR7MQd6w+2fgPGE98UzSVddUdXwX7pwVcktGk0vbj8RzAJ6hbUziQhLGJFpmJiQdddBQxL69MpSrUKVBlm6cT6sa6o6DBosi4x2zxZvsAguYOkoAAAAAA')}%23sky-scrolltop,%23sky-scrolltbtm{font-family:TandB!important;font-style:normal;font-weight:400;font-variant:normal;text-transform:none;-webkit-font-smoothing:antialiased;line-height:1;font-size:16px;padding:5px;background:%23222;border-radius:6px}";document.head.append(f);const d=document.createElement('div');d.innerHTML='<div id="sky-scrolltop">顶</div><div id="sky-scrolltbtm" style="margin-top:18px;">底</div>';d.style='position:fixed;right:15px;bottom:20%;z-index:999999;color:#eee;user-select:none;opacity:0.6;';document.body.append(d);document.getElementById('sky-scrolltop').onclick=()=>{s(0)};document.getElementById('sky-scrolltbtm').onclick=()=>{s(document.body.scrollHeight)}}catch(err){console.log('到顶到底：',err)}})();
//    CSDN去广告
(function(){window.onload=function(){if(window.location.host=="blog.csdn.net"){var asideFooter=document.querySelector("#asideFooter");if(asideFooter!=null){asideFooter.style.visibility="hidden"}var pulllogBox=document.querySelector(".pulllog-box");if(pulllogBox!=null){pulllogBox.style.visibility="hidden"}var dmp_ad_58=document.querySelector("#dmp_ad_58");if(dmp_ad_58!=null){dmp_ad_58.style.visibility="hidden"}var indexSuperise=document.querySelector(".indexSuperise");if(indexSuperise!=null){indexSuperise.style.visibility="hidden"}var adContent=document.querySelector("#adContent");if(adContent!=null){adContent.style.visibility="hidden"}var recommendadbox=document.querySelectorAll(".recommend-ad-box");if(recommendadbox!=null){for(var i=0;i<recommendadbox.length;i++){recommendadbox[i].style.visibility="hidden"}}var type_hot_word=document.querySelector(".type_hot_word");if(type_hot_word!=null){type_hot_word.style.visibility="hidden"}var recommendRight=document.querySelector(".recommend-right");if(recommendRight!=null){recommendRight.style.visibility="hidden"}var aside=document.querySelector("aside");if(aside!=null){aside.parentNode.removeChild(aside)}document.querySelector("#btn-readmore").click()}};})();
//    限制解除
(function(){'use strict';document.oncontextmenu=function(){return true};document.onselectstart=function(){return true};document.oncopy=function(){return true};document.oncut=function(){return true};document.onpaste=function(){return true}})();
*/
