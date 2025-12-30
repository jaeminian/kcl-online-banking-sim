## Authors: Ayan Ahmad (K19002255), Kevin Quah (k1921877), Jae Min An (k19034574), Daniela Stanciu (k1922053), Mihaela Peneva (k19026170) 

module TransactionAdminsHelper
    # Takes in the ID of the currency and return an array of local shops for fake transactions
    def get_receivers id_country
        # Common Shop Names
        common_shop_names = ["McDonalds FNB Trading LLC", "Apple Inc.",
        "Nike Inc", "Nandos FNB Company Trading LLC", "Local Store 24/7", "Uber Eats LLC"]

        if id_country == 2
            #Korean Shop Names
            specific_shop = ["Burger King Seoul", "Loteria Yeoeuido-Dong", "Maebong - Travel", "GS25"]
            @receivers = common_shop_names + specific_shop
        elsif(id_country == 5)
            #Indian Shop Names
            specific_shop = ["Big Bazaar", "Olives Khan Market",
            "Big Chill Nehru Place", "Golgappa Wala"]
            @receivers = common_shop_names + specific_shop
        elsif(id_country == 4)
            #Bulgarian Shop Names
            specific_shop = ["Grand Foods Saborna","Shtastlivetsa Sofia","Skapto Iskar","Serdika Center"]
            @receivers = common_shop_names + specific_shop
        elsif(id_country == 3)
            #Romainain Shop Names
            specific_shop = ["Profi City","Magazinul Faptelor Bune","Sushi Room Stefan 25","Spitual Monza Vatra Luminosa"]
            @receivers = common_shop_names + specific_shop
        elsif(id_country == 1)
            #British Shop Names
            specific_shop = ["Sushi Samba London","Tesco UK","Boots","Bens Cookies"]
            @receivers = common_shop_names + specific_shop
        else
            #If it is any other currency just add Common Shop Names
            specific_shop = ["Convenience Store","Masks - Local Hospital","Charity Spend - Local","Home Delivery - Convenience Store"]
            @receivers = common_shop_names + specific_shop
        end
    
    end
end
