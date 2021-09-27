
// チェックボックス要素を取得
let checkboxes = document.getElementsByName('article[tag_ids][]');
let selectedTagsList = document.querySelector('.selected-tags-list');

// チェックされた値を格納する配列を初期化
let checkedArray = [];

let checkedElementsText = [];

// チェックされた値をcheckedArray配列に代入する
function checkedElementsToArray(el) {
	if (el.checked) {
		checkedArray.push(el.value);
    checkedElementsText.push(el.nextElementSibling.textContent);
	}
}

// チェックボックスをクリックするとcheckedCheck関数が実行される
checkboxes.forEach(function(el) {
	el.addEventListener('click', checkedCheck);
	checkedElementsToArray(el);
});

// console.log(checkedElementsText);
checkedElementsText.forEach(function(el) {
  let elList = document.createElement('li');
  // elList.classList.add('tag');
  elList.innerHTML = `${el}`;
  selectedTagsList.append(elList);
});

// console.log(checkedArray);

// チェックボックスをクリックするとチェックされた要素のvalueを配列に格納する
function checkedCheck() {
	checkedArray = [];
  checkedElementsText = [];
	checkboxes.forEach(function(el) {
		checkedElementsToArray(el);
	});

  selectedTagsList.textContent = '';
  // console.log(checkedElementsText);
  checkedElementsText.forEach(function(el) {
    let elList = document.createElement('li');
    // elList.classList.add('tag');
    elList.innerHTML = `${el}`;
    selectedTagsList.append(elList);
  });

}

// Tags Addアクションが成功したらチェックボックスの取得状況を更新
// TODO: documentをセレクタにしない
// document.addEventListener('ajax:success', function() {

	// Ajax後に更新されたチェックボックス要素を再取得
	// checkboxes = document.getElementsByName('article[tag_ids][]');

	// checkboxes.forEach(function(el) {
		// 一度全てのチェックを外す
		// el.checked = false;

	  // checkboxesのvalueと、checkedArrayに格納されているvalueが同じならチェックを入れる
// 		if (checkedArray.indexOf(el.value) !== -1 ) {
// 			el.checked = true;	
// 		}

// 	});

// });


// import Marked
import marked from 'marked';

// document.addEventListener('ajax:success', markedRender);

function markedRender() {
  let oldArticleContentEl = document.querySelector('#history-view-area .old-article-content');
  const oldArticleContentText = oldArticleContentEl.textContent;
  const markedRendered = marked(oldArticleContentText);
  oldArticleContentEl.innerHTML = markedRendered;

}

// Articles new, edit タグ選択画面の表示

// body直下のdiv.shadow-wrapper
const articleFormShadowWrapper = document.querySelector('.shadow-wrapper');
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
  articleFormShadowWrapper.addEventListener('click', () => {
    modalMenuClose(tagsWindowArea);
  });

  // クローズボタンを押した際もmodalMenuCloseが実行される
  closeButton.addEventListener('click', () => {
    modalMenuClose(tagsWindowArea);
  });

});

// Article edit Historyをモーダルウィンドウで表示する
const historyViewArea = document.querySelector('#history-view-area');
let historyViewCloseButton;

const indexHistoryLinks = document.querySelectorAll('.index-history-link');

document.addEventListener('DOMContentLoaded', function() {

  indexHistoryLinks.forEach(function(linkEl) {
    // モーダルを開く
    linkEl.addEventListener('click', () => {
      modalMenuOpen(historyViewArea);
    });

    linkEl.addEventListener('ajax:success', function() {
      historyViewCloseButton = document.querySelector('.history-view-close-button');
  
      // クローズボタンを押すとモーダルを閉じる
      historyViewCloseButton.addEventListener('click', () => {
        modalMenuClose(historyViewArea);
      });

      // モーダル内のmarkdownをHTMLへレンダリングする
      markedRender();
  
    });
  
  });

  // 背景をクリックするとモーダルを閉じる
  articleFormShadowWrapper.addEventListener('click', () => {
    modalMenuClose(historyViewArea);
  });


});


// readable

const reableLimitedButtons = document.querySelectorAll('.select-publish input');

const readableUsersSelectButtons = document.querySelector('.readable-users-select-buttons');

const readableUsersSelectButton = document.querySelector('#readable-users-select-button');
const readableGroupsSelectButton = document.querySelector('#readable-groups-select-button');

const readableUsersSelectArea =document.querySelector('#readable-users-select-area');
const readableGroupsSelectArea =document.querySelector('#readable-groups-select-area');


// writable

const writableSelectedButtons = document.querySelectorAll('.select-editor input');

const writableUsersSelectButtons = document.querySelector('.writable-users-select-buttons');

const writableUsersSelectButton = document.querySelector('#writable-users-select-button');
const writableGroupsSelectButton = document.querySelector('#writable-groups-select-button');

const writableUsersSelectArea =document.querySelector('#writable-users-select-area');
const writableGroupsSelectArea =document.querySelector('#writable-groups-select-area');

// 閉じるボタン、readable writable共通
const userAndGroupSelectCloseButtons = document.querySelectorAll('.users-window-close-button, .groups-window-close-button');

document.addEventListener('DOMContentLoaded', function() {

  reableLimitedButtons.forEach((limitedButton) => {

    if (limitedButton.checked && limitedButton.id == 'article_status_limited') {
      readableUsersSelectButtons.classList.add('active');
    }

    limitedButton.addEventListener('click', (el) => {    
      if (el.target.id === 'article_status_limited' ) {
        readableUsersSelectButtons.classList.add('active');
      } else {
        readableUsersSelectButtons.classList.remove('active');
      }
    });
  });

  writableSelectedButtons.forEach((selectedButton) => {

    if (selectedButton.checked && selectedButton.id == 'article_coedit_permit_selected') {
      writableUsersSelectButtons.classList.add('active');
    }

    selectedButton.addEventListener('click', (el) => {
      if (el.target.id === 'article_coedit_permit_selected' ) {
        writableUsersSelectButtons.classList.add('active');
      } else {
        writableUsersSelectButtons.classList.remove('active');
      }
    });
  });

  readableUsersSelectButton.addEventListener('click', () => {
    modalMenuOpen(readableUsersSelectArea);
  });

  readableGroupsSelectButton.addEventListener('click', () => {
    modalMenuOpen(readableGroupsSelectArea);
  });

  writableUsersSelectButton.addEventListener('click', () => {
    modalMenuOpen(writableUsersSelectArea);
  });

  writableGroupsSelectButton.addEventListener('click', () => {
    modalMenuOpen(writableGroupsSelectArea);
  });

  articleFormShadowWrapper.addEventListener('click', () => {

    modalMenuClose(readableUsersSelectArea);
    modalMenuClose(readableGroupsSelectArea);

    modalMenuClose(writableUsersSelectArea);
    modalMenuClose(writableGroupsSelectArea);

  });

  userAndGroupSelectCloseButtons.forEach((el) => {
    el.addEventListener('click', () => {

      modalMenuClose(readableUsersSelectArea);
      modalMenuClose(readableGroupsSelectArea);

      modalMenuClose(writableUsersSelectArea);
      modalMenuClose(writableGroupsSelectArea);

    });
  });

});

// モーダルオープン関数
function modalMenuOpen(modalEl) {
  articleFormShadowWrapper.classList.add('active');
  modalEl.classList.add('active');
};

// モーダルクローズ関数
function modalMenuClose(modalEl) {
  articleFormShadowWrapper.classList.remove('active');
  modalEl.classList.remove('active');
};
