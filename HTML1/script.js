let isSliding = false;
let startX = 0;

const slideButton = document.getElementById('slide-button');
const sliderCover = document.getElementById('slider-cover');
const mainCard = document.getElementById('main-card');


let slideThreshold = 0;

function updateThreshold() {
    if (mainCard) {
        slideThreshold = mainCard.offsetWidth * 0.7;
    }
}


window.addEventListener('load', updateThreshold);
window.addEventListener('resize', updateThreshold);


function startSlide(event) {
    updateThreshold(); 


    if (event.type === 'mousedown') {
        event.preventDefault(); 
        document.addEventListener('mousemove', moveSlide);
        document.addEventListener('mouseup', endSlide);
        startX = event.clientX;
    } 

    else if (event.type === 'touchstart') {
        startX = event.touches[0].clientX;
    }
    
    isSliding = true;
    slideButton.style.transition = 'none'; 
    sliderCover.style.transition = 'none';
}


function moveSlide(event) {
    if (!isSliding) return;

    let currentX = 0;
    
    if (event.type === 'mousemove') {
        currentX = event.clientX;
    } else if (event.type === 'touchmove') {
        currentX = event.touches[0].clientX;
    }

    const diffX = currentX - startX;
    

    const newPosition = Math.max(0, diffX); 
    

    if (newPosition <= mainCard.offsetWidth) {
        sliderCover.style.transform = `translateX(${newPosition}px)`;
    }
}


function endSlide() {
    if (!isSliding) return;
    
    isSliding = false;
    slideButton.style.transition = 'all 0.5s ease-in-out';
    sliderCover.style.transition = 'transform 0.5s ease-in-out';
    

    const currentCoverX = sliderCover.getBoundingClientRect().left - mainCard.getBoundingClientRect().left;
    
    // Check if slide threshold (70%) cross hua hai
    if (currentCoverX >= slideThreshold) {
        // Successful slide:
        sliderCover.classList.add('slid-out');
        slideButton.style.visibility = 'hidden'; 
        console.log("Slider unlocked the form!");
        
    } else {
        // Failed slide:
        sliderCover.style.transform = 'translateX(0)';
    }

    // Mouse event listeners hata dein
    document.removeEventListener('mousemove', moveSlide);
    document.removeEventListener('mouseup', endSlide);
}


// --- Form Validation and Utility functions (Password Toggle) ---

// Password Visibility Toggle
function togglePasswordVisibility() {
    const passwordInput = document.getElementById('password');
    const confirmPasswordInput = document.getElementById('confirm-password');
    const toggleIcon = document.getElementById('toggle-icon');
    
    const newType = passwordInput.type === 'password' ? 'text' : 'password';
    passwordInput.type = newType;
    confirmPasswordInput.type = newType; 
    
    if (newType === 'text') {
        toggleIcon.classList.remove('fa-eye');
        toggleIcon.classList.add('fa-eye-slash');
    } else {
        toggleIcon.classList.remove('fa-eye-slash');
        toggleIcon.classList.add('fa-eye');
    }
}

// Basic Form Validation (Password Match)
document.getElementById('registration-form').addEventListener('submit', function(event) {
    event.preventDefault();

    const password = document.getElementById('password').value;
    const confirmPassword = document.getElementById('confirm-password').value;
    const errorMessage = document.getElementById('error-message');
    const passwordGroup = document.getElementById('password').parentNode;
    const confirmPasswordGroup = document.getElementById('confirm-password').parentNode;

    // Resetting previous state
    errorMessage.textContent = '';
    errorMessage.style.visibility = 'hidden';
    passwordGroup.style.boxShadow = 'inset 3px 3px 6px rgba(0, 0, 0, 0.4), inset -3px -3px 6px rgba(45, 45, 75, 0.6)';
    confirmPasswordGroup.style.boxShadow = 'inset 3px 3px 6px rgba(0, 0, 0, 0.4), inset -3px -3px 6px rgba(45, 45, 75, 0.6)';


    if (password !== confirmPassword) {
        errorMessage.textContent = 'Error: Passwords do not match!';
        errorMessage.style.visibility = 'visible';
        passwordGroup.style.boxShadow = 'inset 0 0 5px #ff6347';
        confirmPasswordGroup.style.boxShadow = 'inset 0 0 5px #ff6347';
        
    } else if (password.length < 8) {
        errorMessage.textContent = 'Error: Password must be at least 8 characters long.';
        errorMessage.style.visibility = 'visible';
        passwordGroup.style.boxShadow = 'inset 0 0 5px #ff6347';
    } 
    else {
        // Validation successful
        errorMessage.textContent = 'Success! Account Registered (Demo).';
        errorMessage.style.visibility = 'visible';
        errorMessage.style.color = '#00ffff'; 
        this.reset(); 
        
        // Optionally reset the slider after success
        // setTimeout(() => {
        //     sliderCover.classList.remove('slid-out');
        //     slideButton.style.visibility = 'visible';
        // }, 3000);
    }
});