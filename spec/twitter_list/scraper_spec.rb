describe TwitterList::Scraper do

  describe "when using the four tokens at once" do
    let(:tokens) {'abc|123|def|456'}
    let(:scraper) {TwitterList::Scraper.new(twitter_tokens: tokens)}

    it "assigns the consumer key correctly" do
      expect(scraper.client.consumer_key).to eq('abc')
    end

    it "assigns the consumer secret correctly" do
      expect(scraper.client.consumer_secret).to eq('123')
    end

    it "assigns the access token correctly" do
      expect(scraper.client.access_token).to eq('def')
    end

    it "assigns the access secret correctly" do
      expect(scraper.client.access_token_secret).to eq('456')
    end
  end

  describe "when using the four tokens separately" do
    let(:tokens) {{
      consumer_key: 'abc',
      consumer_secret: '123',
      access_token: 'def',
      access_token_secret: '456'
    }}
    let(:scraper) {TwitterList::Scraper.new(tokens)}

    it "assigns the consumer key correctly" do
      expect(scraper.client.consumer_key).to eq('abc')
    end

    it "assigns the consumer secret correctly" do
      expect(scraper.client.consumer_secret).to eq('123')
    end

    it "assigns the access token correctly" do
      expect(scraper.client.access_token).to eq('def')
    end

    it "assigns the access secret correctly" do
      expect(scraper.client.access_token_secret).to eq('456')
    end
  end

  describe "when getting the list of Twitter handles", :vcr do
    let(:tokens)  {ENV['TWITTER_TOKENS'].to_s}
    let(:people) {TwitterList::Scraper.new(twitter_tokens: tokens).people('lechinoise', 'politic-arg')}

    before { stub_request(:post, 'https://api.twitter.com/oauth2/token') }

    it "gets the right Twitter id" do
      expect(people.first[:id]).to eq(717802179415969792)
    end

    it "gets the right Twitter name" do
      expect(people.first[:name]).to eq('ProgresarGob')
    end

    it "gets the right Twitter handle" do
      expect(people.first[:twitter]).to eq('Progresar_Gob')
    end

    it "gets the right Twitter avatar" do
      expect(people.first[:image]).to eq('https://pbs.twimg.com/profile_images/725763187371560961/l8sRBtjN.jpg')
    end
  end

end
