`head`:

```head

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">


```
`CSS`:
```css

/* 图标隔离层 */
.Arlettebrook-icon {
    display:inline-block;
    font-size:1em;
    line-height:1;
    width:1em;
    height:1em;
    -webkit-font-smoothing: antialiased;
    vertical-align:middle;
}
.Arlettebrook-floating-btn .Arlettebrook-icon { font-size:1.3rem; }
.Arlettebrook-menu-item .Arlettebrook-icon { font-size:1rem; }

.Arlettebrook-floating-btn {
    position: fixed;
    bottom:1.8rem;
    right:1.8rem;
    width:50px;
    height:50px;
    border-radius:50%;
    background:linear-gradient(135deg,#6f83ff,#8f69ff);
    color:white;
    border:none;
    cursor:pointer;
    display:flex;
    justify-content:center;
    align-items:center;
    box-shadow:0 8px 22px rgba(110,90,255,0.38);
    z-index:1200;
    transition: transform 0.35s cubic-bezier(0.22,1,0.36,1);
    overflow:hidden;
}

.Arlettebrook-hide { transform:translateY(80px); }
.Arlettebrook-show { transform:translateY(0); }

.Arlettebrook-floating-btn.Arlettebrook-open .Arlettebrook-icon::before {
    content: "\f00d";
}

.Arlettebrook-menu {
    position: fixed;
    bottom: calc(1.8rem + 25px);
    right: calc(1.8rem + 25px);
    width:0;
    height:0;
    pointer-events:none;
    z-index:1100;
}

.Arlettebrook-menu-item {
    position:absolute;
    width:42px;
    height:42px;
    border-radius:50%;
    display:flex;
    justify-content:center;
    align-items:center;
    color:white;
    cursor:pointer;
    pointer-events:auto;
    transform: scale(0) rotate(0deg) translate(0,0);
    opacity:0;
    transition:
        transform .55s cubic-bezier(0.25,0.8,0.5,1),
        opacity .35s ease-in;
    box-shadow:0 8px 22px rgba(0,0,0,0.12);
}

/* 三个按钮布局不变 */
.Arlettebrook-item1 { --Arlettebrook-tx:-90px;  --Arlettebrook-ty:0;    background:#ff859a; }
.Arlettebrook-item2 { --Arlettebrook-tx:-75px;  --Arlettebrook-ty:-75px; background:#a38aff; }
.Arlettebrook-item3 { --Arlettebrook-tx:0;      --Arlettebrook-ty:-90px; background:#63ddd1; }

.Arlettebrook-menu-item:hover {
    transform: scale(1.18) translate(var(--Arlettebrook-tx),var(--Arlettebrook-ty));
}

.Arlettebrook-menu.Arlettebrook-open .Arlettebrook-menu-item {
    opacity:1;
    transform: scale(1.05) rotate(360deg) translate(var(--Arlettebrook-tx),var(--Arlettebrook-ty));
    animation:Arlettebrook-bounceBack .45s cubic-bezier(0.25,1,0.5,1) forwards;
}

@keyframes Arlettebrook-bounceBack {
    0%   { transform:scale(1.25) rotate(360deg) translate(var(--Arlettebrook-tx),var(--Arlettebrook-ty)); }
    60%  { transform:scale(.92)  rotate(360deg) translate(var(--Arlettebrook-tx),var(--Arlettebrook-ty)); }
    100% { transform:scale(1.0) rotate(360deg) translate(var(--Arlettebrook-tx),var(--Arlettebrook-ty)); }
}

.Arlettebrook-ripple {
    position:absolute;
    width:120%;
    height:120%;
    border-radius:50%;
    background:rgba(255,255,255,0.3);
    transform:scale(0);
    opacity:0;
    pointer-events:none;
}

.Arlettebrook-animate {
    animation:Arlettebrook-rippleAnim .55s ease-out forwards;
}

@keyframes Arlettebrook-rippleAnim {
    0%   { transform:scale(0); opacity:.5; }
    100% { transform:scale(1.5); opacity:0; }
}

```

`HTML`:
```html

<!-- 菜单 -->
<!-- ★★ 已调整按钮顺序：登出 → 管理 → 其他 -->
<div class="Arlettebrook-menu" id="Arlettebrook-menu">
    <div class="Arlettebrook-menu-item Arlettebrook-item1">
        <i class="fas fa-sign-out-alt Arlettebrook-icon"></i>
    </div>
    <div class="Arlettebrook-menu-item Arlettebrook-item2">
        <i class="fas fa-tools Arlettebrook-icon"></i>
    </div>
    <div class="Arlettebrook-menu-item Arlettebrook-item3">
        <i class="fas fa-ellipsis-h Arlettebrook-icon"></i>
    </div>
</div>

<button class="Arlettebrook-floating-btn Arlettebrook-show" id="Arlettebrook-floatBtn">
    <i class="fas fa-bars Arlettebrook-icon"></i>
</button>

```

`JAVASCRIPT`:
```JavaScript

const floatBtn = document.getElementById("Arlettebrook-floatBtn");
const menu = document.getElementById("Arlettebrook-menu");
const items = [...document.querySelectorAll(".Arlettebrook-menu-item")];

/* ripple init */
items.forEach(item=>{
    const r=document.createElement("span");
    r.className="Arlettebrook-ripple";
    item.appendChild(r);
});

/* close menu */
function closeMenu(){
    floatBtn.classList.remove("Arlettebrook-open");
    menu.classList.remove("Arlettebrook-open");
}

/* main toggle */
floatBtn.addEventListener("click",()=>{
    floatBtn.classList.toggle("Arlettebrook-open");
    menu.classList.toggle("Arlettebrook-open");

    let ripple=floatBtn.querySelector(".Arlettebrook-ripple");
    if(!ripple){
        ripple=document.createElement("span");
        ripple.className="Arlettebrook-ripple";
        floatBtn.appendChild(ripple);
    }
    ripple.classList.remove("Arlettebrook-animate");
    void ripple.offsetWidth;
    ripple.classList.add("Arlettebrook-animate");

    requestAnimationFrame(()=>{
        items.forEach((item,i)=>{
            const rp=item.querySelector(".Arlettebrook-ripple");
            rp.classList.remove("Arlettebrook-animate");
            void rp.offsetWidth;
            setTimeout(()=> rp.classList.add("Arlettebrook-animate"), i*70);
        });
    });
});

/* ★★ 子按钮动作顺序已对应调整 ★★  
   原：其他 / 管理 / 登出
   新：登出 / 管理 / 其他
*/
const names = ["登出","管理","其他"];

items.forEach((item,i)=>{
    item.addEventListener("click",()=>{
        alert("点击：" + names[i]);
        closeMenu();
    });
});

/* 点击空白关闭 */
document.addEventListener("click",(e)=>{
    if(!menu.classList.contains("Arlettebrook-open")) return;
    if(menu.contains(e.target)||floatBtn.contains(e.target)) return;
    closeMenu();
});

/* 滑动关闭 */
let startY=0;
document.addEventListener("touchstart",e=> startY=e.touches[0].clientY);
document.addEventListener("touchmove",e=>{
    if(!menu.classList.contains("Arlettebrook-open")) return;
    if(Math.abs(e.touches[0].clientY-startY)>30) closeMenu();
});

/* 滚动隐藏按钮 */
let lastY=window.scrollY;
let ticking=false;

window.addEventListener("scroll",()=>{
    if(!ticking){
        requestAnimationFrame(()=>{
            const y=window.scrollY;

            if(y>lastY+10){
                floatBtn.classList.remove("Arlettebrook-show");
                floatBtn.classList.add("Arlettebrook-hide");
                if(menu.classList.contains("Arlettebrook-open")) closeMenu();
            }else if(y<lastY-10){
                floatBtn.classList.remove("Arlettebrook-hide");
                floatBtn.classList.add("Arlettebrook-show");
            }

            lastY=y;
            ticking=false;
        });
        ticking=true;
    }
});

```

