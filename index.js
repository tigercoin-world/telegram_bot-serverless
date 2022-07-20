require("dotenv").config();
const axios = require("axios").default;

const TelegramBot = require("node-telegram-bot-api");
const token = process.env.TOKEN;

// Create a bot that uses 'polling' to fetch new updates
const bot = new TelegramBot(token, { polling: true });

// Matches "/echo [whatever]"
bot.onText(/\/echo (.+)/, (msg, match) => {
  const chatId = msg.chat.id;
  const resp = match[1]; // the captured "whatever"
  bot.sendMessage(chatId, response);
});

bot.on("message", (msg) => {
  var btc = "btc";
  if (msg.text.toString().toLowerCase().indexOf(btc) === 0) {
    axios
      .get("https://api.upbit.com/v1/ticker?markets=KRW-BTC")
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

  var bye = "eth";
  if (msg.text.toString().toLowerCase().includes(eth)) {
    axios
      .get("https://api.upbit.com/v1/ticker?markets=KRW-ETH")
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
