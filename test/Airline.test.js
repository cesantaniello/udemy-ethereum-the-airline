const Airline = artifacts.require('Airline');

let instance;

beforeEach(async () => {
    instance = await Airline.new();
});

contract('Airline', accounts => {
    it('should have available flights', async() => {
        let total = await instance.totalFlights();
        assert(total > 0);
    });
});
