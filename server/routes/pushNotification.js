const pushNotificationController = require('../controllers/push-notifications.controller');
const express = require('express');
const pushNotiRouter = express.Router();

pushNotiRouter.get('/sendNotification', pushNotificationController.sendNotification);
pushNotiRouter.post('/sendNotificationToDevice', pushNotificationController.sendNotificationToDevice);

module.exports = pushNotiRouter;