import Rails from '@rails/ujs';


// import bootstrap icons
// application.jsに移したが、それが最適なのかはよくわからない
// import "bootstrap-icons/font/bootstrap-icons.css";


// ---------------
// 以下 article/form.jsに移した方がよさそう?


// import inline attachment
import "inline-attachment/src/inline-attachment";
import "inline-attachment/src/codemirror-4.inline-attachment";

// import simpleMDE
import SimpleMDE from 'simplemde';
import 'simplemde/dist/simplemde.min.css';

window.onload = function() {

  const simplemde = new SimpleMDE({
    element: document.querySelector('.mde'),
    insertTexts: {
      // horizontalRule: ["", "\n\n-----\n\n"],
      // image: ["![](http://", ")"],
      // link: ["[", "](http://)"],
      table: ["", "\n\n| Column 1 | Column 2 | Column 3 |\n| -------- | -------- | -------- |\n| Text     | Text      | Text     |\n\n"],
    },
    // display table icon
    showIcons: ["table"],
    autofocus: true,
    spellChecker: false,
    forceSync: true,

    // to be customed
    // toolbar: [
    //   {
    //       name: "bold", // 機能名
    //       action: "toggleBold", // アクションハンドラ?
    //       //className: "fa fa-bold", // アイコン
    //       className: "bi bi-type-bold",
    //       title: "Bold" // 説明
    //   }
    // ]

  });

  // エディタに画像がドラッグ&ドロップされた際の処理
  inlineAttachment.editors.codemirror4.attach(simplemde.codemirror, {
    uploadUrl: "/articles/attach", // POSTする宛先Url
    uploadFieldName: "image", // ファイルのフィールド名(paramsで取り出す時のkey)
    allowedTypes: ['image/jpeg', 'image/png', 'image/jpg', 'image/gif'],
    extraHeaders: { "X-CSRF-Token": Rails.csrfToken() }, // CSRF対策
  });

};



// article.form.jsへ移す予定終了範囲
// ------------------



// showでの表示

// import Marked
import marked from 'marked';

// Preview Markdown to HTML with SimpleMde PreviewRender mode
marked.setOptions({
  // renderer: new marked.Renderer(),
  // highlight: function(code, language) {
  //   const hljs = require('highlight.js');
  //   const validLanguage = hljs.getLanguage(language) ? language : 'plaintext';
  //   return hljs.highlight(validLanguage, code).value;
  // },
  // pedantic: false,
  // gfm: true,
  breaks: true,
  // sanitize: true, // deprecated
  // smartLists: true,
  // smartypants: false,
  // xhtml: false
});


document.addEventListener('DOMContentLoaded', markedRender);

function markedRender() {
  let articleContentEl = document.querySelector('.article-content');
  const articleContentText = articleContentEl.textContent;
  const markedRendered = marked(articleContentText);
  articleContentEl.innerHTML = markedRendered;  

}



// get content editing
// simplemde.value();

// 使えなかった simplemde.options.previewRender(<%= @article.content %>);

// sanitizeHtmlはerrorになるのでやめる
// import sanitizeHtml from 'sanitize-html';

// DOMPurifyはOKだけどあってもなくても変わらないような...オプション調べる
// import DOMPurify from 'dompurify';

// const markedRendered = marked(DOMPurify.sanitize(articleContentText));
// console.log(DOMPurify.sanitize(articleContentText));



// --------------------------
// Articles new, edit タグ選択画面の表示


// body直下のdiv.wrapper

const shadowWrapper = document.querySelector('.shadow-wrapper');

// クローズボタン .tag-select-areaのなかに書く
const closeButton = document.querySelector('.tags-window-close-button');

// クリックするボタン
const openButton = document.querySelector('.add-tag-to-article');

// タグ選択エリア はじめは非表示にしておく
const tagsWindowArea = document.querySelector('.tags-window-area');


document.addEventListener('DOMContentLoaded', function() {

  // モーダルを開く
  openButton.addEventListener('click', () => {
    modalMenuOpen(tagsWindowArea);
  });

  // モーダルを閉じる
  shadowWrapper.addEventListener('click', () => {
    modalMenuClose(tagsWindowArea);
  });

  // クローズボタンを押した際もmodalMenuCloseが実行される
  closeButton.addEventListener('click', () => {
    modalMenuClose(tagsWindowArea);
  });

});
// ---------------



// サイドバーのスライド
document.addEventListener('DOMContentLoaded', function() {
  const sidebarMenuToggleButton  = document.querySelector('.sidebar-menu-toggle-btn');
  const wrapperRow = document.querySelector('.wrapper > .row');
  sidebarMenuToggleButton.addEventListener('click', function() {
    wrapperRow.classList.toggle('close-sidebar');
  });
});


// ヘッダーのユーザーメニュー表示切り替え
const headerMenuUser  = document.querySelector('.header-menu-user');
const headerMenuList = document.querySelector('.header-menu');

document.addEventListener('DOMContentLoaded', function() {

  headerMenuUser.addEventListener('click', () => {
    headerMenuList.classList.add('open');
    shadowWrapper.classList.add('open');
  });
  shadowWrapper.addEventListener('click', () => {
    headerMenuList.classList.remove('open');
    shadowWrapper.classList.remove('open');
  });

});

// モバイル時のサイドバーのスライド

const mobileSidebar = document.querySelector('.sidebar');
const mobileSidebarButton = document.querySelector('.mobile-sidebar-button');
const mobileSidebarCloseButton = document.querySelector('.mobile-sidebar-close-button');



// mobileSidebarButton.addEventListener('click', function() {
//   mobileSidebar.classList.add('active');
// });

document.addEventListener('DOMContentLoaded', function() {
  // モーダルを開く
  mobileSidebarButton.addEventListener('click', () => {
    modalMenuOpen(mobileSidebar);
    mobileSidebarCloseButton.classList.add('active');
  });

  // モーダルを閉じる
  shadowWrapper.addEventListener('click', () => {
    modalMenuClose(mobileSidebar);
    mobileSidebarCloseButton.classList.remove('active');
  });

  // クローズボタンを押した際もmodalMenuCloseが実行される
  mobileSidebarCloseButton.addEventListener('click', () => {
    modalMenuClose(mobileSidebar);
    mobileSidebarCloseButton.classList.remove('active');
  });

});



// モーダルオープン関数
function modalMenuOpen(modalEl) {
  shadowWrapper.classList.add('active');
  modalEl.classList.add('active');
};

// モーダルクローズ関数
function modalMenuClose(modalEl) {
  shadowWrapper.classList.remove('active');
  modalEl.classList.remove('active');
};







// モバイル時のサイドバーにあるユーザーメニューのアコーディオン
document.addEventListener('DOMContentLoaded', function() {
  // const bodyWrapper = document.querySelector('.wrapper');
  const mobileUserMenu  = document.querySelector('.mobile-user-menu-info');
  const mobileMenuList = document.querySelector('.mobile-user-menu');
  const mobileUserMenuButton = document.querySelector('.mobile-user-menu-button');

  mobileUserMenu.addEventListener('click', function() {
    mobileMenuList.classList.toggle('open');
    mobileUserMenuButton.classList.toggle('open');
  });

});











// UsersShowでのタブ切り替え
document.addEventListener('DOMContentLoaded', function() {

  let tabIndex = 0;
  const tabs = document.querySelectorAll('.tabs > .tab');
  const tabContents = document.querySelectorAll('.tab-contents-area > .tab-cont');

  tabs.forEach(function(tab, index) {

    tab.addEventListener('click', function(el) {

      tabs.forEach(function(allTab) {
        allTab.classList.remove('active');
      });

      el.target.classList.add('active');

      
      tabIndex = index;

      tabContents.forEach(function(tabCont) {
        tabCont.classList.remove('active');
      });
      tabContents[tabIndex].classList.add('active');
      
    });

  });

});



// Article ShowでのTable of Contents
document.addEventListener('DOMContentLoaded', setToc);
function setToc() {
  let idcount = 1;
  let toc = '';
  let currentlevel = 1;
  let tocEls = document.querySelectorAll('.article-content h1, .article-content h2, .article-content h3, .article-content h4, .article-content h5, .article-content h6');
  tocEls.forEach(function(el) {
    // console.log(el.nodeName);
    let level = 1;
    if(el.tagName === 'H1') {
      level = 2;
    } else if(el.tagName === 'H2') {
      level = 3;
    } else if(el.tagName === 'H3') {
      level = 4;
    } else if(el.tagName === 'H4') {
      level = 5;
    } else if(el.tagName === 'H5') {
      level = 6;
    } else if(el.tagName === 'H6') {
      level = 7;
    }
    while(currentlevel < level) {
      toc += `<ol>`;
      currentlevel++;
    }
    while(currentlevel > level) {
      toc += `</ol>`;
      currentlevel--;
    }
    el.id = `heading-num${idcount}`;
    el.className = "headings";
    idcount++;
    toc += `<li><a href="#${el.id}" class="toc-link">${el.textContent}</a></li>\n`;
  });
  while(currentlevel > 0) {
    toc += `</ol>`;
    currentlevel--;
  }
  if(document.querySelectorAll('.article-content article h2')) { 
    document.getElementById('toc').innerHTML = toc;
  } 
  else{
    document.getElementById('toc').setAttribute('class', 'no-toc');
  }
}

// Smooth Scroll
document.addEventListener('click', el => {
  const link = el.target;
  if (!link.classList.contains('toc-link')) return;
  el.preventDefault();
  const targetId = link.hash;
  const targetElement = document.querySelector(targetId);
  const headRoom = targetElement.getBoundingClientRect().top;
  const offsetTop = window.pageYOffset;
  const marginTop = 104;
  // const marginTop = 0;
  const top = headRoom + offsetTop - marginTop;
  window.scrollTo({
    top,
    behavior: "smooth"
  });
});

// Scroll Spy
document.addEventListener('DOMContentLoaded', activeBar);
function activeBar() {

  let tocActiveEl = [];
  let rect = [];
  let elPosition = [];
  let elHeight = [];
  let tocLink = [];
  let scrollAmount = 0;

  const buffer = 105;
  // const buffer = 64;

  tocActiveEl = document.querySelectorAll('.article-content h1, .article-content h2, .article-content h3, .article-content h4, .article-content h5, .article-content h6');
  for (let i = 0; i < tocActiveEl.length; i++) {
    tocLink[i] =  document.querySelector(`.toc-sidebar a.toc-link[href="#${tocActiveEl[i].id}"]`);
  }

  let flug = true;

  function timefunc() {

    if(flug){

      flug = false;
  
      setTimeout(function() {

        // get scroll amount
        scrollAmount = window.pageYOffset;

        for (let i = 0; i < tocActiveEl.length; i++) {

          // get relative Y coordinates of each Element
          rect[i] = tocActiveEl[i].getBoundingClientRect().top;
          // absolute position of each Element obtained getBoundingClientRect plus window.pageYOffset
          elPosition[i] = rect[i] + scrollAmount - buffer;
        }
        for (let i = 0; i < tocActiveEl.length; i++) {
          elHeight[i] = elPosition[i+1] - elPosition[i];

          if(tocActiveEl[tocActiveEl.length - 1]) {
            let footerEl = document.querySelector('.histories-area');
            let footerRect = footerEl.getBoundingClientRect().top;
            let footerPosition = footerRect + scrollAmount;
            elHeight[elHeight.length - 1] = footerPosition - elPosition[elPosition.length - 1];
          }
          if ( (scrollAmount > elPosition[i]) && (elHeight[i] > scrollAmount - elPosition[i]) ) {
            tocLink[i].classList.add("active");
          } else {
            tocLink[i].classList.remove("active");
          }
        }

        flug = true;
        return flug;

      }, 200);
    }
  }

  document.addEventListener('scroll', timefunc);
}
