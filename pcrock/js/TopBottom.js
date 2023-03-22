(function() {
    const key = encodeURIComponent('到顶到底:执行判断');
    if (window[key]) {
        return
    }
    try {
        window[key] = true;
 
        function s(i) {
            window.scrollTo(0, i)
        }
        document.head.append();
        const d = document.createElement('div');
        d.innerHTML = '<div id="sky-scrolltop">↑</div><div id="sky-scrolltbtm" style="margin-top:18px;">↓</div>';
        d.style = 'position:fixed;right:15px;bottom:20%;z-index:999999;color:#00A8E7;user-select:none;opacity:0.6;';
        document.body.append(d);
        document.getElementById('sky-scrolltop').onclick = () => {
            s(0)
        };
        document.getElementById('sky-scrolltbtm').onclick = () => {
            s(document.body.scrollHeight)
        }
    } catch (err) {
        console.log('到顶到底：', err)
    }
})();
