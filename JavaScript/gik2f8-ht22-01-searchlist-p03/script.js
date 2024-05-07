'use strict';

let bookList = [];

window.addEventListener('load', () => {
  getAll().then((apiBooks) => (bookList = apiBooks));
});

searchField.addEventListener('keyup', (e) =>
  renderBookList(
    bookList.filter(({ title, author }) => {
      const searchTerm = e.target.value.toLowerCase();
      return (
        title.toLowerCase().includes(searchTerm.toLowerCase()) ||
        author.toLowerCase().includes(searchTerm.toLowerCase())
      );
    })
  )
);

function renderBookList(bookList) {
  const existingElement = document.querySelector('.book-list');

  const root = document.getElementById('root');

  existingElement && root.removeChild(existingElement);
  bookList.length > 0 && searchField.value && root.insertAdjacentHTML('beforeend', BookList(bookList));

  
  //console.log("before mouseover log");


const elements = document.querySelectorAll(".book-list__item");

//console.log(elements);

for(let i = 0; i < elements.length; i++) {
    //console.log("Mouseenter log");


    // Mouseenter event
    elements[i].addEventListener("mouseenter", (e) =>{
      //console.log("mouseenter log");
      let hoverBookDetails = getBookDetails(e.target.id)
      hoverBookDetails.then(function (result) {
        renderBookDetails(result);
      })
    });


    // Mouseleave event
    elements[i].addEventListener("mouseleave", () =>{
      const existingElement = document.querySelector(".book-details");
      existingElement && existingElement.remove();
      //console.log("inside mouseout event")
    });
  }
}

 
//console.log("after Mouseenter log");


function renderBookDetails(book){
  const existingElement = document.getElementById('bookDetail');
  const root = document.getElementById('root');

  existingElement && existingElement.remove()

  let html = BookDetails(book);

  root.insertAdjacentHTML("afterend", html);

  //console.log("inside renderBookDetails log");

}

//console.log("after renderBookDetails log");
