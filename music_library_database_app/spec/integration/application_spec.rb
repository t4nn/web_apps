require "spec_helper"
require "rack/test"
require_relative "../../app"

def reset_albums_table
  seed_sql = File.read("spec/seeds/albums_seeds.sql")
  connection = PG.connect({ host: "127.0.0.1", dbname: "music_library_test" })
  connection.exec(seed_sql)
end

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do
    reset_albums_table
  end

  it "posts a new album" do
    response = post("/albums", title: "Bad Bunny", release_year: 2020, artist_id: 1)

    expect(response.status).to eq(200)
    expect(response.body).to eq ""
    response = get("/albums")
    expect(response.body).to include "Bad Bunny"
  end

  it "returns a list of albums" do
    response = get("/albums")
    expect(response.status).to eq(200)
    expect(response.body).to include "Ring Ring"
    expect(response.body).to include "Doolittle"
  end

  it "returns list of artists" do
    response = get("/artists")
    expect(response.status).to eq(200)
    expect(response.body).to include "Pixies"
    expect(response.body).to include "ABBA"
    expect(response.body).to include "Taylor Swift"
    expect(response.body).to include "Nina Simone"
  end

  it "posts a new artist" do
    response = post("/artists", name: "Wild nothing", genre: "Indie")
    expect(response.status).to eq(200)
    expect(response.body).to eq ""
    response = get("/artists")
    expect(response.status).to eq(200)
    expect(response.body).to include "Wild nothing"

  end
end
