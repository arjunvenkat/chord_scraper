class PagesController < ApplicationController
require 'open-uri'  


  def search
  
  end
  
  def results
    # page_url = params['page_url']
    # 
    # #manual parsing
    # @page = open(page_url).read
    # 
    # #nokogiri parsing
    # doc = Nokogiri::HTML(open(page_url))
    # @chords = []
    # doc.css('div#cont span').each do |node|
    #   @chords << node.text
    # end
    # @chords.uniq!
    
    #@chords = @chords.scan(/\w+/)
    
    page_url = params['page_url']
    
    @chords = []
    agent = Mechanize.new
    agent.get(page_url) do |page|
      table = page.search('table[cellspacing="0"][cellpadding="2"]')
      table.css('tr').each do |row|
        next if row.css('td:nth-child(3)').blank?
        
        if row.css('td:nth-child(3)').text == "Chords"
          #row.css('td:nth-child(1) > a').each{|link| @chords << link['href']}
          @chords << row.css('td:nth-child(1) > a').attr('href').text
        end
      end
      

    end 
    #@chords = @chords.split(/\s\S\s\s/)

  end

end