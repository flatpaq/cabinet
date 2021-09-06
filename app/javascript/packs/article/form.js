
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
document.addEventListener('ajax:success', function() {

	// Ajax後に更新されたチェックボックス要素を再取得
	checkboxes = document.getElementsByName('article[tag_ids][]');

	checkboxes.forEach(function(el) {
		// 一度全てのチェックを外す
		el.checked = false;

	  // checkboxesのvalueと、checkedArrayに格納されているvalueが同じならチェックを入れる
		if (checkedArray.indexOf(el.value) !== -1 ) {
			el.checked = true;	
		}

	});

});



