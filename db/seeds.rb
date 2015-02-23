User.create!([
  {email: "test@gmail.com", password: "12121212", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 3, current_sign_in_at: "2015-02-23 07:19:51", last_sign_in_at: "2015-02-23 05:52:24", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", status: nil, username: nil, cash: "9378.41", total: "10001.81"},
  {email: "test2@gmail.com", password: "12121212", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-02-23 07:18:46", last_sign_in_at: "2015-02-23 07:18:46", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", status: nil, username: nil, cash: "8203.44", total: "9949.07"},
  {email: "test3@gmail.com", password: "12121212", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-02-23 13:17:30", last_sign_in_at: "2015-02-23 13:17:30", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", status: nil, username: nil, cash: "10000.0", total: "10000.0"},
  {email: "test4@gmail.com", password: "12121212", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 1, current_sign_in_at: "2015-02-23 13:17:56", last_sign_in_at: "2015-02-23 13:17:56", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", status: nil, username: nil, cash: "10000.0", total: nil}
])
Buy.create!([
  {user_id: 1, stock_id: 1, price: "60.0", numofstock: 2},
  {user_id: 1, stock_id: 1, price: "10.0", numofstock: 2},
  {user_id: 1, stock_id: 1, price: "10.0", numofstock: 2},
  {user_id: 2, stock_id: 1, price: "10.0", numofstock: 2},
  {user_id: 1, stock_id: 9, price: "50.0", numofstock: 3},
  {user_id: 1, stock_id: 9, price: "34.0", numofstock: 2},
  {user_id: 1, stock_id: 1, price: "54.0", numofstock: 3},
  {user_id: 2, stock_id: 1, price: "56.0", numofstock: 2}
])
MarketEvent.create!([
  {stock_id: 1, eventname: "Intel releases new products for holiday season", event_type: 1, event_turn: 3, event: 2, event_done: 1},
  {stock_id: 2, eventname: "Infy releases new products for holiday season", event_type: 1, event_turn: 3, event: 2, event_done: 1},
  {stock_id: 3, eventname: "CEO of Dell sacked", event_type: 0, event_turn: 3, event: 2, event_done: 1},
  {stock_id: 4, eventname: "LG set to expand globally", event_type: 1, event_turn: 3, event: 1, event_done: 1},
  {stock_id: 10, eventname: "ESAT acquires Delta", event_type: 0, event_turn: 3, event: 3, event_done: 1},
  {stock_id: 6, eventname: "Delta acquired by ESAT", event_type: 1, event_turn: 3, event: 3, event_done: 1},
  {stock_id: 12, eventname: "Apple plans to split stocks", event_type: 1, event_turn: 3, event: 3, event_done: 1},
  {stock_id: 13, eventname: "TCS faces lawsuit for illegal patent frauds", event_type: 0, event_turn: 3, event: 1, event_done: 1},
  {stock_id: 14, eventname: "MorganStanley releases new products for holiday season", event_type: 1, event_turn: 3, event: 2, event_done: 1},
  {stock_id: 15, eventname: "Sony set to invest on the latest tech", event_type: 1, event_turn: 3, event: 2, event_done: 1},
  {stock_id: 1, eventname: "Intel reports quaterly loss in revenue", event_type: 0, event_turn: 1, event: 1, event_done: 0},
  {stock_id: 4, eventname: "LG acquires Apple", event_type: 0, event_turn: 1, event: 3, event_done: 0},
  {stock_id: 12, eventname: "Apple acquired by LG", event_type: 1, event_turn: 1, event: 3, event_done: 0},
  {stock_id: 5, eventname: "HDFC reports quaterly loss in revenue", event_type: 0, event_turn: 1, event: 1, event_done: 0},
  {stock_id: 6, eventname: "Delta plans to split stocks", event_type: 1, event_turn: 1, event: 3, event_done: 0},
  {stock_id: 7, eventname: "Ranbaxy set to expand globally", event_type: 1, event_turn: 1, event: 1, event_done: 0},
  {stock_id: 8, eventname: "Pragyan plans to split stocks", event_type: 1, event_turn: 1, event: 3, event_done: 0},
  {stock_id: 9, eventname: "CEO of Github sacked", event_type: 0, event_turn: 1, event: 2, event_done: 0},
  {stock_id: 10, eventname: "ESAT releases new products for holiday season", event_type: 1, event_turn: 1, event: 2, event_done: 0},
  {stock_id: 11, eventname: "CEO of HP sacked", event_type: 0, event_turn: 1, event: 2, event_done: 0},
  {stock_id: 12, eventname: "Apple faces lawsuit for illegal patent frauds", event_type: 0, event_turn: 1, event: 1, event_done: 0},
  {stock_id: 13, eventname: "CEO of TCS sacked", event_type: 0, event_turn: 1, event: 2, event_done: 0},
  {stock_id: 14, eventname: "MorganStanley set to invest on the latest tech", event_type: 1, event_turn: 1, event: 2, event_done: 0},
  {stock_id: 1, eventname: "Intel releases new products for holiday season", event_type: 1, event_turn: 3, event: 2, event_done: 1},
  {stock_id: 2, eventname: "Infy releases new products for holiday season", event_type: 1, event_turn: 3, event: 2, event_done: 1},
  {stock_id: 3, eventname: "CEO of Dell sacked", event_type: 0, event_turn: 3, event: 2, event_done: 1},
  {stock_id: 4, eventname: "LG set to expand globally", event_type: 1, event_turn: 3, event: 1, event_done: 1},
  {stock_id: 10, eventname: "ESAT acquires Delta", event_type: 0, event_turn: 3, event: 3, event_done: 1},
  {stock_id: 6, eventname: "Delta acquired by ESAT", event_type: 1, event_turn: 3, event: 3, event_done: 1},
  {stock_id: 12, eventname: "Apple plans to split stocks", event_type: 1, event_turn: 3, event: 3, event_done: 1},
  {stock_id: 13, eventname: "TCS faces lawsuit for illegal patent frauds", event_type: 0, event_turn: 3, event: 1, event_done: 1},
  {stock_id: 14, eventname: "MorganStanley releases new products for holiday season", event_type: 1, event_turn: 3, event: 2, event_done: 1},
  {stock_id: 15, eventname: "Sony set to invest on the latest tech", event_type: 1, event_turn: 3, event: 2, event_done: 1},
  {stock_id: 1, eventname: "Intel reports quaterly loss in revenue", event_type: 0, event_turn: 1, event: 1, event_done: 0},
  {stock_id: 4, eventname: "LG acquires Apple", event_type: 0, event_turn: 1, event: 3, event_done: 0},
  {stock_id: 12, eventname: "Apple acquired by LG", event_type: 1, event_turn: 1, event: 3, event_done: 0},
  {stock_id: 5, eventname: "HDFC reports quaterly loss in revenue", event_type: 0, event_turn: 1, event: 1, event_done: 0},
  {stock_id: 6, eventname: "Delta plans to split stocks", event_type: 1, event_turn: 1, event: 3, event_done: 0},
  {stock_id: 7, eventname: "Ranbaxy set to expand globally", event_type: 1, event_turn: 1, event: 1, event_done: 0},
  {stock_id: 8, eventname: "Pragyan plans to split stocks", event_type: 1, event_turn: 1, event: 3, event_done: 0},
  {stock_id: 9, eventname: "CEO of Github sacked", event_type: 0, event_turn: 1, event: 2, event_done: 0},
  {stock_id: 10, eventname: "ESAT releases new products for holiday season", event_type: 1, event_turn: 1, event: 2, event_done: 0},
  {stock_id: 11, eventname: "CEO of HP sacked", event_type: 0, event_turn: 1, event: 2, event_done: 0},
  {stock_id: 12, eventname: "Apple faces lawsuit for illegal patent frauds", event_type: 0, event_turn: 1, event: 1, event_done: 0},
  {stock_id: 13, eventname: "CEO of TCS sacked", event_type: 0, event_turn: 1, event: 2, event_done: 0},
  {stock_id: 14, eventname: "MorganStanley set to invest on the latest tech", event_type: 1, event_turn: 1, event: 2, event_done: 0}
])
Message.create!([
  {message: "Welcome To Dalal Street"},
  {message: "Welcome To Dalal"}
])
Notification.create!([
  {user_id: 2, notification: "1.0 stocks of Intel traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of Infy traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of LG traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "1.0 stocks of LG traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "1.0 stocks of Dell traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "1.0 stocks of Intel traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "1.0 stocks of Infy traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "1.0 stocks of LG traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "2.0 stocks of LG traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of Infy traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of LG traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of Dell traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of LG traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of LG traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of Sony traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of Apple traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of Sony traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of TCS traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of LG traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of LG traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of Apple traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of ESAT traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of HDFC traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of HDFC traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of Intel traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of TCS traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "1.0 stocks of Intel traded successfully", seen: 1, notice_type: 1},
  {user_id: 2, notification: "Did not recieve request.Please try again.", seen: 1, notice_type: 3},
  {user_id: 1, notification: "1.0 stocks of Delta traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Invalid trade parameters.Please check and try again.", seen: 1, notice_type: 3},
  {user_id: 1, notification: "1.0 stocks of Intel traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "1.0 stocks of Ranbaxy traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "1.0 stocks of Intel traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "1.0 stocks of Dell traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Successful Bid.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Sell request made.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Sell request made.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Successful Bid.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Successful Bid.", seen: 1, notice_type: 1},
  {user_id: 2, notification: "You cannot bid for more than 10% of the current price the max buy price for Dell is 37.77.", seen: 1, notice_type: 2},
  {user_id: 2, notification: "Successful Bid.", seen: 1, notice_type: 1},
  {user_id: 2, notification: "You cannot bid for more than 10% of the current price the max buy price for Intel is 65.43.", seen: 1, notice_type: 2},
  {user_id: 1, notification: "You cannot bid for less than 10% of the current price the minimum buy price for Ranbaxy is 69.79.", seen: 1, notice_type: 2},
  {user_id: 1, notification: "Successful Bid.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "You cannot bid for less than 10% of the current price the minimum buy price for Github is 32.27.", seen: 1, notice_type: 2},
  {user_id: 1, notification: "You cannot bid for less than 10% of the current price the minimum buy price for Github is 32.27.", seen: 1, notice_type: 2},
  {user_id: 1, notification: "You cannot bid for less than 10% of the current price the minimum buy price for Github is 32.27.", seen: 1, notice_type: 2},
  {user_id: 1, notification: "Successful Bid.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Sell request made.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "You cannot bid for less than 10% of the current price the minimum buy price for Intel is 53.53.", seen: 1, notice_type: 2},
  {user_id: 1, notification: "Successful Bid.", seen: 1, notice_type: 1},
  {user_id: 2, notification: "Successful Bid.", seen: 1, notice_type: 1},
  {user_id: 2, notification: "Successful Bid.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Sell request failed.You only have 1 stocks of Infy.", seen: 1, notice_type: 2},
  {user_id: 1, notification: "Sell request made.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "You cannot trade more than 10 stocks at a time.Trade failed.", seen: 1, notice_type: 3},
  {user_id: 1, notification: "10.0 stocks of Infy traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "1.0 stocks of Intel traded successfully", seen: 1, notice_type: 1},
  {user_id: 1, notification: "You cannot trade more than 10 stocks at a time.Trade failed.", seen: 1, notice_type: 3},
  {user_id: 1, notification: "Sell request made.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Sell request made.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Sell request made.", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Sell request made.", seen: 1, notice_type: 1},
  {user_id: 2, notification: "You bought 2 stocks of Infy at the rate of $30.0 per share", seen: 1, notice_type: 1},
  {user_id: 1, notification: "You sold 2 stocks of Infy at the rate of $22.0 per share", seen: 1, notice_type: 1},
  {user_id: 1, notification: "Invalid parameters.Please try again.", seen: 1, notice_type: 3}
])
Sell.create!([
  {user_id: 1, stock_id: 1, priceexpected: "34.0", numofstock: 3},
  {user_id: 1, stock_id: 1, priceexpected: "34.0", numofstock: 1},
  {user_id: 1, stock_id: 1, priceexpected: "32.0", numofstock: 2},
  {user_id: 1, stock_id: 2, priceexpected: "23.0", numofstock: 1},
  {user_id: 1, stock_id: 2, priceexpected: "34.0", numofstock: 2},
  {user_id: 1, stock_id: 2, priceexpected: "23.0", numofstock: 3},
  {user_id: 1, stock_id: 2, priceexpected: "32.0", numofstock: 2}
])
Stock.create!([
  {stockname: "Intel", currentprice: "59.47", dayhigh: "71.00", daylow: "22.01", alltimehigh: "45.7", alltimelow: "22.09", stocksinexchange: 26, stocksinmarket: 24, updown: 0},
  {stockname: "Infy", currentprice: "23.33", dayhigh: "40.30", daylow: "18.96", alltimehigh: "40.30", alltimelow: "18.96", stocksinexchange: 40, stocksinmarket: 22, updown: 1},
  {stockname: "Dell", currentprice: "34.34", dayhigh: "36.57", daylow: "24.40", alltimehigh: "23.65", alltimelow: "32.84", stocksinexchange: 29, stocksinmarket: 11, updown: 0},
  {stockname: "LG", currentprice: "82.38", dayhigh: "83.46", daylow: "32.22", alltimehigh: "44.42", alltimelow: "45.49", stocksinexchange: 170, stocksinmarket: 50, updown: 0},
  {stockname: "HDFC", currentprice: "128.81", dayhigh: "136.71", daylow: "33.53", alltimehigh: "66.26", alltimelow: "11.81", stocksinexchange: 34, stocksinmarket: 18, updown: 0},
  {stockname: "Delta", currentprice: "4.48", dayhigh: "6.79", daylow: "2.82", alltimehigh: "3.43", alltimelow: "3.91", stocksinexchange: 36, stocksinmarket: 7, updown: 1},
  {stockname: "Ranbaxy", currentprice: "77.54", dayhigh: "83.14", daylow: "35.33", alltimehigh: "77.34", alltimelow: "78.3", stocksinexchange: 35, stocksinmarket: 2, updown: 1},
  {stockname: "Pragyan", currentprice: "47.19", dayhigh: "50.37", daylow: "18.50", alltimehigh: "45.77", alltimelow: "3.41", stocksinexchange: 54, stocksinmarket: 3, updown: 1},
  {stockname: "Github", currentprice: "35.85", dayhigh: "44.02", daylow: "22.72", alltimehigh: "34.3", alltimelow: "32.44", stocksinexchange: 27, stocksinmarket: 6, updown: 0},
  {stockname: "ESAT", currentprice: "3.00", dayhigh: "43.2", daylow: "2.18", alltimehigh: "55.1", alltimelow: "13.0", stocksinexchange: 18, stocksinmarket: 5, updown: 1},
  {stockname: "HP", currentprice: "98.19", dayhigh: "126.09", daylow: "8.0", alltimehigh: "64.3", alltimelow: "6.2", stocksinexchange: 29, stocksinmarket: 11, updown: 0},
  {stockname: "Apple", currentprice: "114.11", dayhigh: "137.3", daylow: "32.0", alltimehigh: "45.0", alltimelow: "4.0", stocksinexchange: 27, stocksinmarket: 6, updown: 0},
  {stockname: "TCS", currentprice: "54.45", dayhigh: "91.46", daylow: "24.05", alltimehigh: "77.48", alltimelow: "11.42", stocksinexchange: 66, stocksinmarket: 9, updown: 0},
  {stockname: "MorganStanley", currentprice: "78.27", dayhigh: "89.7", daylow: "38.45", alltimehigh: "50.82", alltimelow: "45.41", stocksinexchange: 53, stocksinmarket: 7, updown: 1},
  {stockname: "Sony", currentprice: "21.32", dayhigh: "32.24", daylow: "17.95", alltimehigh: "43.39", alltimelow: "32.02", stocksinexchange: 75, stocksinmarket: 22, updown: 0},
  {stockname: "Intel", currentprice: "59.47", dayhigh: "71.00", daylow: "22.01", alltimehigh: "45.7", alltimelow: "22.09", stocksinexchange: 31, stocksinmarket: 19, updown: 0},
  {stockname: "Infy", currentprice: "22.15", dayhigh: "40.30", daylow: "18.96", alltimehigh: "34.04", alltimelow: "22.03", stocksinexchange: 53, stocksinmarket: 9, updown: 0},
  {stockname: "Dell", currentprice: "34.34", dayhigh: "36.57", daylow: "24.40", alltimehigh: "23.65", alltimelow: "32.84", stocksinexchange: 32, stocksinmarket: 8, updown: 0},
  {stockname: "LG", currentprice: "82.38", dayhigh: "83.46", daylow: "32.22", alltimehigh: "44.42", alltimelow: "45.49", stocksinexchange: 180, stocksinmarket: 40, updown: 0},
  {stockname: "HDFC", currentprice: "128.81", dayhigh: "136.71", daylow: "33.53", alltimehigh: "66.26", alltimelow: "11.81", stocksinexchange: 36, stocksinmarket: 16, updown: 0},
  {stockname: "Delta", currentprice: "4.48", dayhigh: "6.79", daylow: "2.82", alltimehigh: "3.43", alltimelow: "3.91", stocksinexchange: 37, stocksinmarket: 6, updown: 1},
  {stockname: "Ranbaxy", currentprice: "77.54", dayhigh: "83.14", daylow: "35.33", alltimehigh: "77.34", alltimelow: "78.3", stocksinexchange: 36, stocksinmarket: 1, updown: 1},
  {stockname: "Pragyan", currentprice: "47.19", dayhigh: "50.37", daylow: "18.5", alltimehigh: "45.77", alltimelow: "3.41", stocksinexchange: 54, stocksinmarket: 3, updown: 1},
  {stockname: "Github", currentprice: "35.85", dayhigh: "44.02", daylow: "22.72", alltimehigh: "34.3", alltimelow: "32.44", stocksinexchange: 27, stocksinmarket: 6, updown: 0},
  {stockname: "ESAT", currentprice: "3.00", dayhigh: "43.2", daylow: "2.18", alltimehigh: "55.1", alltimelow: "13.0", stocksinexchange: 19, stocksinmarket: 4, updown: 1},
  {stockname: "HP", currentprice: "98.19", dayhigh: "126.094", daylow: "8.0", alltimehigh: "64.3", alltimelow: "6.2", stocksinexchange: 29, stocksinmarket: 11, updown: 0},
  {stockname: "Apple", currentprice: "114.11", dayhigh: "137.35", daylow: "32.0", alltimehigh: "45.0", alltimelow: "4.0", stocksinexchange: 29, stocksinmarket: 4, updown: 0},
  {stockname: "TCS", currentprice: "54.45", dayhigh: "91.46", daylow: "24.05", alltimehigh: "77.48", alltimelow: "11.42", stocksinexchange: 68, stocksinmarket: 7, updown: 0},
  {stockname: "MorganStanley", currentprice: "78.27", dayhigh: "89.70", daylow: "38.45", alltimehigh: "50.82", alltimelow: "45.41", stocksinexchange: 53, stocksinmarket: 7, updown: 1},
  {stockname: "Sony", currentprice: "21.32", dayhigh: "32.24", daylow: "17.95", alltimehigh: "43.39", alltimelow: "32.02", stocksinexchange: 77, stocksinmarket: 20, updown: 0}
])
StockUsed.create!([
  {user_id: 2, stock_id: 1, numofstock: 1},
  {user_id: 2, stock_id: 2, numofstock: 1},
  {user_id: 2, stock_id: 4, numofstock: 1},
  {user_id: 1, stock_id: 4, numofstock: 1},
  {user_id: 1, stock_id: 3, numofstock: 1},
  {user_id: 1, stock_id: 1, numofstock: 1},
  {user_id: 1, stock_id: 2, numofstock: 1},
  {user_id: 1, stock_id: 4, numofstock: 1},
  {user_id: 2, stock_id: 4, numofstock: 2},
  {user_id: 2, stock_id: 2, numofstock: 1},
  {user_id: 2, stock_id: 4, numofstock: 1},
  {user_id: 2, stock_id: 3, numofstock: 1},
  {user_id: 2, stock_id: 4, numofstock: 1},
  {user_id: 2, stock_id: 4, numofstock: 1},
  {user_id: 2, stock_id: 15, numofstock: 1},
  {user_id: 2, stock_id: 12, numofstock: 1},
  {user_id: 2, stock_id: 15, numofstock: 1},
  {user_id: 2, stock_id: 13, numofstock: 1},
  {user_id: 2, stock_id: 4, numofstock: 1},
  {user_id: 2, stock_id: 4, numofstock: 1},
  {user_id: 2, stock_id: 12, numofstock: 1},
  {user_id: 2, stock_id: 10, numofstock: 1},
  {user_id: 2, stock_id: 5, numofstock: 1},
  {user_id: 2, stock_id: 5, numofstock: 1},
  {user_id: 2, stock_id: 16, numofstock: 1},
  {user_id: 2, stock_id: 13, numofstock: 1},
  {user_id: 2, stock_id: 1, numofstock: 1},
  {user_id: 1, stock_id: 6, numofstock: 1},
  {user_id: 1, stock_id: 1, numofstock: 1},
  {user_id: 1, stock_id: 7, numofstock: 1},
  {user_id: 1, stock_id: 1, numofstock: 1},
  {user_id: 1, stock_id: 3, numofstock: 1},
  {user_id: 2, stock_id: 2, numofstock: 1},
  {user_id: 1, stock_id: 2, numofstock: -1},
  {user_id: 1, stock_id: 2, numofstock: 10},
  {user_id: 1, stock_id: 1, numofstock: 1},
  {user_id: 2, stock_id: 2, numofstock: 1},
  {user_id: 1, stock_id: 2, numofstock: -1},
  {user_id: 2, stock_id: 2, numofstock: 2},
  {user_id: 1, stock_id: 2, numofstock: -2},
  {user_id: 2, stock_id: 2, numofstock: 2},
  {user_id: 1, stock_id: 2, numofstock: -2},
  {user_id: 2, stock_id: 2, numofstock: 2},
  {user_id: 1, stock_id: 2, numofstock: -2}
])
