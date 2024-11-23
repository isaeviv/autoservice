// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "popper"
import "bootstrap"
import LocalTime from "local-time"
import "trix"
import "@rails/actiontext"

(function() {
  var locale, queryString, urlParams;

  LocalTime.config.i18n["ru"] = {
    date: {
      dayNames: ['Воскресенье', 'Понедельник', 'Вторник', 'Среда', 'Четверг', 'Пятница', 'Суббота'],
      abbrDayNames: ['Вос', 'Пон', 'Вто', 'Сре', 'Чет', 'Пят', 'Суб'],
      monthNames: ['Января', 'Февраля', 'Марта', 'Апреля', 'Мая', 'Июня', 'Июля', 'Августа', 'Сентября', 'Октября', 'Ноября', 'Декабря'],
      abbrMonthNames: ['Янв', 'Фев', 'Мар', 'Апр', 'Май', 'Июн', 'Июл', 'Авг', 'Сен', 'Окт', 'Ноя', 'Дек'],
      yesterday: 'вчера',
      today: 'сегодня',
      tomorrow: 'завтра',
      on: '{date}',
      formats: {
        'default': '%b %e, %Y',
        thisYear: '%b %e'
      }
    },
    time: {
      am: 'am',
      pm: 'pm',
      singular: '{time}',
      singularAn: '{time}',
      elapsed: '{time} назад',
      second: 'секунда',
      seconds: 'секунд',
      minute: 'минута',
      minutes: 'минут',
      hour: 'час',
      hours: 'часов',
      formats: {
        'default': '%l:%M%P'
      }
    },
    datetime: {
      at: '{date} в {time}',
      formats: {
        'default': '%B %e, %Y в %l:%M%P %Z'
      }
    }
  };

  queryString = window.location.search;

  urlParams = new URLSearchParams(queryString);

  locale = urlParams.get('locale') || "ru";

  LocalTime.config.locale = locale;

  LocalTime.start();

}).call(this);