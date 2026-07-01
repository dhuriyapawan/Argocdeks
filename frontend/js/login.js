const API_BASE_URLS = [
    '/api',
    'http://127.0.0.1:3000/api',
    'http://localhost:3000/api',
    'http://127.0.0.1:5000/api',
    'http://localhost:5000/api'
];

async function callAuthApi(path, options = {}) {
    let lastError;

    for (const baseUrl of API_BASE_URLS) {
        try {
            const response = await fetch(`${baseUrl}${path}`, options);
            const data = await response.json().catch(() => ({}));

            if (response.ok) {
                return { response, data };
            }

            // If the local static server is serving the page, it will reject POST /api with 501.
            // In that case, try the backend host URLs before failing completely.
            if (baseUrl === '/api' && response.status === 501) {
                continue;
            }

            return { response, data };
        } catch (error) {
            lastError = error;
        }
    }

    throw lastError || new Error('Unable to reach auth service');
}

document.getElementById('loginForm').addEventListener('submit', async (e) => {
    e.preventDefault();

    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    try {
        const { response, data } = await callAuthApi('/auth/login', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email, password })
        });

        if (response.ok && data.token) {
            localStorage.setItem('token', data.token);
            window.location.href = '/dashboard.html';
        } else {
            alert(data.message || 'Login failed. Please check your credentials.');
        }
    } catch (error) {
        console.error('Error:', error);
        alert('An error occurred. Please try again.');
    }
});
