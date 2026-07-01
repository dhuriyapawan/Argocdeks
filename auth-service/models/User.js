const pool = require('../config/database');
const bcrypt = require('bcryptjs');

const memoryUsers = new Map();

const demoUser = {
    id: 1,
    email: 'demo@example.com',
    name: 'Demo User',
    password: bcrypt.hashSync('123456', 10)
};
memoryUsers.set(demoUser.email, demoUser);

class User {
    static async create(email, name, password) {
        try {
            const hashedPassword = await bcrypt.hash(password, 10);
            const [result] = await pool.query(
                'INSERT INTO users (email, name, password) VALUES (?, ?, ?)',
                [email, name, hashedPassword]
            );
            return result;
        } catch (error) {
            if (process.env.NODE_ENV === 'production') {
                throw error;
            }

            const user = {
                id: Date.now(),
                email,
                name,
                password: await bcrypt.hash(password, 10)
            };
            memoryUsers.set(email, user);
            return user;
        }
    }

    static async findByEmail(email) {
        try {
            const [rows] = await pool.query(
                'SELECT * FROM users WHERE email = ?',
                [email]
            );
            return rows[0];
        } catch (error) {
            if (process.env.NODE_ENV === 'production') {
                throw error;
            }
            return memoryUsers.get(email) || null;
        }
    }

    static async findById(id) {
        try {
            const [rows] = await pool.query(
                'SELECT * FROM users WHERE id = ?',
                [id]
            );
            return rows[0];
        } catch (error) {
            if (process.env.NODE_ENV === 'production') {
                throw error;
            }
            return Array.from(memoryUsers.values()).find((user) => user.id === Number(id)) || null;
        }
    }

    static async validatePassword(password, hash) {
        return bcrypt.compare(password, hash);
    }
}

module.exports = User;
