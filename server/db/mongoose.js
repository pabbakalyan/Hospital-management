var mongoose = require ('mongoose');


mongoose.Promise = global.Promise;

//change the database with yours
mongoose.connect('mongodb://username:password@ds145220.mlab.com:45220/database', { useNewUrlParser: true, useUnifiedTopology: true });

module.exports = {mongoose};

