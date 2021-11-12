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
            let footerEl = document.querySelector('footer');
            // let footerEl = document.querySelector('.histories-area');
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
