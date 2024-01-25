require_relative '../lib/Mairie_Christmas'

describe "get_townhall_urls and get_townhall_email methods" do
    context "when getting townhall URLs" do
      it "should return a hash of townhall names and URLs" do
        val_doise_url = "https://www.annuaire-des-mairies.com/val-d-oise.html"
        townhall_urls = get_townhall_urls(val_doise_url)
  
        expect(townhall_urls).to be_a(Hash)
        expect(townhall_urls).not_to be_empty
      end
    end

    context "when getting townhall emails" do
      it "should return the email linked to townhall URL" do
        townhall_url = "https://www.annuaire-des-mairies.com/95/avernes.html"
        email = get_townhall_email(townhall_url)
  
        expect(email).to eq('mairie.avernes@orange.fr')
      end
    end
end