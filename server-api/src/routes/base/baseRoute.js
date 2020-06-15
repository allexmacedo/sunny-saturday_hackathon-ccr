const user = require('../user/userRoutes');
const partner = require('../partner/partnerRoutes');
const driver = require('../driver/driverRoutes');
const auth = require('../auth/outhRoutes');
const open = require('../open/openRoutes');

module.exports = [].concat(user, partner, driver, auth, open);