class HomeController < ApplicationController
  def index
    require 'net/http'
    require 'json'

    @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=20005&distance=25&API_KEY=AB530B48-8F79-4A04-9AAC-D9A6FD3C2661'
    @uri = URI(@url)
    @response = Net::HTTP.get(@uri)
    @output = JSON.parse(@response)


    if @output.empty?
      @final_output = "Error"
    elsif !@output
      @final_output = "Error"
    else
      @final_output = @output[0]['AQI']
    end


    if @final_output == "Error"
      @api_color = "gray"
    elsif @final_output <= 50
      @api_color = "green"
      @api_description = "Good (0 - 50) Air quality is considered satisfactory and air pollution poses little or no risk."
    elsif @final_output >= 51 && @final_output <= 100
      @api_color = "yellow"
      @api_description = "Moderate (51 - 100) Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution"
    elsif @final_output >= 101 && @final_output <= 150
      @api_color = "orange"
      @api_description = "Unhealthy for Sensitive Groups (101 - 150) Although general public is not likely to be affected at this AQI range, people with lung disease, older adults and children are at a greater risk from exposure to ozone, whereas persons with heart and lung disease, older adults and children are at greater risk from the presence of particles in the air."
    elsif @final_output >= 151 && @final_output <= 200
      @api_color = "red"
      @api_description = "Very Unheathy (201 - 300) Everyone may begin to experience health effects, members of sensitive groups may experience more serious health effects."
    elsif @final_output >= 201 && @final_output <= 300
      @api_color = "purple"
      @api_description = "Health alert; everyone may experience more serious health effects."
    elsif @final_output >= 301 && @final_output <= 500
      @api_color = "maroon"
      @api_description = "Hazardous (301 - 500) Health warnings of emergency conditions. The entire population is more likely to be affected."

    end
  end

  def zipcode 
    @zip_query = params[:zipcode]

    if params[:zipcode] == ""
      @zip_query = "Hey you forgot to enter a zipcode!"
    elsif params[:zipcode]
      require 'net/http'
      require 'json'

      @url = 'https://www.airnowapi.org/aq/observation/zipCode/current/?format=application/json&zipCode=' + @zip_query.to_s + '&distance=25&API_KEY=AB530B48-8F79-4A04-9AAC-D9A6FD3C2661'
      @uri = URI(@url)
      @response = Net::HTTP.get(@uri)
      @output = JSON.parse(@response)


      if @output.empty?
        @final_output = "Error"
      elsif !@output
        @final_output = "Error"
      else
        @final_output = @output[0]['AQI']
      end


      if @final_output == "Error"
        @api_color = "gray"
      elsif @final_output <= 50
        @api_color = "green"
        @api_description = "Good (0 - 50) Air quality is considered satisfactory and air pollution poses little or no risk."
      elsif @final_output >= 51 && @final_output <= 100
        @api_color = "yellow"
        @api_description = "Moderate (51 - 100) Air quality is acceptable; however, for some pollutants there may be a moderate health concern for a very small number of people who are unusually sensitive to air pollution"
      elsif @final_output >= 101 && @final_output <= 150
        @api_color = "orange"
        @api_description = "Unhealthy for Sensitive Groups (101 - 150) Although general public is not likely to be affected at this AQI range, people with lung disease, older adults and children are at a greater risk from exposure to ozone, whereas persons with heart and lung disease, older adults and children are at greater risk from the presence of particles in the air."
      elsif @final_output >= 151 && @final_output <= 200
        @api_color = "red"
        @api_description = "Very Unheathy (201 - 300) Everyone may begin to experience health effects, members of sensitive groups may experience more serious health effects."
      elsif @final_output >= 201 && @final_output <= 300
        @api_color = "purple"
        @api_description = "Health alert; everyone may experience more serious health effects."
      elsif @final_output >= 301 && @final_output <= 500
        @api_color = "maroon"
        @api_description = "Hazardous (301 - 500) Health warnings of emergency conditions. The entire population is more likely to be affected."

       end
  
    end
  end
end
