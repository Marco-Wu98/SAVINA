document.addEventListener('DOMContentLoaded', function () {
    // Lưu checkbox được chọn gần nhất
    let lastCheckedPrice = null;
    let lastCheckedPublisher = null;

    document.querySelectorAll('.option input[name="price"]').forEach(function (checkbox) {
        checkbox.addEventListener('click', function () {
            if (this === lastCheckedPrice && this.checked) {
                // Nếu checkbox được chọn là checkbox hiện tại và đã được chọn trước đó,
                // thì bỏ chọn checkbox này
                this.checked = false;
                lastCheckedPrice = null;
            } else {
                // Bỏ chọn checkbox đã được chọn trước đó (nếu có)
                if (lastCheckedPrice !== null) {
                    lastCheckedPrice.checked = false;
                }
                // Lưu checkbox hiện tại là checkbox được chọn gần nhất
                lastCheckedPrice = this;
            }
        });
    });

    document.querySelectorAll('.option input[name="publisher"]').forEach(function (checkbox) {
        checkbox.addEventListener('click', function () {
            if (this === lastCheckedPublisher && this.checked) {
                // Nếu checkbox được chọn là checkbox hiện tại và đã được chọn trước đó,
                // thì bỏ chọn checkbox này
                this.checked = false;
                lastCheckedPublisher = null;
            } else {
                // Bỏ chọn checkbox đã được chọn trước đó (nếu có)
                if (lastCheckedPublisher !== null) {
                    lastCheckedPublisher.checked = false;
                }
                // Lưu checkbox hiện tại là checkbox được chọn gần nhất
                lastCheckedPublisher = this;
            }
        });
    });


//     ===============================================================


    // Hàm lấy giá trị của các checkbox được chọn
    function getCheckedValues() {
        const checkedValues = [];
        const checkboxes = document.querySelectorAll('input[type="checkbox"]:checked');
        checkboxes.forEach(checkbox => {
            checkedValues.push(checkbox.value);
        });
        return checkedValues;
    }

    // Hàm để chuyển đổi giá trị của các checkbox thành tham số URL và gửi yêu cầu
    function submitFilter() {
        const checkedValues = getCheckedValues();
        let params = new URLSearchParams();

        // Xử lý giá và nhà xuất bản trong cùng một lần lặp
        checkedValues.forEach(value => {
            if (value.includes('-')) {
                const [min, max] = value.split('-');
                params.append('minPrice', min);
                params.append('maxPrice', max);
            } else {
                params.append('publisher', value);
            }
        });
        // Lấy giá trị currentSubcategory từ model
        let currentSubcategory = document.getElementById('currentSubcategory').innerText;

        // Tạo URL với các tham số
        const url = 'filter/' + currentSubcategory + '?' + params.toString();
        // Chuyển hướng đến URL mới
        window.location.href = url;

    }

    // Lắng nghe sự kiện click của nút "Lọc"
    const filterButton = document.querySelector('#filter-button');
    filterButton.addEventListener('click', () => {
        submitFilter(); // Gọi hàm submitFilter() mỗi khi nút "Lọc" được click
    });

});
