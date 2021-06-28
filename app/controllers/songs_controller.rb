require 'rack-flash'
class SongsController < ApplicationController
    use Rack::Flash

    get '/songs' do
        @songs = Song.all
        erb :'/songs/index'
    end

    post '/songs' do
        @song = Song.create(params[:song])
        params[:genres].each do |genre|
            @song.genres << Genre.find_by(genre)
        end
        @artist = Artist.find_by(params[:artist])
        if @artist
            @song.artist = @artist
        else
            @song.artist = Artist.create(params[:artist])
        end
        @song.save
        flash[:message] = "Successfully created song."
        redirect "/songs/#{@song.slug}"
    end
    
    get '/songs/new' do
        @genres = Genre.all
        erb :'songs/new'
    end
    
    get '/songs/:slug/edit' do
        @song = Song.find_by_slug(params[:slug])
        @genres = Genre.all
        erb :'songs/edit'
    end
    
    get '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        erb :'/songs/show'
    end

    patch '/songs/:slug' do
        @song = Song.find_by_slug(params[:slug])
        @song.update(params[:song])
        @song.genres.clear
        params[:genres].each do |genre|
            @song.genres << Genre.find_by(genre)
        end
        @artist = Artist.find_by(params[:artist])
        if @artist
            @song.artist = @artist
        else
            @song.artist = Artist.create(params[:artist])
        end
        @song.save
        flash[:message] = "Successfully updated song."
        redirect "/songs/#{@song.slug}"
    end
end