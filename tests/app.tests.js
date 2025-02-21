const request = require('supertest');
const app = require('../src/app');

describe('API Tests', () => {
  test('GET /health returns healthy status', async () => {
    const response = await request(app).get('/health');
    expect(response.statusCode).toBe(200);
    expect(response.body.status).toBe('healthy');
  });

  test('GET /api/greet returns greeting', async () => {
    const response = await request(app).get('/api/greet?name=John');
    expect(response.statusCode).toBe(200);
    expect(response.body.message).toBe('Hello, John!');
  });
});