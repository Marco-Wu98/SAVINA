window.onload = function () {
    const menuElements = document.querySelectorAll('.menu');
    const menuDetailElements = document.querySelectorAll('.menu__detail');

    menuElements.forEach((menuElement, index) => {
        const menuDetailElement = menuDetailElements[index];

        // Initially hide the menu detail element
        menuDetailElement.style.display = 'none';

        menuElement.addEventListener('mouseover', () => {
            menuDetailElement.style.display = 'block'; // Show on mouseover
        });

        menuDetailElement.addEventListener('mouseover', () => {
            menuDetailElement.style.display = 'block'; // Redundant event listener, can be removed
        });

        menuElement.addEventListener('mouseout', () => {
            if (!menuDetailElement.contains(event.relatedTarget)) {
                menuDetailElement.style.display = 'none'; // Hide on mouseout
            }
        });

        menuDetailElement.addEventListener('mouseout', () => {
            if (!menuDetailElement.contains(event.relatedTarget)) {
                menuDetailElement.style.display = 'none'; // Redundant event listener, can be removed
            }
        });
    });

    // xử lý sự kiện khi ấn vào nút search >> chuyển hướng đến /search/{keyword}
    const searchBar = document.querySelector('#search-bar');
    const searchBtn = document.querySelector('#search-btn');
    const handleSearch = () => {
        let keyword = searchBar.value;
        if (keyword === '') {
            keyword = '_';
        }
        const url = 'search/' + keyword;
        window.location.href = url;
    };

    searchBtn.addEventListener('click', handleSearch);

    searchBar.addEventListener('keydown', (event) => {
        if (event.key === 'Enter') {
            handleSearch();
        }
    });
}
