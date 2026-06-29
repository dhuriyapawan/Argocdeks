# Blog Platform

A simple blog platform backend with a static frontend.

## Run locally

1. Install dependencies

```bash
cd backend
npm install
```

2. Start the server

```bash
npm run dev
```

3. Open the application

Visit `http://localhost:5000`

## Project structure

- `backend/config/db.js` - MongoDB connection
- `backend/controllers/blogController.js` - CRUD handlers
- `backend/models/Blog.js` - Blog schema
- `backend/routes/blogRoutes.js` - API routes
- `backend/public` - static client files
- `backend/app.js` - Express server entry point
