document.addEventListener("DOMContentLoaded", function () {
    const featureTexts = document.querySelectorAll(".feature-text span");
    let currentIndex = 0;

    function updateFeatureText() {
        featureTexts.forEach((text, index) => {
            if (index === currentIndex) {
                text.classList.add("active");
            } else {
                text.classList.remove("active");
            }
        });

        currentIndex = (currentIndex + 1) % featureTexts.length;
    }

    setInterval(updateFeatureText, 2000); // 2초마다 강조 변경
});