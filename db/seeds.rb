# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 


# Define 10 Dummy Users for Development
user_master = [
["Jack","Boy","jacky@jackal.com", "jack"],
["Bailey","Booij","bbooij1@unblog.fr", "baily"],
["Ellary","Dows","edows2@bravesites.com", "ellary"],
["Emmy","Buckthought","ebuckthought3@tinypic.com", "emmy"],
["Wylma","Screwton","wscrewton4@usda.gov", "wylma"],
["Lowell","Edelman","ledelman5@state.gov", "lowell"],
["Johnath","Ramage","jramage6@sfgate.com", "johnath"],
["Bibby","Onge","bonge7@ibm.com", "bibby"],
["Adan","Pavelin","apavelin8@house.gov", "adan"],
["Linnea","Dudson","ldudson9@163.com", "linnea"]


]

# Define 4 currencies that we will iterate over to generate a database record 
curr_master = [
    ["United States Dollar", "USD"],
    ["Sterling Pounds", "GBP"],
    ["Indian Rupee", "INR"],
    ["Emirati Dirham", "AED"]
]

#Iteratre over Each user and make a new record
user_master.each do |k|
    User.create!(
        fname: k[0],
        lname: k[1],
        email: k[2],
        username: k[3],
        password: "abcdef", # issue each user the same password
        password_confirmation: "abcdef",
        admin: false
    )
end

#Define an Admin User
User.create!(
    fname: "Admin",
    lname: "User",
    email: "admin@jackal.com",
    username:"admin",
    password: "abcdef", # issue each user the same password
    password_confirmation: "abcdef",
    admin: true
)

# Iterate over all the currencies and generate a database record
curr_master.each do |k|
    Currency.create!(
        bigname: k[0],
        shortname: k[1]
    )
end

# Outer loop is for number of Accounts and Inner Loop for the number of accounts per user
# The function below makes 20 accounts in total which are assigned to random users
(1..10).each do |k|
    (1..2).each do |u|
        Account.create!(
            curr_id: rand(1..4),
            accname: "L#{k}-#{u}JK",
            sortcode: "#{rand(10..99)}-#{rand(10..99)}-#{rand(10..99)}",
            accnumber: rand(1000000..9999999),
            user_id: rand(1..10)
        )
    end
end

(1..20).each do |single|
    Transaction.create!(
        account_id: single,
        receiver: "Initial Deposit",
        amount: -80000,
    )
end

(0..200).each do |k|
    Transaction.create!(
        account_id: rand(1..10),
        receiver: "SHOP##{rand(1..100)}-#{rand(100000..999999)}G",
        amount: rand(10..999),
    )
end

# Default Color Settings for our Header/Footer/Banner/Corona Support
Console.create!(
    footer_b: "#5E503F",
    footer_t: "#fff",
    header_b: "#5E503F",
    header_t: "#fff",
    corona_b: "#251F18",
    corona_t: "#fff",
    banner_b: "#C6AC8F",
    banner_t: "#0A0908"
)
