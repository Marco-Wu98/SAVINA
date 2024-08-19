document.addEventListener('DOMContentLoaded', function () {
    // Update tổng giá của mỗi item sau khi load trang
    const quantityInputs = document.querySelectorAll('.quantity-input');
    const saleSpans = document.querySelectorAll('.sale');
    const totalAmounts = document.querySelectorAll('[name="totalAmount"]');

    quantityInputs.forEach((quantityInput, index) => {
        const quantity = parseInt(quantityInput.innerText);
        const sale = parseFloat(saleSpans[index].innerText.replace(/[^\d.]/g, '')); // Lấy giá trị của sale, bỏ qua các ký tự không phải số hoặc dấu chấm
        totalAmounts[index].innerText = (sale * quantity).toFixed(3); // Cập nhật giá trị của totalAmount
    });

    // Update tổng giá cần thanh toán sau khi chọn item-checkbox
    const checkboxes = document.querySelectorAll('.item-checkbox');
    const totalPriceElement = document.getElementById('total-price');
    const totalPriceVatElement = document.getElementById('total-price-vat');

    function updateTotalPrice() {
        let totalPrice = 0;
        checkboxes.forEach(function (checkbox) {
            if (checkbox.checked) {
                totalPrice += parseFloat(checkbox.getAttribute('data-price'));
            }
        });
        totalPriceElement.textContent = `${(totalPrice / 1000).toFixed(3)}`;
        totalPriceVatElement.textContent = `${(totalPrice / 1000).toFixed(3)}`; // Giả sử VAT đã bao gồm trong giá
    }

    checkboxes.forEach(function (checkbox) {
        checkbox.addEventListener('change', updateTotalPrice);
    });

    updateTotalPrice();

    // Chọn tất cả khi chọn checkbox-all
    const checkboxAll = document.getElementById('checkbox-all');
    const itemCheckboxes = document.querySelectorAll('.item-checkbox');

    checkboxAll.addEventListener('change', function () {
        itemCheckboxes.forEach(checkbox => {
            checkbox.checked = checkboxAll.checked;
        });
        updateTotalPrice();
        updateCheckoutButton();
    });

    itemCheckboxes.forEach(checkbox => {
        checkbox.addEventListener('change', function () {
            const allChecked = Array.from(itemCheckboxes).every(item => item.checked);
            checkboxAll.checked = allChecked;

            const allUnchecked = Array.from(itemCheckboxes).every(item => !item.checked);
            checkboxAll.indeterminate = !allUnchecked && !allChecked;

            updateTotalPrice();
            updateCheckoutButton();
        });
    });

    // Xử lý sự kiện khi có ít nhất 1 checkbox được chọn thì enable checkoutButton
    const checkoutButton = document.getElementById("checkout-button");

    function updateCheckoutButton() {
        let isAnyChecked = Array.from(itemCheckboxes).some(checkbox => checkbox.checked);
        checkoutButton.disabled = !isAnyChecked;
    }

    itemCheckboxes.forEach(checkbox => {
        checkbox.addEventListener("change", updateCheckoutButton);
    });

    checkboxAll.addEventListener("change", function () {
        itemCheckboxes.forEach(checkbox => {
            checkbox.checked = checkboxAll.checked;
        });
        updateCheckoutButton();
    });

    // Khởi tạo trạng thái của btn
    updateCheckoutButton();


    // Xử lý sự kiện khi người dùng chọn sản phẩm

    checkoutButton.addEventListener('click', function () {
    // Lấy ra danh sách các checkbox đã chọn
        const checkedItems = document.querySelectorAll('.item-checkbox:checked');

        // Khởi tạo mảng lưu trữ dữ liệu bookId và buyQuantity của từng mục đã chọn
        const orderData = [];

        // Lặp qua từng checkbox đã chọn để lấy dữ liệu
        checkedItems.forEach(function (checkbox) {
            const bookId = checkbox.getAttribute('data-book-id');
            const buyQuantity = checkbox.getAttribute('data-buy-quantity');
            orderData.push({bookId: bookId, buyQuantity: buyQuantity});
        });

        // Nếu có ít nhất một mục được chọn
        if (orderData.length > 0) {
            // Lấy ra input hidden trong form
            const bookIdInput = document.getElementById('bookId');
            const buyQuantityInput = document.getElementById('buyQuantity');

            // Đặt giá trị cho input hidden
            bookIdInput.value = orderData.map(item => item.bookId).join(',');
            buyQuantityInput.value = orderData.map(item => item.buyQuantity).join(',');

            // Submit form
            document.getElementById('checkout-form').submit();
        }
    })

    // const decrementButton = document.querySelector('.decrement');
    // const incrementButton = document.querySelector('.increment');
    // const quantityInput = document.querySelector('.quantity-input');
    //
    // decrementButton.addEventListener('click', function () {
    //     let currentValue = parseInt(quantityInput.innerText);
    //     if (currentValue > 1) {
    //         quantityInput.innerText = currentValue - 1;
    //     }
    // });
    //
    // incrementButton.addEventListener('click', function () {
    //     let currentValue = parseInt(quantityInput.innerText);
    //     quantityInput.innerText = currentValue + 1;
    // });
});
