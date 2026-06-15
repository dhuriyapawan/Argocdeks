// applications/frontend/src/app.js

document.addEventListener("DOMContentLoaded", () => {
    const rideForm = document.getElementById("ride-form");
    
    if (rideForm) {
        rideForm.addEventListener("submit", (e) => {
            e.preventDefault();
            
            const btn = rideForm.querySelector("button");
            const originalText = btn.textContent;
            
            btn.textContent = "Connecting to Dispatch...";
            btn.style.opacity = "0.7";
            btn.disabled = true;
            
            setTimeout(() => {
                alert("Driver found! Driver John (Tesla Model 3, Green) is on his way to Downtown Terminal.");
                btn.textContent = originalText;
                btn.style.opacity = "1";
                btn.disabled = false;
            }, 1500);
        });
    }
});
