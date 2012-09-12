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

    @songs = []
    
    @chord_page_links = []
    agent = Mechanize.new
    @page = agent.get(page_url)

    until @page == nil
      puts "loop"
      table = @page.search('table[cellspacing="0"][cellpadding="2"]')
      table.css('tr').each do |row|
        next if row.css('td:nth-child(3)').blank?
        
        if row.css('td:nth-child(3)').text == "Chords"
          #row.css('td:nth-child(1) > a').each{|link| @chords << link['href']}
          @chord_page_links << row.css('td:nth-child(1) > a').attr('href').text
        end
      end
      
      if @page.link_with(:text => /^Next/) != nil
        @page = @page.link_with(:text => /^Next/).click
      else
        @page = nil
      end

    end  
  

    #@chords = @chords.split(/\s\S\s\s/)
    @chord_page_links.each do |song_link|
      test_page = agent.get(song_link)
      title = test_page.search('td.fs-10 h1').text
      chords = []
      pre_div = test_page.search('pre').css('span').each do |chord|
        chords << chord.text
      end 
      chords.uniq!

      @songs << [title, chords]
    end

    
    


    #   @chords << node.text
    # end

  end

end