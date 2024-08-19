document.addEventListener('DOMContentLoaded', function () {
    const decrementButton = document.querySelector('.decrement');
    const incrementButton = document.querySelector('.increment');
    const quantityInput = document.querySelector('.quantity-input');
    const stockQuantity = parseInt(document.querySelector('#stockQuantity').innerText);

    decrementButton.addEventListener('click', function () {
        let currentValue = parseInt(quantityInput.innerText);
        if (currentValue > 1) {
            quantityInput.innerText = currentValue - 1;
        }
    });

    incrementButton.addEventListener('click', function () {
        let currentValue = parseInt(quantityInput.innerText);
        if (currentValue < stockQuantity) {
            quantityInput.innerText = currentValue + 1;
        }
    });

    // Xử lý text trong description
    var descriptionElement = document.getElementById("description");
    var text = descriptionElement.innerHTML;

    // Replace periods followed by a space or end of line with a period and a <br> tag
    var formattedText = text.replace(/\. /g, '.<br><br>');

    descriptionElement.innerHTML = formattedText;

    // Xử lý menu__detail không hiện khi menu:hover (do chồng chéo JS)
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

    // Xử lý sự kiện khi người dùng ấn "Thêm vào giỏ hàng"
    const addBtn = document.getElementById("addBtn");
    addBtn.addEventListener('click', function () {
        const bookId = document.getElementById("bookId").innerText;
        const quantity = quantityInput.innerText;
        // Tạo URL dựa trên bookID và quantity
        var addToCartUrl = 'addToCart/' + bookId + '/' + quantity;

        // Hiển thị modal
        var successModal = new bootstrap.Modal(document.getElementById('successModal'), {
            keyboard: false
        });
        successModal.show();

        // Chuyển hướng sau 2 giây
        setTimeout(function () {
            window.location.href = addToCartUrl;
        }, 2000);
    });

    // Xử lý sự kiện khi người dùng ấn "Mua ngay"
    const buyBtn = document.getElementById("buyBtn");
    buyBtn.addEventListener('click', function () {
        const bookId = document.getElementById("bookId").innerText;
        const quantity = quantityInput.innerText;
        // Tạo URL dựa trên bookID và quantity
        var addToCartUrl = 'buy/' + bookId + '/' + quantity;
        window.location.href = addToCartUrl;
    });

});
