require_relative '../lib/dark_trader'

describe "Crypto Scrapper methods" do
    let(:url) { 'https://coinmarketcap.com/all/views/all/' }

    describe "the scrap_names method" do
        it "should return an array of crypto names" do
            expect(scrap_names(url)).to be_an(Array)
        end
    end

    describe "the scrap_prices method" do
        it "should return an array of crypto prices" do
            expect(scrap_prices(url)).to be_an(Array)
        end
    end

    describe "the create_crypto_data method" do
        it "should return a hash with crypto names and prices" do
            expect(create_crypto_data(url)).to be_a(Hash)
        end
    end
end