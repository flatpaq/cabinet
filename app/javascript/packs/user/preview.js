

if (document.URL.match(/(new|edit)/)){

  document.addEventListener('DOMContentLoaded', () => {


    const createImageHTML = (blob) => {  
      const imageElement = document.getElementById('new-image');
      const blobImage = document.createElement('img'); 
      blobImage.setAttribute('class', 'new-img') 
      blobImage.setAttribute('src', blob); 

      imageElement.appendChild(blobImage);

    }; 


    document.getElementById('user_user_image').addEventListener('input', (e) => {

      const imageContent = document.querySelector('.new-img'); 

      if (imageContent){ 
        imageContent.remove(); 
      } 

      // console.log(e);
      const file = e.target.files[0];  
      const blob = window.URL.createObjectURL(file); 
      createImageHTML(blob);

    });

  });


}

