require("dotenv").config();
const axios = require("axios").default;

const TelegramBot = require("node-telegram-bot-api");
const token = process.env.TOKEN;

// Create a bot that uses 'polling' to fetch new updates
const bot = new TelegramBot(token, { polling: true });

// Matches "/echo [whatever]"
bot.onText(/\/help (.+)/, (msg, match) => {
  const chatId = msg.chat.id;
  const resp = match[1]; // the captured "whatever"
  bot.sendMessage(chatId, resp);
});

bot.on("message", (msg) => {
  var ticker_l = msg.text.toString().toLowerCase();
  var ticker_h = ticker_l.toUpperCase();
  {
    axios
      .get("https://api.upbit.com/v1/ticker?markets=KRW-" + ticker_h)
      .then(function (response) {
        const resp = response.data[0].trade_price;
        const price = resp.toLocaleString() + "원";

        bot.sendMessage(msg.chat.id, price); //bot에 보내기
        console.log(price);
      })
      .catch(function (error) {
        console.log(error);
      })
      .then(function () {});
  }
});
