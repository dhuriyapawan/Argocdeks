const appName = 'Apple Inspired App';

function initApp() {
    console.log(`${appName} initialized.`);
    const message = getWelcomeMessage();
    showMessage(message);
}

function getWelcomeMessage() {
    return `Welcome to ${appName}! Modern design, simple code.`;
}

function showMessage(text) {
    if (typeof document !== 'undefined') {
        const element = document.getElementById('app-message');
        if (element) {
            element.textContent = text;
            return;
        }
    }
    console.log(text);
}

initApp();
