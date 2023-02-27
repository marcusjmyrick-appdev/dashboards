class CurrenciesController < ApplicationController
  def first_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    @array_of_symbols = @symbols_hash.keys
    render({:template => "currency_templates/step_one.html.erb"})
  end

  def second_currency
    @raw_data = open("https://api.exchangerate.host/symbols").read
    @parsed_data = JSON.parse(@raw_data)
    @symbols_hash = @parsed_data.fetch("symbols")
    @array_of_symbols = @symbols_hash.keys
    @from_symbol = params.fetch("from_currency")
    render({ :template => "currency_templates/step_two.html.erb"})
  end

  def third_currency
    @origin_symbol = params.fetch("from_currency")
    @from_symbol = params.fetch("there_currency")
    @raw_data = open("https://api.exchangerate.host/convert?from=#{@origin_symbol}&to=#{@from_symbol}").read
    @parsed_data = JSON.parse(@raw_data)
    @rate = @parsed_data["info"]["rate"]

    render({ :template => "currency_templates/step_three.html.erb"})
  end
end
