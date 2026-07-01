# Login Microservice

A complete login microservice application with frontend, authentication service, and database integration.

## Project Structure

```
login-microservice/
├── frontend/                 # Nginx-based frontend
│   ├── index.html           # Login page
│   ├── dashboard.html       # Dashboard page
│   ├── css/
│   │   └── style.css
│   ├── js/
│   │   ├── login.js
│   │   └── dashboard.js
│   └── Dockerfile
│
├── auth-service/            # Node.js authentication service
│   ├── controllers/
│   │   └── authController.js
│   ├── routes/
│   │   └── authRoutes.js
│   ├── middleware/
│   │   └── auth.js
│   ├── models/
│   │   └── User.js
│   ├── config/
│   │   └── database.js
│   ├── server.js
│   ├── package.json
│   └── Dockerfile
│
├── database/
│   └── init.sql            # Database schema
│
├── helm/                    # Helm charts (for Kubernetes deployment)
│
├── k8s/                     # Kubernetes manifests
│
└── docker-compose.yml       # Docker Compose configuration
```

## Getting Started

### Prerequisites
- Docker & Docker Compose
- Node.js (for local development)

### Run with Docker Compose

```bash
docker-compose up -d
```

This will start:
- **Frontend**: http://localhost (port 80)
- **Auth Service**: http://localhost:3000
- **MySQL Database**: localhost:3306

### API Endpoints

#### Register
```bash
POST /api/auth/register
Content-Type: application/json

{
  "email": "user@example.com",
  "name": "User Name",
  "password": "password123"
}
```

#### Login
```bash
POST /api/auth/login
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "password123"
}
```

Response:
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": 1,
    "email": "user@example.com",
    "name": "User Name"
  }
}
```

#### Get User Info
```bash
GET /api/auth/user
Authorization: Bearer <token>
```

### Database

The MySQL database is automatically initialized with the schema defined in `database/init.sql`.

**Database Credentials:**
- User: `auth_user`
- Password: `auth_password`
- Database: `auth_db`

### Development

For local development without Docker:

1. **Set up environment variables** (create `.env` in `auth-service/`):
```
DB_HOST=localhost
DB_USER=auth_user
DB_PASSWORD=auth_password
DB_NAME=auth_db
PORT=3000
JWT_SECRET=your-secret-key
```

2. **Install dependencies**:
```bash
cd auth-service
npm install
```

3. **Run the service**:
```bash
npm run dev
```

## Technologies

- **Frontend**: HTML5, CSS3, JavaScript
- **Backend**: Node.js, Express.js
- **Database**: MySQL
- **Authentication**: JWT (JSON Web Tokens)
- **Containerization**: Docker & Docker Compose
- **Orchestration**: Kubernetes (Helm & Manifests)

## License

MIT
