
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

// Tags Addアクションが成功したら
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

document.addEventListener('ajax:success', markedRender);

function markedRender() {
  let oldArticleContentEl = document.querySelector('#history-view-area .old-article-content');
  const oldArticleContentText = oldArticleContentEl.textContent;
  const markedRendered = marked(oldArticleContentText);
  oldArticleContentEl.innerHTML = markedRendered;  

}



// --------------------------
// Articles new, edit タグ選択画面の表示


// body直下のdiv.wrapper

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
// ---------------



// Article edit Historyをモーダルウィンドウで表示する

const historyViewArea = document.querySelector('#history-view-area');

// closeボタンはajaxが走るごとに新規に作成されるためこのコードでは動かない
let historyViewCloseButton;


const indexHistoryLink = document.querySelectorAll('.index-history-link');

document.addEventListener('DOMContentLoaded', function() {

  indexHistoryLink.forEach(function(linkEl) {
    // モーダルを開く
    linkEl.addEventListener('click', () => {
      modalMenuOpen(historyViewArea);
    });

  });


  document.addEventListener('ajax:success', function() {
    historyViewCloseButton = document.querySelector('.history-view-close-button');

    // クローズボタンを押した際もmodalMenuCloseが実行される
    historyViewCloseButton.addEventListener('click', () => {
      modalMenuClose(historyViewArea);
    });

  });

  // モーダルを閉じる
  articleFormShadowWrapper.addEventListener('click', () => {
    modalMenuClose(historyViewArea);
  });


});


// ---------------




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
