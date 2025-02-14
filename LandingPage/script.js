document.addEventListener("DOMContentLoaded", function () {
    const features = document.querySelectorAll(".feature-text");

    function checkScroll() {
        let scrollPosition = window.scrollY + window.innerHeight * 0.7; // 스크롤 위치 조정

        features.forEach((feature, index) => {
            let sectionTop = feature.getBoundingClientRect().top + window.scrollY;

            if (scrollPosition >= sectionTop) {
                feature.classList.add("active");
            } else {
                feature.classList.remove("active");
            }
        });
    }

    window.addEventListener("scroll", checkScroll);
    checkScroll(); // 초기 실행
});