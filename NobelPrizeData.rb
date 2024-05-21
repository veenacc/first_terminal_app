

##### NobelprizeData ####
# App Objective: 1) find the winners by year by category

# Steps:
  # 1: get the data from the API 
  # 2: get the data in the required format for ease of calcultaion and extraction
  # 3: design and implement interaction with user:
  #   1.1: Give user the choice of information they want to see
  # 4: Based on user choice show data

######## step1 ###########
require "http"

nobelprize= HTTP.get("https://api.nobelprize.org/v1/prize.json").parse

### data check ##############
# p nobelprize.class
# p nobelprize.keys # ["prizes"]
# p nobelprize["prizes"].class
################################

########### sample data from Api ########
# {"year"=>"2023", "category"=>"chemistry", "laureates"=>[{"id"=>"1029", "firstname"=>"Moungi", "surname"=>"Bawendi", "motivation"=>"\"for the discovery and synthesis of quantum dots\"", "share"=>"3"}, {"id"=>"1030", "firstname"=>"Louis", "surname"=>"Brus", "motivation"=>"\"for the discovery and synthesis of quantum dots\"", "share"=>"3"}, {"id"=>"1031", "firstname"=>"Aleksey", "surname"=>"Yekimov", "motivation"=>"\"for the discovery and synthesis of quantum dots\"", "share"=>"3"}]}
#############################################################################

######## step2 #################################################################
prize = []
dt=[]
nobelprize.each do |key,value|
  prize = value
end
# p prize[0]["year"]  
yr=[]
category =[]

prize.each do |record|
  details = {}
  laureate=[]
  details["year"] = record["year"]
  #yr << record["year"]  
  details["category"] = record["category"]
  #category <<record["category"]
  laureate = record["laureates"]
  len = 0
  if laureate 
    laureate.each do |i|
      # p laureate.index(i)
      details["firstname#{laureate.index(i)}"]=i["firstname"]
      details["surname#{laureate.index(i)}"]=i["surname"]  
      len+=1
    end
    details["share"]=len
  end
  #p laureate
  dt << details
end
p dt[0]
# p yr.uniq!
# p category.uniq!
##############################################################################

############## function thats takes in the input value for year and category and prints the name of the winners ################################################
def find_winner(year1, category1, dt)
  output_winners =dt.select{|nobel_prize| nobel_prize["year"] == year1 && nobel_prize["category"] == category1}
  
  if output_winners.empty?
    puts "no informtaion found"
  else
    i=0
    p "The winner of the #{category1} for the year #{year1}:"
    while i < output_winners[0]["share"]
      p output_winners[0]["firstname#{i}"] + " " + output_winners[0]["surname#{i}"]
      i+=1
    end    
  end
end
##################################################################################

######### step 3 ########################################################

puts "Welcome to data bank on nobel prizes where you can find the winners by category and year"
question = "which category would you like to find "
choice =[ "1.chemistry", "2.physics", "3.economics", "4.literature", "5.medicine","6.peace"]
puts question
choice.each {|choice| puts choice}
puts "enter number of choice"
user_input =gets.chomp
category_input=""
year_input=""
case user_input
when "1"
  category_input = "chemistry"
when "2"
  category_input = "physics"
when "3"
  category_input = "economics"  
when "4"
  category_input = "literature"
when "5"
  category_input = "medicine"
when "6"
  category_input = "physics"
else
  # puts "invalid choice"
  
  category_input =""
end

puts "Which year information would you like? - Data available from 1901 to 2023"
year_input =gets.chomp
# p category_input ,year_input

###################################################################################

####################### step 4 #######################################
# calls the function that returns the requested information
if year_input.to_i >=1901 && year_input.to_i<=2023 && category_input!= ""
  find_winner(year_input, category_input,dt)
else
  p "Enter valid year / acategory"
end
#####################################################################





