//取系统时间
setInterval("time.innerHTML = new Date().toLocaleString('chinese',{hour12:false});",1000);
//屏障右键
document.oncontextmenu=new Function("event.returnValue=false;");document.onselectstart=new Function("event.returnValue=false;");
//隐藏代码框
var btn1=document.getElementById('btn');var box1=document.getElementById('box');function btn(){if(btn1.value=="HideCode"){box1.style.display='none';btn1.value="DisplayCode"}else{box1.style.display='';btn1.value="HideCode"}}
//收缩展开
function show(d1){if (document.getElementById(d1).style.display == 'none') {document.getElementById(d1).style.display = 'block';} else {document.getElementById(d1).style.display = 'none';}}
//特效
!function(){function n(n,e,t){return n.getAttribute(e)||t}function e(n){return document.getElementsByTagName(n)}function t(){var t=e("script"),o=t.length,i=t[o-1];return{l:o,z:n(i,"zIndex",-1),o:n(i,"opacity",.5),c:n(i,"color","0,0,0"),n:n(i,"count",99)}}function o(){a=m.width=window.innerWidth||document.documentElement.clientWidth||document.body.clientWidth,c=m.height=window.innerHeight||document.documentElement.clientHeight||document.body.clientHeight}function i(){r.clearRect(0,0,a,c);var n,e,t,o,m,l;s.forEach(function(i,x){for(i.x+=i.xa,i.y+=i.ya,i.xa*=i.x>a||i.x<0?-1:1,i.ya*=i.y>c||i.y<0?-1:1,r.fillRect(i.x-.5,i.y-.5,1,1),e=x+1;e<u.length;e++)n=u[e],null!==n.x&&null!==n.y&&(o=i.x-n.x,m=i.y-n.y,l=o*o+m*m,l<n.max&&(n===y&&l>=n.max/2&&(i.x-=.03*o,i.y-=.03*m),t=(n.max-l)/n.max,r.beginPath(),r.lineWidth=t/2,r.strokeStyle="rgba("+d.c+","+(t+.2)+")",r.moveTo(i.x,i.y),r.lineTo(n.x,n.y),r.stroke()))}),x(i)}var a,c,u,m=document.createElement("canvas"),d=t(),l="c_n"+d.l,r=m.getContext("2d"),x=window.requestAnimationFrame||window.webkitRequestAnimationFrame||window.mozRequestAnimationFrame||window.oRequestAnimationFrame||window.msRequestAnimationFrame||function(n){window.setTimeout(n,1e3/45)},w=Math.random,y={x:null,y:null,max:2e4};m.id=l,m.style.cssText="position:fixed;top:0;left:0;z-index:"+d.z+";opacity:"+d.o,e("body")[0].appendChild(m),o(),window.onresize=o,window.onmousemove=function(n){n=n||window.event,y.x=n.clientX,y.y=n.clientY},window.onmouseout=function(){y.x=null,y.y=null};for(var s=[],f=0;d.n>f;f++){var h=w()*a,g=w()*c,v=2*w()-1,p=2*w()-1;s.push({x:h,y:g,xa:v,ya:p,max:6e3})}u=s.concat([y]),setTimeout(function(){i()},100)}();
//list
function show(d1){if(document.getElementById(d1).style.display=='none'){document.getElementById(d1).style.display='block';}else{document.getElementById(d1).style.display='none';}}
<!-- VIP  -->
var lang=new Array();var userAgent=navigator.userAgent.toLowerCase();var is_opera=userAgent.indexOf("opera")!=-1&&opera.version();var is_moz=(navigator.product=="Gecko")&&userAgent.substr(userAgent.indexOf("firefox")+8,3);var is_ie=(userAgent.indexOf("msie")!=-1&&!is_opera)&&userAgent.substr(userAgent.indexOf("msie")+5,3);Array.prototype.push=function(value){this[this.length]=value;return this.length};function $(objname){return document.getElementById(objname)}function runCode(objname){var winname=window.open("","_blank","");var obj=$(objname);winname.document.open("text/html","replace");winname.opener=null;winname.document.write(obj.value);winname.document.close()}function saveCode(objname){var winname=window.open("","_blank","top=10000");winname.document.open("text/html","replace");var obj=$(objname);winname.document.write(obj.value);winname.document.execCommand("saveas","","code.htm");winname.close()}; //VIP
var data = [
{name:"OK解析",url:"https://okjx.cc/?url="},
{name:"云解析",url:"https://jx.yparse.com/index.php?url="},
{name:"小七",url:"https://2.08bk.com/?url="},
{name:"8090",url:"https://www.8090g.cn/jiexi/?url="},
{name:"无名",url:"https://www.administratorw.com/admin.php?url="},
{name:"盘古",url:"https://www.pangujiexi.cc/jiexi.php?url="},
{name:"虾米",url:"https://jx.xmflv.com/?url="},
{name:"B-JX",url:"https://jx.m3u8.tv/jiexi/?url="},
{name:"1717",url:"https://www.1717yun.com/jx/ty.php?url="},
{name:"讯讯",url:"https://www.ckmov.com/?url="},
{name:"BDyun",url:"https://jx.jxbdzyw.com/m3u8/?url="},
{name:"660ejx",url:"https://660e.com/?url="},
{name:"17jx",url:"https://www.1717yun.com/jiexi/?url="},
{name:"TVjx",url:"http://jx.ashvsash.cc/?url="},
{name:"asysjx",url:"http://www.asys.vip/jx/?url="},
{name:"leduoJX",url:"https://api.leduotv.com/wp-api/ifr.php?vid="},
{name:"M3u8",url:"http://www.chplayer.com/examples/player.html?videourl="},
];
for (var i in data) {var opt = document.createElement("option");opt.value = data[i].url;opt.innerText = data[i].name;document.getElementById("sel").appendChild(opt)}
function play() {var url = document.getElementById("url").value;if (url.indexOf("http") == -1) {alert("Video address is not correct！");return}var api = document.getElementById("sel").value;var open = document.getElementById("open").value;url = api + url;switch (open) {case "0":window.open(url);console.log(0);break;case "1":window.location = url;console.log(1);break}}; //play
