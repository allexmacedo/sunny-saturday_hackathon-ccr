class NotImplementedExepction extends Error {
    constructor() {
        super("Not Implemented Excepction")
    }
}

class Crud {

    create(item) {
        throw new NotImplementedExepction();
    }

    read(query) {
       throw new NotImplementedExepction();
    }

    one(query) {
        throw new NotImplementedExepction();
    }

    update(id, item) {
        throw new NotImplementedExepction();
    }

    delete(id) {
        throw new NotImplementedExepction();
    }

    isConnected() {
        throw new NotImplementedExepction();
    }

}

module.exports = Crud;