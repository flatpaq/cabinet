
// チェックボックス要素を取得
// let checkboxes = document.getElementsByName('article[tag_ids][]');
// let selectedTagsList = document.querySelector('.selected-tags-list');

// チェックされた値を格納する配列を初期化
// let checkedArray = [];

// let checkedElementsText = [];

// チェックされた値をcheckedArray配列に代入する
// function checkedElementsToArray(el) {
// 	if (el.checked) {
// 		checkedArray.push(el.value);
//     checkedElementsText.push(el.nextElementSibling.textContent);
// 	}
// }

// チェックボックスをクリックするとcheckedCheck関数が実行される
// checkboxes.forEach(function(el) {
// 	el.addEventListener('click', checkedCheck);
// 	checkedElementsToArray(el);
// });

// console.log(checkedElementsText);
// checkedElementsText.forEach(function(el) {
//   let elList = document.createElement('li');
//   // elList.classList.add('tag');
//   elList.innerHTML = `${el}`;
//   selectedTagsList.append(elList);
// });

// チェックボックスをクリックするとチェックされた要素のvalueを配列に格納する
// function checkedCheck() {
// 	checkedArray = [];
//   checkedElementsText = [];
// 	checkboxes.forEach(function(el) {
// 		checkedElementsToArray(el);
// 	});

//   selectedTagsList.textContent = '';
//   checkedElementsText.forEach(function(el) {
//     let elList = document.createElement('li');
//     elList.innerHTML = `${el}`;
//     selectedTagsList.append(elList);
//   });

// }

// body直下のdiv.shadow-wrapper
const articleFormShadowWrapper = document.querySelector('.shadow-wrapper');

// owner
const groupOwnerSelectButton = document.querySelector('#group-owner-select-button');
const groupOwnersSelectArea =document.querySelector('#group-owners-select-area');

// member
const groupMemberSelectButton = document.querySelector('#group-member-select-button');
const groupMembersSelectArea =document.querySelector('#group-members-select-area');

// 閉じるボタン、readable writable共通
const groupSelectCloseButtons = document.querySelectorAll('.group-owners-window-close-button, .group-members-window-close-button');

document.addEventListener('DOMContentLoaded', function() {

  groupOwnerSelectButton.addEventListener('click', () => {
    modalMenuOpen(groupOwnersSelectArea);
  });

  groupMemberSelectButton.addEventListener('click', () => {
    modalMenuOpen(groupMembersSelectArea);
  });

  articleFormShadowWrapper.addEventListener('click', () => {
    modalMenuClose(groupOwnersSelectArea);
    modalMenuClose(groupMembersSelectArea);
  });

  groupSelectCloseButtons.forEach((el) => {
    el.addEventListener('click', () => {
      modalMenuClose(groupOwnersSelectArea);
      modalMenuClose(groupMembersSelectArea);
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
