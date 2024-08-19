window.onload = function () {
    let chk = document.getElementById("chk");
    let pwd = document.getElementById("password");
    let closeIcon = document.getElementById("close-icon");
    let openIcon = document.getElementById("open-icon");
    chk.onchange = function () {
        pwd.type = chk.checked ? "text" : "password";
    }

    closeIcon.onclick = function () {
        closeIcon.classList.add("d-none");
        openIcon.classList.remove("d-none");
    }

    openIcon.onclick = function () {
        openIcon.classList.add("d-none");
        closeIcon.classList.remove("d-none");
    }

}