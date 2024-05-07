/* Här ska HTML-kod finnas för att rendera hover-ruta */

const BookDetails = (book) => {
    let html = 
    `
    <div id = "bookDetail" class = "book-details bg-white/50 p-2 m-2 rounded w-1/5 ml-2 top-24 mx-auto flex flex-col text-center absolute ">
        <img class = "Image" src = "${book.coverImage}" alt = "Omslag saknas för denna bok. :(" >

        <div class= "border-t-2 border-lime-600 py-3 my-3">
    
        <div class= "book_detail">
            <ul class= "book_detail_list book-list bg-white/50 rounded-md border-2 border-blue-400 bg-white w-full mx-auto">
                <li class= "book_detail_list_item"> Author: ${book.author} </li>
                <li class= "book_detail_list_item"> Title: ${book.title} </li>
                <li class= "book_detail_list_item"> Pages: ${book.pages} </li>
                <li class= "book_detail_list_item"> Release date: ${book.releaseDate} </li>
            </ul>
        </div>
    </div>
    
    `;

    return html;
};

// book-details bg-white/50 p-2 m-2 rounded w-1/5 top-1/4 ml-2 mx-auto flex flex-col text-center justify-end absolute 