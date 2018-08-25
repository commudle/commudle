class HomeController < ApplicationController


  def home

    @upcoming_events = Event.upcoming

  end



end
