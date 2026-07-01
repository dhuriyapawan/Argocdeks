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

document.addEventListener('DOMContentLoaded', () => {
    const token = localStorage.getItem('token');

    if (!token) {
        window.location.href = '/index.html';
        return;
    }

    callAuthApi('/auth/user', {
        headers: {
            Authorization: `Bearer ${token}`
        }
    })
        .then(({ response, data }) => {
            if (!response.ok) {
                throw new Error(data.message || 'Unable to fetch user');
            }
            document.getElementById('username').textContent = data.name || 'User';
        })
        .catch((error) => {
            console.error('Error:', error);
            localStorage.removeItem('token');
            window.location.href = '/index.html';
        });

    document.getElementById('logoutBtn').addEventListener('click', () => {
        localStorage.removeItem('token');
        window.location.href = '/index.html';
    });
});
