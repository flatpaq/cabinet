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



// Article Showでの表示

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


// MarkdownをHTMLにレンダリング
document.addEventListener('DOMContentLoaded', markedRender);

function markedRender() {
  let articleContentEl = document.querySelector('.article-content');
  const articleContentText = articleContentEl.textContent;
  const markedRendered = marked(articleContentText);
  articleContentEl.innerHTML = markedRendered;  

}

// body直下にあるモーダル用のシャドウ
const shadowWrapper = document.querySelector('.shadow-wrapper');

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


// UsersShow 記事のタブ切り替え
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
